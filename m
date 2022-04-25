Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC4850E0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbiDYNA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiDYM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:59:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730FC13F07
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Aa8NjesftYaYdVR4FodOHD3Am4qVmIUulGnfWxf72A=; b=Uv4C9qFu2PZVZ1ukPBDTBO8lh9
        G8o5jXw0aqBACRIMk4SyS7RjO6iAK8+1+6Efx/orxFmFyALN33PKvz6hX2wuDFu7IdZnOdnrmeNsV
        wvarazNwNwTLBK8keVkl+6ld3tk3ZzOTcvf29TuNMWx85Nv3VfKcDvzjR8BWAQj58Xo9pZD0p9Qvd
        n2KSFFwt+/Bt2TPAAssDOHTWqP48vhjpOHeRI1Yqthkw4oH2GpF/uN0r7f7im+zj4PD7PAVZkjDos
        1hADAadbf5o+KGEhtIlOz+k0ABIWjnRAWavTzTHt42wsZqLDK4k45990cCxcE4CHFe3Q/uGCRnRfF
        avdvm/OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niyG1-008XnQ-B3; Mon, 25 Apr 2022 12:56:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D231C980C1C; Mon, 25 Apr 2022 14:55:58 +0200 (CEST)
Date:   Mon, 25 Apr 2022 14:55:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V5 0/3] smp: Make softirq handling RT friendly
Message-ID: <20220425125558.GJ2731@worktop.programming.kicks-ass.net>
References: <20220413132836.099363044@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413132836.099363044@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:31:00PM +0200, Thomas Gleixner wrote:
>  include/linux/interrupt.h    |    9 +++++++++
>  include/linux/sched.h        |    2 ++
>  kernel/sched/build_policy.c  |    2 ++
>  kernel/sched/build_utility.c |    1 +
>  kernel/sched/core.c          |    5 ++++-
>  kernel/sched/deadline.c      |    2 --
>  kernel/sched/fair.c          |    1 +
>  kernel/sched/idle.c          |    2 +-
>  kernel/sched/sched.h         |    8 ++------
>  kernel/sched/smp.h           |    6 ++++++
>  kernel/smp.c                 |   32 ++++++++++++++++++++++++--------
>  kernel/softirq.c             |   13 +++++++++++++
>  kernel/stop_machine.c        |    2 --
>  13 files changed, 65 insertions(+), 20 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
