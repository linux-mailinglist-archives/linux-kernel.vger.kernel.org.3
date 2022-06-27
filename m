Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F0A55DC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiF0Nn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiF0NnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:43:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D360C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:43:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q9so13134662wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pugv1+lQ2+Z0Hg6eilYLMYL9WMgHFKUW5D017ff05Fc=;
        b=pleyBUZVqIjaCSPpk2fKfg2Pn4KUCePCzaHKZwwOYEf0+rJuc2d4o4V8vvn6bGun4b
         jpT2SrMF1xvPWXWmevd4el9Mvu++lJTB/nu6IZcndybD2Iw+aXIuXCSnn2hL7epsHkqx
         6DAI6eRhPKg3vENsen25vcoBPTd5twvQpsSx4O6B0Wb5DalzUeRMmLkJqTH+88lY4SCY
         oeVRGk9LPIlZyFjjP1OYwnN/k6WSCJKA08uaMxPmm21plah5+hfbfJVqwt0oij0xoTBR
         MPN/K8LAbKMER2EWI9kCwv7bGVtcqYLSyXodRvcqKhmzYgBxpbyVdAi6+XBLtTTtmV/t
         puSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pugv1+lQ2+Z0Hg6eilYLMYL9WMgHFKUW5D017ff05Fc=;
        b=wMEJ3qSy/DkKrYDKwlnXeli3wtKgPXplb6sdI5h1FK/SU5CCAGltFQiZ2HTkz9Fmek
         6cURtpEOx1boTaIAC7vL9LzzYy9cubrIHnQagypdCKo7KExBj+Yzw8bQZ/0HofsxELQi
         zOoq+VkutWGCn5HHyjGqKaPvHlqCZ+PKyjAXja8NaqAkH5PtUDN2MKV5IqwgRg6dNxOF
         +1txrVheChfsnVJYAdoJPO6J/ePsuX80MFD6DbM/lKrxq2xhtcHEJnc3G3kWdACjibFp
         4IHrAPU8KgJKZr8Bu0Y/cTkE27Mai9vWPJl7NuhtxtoBara1pThdzagFa3RSCvGXNK5/
         QstQ==
X-Gm-Message-State: AJIora9TmHUop+dTRzYy5jXZNitUVCCVwGwj5Bb9GVzAizDxKeDcRYwE
        +CXFUONoIz1kemMEsEtUEQ2jFA==
X-Google-Smtp-Source: AGRyM1tD0IRFBBs1M1XkqG4I+Xd50X6ZXzu0XK16n+cSANdvlmfIJ0Yfk57+Dv1jXOrJtoXKdGedhQ==
X-Received: by 2002:a05:6000:9:b0:21b:9ebf:54e4 with SMTP id h9-20020a056000000900b0021b9ebf54e4mr12867953wrx.658.1656337402846;
        Mon, 27 Jun 2022 06:43:22 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y3-20020a05600c17c300b003a0231af43csm12485277wmo.48.2022.06.27.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:43:22 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:43:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 7/9] mfd: intel_soc_pmic_crc: Convert driver to use
 ->probe_new()
Message-ID: <Yrmz+Fh2IwjkuQX3@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-7-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> Use the ->probe_new() callback.
> 
> The driver does not use const struct i2c_device_id * argument,
> so convert it to utilise the simplified I²C driver registration.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
