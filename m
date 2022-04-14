Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F893501BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbiDNT3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbiDNT3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:29:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C11CE33BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:26:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s14so5477592plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sC6zeBvAQu12F4pHcyP2yBc/sNcvkHC/U+oaZNn0uLo=;
        b=3AfN2QOtqPTE4Jjh3ZdUSD2K4zUz4u91wUVgcUboZjbwv6YIW+k2VsYETOafSvTe4b
         n4zLGloSG1zzfke+Sq6mMIM1QU9dewPGWZaoH+D3+ps60K/V93ytVnbwyb5WogiM1N38
         GPRUU22cGgRa50HWfsmTGjNekDHH0l9jcXoICtk0lIyyui1kCuFmo1B3ll5X0tdXQpSV
         9psRH0XVqSqG1r7H7oXbsH+9Wi7LZfmZdJChOOg+xk4E45akeLj4J0i/XJiyhppKeBbA
         XJH1ZXQJQUznda1sL0TuSNqgTcKZkPzkAsCmAaYphFrctWeIWtnE8bbBWaC2HCXE8mAU
         KGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sC6zeBvAQu12F4pHcyP2yBc/sNcvkHC/U+oaZNn0uLo=;
        b=AqNcaJYU2HXOHzqkm/zHr3K/WFmxDJAPzdEK7CD97aauxpf2XtDEim8NU8txphsBNe
         cMO+zL6P75o1AFav9JQf4zrSUoIvndKazVHx/8vbFBU4QMALRq98efyW75OVaYPlnIgE
         mrWJeJUBjnPadMAydh0aMtxadJEJZL38k/NX79GfiFnVcbvBf0b30G5I1ITa0xGUX+60
         eLy7j4m4GLk5dkQXbXVAMY7jiOG8H+OFmuZRZwJBzRlpZa00VodmD2EAP2IL3Jo1W1W5
         J9MmKQFJQSzqoHlRFcmRYMwJGWq8WWtpoStp8+NJgwCI8Tx75eJ8+uJDgMYBZe9yJ639
         3HgA==
X-Gm-Message-State: AOAM533SP2hFNvbPk3OTCB0CIOnfYcc++/aoPe/mv7dclGByFuWFZLJX
        Ha7osgyNBViZ0sxYTopYhe7pFBe4p7EWJQ==
X-Google-Smtp-Source: ABdhPJwvU2iJvb3e73vr/AtPaxjK1N67PxTbv0mAqo4AjvYN0nLyNkbBYaYk20Oy+vdCAtgTLvu7fg==
X-Received: by 2002:a17:90a:2e0d:b0:1c9:b839:af02 with SMTP id q13-20020a17090a2e0d00b001c9b839af02mr142074pjd.122.1649964414801;
        Thu, 14 Apr 2022 12:26:54 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:5b60:6a76:138d:2646])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b00505ff62176asm590060pfw.180.2022.04.14.12.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:26:54 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 2/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
Date:   Thu, 14 Apr 2022 12:27:24 -0700
Message-Id: <20220414192722.2978837-3-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414192722.2978837-1-dfustini@baylibre.com>
References: <20220414192722.2978837-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

AM43xx support isolation of the IOs so that control is taken
from the peripheral they are connected to and overridden by values
present in the CTRL_CONF_* registers for the pad in the control module.

The actual toggling happens from the wkup_m3, so use a DT property from
the wkup_m3_ipc node to allow the PM code to communicate the necessity
for placing the IOs into isolation to the firmware.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
No changes from v1

 drivers/soc/ti/wkup_m3_ipc.c | 14 ++++++++++++--
 include/linux/wkup_m3_ipc.h  |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 247a4b57a372..988162dd153a 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -46,6 +46,8 @@
 #define IPC_VTT_STAT_MASK		(0x1 << 3)
 #define IPC_VTT_GPIO_PIN_SHIFT		(0x4)
 #define IPC_VTT_GPIO_PIN_MASK		(0x3f << 4)
+#define IPC_IO_ISOLATION_STAT_SHIFT	(10)
+#define IPC_IO_ISOLATION_STAT_MASK	(0x1 << 10)
 
 #define M3_STATE_UNKNOWN		0
 #define M3_STATE_RESET			1
@@ -228,6 +230,11 @@ static void wkup_m3_set_vtt_gpio(struct wkup_m3_ipc *m3_ipc, int gpio)
 			    (gpio << IPC_VTT_GPIO_PIN_SHIFT);
 }
 
+static void wkup_m3_set_io_isolation(struct wkup_m3_ipc *m3_ipc)
+{
+	m3_ipc->isolation_conf = (1 << IPC_IO_ISOLATION_STAT_SHIFT);
+}
+
 /* Public functions */
 /**
  * wkup_m3_set_mem_type - Pass wkup_m3 which type of memory is in use
@@ -308,8 +315,8 @@ static int wkup_m3_prepare_low_power(struct wkup_m3_ipc *m3_ipc, int state)
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->resume_addr, 0);
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_power_state, 1);
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->mem_type |
-			       m3_ipc->vtt_conf, 4);
-
+			       m3_ipc->vtt_conf |
+			       m3_ipc->isolation_conf, 4);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 2);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 3);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 5);
@@ -518,6 +525,9 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 			dev_warn(dev, "Invalid VTT GPIO(%d) pin\n", temp);
 	}
 
+	if (of_find_property(np, "ti,set-io-isolation", NULL))
+		wkup_m3_set_io_isolation(m3_ipc);
+
 	/*
 	 * Wait for firmware loading completion in a thread so we
 	 * can boot the wkup_m3 as soon as it's ready without holding
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index 2bc52c6381d5..b706eac58f92 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -34,6 +34,7 @@ struct wkup_m3_ipc {
 	int mem_type;
 	unsigned long resume_addr;
 	int vtt_conf;
+	int isolation_conf;
 	int state;
 
 	struct completion sync_complete;
-- 
2.32.0

