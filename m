Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172635A51AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiH2Q00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiH2Q0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:26:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF1E7CB78
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:26:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso15208269pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sCQOXjIRhx098eyDLNjkm2xdki3mFdMs6DS03OL+UzQ=;
        b=T7vI8ltKs6VHkcjxGMChvB0qz4gQxcghfiSNIA+cFuVwoLtYAWh6b8UobIkdoA4YDc
         Zf5a0bQ10JmB8WcLMPTzViqzzQqJro28/TS0rcUdb+k8ijmK4ifk2eSg2ZbvYkybVdal
         13r160mDvh01BPA8iT5xkP1BcEJT0wfQIPEd+PeRJ97DOViRhqtcbNIeVBh+1OxT9N56
         H+InE9/40xoewLd7EloYTEl1CJttijMj1QDJ94QwKc6cbJbPoedNB0YokudzHhQyjPRw
         h/Y6HgZRLPTnIRCR1aEPXe3WjGuQQuAd2f5muIad9Iob7e5qdN1TH3/5XJN1oxkZgdB3
         3bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sCQOXjIRhx098eyDLNjkm2xdki3mFdMs6DS03OL+UzQ=;
        b=QyCuVfBpbz+DHrD9/IducUaVbfSYawd9n60UZXL3CPzYjv4b89SENEJoLbMqEWt7Gj
         6gy+71wiiwOReDokgLpou1G0udDzATOlLpT2fiBNdKFKEW31MjNYxcNM9ju5YPXj1BPC
         w6H2OG55lm1rSjF8yIizzakPyDkXFVIHZ+ytuHRNiimOdGZin8GNOP94OQA3XZvaJIYi
         DA0Vfwl9uV8l4aNzcEvO1ohRfdCfaq7gEHsix+HVO7YscqIWd7ZpIAB/NREdp2be+BDw
         rQ/KOGk3hlNG0w54fflYzeCiJV+S3soQu1ZiWfS7SfFY80iCQu43JxjVXR2Nu9jSWzi0
         yj2g==
X-Gm-Message-State: ACgBeo3ssj/2J9JQ++IJ/ywIOYnKKSwBoR/662AN0CKXWCD1+zwZskjW
        ctZCJ3oulvFIVXxVYV0PqJIULozDf7Y=
X-Google-Smtp-Source: AA6agR4i3guSKlTbUhr4lF4mL1CrpYMiQD+HjyyN8n9KfAi+HUSlAcVEwgfDn4X1JTy68OkE2vbMGQ==
X-Received: by 2002:a17:902:7582:b0:172:db9d:99de with SMTP id j2-20020a170902758200b00172db9d99demr17305618pll.125.1661790375160;
        Mon, 29 Aug 2022 09:26:15 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b0016dbdf7b97bsm7813008pls.266.2022.08.29.09.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:26:14 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com, rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] audit: use time_after to compare time
Date:   Tue, 30 Aug 2022 00:26:09 +0800
Message-Id: <20220829162609.25105-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

Using time_{*} macro to compare time is better

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 kernel/audit.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index a75978ae38ad..9bc0b0301198 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -321,7 +321,6 @@ static inline int audit_rate_check(void)
 	static DEFINE_SPINLOCK(lock);
 	unsigned long		flags;
 	unsigned long		now;
-	unsigned long		elapsed;
 	int			retval	   = 0;
 
 	if (!audit_rate_limit) return 1;
@@ -330,9 +329,8 @@ static inline int audit_rate_check(void)
 	if (++messages < audit_rate_limit) {
 		retval = 1;
 	} else {
-		now     = jiffies;
-		elapsed = now - last_check;
-		if (elapsed > HZ) {
+		now = jiffies;
+		if (time_after(now, last_check + HZ)) {
 			last_check = now;
 			messages   = 0;
 			retval     = 1;
@@ -366,7 +364,7 @@ void audit_log_lost(const char *message)
 	if (!print) {
 		spin_lock_irqsave(&lock, flags);
 		now = jiffies;
-		if (now - last_msg > HZ) {
+		if (time_after(now, last_msg + HZ)) {
 			print = 1;
 			last_msg = now;
 		}
-- 
2.20.1

