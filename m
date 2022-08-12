Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F5590EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbiHLKMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbiHLKMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:12:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5567A98C6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p125so563905pfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=V7yMXZa3MywkOFBvlYMPqSqmCaZ5JNGIAqlkaSLZ/kM=;
        b=GUsQrErKwYfApaFW7t1aycaDDOcT4RNUbr8JoqRV/JeKU6zJZtEoluxB2oppeJz+c+
         uicrtsV0V2YYg4yrptx59NDO9hjcFwCQiWINbbZGDntxrXtgrUandYeo6JfRBNNiXqkO
         X+F5nDt6ITpzGdKmFJoiXZrl/hWAbj0LnZXL3QzrrrQwOS+wwzlGzn3bCbcHPl445y+U
         nk6kGyOxAT30qQy9rI9gbbQR79VBd0/FrHsxTCpwyW0NOfsh42UQiDnh6mRvNi2gHABd
         Klf3QM2nSSx8nIdpGoCKb1s+uqWvK8CgBYm/CnLRpaCRweC3Ap/D0sRqbw92h24VZ2TH
         Ol6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=V7yMXZa3MywkOFBvlYMPqSqmCaZ5JNGIAqlkaSLZ/kM=;
        b=dQGTBADCeQpwRvmZCzvHjI+GMZb/vzS/kr+AEqQq5feGxAzpBsTQCMzs49qU2+x6KK
         uT9/uXiaQWV2jR2zZIZ4j3sEhfpuMZ6RHX59Hah0UMg5446kTDGCqqn+hvuG3tfFt5rt
         zY0TxEGFMxOZKNcyqWw0MGiVTkZp6jdpko70Id0Sdp3iNSSFgim37Ux6nH8nlWP2oEjx
         JkNT2OGCUNTVtmMBN9W8198sARRt8mmviBp09AaEYcUzzpYkYiqz7gKT5P53Dm86yQJw
         LsJ7ec4xzig0sQVmwIYmjbjlx22DGkbYdQ1+AKWdQW36X02y1TUSAT8wRGjElj1mLZtA
         mk0g==
X-Gm-Message-State: ACgBeo3LGVpJxQ4TxUJ2Brhmxhvbviyq/+qS6dFgFwh5EgLGmQ4Ehsd6
        C0jB1Bd2kxWipVhnWzT2dJNgVVE8GWk=
X-Google-Smtp-Source: AA6agR7ruzvjPLVoqRS4ooTCRVR7Zek3i441oZSHEk/8OA3W9OWSqoZisu1kEC4y/u4cMpl7eVVPYw==
X-Received: by 2002:a05:6a00:328e:b0:52d:44e0:297c with SMTP id ck14-20020a056a00328e00b0052d44e0297cmr2943039pfb.64.1660299117343;
        Fri, 12 Aug 2022 03:11:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id gq20-20020a17090b105400b001f52fa1704csm16110031pjb.3.2022.08.12.03.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:11:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin16@zte.com.cn, CGEL <cgel.zte@gmail.com>
Subject: [PATCH v2 1/5] ksm: add a auto-run mode of ksm
Date:   Fri, 12 Aug 2022 10:11:52 +0000
Message-Id: <20220812101152.41479-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812101102.41422-1-xu.xin16@zte.com.cn>
References: <20220812101102.41422-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

Add a new running state auto-mode to ksm. This is to pave the way
for subsequent real optimization features.

Use it by: echo 8 > /sys/kernel/mm/ksm/run

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: CGEL <cgel.zte@gmail.com>
---
 mm/ksm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2f315c69fa2c..c80d908221a4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -290,6 +290,7 @@ static int ksm_nr_node_ids = 1;
 #define KSM_RUN_MERGE	1
 #define KSM_RUN_UNMERGE	2
 #define KSM_RUN_OFFLINE	4
+#define KSM_RUN_AUTO	8
 static unsigned long ksm_run = KSM_RUN_STOP;
 static void wait_while_offlining(void);
 
@@ -2416,7 +2417,9 @@ static void ksm_do_scan(unsigned int scan_npages)
 
 static int ksmd_should_run(void)
 {
-	return (ksm_run & KSM_RUN_MERGE) && !list_empty(&ksm_mm_head.mm_list);
+	if (!list_empty(&ksm_mm_head.mm_list))
+		return ksm_run & KSM_RUN_AUTO || ksm_run & KSM_RUN_MERGE;
+	return 0;
 }
 
 static int ksm_scan_thread(void *nothing)
@@ -2916,7 +2919,7 @@ static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 	err = kstrtouint(buf, 10, &flags);
 	if (err)
 		return -EINVAL;
-	if (flags > KSM_RUN_UNMERGE)
+	if (flags > KSM_RUN_UNMERGE && flags != KSM_RUN_AUTO)
 		return -EINVAL;
 
 	/*
@@ -2942,7 +2945,7 @@ static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 	}
 	mutex_unlock(&ksm_thread_mutex);
 
-	if (flags & KSM_RUN_MERGE)
+	if (flags & KSM_RUN_MERGE || flags & KSM_RUN_AUTO)
 		wake_up_interruptible(&ksm_thread_wait);
 
 	return count;
-- 
2.25.1

