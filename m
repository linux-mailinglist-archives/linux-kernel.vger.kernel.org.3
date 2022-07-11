Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E156D81D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiGKIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiGKIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:32:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A61F2EB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:32:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d13-20020a05600c34cd00b003a2dc1cf0b4so2576725wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kq6G3iA5ux+doUXuphSThWAktBBd0VhjVl51MoYBJKU=;
        b=Ae3C9lAeMmA60OykQ8m7tZ1pWzhGUN+zEk/awrauGSEyebYxQywVN7262hfEo3ZMuj
         nF26SlMcZiX0r3wIKXwSVXOiwgN1nWghCKOW7pHIgwh/Wx4murvGuPbT0/sOLBvP+T1S
         mxN0H3KcF9AdaT26SsuMYfY7Pt6VV9TVQEKNt7/mSXpp6etlhO26yYZcpRHluwALJNEs
         8w9/LwXsL1KQJudcYZr4Z9KG1ju/CB954WVvSQazXei1cLzKC3hiiJs2UIVcqHBHV2WP
         YC77oYJdHTqwPmr0NR5DwSqb3n5OuTxfLxAck0TQ6s/t10m0eAaUEKM3zdKM8LwV9AW3
         uHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kq6G3iA5ux+doUXuphSThWAktBBd0VhjVl51MoYBJKU=;
        b=l4FGhU0Cl0jiDIKD2IEpGDNHpdDCXnzSuLyJDKdrpHMFtvHphaUI6TRFDpJwvI25TZ
         p6T6usvnPcqqc+AYg1WZtLQvWRRx7b0IK2ZwkPT7cFL+khBDPrycH7WSCiY/Ypv4KPTj
         Go/kEmxtYkVUUPTr+9OsCxm8Iq1mq6IhchxAFmWgtT/soCdgpJecA6EGX4FzJjouoL9k
         aHZZk+iQca6vJLePgbm7yj2W5uun7td2a46jfa3zPHqyULiOEkz9NaW0C+gx09J/K6IO
         4T0jwSJHOS49rbUAt4KFnr+shbyRkKu4bYKBK8x20J+KUL4sR4KegKAgAfnDw0DAU6PO
         4O6g==
X-Gm-Message-State: AJIora/deSgoyHMtaqCqKg0Hmnqm5J8juz50FdZ7FayxTfFogzR2aGCi
        Y90SgKXaHSr7KxcMleJV3fyjYg==
X-Google-Smtp-Source: AGRyM1svok92gNsPEHyCFSh2tajG0AHCkjmsotsV/wL2lS/OHBFPDKy1P/N8ZBHuNm+aUfB9n0zuIA==
X-Received: by 2002:a7b:c310:0:b0:38c:f07a:e10d with SMTP id k16-20020a7bc310000000b0038cf07ae10dmr14941336wmj.110.1657528347939;
        Mon, 11 Jul 2022 01:32:27 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d69c6000000b0021d69860b66sm6495082wrw.9.2022.07.11.01.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:32:27 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:32:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 05/11] mfd: intel_soc_pmic_bxtwc: Extend use of
 temporary variable for struct device
Message-ID: <YsvgGaM1ZPaHFejH@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-5-andriy.shevchenko@linux.intel.com>
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

> Extend use of temporary variable for struct device to make code neater.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
> 
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
