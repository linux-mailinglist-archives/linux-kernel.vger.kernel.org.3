Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68AD58CBE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbiHHQMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiHHQMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:12:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53544FE3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:12:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so11428663wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dho4Ayl/GEJOf2L02KwE07TOrtiAKXs0/TIu1wwIUVg=;
        b=XvmA3vVo7GmCMwv7ALNPB/cNlUd6xc7cTqhUdihCEKfJJ4HgA3VXHNmN+b8MnVGjvp
         ntEYrRohK6ryovjHqTQn6CSl3OGnvtK9ozwpKqrlsF/7se97DZ2ZQ9IVdVOCEUL0vfer
         P/M+eUwAO/KsDOU85EwoByPqusuVhfMz6s23bZhi2k7nlzNWHVs9UBISIrFgb43gAgqd
         nbR80gkLN8jY3EXbgt7rc7khd3i01Aw4WAiAh070aKBdiyHSjXB9kryqfaXDyMQ9wEaG
         GY8rqyHix/1+GQPDnCLVKhj7ZhWPubWO/89McDFnioEZvv84hdbn+MKOxLEKB4HY2+Ym
         IFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dho4Ayl/GEJOf2L02KwE07TOrtiAKXs0/TIu1wwIUVg=;
        b=eIQ7pWz1RLcVHeRAwpWnotKs6WGcwpXq9ZonOakLqdBzJ0RLguW057f4mjz5KDQHMF
         78i2UZuOwOGjUCra2iy1/2Y9377q5ZjjqV/LLmT3gBAU/2reY/tzVthg+it0loQdENVy
         zVrHDtJH9l8i5e7aTVGJh6TRuiVP42lLmQ3XanAd2d7U5Da2K2E4ILWOV+gD9VoGZaY/
         A3SReNjfWE7n+StfDQ/KxncrYfjdqLzbijFtoYUG1dCMUNPbxwT9h1tQVZB1Q6wdFWgH
         sh+t7JTBxVpZY8BXN8fmgaPWvkPHeYftzOX0SPK96XIcM9wJYaTdeNRZr8ns82bpNNrE
         Mdow==
X-Gm-Message-State: ACgBeo2H/8taKu8bQmYD6W5ZqTSDiqcYx1JoDZ/i+fAWgLhQ8dZpoRvB
        gEgcWGCaec7om0AlZp3PZmqufA==
X-Google-Smtp-Source: AA6agR4HjRptLDnEEnkwxUibw9Sf5aSrc8JhTs47KXmlnyBtHwwUtes2IPPtWzARETmJ9iTxafo/Zg==
X-Received: by 2002:a5d:614e:0:b0:222:c091:9ce1 with SMTP id y14-20020a5d614e000000b00222c0919ce1mr6098544wrt.232.1659975132874;
        Mon, 08 Aug 2022 09:12:12 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c424300b003a53de38c0dsm5124142wmm.14.2022.08.08.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:12:12 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:12:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 04/10] mfd: intel_soc_pmic_crc: Use
 devm_regmap_add_irq_chip()
Message-ID: <YvE12gpy0OkJF4rr@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022, Andy Shevchenko wrote:

> Use devm_regmap_add_irq_chip() to simplify the code.
> 
> While at it, replace -1 magic parameter by PLATFORM_DEVID_NONE when
> calling mfd_add_devices().
> 
> Note, the mfd_add_devices() left in non-devm variant here due to
> potentially increased churn while wrapping pwm_remove_table().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v3: no changes
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/intel_soc_pmic_crc.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
