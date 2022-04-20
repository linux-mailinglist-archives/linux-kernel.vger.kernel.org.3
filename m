Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40872508A03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379282AbiDTOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379228AbiDTOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:08:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E73E0DD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:05:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z16so2031254pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOKJyrS8QtzQoeHSOkLR7Y1klkfAcATQqfMHIhBU3dw=;
        b=ZX3TjlWVIUa6DvnJkhrX3gVqjsqt6eo7qvybPLa7T6oIsBDQw7Mb0r7DCJog0kL2Ol
         UH0MM6WRaZpuwbYQKyYfRLfEjhOsTDGfL4Bpga8Bv5xTUWvAWbWWcSd8XejK2Pd5cVf6
         hGkgMpxNaZq5N7U69xre+mNALmWV1kex7FWpXVXvpPwDYweXGLrLQQaVXgM+1M8gER/z
         rUqaOucEHqdNVbx5YKuzMOL3zJ4XqLPkZ7/8kc+3mgeBpAOh0vo4LgmU1s51Al+K2kO7
         hMHMYe0j+XJA0PIpN7aQJV+9W2BxmpwpyNQ/JNT9qTpbfaBjPcewH+6wHkwtTG/FmEEC
         BG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOKJyrS8QtzQoeHSOkLR7Y1klkfAcATQqfMHIhBU3dw=;
        b=SJa5QR6+nhbqhfIhDJPckvn167oY2Fy/tFAAuCMJyoKBrxOlwglnMPY+jNPM0zzSRc
         i7bh3iHUE5pz3AqyY+PZ55i7EAiOBkg4y0E71cYX6/X5XBop8MUajvL+d+4sG1388nmI
         aBGt2KDwRcvrur6lXT3z+PLLfbEGDCx1x1FBXPOUKmDSYDbrPYjyuqEBnUvtzxI539Q5
         APu0SPPHvlnH1fmjnvAZFEJtbKs/Snm5YMqcsgROnQMVY5sfihhOtcFzsonoY26Gkv11
         HxGEIlXajfWY5qclqyvS8hNCPMpUfHw9YDJieTO0ngACZRkLnH26hQd6sNCMYAC2Qa7G
         HgIw==
X-Gm-Message-State: AOAM531ik6cJh8hxL425JKhCy+qqvOiaetAonSlu6hgnL30gnzacu/gJ
        rwQJ49ZjIk6Kb/2s44X51Cy3z2rOiA==
X-Google-Smtp-Source: ABdhPJwZ2FrncAHnqzoABz25ayfNH+RftLyH/2iLGiBMZpb5Jq/7i0nzYWrvg1eeYSh1pcTSPB0Erw==
X-Received: by 2002:a63:ec46:0:b0:381:81c4:ebbd with SMTP id r6-20020a63ec46000000b0038181c4ebbdmr19418649pgj.534.1650463542277;
        Wed, 20 Apr 2022 07:05:42 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:05:42 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/9] irq/irqdesc: put the lock at the exact place in irq_sysfs_init()
Date:   Wed, 20 Apr 2022 22:05:13 +0800
Message-Id: <20220420140521.45361-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420140521.45361-1-kernelfans@gmail.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
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

sparse_irq_lock is used to protect irq_desc, and furthermore
irq_sysfs_init() is called only once, so put irq_lock_sparse() at the
exact place, where the race condition may start.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
---
 kernel/irq/irqdesc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 939d21cd55c3..8d0982233277 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -312,15 +312,14 @@ static int __init irq_sysfs_init(void)
 	struct irq_desc *desc;
 	int irq;
 
-	/* Prevent concurrent irq alloc/free */
-	irq_lock_sparse();
-
 	irq_kobj_base = kobject_create_and_add("irq", kernel_kobj);
 	if (!irq_kobj_base) {
-		irq_unlock_sparse();
 		return -ENOMEM;
 	}
 
+	/* Prevent concurrent irq alloc/free */
+	irq_lock_sparse();
+
 	/* Add the already allocated interrupts */
 	for_each_irq_desc(irq, desc)
 		irq_sysfs_add(irq, desc);
-- 
2.31.1

