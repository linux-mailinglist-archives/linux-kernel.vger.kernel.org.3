Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C8551890
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbiFTMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbiFTMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:13:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D90D186C2;
        Mon, 20 Jun 2022 05:13:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so9557292plo.10;
        Mon, 20 Jun 2022 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8oaiAKxAOnyKxeq8pXjdS3ucgnot6WTv7IYYMvN1bw=;
        b=Mzv/1B5KER1Tzc4pyAmUxXiI6bmnUBq1YFxVhaYUIeT26QLOa5jqYfnQLXYIA3aDmO
         Pb+HICFg+g8AWPnTple1LWm3AjYOyYP8Gk28IYWzX/CwPgM8X8L93i/ayTNcpAj/B2H3
         dPiLTSqV5xcmzU17t82tRf8e6IfjYbW65/YC+0GqdcYoQ2EsR7qD9rE5WdPLLtTcLgvX
         ungWGu53GgJAi48pQTRIs0Q4b7hbiTqSgqfopKttbRP8M57xHpb8XKQf7IKbX2bVh/Cp
         //6xIuVPD+9nV+JaDMJ0gMVD8E14i+mHQwX50fnRkGs1Sz9tP22u+VUGSs/g8J84c1FM
         XujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8oaiAKxAOnyKxeq8pXjdS3ucgnot6WTv7IYYMvN1bw=;
        b=kNYLA2AyF9S+lxFCsvVm/IF13RgYMu00VmeIZhbE2ZP0aaf7YJRG+EAvn13uRzHZ1u
         MOI0PEDs5i0c3SDkP37POg+DsEkH0DtJhFIXcFcXUx1ILYLIaT97zjdEPrttun5ix6PS
         sqxbt31zg9Z5gndwmGSEBL7I0yrxgNqPu59q4KWLFeNUvfzYfU6osoM28b6OyV3f42RT
         8tXkk0IVYtJ+fLN5hfZ9gtFIuG2X57dnor63yprFibWnnMX9taRHY6VMdjo6Pfm/e6Xz
         p4tnatLkU96WSnlIWPk84ejnc879fvjFfWo/QT1Wo3GHkcvONE13G6ey//2GlQV3U+oT
         euRg==
X-Gm-Message-State: AJIora88o+bqOiAS8ift1mQqRyjqDKF72l5HYpHoxSElTA1XjYPHp90E
        zFbtXtMcxxGUbRcqXbadsCiBU2d0kSw=
X-Google-Smtp-Source: AGRyM1sfkYcvWWS2M0tpjoFsHoSPXYou3curuP6O7pouA98HaOchiXcq29VsVpNh60ufyWtUHGOlCQ==
X-Received: by 2002:a17:90b:388f:b0:1e8:57db:443 with SMTP id mu15-20020a17090b388f00b001e857db0443mr26500027pjb.52.1655727215152;
        Mon, 20 Jun 2022 05:13:35 -0700 (PDT)
Received: from linux-server-us.. ([172.247.46.202])
        by smtp.gmail.com with ESMTPSA id a2-20020a624d02000000b0051e7b6ec81dsm8946987pfb.108.2022.06.20.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:13:34 -0700 (PDT)
From:   YuTong Chang <mtwget@gmail.com>
To:     bcousson@baylibre.com
Cc:     tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        YuTong Chang <mtwget@gmail.com>
Subject: [PATCH v1 1/1] ARM: dts: am33xx: Fix MMCHS0 dma properties
Date:   Mon, 20 Jun 2022 05:13:26 -0700
Message-Id: <20220620121326.5122-2-mtwget@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620121326.5122-1-mtwget@gmail.com>
References: <20220620121326.5122-1-mtwget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to technical manual(table 11-24), the DMA of MMCHS0 should be
direct mapped.

Signed-off-by: YuTong Chang <mtwget@gmail.com>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 7da42a5b959c..7e50fe633d8a 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1502,8 +1502,7 @@ SYSC_OMAP2_SOFTRESET |
 			mmc1: mmc@0 {
 				compatible = "ti,am335-sdhci";
 				ti,needs-special-reset;
-				dmas = <&edma_xbar 24 0 0
-					&edma_xbar 25 0 0>;
+				dmas = <&edma 24 0>, <&edma 25 0>;
 				dma-names = "tx", "rx";
 				interrupts = <64>;
 				reg = <0x0 0x1000>;
-- 
2.36.1

