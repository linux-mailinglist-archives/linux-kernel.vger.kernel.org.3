Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A5653A4FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352773AbiFAMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352904AbiFAMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:30:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A106A87A29
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:30:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so6112053pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4bVw6gq8t0WVuGgY2zAvilf+MdDU3JFmE5ha/acZfM=;
        b=oIcEsTH3b5mXEb2Ia3i3UOeqlsqcRq8MBSyLyQThDEvng01ryIwMf03NfLD3AKtbk3
         jw6b7seXRuczB3gqFUYEdO5Xp/xEl3W7cT8yrgUpB8ReMyAVDbDLLiaJEhPuKEDZmoah
         rxIImweKZEk32i1HxGQ+uiDC9PXZ530B0wZR91ZTcGbAZirLIWVo8q0ufuiR8RXmZc1G
         cu/jfkhVi7d1fihVY8L+mMaQjrz0rN/KeYaXsj+/E63vy9PPqLqSKfKhKRoeZIlAvLrW
         ACZTebUc0fmGCeWL+YbY2M6lHkS7rECGmQrSkrmiTeFdVfxBWDq61LekP92CT8eUdZPY
         ZyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4bVw6gq8t0WVuGgY2zAvilf+MdDU3JFmE5ha/acZfM=;
        b=w3MUZ/AvbVwcz/oXIFu92I26K1sGQjT7vlGduyXf3G8CerPLxrleAXcQajmuNlz0uO
         KvUGwNiZSjwDyIm06gmCZLWDnzFjmTNllv+zHCTh3XQloMqGssx4/Xsz8ZQnvZzDYkM2
         rm3ZHKlUrOayDnRoKOuuk/eJ+Y/zVgIWXHSkl8sE3eOL9Be4gVh0YR4y0arVl/Er8ioJ
         +6PrWjJEcXCdwDiGUXq1IQLLLMwmjmlrVR04Xa7eWIxCJUTtSG/EJC+B36PdDHJ8OSt+
         TJ0gihYVQjFxEcqCek6/sX8bHbOa65VqEG2vxF3jfgkWFk6VG7RJx4oFbH3mn3DwOOE5
         wLYA==
X-Gm-Message-State: AOAM531K6dN9W3BvidoEVe8ZrMKUQrHC81d0x7UWED0Q9NNEPrJ7lAFV
        6+D10VO2sAyU05wsSiIvbGU=
X-Google-Smtp-Source: ABdhPJx8SOiW4AxKkDbo5IxtI8Cb1ZzMdPTjUqrkl0YtjgoZhmod06ZSz7bHjsBeqL9vdeKTquMa1g==
X-Received: by 2002:a17:90b:214b:b0:1e2:d777:934f with SMTP id kt11-20020a17090b214b00b001e2d777934fmr19989630pjb.193.1654086612156;
        Wed, 01 Jun 2022 05:30:12 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id g3-20020aa78743000000b0050dc7628163sm1352451pfo.61.2022.06.01.05.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:30:11 -0700 (PDT)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/setup: Move duplicate variable definition out of the if/else block
Date:   Wed,  1 Jun 2022 20:29:14 +0800
Message-Id: <20220601122914.820890-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the if and else blocks define an exact same boot_cpu_data variable,
move the duplicate variable definition out of the if/else block.

In addition, this patch also does some other minor cleanups.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/e820.c  |  4 ++--
 arch/x86/kernel/setup.c | 10 ++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..06ece49ac812 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -395,7 +395,7 @@ int __init e820__update_table(struct e820_table *table)
 
 		/* Continue building up new map based on this information: */
 		if (current_type != last_type || e820_nomerge(current_type)) {
-			if (last_type != 0)	 {
+			if (last_type != 0) {
 				new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
 				/* Move forward only if the new size was non-zero: */
 				if (new_entries[new_nr_entries].size != 0)
@@ -403,7 +403,7 @@ int __init e820__update_table(struct e820_table *table)
 					if (++new_nr_entries >= max_nr_entries)
 						break;
 			}
-			if (current_type != 0)	{
+			if (current_type != 0) {
 				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
 				new_entries[new_nr_entries].type = current_type;
 				last_addr = change_point[chg_idx]->addr;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c95b9ac5a457..bb3451d3e548 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -115,11 +115,6 @@ static struct resource bss_resource = {
 #ifdef CONFIG_X86_32
 /* CPU data as detected by the assembly code in head_32.S */
 struct cpuinfo_x86 new_cpu_data;
-
-/* Common CPU data for all CPUs */
-struct cpuinfo_x86 boot_cpu_data __read_mostly;
-EXPORT_SYMBOL(boot_cpu_data);
-
 unsigned int def_to_bigsmp;
 
 struct apm_info apm_info;
@@ -133,11 +128,10 @@ EXPORT_SYMBOL(ist_info);
 struct ist_info ist_info;
 #endif
 
-#else
-struct cpuinfo_x86 boot_cpu_data __read_mostly;
-EXPORT_SYMBOL(boot_cpu_data);
 #endif
 
+struct cpuinfo_x86 boot_cpu_data __read_mostly;
+EXPORT_SYMBOL(boot_cpu_data);
 
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
 __visible unsigned long mmu_cr4_features __ro_after_init;
-- 
2.36.0

