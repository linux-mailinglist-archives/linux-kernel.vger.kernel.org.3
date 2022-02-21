Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308504BDFFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356096AbiBULYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356168AbiBULXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:23:45 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D57655
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:17:57 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id j78so11556330qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xlXsGRli3ze1+3F4Fxu+m92oWVroAjRttnPUA7W+HAk=;
        b=q3wK6oJwVAEXOYSs60uAl84AdwpFF9NoNjhqogmvF8J2uyXxbK7hiF5qnDkWi5Onzi
         iojv7hOY31rbmk6DHbUkrAMr4AhfUZdTy5NoLhiNrASfnrkbvRjExvP/AOJeIQLL2eI7
         pb/wkDqOAYiylzAqOWd+KLWDI8ZHSAJfTeztt7Fu5UxM0kzdJScKnF2rQz6R+FHNwzLY
         Y6OVRQ/UPlpEeopxKBON1qG6sBqHCWOaBTbf25Vq1+ke/k2ME0rknt+wqWFGdGJcbE0G
         81wVcuG2N4TbVy21kU08v7mJHRdsoUs7NGEL6mMLmQvZjZuHcHmVhUuTUZenMerArWJq
         wM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xlXsGRli3ze1+3F4Fxu+m92oWVroAjRttnPUA7W+HAk=;
        b=DleQPyXSlMSMwIXSF7ObOdZIEuiWbwz8djVy3Mdrnn7YeHWmklASC1MpZcyO2gtR1k
         dsTbEBQR2Rm+pAtEQmJli2anZHe54EPAQW+fhW8EPH9eY+ZOgQyLZ/KRFtQV/XHkjbAK
         s31imtwz+yS8qWpi7hN276Y4rrJo28NzJowi9KCicCRHwz5xkEKCl3wYfgnHseAqqtfE
         SSH0okaOCosSwaCPfJou5v0Qm4UeDiE7mRbLqyKK2sq5WVFvx5vhZjmNrzjr++SB8dsr
         ASj6UpSm9G8h5cIEWVhgJsZ+e64DHu12zSdw0ccdy/9ZmOwnmK59FHj3CPzEPmETYLYv
         e8tw==
X-Gm-Message-State: AOAM5303w4kzx6rOVBXmag+vL0reo1IiMCdyxNRBW+M0KtwKvC2flvuT
        ddkWLkeXvBw8qZPm5OqExZA=
X-Google-Smtp-Source: ABdhPJw/Bm47unRUNrP9rgGjLdOY/XVWlTT1u2FHeFomCD9tLiSyRCmTe3k5zzcSU5hTdLLp9qNZGQ==
X-Received: by 2002:a37:cd3:0:b0:5f1:707d:78b9 with SMTP id 202-20020a370cd3000000b005f1707d78b9mr11441751qkm.394.1645442276720;
        Mon, 21 Feb 2022 03:17:56 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j4sm10622085qtp.65.2022.02.21.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:17:56 -0800 (PST)
From:   cgel.zte@gmail.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org
Cc:     rogerq@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guo.ziliang@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH linux-next] mm: swap: get rid of deadloop in swapin readahead
Date:   Mon, 21 Feb 2022 11:17:49 +0000
Message-Id: <20220221111749.1928222-1-cgel.zte@gmail.com>
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

From: Guo Ziliang <guo.ziliang@zte.com.cn>

In our testing, a deadloop task was found. Through sysrq printing, same 
stack was found every time, as follows:
__swap_duplicate+0x58/0x1a0
swapcache_prepare+0x24/0x30
__read_swap_cache_async+0xac/0x220
read_swap_cache_async+0x58/0xa0
swapin_readahead+0x24c/0x628
do_swap_page+0x374/0x8a0
__handle_mm_fault+0x598/0xd60
handle_mm_fault+0x114/0x200
do_page_fault+0x148/0x4d0
do_translation_fault+0xb0/0xd4
do_mem_abort+0x50/0xb0

The reason for the deadloop is that swapcache_prepare() always returns
EEXIST, indicating that SWAP_HAS_CACHE has not been cleared, so that
it cannot jump out of the loop. We suspect that the task that clears
the SWAP_HAS_CACHE flag never gets a chance to run. We try to lower
the priority of the task stuck in a deadloop so that the task that
clears the SWAP_HAS_CACHE flag will run. The results show that the
system returns to normal after the priority is lowered.

In our testing, multiple real-time tasks are bound to the same core,
and the task in the deadloop is the highest priority task of the
core, so the deadloop task cannot be preempted.

Although cond_resched() is used by __read_swap_cache_async, it is an
empty function in the preemptive system and cannot achieve the purpose
of releasing the CPU. A high-priority task cannot release the CPU
unless preempted by a higher-priority task. But when this task
is already the highest priority task on this core, other tasks
will not be able to be scheduled. So we think we should replace
cond_resched() with schedule_timeout_uninterruptible(1),
schedule_timeout_interruptible will call set_current_state
first to set the task state, so the task will be removed
from the running queue, so as to achieve the purpose of
giving up the CPU and prevent it from running in kernel
mode for too long.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Guo Ziliang <guo.ziliang@zte.com.cn>
---
 mm/swap_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8d4104242100..ee67164531c0 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -478,7 +478,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
 		 * in swap_map, but not yet added its page to swap cache.
 		 */
-		cond_resched();
+		schedule_timeout_uninterruptible(1);
 	}
 
 	/*
-- 
2.15.2


