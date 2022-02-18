Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899674BAE96
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiBRAa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBRAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F535F4D8;
        Thu, 17 Feb 2022 16:30:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d27so11765955wrb.5;
        Thu, 17 Feb 2022 16:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8YGCose0S4kV16gVOE5GK8KxI3gBtjdR2w24/hi2y8=;
        b=PkSPePacXyTtO6DnMorB/v+zKE5POlRdrIhYNs4xnCcVi4F6b3yS/QQsjZ5ZgDgK5S
         2SdpV6pJIxZQIE9mg+B6XutzoYYZLjXwBVRTAr9iWocEHpZ3pxWEBQ0LAZpwn6bKjPTd
         EOx7+jlBeYjjfAmsajw+/lu8mBeN9MNCngtprRRvRMKGiL8igEX/Pon1Dbx7O99LE6gL
         PaTyWfY5BBCzi68rKICnZlLHBVNMXl9A+lJ1TvPYhd9bpRggZf5+rQw3ki49aF8lpWxq
         8iYYdwpR95ZNE19H5q5Avg5wcSczjSLLTOAi3R7UeyuSOZYW2uPbnBUti7H4qe9/hz5P
         g6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8YGCose0S4kV16gVOE5GK8KxI3gBtjdR2w24/hi2y8=;
        b=n5jeKAMZuCcVy/iMzzRaXuhc/3TNeWZxpOe7TdhojQbnGPDjzlTM74uxSRXdUQ8Vwj
         oTJqoZl+HW3ntq4vrES1x2nL8lvjema59uN+7dhaFtAVv1M2hcX+grHoqf5hqxvCyC9p
         YFPPYFTVui99GO3ZRnli+8kWSVgc8XhfEvtq18qzRZUIKlxFjTRpSJFn2JjGOVKOMJvO
         cZmPe3T19KVgi+knBuI+TbsrwuR4bWcJ48V/28lNItiylIZc2S8MCxobIH7/e7DYsSYk
         kK63HIyR0I9ZoEEmDJ6MYed98Bd5ekE45CO0ClJGgSmTrhLhAPZDm65mE9vxIh5+Hp93
         nBRQ==
X-Gm-Message-State: AOAM530hWUXbH3J02X1izA+niPwwCQG0t3MtHwV8VSQcKybO3L+FUIgl
        O38xP2E3Lc05npiD9B3/NiE=
X-Google-Smtp-Source: ABdhPJy+kvwN7hQ4CoWYdLK2Tp9Cxfb8Q7Ly96hu6XybMdHLtM1qjmLeULmWUu5UfnkPVPVXM0MnUQ==
X-Received: by 2002:adf:eb89:0:b0:1e4:b8f4:da74 with SMTP id t9-20020adfeb89000000b001e4b8f4da74mr4161135wrn.408.1645144199825;
        Thu, 17 Feb 2022 16:29:59 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:29:59 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 04/18] ARM: dts: qcom: disable smb208 regulators for ipq8064-rb3011
Date:   Fri, 18 Feb 2022 01:29:42 +0100
Message-Id: <20220218002956.6590-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

Mikrotik RB3011 have a special configuration where the regulators are
not the common smb208 controlled by RPM but they use a TPS563900
controlled via i2c. Disable the smb208 for this specific device.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 596d129d4a95..0982b6214fb7 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -216,6 +216,10 @@ led@7 {
 	};
 };
 
+&smb208_regulators {
+	status = "disabled";
+}
+
 &adm_dma {
 	status = "okay";
 };
-- 
2.34.1

