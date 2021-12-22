Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD5B47D712
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbhLVSoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:44:02 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:44170 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344845AbhLVSoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y8vS4bG/Og/65YSvsw5yKNZApWbt4g5SqGst58r76js=; b=go2D0T4j7FSuoscFMthbG+EWWE
        FKHmxFTTxNawO/FSEoLMU6dx5Qfx2z2c/PeA5LvLbFKv1TFmjcAyLQeLdWjjwoB1Iyb5aLXmeaVMD
        3CL6SaS8C4GarC+xYNrMUB6lpKXQf1wvBe7eFfhPzCuQkSIbKW2PPH7+SwltfG4Up78Y+hT3JKWjg
        JaWxM6hLBRqsKK02FOtzICsvyHtZgIyYX/tzW9pJt9e2THBhVVVJZx8gtOrdLpEq2uQSvk/tYccrC
        bBEeCz6Du3Xtbf3esOW4iZTdEu0BavkReHnGQX/TeeaDxBnJ6MqwQjRsWGItUuwhCldyH7oaUlz3M
        u7S2izSQ==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:44088 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1n06ai-000CmX-V0; Wed, 22 Dec 2021 18:43:58 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH v2 3/5] Added setting of writemap to formatted write
Date:   Wed, 22 Dec 2021 18:43:38 +0000
Message-Id: <20211222184340.1907240-4-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
References: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whuk3.redbackinternet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fbautosys.co.uk
X-Get-Message-Sender-Via: whuk3.redbackinternet.net: authenticated_id: linuxkernel@fbautosys.co.uk
X-Authenticated-Sender: whuk3.redbackinternet.net: linuxkernel@fbautosys.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>

Added regmap_set_work_buf_flag_mask to _regmap_bus_formatted_write
to ensure correct write bit value set when writemask defined

	modified:   drivers/base/regmap/regmap.c

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/regmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 05c65312a9b3..0761c854ae3b 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1969,6 +1969,9 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 
 	map->format.format_write(map, reg, val);
 
+	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
+					      map->write_flag_mask);
+
 	trace_regmap_hw_write_start(map, reg, 1);
 
 	ret = map->bus->write(map->bus_context, map->work_buf,
-- 
2.25.1

