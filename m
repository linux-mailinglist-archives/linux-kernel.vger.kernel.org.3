Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBA56D7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiGKI3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGKI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:29:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A56177
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:28:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so5985023wrr.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lhErg+mgjDKK6031KpBEO5ycdfEnEJiCfcEvhof4/G4=;
        b=s463ynAHfFBi3ykpC351Ih/5k+I5wXVuxg8SkcRYuOA/i+nvRcKBeZgk4XZcq4fPfl
         Z/OTQfJV8+a3jNk3eGqpY/m7e1RZJVVVDw3MO+EA/zaIcch1zD+ZHlYmidmOrvWgj44i
         tc/vkSKAE5IdnCThAKVAPZ5JnUbSQlmGnwa2fJNP6TldUZSYRtBAv4nOAc+AqExusvZj
         tDu70KFdZrtw0+3zt50gDjZ5xLYLqun5Xq+GBfk6aiMzucxOdj5abKKVWYouHvWXDs0q
         PDDyV9KcIjkaN66HvIGDqbKvxyS+r6c6L1O/XYad4iH0nLy0rD7RnyLuU4MHeEcUqaVU
         s7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lhErg+mgjDKK6031KpBEO5ycdfEnEJiCfcEvhof4/G4=;
        b=CmHqFyEIP4oCh2YGo/QGL1xBt/XtepVWTdBGVK8+qMrzW2p/pQmqZ1swzHjm5Qz+5X
         gWV73NUP5SJwLEIgj2bOcLsh/0ORSJuVtcJC3wXeYMkFK7HGx9pprf4WYPupzgWWVgm7
         sEv9tXRvNSsPcEJDCDzvHkNFgAA92Alk5jCUoVd+/SrEgGcMF5+c5RShX3zSJ90NH9Td
         SahjvrJQu+4/ubRNuSB8LatQov0Tz+70fFdmXlLCbW52agwkBOAl4t+3WryDAldeYkZq
         +ld1LtveOu4Zcof9vEx6TeDlOX5Old7obB2XcGiXgJm/oZo+Fx99QqsnNd16PBcApJpS
         F9gA==
X-Gm-Message-State: AJIora/+Wi8jPrpX/Lxr1bAr+9L8ataz3nc/QZhnowOcjxdmgttW+BCH
        z9lZLtcuW2H8+BknzRtfGRzNY5IHdyozrA==
X-Google-Smtp-Source: AGRyM1tSnwLhKzpEJKM4c0SI9kR4+Z+OSOoPCtORKdWGRH3PzqTce3oLls2sq0w3wO9uARpN3p1+bA==
X-Received: by 2002:a5d:5601:0:b0:21d:7174:7e9d with SMTP id l1-20020a5d5601000000b0021d71747e9dmr14790624wrv.209.1657528137734;
        Mon, 11 Jul 2022 01:28:57 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bj22-20020a0560001e1600b0021d60994b0asm5257941wrb.100.2022.07.11.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:28:57 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:28:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 03/11] mfd: intel_soc_pmic_bxtwc: Convert to use
 platform_get/set_drvdata()
Message-ID: <YsvfRyEXrdnJhp4T@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> We have the specific helpers for platform device to set and get
> its driver data. Convert driver to use them instead of open coded
> variants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
> 
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
