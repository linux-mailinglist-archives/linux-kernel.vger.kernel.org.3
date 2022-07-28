Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0B45845FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiG1S2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiG1S2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:28:35 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8E6D564
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8en1dUZtVi+OtbnjpKM2o5kUvsguWNwrKsWi5O1zrkw=; b=NPJvcL7rNtP72r0d+7Suy59IFh
        wFMuQ3nRTSwELo770zYkYZ3iuLEHBoY92nhKztK74cOEWft3CYq+38Knw9tBlPvm+uznS0hLrirIR
        uER8T0NWTPNQk4gXA3L6Umk6dXGcl66RLlvPOJluXVLe+WDur3ITCOzIJEm6YpMDfhyKReRB8S6I5
        J3sS5m52wPpJS8kfDNuIRy8zFF1Kl/S3c03+X1/ygZliuTABJH5MoTvpGtlWQborrQr6rb6igHTz7
        ribOKa9Saq408azt5yQUC7Pb9183n+XHrCtivbr458Fw0j7ZGKsGl8eyprlZCOCVwdKLkCIM1FuM1
        5mvfSrfg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33614)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oH8FF-0006dn-45; Thu, 28 Jul 2022 19:28:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oH8FC-0003Q4-A6; Thu, 28 Jul 2022 19:28:22 +0100
Date:   Thu, 28 Jul 2022 19:28:22 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <YuLVRiblUzo18gST@shell.armlinux.org.uk>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <Yt+v9brPqxun0nhA@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt+v9brPqxun0nhA@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:12:21AM +0100, Russell King (Oracle) wrote:
> First I'm aware of it. Was it reported to linux-arm-kernel? I'm guessing
> the report wasn't Cc'd to me - I can't find anything in my mailbox about
> it.
> 
> > I think the fix might be something like this:
> > 
> >   diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
> >   index b5e8b9ae4c7d..b36ca301892e 100644
> >   --- a/arch/arm/lib/findbit.S
> >   +++ b/arch/arm/lib/findbit.S
> >   @@ -83,6 +83,8 @@ ENDPROC(_find_first_bit_le)
> >    ENTRY(_find_next_bit_le)
> >                 teq     r1, #0
> >                 beq     3b
> >   +             cmp     r2, r1
> >   +             bhs     3b
> >                 ands    ip, r2, #7
> >                 beq     1b                      @ If new byte, goto old routine
> >     ARM(                ldrb    r3, [r0, r2, lsr #3]    )
> > 
> > but my ARM asm is so broken that the above is just really random noise
> > that may or may not build - much less work.
> > 
> > I'll leave it to Russell &co to have a tested and working patch.
> 
> I think it needs a bit more than that, but as you point out in later
> emails, the compiler may do a better job for this.

Okay, I've moved my patch that fixes this (without adding a single line
of code!) to my fixes branch, which I'll ask you to pull in the next
couple of days.

Each of the _find_next_* functions had:

	teq	r1, #0
	beq	3b

at the beginning to catch the case where size == 0. This is now:

	cmp	r2, r1
	bhs	3b

which is the C equivalent of:

	if (offset >= size)
		goto 3b;

where both are unsigned, and nicely covers the case where size == 0 as
before (since if size is 0, the condition is always true irrespective
of the value of offset.)

We can sort out the question of keeping this code or not later, but I
think as this has been spotted as an issue, it's important to get it
fixed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
