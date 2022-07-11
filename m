Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56356D7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiGKI31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGKI30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:29:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5771EC4D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:29:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so5998920wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VXrYntnPTd8eD5cTT+KzAeDOqk3D8uGW/zDOW/9+tsM=;
        b=kvqgzD+kMVngdM7Suus4K7vFoV5ktAmcBoaoJ6VcqliX/NJzRAHYuoGL52ogkiZb9o
         IAzij5Ly1lzbKcSn/eeQ18wE2GGT3wFx9Ba0uJIJzhsHeIrYZG1la7lpHTgimIhf553+
         2M8hQNycMxftth3NrrzyOZayfcbmsO5PuuZZJZRtgEavXwBtXAhJsireqZWHrVaStjrS
         sHJDHjZNb7nzwnEEkrA6lPLVVo0vGtXHqKK3+V1BnLS/ryUTlHxF2phIt2qWCDVwgdFB
         /7vOdiLqfru1meItfHdGC4qgPmkGqzLPcbe4PqHNKlW56li0KuaInoVhhVKveNRPL1oO
         mz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VXrYntnPTd8eD5cTT+KzAeDOqk3D8uGW/zDOW/9+tsM=;
        b=gge2vSEMPoXCLPItTfEBiltcJli4UCzMYu1upwCqK+qRWPFoj6MZbOZCh+Dj4CCTgG
         O/50da8XyRchf6SytzXfjuG9K04MS6jUyWofRomzdpcOFiZOKAsXzAOWhWsh7sfEpZqv
         t1kdkQHz2GEeLdDvsS9r8+ihjUJRN0OLip4n/CJQB38Hy1IA+QkVDqC9SvvsnxNY3n73
         NhuFvAp9KVAsgyvvOC8SqUizq8enEdQ0HtWx4eyws5Mt0/XT8LsT2mhvbjODjYjU/qkx
         PRym64RHmaA+d2u1j7ymPN/I8dMrIZ+xL4QOig/5OpwTHht0tWlhjkU8pWb9bq3Sz8ao
         8uRA==
X-Gm-Message-State: AJIora+hGcvif+Htgy3X/G0mZO8eZAvxxGUaV5oQBdFLXzT7rguK2ZN1
        Bf+Ys3cagaPr7o3Hl9tb3pGV/Q==
X-Google-Smtp-Source: AGRyM1sIB8QqpdZWVZv7JssAYK5KdQ5biB8YTRA1MacHbtPhctmIXcQZvo9QeOxbzstb9PwK0LFy7Q==
X-Received: by 2002:a5d:5261:0:b0:21d:8457:4de with SMTP id l1-20020a5d5261000000b0021d845704demr15960798wrc.341.1657528164118;
        Mon, 11 Jul 2022 01:29:24 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5944000000b0021d4aca9d1esm6131775wri.99.2022.07.11.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:29:23 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:29:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 04/11] mfd: intel_soc_pmic_bxtwc: Use dev_err_probe()
Message-ID: <YsvfYteD6mPx/RX+@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-4-andriy.shevchenko@linux.intel.com>
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

> Simplify the mux error path a bit by using dev_err_probe().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
> 
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 86 +++++++++---------------------
>  1 file changed, 26 insertions(+), 60 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
