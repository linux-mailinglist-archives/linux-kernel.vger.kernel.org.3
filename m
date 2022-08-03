Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53B5588528
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiHCAhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHCAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70D7A27CEB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659487069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MNwWCoZOuwPxSYyDQ6YzxKBvZEYHs5K0G6f2+t5kiFc=;
        b=ieAni7vvpWM/eXhHbekwcncgq28zeQxVjGu6g5OrJUeTBQYJXM0pURdss7xpYTce2YYZWV
        Dyj5HhU08YudA61bJculUF8QIwr2pNCepbUG9p4msMY9OG3OEF7hBeyXdGHAUs3WX80xbN
        RHRdxVBzLbsYTBM/qn0CM/wa4nivbEI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-ILPiNa2TPf2IE9CWV39f2g-1; Tue, 02 Aug 2022 20:37:48 -0400
X-MC-Unique: ILPiNa2TPf2IE9CWV39f2g-1
Received: by mail-qt1-f199.google.com with SMTP id l16-20020ac848d0000000b00339ccb6ef6bso2168401qtr.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 17:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNwWCoZOuwPxSYyDQ6YzxKBvZEYHs5K0G6f2+t5kiFc=;
        b=nSD9mzp9zMmpQkz5urTnPsC34uZFp5ntoiApdemr8/C2pMCtJSTV7jMxYI+vBHp3Hg
         MM7qqkOH9VJ/SG+WS4y0H0ZRjHeJviZW6eTnmPsvcwxg+VQzgaQqRWusA+YhTE7wVr4M
         P+oAAdjkFsdy2CFM1uZy+/Zu5ZaaWfRMcsmemCv8WvE89b/7w7cBlwgr1v3ICmnQ95TU
         wpFcKk9NuhbDQlBlbtiz5FBMqssXD77UjcZO4L2uMO6kk6TsFidYdxBmGPQ3yqpSDMOB
         eAT7NDRY3SKJz2cT1yue3s6LbgB+6EfvbJjflMuGaBk/USsoIl0JkF9Xk6nXzOkP6jwQ
         L45A==
X-Gm-Message-State: ACgBeo0oZVbLxtDF0Zm0BIoHvXLeaTnybt+GeaKT3QDJOULKvRSs5mJK
        I1wGvtYmKOS6kwfv41BDsqcD/VJYnRgsO8SC1lRNZEYnuFxHYz46t8Zy5xMD/FhkZ8lpNugk56s
        k5zI28p8m0ArIbJFqVMb+D93k
X-Received: by 2002:a0c:eb09:0:b0:474:9b46:f9f6 with SMTP id j9-20020a0ceb09000000b004749b46f9f6mr16639430qvp.78.1659487067849;
        Tue, 02 Aug 2022 17:37:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6VOO+RLJg2umykRFY/og+D9grZv9NcB4WO0HpWj1YDpwIMm8DQoa374LSWA88zj9M5F7WI+w==
X-Received: by 2002:a0c:eb09:0:b0:474:9b46:f9f6 with SMTP id j9-20020a0ceb09000000b004749b46f9f6mr16639420qvp.78.1659487067615;
        Tue, 02 Aug 2022 17:37:47 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85e13000000b0031eb02307a9sm10955301qtx.80.2022.08.02.17.37.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Aug 2022 17:37:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com
Subject: [PATCH] mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
Date:   Tue,  2 Aug 2022 20:37:45 -0400
Message-Id: <20220803003745.35263-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all the magic "5" with the macro.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable-3level.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index e896ebef8c24..28421a887209 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -256,10 +256,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 /* We always extract/encode the offset by shifting it all the way up, and then down again */
 #define SWP_OFFSET_SHIFT	(SWP_OFFSET_FIRST_BIT + SWP_TYPE_BITS)
 
-#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
-#define __swp_type(x)			(((x).val) & 0x1f)
-#define __swp_offset(x)			((x).val >> 5)
-#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << 5})
+#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
+#define __swp_type(x)			(((x).val) & ((1UL << SWP_TYPE_BITS) - 1))
+#define __swp_offset(x)			((x).val >> SWP_TYPE_BITS)
+#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << SWP_TYPE_BITS})
 
 /*
  * Normally, __swp_entry() converts from arch-independent swp_entry_t to
-- 
2.32.0

