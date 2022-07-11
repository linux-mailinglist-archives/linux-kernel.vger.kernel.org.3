Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6257047C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiGKNjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiGKNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:39:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D1C8419AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:39:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3857C1596;
        Mon, 11 Jul 2022 06:39:37 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22E803F70D;
        Mon, 11 Jul 2022 06:39:35 -0700 (PDT)
Date:   Mon, 11 Jul 2022 14:40:08 +0100
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, judyhsiao@chromium.org
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix NULL pointer dereference when
 pinctrl is not found
Message-ID: <YswoOE/sP088lius@monolith.localdoman>
References: <20220711130522.401551-1-alexandru.elisei@arm.com>
 <Yswkb6mvwUywOTLg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yswkb6mvwUywOTLg@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Jul 11, 2022 at 02:23:59PM +0100, Mark Brown wrote:
> On Mon, Jul 11, 2022 at 02:05:22PM +0100, Alexandru Elisei wrote:
> > Commit a5450aba737d ("ASoC: rockchip: i2s: switch BCLK to GPIO") switched
> > BCLK to GPIO functions when probing the i2s bus interface, but missed
> > adding a check for when devm_pinctrl_get() returns an error.  This can lead
> > to the following NULL pointer dereference on a rockpro64-v2 if there are no
> > "pinctrl" properties in the i2s device tree node:
> > 
> > [    0.658381] rockchip-i2s ff880000.i2s: failed to find i2s default state
> > [    0.658993] rockchip-i2s ff880000.i2s: failed to find i2s gpio state
> > [    0.660072] rockchip-i2s ff890000.i2s: failed to find i2s default state
> > [    0.660670] rockchip-i2s ff890000.i2s: failed to find i2s gpio state
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information

I'm at a loss here. Are you saying that those 4 lines represent a complete
backtrace and they are very large? Or are you talking about the panic log
that I've included in the commit message?

> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Would you mind pointing out what you think the relevant sections are? I
would also find it very useful (for future patches) if you can explain why
they are relevant, and why those parts you've left out aren't.  It's not
very easy to figure out what is relevant when you're not familiar with a
subsystem.

Thanks,
Alex
