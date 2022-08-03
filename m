Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB42F588A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiHCKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiHCKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:05:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA67E2C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:05:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 17so16065983pfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=V7yMXZa3MywkOFBvlYMPqSqmCaZ5JNGIAqlkaSLZ/kM=;
        b=ipjbvHg48fVyW4jVX5gIjrnxkQ8/Uun3HS5plAciRpFp9N9V56WtAuDOfPwusWnA0M
         Ra3acdntu7vD9oDei3ZjYZSowPGpmY07igPy8HRpVLkeTkcf31OxvmQ+go0em31ADw2e
         xdPeXir+TMMAUQfNFeBjzEWoAsiIjC4BmO0xeqiO4pqM8SABLHZjevqyqoxRcIqtfqsO
         QpROXLlVD+2olAHOIGCTIU5YWCf1IkbU4LJf1AEX7ZQI0AHQPwQRKNc9+Tr6t91wITSV
         W9wIQoLg2vLppCaaIrBWQx3tzEu90iHp/9ztRKJxAbAa4Jj6VCf5dDziuLsHdXDuscqC
         Zwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=V7yMXZa3MywkOFBvlYMPqSqmCaZ5JNGIAqlkaSLZ/kM=;
        b=pPOY/FxMoVLrth/w7LWHY2TSIO9nypoFg0oLAV2B3NKIL00Go596fmI+oxkqu3LV41
         Na+WoFDDHZKg5Iu1Vb0D3cVfiGsCejUgPiNqLybIHcotkMsgozhKVNu4UJur9XLTvuys
         /OsqbOqS4EdTCB8XlZ4ZpaQpbEsz4Jp5o35YTEG8bdW5ST95W/wE9YEq3m5pN4rlDXnb
         VrOi5UpEUikNAXKOGQRssBHs9WspwtwluqP5mP5GvpIKQEC+Z7wkc2Z21wtP0DHLnVtR
         1QBzBN8/9tlMTFYSbwderTgoAbaOUlyWnxC1O55Flwx30Yej5ED5K4mzbeu4+DuA8QPp
         gwPg==
X-Gm-Message-State: AJIora/z2651XNAQtwMFcA3S3KWJTzPsC+wkS60lt9yFPreH1+QuCS0n
        TgIp5XbaT6Rooruyvz+i3bFSuL9KZ5s=
X-Google-Smtp-Source: AGRyM1saowNGHUEc91GATroNAs1Ulpr9zGAqAodgHMmGAOrGXpFhOyI9NrSJEWMx+FVvZRavoC9blg==
X-Received: by 2002:a63:c10a:0:b0:41b:f15:f9c4 with SMTP id w10-20020a63c10a000000b0041b0f15f9c4mr20763742pgf.72.1659521123115;
        Wed, 03 Aug 2022 03:05:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902d58e00b0016b90620910sm1455917plh.71.2022.08.03.03.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 03:05:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.con.cn
To:     akpm@linux-foundation.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        CGEL <cgel.zte@gmail.com>
Subject: [RFC PATCH 1/4] ksm: propose a auto-run mode of ksm
Date:   Wed,  3 Aug 2022 10:05:14 +0000
Message-Id: <20220803100514.1653440-1-xu.xin16@zte.con.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803100306.1653382-1-xu.xin16@zte.con.cn>
References: <20220803100306.1653382-1-xu.xin16@zte.con.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

