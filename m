Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8B4C22CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiBXEBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBXEBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:01:46 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ACA25D258
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:01:17 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so501555otl.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RPBh5QvRvQ76MFJIjmBhbU4YJ3EpkpvomZu3C1exFBk=;
        b=S2RBFk1Nhcd/PgqzBcu3n7EEPBGXVyUDQEGzZim9bquciNRrMHMOA7Ir6fT+NUGbi8
         U5dzX5OEA8DtBxi8Fj/Stw17bIqk52i3DlcjCrK3AOes4Fx0IvKBuSKt92imHvojfOWX
         luk2JiKSyxR4Z/a/4QExJ+Qx7H6rBpamjXzdzHXm2YwLdVoz+fwMsO9FYBdVvkBz/rIj
         yQegj8JhSG4CsnmMedfFc/uhZX/8bf+FZDb277oc8iuL3DOdrFhi1uqt5q4eTUOwf1P3
         pYPsLfmgzkNXo8x8acZR/mtFiMpuR76ff372uz4wj5+BL6mitrRfDL7uqhddU8yQZP7e
         KieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RPBh5QvRvQ76MFJIjmBhbU4YJ3EpkpvomZu3C1exFBk=;
        b=SGliz4bwqU//6MggVpe9S8BfzqPIuudrQk0k1mV7DOaan30SVq4bwtJkYl28ZMWA20
         UOQMMnhkKrtxCny7UPIceif3fIP7i5TD6mqc1FsW6wwSkTyom1yBuxfq760wh8AThg29
         QUrP0KPrPWdIs8peVUfhA49u5u6rH+oMlTzBrCGoVN1s3GwSrByoaen//Nkrz0RN7WzW
         Rk+bOyS9laibdRwI7ybya2Zpkv/H3qYg4xrdYhtU3b5+u2wUdcZTkUZUw3qahM44Bef6
         qPIZqOUYIILBaB/jrH9SDPSv/TTr4+eVr5jyY4dXC+4T8i0oTgW0+LDha1Oj+6mpVhvA
         aTrQ==
X-Gm-Message-State: AOAM530NaHRBaJwjq/fnnudodlZqf8QkU4eJjBHFD1BhFj8Z2wEqq0CT
        sJoT0Cijkad1IlT4/qEkLLYhgA==
X-Google-Smtp-Source: ABdhPJw21QcCeH/Of1Vl1QVpGrnoUDzHjaV0o0z84SXiiQkRKiiPfy4c32mjGj1BunxOE6GtLKy2oA==
X-Received: by 2002:a9d:6b8c:0:b0:5ac:fdf0:df66 with SMTP id b12-20020a9d6b8c000000b005acfdf0df66mr261446otq.199.1645675276724;
        Wed, 23 Feb 2022 20:01:16 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14sm909100oae.21.2022.02.23.20.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 20:01:16 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:01:14 -0600
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
Subject: Re: [PATCH v4 12/16] dt-bindings: clock: add ipq8064 ce5 clk define
Message-ID: <YhcDCnMFRppk3Mo+@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-13-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-13-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:

> Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/qcom,gcc-ipq806x.h b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> index 7deec14a6dee..02262d2ac899 100644
> --- a/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> +++ b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> @@ -240,7 +240,7 @@
>  #define PLL14					232
>  #define PLL14_VOTE				233
>  #define PLL18					234
> -#define CE5_SRC					235
> +#define CE5_A_CLK				235
>  #define CE5_H_CLK				236
>  #define CE5_CORE_CLK				237
>  #define CE3_SLEEP_CLK				238
> @@ -283,5 +283,8 @@
>  #define EBI2_AON_CLK				281
>  #define NSSTCM_CLK_SRC				282
>  #define NSSTCM_CLK				283

You don't like 284?

Regards,
Bjorn

> +#define CE5_A_CLK_SRC				285
> +#define CE5_H_CLK_SRC				286
> +#define CE5_CORE_CLK_SRC			287
>  
>  #endif
> -- 
> 2.34.1
> 
