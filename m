Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F3250F35C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbiDZIJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbiDZIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:09:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E34434B80
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:06:02 -0700 (PDT)
X-UUID: c105b1515d8f4bfcb06b245bcf03ea83-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a6e2e7ab-8ac8-4f56-b9c5-3f6ccf239068,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:73a482c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,File:nil,QS:0,BEC:ni
        l
X-UUID: c105b1515d8f4bfcb06b245bcf03ea83-20220426
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 154487007; Tue, 26 Apr 2022 16:05:56 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 26 Apr 2022 16:05:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Apr
 2022 16:05:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 16:05:54 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mingo@redhat.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3 2/2] tracing: make tracer_init_tracefs initcall asynchronous
Date:   Tue, 26 Apr 2022 16:05:54 +0800
Message-ID: <20220426080554.13180-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422180734.225718b7@gandalf.local.home>
References: <20220422180734.225718b7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static __init int tracer_init_tracefs(void)
> > +{
> > +	int ret;
> > +
> > +	trace_access_lock_init();
> > +
> > +	ret = tracing_init_dentry();
> > +	if (ret)
> > +		return 0;
> > +
> > +	INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
> > +	if (!eval_map_wq)
> > +		tracer_init_tracefs_work_func(&tracerfs_init_work);
> 
> Why go through the bother of doing the INIT_WORK if eval_map_wq is not
> created? Just do:
> 
> 	if (eval_map_wq) {
> 		INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
> 		queue_work(eval_map_wq, &tracerfs_init_work);
> 	} else {
> 		tracer_init_tracefs_work_func(NULL);
> 	}

Got it, I will update it in v4.
Thanks!

> 
> But that's just a nit anyway.
> 
> -- Steve
> 
> 
> 
> > +	else
> > +		queue_work(eval_map_wq, &tracerfs_init_work);
> >  
> >  	return 0;
> >  }
