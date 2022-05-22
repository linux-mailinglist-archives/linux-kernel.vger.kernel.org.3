Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115255302A8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbiEVL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiEVL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA82ED68;
        Sun, 22 May 2022 04:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DC7A60EFA;
        Sun, 22 May 2022 11:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42281C385AA;
        Sun, 22 May 2022 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653218914;
        bh=I1TCglVaUOlQv9NY1yHyp/8XZg1F5alSwioMHOuiLOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=edEcURbzrSmVoivNV/l85Tcq/+YRXHI5cR2eu5pjA0Sv23Xrjb5FPT6Cz09vqcn0R
         yHBK+QMqd0ivdLGszxp2I5NBWvlXmwOCxBGlslpJF7A/X/ZgLy4w0sUo9hq02CYU2z
         9qsRJ/da2mX9NBOMmlIQ+P7ewqEYlWswU0j98Jr1zA298CkHTqGimkGArz3zkgVo/z
         8midgGKhZB94LkCA57NlQ469ykb4sJaaX94An75MYXn/tBLyU83636n3dNRdPuPdvd
         4TgYLqw2kY93fwc5gey0G/gLo9ZYJURsKm28iDBmUOt1oo+zhPd0QyNBm1a8geSZx8
         z23vmr7EtANbw==
Date:   Sun, 22 May 2022 12:37:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: Re: [PATCH V3 0/6] iio: accel: bmi088: support BMI085 BMI090L
Message-ID: <20220522123719.3e34bb6e@jic23-huawei>
In-Reply-To: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 15:04:19 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Modified the units after application of scale from 100*m/s^2 to m/s^2,
> since the units in the ABI documents are m/s^2.
> Add supports for the BMI085 accelerometer.
> Add supports for the BMI090L accelerometer.
> Make it possible to config scales.
> 
> Change in V3: 
> 
> Use FIELD_GET for checking register range. Reorder the chip info and 
> dt-bindings alphabetical. Add of_id_table. Modify the logic of loading
> sensor chip info. If the device was found in the table but the device 
> tree binding is different, the driver will carry on with the detected
> chip with a warning. If no matching device was found, the driver load
> the binding chip.

All looks good to me. Unfortunately we've missed the 5.19 merge window
now as it will probably open shortly.  As such we have lots of time so
I'll leave this on list for a little longer for others to take a look at.
Thanks,

Jonathan

> 
> 
> LI Qingwu (6):
>   iio: accel: bmi088: Modified the scale calculate
>   iio: accel: bmi088: Make it possible to config scales
>   iio: accel: bmi088: modified the device name
>   iio: accel: bmi088: Add support for bmi085 accel
>   iio: accel: bmi088: Add support for bmi090l accel
>   dt-bindings: iio: accel: Add bmi085 and bmi090l bindings
> 
>  .../bindings/iio/accel/bosch,bmi088.yaml      |  2 +
>  drivers/iio/accel/bmi088-accel-core.c         | 96 +++++++++++++++----
>  drivers/iio/accel/bmi088-accel-spi.c          | 17 +++-
>  drivers/iio/accel/bmi088-accel.h              |  9 +-
>  4 files changed, 100 insertions(+), 24 deletions(-)
> 

