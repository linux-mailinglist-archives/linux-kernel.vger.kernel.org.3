Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89C350E8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244699AbiDYS4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244666AbiDYS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:56:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ABEB7163;
        Mon, 25 Apr 2022 11:53:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w1so27839156lfa.4;
        Mon, 25 Apr 2022 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDNJsDyTJLs5MJ0mBXcwMzf/Gj7LqsQqTJ3q7FnQROQ=;
        b=ekvxKZ3ea97YGp/oFmHYBM1xsTa7LGFmyFW3KAXXFvI0j5lgLpZjcsLugqHiHffGfU
         JSbIhRZXYppFsvCHUZ/dysPaFmLv2+iRwNsGqg07MAi11Zik5c/0fQXS8eP4CjE/t+JM
         GeunbqeWubHY8+7qjbKOfHJLVP4csBZsEN/ODK3A3Jm/BAZONUFK9ooPo/xIB4uPMOv1
         DfAF9dty1D52+/RrKS0YvOJvSjsYyQFahG+8ZsltF1ZSX0xmsYaEXtIo+TKFBC40P6se
         guPhud4XqqiniXXduuXEUcUxWjvQn3BW9FV+1dOSk5u8WjDGUNN3VKNVOOt8AHCnM1DK
         vbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDNJsDyTJLs5MJ0mBXcwMzf/Gj7LqsQqTJ3q7FnQROQ=;
        b=HnVRw10gN1MShUZWN01mOPQXoyNsSmjUrwuMmJnaWJbdQakoG8s3ILNYiefc8eDn9z
         UlczHxEhX24MwaCGWo3Sr4obScGeASi8KdLpAMtl7WEg08FUKlsmy8oZa31EPp1AVnQQ
         A4mAG/wzAWQ32ACnTUB9IN8IME0vgJq8quRhOjOvx8tEe0Qdpw+RIr3S/9nc45JpdmgH
         58hdAgl4u21OIU1AFa0o1AM0SYzVFoNZbphD/TDEGN0YcHp/0+A6K4GHRCcoRPVbjfzf
         hKsC9fyv2uEzvAXT6Zacpi5zkggk58H4qsZTQkESHms8cvna+ObWcKZD7nB5E96V2PwS
         EK9A==
X-Gm-Message-State: AOAM530IKVu9zT72wZPsoG2SrGTHidR4tnN7QA5UCAzAWX/EqlvwuXfC
        kxtyeadhQC94YLvrgW6NxE4GLwn1ytbqyw==
X-Google-Smtp-Source: ABdhPJypviE8R3OmRDACDgJ8P2Zwpg7QJSbI3Gg+Feo5rMFUHD1NNcF7p/j+UXzeysaXCSzgtQ0hgg==
X-Received: by 2002:a05:6512:31c2:b0:471:ad85:9553 with SMTP id j2-20020a05651231c200b00471ad859553mr13382341lfe.330.1650912788063;
        Mon, 25 Apr 2022 11:53:08 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id r20-20020ac25f94000000b00471fcf5b4basm913135lfe.90.2022.04.25.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:53:07 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: clk: qcom: gcc-msm8976:Add modem reset
Date:   Mon, 25 Apr 2022 20:51:39 +0200
Message-Id: <20220425185140.15154-3-a39.skl@gmail.com>
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

Add modem reset for MSM8976.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-msm8976.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-msm8976.h b/include/dt-bindings/clock/qcom,gcc-msm8976.h
index 51955fd49426..5351f48b2068 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8976.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8976.h
@@ -224,6 +224,7 @@
 #define RST_CAMSS_CSI_VFE1_BCR			7
 #define RST_CAMSS_VFE1_BCR			8
 #define RST_CAMSS_CPP_BCR			9
+#define RST_MSS_BCR				10
 
 /* GDSCs */
 #define VENUS_GDSC				0
-- 
2.25.1

