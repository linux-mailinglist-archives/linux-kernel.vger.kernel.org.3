Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1834EB5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbiC2WQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiC2WQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:16:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8E7186FA6;
        Tue, 29 Mar 2022 15:14:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e16so32640361lfc.13;
        Tue, 29 Mar 2022 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bUho4h3zzyg8mrHSXNWvfp6RptsEnl8G83mOpfY+8A=;
        b=bh7oMU8UPCqwbBrPRO6PPukc9f8hIRc+lb/bA8WWrXnuXulYF2BEAQFo14jUSUDx5s
         v/eUHNA5ayGfb5BqoNdiNDRyXPrC1kpH0/sYRj+1xjYsWuZRqw59J5mjFIRxTaeQILoI
         ocRVQEiF/frLG4RsG1ZpC51jWy3KK0satvkTzAMdkhAk01zHUUHXsKBI4N5zaQ63yagx
         +pP7SOPZ0AqLBbyBtQl7RM93hlDECYrq3hkLFEgYZ9s2pbU0vyGqNmK3JOP4ApjsQobO
         0VR9mde15FL1GZzs7GBEGpVvlUuPCqk8bBPtHlv5+7ul4Ehb5d0eFzkheJVgvZ+O2OSz
         jAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bUho4h3zzyg8mrHSXNWvfp6RptsEnl8G83mOpfY+8A=;
        b=5VULLdid1e7dQopbvgYWWmnxPSWFXBmTuTUgVG1Nk9WKwlwhc5nHmKtc5jyHOneEHw
         PSk04F6VZRSYsTmUDBlPcjdXWLgJa5XjsTkS/Hx2VO26qi7asHVvzDXc0iB1rcMJHGiS
         ldhYnDcGlFM1BWm9jUysRCrQC1FEW4MIc1iktTb+C14z5UMX9xS8d6Ozso81x2p+mZZf
         yKA7WlvTGxvH8vzhdFHzyL/HPhyJEbpW2zRXgOhBCNbOt2X69TWIyYzDiQ0IH55s2zue
         SzBGtHRvClKOx4a+pA7r3urs0HnWk78riLzr78lNgQA8h/AYB9Z+CynFO8fJuyhmW3uo
         SQ5Q==
X-Gm-Message-State: AOAM532HaH2PJEoLNu7zHj+4jtyOKBaQimOuBM7mCtnnxeFSRXa+1mE/
        Qa4FXACaCevvkcMh+Phv3IM=
X-Google-Smtp-Source: ABdhPJw/Cx1HFbKNuVfKF/lbkCI8c5zDX6pAuLqHOq2y9eMru5aTEj+d6/wIaOiUwpZ/NAFJvnki7A==
X-Received: by 2002:a05:6512:13a1:b0:448:887e:da38 with SMTP id p33-20020a05651213a100b00448887eda38mr4661334lfa.298.1648592073440;
        Tue, 29 Mar 2022 15:14:33 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.225])
        by smtp.gmail.com with ESMTPSA id h16-20020ac24db0000000b0044aace47e83sm427397lfe.185.2022.03.29.15.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:14:33 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     sumit.semwal@linaro.org, gustavo@padovan.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com
Subject: [PATCH next] dma-buf/sync-file: do not allow zero size allocations
Date:   Wed, 30 Mar 2022 01:14:25 +0300
Message-Id: <20220329221425.22691-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

syzbot reported GPF in dma_fence_array_first(), which is caused by
dereferencing ZERO_PTR in dma-buf internals.

ZERO_PTR was generated in sync_file_merge(). This functuion tries to
reduce allocation size, but does not check if it reducing to 0.

Fix reported bug by validating `index` value before passing it to
krealloc_array().

Fail log:

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 3595 Comm: syz-executor814 Not tainted 5.17.0-next-20220328-syzkaller #0
...
RIP: 0010:dma_fence_array_first+0x78/0xb0 drivers/dma-buf/dma-fence-array.c:234
...
Call Trace:
 <TASK>
 __dma_fence_unwrap_array include/linux/dma-fence-unwrap.h:42 [inline]
 dma_fence_unwrap_first include/linux/dma-fence-unwrap.h:57 [inline]
 sync_file_ioctl_fence_info drivers/dma-buf/sync_file.c:414 [inline]
 sync_file_ioctl+0x248/0x22c0 drivers/dma-buf/sync_file.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]

There was same problem with initial kcalloc() allocation in same
function, so it's fixed as well.

Reported-and-tested-by: syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com
Fixes: 519f490db07e ("dma-buf/sync-file: fix warning about fence containers")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/dma-buf/sync_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index b8dea4ec123b..aa744f017008 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -212,7 +212,7 @@ static struct sync_file *sync_file_merge(const char *name, struct sync_file *a,
 	dma_fence_unwrap_for_each(b_fence, &b_iter, b->fence)
 		++num_fences;
 
-	if (num_fences > INT_MAX)
+	if (num_fences > INT_MAX || !num_fences)
 		goto err_free_sync_file;
 
 	fences = kcalloc(num_fences, sizeof(*fences), GFP_KERNEL);
@@ -264,7 +264,7 @@ static struct sync_file *sync_file_merge(const char *name, struct sync_file *a,
 	if (index == 0)
 		add_fence(fences, &index, dma_fence_get_stub());
 
-	if (num_fences > index) {
+	if (index && num_fences > index) {
 		struct dma_fence **tmp;
 
 		/* Keep going even when reducing the size failed */
-- 
2.35.1

