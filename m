Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0713D47FD43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhL0NK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhL0NK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:10:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DD6C06173E;
        Mon, 27 Dec 2021 05:10:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso8182545wmk.1;
        Mon, 27 Dec 2021 05:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=B6EDKAnHtoumNaOqDyi3E7TX6yPK13Mj5ojCgKu08oc=;
        b=YAtG05krtdU9+ZKMiMUsGDdQ106+O6rwJkSc3+B1OrJeLMEu7x5YxedoO441w25Me6
         WNNOup1KpSIHxOXs2fKl+dzKfd+Ao4yOBlEMFCgcHJM+lxazc0CpPNTHGAltw+uEauUs
         pdalXh4hVj28OMwyhcsNuKLcWzeFZqXmgdBgV6I8xpkSGyEenqFdnXzdKeW4blFMn9zG
         IdJTg+sfZ02OUpoP4uyhhGtu3q9hQoMLccoV4l2V6EqbYelkj3LhYnQO4Fqs9mJFKBgb
         UD2KK3cMepIP5auToveFOPk0tTJi35PSR5meyu21AY3aXYp1qg2YkAForBZZls6ROd+a
         I5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B6EDKAnHtoumNaOqDyi3E7TX6yPK13Mj5ojCgKu08oc=;
        b=i9X/UZUH0uJmk7/PpGVhHObJkCyVCo+lctsNbLyt2ctZvU+14BpbZEx28nEJJGTPt4
         XNo1MD14mq14HXThQCwCy6Uxv8k1XerJgKurLp2+iTu9fcdFscf+GegQ3EpLcB9w9se/
         bLNzSAb6tZ6ZbOSBQlZhpcHmh8KBd3/Iu7KRnbh8owyI7MoOGtNqWBEnPUGj3s/pIhUm
         BzedDGEJ/9cc7HkTCIOQg8DnbSaDBVaww24Cc3RonsZ0EjhCXlisEXejgtHIWVoha2Y7
         RVcjNe/9saYgdpKKFMnPaD0LYb2Xe4NDMVLFW3iqrbypxc3XjFa2hXOQFvR2ONpADp23
         pm5Q==
X-Gm-Message-State: AOAM533Dp3TlmU9KGmiP+C++SrZw3lWZSMjv5h1aAp1R0FO2Wxa5Ssva
        WFPzsnJNEjedMv/ezJacB6Y=
X-Google-Smtp-Source: ABdhPJw6OyLoHPd6dzSdn/iAJCsy45wJ8UA0VVqIflmFaZbeRCmMTG2k8vwe/wGY1GAJeXlYpxx8hQ==
X-Received: by 2002:a05:600c:c7:: with SMTP id u7mr13159108wmm.85.1640610655047;
        Mon, 27 Dec 2021 05:10:55 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:26c4:7200:610f:609b:d46a:2a08])
        by smtp.gmail.com with ESMTPSA id y13sm17170951wrd.89.2021.12.27.05.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:10:54 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] taskstats: remove unneeded dead assignment
Date:   Mon, 27 Dec 2021 14:10:41 +0100
Message-Id: <20211227131041.4668-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make clang-analyzer on x86_64 defconfig caught my attention with:

  kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
  [clang-analyzer-deadcode.DeadStores]
          rc = 0;
          ^

Commit d94a041519f3 ("taskstats: free skb, avoid returns in
send_cpu_listeners") made send_cpu_listeners() not return a value and
hence, the rc variable remained only to be used within the loop where
it is always assigned before read and it does not need any other
initialisation.

So, simply remove this unneeded dead initializing assignment.

As compilers will detect this unneeded assignment and optimize this anyway,
the resulting object code is identical before and after this change.

No functional change. No change to object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201105
Resend: still applies cleanly on next-20211224

Balbir, please pick this minor non-urgent clean-up patch.

 kernel/taskstats.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index a2802b6ff4bb..bd18a7bf5276 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -117,7 +117,6 @@ static void send_cpu_listeners(struct sk_buff *skb,
 
 	genlmsg_end(skb, reply);
 
-	rc = 0;
 	down_read(&listeners->sem);
 	list_for_each_entry(s, &listeners->list, list) {
 		skb_next = NULL;
-- 
2.17.1

