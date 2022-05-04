Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3251AFF1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378425AbiEDVCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiEDVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:02:38 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE940E40;
        Wed,  4 May 2022 13:59:01 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 075787FC20;
        Wed,  4 May 2022 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1651697939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lQYNSaWHnrcI5QezQhu4C6Dn82MFLjowgcSE9eLDMWM=;
        b=W/h4q1VZLVeeo+4ZiqMAKqvIOyV73ZC0GYROIcYjy6YKERMEYeZVlUVz3sLFBLm65FCawg
        G+DYZhO0Pv8qwoXzKqeVRQTbSDYD94NwjW9VxX62WOqzJpQpXhNC2c/nNojCM8mKcrnEds
        SwazqYTDS3ky50bo9eCGjBOoa3SOOABt8UO0Ps0kx4nHz6fpe39+Rf6eS0Ypipr8qaPzA0
        ul2AICRDyknE3Y/MDLNIGVQ+qSpa3SOOahI0Cvs3s0eb5JspGRMJVwbE5L+CAZ2i46pG2D
        Zv4l0xGYyrDveTAKQmZyYSNBoWowedWxz7pZGXPM7nnvVi6I/BswR2Fw3suU1Q==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Tom Talpey <tom@talpey.com>, Steven French <sfrench@samba.org>,
        Byron Stanoszek <gandalf@winds.org>,
        Shyam Prasad N <nspmangalore@gmail.com>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too
 long
In-Reply-To: <df763cb0-83f2-35a5-a381-57cfd040becf@talpey.com>
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
 <878rri2i6o.fsf@cjr.nz> <7dc6c729-73cd-74be-eec7-ac4a0013f60f@samba.org>
 <87tua51550.fsf@cjr.nz> <df763cb0-83f2-35a5-a381-57cfd040becf@talpey.com>
Date:   Wed, 04 May 2022 17:58:54 -0300
Message-ID: <87r15910c1.fsf@cjr.nz>
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

Tom Talpey <tom@talpey.com> writes:

> I think the most conservative and spec-compliant choice should be made.
> SMB1 should not be pushing the envelope of interoperability, in this day
> and age.

OK.

> I believe the NetBIOS name is a fixed array of 16 octets, right? So, if
> the nodename is shorter, it needs to be padded with 0's.

Right.

> Did this code change recently? Why???

We used to not send the WorkstationName during NTLMSSP until recent
patch from Shyam:

	commit 49bd49f983b5026e4557d31c5d737d9657c4113e
	Author: Shyam Prasad N <sprasad@microsoft.com>
	Date:   Fri Nov 5 19:03:57 2021 +0000
	
	    cifs: send workstation name during ntlmssp session setup
	
	    During the ntlmssp session setup (authenticate phases)
	    send the client workstation info. This can make debugging easier on
	    servers.
	
	    Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
	    Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
	    Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
	    Signed-off-by: Steve French <stfrench@microsoft.com>

Unfortunately some servers did not seem to enforce it to be 16 bytes
long, so the reason why we didn't catch it earlier.

Steve, Shyam, let me know if it does make sense to you and then I can
work on a patch to fix it properly.
