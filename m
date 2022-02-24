Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267934C2F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiBXPWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiBXPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:21:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD181B4035
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qvM8jMFqdhB8ggMaZ8z1CU+Zz5sAw6Hp+J/ntKdwyaM=; b=fSEXEEkFMLpIgLXbqA2nOecSt5
        9GyadfrtfRSW11ywgU3aKH8kLQRavn57Qv/KH4s1T91yhBZDkCOEvr+un/C9eQmmc4nz9/6JOm/dY
        J0GP1wvipeR3YCNQWhMc4ZRKfu7JNQuyWAy5Zey6KY7njrcUwG3bwJAP9r4TKRrzP/P6Rty8J3O6M
        JXdnafq+WuREFPHtPj3AZcnbGNVskgUV0xqR/2JAHWncXx9h6i6Oa1aa7zVcV1WIwyCJxjUc7cJDQ
        ioNFRqztEASVyMmeXhpvXwJbuSTOSjusqRmok9JiS+7jAXNHRsmw4MPzQRGxoTjCvk6XglWQ8vqsD
        ohuEpbFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFvE-00CeY9-Aj; Thu, 24 Feb 2022 15:20:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FC3C300230;
        Thu, 24 Feb 2022 16:20:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89ECB20164DD3; Thu, 24 Feb 2022 16:20:47 +0100 (CET)
Date:   Thu, 24 Feb 2022 16:20:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Message-ID: <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217154403.6497-1-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
> Current load balancing is mainly based on cpu capacity
> and task util, which makes sense in the POV of overall
> throughput. While there still might be some improvement
> can be done by reducing number of overloaded cfs rqs if
> sched-idle or idle rq exists.

I'm much confused, there is an explicit new-idle balancer and a periodic
idle balancer already there.
