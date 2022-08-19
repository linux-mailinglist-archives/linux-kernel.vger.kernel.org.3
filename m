Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9B59980D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347430AbiHSIw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343696AbiHSIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:52:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF56EA8A0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:52:53 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h4so2861703qtj.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jASm5F7IG0cL7Edz8ZOf/AbyNJZ6sd775ispaeESRb0=;
        b=TRa8ABit0XQvSbDR2dM/OYiebLfodgmI9pv5uHw4sJ1x5pS2tAP3hILJXO22stjVWb
         SsR5IN16WTY4P92/+DPl5Ow511nagAwV5YqxOlirPhX8SP7KStqpyD3Ig1kS8ontazEr
         Hb5Uf67GcRPKsm25fBmfy6toELEBKSu0uUnNnLJsSe19J55ZEBSMEZxt06Jkwymx/b+g
         tgt/bbCv1ZkYkPObpzne8bGuFL9Vf3tpTMXnM3NKXtmZEVGMVzU1XwBNwHnvovNly1XY
         z3/26FYTFgLvsXsbzYoT7tJnnSJ5uISbUGpqQnE/+4SmVl1TLTodMyRp1xFvyEg0z5B6
         5nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jASm5F7IG0cL7Edz8ZOf/AbyNJZ6sd775ispaeESRb0=;
        b=u8R8VwOmz7kzf8XooV9lDgL2xMkP5Q1NUvIfEIMzNaW3tLacyV2JZfQXVPky9Qg+aK
         XbTJtxUAJ1fnlLta1BMy91FcIW0pSkRFaC9gTlbSKFLJTOwCBP1PWR33HltbqLwtKN4u
         U9Sk0liNOQqPyYf7qcfbbG2N74hsl3ElhvZf8Os+Kwtvo1btcEp2HDy5VnklC3uKqxTm
         KkDYiqthuqlDOqieFV0pSsYD+wm9W5EPFPWmSprky8M2N7RYfS2bgJ9WJz+kTyTtj6Lz
         +g3WdH35J38kOa0i5vBjz6RSt6RW5ndHHrQLnkXyQD+wvs3rz3jWb1AHZkA4/d4/BOaL
         hTGA==
X-Gm-Message-State: ACgBeo1oQn9auxpQAvPNMBQKv1YoRG0si0nDBu/2LElvnxmVyRPqXmA9
        q9wv97+BFKYi2Zd2GM4sHVE=
X-Google-Smtp-Source: AA6agR4AYmNMNf30kl/3P5ZoHdVZkf0G2VyOjgLq3MTmBmirkaXdSrwX7sXzYxmDCuKFMrlu3u5GjQ==
X-Received: by 2002:ac8:5d89:0:b0:344:7c2d:92ba with SMTP id d9-20020ac85d89000000b003447c2d92bamr5451296qtx.124.1660899172229;
        Fri, 19 Aug 2022 01:52:52 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id q1-20020a05620a0d8100b006bb2661f3fasm3648840qkl.133.2022.08.19.01.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:52:51 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>
Subject: [PATCH v2 7/8] memblock tests: add tests for memblock_*bottom_up functions
Date:   Fri, 19 Aug 2022 01:34:55 -0700
Message-Id: <dc0ab2f907e746ea8304ab0fb8e093192711e6f4.1660897732.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660897732.git.remckee0@gmail.com>
References: <cover.1660897732.git.remckee0@gmail.com>
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

