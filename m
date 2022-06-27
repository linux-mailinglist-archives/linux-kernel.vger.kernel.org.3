Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C408955D78A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiF0JW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiF0JW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:22:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77EE63C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:22:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n185so4982586wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iDWLedW+y5sHbkOUsgkqguWNPH+eoSjVnCEs5gXPIiw=;
        b=HjOh0Av3CrqVZjWNchikrkiaSxyZ8fMqeABK1FouIGD6ECcH1+khPZuCVoQlpu2J3S
         KWYRQcEYGiKQqbjJYozNx9mtK13Etj3ux6FvZRx4/ZhQgz1wtyG1P2Uhfihx67dTVKhS
         nmxxXtkVM5u3mAGBgDGEYZwedo6XojSuESuxX07iNOCsmsC+GmNmTW7R84gkSzlJC0nO
         Zl4ivAIDgxSIBNF771nmB2apB1CKThMiUcJsdtZf2s5UVVIfnEOTo3+uOM94/FOh/ewJ
         wsXAJeFAIGIZZUnl8TamOOXFDSamTtS9VLV/rq0bGwN5BFAiJmNRKItXVoduUgHZXRUm
         n5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iDWLedW+y5sHbkOUsgkqguWNPH+eoSjVnCEs5gXPIiw=;
        b=hX2h7WfrMAuLIoJvrehA3VeGueu+VAbykyTpBdiEejLWzEclVMRRTyKNGkgfEFVoF/
         d1t7VQQoJgytdZsAxr1Tk86C3YZVqYA2KBkCDRItCpOicXm1LH98HsxTS5iR1dXpamFW
         vRV8jGobtjBZS017Lfos+28MSKzjkpLzrxmuWI9uOnojraGm8iv4TP2D+rfpoxhfquU/
         7uOKOZA6YxG/pswlKjV1StzFPZ8wafAYJ4w4L+fB6kym4FVUKCSpLn8N00IR2IqnobYx
         WMA9PMe++OB4xsRe1QXGt072SuIG/mqIRy0NXT44vIp97txfPm46jlgWrW5WggowNzjm
         5D7g==
X-Gm-Message-State: AJIora/lmACGwwu5kAqhS4YTuof1aAW+XGf4yzIFQ1iU6SnBiE1mplsB
        pPFk1x5yJdRzBNf+VXyf8zPhlQ==
X-Google-Smtp-Source: AGRyM1vY1ciW7hsYcMr6YHoGDcNeZE/BBb4c2Yy203mjv0cTHWC1fqWWHMRmzYIEYUuYqHmMBWFQLA==
X-Received: by 2002:a7b:c14c:0:b0:3a0:4abb:a921 with SMTP id z12-20020a7bc14c000000b003a04abba921mr4061528wmi.100.1656321774262;
        Mon, 27 Jun 2022 02:22:54 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c19d300b0039c4f53c4fdsm21285924wmq.45.2022.06.27.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:22:53 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:22:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 04/11] mfd: intel_soc_pmic_bxtwc: Use dev_err_probe()
Message-ID: <Yrl27NNift+7T203@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-4-andriy.shevchenko@linux.intel.com>
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

> Simplify the mux error path a bit by using dev_err_probe().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 86 +++++++++---------------------
>  1 file changed, 26 insertions(+), 60 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
