Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF70500808
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiDNIOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiDNIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:14:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB146658
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:11:40 -0700 (PDT)
X-UUID: cc846f08a8b14c8188298998acd3a84c-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:4c515ac7-047f-47eb-a159-2ab1329cdf3b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:54
X-CID-INFO: VERSION:1.1.4,REQID:4c515ac7-047f-47eb-a159-2ab1329cdf3b,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_UHam,ACTI
        ON:release,TS:54
X-CID-META: VersionHash:faefae9,CLOUDID:197720a9-d103-4e36-82b9-b0e86991b3df,C
        OID:10fbb2c55067,Recheck:0,SF:13|15|28|100|16|19|48|101,TC:nil,Content:0,E
        DM:-3,File:nil,QS:0,BEC:nil
X-UUID: cc846f08a8b14c8188298998acd3a84c-20220414
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 450445553; Thu, 14 Apr 2022 16:11:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 Apr 2022 16:11:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 16:11:32 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH -next] sound/oss/dmasound: fix 'dmasound_setup' defined but not used
Date:   Thu, 14 Apr 2022 16:11:18 +0800
Message-ID: <20220414081119.30851-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed: 'dmasound_setup' defined but not used error with
COMPILER=gcc ARCH=m68k DEFCONFIG=allmodconfig build.

__setup() does not work if MODULE is defined.
Fix it by warpping dmasound_setup with #ifndef MODULES.

Error(s):
sound/oss/dmasound/dmasound_core.c:1431:12: error: 'dmasound_setup' defined but not used [-Werror=unused-function]

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 sound/oss/dmasound/dmasound_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 9c48f3a9e3d1..a1b3e71beadf 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -1428,6 +1428,7 @@ void dmasound_deinit(void)
 		unregister_sound_dsp(sq_unit);
 }
 
+#ifndef MODULE
 static int dmasound_setup(char *str)
 {
 	int ints[6], size;
@@ -1470,6 +1471,7 @@ static int dmasound_setup(char *str)
 }
 
 __setup("dmasound=", dmasound_setup);
+#endif
 
     /*
      *  Conversion tables
-- 
2.18.0

