Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DF5A3A62
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 01:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiH0XBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 19:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH0XBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C6165AE
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661641262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qI/TRb7yyY9YDzUGJ2R7gXKC3BcSTndOOR+KS4v4hNo=;
        b=b7pZXfvxtcHnIHlq9OnLDNgsF3QC898O2R8+V0Qs+lZDGfSXgxUrqGGpERIMEp3LDsbRNm
        p0KGw1URvtHL7HKN3YCke7/9RvkfuRsAeozNKL8a9hubx99DQmo9LenEApDCmoWplrfE0N
        WN9cKHIPZWiwm7QGLf3h6R3FXcfFO6U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-ZzHmAm30N929Lrgqj-s-2Q-1; Sat, 27 Aug 2022 19:00:46 -0400
X-MC-Unique: ZzHmAm30N929Lrgqj-s-2Q-1
Received: by mail-pl1-f198.google.com with SMTP id p18-20020a170902a41200b00172b0dc71e0so3499962plq.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 16:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qI/TRb7yyY9YDzUGJ2R7gXKC3BcSTndOOR+KS4v4hNo=;
        b=OoWdonWaBM0UUCXk0m5yc8KdwK8kTI0t5V7e9YNnE1Bi50SR1sM+ToXbs43gvjH0Yr
         eJLNAD36wbxUr1zv02DgDqorsJzYZUTCkl39u5GVWCIloQhxY7WKBIK1enCDWrmGLmlP
         vPDlBLPMfKT6rEqfKO+wVQN/6+cOz07cUJUSllYie64XSx+wdsjt0Z+hUYb89bZ1CdRF
         99CLB2dqTE9+iGgnfH15NBZUnptZMtzLmAsE9pTq4n4F8887wpsRhWr/IONwoSLbN96E
         9pXjLCS5HdWc/ow/cWvDBYa3/xKog1KSnb4cQzEfOXBGFImUCEiuFcBC0MAzMi7CWOsn
         AThg==
X-Gm-Message-State: ACgBeo3VDCIorVKWsdlNZFtKv2a2WIxM2FpevelBC4/Xfb/XeGSDqO1+
        6lqOTVz+k3I9TMjy+orkGizeDm7QnkbxyuRSNeujrRDiHpkhDEvXsmEOLs3E9uyKST8npVf0Dlw
        86y8JwN+vewIdIqgdh4lbl4LH
X-Received: by 2002:a17:90a:4801:b0:1fa:98ec:fa2 with SMTP id a1-20020a17090a480100b001fa98ec0fa2mr10841747pjh.41.1661641245182;
        Sat, 27 Aug 2022 16:00:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6vzdYchRF2TEFkGashATDOr6JPFXLJkrFtu01uhG5n3edGz2/gx1GA+3F8PPFkdA+TInAA5w==
X-Received: by 2002:a17:90a:4801:b0:1fa:98ec:fa2 with SMTP id a1-20020a17090a480100b001fa98ec0fa2mr10841735pjh.41.1661641244957;
        Sat, 27 Aug 2022 16:00:44 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id 23-20020a631257000000b0042988a04bfdsm3647844pgs.9.2022.08.27.16.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 16:00:44 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     akpm@linux-foundation.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <yshigeru@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mm/gup.c: Fix uninitialized return value on __gup_longterm_locked()
Date:   Sun, 28 Aug 2022 08:00:37 +0900
Message-Id: <20220827230037.78876-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shigeru Yoshida <yshigeru@gmail.com>

In __gup_longterm_locked(), it returns uninitialized value if
__get_user_pages_locked() fails on the first iteration of the loop
since rc is not initialized.

This patch fixes this issue by properly returning error code if
__get_user_pages_locked() fails.

Fixes: 11147539df44 (mm/gup.c: Fix return value for __gup_longterm_locked())
Cc: Alistair Popple <apopple@nvidia.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shigeru Yoshida <yshigeru@gmail.com>
---
 mm/gup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index ad59c796d4d3..66d8619e02ad 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2110,8 +2110,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 		nr_pinned_pages = __get_user_pages_locked(mm, start, nr_pages,
 							  pages, vmas, NULL,
 							  gup_flags);
-		if (nr_pinned_pages <= 0)
+		if (nr_pinned_pages <= 0) {
+			rc = nr_pinned_pages;
 			break;
+		}
 		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
 	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
-- 
2.37.2

