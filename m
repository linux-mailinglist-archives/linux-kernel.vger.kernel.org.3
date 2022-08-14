Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93A591E8B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiHNFyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbiHNFyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:54:23 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B45FAC8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j20so2492078ila.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SnDhYdrAcbvGcTO2vU9jv0bvWt3Yk1v2Rp41yYuWQ5Y=;
        b=jyJHJXdGgxnJHliMAK+EYrp/qvH6ThciPn+bCSwsOKziwkLyYX6MPGlVUCubMP5P+B
         NMtPAWl/7nwg8cUg8r65aQI8ncSmX7SyCprI3nRYU3kMd9Tjn4p9tQm6yA9z9nuUWVRR
         PxOqj7+jJ4gADUE6RYNu/tNkBl1TRNlgnyZ2B5BD67koCOumu4Sz9RSZ9CA81l9mxXdF
         DlUdLdP52LMVa0G5fWRZChr6PIYHdKelTe/PywwwtkTPJpJZp/xGG3Sl+O1fOUhoh607
         AClxX3snucMIc2jFqOEs9np8SalmREVGy4dQuVDKMDygLniWlBpWyWc8grFyeqZs6P23
         SwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SnDhYdrAcbvGcTO2vU9jv0bvWt3Yk1v2Rp41yYuWQ5Y=;
        b=Vzbg2ei00edXVlMxwcHx53HqxwK5RMe3en6Z3IhbnZ23bN9K81qQqM0Ng/tmlNYL9Y
         U5xeszFeLRzAypJA1ZhL0SUL8LJKWaSl+JD199B8dCXzaH5VQZYDbN3ioaQ+MUHSx5fn
         Yfgwwe1E3Fv0lHqZA9Bk0TIAZ0V8Q/hJtS3sdh7Y3ODC6m8sa0jSWvTA3xqFeU+UTU1t
         S7+MTOPbfVo8VI93Bbo+DLkvTwo4R88hSi9S84MNEMv5nENEAYKn4iMiLAsd+rJmO2yn
         BfiRgs56G2X0vNWBJMduco1yOINC9TpAlN65GykVMjB9LqVfPLOWmkIYiLL3q8Sm8sv8
         RNFA==
X-Gm-Message-State: ACgBeo2HsSkS8Zv2IInaxM3SkSuxJmAe8xbpC/GYk4FI40iml4r7+xgF
        dirTl+S/i5Pi4oS6GmBYgpao9hM1dUxWDw==
X-Google-Smtp-Source: AA6agR5A4fVnZwWVC2PDMrTvzD+FcOYVwxg8Kew9QoZsCBpzm3YWd171CU+xXOYjPP670UvnabnUhw==
X-Received: by 2002:a92:c246:0:b0:2de:b25b:e75 with SMTP id k6-20020a92c246000000b002deb25b0e75mr4859257ilo.246.1660456460564;
        Sat, 13 Aug 2022 22:54:20 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id d13-20020a92d5cd000000b002dd143ee62esm2648816ilq.14.2022.08.13.22.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:54:20 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 7/8] memblock tests: add tests for memblock_*bottom_up functions
Date:   Sun, 14 Aug 2022 00:53:59 -0500
Message-Id: <69524966ac92d93b45a8a8e739434d5fb31e3084.1660454730.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660454730.git.remckee0@gmail.com>
References: <cover.1660454730.git.remckee0@gmail.com>
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
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index ef5642d0863b..d7f008e7a12a 100644
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

