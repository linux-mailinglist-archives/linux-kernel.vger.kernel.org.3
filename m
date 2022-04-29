Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63D514878
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358702AbiD2LrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358626AbiD2LrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:47:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5940FB36B0;
        Fri, 29 Apr 2022 04:43:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j15so10460785wrb.2;
        Fri, 29 Apr 2022 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QAG6pPyD19LucMP6CU8bLxTFEbcMKLUH+h3BO7hHMdg=;
        b=XrPtIQJKdVelzjyZcDP5JYWrAupI8eZfW+4qG0MmikLOobez5/6ud+gLpdOLZq0qwz
         5toAEsssrC9sqnJ4HQhGUJcYOB80r7aCIq0ahp12jO/r2k9Q0/9GFD9wz3locbaO+4Ja
         dDIJQ1eZ/pa6I06DOQKdfLsrH84GiyAdDTcJtVJl9onmAOaiaTmVvVUhIT3nkA76UPWw
         jFjnt/vJKMmieYSXzyGaOSu+lsQkhJCI1VNHvG+9wvv3T69ycqRGyR5V6Npw48QLREmb
         HglDsujyrC+DWR62abq5WjWN+j4ry+eIZ/iAqRth9YFKC08dQblImp1l2trLqws/awdV
         FMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QAG6pPyD19LucMP6CU8bLxTFEbcMKLUH+h3BO7hHMdg=;
        b=QSCE2WzkjwxveiiEdkxUEJDA2CTIdSi7leihBDyrhuCvSD8P2+QncrbBDAWbH62ozl
         yQig5f//p1TzFBfYC9lpLxjdoy4ZgvNkkJbzNbilhLV/VxPLfLBfzU4RwiuJb0Xu2wMJ
         bdhUL+pTFadw20DsXfO+dPdlR8CUjY/v2IrmBEaQcWzUW+U3gp4Ud1cxjljsOG0DRrG/
         q6t35olAV2GRJKsGtHnYuPP0LUGAXgoNqLz48Tvk8ptHFc99gz2J2AIvqJZr83xAP7Zq
         VggrTHCThjPv5lG+Q74qEXwSdn5Ftt9j7aRBQh3DuM6UdLcgTJ/A9boB5cNHU7vkmv+T
         TFXQ==
X-Gm-Message-State: AOAM532lFkSzkomgpqPK3URnbdcEiKU616tsQAHljhnC8x40J8LQcPYF
        umSptQkrWZAeo6XPFxoH0eSNIz5WoPB+8w==
X-Google-Smtp-Source: ABdhPJwa9zh912EeQ+Wd2W4TIvEJ8UM0h4erACtzSUOUAWGv85uWKfGiyjFUhY9MzrZxsC1K1zBUMw==
X-Received: by 2002:a5d:634e:0:b0:20a:d67e:4a76 with SMTP id b14-20020a5d634e000000b0020ad67e4a76mr24094750wrw.637.1651232620918;
        Fri, 29 Apr 2022 04:43:40 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-183.xnet.hr. [88.207.99.183])
        by smtp.googlemail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm2990900wml.5.2022.04.29.04.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:43:40 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 6/6] arm64: dts: ipq8074: update APCS node due to clock support
Date:   Fri, 29 Apr 2022 13:43:30 +0200
Message-Id: <20220429114330.59026-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429114330.59026-1-robimarko@gmail.com>
References: <20220429114330.59026-1-robimarko@gmail.com>
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

APCS now has support for providing the APSS clocks as the child device
for IPQ8074, so update the DT node to reflect the expanded register space
as well as add #clock-cells property as it now provides the APSS clock
that will be used for CPU scaling.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 5b32d141c7ae..d23b14a8d4b4 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -970,8 +970,9 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 
 		apcs_glb: mailbox@b111000 {
 			compatible = "qcom,ipq8074-apcs-apps-global";
-			reg = <0x0b111000 0x1000>;
+			reg = <0x0b111000 0x6000>;
 
+			#clock-cells = <1>;
 			#mbox-cells = <1>;
 		};
 
-- 
2.35.1

