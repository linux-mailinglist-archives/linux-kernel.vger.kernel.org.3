Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB204B53AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355322AbiBNOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:48:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355304AbiBNOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:47:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D94B87D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:47:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so11773849wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VqFIbMHS9PJxJt/MmXCU6mhg8T/EbdtODuacavlxAZA=;
        b=Uz8HM22G11OlllXpa0uJQqZlDsuee2x2w569q1vQbJJNGHN0n8s3+O3Qxy+ArdyO0E
         aQ2c3ueo8s1I4EZUiiWEJMFXJCPnXTJ7LytcJl9bpU1rCz9AcmB5Bvaa3eFIV+SuBgj9
         rF9oxfaHfyai8TbI7eQeSmcAQBqvtDU08l4pIScZ/Ljv/kONmmqeUkq/yaQ5dgRTAZPU
         yxfnDeC+nyrO1rdGY8VJ828QgVwci3oko+UGmqSPtHpd5flkrLtmW2o77PclYcR647Rj
         Ut4WOyhvdJQF9McJTPTWpA1LpJhi2k9YX2vT4E3mKZkYHHBxOuU3uKWDn5meuSOGzP/s
         cQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VqFIbMHS9PJxJt/MmXCU6mhg8T/EbdtODuacavlxAZA=;
        b=E4Vimv5wcxvgcGNkN7IjYJaxMMz3DFdkFCfexme+pufbGbRoDFM7Qc4gZ5l6HqFSxB
         gwjAGr/6oEfvYwe040gdJmndRyRr7/Yr8uLe/RMTAWcTPxLquztsvd8IMr/u4dG6hvl6
         kwqoJvb9wY6JQRCLoAhS6eFj2tWE0lSNDbQRDxlCLU2vwyeN/8e+UQpBEtIi3GwESU4X
         DsUdtnFilJTJRyohkpr/ho7riz6ADJ6SDFlCqEkkuBixtQYpdJPLZBPazv3u8JXR+9BQ
         NMftLAi5jM2SI/CVZO1Xec4VbudTim9Q+nCV700JTAhO5P/lskf/9n4CaqNR8YqnU15W
         adug==
X-Gm-Message-State: AOAM533HNWTxHx7Ao5SmjTutXlK10UmDRCE+tdorKbHj3zJQTvTPUUPt
        F022jZmujZLRgJgS3rsUF1YiVQ==
X-Google-Smtp-Source: ABdhPJxSw1FwkKhmXDhcwO+z+DvJYTP+fXzHbCfXunNctoyfkj9UEuX9KbRQKkkrTHVeacjS2FzjHw==
X-Received: by 2002:a05:600c:3583:: with SMTP id p3mr5799657wmq.69.1644850069265;
        Mon, 14 Feb 2022 06:47:49 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id a1sm30331629wrf.42.2022.02.14.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:47:48 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:47:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 1/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <Ygprkl4sLrW6T+iD@google.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
 <YgFgQsV2bJS6mjQs@sirena.org.uk>
 <YgpkZzMWuuWpK8Tk@google.com>
 <YgppwvQwfJ1xycvT@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgppwvQwfJ1xycvT@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Mark Brown wrote:

> On Mon, Feb 14, 2022 at 02:17:11PM +0000, Lee Jones wrote:
> > On Mon, 07 Feb 2022, Mark Brown wrote:
> > 
> > > On Mon, Jan 24, 2022 at 09:23:44AM +0100, Krzysztof Kozlowski wrote:
> > > > Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> > > > controller bindings to DT schema format.
> > > 
> > > Reviewed-by: Mark Brown <broonie@kernel.org>
> > 
> > Do you need a PR?
> 
> It'd be good to have one in case it's needed.

No problem.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
