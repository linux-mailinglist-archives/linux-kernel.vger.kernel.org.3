Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDA64CA7D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbiCBOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242875AbiCBOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:20:13 -0500
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DAC12F4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=n5GR3TWh0Q8Ps0121pNs/9Rd3Eg3tDNanGJBJMO8gro=; b=ZHQ9EkEa8S+XsegimbKXyGEGeW
        8rVmwb2GVnGk0Yp0saDpIXYhZziXKJPRk2i6CMQSLxTwQf88KwilxUSNLT4UwaAxFnlWM8+y/ReOg
        wHUUHhus9+0G52BuPZQwxEqt8yeAJEbH+mXxxFHCabJC1uma6EmBMeJaPIFQurxks20D0/UskdgKU
        lMGAF27LhjyeAez71Tr/RuzKQJldS4ly1F3lhTyuwrjLPcBQ7RnyzAvU2+AyQj4g6UWln9lXXsVYO
        VRZJ1h+kxDlf1fXAAkGkOnacjFoW58QVTTEk64M+BG2m9unbyHh8JqZ8SF/57x3scPaB7DYcOizY6
        BGvnABBw==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1nPPou-002a4A-Uo; Wed, 02 Mar 2022 14:19:12 +0000
Date:   Wed, 2 Mar 2022 14:19:12 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        jeremy.fitzhardinge@citrix.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Use strtobool for noexec parsing
Message-ID: <Yh984FR4fd/cSlaS@gallifrey>
References: <20220227201356.241452-1-linux@treblig.org>
 <Yh9ffhD3809qieua@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Yh9ffhD3809qieua@nazgul.tnic>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-9-amd64 (x86_64)
X-Uptime: 14:18:28 up 114 days, 23:51,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Borislav Petkov (bp@alien8.de) wrote:
> On Sun, Feb 27, 2022 at 08:13:56PM +0000, Dr. David Alan Gilbert wrote:
> > Use strtobool to parse the 'noexec' parameter rather than open coding
> > it.
> > 'disable_nx' is changed to a bool and flipped to 'enable_nx'
> > so it's meaning follows the command line option.
> > 
> > There's no change in behaviour for noexec=on/off.
> > noexec=junk will now warn
> > strtobool allows 0/1 and y/n (etc) as well as the on/off.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  arch/x86/mm/setup_nx.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> https://lkml.kernel.org/r/20220127115626.14179-6-bp@alien8.de

Oh well; good.

Thanks for the pointer.

Dave

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
