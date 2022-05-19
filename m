Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7652D3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiESNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiESNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:19:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2ACC8BD3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l7xioVIlid5Wh7WU7WZik6lZur+fLsYpq5g+mTWR0Pk=; b=b7a17+X2himp3SfbrlHjutD4cj
        ceQv50Quxzo5sFDHtR7tWwnE83YvGYTrixHxz328sN1rnEAvZKhNgxCOAlJbEHAT3ZAhtqjzNN/3k
        SzoBUjE8nyON1GXKlkJQsqh5cky8daxU89PvFipgxtLiZUoNVgQ6IFeYm2ZCjYuDSABhTKytHLj2n
        FlPEw5KRtN+zrftwcAr4u1OQKbe2dxpuzW1qp8iAMrxHO9nvapnp0lNY6d+7qc55rP4MwkbDMbLiK
        xMqPIlpTfzV3ax22Rlp+KvjVyUDSh51FI6vF1QO6EH/xqWpqf8EmN3A8fqcHXyZ0XYTgKRdjju2Dn
        Wj4cF9kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrg3r-00CkWv-Cc; Thu, 19 May 2022 13:19:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBE42980E0B; Thu, 19 May 2022 15:19:26 +0200 (CEST)
Date:   Thu, 19 May 2022 15:19:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, tglx@linutronix.de,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jonathan.JMChen@mediatek.com,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [Bug] Race condition between CPU hotplug off flow and
 __sched_setscheduler()
Message-ID: <20220519131926.GB6479@worktop.programming.kicks-ass.net>
References: <4a0aa13c99ffd6aea6426f83314aa2a91bc8933f.camel@mediatek.com>
 <20220519131452.GG2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519131452.GG2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 03:14:52PM +0200, Peter Zijlstra wrote:
> On Thu, May 19, 2022 at 08:53:15PM +0800, Jing-Ting Wu wrote:
> > Hi all
> > 
> > 
> > There is a race condition between CPU hotplug off flow and
> > __sched_setscheduler(), which will cause hang-up in CPU hotplug off
> > flow.
> 
> Oooh, you're using core scheduling and the A/B are SMT siblings?

Hmm, no.. lemme try again.
