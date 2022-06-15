Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD68754C4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiFOJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbiFOJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:40:40 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA8113E5EF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DuQRL
        Pteq/QutWLRbDO/GDt2Co+X3sypT6f1CtgXWPY=; b=SM4reZzQ1xo/P/1Hwvw+a
        30DZvOoTrVYxqNRae8MrGUVLU6OVRwMyzEXXJTi3ssqtJ7wKHOxxfJxB55VtAxRl
        g3gwzCQ3RY/X1PGfwtQmAeLSjk9XggKFWa0iK1LJDv6uSvaXVtJohm7QBkv304Sb
        iYrPbJRcQuq2jAyg03whtY=
Received: from whoami-Latitude-5401.. (unknown [223.104.41.12])
        by smtp9 (Coremail) with SMTP id DcCowAAnouAAqalieFS0JA--.51718S2;
        Wed, 15 Jun 2022 17:40:17 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jinyu Tang <tjytimi@163.com>
Subject: [PATCH v2] memblock: avoid some repeat when add new range
Date:   Wed, 15 Jun 2022 17:40:15 +0800
Message-Id: <20220615094015.3672-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnouAAqalieFS0JA--.51718S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1UCw4kKFyxuFyktw17GFg_yoW8GFyfpr
        48Gw4fCr4fJFn2v3WfJa43Wr13Aw4fGrW5Cr4a9rnFgFZ5tFy7Krs5Gws8Ka48G39rtw1S
        vF42qrW7JwnrZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR8hLUUUUUU=
X-Originating-IP: [223.104.41.12]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbipQEheFUMkYVtiwAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The worst case is that the new memory range overlaps all existing
regions,which need type->cnt + 1 free area of struct memblock_region.
So if type->cnt + 1 + type->cnt is less than type->max,we can insert
regions directly.And becase of merge operation in the end of function,
tpye->cnt increase slowly for many cases.So this patch can avoid
unnecessary repeat for many cases when add new memory range.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
V1 -> V2: 1.Change the code as reviewer suggestions
           2.Add comment in the code
           3.Move the code above the repeat lable, because if reapeat
           code executed twice, insert is already true and don't need
           to test

 mm/memblock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index e4f03a6e8..e94661fd3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -593,6 +593,17 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		type->total_size = size;
 		return 0;
 	}
+
+	/*
+	 * The max free regions needed is when new range overlaps all existing
+	 * regions, which will cost type->cnt + 1 free regions. So if
+	 * type->cnt * 2 + 1 is less than type->max, We can confirmed
+	 * that there is enough number of regions, and we can insert
+	 * regions directly.
+	 */
+	if (type->cnt * 2 + 1 < type->max)
+		insert = true;
+
 repeat:
 	/*
 	 * The following is executed twice.  Once with %false @insert and
-- 
2.30.2

