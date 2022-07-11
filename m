Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9E5708AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGKRJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiGKRJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:09:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D914AB87C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:08:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b2so4964453plx.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DLoKLo9KSBBsl7M8MYAQa9UFt2d+Z+jamo38RKgFwFc=;
        b=pe/wvJNzsULkC2DIkC2YSGo8Aywe6DTSXUvNo8Cwlb6e89OhWD8sP2VeTfGdHP15T6
         B4xwVhigiFmbSzF9YFa1Nd4JCOArw5wjYUJvJwtXQ/jLavUEdYu9YuFvQVdH38qSniP7
         OLH2J4sTAw6227Yd1gs9USM78S1FDmsaSdil3IS/Kvl5MQRGD3u/39SFc34qLesP0ZPd
         QHSPF0KIjFSaApxsDu1YXwbgtSDoTVCQEnDYdxJAsBGToZUEPs7AmmG2890TqyC4Pnxt
         jnnWxSvF40jqXQI+ozExHr+SNcCi7p+gIkkYcv3h8YNk+kT/CiIIRuupOefNls71dlDq
         lAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DLoKLo9KSBBsl7M8MYAQa9UFt2d+Z+jamo38RKgFwFc=;
        b=GRYliqwZLrJiwyw4JoIOSHmAEL8JxkhBhVWmYX3Ek2Aa+kYp0ggYyn55TxUrjieXwO
         3RirIfqSlZ65usjhAPgyvpjexDhAni9GPlWQEnx4dPBDe9m3UHf8IOE2lCXJdgpZ/H0C
         ReqmurdkyF/ohUJcYb9KsK4BFOhL6Xd3g9ZThsTpLkj7iU7eoEqWbgEpmyfiD/AR9Fzp
         Ovt8//yAL0g+J+K0nc4yz67XkOndhfstQ4IZ6XUGtbm2mpBI47kAB1CxgeO001rmY3t2
         SQOkHAJZYP1WYseKwYBi3ChvAoOArc2mtdl3SrkCFq2p2MRRpjrVxQts912pnCJfq2Rg
         MNtw==
X-Gm-Message-State: AJIora/4V+UYXiaYwGZdavXiwtB3w32AArftAmC7TpN5rmtmwRjo1xnS
        eZBn7KXbJCJWvQoDWBlBqT8=
X-Google-Smtp-Source: AGRyM1twnjsYSR7y1N5REE2JIK/yOFJApWP9Ch8JKj3yHyKCOAFQ1Zv8MqaHBGn7NAm+0fOvYxI26g==
X-Received: by 2002:a17:90a:e7d1:b0:1f0:2304:f57f with SMTP id kb17-20020a17090ae7d100b001f02304f57fmr13069498pjb.133.1657559339369;
        Mon, 11 Jul 2022 10:08:59 -0700 (PDT)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id d16-20020a17090a115000b001efff0a4ca4sm5032581pje.51.2022.07.11.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:08:58 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org,
        asas1asas200 <asas1asas200@gmail.com>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH] tools: Upgrade atomic_set() to use WRITE_ONCE()
Date:   Tue, 12 Jul 2022 01:08:51 +0800
Message-Id: <20220711170851.72208-1-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Since the atomic operation in the tools directory is from the kernel
source [1]. And from the commit [2], atomic_set() is at least
WRITE_ONCE() in the kernel source. atomic_{read,set}() should be
symmetry with {READ, WRITE}_ONCE() [3]. To be synchronous with the
source, atomic_set() should use WRITE_ONCE() rather than plain access.

[1] commit da6d8567512d ("tools include: Add basic atomic.h implementation from the kernel sources")
[2] commit 62e8a3258bda ("atomic, arch: Audit atomic_{read,set}()")
[3] commit 6aa7de059173 ("locking/atomics: COCCINELLE/treewide: Convert trivial ACCESS_ONCE() patterns to READ_ONCE()/WRITE_ONCE()")

Signed-off-by: asas1asas200 <asas1asas200@gmail.com>
Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 tools/arch/x86/include/asm/atomic.h    | 2 +-
 tools/include/asm-generic/atomic-gcc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/asm/atomic.h b/tools/arch/x86/include/asm/atomic.h
index 1f5e26aae9fc..4dcf4e9baecc 100644
--- a/tools/arch/x86/include/asm/atomic.h
+++ b/tools/arch/x86/include/asm/atomic.h
@@ -37,7 +37,7 @@ static inline int atomic_read(const atomic_t *v)
  */
 static inline void atomic_set(atomic_t *v, int i)
 {
-	v->counter = i;
+	WRITE_ONCE(v->counter, i);
 }
 
 /**
diff --git a/tools/include/asm-generic/atomic-gcc.h b/tools/include/asm-generic/atomic-gcc.h
index 4c1966f7c77a..df84af8012e6 100644
--- a/tools/include/asm-generic/atomic-gcc.h
+++ b/tools/include/asm-generic/atomic-gcc.h
@@ -34,7 +34,7 @@ static inline int atomic_read(const atomic_t *v)
  */
 static inline void atomic_set(atomic_t *v, int i)
 {
-        v->counter = i;
+	WRITE_ONCE(v->counter, i);
 }
 
 /**
-- 
2.25.1

