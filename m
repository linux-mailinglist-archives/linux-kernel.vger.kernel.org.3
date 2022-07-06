Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B3569510
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiGFWKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiGFWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:10:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6647E29806;
        Wed,  6 Jul 2022 15:10:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e12so28127146lfr.6;
        Wed, 06 Jul 2022 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3I0RW+TU+Dt1P645glOi8M5+ymvA2PdtgHWL6EUBTE=;
        b=Lo5nMyGxSyr473d8zWRCifaxkZv9q9B33HlT6R/uatHkTgi/Ft2Tmc0A2fLXEkCCUR
         r8cqtI0xnY7ZyFflZ3z1L0Luv9qg2voj7DvhbSIQiisRH/Erl6W4zFJzCUGi6M6YGU+y
         j8Z7VpK3mI/z2Qu9UZ5iEs7ynlyo8w198ZaKq5FHE2lhHMDY9uHBwGjqTuvD0vTEkqwr
         REh7mswNrJZjAWUgy08Y/2gRETVWY2+FV3L2EDW+XmgopShuGGoHkY3bX2iS4IzFQLTr
         q97HWckBTd3pF5ToAylftmwEtuNZHftGbjXCy2xIsavUPpP66xamCoPF7mP4+6eJ1C2d
         2bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3I0RW+TU+Dt1P645glOi8M5+ymvA2PdtgHWL6EUBTE=;
        b=rObUz8QR52fnfshg9a/VKrGjE5Yw0UZgyCx2A9iM8Aw/jcnTnEqr/y6D6hbeDdvF19
         nNf4iLYXFIuYVfXC1O2PgsLiCvLal+fDNQXy/Gn9969YKGd8/aEcmX/6BcwRdDlS6FFM
         PofOEG2/j4RKm53HFWfCUQTNV1uJc2y0kjm+fe4oKMYgqoyE2xbo7aq8jEAcHwpRcg9q
         fULovJ9L8wK/+WET+7VG5JNYlaEmDZ+eQuNhvZcw9bvGzw73gPl0IRvlkQf1/GKo2+2J
         lCcwpiIx5YaTYWfpRygjSrI/rTX1I/k+JTk/5M4Z/fwE8fxHiyXhc8HjRPB4tjqsHlw0
         Shhw==
X-Gm-Message-State: AJIora+HBVEbZsGFwDuJQ1Mwpvza1FjlAT3DDcu009abfQ5Dx6W6DYJV
        CGzVUX4XRnTTXOADyDpvZ0w=
X-Google-Smtp-Source: AGRyM1tB+RlfKxXF0voWtTSuQ8A9WCh00/hQLi3fR0Iv3n7cqMx/h4hcrfYaL6u1ivl3sQgKiJNlZQ==
X-Received: by 2002:a05:6512:3d9f:b0:47f:9e4f:adb1 with SMTP id k31-20020a0565123d9f00b0047f9e4fadb1mr26345755lfv.340.1657145421474;
        Wed, 06 Jul 2022 15:10:21 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id c23-20020a056512325700b0047f70a0b8ffsm6475602lfr.20.2022.07.06.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:10:20 -0700 (PDT)
Date:   Thu, 7 Jul 2022 01:10:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 6/8] clk: baikal-t1: Move reset-controls code
 into a dedicated module
Message-ID: <20220706221018.3swtmotaqggww4xu@mobilestation>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141853.7417-7-Sergey.Semin@baikalelectronics.ru>
 <e0869ae1b10ec19eaf87dc5fa53498f82e7deaac.camel@pengutronix.de>
 <20220705220757.dwzmrx34t2nsxfzl@mobilestation>
 <f28de0c61c06396e36756f2d4f3379fab26abdbf.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f28de0c61c06396e36756f2d4f3379fab26abdbf.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:16:34AM +0200, Philipp Zabel wrote:
> Hi Serge,
> 
> On Mi, 2022-07-06 at 01:07 +0300, Serge Semin wrote:
> [...]
> > > What is the reason for separating ccu-rst.c and clk-ccu-rst.c?
> > > 
> > > I expect implementing the reset ops and registering the reset
> > > controller in the same compilation unit would be easier.
> > 
> > From the very beginning of the Baikal-T1 driver live the Clock/Reset functionality
> > has been split up into two parts:
> > 1. ccu-{div,pll}.c - Clock/Reset operations implementation.
> > 2. clk-ccu-{div,pll}.c - Clock/Reset kernel interface implementation.
> > At least for the clk-part it has made the driver much easier to read.
> > Code in 1. provides the interface methods like
> > ccu_{div,pll}_hw_register() to register a clock provider corresponding
> > to the CCU divider/PLL of the particular type. Code in 2. uses these
> > methods to create the CCU Dividers/PLL clock descriptors and register
> > the of-based clocks in the system. The reset functionality was
> > redistributed in the same manner in the framework of the ccu-div.c and
> > clk-ccu-div.c modules.
> > 
> > A similar approach I was trying to utilize in the framework of the
> > separate CCU Resets implementation. Although it turned out to be not as
> > handy as it was for the clock-part due to the different clock and
> > reset subsystems API (clock subsystem provides a single clock
> > source based API, while the reset subsystem expects to have the whole
> > resets controller described). Anyway I've decided to preserve as much
> > similarities as possible for the sake of the code unification and
> > better readability/maintainability. Thus the reset lines control
> > methods have been placed in the ccu-rst.c object file, while the reset
> > control registration has been implemented in the clk-ccu-rst.c module.
> 
> Thank you for the detailed explanation. I think that splitting doesn't
> help readability much in this case, but I realize that may just be a
> matter of preference.
> 
> [...]
> > > I don't think this is necessary, see my comments below. Since the reset
> > > ids are contiguous, just setting nr_resets and using the default
> > > .of_xlate should be enough to make sure this is never called with an
> > > invalid id.
> > 
> > Using non-contiguous !Clock! IDs turned to be unexpectedly handy. Due to
> > that design I was able to add the internal clock providers hidden from
> > the DTS users but still visible in the clocks hierarchy. It has made the
> > clocks implementation as detailed as possible and protected from the
> > improper clocks usage. It also simplified a new clock providers adding
> > in future (though there won't be clock sources left undefined in the
> > SoC after this patchset is applied).
> > 
> > All of that made me thinking that the same approach can be useful in
> > the framework of the CCU reset controls implementation too at the very
> > least for the code unification. Although after the next patch in the
> > series is applied there won't be resets left undefined in the
> > Baikal-T1 SoC. So from another side you might be partly right on
> > suggesting to drop the independent reset IDs/descriptors design and
> > just assume the IDs contiguousness.
> > 
> > So could you please confirm that you still insists on dropping it?
> 

> Please drop it, then. I don't think there is value in carrying this
> complexity just because it makes the code more similar to the
> neighboring clk code.
> 
> I'd prefer to keep the reset ids contiguous, so future hardware should
> just get a different set of contiguous IDs, or new IDs appended
> contiguously as you do in patch 7.

Agreed then. I'll update the patches and resend the series shortly.
Thank you very much for review.

-Sergey

> 
> [...]
> > > 
> > > 
> > > 
> > > I would fold this into ccu_rst_hw_unregister().
> > 
> > I disagree in this part. Splitting up the interface methods in a set
> > of the small coherent methods like protagonists and respective
> > antagonists makes the code much easier to read and maintain. So I
> > will insist on having the ccu_rst_free_data() method even if it is
> > left with only a single kfree() function invocation.
> [...]
> > I have to disagree for the same reason as I would preserve the
> > ccu_rst_free_data() method here. Please see my comment above.
> 
> I'm fine with that.
> 
> > 
> regards
> Philipp
