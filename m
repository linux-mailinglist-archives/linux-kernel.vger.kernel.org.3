Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762CA4965C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiAUTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiAUTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:36:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB0EC06173D;
        Fri, 21 Jan 2022 11:36:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s4so596128wrb.0;
        Fri, 21 Jan 2022 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iD/CADMJmjE6Wqsta+zyCvYv9Ey28eqoIb5w5xoLVEA=;
        b=pT1Wq/aAIl8THxDwAu4WsHnCXwPt44I62OEbx4xZhMzz2zo+cVyAmgxsaQt3T3X1U9
         JyAcHpk0XTuT+syn8/rkM0A2joco1O+Y5elE3iQ3DULT2eNvJ/FwBoQ0XVRWh2U9a5vt
         JB6BO+SDq5LbD5Ftb0ZIIEwKCzDjdr8XLg6SUXF9sFzHGe/mj2RzrXuuZVVdfxcvzIhh
         +IL83B0uQprKTsi9yyyQ88Nhn8HbJjbFAQU2KNVu/vGPu5sfbaeypfPReJpFRPERHn11
         eG7uWF6RHgPTqXspVOFmmjRQ1Iyx9I3tI7tFy6Coh7BgCoaZRk2z0IbjqU0fyuzmgRRl
         VOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iD/CADMJmjE6Wqsta+zyCvYv9Ey28eqoIb5w5xoLVEA=;
        b=1zz1bvWg61pXmLJyJz0lCe3hyS/9dQFp6ZWxg0K7ILzOcEyyJAEfTFBxTFusyKYxWg
         +ZSn86b5x9K5/nL8V8SC2q9XOKALbHfhW4BsHHbRUJfdgymFxF2bx4KoQ6lAFPTxxpHc
         1xRfr1MHgc9XqNIAB7UWeItpz6t9G1eREDWTEMwjZ6WDVyP3VDIZXYctDZDFAXfZ84sB
         FXxBV0SSDTxA4kfDROYggl6fJpYAV4jm9o7cvXXSbsNbIBOh5Gc75WkSz9G0PJeyKPLS
         FTajK5r0OlUuADGA6XiQHmpplP0tLz10EDxgH5DL+hisNP6U9yWI3nB8fUJ7v6q4gA/1
         KuOA==
X-Gm-Message-State: AOAM532pwa2xdPJQMyXHJyXzpS6pEqp/OV7TvIEeeyYTQs+wmHV0jpsS
        u0NxoMmKXEzKcqRDc65Tz4GpTQrTXD9qeg==
X-Google-Smtp-Source: ABdhPJwVJyHJrYnB/nAOd95Z2o0Y1FG3/+VVs+HRs4c0yfdCd4kS22114ki82+YNAOZzUPZxqsjJkA==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr5154671wrn.502.1642793759362;
        Fri, 21 Jan 2022 11:35:59 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id h4sm7803309wre.0.2022.01.21.11.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:58 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] ARM: mstar: Extend opp_table for infinity2m
Date:   Fri, 21 Jan 2022 20:35:44 +0100
Message-Id: <20220121193544.23231-10-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121193544.23231-1-romain.perier@gmail.com>
References: <20220121193544.23231-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

infinity2m are running up to 1.2Ghz, this extends opp_table with the
corresponding frequencies and enable operating-points table for cpu1

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index dc339cd29778..1b485efd7156 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -6,10 +6,25 @@
 
 #include "mstar-infinity.dtsi"
 
+&cpu0_opp_table {
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+};
+
 &cpus {
 	cpu1: cpu@1 {
 		device_type = "cpu";
 		compatible = "arm,cortex-a7";
+		operating-points-v2 = <&cpu0_opp_table>;
 		reg = <0x1>;
 		clocks = <&cpupll>;
 		clock-names = "cpuclk";
-- 
2.34.1

