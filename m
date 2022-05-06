Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6247451DB6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442608AbiEFPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442580AbiEFPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:06:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D486B083
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:03:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l203so7779110oif.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvoH8ZCcnfut2q0yddyy+EI61mB9kTHgif1bkR8UyTE=;
        b=MlGDGfV1Cn1Ta1i0dFcaMEd5xxCvPuVIF8txFh+e1Tnbx/zW0SGPjSpZODIxOWvOlg
         5EWCWj9Xyy3Ru4nGTFi6t/IXZf4c2AQaH2pRBHdbmXP0gK8EbPBhHtPqjjnoNxaTOxzo
         +MzBIMYiApit1Y/bGe+vfgC0wkSHpEmz/4gdL69paMhTGvabK2awbesBaN0fg9mUAoBX
         0lJEttKWwieu4/6PNURbCaUwPNeD8eAv+vRf6JjcUq2xFNMNuMv1gJkGVKdLAgI5xSOC
         ovqwQFK2oiTWHGl4Xr6HSovKKJWXJofG+A6idIY3vWi7UJVF8PxWqQNSPdZF+gSkZVMo
         2KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvoH8ZCcnfut2q0yddyy+EI61mB9kTHgif1bkR8UyTE=;
        b=Z3NO3RIKLulkWEhiipfQ7cbZBevUZmmUVVqOxXWWzc6fSMtnoa5gFX0XMtkp08SBj/
         5Bx2PJCiqv17ZNDFSqXjkxVJZxIePn8cGeiogZerYUP7IELb9JelxEzP5jH9mZl2PM5E
         gE4hX5xJJL0sTH+sArPn8xktPgXE77K/pTNZih4CHbdZh31AH1Ppo8edEQGgNyy1Fdmy
         49/JI6VkMBnYJFjhrkg8H2m6F6IId27SRvI9Bnnmdbwx8VdzGAL4BjWttbv1mDjfhnrD
         8aGZMW63pk49kZqUW8FYTjOc4YWP1w+whAYQA+v9UtYOvTCjOOKO1D6BGsAcfKMrwm77
         4a2Q==
X-Gm-Message-State: AOAM532fyrMjbfhDCqhb7knKq0979ZjgPHLuft0fNLPKQCGhjpUSklYf
        h5hg2/VXx0nN7BhPjwcqhF9kyw==
X-Google-Smtp-Source: ABdhPJw7KRjo7fodRuHUv4feQJ+ELLzrnyXZYloFvWJRv3HLo1gcm1VfqMi88r9DENwA42UCtJIiRQ==
X-Received: by 2002:aca:add0:0:b0:326:72d:fd64 with SMTP id w199-20020acaadd0000000b00326072dfd64mr5009820oie.294.1651849394558;
        Fri, 06 May 2022 08:03:14 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e21-20020a056808111500b00325cda1ffb9sm1665311oih.56.2022.05.06.08.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:03:13 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     phone-devel@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/3] MSM8976 GCC updates
Date:   Fri,  6 May 2022 10:03:03 -0500
Message-Id: <165184936433.73465.10846500957961033721.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426073048.11509-1-a39.skl@gmail.com>
References: <20220426073048.11509-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 09:30:45 +0200, Adam Skladowski wrote:
> This patch series brings small fixes for SDCC clocks
> and adds reset for modem.
> 
> Changes since v1
> ================
> 1. Adjusted comment line length for SDCC patch.
> 2. Added Acked-by to dt-bindings patch.
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: gcc-msm8976: Set floor ops for SDCC
      commit: 24a8ed12aa00af135fe698061017042532aac5e5
[2/3] dt-bindings: clk: qcom: gcc-msm8976: Add modem reset
      commit: 7e555e9975698924d7f3ead154847bcf8f5cd40c
[3/3] clk: qcom: gcc-msm8976: Add modem reset
      commit: cadf16c9469e58ba74806f76b3d0f9f553a41b2c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
