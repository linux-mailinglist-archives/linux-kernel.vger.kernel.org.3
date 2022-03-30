Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2AB4EBCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiC3IXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244407AbiC3IX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:23:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FE532EE0;
        Wed, 30 Mar 2022 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1648628503;
  x=1680164503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AH+4xQbZM08WZt8qm/l3tTz+5fAhec0WZ52E5BgUGxc=;
  b=dsOxHm2wNOiFvRmqiE98ot35tpcWiFtTvkvwup5ov/K6Q2XzEDOpgwsQ
   XcxFQOfxiGgQakGVld8FSQoH6agDp+UvQAyXDAcWRhQkaCuu2EvhHwiUw
   qXxpPA0E9c1/bBgEwRzOe0WBNrE59G4fOyp7BqyP+i9Fb/+LSnFpMo0tw
   YXM3CiSLUoeHPOMY5x7CDcPOOfVUMTsjNyVGLg5GTdqJdFULrojMwzUGK
   IpYMYpWGdIqSgJRFXObZRRAJPNqMoAX+ZheMSKAZJdvl3a8zp+tdr/Jdn
   LgSaLa6peKUassyO0mIdc5k7OEItSrVKIn4+dH5KbwJR6NgyXOFMWkUtE
   g==;
Date:   Wed, 30 Mar 2022 10:21:37 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] clocksource/drivers/exynos_mct: Support
 local-timer-index property
Message-ID: <20220330082137.GA21079@axis.com>
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
 <20220308142410.3193729-4-vincent.whitchurch@axis.com>
 <226dcb1b-d141-f0d3-68c4-11d2466ca571@canonical.com>
 <20220311113543.GA17877@axis.com>
 <CGME20220311125154eucas1p180cf38fcfe33e52757c2442bbd9c2ab3@eucas1p1.samsung.com>
 <69be9f88-b69b-c149-4387-c5002219bf0a@canonical.com>
 <e8b58fc4-fdc2-7fca-f8f5-c45f0891b53b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8b58fc4-fdc2-7fca-f8f5-c45f0891b53b@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 09:00:08AM +0100, Marek Szyprowski wrote:
> Right, I've played a bit with MCT on some older Exynos SoCs (ARM 32bit 
> based and even Exynos5433) and it looked that none of it enabled MCT FRC 
> timer in their proprietary firmware. I've even proposed a patch for this 
> once ([1]), but such approach has been rejected. I think that calling 
> exynos4_mct_frc_start() unconditionally won't hurt.

Thank you for looking into this.  The proposal was however not to avoid
changing when exynos4_mct_frc_start() is called, but to instead skip the
write to the Timer Enable bit of the G_TCON register if it is already
set, like in the below patch.  (This is needed to avoid races when the
FRC is shared between CPUs in an AMP configuration, since TCON can be
modified for other reasons from the CPU which is using the global
comparator.)

If I understand your comment correctly, such a change should not cause
any difference at least on the platforms you looked at since there
MCT_G_TCON_START will not have been set at startup.

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 6db3d5511b0f..ed462e0a77ff 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -162,6 +162,9 @@ static void exynos4_mct_frc_start(void)
 	u32 reg;
 
 	reg = readl_relaxed(reg_base + EXYNOS4_MCT_G_TCON);
+	if (reg & MCT_G_TCON_START)
+		return;
+
 	reg |= MCT_G_TCON_START;
 	exynos4_mct_write(reg, EXYNOS4_MCT_G_TCON);
 }
