Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1D56D83F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiGKIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiGKIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:36:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6C10E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:36:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r14so6037849wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lhEZxV0CVc3vFbTf4KhCIOA4IteCraY+vi1Ct3N+1T8=;
        b=ZoE3KzNWTSCCZKBhjlvmYgfaf1OALP27tOdPk6zGY0lFFO9RRrzXceCXIL96yK/Ap1
         nEPVZUzJknPus7JvLtJiRJBMH5qx3sFztwrGGnRPJoTaC+0QIdb1DoAnIvjwsMCSRQBx
         JMG0Nw4S/tibgYYuNrcRN44wn05g9kdUmFZCDdNCPeOEvz5KNiB97qrhoIu1wo5z8bsx
         85Dwf5tGN/mZ+irEj75PrBpO1JJ9v1G1pt6NWxUkogjmlbkWRdQYg7o2QhRoEsYOVhKa
         BVuX12yLZHtnqUOCbLl1qz0/MhJnM16Xd735XQNJjnPf38611jImJZNDCsnFusAsy1pd
         Q2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lhEZxV0CVc3vFbTf4KhCIOA4IteCraY+vi1Ct3N+1T8=;
        b=quFNQMVio5jMekkmpw20Id7hkkqud5kAYHRUdntP4Fozexc0q3E3afNxcnjmA3r6Xr
         uiWwZ5Cu6r0mwv1uaOPhU4n1FuNvp3ZaHmc9nI7Xn32+OEVwyvS64kX1nu4Vv2MFHY54
         39h5VAic+6K+fGT5NS7m9Rv+whWnfr8mYnlger35oWes36X4J5C51i3GVnUx9cBSPwAR
         y2GbT2uv9f7643HwJR2PUuZIIepMFIU/sHdyelVa7kBgl7kR+FInQve7I4r5Z5vLlhhb
         r2tQIdckOZh4D7Jve8dUWlOxRdOMBMi53RiHFODlYprA5IRo4ZnAA2sRtYx/IR9JSwes
         dNZw==
X-Gm-Message-State: AJIora8eptHh3s6XAMNNPshbxh6qsKerU7Qkfgqxat7onCQsXJ2QxAGq
        lTyeHSHZF3aJUH+HpTGbW6HXeocO5Se8nw==
X-Google-Smtp-Source: AGRyM1tDExu7j4sKrnuLBeMVegIjVgNh1TJ/Zs6dgd6hVz8MR6M5qk3v8JLmEkjf6A00yJKJGNy2IQ==
X-Received: by 2002:a5d:4c91:0:b0:21d:8293:66dc with SMTP id z17-20020a5d4c91000000b0021d829366dcmr16972958wrs.30.1657528612225;
        Mon, 11 Jul 2022 01:36:52 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id w2-20020adfde82000000b00213ba3384aesm5274506wrl.35.2022.07.11.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:36:51 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:36:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 06/11] mfd: intel_soc_pmic_bxtwc: Switch from
 CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Message-ID: <YsvhIi/+QYtekhQm@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-6-andriy.shevchenko@linux.intel.com>
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

> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
> 
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
