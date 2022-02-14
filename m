Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55084B5307
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355033AbiBNORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:17:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiBNORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:17:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6619C2D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:17:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s10so13580989wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s8YquNU04gHjJdyZdqG6wS1fewBMA8c3UASp3XdZ20I=;
        b=d7/+3WHErfiJHVs7nuciZQLFuQpqn1uH0EnhAQvlHUfiv9Jt6LsJ/fYZJQrCxvL1p9
         OaMvHPwxZT+pPyLd6pRuiwyCeDygrpMmPrsuVUYVElbPTqmA3P1AONASmkaul1BqUXey
         8yU9vkKcJ4cyc2TQRGYpdDfmsupF5o4+76JbFGCIB+OSAFY2l6cjxqUBDZ5dceonEMS8
         ikLTTOPxFFMN+gwBSZ/Y8WQO5IDKI4F5ZoKXZqbeKGNPJMpUsz5XNMVKFLt7GpNLbQwU
         L0v7io0cv5YnIY07Q+L7ql3eZ/kgl7OoWAAFTvcyLuGrI8JvxHDnjwAGIkijUfhm2gIF
         FQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s8YquNU04gHjJdyZdqG6wS1fewBMA8c3UASp3XdZ20I=;
        b=38pS32SoeY/N51TZgfplI7UBOcA4Ha9gBLKd9TarlSs8QWb/tms6LpLVaEqQZzTFIh
         ht99qO33cpIUb2az8xyYUL2fpTtYBNMFpywVa/pMZc6xaiV3M1EuQ3lSZ6HFV/+klF2g
         lvdy+o89r103eb+Cl0eeqkUIdF3i+lkFo9sNJ8IbuQKR5kWXhXJSwtjPaMI7tJYxAqiC
         DgX+0xRHnhumlpWPzcYQZ7d2yH5TkHaVOlpJFM+HjP+H6ZgJ66cyJiBWEvz7OIk2GQn8
         4kaNC/ZSv5YTFBXkSwhdUtILchowaOwwBeZhQIdIRd4wYxYOOTs7Y34HkVn51RDGnHkD
         4suQ==
X-Gm-Message-State: AOAM5337N8cv1pWFGqoMUdPKJA4iBGtKh6In9qIdE+CXKPRxcQ6VPS+1
        klxwmG+oXuNCLWeSPLIVTn3Ths0s/hAKoA==
X-Google-Smtp-Source: ABdhPJzlbYCMwZF+I5AvIrwVXEqzQejiMLKHsGIY4lGCN3MuJQQ/7sRR0ojLKZAdCZqUhQlOsUbVfQ==
X-Received: by 2002:a5d:508c:: with SMTP id a12mr11574121wrt.379.1644848233876;
        Mon, 14 Feb 2022 06:17:13 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u12sm27136772wrs.2.2022.02.14.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:17:13 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:17:11 +0000
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
Message-ID: <YgpkZzMWuuWpK8Tk@google.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
 <YgFgQsV2bJS6mjQs@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgFgQsV2bJS6mjQs@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022, Mark Brown wrote:

> On Mon, Jan 24, 2022 at 09:23:44AM +0100, Krzysztof Kozlowski wrote:
> > Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> > controller bindings to DT schema format.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Do you need a PR?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
