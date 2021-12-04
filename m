Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D73468426
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384618AbhLDKro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhLDKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:47:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBE9C061751;
        Sat,  4 Dec 2021 02:44:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D1C0B80315;
        Sat,  4 Dec 2021 10:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA52CC341C0;
        Sat,  4 Dec 2021 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638614655;
        bh=03ultkCDIAoTutwVzv8jZpQbHU9d6HK0vaXgZTieX38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7lxzZjoZy9/XNSjw35zcKf8Y2PQJYap9pXGyWDp1A88gfLy8BJXuOFHeI2jJpFbW
         ldEvjAfWIDFupX+6ZtkXlQkk7wbHI9PPAFSkucwiT/WzmWfjVonQ7JRxsPVUiPMEPP
         2ly4V5uF7N5IuItQ0Bnj4ORvhXE1SkeRCrf0fzJQ=
Date:   Sat, 4 Dec 2021 11:44:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Regression: plugging in USB scanner breaks all USB functionality
Message-ID: <YatGfEzzniH/Srn4@kroah.com>
References: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
 <3eb9c3f8-6bca-da08-47ec-af2a02d6a485@leemhuis.info>
 <e03ddc81-c60b-bd28-b959-0602142f0efc@leemhuis.info>
 <Yas83rCCAQcabahe@kroah.com>
 <73b325e3-d5d9-f768-9033-3aa0d3683e47@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b325e3-d5d9-f768-9033-3aa0d3683e47@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 11:26:45AM +0100, Thorsten Leemhuis wrote:
> 
> On 04.12.21 11:03, Greg KH wrote:
> > On Fri, Dec 03, 2021 at 06:24:52PM +0100, Thorsten Leemhuis wrote:
> >> On 02.12.21 16:13, Thorsten Leemhuis wrote:
> >>> Hi, this is your Linux kernel regression tracker speaking.
> >>>
> >>> Thanks for the report.
> >>>
> >>> Top-posting for once, to make this easy accessible to everyone.
> >>>
> >>> FWIW, 5.14 is EOL, so it might not be fixed there. As the problem is in
> >>> newer kernels as well, I suspect that it was a change applies to 5.15 or
> >>> 5.16 that got backported. Maybe one of the developers might have an idea
> >>> which commit causes it. If that's not the case you likely should try a
> >>> bisection to find the culprit. Performing one between v5.14.11..v5.14.14
> >>> is likely the easiest and quickest way to find it.
> >>>
> >>> To be sure this issue doesn't fall through the cracks unnoticed, I'm
> >>> adding it to regzbot, my Linux kernel regression tracking bot:
> >>>
> >>> #regzbot ^introduced v5.14.11..v5.14.14
> >>> #regzbot title usb: plugging in USB scanner breaks all USB functionality
> >>> [regression present in 5.15.2 und 5.16-rc3, too]
> >>> #regzbot ignore-activity
> >>
> >> #regzbot introduced ff0e50d3564f
> >> #regzbot fixed-by 385b5b09c3546c87cfb730b76abe5f8d73c579a2
> >
> > Odd, where did that git commit id come from?  I don't see it in
> > linux-next or Linus's tree.
> > 
> > confused,
> 
> Yeah, sorry, after sending that mail it occurred to me that this wasn't
> ideal and hard to follow.
> 
> I got it from here:
> https://lore.kernel.org/lkml/a649395b-0b91-a0d2-c510-ea8ec4aef917@linux.intel.com/
> 
> I already decided that next time something like this comes up I'll reply
> to the mail with the details instead (with proper quoting) to make this
> easier to follow.
> 
> Reading that message again I suspect that I might have been a bit quick
> as well, as this might not be the commit id this ends up with when it
> gets merged: I now see that this is likely a developers tree and not one
> that gets indirectly merged.
> 
> Sorry, I'll manually keep an eye on things to fix this up once that
> patch gets its real it.

Ah, found it, it's now in my usb-linus branch, and I'll send it to Linus
later today:
	09f736aa9547 ("xhci: Fix commad ring abort, write all 64 bits to CRCR register.")

thanks,

greg k-h
