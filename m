Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063164E7EE5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 05:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiCZEZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 00:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiCZEZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:25:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529F116283;
        Fri, 25 Mar 2022 21:23:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p8so8154794pfh.8;
        Fri, 25 Mar 2022 21:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCBIirOoy5iS39x42QQNsgyY9hPVbW/ZEOeOJnVZ7v8=;
        b=QFvSXLdhCIUgHlJ9CNoBWgTctPTXj+vQlBGdg+9egYM+RsBS3cR0JpeqLpFlNiSF8q
         Jd315vBb8BuJQfNX30bOfiLz8V1P++IfjSt33kutn9VvYSEkOc7w2vySwl7ZplxOiHcA
         I5xZbBS4YhrnFTog61QHn6lSdAhEreGOx4lpbvzCoOEgGZR422mNDE24N0XqTV+P96od
         r1fE4av/5hTsMD6CFA6WDxZY0VwddE495H5ZLNk4UB6ndHTGjnfX9iQ7Om0N+4VJaXmt
         YawZL/9c+oSMdCaXkRyZn1UhY7LXJ0wcIwP3NxxIChoqMQ40DiOnudIGpabe1eZHOIca
         q14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCBIirOoy5iS39x42QQNsgyY9hPVbW/ZEOeOJnVZ7v8=;
        b=MWORU0380nH73cg1+Vgzl9CUamvW78P/i57/cPFztdJzSknERYuVjv/smg4bErwvPQ
         Q1OipqnQ62Qq3+JXpPbRUGd91Xh+TVxGzQ1S4q7iD2e0E8/HtoJEoECZ6SUrCsyG1hWs
         QT3kW7U83bWFF84V8Oztgh5B1HiNfKqKpiBifNRKE3hxncBUOxLGHWBgKjRz6mosC9El
         jzO861ij1hFWDsiJ05Iv09prKHHxeNV7GydMfQ2Qg1wkgzk40LOEGN2g7F6xcU5TgZ1k
         74xepNua4hwSfOhUiLbYYMRztC50/7rTQeIflh92P0hnxqgei1UQTEQcszISUkaAjOSS
         ULMw==
X-Gm-Message-State: AOAM533iKWEawikpFPgW77Al9AEQL6LYuISvGZSsM9a4UWx6uKSihGw0
        ybrwJjMYrw0avUlbZyvroTo=
X-Google-Smtp-Source: ABdhPJy0ZYgrO1Ufw88z6oXuVsGtavi/8aXUm5ged1ojhDNufuTsxxFq8trQv2tmfz5Z9FK8hoc3Nw==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id l15-20020a056a00140f00b004e069959c48mr13242222pfu.59.1648268621662;
        Fri, 25 Mar 2022 21:23:41 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b001c75d6a4b18sm7457544pjb.14.2022.03.25.21.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 21:23:41 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/4] ARM: dts: spear13xx: Update SPI dma properties
Date:   Sat, 26 Mar 2022 09:53:09 +0530
Message-Id: <20220326042313.97862-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220326042313.97862-1-singh.kuldeep87k@gmail.com>
References: <20220326042313.97862-1-singh.kuldeep87k@gmail.com>
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

Reorder dmas and dma-names property for spi controller node to make it
compliant with bindings.

Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm/boot/dts/spear13xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index c87b881b2c8b..913553367687 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -284,9 +284,9 @@ spi0: spi@e0100000 {
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 4 0 0>,
-					<&dwdma0 5 0 0>;
-				dma-names = "tx", "rx";
+				dmas = <&dwdma0 5 0 0>,
+					<&dwdma0 4 0 0>;
+				dma-names = "rx", "tx";
 			};
 
 			rtc@e0580000 {
-- 
2.25.1

