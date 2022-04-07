Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A94F7818
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiDGHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiDGHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:50:30 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B346141;
        Thu,  7 Apr 2022 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649317712;
  x=1680853712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=65cq+04D2t91MgXQs2FV1LSZ91INmcsG6pr3WgD2E7M=;
  b=bQzducTedCmQckTwZX1IlWeB9H+3fnDxErNGSv0UqoYECY1mAV0iLDGj
   ccIXbqu4qZpJamltH5XlBMFaBgOjaIjISpDPtXghLFWvWE1wJ/2RdTKvG
   kVnFMjDt8I0SAP5JyX+ZRRm0c+JhqbehKve6bUmbooP1ClbKrYhT/52B1
   F8vQVcI0SShLOuvc38+4KwKI1r0Yy216y0N915mP7He93wyjx8V8yojdA
   mJTrcykmve5LG4kvX/BIvvNIRF3dRjdjTpw8sVjJxbcgDSHYuf1MM8Hss
   JxEilDw+OCQ7uYCBwLiJj1kN7AB9JOkE7aFZtNBAuoisfJCGRq1tqvwEL
   Q==;
Date:   Thu, 7 Apr 2022 09:48:29 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        kernel <kernel@axis.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>
Subject: Re: [PATCH v2 3/4] clocksource/drivers/exynos_mct: Support
 local-timer-index property
Message-ID: <20220407074829.GA31389@axis.com>
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
 <20220308142410.3193729-4-vincent.whitchurch@axis.com>
 <226dcb1b-d141-f0d3-68c4-11d2466ca571@canonical.com>
 <20220311113543.GA17877@axis.com>
 <CGME20220311125154eucas1p180cf38fcfe33e52757c2442bbd9c2ab3@eucas1p1.samsung.com>
 <69be9f88-b69b-c149-4387-c5002219bf0a@canonical.com>
 <e8b58fc4-fdc2-7fca-f8f5-c45f0891b53b@samsung.com>
 <20220330082137.GA21079@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220330082137.GA21079@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:21:37AM +0200, Vincent Whitchurch wrote:
> On Mon, Mar 21, 2022 at 09:00:08AM +0100, Marek Szyprowski wrote:
> > Right, I've played a bit with MCT on some older Exynos SoCs (ARM 32bit 
> > based and even Exynos5433) and it looked that none of it enabled MCT FRC 
> > timer in their proprietary firmware. I've even proposed a patch for this 
> > once ([1]), but such approach has been rejected. I think that calling 
> > exynos4_mct_frc_start() unconditionally won't hurt.
> 
> Thank you for looking into this.  The proposal was however not to avoid
> changing when exynos4_mct_frc_start() is called, but to instead skip the
> write to the Timer Enable bit of the G_TCON register if it is already
> set, like in the below patch.  (This is needed to avoid races when the
> FRC is shared between CPUs in an AMP configuration, since TCON can be
> modified for other reasons from the CPU which is using the global
> comparator.)
> 
> If I understand your comment correctly, such a change should not cause
> any difference at least on the platforms you looked at since there
> MCT_G_TCON_START will not have been set at startup.

I needed the frc-shared property anyway to prevent registration of the
clock events so I followed Krzysztof's suggestion of doing this
conditionally and also clearing the resume callback.
