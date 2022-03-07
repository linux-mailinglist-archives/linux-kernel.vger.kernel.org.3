Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434954CF484
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiCGJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiCGJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:17:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC1652E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:16:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 19so8483344wmy.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uGD0AznMPULr9/ADv56wNfWTzUyQ3OazhFS/p3ygy5E=;
        b=pwyUaw0ILKRgOjztCGvamksWmJ0ZPFcmF/3c9GBy97o2+lgD0923QsRvpXQni5mcPy
         xo+u2jlQRKZuue76ppcjOeHvdhkMehK0eNIZx3E5WiklQs5czwaiP1tvwcucHFlKp5aw
         qXNMSzG40iyGG3+kv8mBaT6wF4tVAm0wDmtMF6NYnBHTtF7DXfW/f6yxGHv2Q11dZNLy
         ECARApJp6vbJl4ejMR/siE8oA2X0c9tsA4YyxaK5By7GoyIvQ9kHGu38q22Ka4n/pHq+
         MMFlnNPTVbVDHSip/3iSo3QXgzPVSkpwsBeiBKrVZqS/c7wILZ8QJy8Zz6BoYF6f6aMw
         a9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uGD0AznMPULr9/ADv56wNfWTzUyQ3OazhFS/p3ygy5E=;
        b=rrb22KicBs/0O6GDfh5//Feq2awxO6xuK0XDLCkJWKc49AKDfBn2tq9CAcMZQXz+sP
         F8GcajVCjt2aYq31YdcooppfMT+UzD6rgFxgVx8Va8uiZxmn2VAWc4D3HJ8yHcXOCaZX
         6Q/LvceWCQYL35IeWiIsgHoBQ572zKxPvnVOJNi1DHGuynh6FdKVrGbizb249be+0A5Y
         tJxcCMbpWO4Q8Q0/++8jxgw3kD7mQkQTg4QhGk/mLMCGpcBUz5UDHvDFsv2x0cbQG53L
         GGdpvQZcSayaE3lT3HaopzkeQjqNNxZn6uDqOMOXUtXfbXW31aLA552MNwCp396u9P4e
         PPfg==
X-Gm-Message-State: AOAM530G55xdsTJ0ncfRcBtheRaEmQe7+inZzVQLjjxQ3BlkFKoY6QNS
        cTTNTZD8o1SVp80s2/CiVvVcUwD3ZZisvQ==
X-Google-Smtp-Source: ABdhPJyTzicxUG+rkJP2G1eUqPc8CWKy4HBwoZ6UGxDL3nTPbcTk/4aZ4yNREW7ahY2El22rA6OgnA==
X-Received: by 2002:a05:600c:4fd6:b0:37f:2a37:87a3 with SMTP id o22-20020a05600c4fd600b0037f2a3787a3mr8206865wmq.152.1646644605303;
        Mon, 07 Mar 2022 01:16:45 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389a558670fsm2199704wmi.11.2022.03.07.01.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:16:44 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:16:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] MAINTAINERS: mfd: cover MAX77843 by Maxim
 PMIC/MUIC for Exynos boards entry
Message-ID: <YiXNejk+Y7DJ3x99@google.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
 <20220111174805.223732-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220111174805.223732-6-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022, Krzysztof Kozlowski wrote:

> The MAX77843 is used in Exynos5433-based TM2 boards and shares some
> parts of code with MAX77693 (regulator and haptic motor drivers).
> Include all MAX77843 drivers in the entry for Maxim PMIC/MUIC drivers
> for Exynos boards, so they will receive some dedicated review coverage.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
