Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0489254324F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbiFHOQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiFHOQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:16:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4A2DABF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:16:50 -0700 (PDT)
X-UUID: ea4646ba2b61414d8124b5d049275114-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:848e658f-d590-4e75-aa37-728240725d3c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:c1071fe5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: ea4646ba2b61414d8124b5d049275114-20220608
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1601970917; Wed, 08 Jun 2022 22:16:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Jun 2022 22:16:43 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 8 Jun 2022 22:16:43 +0800
Message-ID: <7e49e2b73aae471514f277d89bc925da269c89d6.camel@mediatek.com>
Subject: Re: [PATCH] sched: Fix balance_push() vs __sched_setscheduler()
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, <tglx@linutronix.de>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Jonathan.JMChen@mediatek.com>,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Christian Brauner" <brauner@kernel.org>
Date:   Wed, 8 Jun 2022 22:16:43 +0800
In-Reply-To: <Yp/Frp7BMp9E5dSp@hirez.programming.kicks-ass.net>
References: <4a0aa13c99ffd6aea6426f83314aa2a91bc8933f.camel@mediatek.com>
         <20220519134706.GH2578@worktop.programming.kicks-ass.net>
         <52eea711b8ce3151ff73bfb0289cc9da0e8c4a10.camel@mediatek.com>
         <ba7ddde1829ee9eedcd6673f923d731d60719dc5.camel@mediatek.com>
         <78f3347e01a5c46975b9029f93deea2b31bb8393.camel@mediatek.com>
         <Yp+3xFMrypvHcLua@hirez.programming.kicks-ass.net>
         <Yp/Frp7BMp9E5dSp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter


On Tue, 2022-06-07 at 23:39 +0200, Peter Zijlstra wrote:
> On Tue, Jun 07, 2022 at 10:40:36PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 03, 2022 at 12:15:51AM +0800, Jing-Ting Wu wrote:
> > > The patch is helpful to the syndrome, passed stability test over
> > > 10
> > > days so far. (as-is: < 48 hours failed)
> > 
> > Excellent, let me go write a Changelog for it, or something.
> 
> How's this then?

I think the description is fine.
Thanks for your help.

[...]
>  
> -static inline struct callback_head *splice_balance_callbacks(struct
> rq *rq)
> +static inline struct callback_head *
> +__splice_balance_callbacks(struct rq *rq, bool split)
>  {
>  	struct callback_head *head = rq->balance_callback;
>  
> +	if (likely(!head))
> +		return NULL;
> +
>  	lockdep_assert_rq_held(rq);
> -	if (head)
> +	/*
> +	 * Must not take balance_push_callback off the list when
> +	 * splace_balance_callbac() and balance_callbacks() are not


Should we change splace_balance_callbac() to splice_balance_callbacks()
at here?


> +	 * in the same rq->lock section.
> +	 *
> +	 * In that case it would be possible for __schedule() to
> interleave
> +	 * and observe the list empty.
> +	 */
> +	if (split && head == &balance_push_callback)
> +		head = NULL;
> +	else
>  		rq->balance_callback = NULL;
>  
>  	return head;
>  }
>  
[...]


Best Regards,
Jing-Ting Wu

