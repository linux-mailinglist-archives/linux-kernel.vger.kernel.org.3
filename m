Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6350E8D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiDYS4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244683AbiDYS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:56:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B8B7C62;
        Mon, 25 Apr 2022 11:53:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g19so27876779lfv.2;
        Mon, 25 Apr 2022 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+fC4tIw9/ys7TcIy0WZlZ78Vh7fLcIzflyXEOhgB6Y=;
        b=GsOMMIUrqiLQJvz5OznDyW8MRUrCZnp9s/6KzP6JH5rl/E6bRGFUlj8e8yVP4MrxXQ
         d/NF6FwJssHuIVHYM93YNdQ+MnH1dkOcUBP1BZpTzajzYEWGvJT2gu8lUHZtaQYp/yCF
         ij0EMOvXadyv8BV7uN8/qU/3xm/g+0/ggGCMHYwUTjdwT2s4V8wuUvz68Zt8xF2bEhVf
         YW5mHoY2hMYSD5IUUxtfeYUXS+QL1FtG8rtwmjQF4odeHxfTdFpL6j4F0apftqXQMO0V
         xoqpnbvUIyvtvHOZA2456UK45tSsdxGwUiDEe013tSBWR/LGhB6nYG93I0fXgItOcQcP
         HZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+fC4tIw9/ys7TcIy0WZlZ78Vh7fLcIzflyXEOhgB6Y=;
        b=EC+APxvUS6axqbwLtJzakoWSZQyyws5TkkE7Y1S5sEvPDv9rbxNgjgcGShW06a4q3h
         L4Ckykdj+CtACAe6PTVCbhip3YHsgNaDeLGQNcervGjhdAuiUzNEUIUxUN/r05Nh+GPa
         3HKtWcLPY4xOgHFaJJLfUra9xM26owUJ3Q895zQ3+krt1l2QLXtlsralV9yHLQvHtkjG
         mplUYeP62ISTL4q3TUNZfHTXJaLwid638DPc43CzTywLCGOPmvpNRnhO4vnMhf3mPpoy
         tVrPqt+erskWWIW6VKZNxT0Q62sfVqabsmkjXUnm/hYojlcOuq8KCd43xakeWxsxVJ/e
         q9JQ==
X-Gm-Message-State: AOAM532q6AeK8M+32UMuVmxCkEh0ooMunqOX0DTSK3OMonWOt/uHKEEd
        zOt/3ASNJ9WM7Kr2gZR9ccGd/Oi0i/paSQ==
X-Google-Smtp-Source: ABdhPJwoEwSO53wZ2hL7cbcL5YhMZfx3ScOq7v1kwWcZL+8NCuipiD7CX8GC5zFr6eJUDxiRGcZz/g==
X-Received: by 2002:a05:6512:31c6:b0:471:a1f2:91cb with SMTP id j6-20020a05651231c600b00471a1f291cbmr14810405lfe.364.1650912789541;
        Mon, 25 Apr 2022 11:53:09 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id r20-20020ac25f94000000b00471fcf5b4basm913135lfe.90.2022.04.25.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:53:09 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3] clk: qcom: gcc-msm8976:Add modem reset
Date:   Mon, 25 Apr 2022 20:51:40 +0200
Message-Id: <20220425185140.15154-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425185140.15154-1-a39.skl@gmail.com>
References: <20220425185140.15154-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add modem reset, it will be needed during modem bringup.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/gcc-msm8976.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8976.c b/drivers/clk/qcom/gcc-msm8976.c
index 5781a7bcecc6..6b112984694c 100644
--- a/drivers/clk/qcom/gcc-msm8976.c
+++ b/drivers/clk/qcom/gcc-msm8976.c
@@ -4056,6 +4056,7 @@ static const struct qcom_reset_map gcc_msm8976_resets[] = {
 	[RST_CAMSS_CSI_VFE1_BCR]	= { 0x58070 },
 	[RST_CAMSS_VFE1_BCR]		= { 0x5807c },
 	[RST_CAMSS_CPP_BCR]		= { 0x58080 },
+	[RST_MSS_BCR]			= { 0x71000 },
 };
 
 static struct gdsc *gcc_msm8976_gdscs[] = {
-- 
2.25.1

