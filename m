Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A27582854
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiG0OO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiG0OOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:14:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABB3D5A1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:14:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l22so2901721wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VvR5xY6dLjk1KtYgBo6Q5I3yBxc3nrSFaDP4RWXJJLM=;
        b=MMlKL/nId+e/+IYux31/RpJISKDYzVgZCc+XZn7yNFcvcmjXlgfKQs8R/5cB/srq4+
         uQnImFmvr0x5OaueZz4B28Z4jmzuz2MNE9rL+X4lbJUY90Wyq8Bs59MPtryNvPrTuto1
         VCoFm7wBXlbHOB2PU0tNZdlivixennKv1/pKZZDjZ4OEwvZOv4AEXcPtCRQBFMrL2buP
         oyJJ97imfOXWv1TEsF9DFXfqf6uAfmfF3zAxx6UGEGQ3QAFocVeh3rcXbn8HLJQJGvJc
         UGTj2/faPcbLpaGomlrHUofc8oWQup6MWdcCBAKnONwFqMlFVN1qU5Mzom1S229jLWY3
         e4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VvR5xY6dLjk1KtYgBo6Q5I3yBxc3nrSFaDP4RWXJJLM=;
        b=bVOXCaBXsgfygUxuWJKS87ROM+QPmMevseLaSGq6HYkT2//j2M7M9/TtCgJxqXAAg6
         ZVxSixZ3knInaZA19xAHDhxFtUlOFYukeQm3iNvbZKVMpSIh/cw2XNTyUaUl+8uhKB17
         pb8uexG3HxvKCyoJURWzWkgVv30IEtx+jhgl+/gGxHRh8KehUymVOaKEjjPgVwH/b/Og
         kWBCu74vGGlhqc6Bc8nMRLYx/sqQ2qfOSHGV1+72Zeb6Jf4oZpmnexHVwz0k/K0sBlbc
         58IRsL+T6CexufTByDGdx5cW6oLs9VtYUx8yGQqys0gzFSbcV8JKe4e2tw6dUYXgvzp9
         tk6A==
X-Gm-Message-State: AJIora/DpbeKCJ37iUw2ix9DLKhPFaUVMSDiw5aoA7wKyT9eIDJ/uBaF
        CY6deLygG7cazHJRZuuikHa4og==
X-Google-Smtp-Source: AGRyM1tntpJT9rAfvN/YlaJ6WTslyCUAB6qx2NmoHD2rQ/rEAgbGGcTLXGrurjwY9hKU74J7mCN+Ng==
X-Received: by 2002:adf:e0cb:0:b0:21e:9ed9:d862 with SMTP id m11-20020adfe0cb000000b0021e9ed9d862mr6171174wri.518.1658931289817;
        Wed, 27 Jul 2022 07:14:49 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id o20-20020a05600c339400b0039c54bb28f2sm2489524wmp.36.2022.07.27.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:14:49 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     jan.kiszka@siemens.com
Cc:     linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        kbingham@kernel.org, Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH 2/3] scripts/gdb: timerlist: fix rb_node access
Date:   Wed, 27 Jul 2022 16:14:42 +0200
Message-Id: <20220727141443.133094-3-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727141443.133094-1-aouledameur@baylibre.com>
References: <20220727141443.133094-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"strcut timerqueue_head" no longer has "next" member since v5.4-rc1:
commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next
timer")

Therefore, access "rb_node" through active->rb_root->rb_root->rb_node.

Moreoever, remove  curr.address.cast() on rb_node as this breaks the code
and is not necessary.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 scripts/gdb/linux/timerlist.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index fac951236dc4..d16909f8df35 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -43,8 +43,7 @@ def print_timer(rb_node, idx):
 
 
 def print_active_timers(base):
-    curr = base['active']['next']['node']
-    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
+    curr = base['active']['rb_root']['rb_root']['rb_node']
     idx = 0
     while curr:
         yield print_timer(curr, idx)
-- 
2.37.1

