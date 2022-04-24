Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6378850D3EF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiDXR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiDXR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783AB14A52A;
        Sun, 24 Apr 2022 10:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3AF611DD;
        Sun, 24 Apr 2022 17:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F9DC385A7;
        Sun, 24 Apr 2022 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650821197;
        bh=m5K1CAlIgKUcTraXvTdW80/ApODzmf3pfeRT9NcxNow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m4TTBpumiZz9pzE1FX+ezyzumuijyP7fc1d3H0r/QJKAxMAU4OwxPZ88xMgnWV2l4
         koQvt5EZ1T/nBMFC2DZA5PHasOc+3pesmeVjPKmAU3T/2zKby2KkXESuh4l2xfzwFC
         YIX1w5QhcACG9AUIJb1pl98stVeFQHNo7Y2y3OG/KnQvd6aW7omtOITn6zXDl+dcw6
         AKqgyeZoBLF3xFopN9yqRB5xcTemjoJv/spmrDH7DGoSSO4AVPu8b7FQvNkU3SrVUc
         8xw7LLig2sRRHbxD3mmWsot104HD7devoCKYFe+qwXFhQBg+iiep6zzr8pViCpvlfM
         rko96J9N5Z3Tg==
Date:   Sun, 24 Apr 2022 18:34:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/7] iio: adc: sc27xx: adjust structure and add
 PMIC's support
Message-ID: <20220424183443.2382ef9c@jic23-huawei>
In-Reply-To: <20220419142458.884933-1-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Tue, 19 Apr 2022 22:24:51 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> this patchset add a sc27xx_adc_variant_data structure
> and add sc272*,sc273* and ump9620 PMIC support.

Series applied with the minor tweaks I've called out in replies
to individual patches.

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

> 
> v2 changes:
>   fix dt_binding_check error
>   adjust some code-style issue
>   optimize the copy-paste functions
>   the smatch warnings found by lkp
>   and  ohter comments by v1 patches.
> 
> v3 changes:
>   fix nvmem-cells Items value and add ump9620 dt sample
>   add the correct signature for each patch
>   fix the unused warning in 3/7, add explain for set the scales
>   remove duplicate code,add goto label in sc27xx_adc_read
>   pull out the refactor code into a single patch
>   delete the suspend and resume pm for ump9620
> 
> v4 changes:
>   Add fix tag in the 2/7 patch.
>   Separate modification and refactoring 3/7(v3) to 2 pathes.
>   remove the pmic_type struct instead of a boot set_volref
>   to define the specific feathure.
>   use switch statement in all scale_init functions.
>   remove ump9620 pmic support in this patchset, submit separately
>   in the next patches.
> 
> Cixi Geng (7):
>   dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
>   iio: adc: sc27xx: fix read big scale voltage not right
>   iio: adc: Fine tune the scale calibration values
>   iio: adc: sc27xx: structure adjustment and optimization
>   iio: adc: refactor some functions for support more PMiCs
>   iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
>   iio: adc: sc27xx: add support for PMIC sc2730
> 
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  59 ++-
>  drivers/iio/adc/sc27xx_adc.c                  | 473 ++++++++++++++++--
>  2 files changed, 491 insertions(+), 41 deletions(-)
> 

