Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F275A87F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiHaVQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiHaVQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:16:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8C95AF2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:16:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 184-20020a2507c1000000b00696056767cfso3046053ybh.22
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=CVUs5rMpA/Mx5em1VCT75qQnrrQY1h9WhhzqZJ9saNU=;
        b=oaXM6J7lTpnUI/r/S2ZdVtkNvlP+Di4wRiabFjYymcYH/2MC/P/ymj+EKbTRsxRXTR
         MBBXoxNeZZYIcFsxkrZGWzvoKm+Tm8RB4Hx4qtCL0fdoZcILCcp2030oUDOKOGeBwbxo
         yc7jfzF3fWcD/TZrZE4rsZ2vdEQH+7cvDxAZt9NTnRYyExyJ/gbAKZg/TgbrzlX0eDMg
         wjDHpwtwULMXV5BxJjg39oBLPIT/RaDqEVLh4ibGiHOLlKX0gdd9S7yM+Lg4jZmYamWX
         rs4Zl1693S1CU0mqXGtJJQ/MOrg/NFtXzR/OedWoOxrr3ftAk8LoNhZcp81BJ03tQ4CG
         BIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=CVUs5rMpA/Mx5em1VCT75qQnrrQY1h9WhhzqZJ9saNU=;
        b=1KUPTthUxppEph3wtFvfPAr/ZGr1wJCEBBRQtVeI+8LBYEemzecTT6j6l10qHc2YuP
         zMkGaGNLUxo/GIDpXnTzGVjReFbSOb70qmwIbQmr2DPxIECrvxfO7mS+DE5Nj3WwgifE
         oKcyE38saulzSiKBAmGns5zVw4Cnv/Vp2FM4Y2dEzd0szoBXpetFt8lxqrTtSadhkeIO
         S/Vn9qUnV9vgVizfVow5TaEEPC41sgBYcXpbtVOBdvsdZNm4qbppaFdETBaIuWPKz64K
         gYgJIxpwpUndF7v+Bet1RapHlGCWPzb0dTbaYR2RZr5tVQ4SIHcm46uMeX7wXDvUVWFk
         m5ZA==
X-Gm-Message-State: ACgBeo1eQZe3B1F+QEVfdmnHV30T8MFpu1mj2m0fBsASET8m5MwYoxQv
        STLHnVE0z6+e9MFqWcM0bhlT3FcptSP5mKTaKFXw
X-Google-Smtp-Source: AA6agR41eX1PK+67vEC2aDTKnHuRqqwAsd+MSa0uR5lvy3+k86wKlWa55YAZq773+hcgi9rqAhfGXMbKKEIQW+3Ym+d8
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:8eef:5fb0:8489:622c])
 (user=axelrasmussen job=sendgmr) by 2002:a25:d206:0:b0:69c:8b5e:4ab8 with
 SMTP id j6-20020a25d206000000b0069c8b5e4ab8mr6791416ybg.207.1661980593942;
 Wed, 31 Aug 2022 14:16:33 -0700 (PDT)
Date:   Wed, 31 Aug 2022 14:15:26 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220831211526.2743216-1-axelrasmussen@google.com>
Subject: [PATCH] selftest: vm: remove orphaned references to local_config.{h,mk}
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Tarun Sahu <tsahu@linux.ibm.com>
Cc:     "Zach O'Keefe" <zokeefe@google.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: this commit is intended to apply to mm-unstable, the commit being
fixed only exists in that branch for now.

Commit b4efb234e53cc60ccdc855190be9f35918687412 ("Kselftests: remove
support of libhugetlbfs from kselftests") removed the rule describing
how to build local_config.{h,mk}, but it left two references to these
files lingering around. The result is, none of the selftests could be
built due to dependencies with no rule for how to build them.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index b52f2cc51482..4ae879f70f4c 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,9 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
 
-LOCAL_HDRS += $(selfdir)/vm/local_config.h $(top_srcdir)/mm/gup_test.h
-
-include local_config.mk
+LOCAL_HDRS += $(top_srcdir)/mm/gup_test.h
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/ppc64/')
-- 
2.37.2.789.g6183377224-goog

