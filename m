Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D830E5ACCA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiIEHVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiIEHU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:20:57 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469944549
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:16:15 -0700 (PDT)
Received: from HP-EliteBook-840-G7.. (1-171-245-2.dynamic-ip.hinet.net [1.171.245.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6E157408B5;
        Mon,  5 Sep 2022 07:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662362171;
        bh=AxoGxPzIGBk82efhqX6g3iPbBMkWiLAKN1Hpf2RJsSg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=uWx5B1BusH6AbgEUowJjnBUm/4LgXO1/88LuZ6D6EwY1WX7EEoRTD0z1wqop8Aky+
         80oDPgIIa/JNFvxbuK4EbiyG9i3ed675jDBKkSEKoAtBVeAusMEawMm/7cKD5qFYmF
         3SD0s/ESCkr1tbop81UDxW2y6GtzY/89HGA+WrYiuw8Q0wopXjaQzqOWy1iGFBZVSk
         nTKWcDCMi7pkfOENQPd57XNZrK5GRgrp4AnzZRW0pvf4yHjhrskc4okrO16UMFmTTv
         9v73IHNMRrMLhQeSOepMhlyt6SEKppkCDy7sbMgF5SPFkqHROIvF9rDDwEoQVRnpge
         dCNytOaeeKfpQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        tangmeng <tangmeng@uniontech.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] PM: ACPI: reboot: Reinstate S5 for reboot
Date:   Mon,  5 Sep 2022 15:15:58 +0800
Message-Id: <20220905071559.1576801-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
PowerEdge r440 hangs at boot.

The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
system reboot to avoid triggering AER"), so reinstate the patch again.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3c35445bf5ad3..c0b89007f0d1b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -254,6 +254,8 @@ void migrate_to_reboot_cpu(void)
 void kernel_restart(char *cmd)
 {
 	kernel_restart_prepare(cmd);
+	if (pm_power_off_prepare)
+		pm_power_off_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	if (!cmd)
-- 
2.36.1

