Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E221570CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiGKVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:31:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A265A28705
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:31:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g126so5848831pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THO9DfPZbcbt/fbJX/PNalaQ/aO0CkM5BdMU2In6QAw=;
        b=dT6zvLmWza30XRRuY7TcScu9MmNOvi5cWPhePSoiWMe1AvRU8uKSvczpN7zLDmpazJ
         i3caLWHebo5zkz0rFugit1TU1LTng9pq0CCmD3gLz6PTd53MC6PTdQ4dnpjNwrq2O9C0
         UcI6pF8QuWuzLTFH739uCpkK1V969vZGqd7tRQ5eHYTSxeOvn/CeBuNNBasAND8MBK0z
         W/nvmJ5Nxg2VwFIQbVQuI/oiqzucUXY3voFe+vb4dRjaCHFofdmbSv65J81zoB55CQdk
         Qc5jpIsZ9dYbC6h32URtIb25ehQIa0crzWlTj0iyCK1jK7eqLxmS2o/dwntxOfTDg2/P
         R+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THO9DfPZbcbt/fbJX/PNalaQ/aO0CkM5BdMU2In6QAw=;
        b=HaLGVremVeGye8Dz4DVHAmEWBDjZFCTLTcNhHGwgrjRfwbxNOlAnXtQ3d2uaKn6sxB
         rEFrwDj4fKaHG76Jrocol53Jg8YVE3GBlkc9acwUmJuyGOZJYn+j08GpSjQcDedZ4yC+
         A1GpDttmLU/pSkLRMh0W4N3SXAZmZmEExvj230191Hh1aPLwTHOPPhTYC3UDs5Winrqk
         jhZmpke6o0vU16jCOO/G+Hhcb/ob9EDgU1xvzSQh8m8Ez/oeCTh1mjeht6nNlTSJTUQB
         eyMBImcD+jaPqD0w61wWzCO6tni8k2w5oSMGZR8v3TgqbnW13nu48QfT/Z2GtKQMbArF
         abWw==
X-Gm-Message-State: AJIora/SJC0KBSQnmo2b/luRXyHdSgcfIJDG3wdkT81FP4kBDZ0FofG8
        0BBY2HoUTfV0wC8oMyAcCzk=
X-Google-Smtp-Source: AGRyM1vb71MrN2AYW+E5i4Nh+A4PuxGpYiUHMtTQZY55vqusc3QbSEGLORCVbPEVuYbrlV23q9gtlw==
X-Received: by 2002:a05:6a00:124a:b0:525:894b:7924 with SMTP id u10-20020a056a00124a00b00525894b7924mr20292973pfi.31.1657575074185;
        Mon, 11 Jul 2022 14:31:14 -0700 (PDT)
Received: from ArtixLinux.localdomain ([116.193.141.30])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a7e8300b001ef78b9d0d7sm5224187pjl.30.2022.07.11.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:31:13 -0700 (PDT)
From:   Shinyzenith <aakashsensharma@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Shinyzenith <aakashsensharma@gmail.com>
Subject: [PATCH] drivers: android: bind_alloc: asm/cacheflush to linux/cacheflush
Date:   Tue, 12 Jul 2022 03:00:59 +0530
Message-Id: <20220711213059.7197-1-aakashsensharma@gmail.com>
X-Mailer: git-send-email 2.37.0
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

* Removing checkpatch warnings.
* No functional changes.

Signed-off-by: Shinyzenith <aakashsensharma@gmail.com>
---
 drivers/android/binder_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 5649a0371a1f..795132af0c15 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* binder_alloc.c
- *
+/*
  * Android IPC Subsystem
  *
  * Copyright (C) 2007-2017 Google, Inc.
@@ -19,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/list_lru.h>
 #include <linux/ratelimit.h>
-#include <asm/cacheflush.h>
+#include <linux/cacheflush.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 #include <linux/sizes.h>
-- 
2.37.0

