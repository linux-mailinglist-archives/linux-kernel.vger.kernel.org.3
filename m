Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5994549D143
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbiAZR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243997AbiAZR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F0CC061749;
        Wed, 26 Jan 2022 09:56:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u15so436811wrt.3;
        Wed, 26 Jan 2022 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDNoKV0qv6YEK56MEl2TbFC2RsE/2jQa2ifEdZIoeX0=;
        b=OqGltRvbjpCNbLcabWMdamxxF4OG4xNm/NOuGRc4l7L7cJ4ZF/20KF43TO2EZGCRap
         RUbL50jsdvJzLubUTpxcjr7fsjh4sey/1ow5NR6+a+M0LtChHzU3DMOUnC9IQKjoMqQ4
         ITznzqwB8tRvcJANRiBOVBza3fBThjqy/eaw37Ji582lyGlYfZnRwjbMo+kifsbqdYp8
         3sHD8y5cRzY0RlP4NWAk05iQ6sJZdJeeT/oORHWM+y+QN4OnfRAf1uUNYLADIwic5rzs
         l+Zvtu0DpULVx5v2qVaK3detxxPtSGS+bifTXhtxl6Oid1BOL/xuu2BaJwJynJ+dwCjm
         ZroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDNoKV0qv6YEK56MEl2TbFC2RsE/2jQa2ifEdZIoeX0=;
        b=agMuH/MHHeWoPmzsrOYPOMxGBICk/vhV5Rs2O9F5HY+9DFroNmgfn5PQjEfp3p25EN
         7+5exEBQdlhbqRPsZvsEopGQb4GjDKAFHw2WOgjhcQGenwqoAcZsWjbhJ3XlcUh1RXn3
         MRhAdCL2dPaY9H1sOFkau+Y9JOvnPMVmz4lx0TwddJWFNORJn59Xz9/3D9vwhIkNwJtl
         F5pQ8YZTf84/BJrtdWIx160V6F6dHxvTcgAvrsCp/Mg6ELdJFIZRZ4XFoZzm7QnO0qbs
         F6lA90AxUv96NxE+P4ClypQKLEowAHuA/UujHNToLObwVumkMtmUnyaMjax/pz5SpDgL
         AhwA==
X-Gm-Message-State: AOAM530hP5lsDdoOCuSQpA6XFY84uPzH/bTpeM9JINzFAKe4MYs2XvWn
        McPl4KZQgx+e30kXIGV38imS52tCAKCzLw==
X-Google-Smtp-Source: ABdhPJzoRB+ISl3F2EneRHRBb/x6urgHFoQbFid3vN+X+fH/Xm/+JtJ5GvksG57uVSkwv06e9i00Zg==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr23742984wru.355.1643219777015;
        Wed, 26 Jan 2022 09:56:17 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id s17sm20207613wrm.62.2022.01.26.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:16 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] ARM: mstar: Link cpupll to cpu
Date:   Wed, 26 Jan 2022 18:56:00 +0100
Message-Id: <20220126175604.17919-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
References: <20220126175604.17919-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

The CPU clock is sourced from the CPU PLL.
Link cpupll to the cpu so that frequency scaling can happen.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 2249faaa3aa7..c26ba9b7b6dd 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -21,6 +21,8 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
+			clocks = <&cpupll>;
+			clock-names = "cpuclk";
 		};
 	};
 
-- 
2.34.1

