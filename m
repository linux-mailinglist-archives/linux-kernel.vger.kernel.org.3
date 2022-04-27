Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6551113A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358147AbiD0Gig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbiD0Gic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:38:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6E8DAC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:35:19 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 475D53F336
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651041316;
        bh=MmefrrBswVUvzgRTE2NPvGr6V97N4RUSYuDtOffwdhE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=WOpE5UR5Hz9Wqb7jVuBOD34t5HqqALrUbw80f/NF3nqejkDlBnzXoWTrqU1KVaS+3
         gBlCGfBcdr56tyU32fWHLEaqsGoLI8xNSjRpAIhnlvLh6gZPAgmiIyodbyK+vFefsZ
         x+030NI4Ssqpgi7XZXL4I8pTPoJQVw2uSjuXimdfK/jTvzDj1mLbBliDtl1oKy8n74
         ejaxvav2z9qh2sZEydH+8Miy/QhIx1C5GYjR35R1l3NTnyxBEWc9wooI0YVTG22VBQ
         yw8JIcu9qgjaRRwQROtD/vxYckeh+0NkaYUI1s1b+nR2pIWbh6xJf3br1FVr8BbP2U
         w6cdfg4CXGrSg==
Received: by mail-ej1-f72.google.com with SMTP id sc26-20020a1709078a1a00b006effb6a81b9so558822ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmefrrBswVUvzgRTE2NPvGr6V97N4RUSYuDtOffwdhE=;
        b=OTO5f/pBoxdStaDO6++ess5jYP8/GHdqhmuVna1rzCZFem9enqgeqiTuVoGfVF0Egp
         UU6/xMv5jZ7DkJwj+BeIQB3UCouV95RpBnVcouchXlU8WsXKfljjlzGQjM+2USRiIBwi
         qB1VPdna0bq2d9DcVZWvy1Rh+4TN10Y/RBHDEszMUZQ1SHRk7rdE2nCzuLyEAD/f6hQx
         xoyUnSdG4lKwlDymhMWeS+lr8yyrJksSyUsBp7GfDqon5iHK+JAnDkboWpUMyi01tCS2
         a6tn2QtIkMUoPqzK9iEXTJdKTUB5zZLAo4OIB5j/Y+7HL7ZDFtVXJG1Wk0zjr1AooADP
         U3XQ==
X-Gm-Message-State: AOAM530QDy9RU6izNwiYja/wR6df2aTDd/7Nb5TrpxVyImDz6kDdE7ni
        YxN+bAYwa7wHs26l39BZx1vjpa9Z/DDCYEtDh62G96X+N/KIZDe332YArP3gUxt6E3rYj9RMH2Y
        Hy6eSB5+2kbgmalkMy4QcBODq0RWQXs7cqoHMrVn8eA==
X-Received: by 2002:a17:907:3f9e:b0:6f2:b3d8:63c0 with SMTP id hr30-20020a1709073f9e00b006f2b3d863c0mr22671645ejc.86.1651041315960;
        Tue, 26 Apr 2022 23:35:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynnSs4jOFEV9GW6BdweHs2YdX16aH7caB5g2dU8QtqdplvwIlTdkiQMjPSuQftugFxM8nPLw==
X-Received: by 2002:a17:907:3f9e:b0:6f2:b3d8:63c0 with SMTP id hr30-20020a1709073f9e00b006f2b3d863c0mr22671633ejc.86.1651041315825;
        Tue, 26 Apr 2022 23:35:15 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm7696688edb.23.2022.04.26.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:35:15 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@protonmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
Subject: [PATCH] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files
Date:   Wed, 27 Apr 2022 08:35:04 +0200
Message-Id: <20220427063504.384540-1-juergh@protonmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ath3k driver loads patch and configuration files so add MODULE_FIRMWARE
macros to povide that information via modinfo.

Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
---
 drivers/bluetooth/ath3k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 88262d3a9392..56e9a64177ae 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -538,3 +538,5 @@ MODULE_DESCRIPTION("Atheros AR30xx firmware driver");
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(ATH3K_FIRMWARE);
+MODULE_FIRMWARE("ar3k/AthrBT_0x*.dfu");
+MODULE_FIRMWARE("ar3k/ramps_0x*_*.dfu");
-- 
2.32.0

