Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D059F340
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiHXF5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiHXF5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:57:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41408B2FC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:57:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v4so14113230pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YSPT0Qki7Ju6xZPR8zVKpd/3Y86SHIvAxlRRGYCf6+4=;
        b=cJxCFckjGJmmRH3AxuVSwOTHmKPDvNUdHzsphspcL7MitfDj8cpemzRzFld9ka1JzG
         WnlEJmWoRnoQ0gxoov7Yt2rf6aTE+TfXoQJvWIXYocISArwgddH0SidAHEq6rI3BEAyN
         lTCzC7TZlFS/gWBvSe7q4HjuJZm2PmzxhmH39KjiNT25T3wxl6rd+nx3TTAEHqkRjefB
         GdI9uw+uu7SgshMtpf8Q4Pap89vTe6dJteYBtDjWBy3J1GMWr5EsxKSpmmXX0h4FUQtj
         GhPxiJ6N14F3KQEG3Fsuq79NI0Rt8cZtb/ZaylWiz9B1X/yS1OJIoDWBzLdxviW9YVnq
         xjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YSPT0Qki7Ju6xZPR8zVKpd/3Y86SHIvAxlRRGYCf6+4=;
        b=Q5aEQGt+wlJouk0crXRdHOM1QK+JLq2BgCim4HdJ6z/TcmtnKvSZo7flDRoTyvw5VL
         QarmIAos7a3SaOzeQleEe+R6EAV7xWZpKG51L3HJXLgdDLI4yb/UbAhH305FTMTbl7IB
         DiCaoZkqpIgBk3eN4vRP6Q+VcV6kSEWvlMP2D5QRkeqgW6zn45ASxtOvsVAcNs2xnyPM
         lpE2fwbnxwKE4ZsTkftXHKZG35BuwZwX3WwUHTCfmo0LyqGWtdOFpeDo2zJ6luOD7FvJ
         s2v1xUwKimEqw3A7udPHTxl8DvWsrQ4AqLfK8L9uYXXI0tGWbv2PzdoJhPLTofOzV8D8
         G+mA==
X-Gm-Message-State: ACgBeo2iPAeXKY1QkXf/87bk3SMFsWAai/EWra9Osjiz74BqcKiLHMpo
        48lgGjRwPGdnzr/7724KzFo=
X-Google-Smtp-Source: AA6agR6SU5V/MTOUdkMzfuBJ885alWNFmMOeIBJqlCJlfH7pKsFBZWwp8COvHDCLw/dA8nRjvHlUeA==
X-Received: by 2002:a63:de02:0:b0:428:9e02:5f3e with SMTP id f2-20020a63de02000000b004289e025f3emr23286847pgg.592.1661320620513;
        Tue, 23 Aug 2022 22:57:00 -0700 (PDT)
Received: from localhost.localdomain ([64.64.123.33])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902eb8400b0016c9e5f291bsm11423473plg.111.2022.08.23.22.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 22:56:59 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] mm: fix used but uninitialized variable
Date:   Wed, 24 Aug 2022 13:56:37 +0800
Message-Id: <20220824055637.10676-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In function walk_hugetlb_range, the local variable err may
be used uninitialzed when:
ops->pte_hole in side of "else if (ops->pte_hole)" is false.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear mm Developers:

When I build kernel using "make CC=clang-14"
the compiler complains following:

CC      mm/pagewalk.o
mm/pagewalk.c:318:12: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                else if (ops->pte_hole)
                         ^~~~~~~~~~~~~
mm/pagewalk.c:321:7: note: uninitialized use occurs here
                if (err)
                    ^~~
mm/pagewalk.c:318:8: note: remove the 'if' if its condition is always true
                else if (ops->pte_hole)
                     ^~~~~~~~~~~~~~~~~~
mm/pagewalk.c:311:10: note: initialize the variable 'err' to silence this warning
                int err;
                       ^
                        = 0
1 error generated.
make[1]: *** [scripts/Makefile.build:250: mm/pagewalk.o] Error 1
make: *** [Makefile:2006: mm] Error 2

I initialize that variable outside of the for loop because we can assign 0 to err
only once in this function.

After my fix, I can compile the kernel. 

Many Thanks
Zhouyi
--
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 54b2a1beeeb3..b6eb330e8ecd 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -306,9 +306,9 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	unsigned long hmask = huge_page_mask(h);
 	unsigned long sz = huge_page_size(h);
 	const struct mm_walk_ops *ops = walk->ops;
+	int err = 0;
 
 	for (; addr < end; addr = next) {
-		int err;
 		pte_t *pte = huge_pte_offset(walk->mm, addr & hmask, sz);
 
 		next = hugetlb_entry_end(h, addr, end);
-- 
2.34.1

