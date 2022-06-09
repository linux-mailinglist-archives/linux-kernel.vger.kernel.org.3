Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB754418A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiFIClx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFIClv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:41:51 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B9D91093
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JoUAa
        1pHcGayDeuqRSDJfulxbExWpOWMmPd/B5mMrWs=; b=Oc/ZqRxjliqaBWDPfF5bE
        /wazxTKs562aT5A1KMP9mXPcn//O40VNwsS60mnLHByw+HJOJoSSmcHYrdmX06NV
        ICXSzxXBxRMVtzrtVAqM+l16eLHaJhnimjpBXwMPYM+NjGyguqXT7vlsiMBkY19B
        iqdrtZhMhCP5X6kNest05I=
Received: from whomami-G7-7588.. (unknown [223.104.41.214])
        by smtp8 (Coremail) with SMTP id DMCowAAnLKXWXaFi4v6CGw--.11496S2;
        Thu, 09 Jun 2022 10:41:27 +0800 (CST)
From:   tjytimi <tjytimi@163.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tjytimi <tjytimi@163.com>
Subject: [PATCH] memblock: avoid some repeat when add new range
Date:   Thu,  9 Jun 2022 10:41:22 +0800
Message-Id: <20220609024122.6679-1-tjytimi@163.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAnLKXWXaFi4v6CGw--.11496S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1Duw48tFy3JF1fKr1ftFb_yoWfuwc_tr
        40gFs7GFWrAa1Fka1jy34rJFy7KFZYvr1kJrn3Jws3u3ykXF1qk3y8K3WDWr1kGF1UG3s8
        Gw4UuF17K3WSqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt38nUUUUUU==
X-Originating-IP: [223.104.41.214]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiTRcbeFc7YZhUfgAAsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: tjytimi <tjytimi@163.com>
---
 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index e4f03a6e8..243cd7de5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -602,6 +602,9 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	base = obase;
 	nr_new = 0;
 
+	if (type->cnt<<1 < type->max - 1)
+		insert = true;
+
 	for_each_memblock_type(idx, type, rgn) {
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
-- 
2.32.0

