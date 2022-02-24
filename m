Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC644C22D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiBXECc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiBXEC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:02:29 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E421163D42
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:02:00 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so1698532oot.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C47SZnnj7WECDuYywW/3ttGfgdVHSBmqkuTNTlr6sy0=;
        b=wgHtC2xqvLpVn9xvxBmqgieyVAnVQx7kC2I6olcvde4IiGA5Z4XAaTUTu9u/DdBwLK
         t5fLCkNWes9Y7YQ15yGJX8DPWjXoBpJQCgvLsK+vcDTwyN53ToQkaB2ia+ZcjlDxPb97
         tFZ+Yg3ZJh5V6i6RfGhxHg0iX4mWoX147AA3P8UZOuRwf2ub7oF4dmm7mIXqj5RDHNn7
         NeSucNPDFQqlqEK9aOJOWWjz1oIpZImbPg4oru8o7EYgWEvshg2RCVLqhZirmSsZ8LHq
         Hk98r6+8ZBq05q8MNJJqcgpoYtJPL+mQS8uMffNOnpOioENmIn1fPUQEaDNH6e/Pmv32
         zC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C47SZnnj7WECDuYywW/3ttGfgdVHSBmqkuTNTlr6sy0=;
        b=QgyvDgLZcgOP241lI4Deme72ZMwJKsO2rlV19ySA+West56wami5DtPjY7BOMUJ3Iw
         pgUBYfQzDsdDPPK+J9kOZ8pLGxox6y1UwrufofWCxPLsJzLoVhAi6lCWbMO1ipuwOpe7
         oUKdoq3iqVQdGRPSsJGdbUlrvZEMAscltDjErwrwRke7eFvEEcHEZnYJiWgqWseMYJkk
         iHDM8k5gTgclt1ucWjUgFeCN721FGNJ66VfRfKI5XMAbiNa107ERcTsiRkjaDjB/YUDY
         SobpGgJl1+FOtAXAz+y2sQmZ8NGtpu1mIsQeyN/bK4HECQtoWs3qHdPWQW/iAkj+GEsg
         vBVQ==
X-Gm-Message-State: AOAM5324XqqLsrDlwvqE2Xaq/xTepoerYPXbxTExEed81fNubx9zumML
        8+7u6EDv8ciAuO9+Sg9g2WUMFg==
X-Google-Smtp-Source: ABdhPJwRTIhc2pUV92EutkmS/7Hg8M5b85r/Ho9yqDpZXPRCP+sSPj++3hAKbZ0FJffQTa20D2wzhQ==
X-Received: by 2002:a05:6870:2892:b0:ce:c0c9:6c6 with SMTP id gy18-20020a056870289200b000cec0c906c6mr5355157oab.280.1645675319819;
        Wed, 23 Feb 2022 20:01:59 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id a32sm1023981oaf.10.2022.02.23.20.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 20:01:59 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:01:57 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/16] dt-bindings: reset: add ipq8064 ce5 resets
Message-ID: <YhcDNW7Ylg1GRglG@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-15-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-15-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Feb 17:57 CST 2022, Ansuel Smith wrote:

> Add ipq8064 ce5 resets needed for CryptoEngine gcc driver.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/reset/qcom,gcc-ipq806x.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/qcom,gcc-ipq806x.h b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
> index 26b6f9200620..020c9cf18751 100644
> --- a/include/dt-bindings/reset/qcom,gcc-ipq806x.h
> +++ b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
> @@ -163,5 +163,10 @@
>  #define NSS_CAL_PRBS_RST_N_RESET			154
>  #define NSS_LCKDT_RST_N_RESET				155
>  #define NSS_SRDS_N_RESET				156
> +#define CRYPTO_ENG1_RESET				157
> +#define CRYPTO_ENG2_RESET				158
> +#define CRYPTO_ENG3_RESET				159
> +#define CRYPTO_ENG4_RESET				160
> +#define CRYPTO_AHB_RESET				161
>  
>  #endif
> -- 
> 2.34.1
> 
