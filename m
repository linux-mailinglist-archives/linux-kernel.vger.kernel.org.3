Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3C85706CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiGKPRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGKPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:17:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B516E23BE2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:17:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D43B71596;
        Mon, 11 Jul 2022 08:17:06 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFACE3F70D;
        Mon, 11 Jul 2022 08:17:04 -0700 (PDT)
Date:   Mon, 11 Jul 2022 16:17:37 +0100
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, judyhsiao@chromium.org
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix NULL pointer dereference when
 pinctrl is not found
Message-ID: <Ysw+3Hg+GbDjXuTn@monolith.localdoman>
References: <20220711130522.401551-1-alexandru.elisei@arm.com>
 <Yswkb6mvwUywOTLg@sirena.org.uk>
 <YswoOE/sP088lius@monolith.localdoman>
 <Ysw2mzhw4pyrxirc@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysw2mzhw4pyrxirc@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 03:41:31PM +0100, Mark Brown wrote:
> On Mon, Jul 11, 2022 at 02:40:08PM +0100, Alexandru Elisei wrote:
> > On Mon, Jul 11, 2022 at 02:23:59PM +0100, Mark Brown wrote:
> 
> > > Please think hard before including complete backtraces in upstream
> > > reports, they are very large and contain almost no useful information
> 
> > I'm at a loss here. Are you saying that those 4 lines represent a complete
> > backtrace and they are very large? Or are you talking about the panic log
> > that I've included in the commit message?
> 
> I'm talking about the entire log that that was the start of, I deleted
> the bulk of it due to the excessive size.

Oh, that makes sense then.

> 
> > > relative to their size so often obscure the relevant content in your
> > > message. If part of the backtrace is usefully illustrative (it often is
> > > for search engines if nothing else) then it's usually better to pull out
> > > the relevant sections.
> 
> > Would you mind pointing out what you think the relevant sections are? I
> > would also find it very useful (for future patches) if you can explain why
> > they are relevant, and why those parts you've left out aren't.  It's not
> > very easy to figure out what is relevant when you're not familiar with a
> > subsystem.
> 
> It really depends what the information you're trying to convey with the
> backtrace is, in general a couple of frames of context might be useful
> if there's something interesting about the context from which things
> were called since that's the unique bit that people might search for.
> For example things like the standard set of generic functions you'd see
> when probing a device is rarely going to convey anything meaningful, and
> similarly the standard kernel entry backtrace for something triggered
> from a system call.  The full register state is also commonly not of any
> great relevance if it's not illustrating something in the rest of the
> message. 
> 
> If you are just including an entire splat on the off chance that it
> might be relevant consider just not including it rather than including
> everything.

Thanks for the explanation!

I've included the entire splat, not just the bits that prove my conclusion,
in case my conclusion is wrong and someone reading the backtrace can notice
what I missed.

In this case, the splat was definitely useful for me, because the last two
functions from the call trace point to where the bug was.

Do you want me to respin the patch with an abbreviated splat?

Thanks,
Alex
