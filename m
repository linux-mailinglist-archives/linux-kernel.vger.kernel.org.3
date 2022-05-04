Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3C519395
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiEDBs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiEDBsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:48:25 -0400
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 18:44:51 PDT
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19441AF22;
        Tue,  3 May 2022 18:44:50 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 0E5CB7FC20;
        Wed,  4 May 2022 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1651628148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8i5okGkEbwGEAVhwahD/P5DzkyrCRNwKvZVtcLyVENY=;
        b=o1s59jr7ki2Zcrx9IZLlhAd6BxaSM68EQhXtCoWuRQDU3bCYLZmzB00KSL2LpXXBHTqVDM
        D5sr3DUejfUdckgKqQIIMQWeNO/CaApEimZXAx1vNPp92+59ZxgbTyCoqt+7CW0TqClLvB
        W+NRNrn6DzB9Oo74irtd32gRYBCbv0U2kmYwBdyhdywSDfiie1ukOi9m+pBYu/vo6qL2Qn
        U9ck6oUOtnaZfkpeOr8/hBIudK6SBmLgje08/TNUP0WKyZYeW5amsW++HV2L0JBzTE7cf/
        VhaY4OK5qorJnCNmlVTtskjN0YfBjLfJN8Hr0xmTTmU6I12352hAbhZL21FckQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Byron Stanoszek <gandalf@winds.org>,
        Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too
 long
In-Reply-To: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
Date:   Tue, 03 May 2022 22:35:43 -0300
Message-ID: <878rri2i6o.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek <gandalf@winds.org> writes:

> I would like to report a regression in the CIFS fs. Sometime between Linux 4.14
> and 5.16, mounting CIFS with option vers=1.0 (and
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y set appropriately) with security type
> NTLMSSP stopped working for me. The server side is a Windows 2003 Server.
>
> I found that this behavior depends on the length of the Linux client's
> host+domain name (e.g. utsname()->nodename), where the mount works as long as
> the name is 16 characters or less. Anything 17 or above returns -EIO, per the
> following example:

Looks like your server is expecting the WorkstationName field in
AUTHENTICATE_MESSAGE payload to be 16 bytes long.  That is, NetBIOS name
length as per rfc1001.

> I implemented a workaround using the following patch:
>
> Signed-off-by: Byron Stanoszek <gandalf@winds.org>
> ---
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -101,7 +101,7 @@
>   #define XATTR_DOS_ATTRIB "user.DOSATTRIB"
>   #endif
>
> -#define CIFS_MAX_WORKSTATION_LEN  (__NEW_UTS_LEN + 1)  /* reasonable max for client */
> +#define CIFS_MAX_WORKSTATION_LEN 16
>
>   /*
>    * CIFS vfs client Status information (based on what we know.)
>
> I don't know if this patch is correct or will have any real effect outside of
> the NTLMSSP session connect sequence, but it worked in my case.

Perhaps we should be use TCP_Server_Info::workstation_RFC1001_name in
fs/cifs/sess.c:build_ntlmssp_auth_blob() instead only when connecting to
old servers by using insecure dialects -- like SMB1, in your case.
