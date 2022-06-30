Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029185616C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiF3Jq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiF3Jq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:46:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCD642EE6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:46:55 -0700 (PDT)
X-UUID: 8c2a2bdaf553407bbbbc90c751819423-20220630
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:34b29601-5dbe-4836-b6a9-7f5abbaa8bc5,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:105
X-CID-INFO: VERSION:1.1.7,REQID:34b29601-5dbe-4836-b6a9-7f5abbaa8bc5,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:105
X-CID-META: VersionHash:87442a2,CLOUDID:b45940d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:2123257b355c,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8c2a2bdaf553407bbbbc90c751819423-20220630
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 757862333; Thu, 30 Jun 2022 17:46:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 30 Jun 2022 17:46:50 +0800
Received: from mszsdtcf10.gcn.mediatek.inc (10.16.4.60) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 30 Jun 2022 17:46:49 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     Sami Tolvanen <samitolvanen@google.com>
CC:     <xiaoming.yu@mediatek.com>, Kees Cook <keescook@chromium.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Haibo Li <haibo.li@mediatek.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Aaron Tomlin <atomlin@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/2] ANDROID: cfi:free old cfi shadow asynchronously
Date:   Thu, 30 Jun 2022 17:46:44 +0800
Message-ID: <20220630094646.91837-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currenly, it uses synchronize_rcu() to wait old rcu reader to go away
in update_shadow.In embedded platform like ARM CA7X,
load_module blocks 40~50ms in update_shadow.
When there are more than one hundred kernel modules,
it blocks several seconds.

To accelerate load_module,change synchronize_rcu to call_rcu.

*** BLURB HERE ***

Haibo Li (2):
  ANDROID: cfi: enable sanitize for cfi.c
  ANDROID: cfi: free old cfi shadow asynchronously

 kernel/Makefile |  3 ---
 kernel/cfi.c    | 20 +++++++++++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.25.1

