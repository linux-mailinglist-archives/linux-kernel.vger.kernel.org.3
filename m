Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238FD51CEF5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388312AbiEFCXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiEFCXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:23:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC4633A1;
        Thu,  5 May 2022 19:19:59 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id h10so10665476ybc.4;
        Thu, 05 May 2022 19:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqeaKt4VHSC0M6Q7xTIrEAfecmkELADSzjUpCKB9s4E=;
        b=hxftpkK7H1BhuEkJMKp3T5iT7qVqTe6yWfanW9MMHeAY5I8Q3HqYuAManaLZW2aOtk
         mZz4Ua8yc2IWXS1jn1cGawbcUvEng4uYgQXBKwWwPKDsvjcRTEFnTTcYV4r+ucj2Ev61
         E7ZQEk1Ef4dGjyJOR4jn3QWtuYFbZef6u95i+9V4+chneKgtGB9HxpBbtGavLVBPVevh
         3yq75CLogf7jiEibqcReZq2SC8Ydx9ndCSMhE2iw+w5zfHjkMSTEp/3sB2R6xks2RzGf
         dNV30IwxoKzCuxR6e3LvYEimqurvOHlsFFr4sZNl/TY37UeiubrxjQ72rdXBfpxswvyf
         E5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqeaKt4VHSC0M6Q7xTIrEAfecmkELADSzjUpCKB9s4E=;
        b=cIdz2usn9e7eLATRCFlhJ1YtMrwN/4PklZy6dOmXH2Et2ooHDxOxLsLre6RNoTSN5s
         nNtd0whFr1ABIvn5XdWU6K7NBQdZA9RM5/IJ65oGgV96AYdQF6ow/+7OCL5QNiEHhNe+
         dYaQkw8bEH9scgIsvGlHSEH4F2v6t10v9tKWjYllP/7wfEZWbmk6Qir00SCdsEeQSqml
         mTZpiqNEzAoN+C1BAjwIym5ur9j+E77QEB0dcCOx5bf95DHW2RkBm1JGWTWoVfXGNYOV
         2a+iJKtZ0fvuYbCusc/YxMAyX3oQZBD/6wmLSXFs4pj07kOxORZ+NciJ602QKmaxUUON
         3DaA==
X-Gm-Message-State: AOAM532DDhBibjrogNPAnnW7vvo7mAY+mhia2a4w3H9kEpt25TSiDcHe
        LJztUioZhaxJThcaHN93Z0Q/A7h7Mav54URZfAk=
X-Google-Smtp-Source: ABdhPJxWMxRqJMwszC6ij/Lonrz/SOBQuzMp415ZfJ7BImUVq9Nl4xXNeCwom+1baZVS9TAARDAtSK19VpeVqy93vqc=
X-Received: by 2002:a05:6902:709:b0:64a:99b:3594 with SMTP id
 k9-20020a056902070900b0064a099b3594mr837242ybt.493.1651803599053; Thu, 05 May
 2022 19:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
 <878rri2i6o.fsf@cjr.nz> <7dc6c729-73cd-74be-eec7-ac4a0013f60f@samba.org>
 <87tua51550.fsf@cjr.nz> <df763cb0-83f2-35a5-a381-57cfd040becf@talpey.com> <87r15910c1.fsf@cjr.nz>
In-Reply-To: <87r15910c1.fsf@cjr.nz>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Fri, 6 May 2022 12:19:48 +1000
Message-ID: <CAN05THQYKRChdR_4T86dGtCO=xY+cWpfa6_fOVNh9WSB=RNE-A@mail.gmail.com>
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too long
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     Tom Talpey <tom@talpey.com>, Steven French <sfrench@samba.org>,
        Byron Stanoszek <gandalf@winds.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 at 11:59, Paulo Alcantara <pc@cjr.nz> wrote:
>
> Tom Talpey <tom@talpey.com> writes:
>
> > I think the most conservative and spec-compliant choice should be made.
> > SMB1 should not be pushing the envelope of interoperability, in this day
> > and age.
>
> OK.
>
> > I believe the NetBIOS name is a fixed array of 16 octets, right? So, if
> > the nodename is shorter, it needs to be padded with 0's.
>
> Right.
>
> > Did this code change recently? Why???
>
> We used to not send the WorkstationName during NTLMSSP until recent
> patch from Shyam:
>
>         commit 49bd49f983b5026e4557d31c5d737d9657c4113e
>         Author: Shyam Prasad N <sprasad@microsoft.com>
>         Date:   Fri Nov 5 19:03:57 2021 +0000
>
>             cifs: send workstation name during ntlmssp session setup
>
>             During the ntlmssp session setup (authenticate phases)
>             send the client workstation info. This can make debugging easier on
>             servers.
>
>             Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
>             Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
>             Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
>             Signed-off-by: Steve French <stfrench@microsoft.com>
>
> Unfortunately some servers did not seem to enforce it to be 16 bytes
> long, so the reason why we didn't catch it earlier.
>
> Steve, Shyam, let me know if it does make sense to you and then I can
> work on a patch to fix it properly.

This regression should be easy to fix, but maybe we should not have
done the initial change in the first place.
If things is broken and do not work under SMB1, that is a good thing.
Instead of adding features or fixing
missing parts to SMB1 we should just tell people to switch to SMB2 instead.

I think if things do not work correctly or things are missing in smb1,
that is a GOOD THING.
:-)
