Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6B47C531
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhLURoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbhLURod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:44:33 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C23C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:44:32 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v1-20020a17090a6b0100b001b12c84a1b7so1719902pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yQVcC55OoadpUPJm5lgEHKled6Uu3AS/23JgHN3JweM=;
        b=GiDwlFY4PevNZXTZxjYnA+LOJzLzost4vNTVzsrNvamLrnwxkYJYAaMz4PD5VxO/tq
         fXiy+gfDB17AzOm9ExFT9g4+nJMacXzvQmHqhjP1i2CrisMeEvfX7zcFqxRtGF/i38x5
         DbDdCZEdrp8ldNKoPo/hCA3DepLd8fQ882lLlCSRVrU4P44PKojnydVKH/7l/jMOAeJ4
         /2BuLQt3Nh8bFYth2C+kGhwX8fh897taYbjW+WT/jfhohd4okyf4OLXhpWc8GwGcQOZo
         LJqY5OqXrioPP7FVVEor+qksnpyMr36QEDSYU0bhHD6oi1DjTcg8ZYLGjhAc+6HxEhSc
         8AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yQVcC55OoadpUPJm5lgEHKled6Uu3AS/23JgHN3JweM=;
        b=eGBgNQEpzgjaYs66Q2JI4gd825KV02BRWIg1dap45g1L7ECQ9O6nqut9n1Zb3LFzJa
         6oCq1mKm0OjcuKhvdgaa1sFqQoR4RCNm7CAlAVWBcppV/270XUdTktNVKQqTIBm1Y1L5
         JJLT9nJdtCegUTfCkmX5R9d9Ev18Cf33EFaFyIIB1xkRue0P4bh13rEMSQv5+4rsd2rJ
         WRVR7/GQZ1qospWLU/hOFq/dgqDhQPBjdJCsUBqo8uPKlnxu5v3YYFm7tP/KzCIrhuPu
         ZimY0KoVF/TpyC+S729/1hm1MB6e1AxbQM0gWck4pgbKj9BlXmqS7psoaou3peJzC1ud
         YRug==
X-Gm-Message-State: AOAM532KmejSVFPDWZDKAWtlv5+vU2S2rhPklsr3TrzqYqB2/EmVAMs2
        eFNeMdPl7ZdDnXuWcdDk5EnGoDydDnzblYVbtIGXu08ym/R6o2N22t+NjeVpRP69BZGRnsoauPF
        z2Z4DhCFwmOTmgCR6FuKByJribRMVt49c2wrICu6MpPrUyMQeaqpl3v/8aaaSEZcnKzBLfrB7
X-Google-Smtp-Source: ABdhPJy1QkR7/Vg/h/zj3GiBFEnfoUAbZdCXSJyAJqx7x75BiMeFHNxASCd5GeldXB+EfbmjW5UqUdXWfz5k
X-Received: from suichen.svl.corp.google.com ([2620:15c:2c5:13:19fd:5987:f46f:7488])
 (user=suichen job=sendgmr) by 2002:a17:90b:798:: with SMTP id
 l24mr5338989pjz.122.1640108672149; Tue, 21 Dec 2021 09:44:32 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:43:44 -0800
In-Reply-To: <20211221174344.1249202-1-suichen@google.com>
Message-Id: <20211221174344.1249202-4-suichen@google.com>
Mime-Version: 1.0
References: <20211221174344.1249202-1-suichen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [RFC Patch v3 3/3] add npcm7xx debug counters as sysfs attributes
From:   Sui Chen <suichen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, andrew@aj.id.au, tali.perry1@gmail.com,
        benjaminfair@google.com, krellan@google.com,
        Sui Chen <suichen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds npcm7xx debug counters as sysfs attributes using the
i2c_adapter_stats_register_counter function.

Signed-off-by: Sui Chen <suichen@google.com>
Reviewed-by: Tali Perry <tali.perry1@gmail.com>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index cc7abd0b870be..c3ba5f3d33af1 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2228,6 +2228,15 @@ static void npcm_i2c_init_debugfs(struct platform_device *pdev,
 	debugfs_create_u64("timeout_cnt", 0444, d, &bus->timeout_cnt);
 	debugfs_create_u64("tx_complete_cnt", 0444, d, &bus->tx_complete_cnt);
 
+	/* register debug counters in sysfs */
+	i2c_adapter_stats_register_counter(&bus->adap, "ber_cnt", &bus->ber_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "nack_cnt", &bus->nack_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "rec_succ_cnt", &bus->rec_succ_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "rec_fail_cnt", &bus->rec_fail_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "timeout_cnt", &bus->timeout_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "i2c_speed", &bus->bus_freq);
+	i2c_adapter_stats_register_counter(&bus->adap, "tx_complete_cnt", &bus->tx_complete_cnt);
+
 	bus->debugfs = d;
 }
 
-- 
2.34.1.307.g9b7440fafd-goog

