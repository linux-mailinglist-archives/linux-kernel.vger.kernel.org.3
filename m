Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0F50B40D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446010AbiDVJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445997AbiDVJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:30:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FCE50B1B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:28:01 -0700 (PDT)
X-UUID: 6ac17bdd6bf443a3afb4ba92b197a07d-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:9d0dcd59-4ad6-413b-bc6b-efef909c0917,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:9d0dcd59-4ad6-413b-bc6b-efef909c0917,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:12ed9af0-da02-41b4-b6df-58f4ccd36682,C
        OID:8df43ccf756e,Recheck:0,SF:13|15|28|16|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 6ac17bdd6bf443a3afb4ba92b197a07d-20220422
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1006618756; Fri, 22 Apr 2022 17:27:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 17:27:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 17:27:54 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mark-pk.tsai@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mingo@redhat.com>, <rostedt@goodmis.org>, <yj.chiang@mediatek.com>
Subject: [PATCH v3 0/2] tracing: make tracer_init_tracefs initcall asynchronous
Date:   Fri, 22 Apr 2022 17:27:51 +0800
Message-ID: <20220422092751.19386-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220323152257.7871-1-mark-pk.tsai@mediatek.com>
References: <20220323152257.7871-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

Could you please help to review this patch?
Sorry to disturb you, I just want to make sure it has not been
forgotten.

> Move trace_eval_init() to subsys_initcall to make it start
> earlier.
> And to avoid tracer_init_tracefs being blocked by
> trace_event_sem which trace_eval_init() hold [1],
> queue tracer_init_tracefs() to eval_map_wq to let
> the two works being executed sequentially.
> 
> It can speed up the initialization of kernel as result
> of making tracer_init_tracefs asynchronous.
> 
> On my arm64 platform, it reduce ~20ms of 125ms which total
> time do_initcalls spend.
> 
> Mark-PK Tsai (2):
>   tracing: Avoid adding tracer option before update_tracer_options
>   tracing: make tracer_init_tracefs initcall asynchronous
> 
>  kernel/trace/trace.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
> 
> -- 
> 2.18.0
