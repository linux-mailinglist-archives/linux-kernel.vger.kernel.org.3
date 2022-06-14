Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B854AFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356286AbiFNMFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbiFNMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:05:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7B4927A;
        Tue, 14 Jun 2022 05:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E54BB81863;
        Tue, 14 Jun 2022 12:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F45C3411B;
        Tue, 14 Jun 2022 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655208344;
        bh=6EaGbSn4r/TeDu88uoSdZfsO2bREhpvtyTSLFRBBdQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ViSpuB8+mSVxLXaTeNpdJzPIzQppv/MhO+DHwRJwhJDujYPH3xlV2r6xzIH2+nANM
         lxM+o/YtxX0/jTFV/9OrXQ27QbPFlAkC2/G9qhMlO2eaF0n/K/HOeHkRaubCNaD7hs
         dPF0wpoF/+UH0qunJs9aZHm8hB+EaF+RtNvhT6YMY2WW/2AIxyclc77Mqthf3oK1Tp
         Jk61012dq1vEqmnpW6yBwUVCMq2ELSVEwWLcxR3A9yxQKrt+bWzBkBuMhyvF5nhuRU
         ENQOKzjpBcN/9quZ/bRC78Z7voa7Q6yrPhoxKnoRW1ZPcVwF5VORv3VrA41GYTW4yv
         Tzd45VXxE0d1Q==
Date:   Tue, 14 Jun 2022 13:14:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Claudiu.Beznea@microchip.com>
Cc:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/16] iio: adc: at91-sama5d2_adc: add runtime pm
 support
Message-ID: <20220614131453.7099c043@jic23-huawei>
In-Reply-To: <68a099ac-7bf6-aca0-4723-af8e48585abc@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-16-claudiu.beznea@microchip.com>
        <20220611174824.2d696a55@jic23-huawei>
        <68a099ac-7bf6-aca0-4723-af8e48585abc@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...


> >> @@ -1268,11 +1309,15 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
> >>       if (!(iio_device_get_current_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
> >>               return -EINVAL;
> >>
> >> +     ret = pm_runtime_resume_and_get(st->dev);  
> > 
> > This seems unusual.  I'd normally expect to see runtime pm left on whenever
> > a buffer is in use, but in this case you seem to let it autosuspend.
> > 
> > That 'might' be fine as you might hit it often enough that it stays up whilst
> > doing DMA but it certainly seems odd and less than efficient.
> > Or possibly the use of the trigger is enough to keep it up.  
> 
> This is here because at91_adc_buffer_prepare() is called though
> .hwfifo_set_watermark which is called in iio_enable_buffers() before
> iio_trigger_attach_poll_func() which calls in turn
> at91_adc_configure_trigger() that turns on the power for the whole duration
> the buffers are enabled.
> 
> It is necessary to have runtime resume here to be able to do proper
> register settings.

Runtime pm is reference counted so I'd take the view that either
* buffer being enabled or
* trigger being enabled

are reasons to leave the device powered up.  That'll result in
needing it to be powered down in both buffer and trigger disables
but that shoudl be fine.

...

Thanks,

Jonathan
