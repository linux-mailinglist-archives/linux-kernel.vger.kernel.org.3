Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982055AD588
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbiIEOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiIEOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:52:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF024F198;
        Mon,  5 Sep 2022 07:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59A3BB811DD;
        Mon,  5 Sep 2022 14:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D0FC433C1;
        Mon,  5 Sep 2022 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662389537;
        bh=rynh9eHuLGphHuv8tPFUM/cZZjVJWwRhNLpk0/cl4+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSa8k35lZL5Q1rhj8YVYVo+qhBs1A97IeEHn6BRCbkJfYZBtLLY6VdlKbcDa8ETF5
         iUNhu1grTL1FmI/dCurZ7ijFmFglQBAeCxACjBYVXCnfk4z1oTuzKg7E9LK3xu6+vG
         UfPn7dr3vqy3yiPXw8DCUcPIVCCfSZ90QFQTMzvKZwLlhvEeX9MdJ1Prtqkhx2u73t
         ocX8N8ypflA7V07DLB6ZXqo5Chhf2hs6K++Q9pOC4Qu/3z5pebHTi3cNNOj+OTV2fe
         q6b4Uy87Ddzo0diJJ2dAjMd39eO8sfc+Q2XSXDTDqxxkWV6tJ2R8mIXyhUoSLBa7X/
         R+ROt3qQupl0Q==
Date:   Mon, 5 Sep 2022 15:52:08 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 14/14] dt-bindings: mfd: qcom,spmi-pmic: fix TM ADC node
 schema on PM8998
Message-ID: <YxYNGLT1X+5AVnBN@google.com>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
 <20220828084341.112146-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220828084341.112146-15-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022, Krzysztof Kozlowski wrote:

> There are two bindings for Qualcomm SPMI PMIC Thermal Monitoring ADC:
> one for ADC HC and one for ADC TM5 and TM7.  PM8998 uses the former one,
> so fix matching of child schema:
> 
>   qcom/msm8998-asus-novago-tp370ql.dtb: pmic@0: adc-tm@3400:compatible:0: 'qcom,spmi-adc-tm-hc' is not one of ['qcom,spmi-adc-tm5', 'qcom,spmi-adc-tm5-gen2', 'qcom,adc-tm7']
> 
> Fixes: 3f5117be9584 ("dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.yaml           | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
