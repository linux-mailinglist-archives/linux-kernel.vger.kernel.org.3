Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6D4F0723
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 05:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiDCDnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 23:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiDCDnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 23:43:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8648231923
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 20:41:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x14so2483915pjf.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 20:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=wKcnleMWX6fErDylcJrWaDMR8n2XsKTiHTFRkseuUTs=;
        b=nOM/32mR775dkbEKBIoRJT1Pacg3FAE7iEsIBHKUc5M+xqFl+hzZLei8rS2ioR+P8W
         EXB+2qdhdzui1gBZqPFUoR/+dqq9v4HCvw22GSYcNNCMGYnpsSXVFF6S1d7ghb9iJPhv
         y/G5JlXbPAqXGK4IFE+Gll7Z3VPTW3OBbHU2i9trUcBJjtDCedHWv/SulaSxfQcwlKGR
         ycVKvchI01uPq7AmAKYpvgyWtUYfWrqng1LpOc38FlUrqLmtAqBzJnlmMKTcublPwJrR
         hWSd8Y8wi9FLo2VL0WASe4UsawEArgy5DUV3fA74Ngout/yyfcUqKBM0UfVgPm2DjzIu
         sC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wKcnleMWX6fErDylcJrWaDMR8n2XsKTiHTFRkseuUTs=;
        b=tcl4ouItEvckHNvB3fTuyOy/tAJ0cUTD+0L4+fIt5S/BaPzW6Xj3BUQI2Ln6uyN3t1
         CInLQqnl+Kj334tnPI5+KzpmXA1avChZy6eWDuoLHilxvdtVO95g57MHQsIrCu/y8NxI
         FYDd1AarGD1uxuEpF+/9YCExHzm4vKCccFx1y7G1Sj6URN2Kk/QllBXFDPswlfvg/5EJ
         +bk256cTh8otm5XzP7+L48cFNgrMca06BWBwYdIIfqnxZe2VnD6CNeIJR9KVmVRk6h6X
         SvpjeSQTdhgaw5jpi0z1+lrUqrxKV2pu/ocOt8fdTYZpsACJDlRNzp5hDIlJnHxBY6nI
         xjGA==
X-Gm-Message-State: AOAM530oSO2ZYsjdR6MMZYNCNZqrzl1CNGVq1vvqRPPDYcyPygph2wJE
        tTAGXBWAI1WRVGsLosbk9MleVaHFkt4=
X-Google-Smtp-Source: ABdhPJyOFt+eICj3S8tPcD+56WBb2Tz2iwGW0YkRJ1H3Gfxu6b7msnMxRZJJaW6aZLzixAXzPEC6wA==
X-Received: by 2002:a17:902:7e0d:b0:156:47a4:a7c4 with SMTP id b13-20020a1709027e0d00b0015647a4a7c4mr17487903plm.141.1648957272910;
        Sat, 02 Apr 2022 20:41:12 -0700 (PDT)
Received: from localhost.localdomain ([183.156.181.188])
        by smtp.googlemail.com with ESMTPSA id x14-20020aa784ce000000b004fa79973c94sm7215598pfn.165.2022.04.02.20.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 20:41:12 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] md: dm-mpath: use list iterator only inside the loop
Date:   Sun,  3 Apr 2022 11:41:01 +0800
Message-Id: <20220403034101.14735-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the declare of list iterator into the list_for_each_entry_*()
macro in the future, it should be avoided to use the list iterator
variable after the loop body [1].

Because the cases (the list is empty or no entry is found) have been
checked prior to iterating m->priority_groups, it is fine to move the
bypass_pg(m, pg, bypassed); inside the loop when entry is found.

[1]: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---

changes since v1:
 - it is not a bug, have checked before (Mike Snitzer)
 - tweak code to avoid dead code "return -EINVAL;" (Xiaomeng Tong)

v1: https://lore.kernel.org/lkml/20220327053742.2942-1-xiam0nd.tong@gmail.com/

---
 drivers/md/dm-mpath.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index f4719b65e5e3..13c65eab32a2 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1496,11 +1496,12 @@ static int bypass_pg_num(struct multipath *m, const char *pgstr, bool bypassed)
 	}
 
 	list_for_each_entry(pg, &m->priority_groups, list) {
-		if (!--pgnum)
+		if (!--pgnum) {
+			bypass_pg(m, pg, bypassed);
 			break;
+		}
 	}
 
-	bypass_pg(m, pg, bypassed);
 	return 0;
 }
 
-- 
2.17.1

