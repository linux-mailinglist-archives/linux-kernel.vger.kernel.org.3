Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CBB586127
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiGaUA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbiGaUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:00:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327D1EE32;
        Sun, 31 Jul 2022 13:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4D98B80D18;
        Sun, 31 Jul 2022 20:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F5CC433D6;
        Sun, 31 Jul 2022 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659297651;
        bh=yhG/0weQiu1uClHoiYMUHcDuCmikwM2JcQ+CqPn5MhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ubFRmDjd9f6LwROClVgJu44QJvGHnInjGvU2sQaqYYe1ZCanW51kettShaf9acR88
         kRgti/Y+F20+PDnWBFU7qZUFkcYFZxAekvxb2F2x8d7ecuiZbf+3FpW0na6XNjxuwq
         pVWHTY4wcgh3Z8SOtawtU3TZ4JXnoooyOp3oIZjThNjQJ3H+pDNkEFUIE9KtViVrih
         hZ0l607+XH4mnQJdOWqXlkJTbJ835uY9z/xgR68crmuQ+KLESi6LbloO1Z2tatqWOb
         0W8VjyOLVae+Xc5evxpVBGhu/lpiCIvnSKE2RN/AzpVMWKbbPpadm9168kC9IC/pBX
         QpnKKq7Xk8+rA==
Date:   Sun, 31 Jul 2022 21:11:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 19/19] iio: adc: at91-sama5d2_adc: add runtime pm
 support
Message-ID: <20220731211101.2ca0ab1b@jic23-huawei>
In-Reply-To: <20220628151631.3116454-20-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
        <20220628151631.3116454-20-claudiu.beznea@microchip.com>
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

On Tue, 28 Jun 2022 18:16:31 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Add runtime PM support by disabling/enabling ADC's peripheral clock.
> On simple conversion the ADC's clock is kept enabled just while the
> conversion is in progress. This includes also temperature conversion.
> For triggered buffers and touch conversions the ADC clock is kept enabled
> while the triggered buffers or touch are enabled. Along with it removed
> the __maybe_unused on suspend() and resume() ops as the dev_pm_ops
> object members are now filled with SYSTEM_SLEEP_PM_OPS().
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi Claudia,

This patch crossed with a mass conversion series taking lots of drivers
over to the new PM ops macros. That covered some of the changes in here.
I've hand applied this but please check I didn't mess it up.

Thanks,

Jonathan
