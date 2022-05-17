Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA211529657
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiEQA6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbiEQA4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:56:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7721246
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:56:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f10so4082657pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
        b=IIIyXSQJWf8UayE82aTml286GpqPORX9ViI9e/yl8XghTxo/ZP4IGnG0yfs5lmsqZh
         XAq01FX14zp3kWmuGrRB787zVcW0Xl2iiLvehDKRPIh6vH6lLApEoZfReOfW4GdGGCip
         i3n+iOtizlgQl+dYG9gSswt+9j5ErccPVhmYyo7iCJC+0rlm2A3kFK/yB6V152fE1p/M
         OiHfebI9mZGTN86UDz2R0krR4FF6bejrChRfTiWyCP05MNGmysQlsbAm5s/ghHmea3wm
         eNqeweDIspoMcW9uaocky1EbdAzCujoUwYTRr0daPN1pfrfvathmDgiX0W85H+XFHVfk
         v/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
        b=R16TsTSxYlweG2EX+Ub6CRIsmqkCN2SV/lupKlaT2c97Efo8NFjDsvghut3cLVSU9T
         BlJMlWhL1CjkRskBJnM4z54RQhXWviiISNocyw0aXG9ADVx7dqEcu5V0ud13ST40uvRB
         eWeO6wc03Joo2ef190OV2KXfkVjrKNukaF/RQaO2qx78Qij3vvFGvB2Nar7/YeWWm4EZ
         5hzUDUryOZOPyE5tLXC/JbNh5T7SajO4wD9cR2E6CPoeOpUgXMMIEnd+L+KFx+WqNuNz
         bAoz9plVQZxAh9fJ3Sg/l5GanhMQ50jdeUrEgeHdjRUYtv91GDcCcja6QVcSK+DKB2il
         AcIA==
X-Gm-Message-State: AOAM5301iTc+prN5PZQ/XNqDeXMY90RjLkZR9DDXPySAu5ukxttA350h
        eERGdvyKRXJ1kjcjiy+6HL3sTdNAbGExKQ==
X-Google-Smtp-Source: ABdhPJzCzap+mCp/6EYXmoaBxWvMCbfqW76N0OCIz6ZiKWNdjx7NhOv3OkFJ2by8dxR+EwgzUmRbjw==
X-Received: by 2002:a17:902:a516:b0:15f:309f:7805 with SMTP id s22-20020a170902a51600b0015f309f7805mr20022119plq.114.1652748965506;
        Mon, 16 May 2022 17:56:05 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090ad08100b001df501391efsm273548pju.53.2022.05.16.17.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:56:04 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 12/13] openrisc/fault: Fix symbol scope warnings
Date:   Tue, 17 May 2022 09:55:09 +0900
Message-Id: <20220517005510.3500105-13-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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

Sparse reported the following warning:

    arch/openrisc/mm/fault.c:27:15: warning: symbol 'pte_misses' was not declared. Should it be static?
    arch/openrisc/mm/fault.c:28:15: warning: symbol 'pte_errors' was not declared. Should it be static?
    arch/openrisc/mm/fault.c:33:16: warning: symbol 'current_pgd' was not declared. Should it be static?

This patch fixes these by:
 - Remove unused pte_misses and pte_errors counters which are no longer
   used.
 - Add asm/mmu_context.h include to provide the current_pgd declaration.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/fault.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 80bb66ad42f6..516cba14dec9 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -18,15 +18,13 @@
 #include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
+#include <asm/mmu_context.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
 #define NUM_TLB_ENTRIES 64
 #define TLB_OFFSET(add) (((add) >> PAGE_SHIFT) & (NUM_TLB_ENTRIES-1))
 
-unsigned long pte_misses;	/* updated by do_page_fault() */
-unsigned long pte_errors;	/* updated by do_page_fault() */
-
 /* __PHX__ :: - check the vmalloc_fault in do_page_fault()
  *            - also look into include/asm/mmu_context.h
  */
-- 
2.31.1

