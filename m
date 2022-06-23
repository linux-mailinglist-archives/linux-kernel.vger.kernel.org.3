Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CDB55789A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiFWLUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFWLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:20:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E8C2CE23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:19:59 -0700 (PDT)
X-UUID: 76c5a1469e72402c87de6a570c79ee02-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:1bb3db0d-3547-452c-a3c9-ca21abe7ce18,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:a94654ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 76c5a1469e72402c87de6a570c79ee02-20220623
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1995390876; Thu, 23 Jun 2022 19:19:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 23 Jun 2022 19:19:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 23 Jun 2022 19:19:51 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Yee Lee <yee.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/1] mm: kfence: remove kfence_pool from leak trace
Date:   Thu, 23 Jun 2022 19:19:34 +0800
Message-ID: <20220623111937.6491-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

Since the latest patches of kmemleak separated its address management 
to two, phys and virt, rb-trees, the kmemleak_free failed to free kfence_pool
in the virt tree. It caused unexpected scan the blocks and triggered
kfence faults.

Reference: 
https://lore.kernel.org/linux-mm/20220611035551.1823303-1-patrick.wang.shcn@gmail.com/

 ==================================================================
 BUG: KFENCE: invalid read in scan_block+0x13c/0x838

 Invalid read at 0x000000003dc26873:
  scan_block+0x13c/0x838
  scan_gray_list+0x1f0/0x478
  kmemleak_scan+0x63c/0xd64
  kmemleak_write+0x618/0x8cc
  full_proxy_write+0x70/0x138
  vfs_write+0x108/0x314
  ksys_write+0x7c/0x14c
  __arm64_sys_write+0x20/0x30
  el0_svc_common+0xa8/0x144
  do_el0_svc+0x30/0xd4
  el0_svc+0x38/0x15c
  el0t_64_sync_handler+0x88/0xf8
  el0t_64_sync+0x1a0/0x1a4

 CPU: 0 PID: 128 Comm: sh Not tainted 5.18.0-mainline-40996-g7d83a175ff4a-dirty #1
 Hardware name: linux,dummy-virt (DT)
 ==================================================================
 
This patch change to call the memblock alloc with the flag to skip leak tracking.
And the latter kmemleak_free can be removed too.


Yee Lee (1):
  mm: kfence: skip kmemleak alloc in kfence_pool

 mm/kfence/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.18.0

