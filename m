Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723E15A4F51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiH2OcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiH2OcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:32:22 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE19083D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 76so8368642pfy.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=x9fs/pcgOChAtJLUDPXp3cv3Ogg9mSNMF+2EQZokRvQ=;
        b=Hi+GDra6Sf12h7DvdH5gSikhtPG2PYCaMty8fDSU0dckAyQ7QVzxTXQm8F0hV41QMU
         fn5K4DThjAfuwv+ooJwsSH81Q9lxRvC9xqKnRuBEyZFCqiBN8Qeial6jlHxj+KipJWmL
         Xtfpsj4pR9C90VzrLB9+oYpCdsYf+SvHBzcHUK5ZPbDwCuqz2a2rJkhnOi8Wl2IWIxTd
         dvzlSQTUvU5U8xF2OUiP8A6Lnaxd8eefbSywHq9qmwlUevC7kg1cuQGpkGDn9BSDdMoe
         zc0Urq9F0GRgYoGy1yW4Ejd1rLKPORzpFh7Qme+SfzF7SsQSPdKn0WFdIKU1KUCcMYE4
         c4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x9fs/pcgOChAtJLUDPXp3cv3Ogg9mSNMF+2EQZokRvQ=;
        b=tLRUhX0fOapFuEtrMp8ux4RcZdoFEW51giu3s7Ho5Q06bF+fS69YPWxbWdZQMlNxwi
         ImxCs4CMVI6AUagwdiqsqGxMj/hEd1bX/xqkK6bLow1jJiW/T2I8gs+SXa6xXqi7B/dt
         gtKO0oomsVPa1MEQyDdiO5EnXsUoMXi4x6a2BLjcUuX4BPmRVBLtRwBMwXYlLv25U9pI
         guQ/gpYfhkxmRToKdAs2ii368rfORrbEGCR1yihGaFBrtJrt1y4KWnaiQdxL8B03K9Fb
         Q17JAoamqeOY+HZwFjAFwLyLDRM7Bg53tpCv7rDXNV3b+A4xAmrY7iuWhZG/8DtZRbhc
         yyRw==
X-Gm-Message-State: ACgBeo2kr1iooclEhc2TZWjvLQKWYe7dWUL2qof+nUMF+ryOh87x/nvY
        tpORYMMYiNDn0qgHjiwACG2i+w==
X-Google-Smtp-Source: AA6agR5uBB+JsA0TTshXcxSp4y9k+Xh/s3mwekUNcXN+nNWn6zzaQDy9IwjFiWnAj0bxcrE0G9RK6Q==
X-Received: by 2002:a05:6a00:a05:b0:534:b1ad:cfac with SMTP id p5-20020a056a000a0500b00534b1adcfacmr16618524pfh.35.1661783540545;
        Mon, 29 Aug 2022 07:32:20 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b0052d200c8040sm7259327pfb.211.2022.08.29.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:32:19 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        hannes@cmpxchg.org, minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 3/7] ksm: remove redundant declarations in ksm.h
Date:   Mon, 29 Aug 2022 22:30:51 +0800
Message-Id: <20220829143055.41201-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
References: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, for struct stable_node, no one uses it in both the
include/linux/ksm.h file and the file that contains it. For
struct mem_cgroup, it's also not used in ksm.h. So they're all
redundant, just remove them.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/ksm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 0b4f17418f64..7e232ba59b86 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -15,9 +15,6 @@
 #include <linux/sched.h>
 #include <linux/sched/coredump.h>
 
-struct stable_node;
-struct mem_cgroup;
-
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-- 
2.20.1

