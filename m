Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8E543519
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbiFHOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243360AbiFHOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:48:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F8F26D262
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ynbcduYnQPY1qe6pk+2Qg8JWumGJLJPqMue4O90LXI0=; b=jB1VxiGeoYt00J+l8QE28FUOAT
        PUeMJyGrq5ZSnl2cPYZASbFJD41AI4UNiG+o02PHBTAUgcyLWPOtvAi861AiAPR6cXPP8ZjXbhEOt
        9gToGxQ/9GP3GRA3Mwy0sOB64PPNH2DKVgSqyDvDtBCEVpJmXHiI/iNLuKbo0DCYEn1Wiww/ooOds
        SasUPwrulfvzy6Chtw/LZqL0c/Yuva8TWhIUmzPB3sR224IsDhd5DPrBh3uxdkBc0unReTgNZ90X8
        UipU4vSRR7H2LqOQiINU8ihzktxxrrAvbsn5mc0hjy74k4ds4FrO1K2hzuMwCJ6xaxuqNLMta0dn1
        mZzfBxrw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nywyy-0067Hv-U7; Wed, 08 Jun 2022 14:48:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C75B302F3F;
        Wed,  8 Jun 2022 16:48:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6711C20967F25; Wed,  8 Jun 2022 16:48:28 +0200 (CEST)
Date:   Wed, 8 Jun 2022 16:48:28 +0200
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
Subject: Re: [PATCH] sched: Fix balance_push() vs __sched_setscheduler()
Message-ID: <YqC2vHJ3BLN0XSMz@hirez.programming.kicks-ass.net>
References: <4a0aa13c99ffd6aea6426f83314aa2a91bc8933f.camel@mediatek.com>
 <20220519134706.GH2578@worktop.programming.kicks-ass.net>
 <52eea711b8ce3151ff73bfb0289cc9da0e8c4a10.camel@mediatek.com>
 <ba7ddde1829ee9eedcd6673f923d731d60719dc5.camel@mediatek.com>
 <78f3347e01a5c46975b9029f93deea2b31bb8393.camel@mediatek.com>
 <Yp+3xFMrypvHcLua@hirez.programming.kicks-ass.net>
 <Yp/Frp7BMp9E5dSp@hirez.programming.kicks-ass.net>
 <7e49e2b73aae471514f277d89bc925da269c89d6.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e49e2b73aae471514f277d89bc925da269c89d6.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 10:16:43PM +0800, Jing-Ting Wu wrote:
> > +	/*
> > +	 * Must not take balance_push_callback off the list when
> > +	 * splace_balance_callbac() and balance_callbacks() are not
> 
> 
> Should we change splace_balance_callbac() to splice_balance_callbacks()
> at here?

Pff, typing is so hard.. :-)

I'll also go find me a Fixes tag I suppose.
