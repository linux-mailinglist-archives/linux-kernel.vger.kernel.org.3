Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4852FCB1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353020AbiEUNPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352636AbiEUNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:14:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613AEB0A68
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h13so3595149pfq.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
        b=E0vkss2uVELfv3PlZ/r95E//7dUFZcVN3Q6zI9qVYQ11thArs93Y74/ki5ZCK+wTf3
         tdv0ait1ZC13crYnB3TS7CagvX3ibFfRuD84rM2ESVm6wASQoVYYEaoRqogua1BsEiaL
         br4T9WsWwI7j3jDeyvx+V4N77DlBKuPnpwiWirc9XTBYDfS/tmBywUaObp9+c9r/nv2k
         PaAOGEproMgyWRzHaXsWUA3C3Ja7EYiRqymvBuF0cJo3tx/hppL3WDX8HU3owF23sTgd
         WuiLjemAdZ/IMMYZlk5WBF/cXGggclCunzkGy3oRJ2Ot9AbjRm5PhgeHeB5g8Y+nUkI4
         +aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
        b=IraNIzsF5Gi0UvTbEnCp4VXfL/VDyM3TTyXzXWBqRUqJWqU9vJhsRxrUvL4DzEdW92
         5RzuJTYyV6ZsFkfMTiVAiq/QMBrmUTh1nudposXHUWv8Y+oVx8mYD4k4FCpnGdTysgFE
         R//1TwX1RCotvduBDo/1DRibyrFnzv+utOk4MUcpjvXN/jDX2UkhzySKrOetu51qTX2C
         aoXV+99c4jEZ1Us1XKBSygrWN/e0N9Qv5oh5UP4xB/uY/kRLOikPbvBpJPt13oWE2rwj
         WFQ0FhmHXBSv+efndTXv3KQBmDKhcFAAKkmzWQgSu7yj1wb4ZlBjZK27UH7k7ZMyE6Xg
         k83A==
X-Gm-Message-State: AOAM532P/o9Sp9HMz5VtJrPer4Am0kgdhlpDKp423nOYhacjrg4lCm2W
        2dPc7YNTAR3h8NThQo0TY4SS3mC44I3pGQ==
X-Google-Smtp-Source: ABdhPJxzxOv0MNjHhHaK6mn9jIflVS4+y14htbcNJBI5Q9e0Aee3EBFglJ0ijsxGWNbzJikDavP5bA==
X-Received: by 2002:a62:e80d:0:b0:50d:8f8e:ffb8 with SMTP id c13-20020a62e80d000000b0050d8f8effb8mr14737980pfi.37.1653138858201;
        Sat, 21 May 2022 06:14:18 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id h131-20020a628389000000b0050dc762812csm3615421pfe.6.2022.05.21.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:14:17 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v3 12/13] openrisc/fault: Fix symbol scope warnings
Date:   Sat, 21 May 2022 22:13:22 +0900
Message-Id: <20220521131323.631209-13-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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

