Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9873258612E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiGaUDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiGaUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C706DF72;
        Sun, 31 Jul 2022 13:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33BEC6106D;
        Sun, 31 Jul 2022 20:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1ECC433C1;
        Sun, 31 Jul 2022 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659297820;
        bh=DiCzLyjq2glkJY89KAj8wJUY9M8e4FOBXNexPvEN1+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lav/Tqvm6Jh6brIHJfl8lK+UYy1F8mqVmUpl+45ClyLSIUlfDEARo98owlJgmi2Ro
         tOl+1xi32Mgcp87SMiKbep0Je6ZQNBicQndl39KnNfM303yfePLeTwzVGoVDMnLG8J
         aN1Qqudh1NTkpKA3ixyyc/mjYnYz+jRa6NIPoJYQQtQ2dbRz224VHebhosFst1lgMU
         FoSVY+gXU8Tb9InGjQBghic6HvYLVLOI4JX+sdC1KWYZDutUeFl14SI7C4uj5Af390
         jNHSB6RshgdC0HcQBhHqlMgDPNJKhPIdgAqLN1bIa8tDjx5YowDHKoxyyq3EA4NOnG
         n/+0F3eoVuSwg==
Date:   Sun, 31 Jul 2022 21:13:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 00/19] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Message-ID: <20220731211351.072e3334@jic23-huawei>
In-Reply-To: <20220716174249.687af22b@jic23-huawei>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
        <20220716174249.687af22b@jic23-huawei>
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

On Sat, 16 Jul 2022 17:42:49 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 28 Jun 2022 18:16:12 +0300
> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> 
> > Hi,
> > 
> > The following series add support for temperature sensor available on
> > SAMA7G5.
> > 
> > Temperature sensor available on SAMA7G5 provides 2 outputs VTEMP and VBG.
> > VTEMP is proportional to the absolute temperature voltage and VBG is a
> > quasi-temperature independent voltage. Both are necessary in computing
> > the temperature (for better accuracy). Also, for better accuracy the
> > following settings were imposed when measusing the temperature:
> > oversampling rate of 256, sampling frequency of 10MHz, a startup time of
> > 512 ticks, MR.tracktim=0xf, EMR.trackx=0x3.
> > 
> > For computing the temperature measured by ADC calibration data is
> > necessary. This is provided via OTP memory available on SAMA7G5.
> > 
> > Patches 1/19-4/19 provides some fixes.
> > Patches 5/19-16/19 prepares for the addition of temperature sensor
> > support.
> > Patch 17/16 adds the temperature sensor support.
> > 
> > Along with temperature sensor support I took the chance and added
> > runtime PM support in this series, too (handled in patch 19/19).
> > 
> > The rest of patches in this series are minor cleanups.  
> 
> Other than the use of MEGA in patch 17, I'm fine with this now, but
> would like to leave more time for Eugen and others to comment if they
> wish.  Given timing, I'm afraid this is very unlikely to make the next
> merge window anyway now, so we have lots of time.

Long enough.  I'll queue this up though for now it'll only be exposed as testing
as I'll be rebasing the togreg tree on rc1 once available.

Thanks,

Jonathan

> 
> Sorry for the delay in my reviewing v2. Pesky covid.
> 
> Jonathan
> 
> > 
> > Thank you,
> > Claudiu Beznea
> > 
> > Changes in v2:
> > - addressed review comments
> > - with this, new patches were intruced in this series: 2/19, 4/19,
> >   8/19, 9,19
> > - runtime pm support has been adapted to work also when CONFIG_PM
> >   is not enabled
> > - collected tags
> > 
> > Claudiu Beznea (19):
> >   iio: adc: at91-sama5d2_adc: fix AT91_SAMA5D2_MR_TRACKTIM_MAX
> >   iio: adc: at91-sama5d2_adc: check return status for pressure and touch
> >   iio: adc: at91-sama5d2_adc: lock around oversampling and sample freq
> >   iio: adc: at91-sama5d2_adc: disable/prepare buffer on suspend/resume
> >   iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are
> >     enabled
> >   iio: adc: at91-sama5d2_adc: handle different EMR.OSR for different hw
> >     versions
> >   iio: adc: at91-sama5d2_adc: move the check of oversampling in its
> >     function
> >   iio: adc: at91-sama5d2_adc: drop AT91_OSR_XSAMPLES defines
> >   iio: adc: at91-sama5d2_adc: add .read_avail() chan_info ops
> >   iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
> >   iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
> >   iio: adc: at91-sama5d2_adc: move oversampling storage in its function
> >   iio: adc: at91-sama5d2_adc: update trackx on emr
> >   iio: adc: at91-sama5d2_adc: add startup and tracktim as parameter for
> >     at91_adc_setup_samp_freq()
> >   iio: adc: at91-sama5d2_adc: lock around at91_adc_read_info_raw()
> >   dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature
> >     channel
> >   iio: adc: at91-sama5d2_adc: add support for temperature sensor
> >   iio: adc: at91-sama5d2_adc: add empty line after functions
> >   iio: adc: at91-sama5d2_adc: add runtime pm support
> > 
> >  drivers/iio/adc/at91-sama5d2_adc.c            | 683 +++++++++++++++---
> >  .../dt-bindings/iio/adc/at91-sama5d2_adc.h    |   3 +
> >  2 files changed, 566 insertions(+), 120 deletions(-)
> >   
> 

