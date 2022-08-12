Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45951590BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiHLFzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiHLFzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:55:11 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D94A4053
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:55:09 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2a4c51c45so24009229fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vyDd5sdlW/fZbgb+P03HOQJNhHBEtM6dR0OmvEFJUas=;
        b=I2/tiLRGP+vTpPDSKssy8o+Alz0OX7R/A3w9bOoDvAefBVZg2WUBaeodhnOr3hiGaA
         C04lqW+K8FeMIotWwAYLyg8E5ojZ3X7V58PA3OGDkS2s5HXA8CcsfN8h3sjas6rIUleU
         giqCAQ4zXY9ghm1tlpBs2gp+I3qBkz4zDQk4m/JU7vU9NM/7y7EGQcxs8Fq6rO21x9hU
         mzqdGWg0Ru1JpXeTBq7fi3JBhZxeStXalldJLDMlITlqGE441bSs3GGUX7TISbU9juQh
         tLVzG5erCe/QiDQMh/RfwLGgAqL5pl/2TO6UXqGZaMOthb9Dfl2EhnNVtaSEBi648iL9
         EEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vyDd5sdlW/fZbgb+P03HOQJNhHBEtM6dR0OmvEFJUas=;
        b=1MyRHZxmKv9Dj57TYrmF+VWCGt+IgyNq8aU961bPuDoiqordlXUfFWBH4k5KvIbDQK
         g6221Nb5zFSYJi460Lffe2zvUHuZVN7IwQud32WcqffGHlgOuD5x9nnyInM6dX0FPthg
         FfrsNN5hL2bsQQag0NZpPPhAc9FuSAyY7tL0x7fIUKcR9gW1ei0FrSMMiYxG7ID2IpWc
         FtWVs6yFRzOL3g/l65StEywpXvjHRw51AbB/2mvtJXCvNVloDNkhG2Hn0As3BKTpPWnI
         MlwTMZ3AqqZl7htG6JyzyjC174qQZC5i/IUa1l9KxpsRSEQYj50icTv0ucuhb/r+yt8C
         EG/A==
X-Gm-Message-State: ACgBeo1dVkDVV89LspEvNWz7RFrGqgNWNl4X9GN+ciM5EftPw7+toDB6
        smLvqHqK7slJLkWNsuPTLoSFPAGEb3E=
X-Google-Smtp-Source: AA6agR5aGXyyJ3+GJIotsDJnqcx75qV+eYnnEhlGhhbARGSbHE48VYmsi9Yyo1+DSijFHW4fZANiZA==
X-Received: by 2002:a05:6870:220a:b0:113:fae9:18bf with SMTP id i10-20020a056870220a00b00113fae918bfmr4915811oaf.66.1660283708323;
        Thu, 11 Aug 2022 22:55:08 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id h5-20020a05683040c500b00616d25dc933sm214380otu.69.2022.08.11.22.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 22:55:08 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] lib: remove lib/nodemask.c
Date:   Thu, 11 Aug 2022 22:55:05 -0700
Message-Id: <20220812055505.2502077-1-yury.norov@gmail.com>
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

Commit 36d4b36b69590 (lib/nodemask: inline next_node_in() and
node_random()) removed the lib/nodemask.c file, but the remove
didn't happen when the patch was applied.

Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/nodemask.c | 23 -----------------------
 1 file changed, 23 deletions(-)
 delete mode 100644 lib/nodemask.c

diff --git a/lib/nodemask.c b/lib/nodemask.c
deleted file mode 100644
index b8a433d16b51..000000000000
--- a/lib/nodemask.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/nodemask.h>
-#include <linux/module.h>
-#include <linux/random.h>
-
-EXPORT_SYMBOL(__next_node_in);
-
-#ifdef CONFIG_NUMA
-/*
- * Return the bit number of a random bit set in the nodemask.
- * (returns NUMA_NO_NODE if nodemask is empty)
- */
-int node_random(const nodemask_t *maskp)
-{
-	int w, bit = NUMA_NO_NODE;
-
-	w = nodes_weight(*maskp);
-	if (w)
-		bit = bitmap_ord_to_pos(maskp->bits,
-			get_random_int() % w, MAX_NUMNODES);
-	return bit;
-}
-#endif
-- 
2.34.1

