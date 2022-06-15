Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F216154D3DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbiFOVkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbiFOVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:40:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E744A3A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:40:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w29so35831pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E9ERFJfmycetiewLsnmPEUf5XGwsEH0WUvIwEqLk+7s=;
        b=ttJN/MGyhYY6DGazXaoQqpX+PSl81iONtGWiRVGGyQJycYL5aAU4x+kKpmRyu0Hsjp
         fcUFQA9DPiXWusNHCI5SwF7dtfoq27GhyKYZVRwPUVp0xl9q2wR7jB5Y5OhdoBwYwmVg
         s2pkhk/gEkd1GpbOqbgtWYk1Y6TGaibyIW9ZhgaDSO0cHHwqTQbYZkQpPxW756AFy3Y+
         7Px/hNO31Ei4BRE9FubcBHP9lSEuAUgIkR83rVGTvBbF/pB/TUng+UFCC5DxawNkXYP2
         /U2tvrhwk6VncuD77fjMrRKzkv2Yv5n9YnSw3j/nKRVKCCo9yCyqJoyc4A7yFKm1wR5z
         kmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E9ERFJfmycetiewLsnmPEUf5XGwsEH0WUvIwEqLk+7s=;
        b=lN5DTnFoEfw/IqI+hDKIXiWr2vCh5m4UYh+7U8xhdm3D8UxTg7zzZ6Ek2Pa5A3o1R4
         Od8dHXDizaxfpNo07KDwQev0YpUwTC7VqeQGZ0pP59a3fk63DKv3KmfWIB/DKMySOqdd
         nb0LFQ9K3uzLTg/4wsl3L3q/nK3L70HLMi0JOTVLpI7WBOJWULs3thHCBqDL+jgmpD+Y
         uVBgW3OBCGt7A2UvoqmQYKRqwT9lnivC0KakjvxGHtsF2ZpnDW1x4D41+yb+1i/Pk6+q
         hqSwc/GfJgCdG7y3fU3ebtzOWxyWP7r0qq/6AYcvDl+/8DT5vLcAHxv9OPtzxmSE1yC4
         9OKg==
X-Gm-Message-State: AJIora+rpKVZNZTTo3BnyBag0NNRpZj+pKur/SOI/9dL6X9jJV5GyUxl
        MkWs3EExUJvhIQ6w77zBXOVmFA==
X-Google-Smtp-Source: AGRyM1sMKXkKuZQnP6khsj5hB3YYQDGwcOOc6pFBBPKzk2thLFoH4KcLdt7LufAaCkTq/ji06lSuFw==
X-Received: by 2002:a63:fe49:0:b0:408:9928:44da with SMTP id x9-20020a63fe49000000b00408992844damr1516490pgj.373.1655329239625;
        Wed, 15 Jun 2022 14:40:39 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a5d1100b001e0d4169365sm2330350pji.17.2022.06.15.14.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:40:38 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:40:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v14 03/10] mfd: qcom-spmi-pmic: read fab id on supported
 PMICs
Message-ID: <YqpR1FmubmQPHzXV@google.com>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
 <20220429220904.137297-4-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429220904.137297-4-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022, Caleb Connolly wrote:

> The PMI8998 and PM660 expose the fab_id, this is needed by drivers like
> the RRADC to calibrate ADC values.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/mfd/qcom-spmi-pmic.c      | 7 +++++++
>  include/soc/qcom/qcom-spmi-pmic.h | 1 +
>  2 files changed, 8 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
