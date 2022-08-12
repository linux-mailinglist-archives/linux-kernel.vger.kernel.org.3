Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA67590EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbiHLKNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbiHLKMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:12:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB5ABD4D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so514847pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1LS1w+4gYbBOJ3fgeWTMSBRNuWyP/hHFUM4MmFgbaww=;
        b=msf5OTF6rIik/luYMAcgB2uHDsWClBvHa1lbsogrHOmhX/n4FGKKX6qj6huLVdGGzM
         ICrQklW4Llnhk7Cyj44kXIqUJIXhyyrrKsvx+cNnGwdwXG4FZCKzwCXaRKw0Jdwu6/Be
         DQlu8saNmWgFOWG8h6+e0upSdMKZ2xgRkAzxSSe7F3jMKdYlqo83I6pww/xD/wwIfTax
         huQ3rvNDB/dzqZX0XhmNlADww25qcPliC0EW9QNCAw19rOE9d3j8dalYcd90puCvT3vO
         xWKxHZut21wxhoy+khsI7tDM3wgJfD0wFJJL3sO6aNdYvxnqrgZlxEpMnH5tXCJ5QdeJ
         CViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1LS1w+4gYbBOJ3fgeWTMSBRNuWyP/hHFUM4MmFgbaww=;
        b=zNRcpdoeKf7FsTP0IZVqyPxcTn9bsrua4kzLv5qojlFS/KwBbii6vq67EqyFe5DWDV
         ZYrUtK86tJpQsiFjwQKQBj+X7TyQiV1fA3fONMXnDmsgkLWNg/QCrs6G9+8C5hAF4Rm9
         +sGhQ0r9VaTrdrfQSvDHueQ9ovCKih0jTh7X5yHFO8vt7DGACr/Su4hz3WW9Cu36U2TX
         6zlVKK2A/WQtw4HhNt17v86Mnvkja5wZr9YRCh++uyiUgtQJJsPUS78p5IEzeLjYfLfu
         IQAGvSD91VDnkq548A65z1v0ETU6AU7nlYbzHC/Q6NN3W1A2irn7via3zyQY/49K3ii4
         5zLQ==
X-Gm-Message-State: ACgBeo0s44IQpx1FmSwMI5PMBSeav9C1AFjvS3MzcoKIWlNyHLe1HzHt
        MDM+nCbsuuYQ8v91Kt2rYag=
X-Google-Smtp-Source: AA6agR7DyayXx1NhvFW/woPbk9r5UkcpGW14C9iIDwV3bfot22BChYdXQe8pWawSmvcYPnZeOr7zDQ==
X-Received: by 2002:a17:90b:3b49:b0:1f4:df09:d671 with SMTP id ot9-20020a17090b3b4900b001f4df09d671mr3408405pjb.129.1660299148170;
        Fri, 12 Aug 2022 03:12:28 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mg21-20020a17090b371500b001f30b100e04sm4973885pjb.15.2022.08.12.03.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:12:27 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin16@zte.com.cn, CGEL <cgel.zte@gmail.com>
Subject: [PATCH v2 4/5] ksm: show ksmd status for auto mode
Date:   Fri, 12 Aug 2022 10:12:23 +0000
Message-Id: <20220812101223.41641-1-xu.xin16@zte.com.cn>
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

Add a sysfs interface of ksmd_status to show some details related
with auto-mode.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: CGEL <cgel.zte@gmail.com>
---
 mm/ksm.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c5fd4f520f4a..478bcf26bfcd 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -307,6 +307,9 @@ unsigned int ksm_auto_threshold = 20;
 /* Work in auto-mode. Whether trigger ksmd to compare and merge pages */
 static bool auto_triggered;
 
+/* Count of times that ksmd is triggered due to low free memory */
+static unsigned long triggered_times;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -2487,8 +2490,10 @@ static bool should_trigger_ksmd_to_merge(void)
 
 static inline void trigger_ksmd_to_merge(void)
 {
-	if (!auto_triggered)
+	if (!auto_triggered) {
+		triggered_times++;
 		auto_triggered = true;
+	}
 }
 
 static inline void stop_ksmd_to_merge(void)
@@ -3118,6 +3123,40 @@ static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 KSM_ATTR(run);
 
+static ssize_t ksmd_status_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	int len = 0;
+	unsigned int mergeable_mms = 0;
+	struct list_head *pos;
+
+	list_for_each(pos, &ksm_mm_head.mm_list)
+		mergeable_mms++;
+
+	if (ksm_run & KSM_RUN_AUTO) {
+		len += sysfs_emit_at(buf, len, "mode: auto\n");
+		len += sysfs_emit_at(buf, len, "auto_triggered: %d\n",
+						      auto_triggered);
+		len += sysfs_emit_at(buf, len, "mergeable_mms: %u\n",
+						       mergeable_mms);
+		len += sysfs_emit_at(buf, len, "scanning_factor: %u\n",
+						       scanning_factor);
+		len += sysfs_emit_at(buf, len, "triggered_times: %lu\n",
+						       triggered_times);
+	} else if (ksm_run & KSM_RUN_MERGE) {
+		len += sysfs_emit_at(buf, len, "mode: on\n");
+		len += sysfs_emit_at(buf, len, "mergeable_mms: %u\n",
+							mergeable_mms);
+	} else if (ksm_run & KSM_RUN_UNMERGE)
+		len += sysfs_emit_at(buf, len, "mode: unmerge\n");
+	else
+		len += sysfs_emit_at(buf, len, "mode: off\n");
+
+
+	return len;
+}
+KSM_ATTR_RO(ksmd_status);
+
 static ssize_t auto_threshold_show(struct kobject *kobj,
 						struct kobj_attribute *attr, char *buf)
 {
@@ -3355,6 +3394,7 @@ static struct attribute *ksm_attrs[] = {
 	&pages_to_scan_attr.attr,
 	&max_scanning_factor_attr.attr,
 	&run_attr.attr,
+	&ksmd_status_attr.attr,
 	&auto_threshold_attr.attr,
 	&pages_shared_attr.attr,
 	&pages_sharing_attr.attr,
-- 
2.25.1

