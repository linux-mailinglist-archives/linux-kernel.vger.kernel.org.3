Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CCD50F280
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbiDZHf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbiDZHfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:35:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B79F8E6D;
        Tue, 26 Apr 2022 00:32:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so5852099lfh.8;
        Tue, 26 Apr 2022 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+fC4tIw9/ys7TcIy0WZlZ78Vh7fLcIzflyXEOhgB6Y=;
        b=P6WlvW3wqo4x24Uwzd08Bn3kfSqQqu/KbsEV52Q03IvO/1VG1D619mnLMCkfTX4k6T
         /yvDC3uQYpHV6Wt3hrZFP5WCtyGLX8ikJ7SwfAZWfMDLAZ+k4ZyTPvJGcqgakrD/wmHE
         Ag+L+MikjZayiDcAus2RbeZBvL7SOQb1gY/JkvJeGbgwFsSlpeRzJ+JqGb8ThkXyawyJ
         LUgNRkwapPoZo/E39jHvJkmaiIcG8L4E1OX29RDP87ElAjXwJrmPmrilyTtKf+Fe1j1J
         uAPcjE6FslRIZU59L5lt5Ay4SHu5Kmj5EPAGZqq/4vc9RNebPemOaKBKGx9I1YWEZRTz
         GFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+fC4tIw9/ys7TcIy0WZlZ78Vh7fLcIzflyXEOhgB6Y=;
        b=f1DtVfPuZ2uDgWeIUHXquQ+leHv65dXEFTNytlxDHiPq86Eu0tYB6brtXZWQIwp/rB
         9U6U+lQeR6clcrphLcVZQXTZNbXuwb3shOKTkUfcg9xzJKXi3R9Zp2lRuFvJ+E4pfYO4
         ZF09LAdmrmo7p/lKpx8JtCAfIxSrr6WgesYiovzVBj0nfigOdl8flYLgamfSS74PQk8u
         Q8dm8x6ouy1pIAB2zTvsl2FVJffJnliNN6ncffC/02LliOhS78MDM45+ivGbwD+iBxOr
         lhtXVTAEHuY1l8HU/NVyVzu6Q1OHnbWkbf8Lc02n+sHrdmrbARFaXxMJFEZq1GACjpxb
         o3qQ==
X-Gm-Message-State: AOAM533TzSZxbLt7RqsrRZWXdYtMsri6qv7KEIDcVvn0hDZ1oILqX7Zl
        BPeC9fRW9/Yg7EkC7EssnHOGOt/O3J0=
X-Google-Smtp-Source: ABdhPJwj24dKYh8u9U8BrMEF/22P2maMsTwPVANpPrzenuzF+i3ei7pUoEMxm3XWhRW3UoOAIlsF+Q==
X-Received: by 2002:a05:6512:1319:b0:44a:c200:61e5 with SMTP id x25-20020a056512131900b0044ac20061e5mr15854052lfu.550.1650958334164;
        Tue, 26 Apr 2022 00:32:14 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id d2-20020a056512320200b004721999f1cesm103509lfe.66.2022.04.26.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:32:13 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] clk: qcom: gcc-msm8976: Add modem reset
Date:   Tue, 26 Apr 2022 09:30:48 +0200
Message-Id: <20220426073048.11509-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426073048.11509-1-a39.skl@gmail.com>
References: <20220426073048.11509-1-a39.skl@gmail.com>
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

