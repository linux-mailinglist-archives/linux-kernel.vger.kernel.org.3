Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBA482C43
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiABQ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiABQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:42 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C426DC061761;
        Sun,  2 Jan 2022 08:57:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so9572128wmb.1;
        Sun, 02 Jan 2022 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBkuRgwe6wjN8B0dWdq4qTtmz/vmICR+ObQMfngMweY=;
        b=LQBHp/l45t4z5YWuB+Sfk5u3i5X3BIZqx5z++W8Ku9PElU7/04F4dE/eehHuLMTzSb
         V8XyxS7Rj0+oj3XyE87KYyBfl2ajEuI/zRAdW+TD6IwWJIyC20iFGwQWc4ZWAo+6dNY8
         ChqJv17YWllfBsa1Xjn9YeDDteYs1NDz7zVlym056KI8WNnNuBJ7JziJ/03ioUKemzC1
         piVuGhP6gGolCqk6Ur562fdyOw4Ok6xCkTsQKWV8mxoygFmpkbUe+GHAwknk5e+aGV3o
         N9h0bW11D1nKyj/1M3JKqWhYWy5lvHvm3a5YUnwHeLRxbzqquT3nNv01WxFC+H9ILpW4
         njUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBkuRgwe6wjN8B0dWdq4qTtmz/vmICR+ObQMfngMweY=;
        b=XRtaT+L/OW89GTMib1VQGRAV/sU/ZL33b9TYiHXI7Y3RrfTHkRE0KqG2Bo5LphYvfX
         gKWi6zIsX6m4SWs2FH15331RYh1pOzyzNDqS9TuKPqgjfE/oxXaPHeioRKGD2vWEqa7J
         cIboVEm9O+qF8DAAockzvmvplK37uGk3tUO/clWAhQyM9Qw8kEvOPRooQh3JjW78kGad
         6/QRWDM3yw69BZlYx7xvOJoPWpgyisl29zayY8ZLtpmzwbAhC5JyF/rw2Fqy2DA57ktM
         m+Km/fESTI+0DioL6u9hd9qQvn929VgsYjL8AvSrz03VZ768DzwMVMzm1dadItaiPLxA
         arXw==
X-Gm-Message-State: AOAM5339oHaPmnQ1luBJBG3s7xw/v+B8W1eCieiTPLSqKwbVPHgOvLrW
        ETx7cBEm8b4Llc9RW2cVxOaJH2atXaCooQ==
X-Google-Smtp-Source: ABdhPJzVe5xaHtg300FhtGj31yzAxDEi2z1lt44/jfQJTXEGYErXbNN3jAWTUoQFGm3g/hxzve5JoQ==
X-Received: by 2002:a05:600c:510f:: with SMTP id o15mr35759659wms.104.1641142660072;
        Sun, 02 Jan 2022 08:57:40 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l6sm42247234wry.18.2022.01.02.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:39 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] ARM: mstar: Link cpupll to second core
Date:   Sun,  2 Jan 2022 17:57:26 +0100
Message-Id: <20220102165730.50190-6-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

The second core also sources it's clock from the CPU PLL.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index 6d4d1d224e96..dc339cd29778 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -11,6 +11,8 @@ cpu1: cpu@1 {
 		device_type = "cpu";
 		compatible = "arm,cortex-a7";
 		reg = <0x1>;
+		clocks = <&cpupll>;
+		clock-names = "cpuclk";
 	};
 };
 
-- 
2.34.1

