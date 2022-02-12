Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC40C4B3895
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiBLXYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:24:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiBLXYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:24:14 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6201A5FF06;
        Sat, 12 Feb 2022 15:24:08 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E819BC0007;
        Sat, 12 Feb 2022 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644708244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFSzZ5yOgdSQAwv0PITlc/tQFNbxlnrDufyb0qNF53Q=;
        b=T3Nl6zUHyCCqkZ70eVXfYZPR33z37M7lQnQsY+qmZhmbBJnDZ0vkPcvrgeCaDUCrE7XYTG
        ILeyfuqBi6bYKAeXp/+nAYT3K5KTIk8buMzeNFwPqKGKGGYbtb4y354lm3VK68YPcM9p13
        GBXHxFZNceYRpbKJBptTKYI+quWgKOkYq3xEOs79KFibZlf/2IxCxTwvRhrawA52lYqw70
        im16ziLbq8q0e2vjmRtKvYMY6aMLDbypJbYyeDS7ToLhecyaFV97jUE+rQL876R3RI52D9
        QCqLVoxh7Gfr90O0YJ26z9EbwtX8EIF6afWEBxUKD5ur6J05GKkR6ln6a7XOOw==
Date:   Sun, 13 Feb 2022 00:24:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: (subset) [PATCH v3 5/6] clk: sunxi-ng: Add support for the sun6i
 RTC clocks
Message-ID: <YghBkp/sUHdqSn4G@piout.net>
References: <20220203021736.13434-1-samuel@sholland.org>
 <20220203021736.13434-6-samuel@sholland.org>
 <164422443570.21572.13511859513410998733.b4-ty@cerno.tech>
 <bb05bc64-2a9e-fe21-5a69-0ea31134e978@sholland.org>
 <20220211124312.kiw6t25nojvkp2rw@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211124312.kiw6t25nojvkp2rw@houat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2022 13:43:12+0100, Maxime Ripard wrote:
> Hi Samuel,
> 
> On Mon, Feb 07, 2022 at 05:54:02PM -0600, Samuel Holland wrote:
> > On 2/7/22 3:00 AM, Maxime Ripard wrote:
> > > On Wed, 2 Feb 2022 20:17:35 -0600, Samuel Holland wrote:
> > >> The RTC power domain in sun6i and newer SoCs manages the 16 MHz RC
> > >> oscillator (called "IOSC" or "osc16M") and the optional 32 kHz crystal
> > >> oscillator (called "LOSC" or "osc32k"). Starting with the H6, this power
> > >> domain also handles the 24 MHz DCXO (called variously "HOSC", "dcxo24M",
> > >> or "osc24M") as well. The H6 also adds a calibration circuit for IOSC.
> > >>
> > >> Later SoCs introduce further variations on the design:
> > >>  - H616 adds an additional mux for the 32 kHz fanout source.
> > >>  - R329 adds an additional mux for the RTC timekeeping clock, a clock
> > >>    for the SPI bus between power domains inside the RTC, and removes the
> > >>    IOSC calibration functionality.
> > >>
> > >> [...]
> > > 
> > > Applied to local tree (sunxi/clk-for-5.18).
> > 
> > Part of the build failures were because this patch depends on patch 3. Is that
> > okay, or should I update this patch to be independent?
> 
> We don't have anything queued up yet, so I think the easiest would be to
> merge this through the RTC tree. So nothing to do on your side yet, we
> just need Alex to answer :)
> 

I can take the whole series but I think I would need acks from Stephen


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
