Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E579B5A7462
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiHaDVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiHaDUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:20:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6727177
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v4so12391784pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=x9fs/pcgOChAtJLUDPXp3cv3Ogg9mSNMF+2EQZokRvQ=;
        b=3EWz+RdAoilxVzBAZIbXaT2y9w/JYKSOiuSsmrx0ab0Rk5p98tjF4aJJrLqO6lxLmI
         olDtI9r36o23DHUAJS+usg6A2arKZfNQRUIA65hXH3D3o2R/8xjGCW2QWa5MK6z3UZ90
         BknGzOP61FsSU+OVGuvg0nCzUbaEMm1ek3r2F66u8egKy3DvD8Fr/CSYWLf4T/lMNng4
         TbsWpMafB47RdxPm6vzmiRlPaggUyBG1IOU2R2ootfTB9kH5cfD12UqOcEyJsLVIky7Z
         U5amLNhO0XgSkmpVeyK72YZwucWP5Udql1VdAKKpsRDuPt0vOY7+ZzZhkpSdx11G5R9P
         qF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x9fs/pcgOChAtJLUDPXp3cv3Ogg9mSNMF+2EQZokRvQ=;
        b=gXgJM58kVi4Tojs3/CClkiuRPlR1YG7EZTceNRTrPZCe/jw6QodCYgEJPbBO2biiCa
         j4uF7Mh8GlupvpCtWz7Yjqb4N4ZbYiN/Ws4U/nY374DFc4BWr2ssQA3W8iojkeosvvca
         0KAiqanK6Ek3g1Xn4BVyk/cVyoEG2suxBxv6gPrul0bxNsoQf59tOp+g6SSHgCCyLLHz
         ZzpQT0le33xesCN0M7IwPP4E4/nUzUxEyBfIC+bot6ZUxf3kuuPuHDeACvHRTgzBThPm
         GPPbzADDzCrt3l6pae5bVhsh4HTGuZwNY0hVSDokcOMPIp//r4R1umTTS3LqUvK4LB5s
         lh7g==
X-Gm-Message-State: ACgBeo2JuYHJ8IDfq4O7xg0q+NhntT74vaRKMxJeZH8ehY8eJJLjtSUv
        DU9oS0XaPX9+je/ED8GXz4Fg6Q==
X-Google-Smtp-Source: AA6agR7R8mNCEwL/D3l+vcBtcrgdDAyd3mWsTq2jAGPWnHMySYMHR3qbt1URZX212VAIIGTEVLmBpw==
X-Received: by 2002:a63:84c6:0:b0:42b:e461:348a with SMTP id k189-20020a6384c6000000b0042be461348amr12598809pgd.87.1661916023299;
        Tue, 30 Aug 2022 20:20:23 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0015e8d4eb1d5sm8633535pla.31.2022.08.30.20.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:20:22 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 3/7] ksm: remove redundant declarations in ksm.h
Date:   Wed, 31 Aug 2022 11:19:47 +0800
Message-Id: <20220831031951.43152-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
References: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
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

