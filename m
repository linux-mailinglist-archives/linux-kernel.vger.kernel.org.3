Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB02F516988
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbiEBDEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiEBDEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:04:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D2264F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 20:00:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so3092733pjv.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 20:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NE2s1fjGG/uAEM/hW9/W7iCfaqTqfWVCzhrV3oZ8vPU=;
        b=St6K+L7v9I6c0BLH91Oc3CgXzE0EzF1oxBORVKA6081EILjF2vYxXHvDy2af27hlwb
         dXOAqtYu73K5VkdJ4zojDSmnlXltTvWWelkq+7HGPOojN5t5CoHGsRYqjZxINs/x5GDP
         oHcyPD1KI2Dka4KJyIZR2t1uIrBu5GBwhvDGXMLfDYmV7P8m95TssFPV/4/9turP+FSt
         55AmeC/6T1Ec1kMUDsR89e9WT76arYWSFT7EoJvwEyzlTnqzF+doWViIPIBoyngdKgsM
         CJXvoPI848yQfEcuNrc07JtSN7cvDYfSbbePtWmavrGb/V7azDBff/LynRespfCoWehx
         AM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NE2s1fjGG/uAEM/hW9/W7iCfaqTqfWVCzhrV3oZ8vPU=;
        b=UC67I0nspkOMrLNrkEETP2tNG40kkXuCZ1hE0+ziTIflzrwyVWZwoQGkb1H3+61dx4
         6BiuSJAWTUz5eXNhHbiAEz+P7jMdZY2F8qL9PUmFl/+0nS9/EBsaidciKAcx96lp8+kB
         BK/fJOmeANDkYGfs8E2SKWhpI5yo1UdR/LPg8OyrpXMQoXCZTpy1HJbDmm0T72kpresI
         B3a1SlWAEuY9xhRsc5FzFrtfLeUm5zud1lWibwkcpo1pxhLAt1PKUJbvFRkGjVmzRh6V
         eK5yl3kgNCvOC5SN5RHpha6NtpqC3QwIFGOUkij7yYzk7qqkZj3yHtvt8n3HwenjIs6H
         yMDQ==
X-Gm-Message-State: AOAM532u5cHDYRjqgtMni8/Z0/jYT8aMt+dy6mAOkwUVe4eN9AHrDAyq
        kQ0pzGERDTdjnZEQnSoseEPyA6qJzSA=
X-Google-Smtp-Source: ABdhPJxUVP9ub8qowaFf0mUDCz+p6+oZWAbQEV6mZMmoiZDcZ4MyhFARdnYjS9n2HVQwP3YQyHbSzw==
X-Received: by 2002:a17:903:22c7:b0:15d:3359:ca4c with SMTP id y7-20020a17090322c700b0015d3359ca4cmr10055183plg.59.1651460437337;
        Sun, 01 May 2022 20:00:37 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:fa8:c0d6:ea14:bd48])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0015e8d4eb1b9sm3500738plg.3.2022.05.01.20.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 20:00:37 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: don't leave invalid TLB entry in fast_store_prohibited
Date:   Sun,  1 May 2022 20:00:29 -0700
Message-Id: <20220502030029.1695897-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fast_store_prohibited needs to go to the C-level exception handler
it leaves TLB entry that caused page fault in the TLB. If the faulting
task gets switched to a different CPU and completes page table update
there the TLB entry will get out of sync with the page table which may
cause a livelock on access to that page.
Invalidate faulting TLB entry on a slow path exit from the
fast_store_prohibited.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index d703ed31254a..7852481d779c 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -1882,7 +1882,11 @@ ENTRY(fast_store_prohibited)
 	j	8b
 
 2:	/* If there was a problem, handle fault in C */
-
+	rsr	a1, excvaddr
+	pdtlb	a0, a1
+	bbci.l	a0, DTLB_HIT_BIT, 1f
+	idtlb	a0
+1:
 	rsr	a3, depc	# still holds a2
 	s32i	a3, a2, PT_AREG2
 	mov	a1, a2
-- 
2.30.2

