Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55AD51BE21
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357748AbiEELip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357590AbiEELim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:38:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481FB517F0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:35:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so4138762plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9AMjgQBvCmyA1ePp0ugTHXhdA/KV96TGy2zDZ4TeDc=;
        b=gD36s46ywn5cBGjvq273k7r3M8UfRfELRbCviW7Ne+LrL7zlIWk0V338EHrG6xGBrp
         sDTe26YWMOut0oJD/9j+3uYqD8Z8PGi7t+jHqUknfzF9VHuari22j3iOf12XGfDuF/k4
         mAzOcUoi8hC91Ra+pX8P5uNb9MJo7Xk7xFUR/HSIh6RSDIir53VVqAnzqX/3G0QzhcDR
         gAeyQLQJaxNhr0KRDX7w3HJwTe+xMmM+KGnenXa5vEJv0d2PKkeZr3bgG2uqeerWKD42
         BmVE8Fd5Xw3SlRDrpfaap452zPwvX24o/yoGLZEjXi9pTUXIf0sClpxEdVRTO5/ZHBJj
         z5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9AMjgQBvCmyA1ePp0ugTHXhdA/KV96TGy2zDZ4TeDc=;
        b=C7Oekb+RyWFVkjOpu0xY2/M8MAHMgr6ZVnv/OBMhEoHZh+NQM3CgN62A2OUpTrBRon
         UYli0btm6j25JpZbzvMuX11vMZ8ArPKqE3PSV3vnNFT3Q6KqXm8hOkDIvocegfaa/QMC
         YPJvrfXwV/GfE0Of9n8qM1h48knveLWwdO+DSStmRNTzS98P2ZHaeP6VbKnT3Aab4uGe
         xhyuf9431VqOvkO5D8rMOapTQKPv5E74HVk7H8KwH3sY8ogHT4sk5eF4WfsfbuCjRaoy
         98rR5nHqBFg2aI6/HVyIERXi9VzLlZCLSfRRwZPG04sHrYhDRt+ydIOo7KEmK9i01MIM
         Sdag==
X-Gm-Message-State: AOAM533Xh/wfTbMZ0ut2f1ElnsxYdI6BiC2LFoeoNofXZtXPW9p2lILZ
        8mki1k0DHchJwagc1d5tUv9ebiYXjzY=
X-Google-Smtp-Source: ABdhPJxMOL/XuysWiausOaNMSrSxhKUgt0xkWw7NL/KHtJve6nExj56tez+jTxZWPMa0ircZm7qBPQ==
X-Received: by 2002:a17:90b:3b4b:b0:1dc:5ee5:19ce with SMTP id ot11-20020a17090b3b4b00b001dc5ee519cemr5569473pjb.234.1651750502755;
        Thu, 05 May 2022 04:35:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l17-20020a170903121100b0015eaa9797e8sm1330856plh.172.2022.05.05.04.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:35:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mm/shmem: fix build failure when CONFIG_TRANSPARENT_HUGEPAGE is not set
Date:   Thu,  5 May 2022 11:33:55 +0000
Message-Id: <20220505113354.202979-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Yang Yang <yang.yang29@zte.com.cn>

shmem_add_to_page_cache() use THP_FILE_FALLBACK even if
CONFIG_TRANSPARENT_HUGEPAGE is not set and triggers this
compile error.

Add ifdef CONFIG_TRANSPARENT_HUGEPAGE in shmem_add_to_page_cache().

In file included from <command-line>:
mm/shmem.c: In function ‘shmem_add_to_page_cache’:
././include/linux/compiler_types.h:352:38: error: call to ‘__compiletime_assert_327’ declared with attribute error: BUILD_BUG failed
  352 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
././include/linux/compiler_types.h:333:4: note: in definition of macro ‘__compiletime_assert’
  333 |    prefix ## suffix();    \
      |    ^~~~~~
././include/linux/compiler_types.h:352:2: note: in expansion of macro ‘_compiletime_assert’
  352 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./include/linux/vm_event_item.h:148:30: note: in expansion of macro ‘BUILD_BUG’
  148 | #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
      |                              ^~~~~~~~~
mm/shmem.c:721:20: note: in expansion of macro ‘THP_FILE_FALLBACK’
  721 |     count_vm_event(THP_FILE_FALLBACK);
      |                    ^~~~~~~~~~~~~~~~~
  CC      arch/x86/events/intel/p4.o
make[1]: *** [scripts/Makefile.build:288: mm/shmem.o] Error 1
make: *** [Makefile:1997: mm] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 107f1e4dd0aa..f01ceedf88c0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -717,10 +717,12 @@ static int shmem_add_to_page_cache(struct folio *folio,
 	if (!folio_test_swapcache(folio)) {
 		error = mem_cgroup_charge(folio, charge_mm, gfp);
 		if (error) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			if (folio_test_large(folio)) {
 				count_vm_event(THP_FILE_FALLBACK);
 				count_vm_event(THP_FILE_FALLBACK_CHARGE);
 			}
+#endif
 			goto error;
 		}
 	}
-- 
2.25.1

