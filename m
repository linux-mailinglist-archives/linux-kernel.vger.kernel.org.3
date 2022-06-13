Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F159254A0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiFMU7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352256AbiFMUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B61724088;
        Mon, 13 Jun 2022 13:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8O3gyMH/DIarLtUQIeptn6LXzo+PYX0mLfSnGbw2a7g=; b=NiCUaEIDQk/r/vKjMnabo0T1aj
        KK3IXgeBZZBkAGgl4TSxcVArNoBIV/AKyyLi9t5a07UnCfbFSwN2nvXFXzLDYNNMAXXD2fr3a3lXn
        5qBH/nL9tJX2J7QQ4kM/7UEN+euVSEGc7b6Ex8N+TV4DQW9YU3BeLEFg/YHZyrRBVB4eOurKWVCUV
        3dbn5FrNEUgwk3XQpLPNxo6eOD7VlDnTDsuYkubKzs3hE1PvMf7ii7WpSMRyCQ1xaKSHGQwOi4VXv
        BhCrf7pxathZUx6m7wZ/N1DXG7+13m4woNibuhLDnSJXchPFtBME85NedsEqI+ptN5vbrVryuRlDS
        RIIm5mxw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0qZK-007fIG-L3; Mon, 13 Jun 2022 20:21:51 +0000
Message-ID: <424b4f90-138c-d71f-0f1c-12c60e44c1c2@infradead.org>
Date:   Mon, 13 Jun 2022 13:21:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 15/15] video: backlight: mt6370: Add Mediatek MT6370
 support
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-16-peterwu.pub@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220613111146.25221-16-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/22 04:11, ChiaEn Wu wrote:
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index a003e02e13ce..ec1589ad88bb 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -268,6 +268,15 @@ config BACKLIGHT_MAX8925
>  	  If you have a LCD backlight connected to the WLED output of MAX8925
>  	  WLED output, say Y here to enable this driver.
>  
> +config BACKLIGHT_MT6370
> +	tristate "Mediatek MT6370 Backlight Driver"
> +	depends on MFD_MT6370
> +	help
> +	  This enables support for Mediatek MT6370 Backlight driver.
> +	  It's commonly used to drive the display WLED. There're 4 channels

	                                                There are 4 channels

> +	  inisde, and each channel supports up to 30mA of current capability

	  inside,

> +	  with 2048 current steps in exponential or linear mapping curves.

-- 
~Randy
