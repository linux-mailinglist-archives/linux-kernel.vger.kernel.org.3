Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA63B4AB463
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiBGFuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbiBGDRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:17:18 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A2C061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 19:17:17 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so12202579oos.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 19:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVL1XarGkGpNrMFF5FpaCxOCFgNox/eu94U3iNLWgOk=;
        b=UzVcUxMLk6QizfUc8c/7P9RNR++92zr5T0oDttbGCWP7UGcZ7xi9Nxd6CknDb6Zn1I
         VK31u/QMNp/hkXmq3vnr9FMoKmAcs4R7UNr7Ylv6LXSdmsH0XMjW+Mr70MzA7kWubIPS
         KitfUUKfznChgEkaPtDIip9U1lHKb3/zj3jAlD0FEL4LhOzBulb8bLHuV8sg3R9gJ8KI
         PzL+YdOj5NyVN13ZbEitnZ1091DJjypEHJ4TXyVckOtJ0q7eD58XQHIGvDqRZE4qJ7kg
         QU652s5nHCrxnq9vvfjdO7sQrKegfL11u2VFTOdhjzMksD0vXllCCrTAJAvwDF8tnhg4
         T55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVL1XarGkGpNrMFF5FpaCxOCFgNox/eu94U3iNLWgOk=;
        b=fDXxB1Ey0oW2df9DaD9Xp8pwrPrSai1GllvW+z/B13FAjWJ1p4GNvxw5NDQYLxqA93
         BAGqJpDyp+fgeAzLTjXRGHoHsh09uLETlmzMWyaLyALUlkQKNfjesKzrFycNwRrWqfvf
         p2HmFcvk4zXxmLvglL38L6TbD6KE+9jsvkUMOa0BKphbvC9g3PP5q7j9vS7jTzewG31+
         hswlvKodbnTfi/dS5NwT/QCx7ss7ql5Acj87PFJA891vVq4Eg8vC4N/Y9Eqq+wIvMOJ7
         RpSYv2hwprxfpx7fpYdhRClm/JiWEWawqRklas+ylKxTIKxUkhDKvq3cEHwrv5cgixTZ
         BR8g==
X-Gm-Message-State: AOAM531UA7Yo+0tKiW7eK4kX5QJYre5Vr7rMj0DpiSRKrSewfUGkTsC7
        N663e1wVxxeXA5E49Z5UJ/U=
X-Google-Smtp-Source: ABdhPJz5HxJMSDPOW73LlU/PtUzQWEN6ctR43Vhlii0R+CgbtJvTVDKLZbk8OSHZQBi3hgAOzBobWw==
X-Received: by 2002:a05:6870:3654:: with SMTP id v20mr2726890oak.17.1644203837175;
        Sun, 06 Feb 2022 19:17:17 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:4134:806a:5a4a:2a88])
        by smtp.gmail.com with ESMTPSA id w62sm3704537oie.4.2022.02.06.19.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 19:17:16 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        "Leonardo Araujo" <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging : android: Struct file_operations should be const
Date:   Mon,  7 Feb 2022 00:17:11 -0300
Message-Id: <20220207031711.13644-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
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

From: "Leonardo Araujo" <leonardo.aa88@gmail.com>

WARNING: struct file_operations should normally be const

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index ddbde3f8430e..4c6b420fbf4d 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.29.0

