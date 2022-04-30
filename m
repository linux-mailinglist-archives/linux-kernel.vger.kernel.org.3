Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355C45160C4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbiD3Whd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3Wha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:37:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253566C92;
        Sat, 30 Apr 2022 15:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4406561115;
        Sat, 30 Apr 2022 22:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF34C385A7;
        Sat, 30 Apr 2022 22:34:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZXTPIYgz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651358044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7X4EiV6ztlb5Dy3IFR/LWL7UyiLURjSoMIEXEAyUg7U=;
        b=ZXTPIYgzj+mW681eGPeF+jG/CS+hzR8NGuDayaOYvpcfU6B7dtdhZ4IFLhHXwmsWDbLrBr
        WFfO4SLZOIAQQUvaW8IKEf82HEo1U8DTc9mob+naWd51hL3CApHTlp8AYx2Vv5RAnpVFeo
        pYhHOvxjQ7/NrSl1c+qK87OI7Dzvjw0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74d45aba (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 30 Apr 2022 22:34:04 +0000 (UTC)
Date:   Sun, 1 May 2022 00:34:02 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 11/17] openrisc: account for 0 starting value in
 random_get_entropy()
Message-ID: <Ym25Wn1PtpNgkKyR@zx2c4.com>
References: <20220423212623.1957011-12-Jason@zx2c4.com>
 <20220429001648.1671472-1-Jason@zx2c4.com>
 <YmyOh/YbgGJ3DK79@antec>
 <YmyRATzJBQX+wnIP@zx2c4.com>
 <Ym20Ga3VsJRzXppd@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym20Ga3VsJRzXppd@antec>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Sun, May 01, 2022 at 07:11:37AM +0900, Stafford Horne wrote:
 
> I was thinking about this, the reason the tick timer is returing 0 is because
> the timer is not started.  It's getting initialized right after the random
> number generator.
> 
> A patch like this helps to startup the timer during intial startup, but I am not
> sure its the best thing:
> 
> diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
> index 15f1b38dfe03..a9b3b5614e13 100644
> --- a/arch/openrisc/kernel/head.S
> +++ b/arch/openrisc/kernel/head.S
> @@ -521,6 +521,9 @@ _start:
>         l.ori   r3,r0,0x1
>         l.mtspr r0,r3,SPR_SR
>  
> +       l.movhi r3,hi(SPR_TTMR_CR)
> +       l.mtspr r0,r3,SPR_TTMR
> +
>         CLEAR_GPR(r1)
>         CLEAR_GPR(r2)
>         CLEAR_GPR(r3)

Yea, great, I was thinking about doing it in assembly earlier in boot
too, but didn't know how you'd feel about that. I like this better.

The reason I think this is a good approach is that it means the cycle
counter includes some information about how long startup takes from the
earliest stages -- which could involve probing various devices or
strange things. So enabling the timer in head.S seems good to me.

> But I wonder:
>  - Why don't any other architectures have similar issues.
>  - Is there any more correct place to do an early timer kick off.

I think most other archs (like, say, x86) have their cycle counter
enabled by default at boot time. I was surprised to see that the or1k
risc cycle counter comes disabled by default actually.

I'll send a v9 incorporating your suggested assembly change.

Jason
