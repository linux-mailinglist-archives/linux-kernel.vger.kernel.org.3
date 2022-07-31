Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD992585FA6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiGaP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiGaP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:57:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E6F5BA;
        Sun, 31 Jul 2022 08:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E24FB80D11;
        Sun, 31 Jul 2022 15:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD80C433D6;
        Sun, 31 Jul 2022 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659283052;
        bh=2Tx7WBqhR2Aw42eMMqAo9G23wcNrK9di5KicstE97W4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tu2gRR8nkLaFIIEVG8liBcMmpIp3NlfGh2b8dbTQyYAWqoMse+dXCSPHZHr18zBiQ
         K0QabxkX02DYH6WKACwm2S/jd69B4F/AUv3CtMeiNf9+w+1csTKmSHqZDd+4fSSpuV
         Lk2PD+cwfN3Bfm8oOpBITASE337s+P8810LEWKAlpi66ttHAGETrdufnl/xxMh7cHd
         9iSZ4Fjy/6Knest+GnFCr5MMiPs2hIahquQSsRW2USroVc6+gO1cgKR4bnHvz2pHwZ
         dLdiWw2z3Dshq5FFMFRws5ScI432UTYhstKIAPutTliVcFxMnXcpmql5Qg4q9PgCLb
         7sLC3a0QhYbIQ==
Date:   Sun, 31 Jul 2022 17:07:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] iio: pressure: bmp280: Fix alignment for DMA
 safety
Message-ID: <20220731170743.238e0e8c@jic23-huawei>
In-Reply-To: <CAHp75VfwhUEdpkRKNme_rVn=bxEgV+p+RK4G961oVnikB35vCA@mail.gmail.com>
References: <cover.1658597501.git.ang.iglesiasg@gmail.com>
        <e6f4055d1c2a535e645ce6c25091dd5b40cd5a2f.1658597501.git.ang.iglesiasg@gmail.com>
        <CAHp75VfwhUEdpkRKNme_rVn=bxEgV+p+RK4G961oVnikB35vCA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 23:08:47 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Jul 23, 2022 at 7:40 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> >
> > Adds a DMA-safe buffer to driver data struct to store raw data from sensor
> >
> > Updated calibration read functions to use DMA-safe buffers as well.
> > In this case, as calibration data is only read at sensor initialization,
> > the buffers are allocated with kmalloc and freed after being processed.  
> 
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>  
> 
> Jonathan, maybe it's easier to fix in regmap once for all (something
> like a new flag there dma_safe)? Also a side note: i2c doesn't need
> that, since it has its own implementation.

Possibly... Not something I want to tie up with an individual driver though
as it might take a while and be (somewhat) controversial. Nice idea though as, if
a bounce buffer is needed for a particular regmap operation it can implement one
and when not, it can elide that step and just use the provided buffer directly.

Jonathan

> 
> P.S. Use sizeof() in regmap calls where it's appropriate.
> 

