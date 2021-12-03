Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C682046700D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378074AbhLCClO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350764AbhLCClJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:41:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59DBC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 18:37:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so3757913ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 18:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+wFTtvlBsypOIxUwrXusJb0tjD/aJF4yN76zKAQ13mg=;
        b=Xt7MzYO3v/bRasrX9w7a47HtnQLDghV/M1u4UAfzoIM7Gwd7vMjZL09IkLQ+VAgqRi
         j1Z+inu5UwPpvTrW4MPQTDeKUVN//EDHNNnl0LdSborNpfMKfSnkLC+EsZjNnYt691Vc
         lvR0dRonxqNafyFwogHxYA6C5E59f5YgeuCxrgzSH1/G9rb0CrUE1yNvplA0/rz9oC84
         S6yKzne8BJLcwCGOlRiRnhSh8nuHL1kOnPl62I2fuM+IER0UF+YGXcNBdHZqVHyNyfz7
         0cPj8ELpgjd37Fx5ykBclsOkCHMM7KhkjcH8Y2dwzm15cmlyMG1BlKaq1yX7tD8+tJ9t
         LJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+wFTtvlBsypOIxUwrXusJb0tjD/aJF4yN76zKAQ13mg=;
        b=4TZwDefqUuAcyWi/mW0oOtP77Y/3kA9GgtB+tSYpLA1BIPxZV3i2zZTCsANUD7LvZB
         2yH1KWzjc5sTe4InqB2zXEPwhqaStoKIyWyCH1avfdXFS1umJl8peGT8zmjBNCsPb1iP
         EWb/vJlTW5N/msScYIHXNcwpCNyxjDeyZAizqtnrAz8pl1rY6NW7GpIVLvf0ztvX4OFq
         lm3oU40fK8/CaE96lWohFakBK8EOmyMBJCIZ1H/Xgbal25/lN355FUOT3w4+JfC9agP+
         ufoKuGjrCfz01RGbwmlaoo71vQ1GCzV7CcL9kz/bkCyf9fO4gY48VvBkpHqNT2JyQyEp
         Kmtw==
X-Gm-Message-State: AOAM530M9lduGNDZ2PulnyttLRFvMr0XWg362zBYborO3975yKhMixWm
        6wI36Fkq+GS2Azp/HmDDZfIu28fUyf9E6dRGZZfczudoVNVimOsgJSYcozGhsDo4e2QjoxI8E29
        2q8HXtZg7pIaDHF21xD6kNOLJqAnWuGmfXhz5iUAfXoBVo2NIreZA3GqqUoQ/8+HC4Y0HAs2c
X-Google-Smtp-Source: ABdhPJyAXcscghDoENH07S/43gSKtbux83/rys5yj/UxH0ZoJhfg/cUXH8BbweI9XPBZR6nDR5XJxUPVWpNC
X-Received: from suichen.svl.corp.google.com ([2620:15c:2c5:13:bc47:f5e4:20fa:844b])
 (user=suichen job=sendgmr) by 2002:a25:d9c5:: with SMTP id
 q188mr20212190ybg.630.1638499065976; Thu, 02 Dec 2021 18:37:45 -0800 (PST)
Date:   Thu,  2 Dec 2021 18:37:27 -0800
In-Reply-To: <20211203023728.3699610-1-suichen@google.com>
Message-Id: <20211203023728.3699610-3-suichen@google.com>
Mime-Version: 1.0
References: <20211203023728.3699610-1-suichen@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC Patch v2 2/3] i2c: npcm7xx: add tx_complete counter
From:   Sui Chen <suichen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au, tali.perry1@gmail.com,
        benjaminfair@google.com, krellan@google.com, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tali Perry <tali.perry1@gmail.com>

Add tx_copmplete counter which increments when a
valid transaction completes.

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index 2ad166355ec9b..0b87706de31d7 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -314,6 +314,7 @@ struct npcm_i2c {
 	u64 rec_fail_cnt;
 	u64 nack_cnt;
 	u64 timeout_cnt;
+	u64 tx_complete_cnt;
 };
 
 static inline void npcm_i2c_select_bank(struct npcm_i2c *bus,
@@ -684,6 +685,8 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 	switch (op_status) {
 	case I2C_MASTER_DONE_IND:
 		bus->cmd_err = bus->msgs_num;
+		if (bus->tx_complete_cnt < ULLONG_MAX)
+            bus->tx_complete_cnt++;
 		fallthrough;
 	case I2C_BLOCK_BYTES_ERR_IND:
 		/* Master tx finished and all transmit bytes were sent */
@@ -2223,6 +2226,7 @@ static void npcm_i2c_init_debugfs(struct platform_device *pdev,
 	debugfs_create_u64("rec_succ_cnt", 0444, d, &bus->rec_succ_cnt);
 	debugfs_create_u64("rec_fail_cnt", 0444, d, &bus->rec_fail_cnt);
 	debugfs_create_u64("timeout_cnt", 0444, d, &bus->timeout_cnt);
+	debugfs_create_u64("tx_complete_cnt", 0444, d, &bus->tx_complete_cnt);
 
 	bus->debugfs = d;
 }
-- 
2.34.0.384.gca35af8252-goog

