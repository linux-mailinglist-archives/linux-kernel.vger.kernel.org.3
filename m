Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81EE53CC73
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiFCPmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242335AbiFCPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B46241;
        Fri,  3 Jun 2022 08:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50225618CD;
        Fri,  3 Jun 2022 15:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90173C385A9;
        Fri,  3 Jun 2022 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654270927;
        bh=uFt38kXWvTTdnaN2oP0GGgGo2/Cw36q2/icUr1V3lKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dJ+Ti4C0KVap4cUeztpqDfBH+7Guhimexya1pTrneKuxTIlHilQHmaPbkvFb7wSue
         otbJhlmUQPqTomW8uWpzhMwboZF1BOTWsW5MGujz9/ZwSu2GQ26gOnS1Cgky/0jABZ
         xASzRfrKhXQd1E6X8Zx8BIeC80YEebgsCG340vKSBB+Buc+uWnInKgZ8WEvPzC3rt8
         zPFcwGo5ok9R9Nt9O/ixe04M0U2TTtVsm+bX0HCV0rQWDVqCHwcBp927s+wWlhR44M
         r0udqBAhpk+Fnsj0ATYQLl8DlFjvurZvEkzJTDZVlv38mHQ5xXyRvHsbO1dS/hpC5N
         hqA6yFTDHvtjw==
Date:   Fri, 3 Jun 2022 16:51:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: Re: [PATCH V5 0/6] iio: accel: bmi088: support BMI085 BMI090L
Message-ID: <20220603165106.78f13761@jic23-huawei>
In-Reply-To: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
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

On Thu, 26 May 2022 13:33:53 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Modified the units after application of scale from 100*m/s^2 to m/s^2,
> since the units in the ABI documents are m/s^2.
> Add supports for the BMI085 accelerometer.
> Add supports for the BMI090L accelerometer.
> Make it possible to config scales.
> 
> Change in v5: 
> - Fix the issue of 'undeclared function FIELD_GET'
>   Reported-by: kernel test robot <lkp@intel.com>

I've applied this series to the togreg branch of iio.git and pushed
out as testing.

Note I can rebase that tree still (and will do anyway to move to
rc1 or so once available) so we can resolve that question of
whether Datasheet is a tag or not in parallel with letting 0-day
see if it can find anything else we missed.

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
>  drivers/iio/accel/bmi088-accel-core.c         | 97 +++++++++++++++----
>  drivers/iio/accel/bmi088-accel-spi.c          | 17 +++-
>  drivers/iio/accel/bmi088-accel.h              |  9 +-
>  4 files changed, 101 insertions(+), 24 deletions(-)
> 

