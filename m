Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176165A34E7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbiH0Fnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345214AbiH0Fnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:43:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05385A6C52
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y141so3438671pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jASm5F7IG0cL7Edz8ZOf/AbyNJZ6sd775ispaeESRb0=;
        b=LlGt7xzTTdWltBBfscH3BSZh4oMpIE6Zq9lTsDtVFCn9ZSLzIO6TXIAsl1u9Mt6lid
         QluHcnOEbixCBKBaLA3HKNvoAU5S2HQ7A6DBKHd7AGJ0EEHazsNIeuLkcmpu22HVS4+H
         jm2MqDosaxqY/Q/ELKSTR7YPAKp0yRLz9o8g41FZfoVClGMiYL0TDsByrZ99p94I8M/W
         hmhFQTr1pWtZYKJ2NbBei/HCSDNaqWgwRfdosnM3DhlaMXmWoWYMkpLvEAG7nGXFcTlD
         jpsvULkDX6tJ5w3k8UvzASoeYKf/FYJnUjQU9o0eHUIqtt1yUqaZ97Az+y5uQBTcEPjd
         NJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jASm5F7IG0cL7Edz8ZOf/AbyNJZ6sd775ispaeESRb0=;
        b=MunwyHgZ3RNQ7Q5/fF8YSDhJ9HMU8qqBjRededY/H20Mehc4agEqeqmKjeuLmA5JAh
         8+CZHejg7VEn8xqLQeVLBbrAoV+mV7zESuAFnPiekKj5WOxhDxcok8+ImX23pqFpYUMa
         mP4sb9jjFltotHnvPwC95exTRZnuNYVc0VNGpisQix7B8xQd62TUYDdTzFH9NJLRdKhk
         GBjaW9kT8hfGpwezop3Ir25z/FzqKKp68+ZfF2UB5+/jI4jleNvTkHyLsigkLmYksF7N
         cmqv5mQE4bZd/2GNXIJGYS8gwPWYdmBTkqUP2B200vAbWU041DNqhEimTal/LGiftCcx
         Nuqg==
X-Gm-Message-State: ACgBeo2ovbPlCk1u9OyJFSw/Ccju+TwvIl/7Rjl6sC/yG4/cJ3UHpyOb
        hND3HTHRMUB/x/z0i/gPsYPVRsTO6Rg=
X-Google-Smtp-Source: AA6agR7NQ9d38vvbPkD45s4BcRuGUJUo/DnO0kXvkozrMis+oPdIulBFulQV/r7MIzy0MEjv3tOasA==
X-Received: by 2002:a63:154a:0:b0:421:5af6:6247 with SMTP id 10-20020a63154a000000b004215af66247mr5897807pgv.353.1661579004868;
        Fri, 26 Aug 2022 22:43:24 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id cp17-20020a170902e79100b0016d9b101413sm2599283plb.200.2022.08.26.22.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:43:24 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>
Subject: [PATCH v3 7/8] memblock tests: add tests for memblock_*bottom_up functions
Date:   Sat, 27 Aug 2022 00:42:49 -0500
Message-Id: <b03701d2faeaf00f7184e4b72903de4e5e939437.1661578349.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661578349.git.remckee0@gmail.com>
References: <cover.1661578349.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple tests for memblock_set_bottom_up() and memblock_bottom_up().

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index ea79396e4611..c7490291c485 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -1679,6 +1679,50 @@ static int memblock_free_checks(void)
 	return 0;
 }
 
+static int memblock_set_bottom_up_check(void)
+{
+	prefix_push("memblock_set_bottom_up");
+
+	memblock_set_bottom_up(false);
+	ASSERT_EQ(memblock.bottom_up, false);
+	memblock_set_bottom_up(true);
+	ASSERT_EQ(memblock.bottom_up, true);
+
+	reset_memblock_attributes();
+	test_pass_pop();
+
+	return 0;
+}
+
+static int memblock_bottom_up_check(void)
+{
+	prefix_push("memblock_bottom_up");
+
+	memblock_set_bottom_up(false);
+	ASSERT_EQ(memblock_bottom_up(), memblock.bottom_up);
+	ASSERT_EQ(memblock_bottom_up(), false);
+	memblock_set_bottom_up(true);
+	ASSERT_EQ(memblock_bottom_up(), memblock.bottom_up);
+	ASSERT_EQ(memblock_bottom_up(), true);
+
+	reset_memblock_attributes();
+	test_pass_pop();
+
+	return 0;
+}
+
+static int memblock_bottom_up_checks(void)
+{
+	test_print("Running memblock_*bottom_up tests...\n");
+
+	prefix_reset();
+	memblock_set_bottom_up_check();
+	prefix_reset();
+	memblock_bottom_up_check();
+
+	return 0;
+}
+
 int memblock_basic_checks(void)
 {
 	memblock_initialization_check();
@@ -1686,6 +1730,7 @@ int memblock_basic_checks(void)
 	memblock_reserve_checks();
 	memblock_remove_checks();
 	memblock_free_checks();
+	memblock_bottom_up_checks();
 
 	return 0;
 }
-- 
2.25.1

