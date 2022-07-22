Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7957DA5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiGVGfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiGVGfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:35:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8011432ED4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:35:39 -0700 (PDT)
X-UUID: d771a68285c6494a964511ceb0fcd37f-20220722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:921bd2d0-ebcf-4cd2-b27a-63423fb4c8c6,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:46c22cd8-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: d771a68285c6494a964511ceb0fcd37f-20220722
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 742952687; Fri, 22 Jul 2022 14:35:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 22 Jul 2022 14:35:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 22 Jul 2022 14:35:31 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] scripts: Fix no space expression between sp and offset
Date:   Fri, 22 Jul 2022 14:35:28 +0800
Message-ID: <20220722063529.7166-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I use older version aarch64 objdump (2.24) to disassemble
aarch64 vmlinux, I get the result like below.
There is no space between sp and offset.

ffff800008010000 <dw_apb_ictl_handle_irq>:
ffff800008010000:       d503233f        hint    #0x19
ffff800008010004:       a9bc7bfd        stp     x29, x30, [sp,#-64]!
ffff800008010008:       90011e60        adrp    x0, ffff80000a3dc000 <num_ictlrs>
ffff80000801000c:       910003fd        mov     x29, sp
ffff800008010010:       a9025bf5        stp     x21, x22, [sp,#32]

When I use newer version aarch64 objdump (2.35), I get
the result like below.

ffff800008010000 <dw_apb_ictl_handle_irq>:
ffff800008010000:       d503233f        paciasp
ffff800008010004:       a9bc7bfd        stp     x29, x30, [sp, #-64]!
ffff800008010008:       90011e60        adrp    x0, ffff80000a3dc000 <num_ictlrs>
ffff80000801000c:       910003fd        mov     x29, sp
ffff800008010010:       a9025bf5        stp     x21, x22, [sp, #32]

Add no space support of regular expression for old version objdump.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/checkstack.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index d2c38584ece6..e404b6b11295 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -56,7 +56,7 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 	if ($arch =~ '^(aarch|arm)64$') {
 		#ffffffc0006325cc:       a9bb7bfd        stp     x29, x30, [sp, #-80]!
 		#a110:       d11643ff        sub     sp, sp, #0x590
-		$re = qr/^.*stp.*sp, \#-([0-9]{1,8})\]\!/o;
+		$re = qr/^.*stp.*sp, ?\#-([0-9]{1,8})\]\!/o;
 		$dre = qr/^.*sub.*sp, sp, #(0x$x{1,8})/o;
 	} elsif ($arch eq 'arm') {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
-- 
2.18.0

