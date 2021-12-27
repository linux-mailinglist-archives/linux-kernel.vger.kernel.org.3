Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B947FDB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhL0NoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhL0NoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:44:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA8C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:44:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z3so11422381plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKaeGvKsgz1NPAETdUyyuQXcs7MwaUt/lx89zUZvzZo=;
        b=ueQSMq1L2Q8jqOBJ/9e7mM3t/txKJJK4iGzCVib6uNxcO8i5+FSOz4D7PDABlsiYAi
         MqZahgIsoL5+ZA+uZti2FXkk1f/HEBsK+9ILFH2enjcxn1I7F8JviVXGTY+u8KK9/vhM
         O8fUZM9KzPNi5lZcjL7+Ia4htxBbZo2q1wA6AxO4v0RfBtiEx+DVGXX0BXF9WtdqOP5s
         v4qemMj1Uj33dBPdIuWDMQWxchnnnKEM2M/IBi2JplCha0COA/3AjNiGP1hr/vzfMGEm
         XI0Us+a1lKyUg2LCGhnpX3EyudCSNPU2TaqxuKIS00LKdbL82MWBPIeryUr38y2hq3Qn
         bFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKaeGvKsgz1NPAETdUyyuQXcs7MwaUt/lx89zUZvzZo=;
        b=Z3kPfT1hE3B0sgn46O06EdEJTxyhZxzyUQVFwZbxMhWIoJJf+58FS0z1iCanrnDk2O
         K8LdHqKlvviosC8zSET+a1fH1gwLX6/qjtE2bnZVfB7YCPNzB9mxBz7zPXJsEg4FRa8k
         zNCqFwRZdpNA5O0MSFjik+bEydcaIV06bCRupLkxHZvJMvVPdOrrTWrDq4hKkJ+M6jJH
         eBPuLvLZheHa0QLvqoMp5/AfyCnUgWv9hRsJa+H/zMtx5fFrdGOW1UJ/HYppHN6IVh9y
         Two+JWs0b0vUmWdHJFtniHddERvgAfohE44TCY8ZGbMz0+DgEAahFhYhzQ+el0STNBw5
         FKpA==
X-Gm-Message-State: AOAM532BuHaU+xVOPWXHw6ZBHL/ISkh6F1r66oXY4aqjw5POTHSPi6oM
        HIVAHNXaW68nGRRRX9oHcw02Mg==
X-Google-Smtp-Source: ABdhPJzfJNUvgZbas+4u8szAM5yE516keyfpaRaol+EdVA/Io9lqa9kPLNKJ60KTlDxajc8+20uQvA==
X-Received: by 2002:a17:902:f702:b0:148:a2e8:2775 with SMTP id h2-20020a170902f70200b00148a2e82775mr17417853plo.124.1640612660082;
        Mon, 27 Dec 2021 05:44:20 -0800 (PST)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id p13sm8084217pgl.23.2021.12.27.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:44:19 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     tglx@linutronix.de
Cc:     dzickus@redhat.com, peterz@infradead.org,
        Gang Li <ligang.bdlg@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] watchdog/hardlockup/perf: downgrade log level from info to debug
Date:   Mon, 27 Dec 2021 21:44:08 +0800
Message-Id: <20211227134408.13467-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This log often flushes out other logs. So downgrade its level from
info to debug.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 kernel/watchdog_hld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582ca..d7dbe69a14d70 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -194,7 +194,7 @@ void hardlockup_detector_perf_enable(void)
 
 	/* use original value for check */
 	if (!atomic_fetch_inc(&watchdog_cpus))
-		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
+		pr_debug("Enabled. Permanently consumes one hw-PMU counter.\n");
 
 	perf_event_enable(this_cpu_read(watchdog_ev));
 }
-- 
2.20.1

