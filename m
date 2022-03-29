Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF14EAC6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiC2Liw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiC2Lis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:38:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E93D2A270;
        Tue, 29 Mar 2022 04:37:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bq8so20550896ejb.10;
        Tue, 29 Mar 2022 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M61AFRbLUdMV7oXCOaCCHm47RW/KqcD8CWFb8D1XXr8=;
        b=mNpnpt5ezVff5NEy7crvvpIdVosqYlaiuf5N6qnfUetlpcAQS2F8bqovdtp/HtR7tA
         NVTE6pVSAbAZe26NInTiHSLr7zBpAI2k/C5ApVbc7yoWs6xk8s2aCkoLUBQEK9cXejRt
         RQU6i7+pQnKCW9hLn/TWAC4vgZe1/d4XKSP0s5jSrS7ue/0FcJjb0phZ3NYNTd5vQV88
         9kU2gvhti9Tf43YCdyVrmIbK9c6w5ro+rHY2KuUZpzvsKMy8tFntvT7aDpowvUq5nh8q
         VJxFz/Tcn8wNGpeBx67xIbQiGICSOjwUihrxtLCS6M2pPuejanVOHrs8klooqRhAZHlo
         dqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M61AFRbLUdMV7oXCOaCCHm47RW/KqcD8CWFb8D1XXr8=;
        b=YvHV0QEW76/TZkteuJk20c2bW7aj6Tnc4qgjGs4wy+AAsUfqNBG8yBeTjwv9k9FKUu
         d0D0OmkNL5cKho3EWjyX6VRpih9YVGL0pl/KshpJL9gYwKqIxbzDM5Xxal6FScbslFbt
         5yU4vca6ZlByiNJng8wiB0qI6u62hty2mMaT5xEhsOjR9KelDZy5NLrnOshYnrueY3Ui
         Z4QsMntK6KEVeyuZOWBblxBq+zPVNF9bLjbRpm8/3co5nijZpLdx77rpZc5u2k6l848D
         iKJ1h9KO0Fels1/FMTQYIrHOk25PURmSnltJ6yM/E584yetq9rehJ0ee7Nq1ieh7oozl
         tswQ==
X-Gm-Message-State: AOAM530DXsKdKVytm/ILLzuoHQv+FdP7UqRsuw/a03xG+pE5aaNk5Mou
        Ro7eaT+C2WG+iXlU2gRbgSHu8t+vuAs=
X-Google-Smtp-Source: ABdhPJx4VMchVqZE8V93EQ5INMuQkm1Q6o8OPqlzDmpYQAC3yEjsNTUGbvY/cGeHSiv1PLxfVEL+ng==
X-Received: by 2002:a17:906:2bc1:b0:6cf:d009:7f6b with SMTP id n1-20020a1709062bc100b006cfd0097f6bmr33203632ejg.17.1648553824861;
        Tue, 29 Mar 2022 04:37:04 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm8171298edb.14.2022.03.29.04.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:37:04 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: rockchip: add clocks property to cru node rk3288
Date:   Tue, 29 Mar 2022 13:36:57 +0200
Message-Id: <20220329113657.4567-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329113657.4567-1-jbx6244@gmail.com>
References: <20220329113657.4567-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks property to rk3288 cru node to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 26b9bbe31..487b0e03d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -862,6 +862,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3288-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

