Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F8A4E1961
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 02:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbiCTBxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 21:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiCTBxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 21:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 419F02156DD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647741111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7+g4lBbR9wGQEz+SJAnS0Y/H4dktfXz+TnU3wixu7kw=;
        b=eP70A0OI37Oiv/Qq3gAIZ1kuTCwW4xaoE8vPZ+xIb0yL5jOV2mR1FJ/AhyOjrixLcR6YxY
        NuOyLXP2rq3n2jfSyZN8lNjjarHqRGuwgrmMNqjwWJDL1UOhdH6YTjEzbm25dIIufc/ocQ
        RVzSDGwvqd0Ki4MJ344hK//Nr75kgGQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-HM77wgOKMFW32QlzM6J5xg-1; Sat, 19 Mar 2022 21:51:50 -0400
X-MC-Unique: HM77wgOKMFW32QlzM6J5xg-1
Received: by mail-qk1-f197.google.com with SMTP id b133-20020a37678b000000b0067d24942b91so7712011qkc.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 18:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+g4lBbR9wGQEz+SJAnS0Y/H4dktfXz+TnU3wixu7kw=;
        b=SlkcwFe5whiatFJ4CvpZFtyQ4y6no97opgY6dZDK0CHfxGYY3DyfmxW16ZvHNHASNx
         ATSYYzn7o6qQOc/gLLif7cSZd9ZqZrJby+c4fZhIBnXUKZlf0q/HPmAjk0nVEGwBdLeF
         tlNytitF5vzeoFMV/jSAXm0WNFrASBiYA/ce6N+uWfrsM7ASAhmfBRCWoWOn104bgkqQ
         Ar5YVGDfObhp2bklIpnqYPxbZiFtPHP/ho7uB0s8CE3u4wPTk8TlfrgazAoXJmU349t0
         oeiGzHlAuAsPBVu1n70nz0ffHJdaFhMQctzBL7uZrF1VllrJDCzl6G7lHVfLejxBGUmr
         RDlw==
X-Gm-Message-State: AOAM530lwAKo5GTIqO/d7E9X2FQB1nXlg1v1RYILHROgZh2kTl74sVpP
        zOyaUwrZkKMhb2Z/aTSRM9pjz5AwS2R2kOWQ5qsrJwd8czDG0pUTUabLf+vHkyuMIO8J5gfPSbK
        jrrML9jUDxecdxgWvWfFSMK06
X-Received: by 2002:a05:620a:c55:b0:67e:125b:38ea with SMTP id u21-20020a05620a0c5500b0067e125b38eamr9466526qki.396.1647741110118;
        Sat, 19 Mar 2022 18:51:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPyxoS2+EPm6TLHGvV+PXYG2sNsQSCkRQCFPHHcE/rizQ+uCKCH6QvrePSyI3ldbboUgS8bQ==
X-Received: by 2002:a05:620a:c55:b0:67e:125b:38ea with SMTP id u21-20020a05620a0c5500b0067e125b38eamr9466513qki.396.1647741109877;
        Sat, 19 Mar 2022 18:51:49 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a060f00b002e2070bf899sm3079882qta.90.2022.03.19.18.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 18:51:49 -0700 (PDT)
From:   trix@redhat.com
To:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, joe.lawrence@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] livepatch: Reorder to use before freeing a pointer
Date:   Sat, 19 Mar 2022 18:51:43 -0700
Message-Id: <20220320015143.2208591-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
livepatch-shadow-fix1.c:113:2: warning: Use of
  memory after it is freed
  pr_info("%s: dummy @ %p, prevented leak @ %p\n",
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The pointer is freed in the previous statement.
Reorder the pr_info to report before the free.

Similar issue in livepatch-shadow-fix2.c

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: Fix similar issue in livepatch-shadow-fix2.c

 samples/livepatch/livepatch-shadow-fix1.c | 2 +-
 samples/livepatch/livepatch-shadow-fix2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 918ce17b43fda..6701641bf12d4 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -109,9 +109,9 @@ static void livepatch_fix1_dummy_leak_dtor(void *obj, void *shadow_data)
 	void *d = obj;
 	int **shadow_leak = shadow_data;
 
-	kfree(*shadow_leak);
 	pr_info("%s: dummy @ %p, prevented leak @ %p\n",
 			 __func__, d, *shadow_leak);
+	kfree(*shadow_leak);
 }
 
 static void livepatch_fix1_dummy_free(struct dummy *d)
diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
index 29fe5cd420472..361046a4f10cf 100644
--- a/samples/livepatch/livepatch-shadow-fix2.c
+++ b/samples/livepatch/livepatch-shadow-fix2.c
@@ -61,9 +61,9 @@ static void livepatch_fix2_dummy_leak_dtor(void *obj, void *shadow_data)
 	void *d = obj;
 	int **shadow_leak = shadow_data;
 
-	kfree(*shadow_leak);
 	pr_info("%s: dummy @ %p, prevented leak @ %p\n",
 			 __func__, d, *shadow_leak);
+	kfree(*shadow_leak);
 }
 
 static void livepatch_fix2_dummy_free(struct dummy *d)
-- 
2.26.3

