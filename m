Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9FF482C38
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiABQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiABQ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641BC061761;
        Sun,  2 Jan 2022 08:57:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j18so65698495wrd.2;
        Sun, 02 Jan 2022 08:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSLPG0MzXHr2sBAsU44qorgJ49GZ8FzI0+68Kp64Drs=;
        b=VOQd0Ow+1WrNgYoFwglIyEDD6eh0BYvqxp/o+V8B/ljFwgxQTOEv6OJej9Mm5R+oYR
         hkhJn924zrQiLQcJnGGw3JAdk3VOqMJwJkpkOvmlDEjNQ9hU+kQ52Ftz1a4TKcUJNrUa
         7Ozk7l+nDnMIdRpuzunuEk28K5nHqv3kP+A1i5CiKF6V6WSNN848CrI8bs1omgDwEv4V
         ERNaMlDYKH8a4Jrd9vug/k4Fy7od9oHsSA9alNkU50hWXcUwFZRz4/96ke0ewxaIol8+
         wVJt6r+O7Yh/X2+qAXheK37OiawrgLjj3R3NxZKPGn/xstgbIaeGGFecPDFaDkmdSrm4
         0cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSLPG0MzXHr2sBAsU44qorgJ49GZ8FzI0+68Kp64Drs=;
        b=uGh4pE9r3ien+f2mVwMYTXFGnywHln3hUZacA9y2TeEcKT+Fo/ZFzdeP969ae7fMt7
         EHk24ywif3nMTc4hbHpWNkfrgCdzTfXhCVUnLigX68Cv2xtAosKSxx/6hpyBFZysiGVm
         oN3LRweDbZHh8hYbN/LssiCV30Zpkv6p8jxYEh/Xcx4fxjYCFkPEcSlRuYy9ses07kPk
         oj7qyLT/1qk3rNWRMDZaSdw1vfaX2TGZ9yxBBmfiPyaBn7qcuv7fx+uNNsvaC4HkFcJx
         UM/WYzJexsBR+1M2C0x20WA/jIFxgMQGfjLdRQ8axVJU9WQ6dKKDqokghH5gJUh1o9ph
         BDRw==
X-Gm-Message-State: AOAM533qQFoa+CZxahr/Fwa/Hqcz3sRC4WpuPxin7s/ptqKTaB/Kq1qQ
        kXQtX8UyDpxv9nKS85jorpUY7Qs5VfAe5w==
X-Google-Smtp-Source: ABdhPJz7QrYuQYvDwF8GFlCqsOZUggIWRhwsYrBN7X2EcIR/k/YLBCU5wE1SdWo+1XMV6CkNH71Jkg==
X-Received: by 2002:a5d:6d0e:: with SMTP id e14mr37348800wrq.407.1641142658912;
        Sun, 02 Jan 2022 08:57:38 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id p13sm25786857wrs.54.2022.01.02.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:38 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] ARM: mstar: Link cpupll to cpu
Date:   Sun,  2 Jan 2022 17:57:25 +0100
Message-Id: <20220102165730.50190-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

The CPU clock is sourced from the CPU PLL.
Link cpupll to the cpu so that frequency scaling can happen.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
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

