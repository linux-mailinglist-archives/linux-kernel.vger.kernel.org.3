Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A004F51F828
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiEIJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiEIJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:29:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C722180C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:25:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so18542247wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=H+DsutZj1L+ifdMTMDgXzW8ycmvYXow7irv3R3N0G0A=;
        b=EMVg4qQf/QsULTjsrV0B3/wwtsJ9Vf60yiGAFh/5rTydM1bnxbv6hPXNIE/GuCENIN
         q0vbAv2ZGCcs1HtKiJuox1M9qD/l2M28yzb0yjVd+CMkkSkHA977QCHazwlls3m0Z184
         ZiH8eNySBC3/+JNrzj3pDmEg5NvtkNnTosNu/AK0lXNpQ+9kIRweJJBynlJs53Vn1nWQ
         SEuMUaaaIqkiU0gHNLr8IcQqqgNWo/mUSdzeCcYr1e7zN4CS9qay/S1vbyVD5Io8g2W7
         U7CGKtOoipiwPY3OiwTrbj0cOJGXPp/Ef5LbBjLXC9D3nxCur4gwoIts/3CilELEOV+C
         CmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H+DsutZj1L+ifdMTMDgXzW8ycmvYXow7irv3R3N0G0A=;
        b=wAMFLoUK1GcB+mpp0v8/Sup6KYv5ASFhEHpegc2f5INO5jbzCfQtISvR+LbnP5GRiK
         hyg/ts52CPUrOwfyXhk/QYgzobj3N8UC3QSQuYjVcjvIiXWoQd7GbIQQEFjned/WP0dn
         T2DGtt/fI9jtytOlC6lvAP0gk4mXUerVxLNKS65u/oc0v16uTQTwj2qQcf2LlLSbh5Zw
         Yf7uAmimvevajcCkMp+QcK2xijOoSfVwVjqOPZdNaiA7gNbTrqurYA8IfgD4eAUOqEer
         IP1iJcDclLUXcFHxDip2+iGImONa7bnEqdryK0bdqtnV7ZVk1ci/rf1hyVtyC7uu+wM1
         qMUQ==
X-Gm-Message-State: AOAM5302f4H7jPPS88Hh+hLbBHguagyADgHshlxgKV4J7AhFjXPicqKv
        I1YXUJI8EmafE9CMX6mK7vohOA==
X-Google-Smtp-Source: ABdhPJwRIgJEwabhbXHOhG62yNCJpaXOkH5nLrt212aoSggBdFxwKKAoFPKPI2PUu9Vk/jJ1E9iVmQ==
X-Received: by 2002:adf:e104:0:b0:206:109a:c90f with SMTP id t4-20020adfe104000000b00206109ac90fmr12894538wrz.259.1652088346627;
        Mon, 09 May 2022 02:25:46 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c339400b003942a244f33sm15854582wmp.12.2022.05.09.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 02:25:46 -0700 (PDT)
Date:   Mon, 9 May 2022 10:25:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to
 yaml
Message-ID: <YnjeGIGW6Pe1R/gY@google.com>
References: <20211227170151.73116-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211227170151.73116-1-david@ixit.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021, David Heidelberg wrote:

> Convert Qualcomm PMIC SPMI binding to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> v2:
>  - add #address and #size-cells
>  - add reg and remove spmi include from example
> v3:
>  - fix doc reference error (make refcheckdocs)
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |   2 +-
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
>  3 files changed, 121 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
