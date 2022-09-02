Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD75AB37D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiIBO3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiIBO13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D73168A04
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P7wIoFqf5p36KrKtv5UDBZ0MqutgeRhjhLt/RxYLrNI=; b=n8jSwtqq6VZlmvdbjh8wmD7wHt
        992tnKu9B5qEAn+04B3IBRdVRXfhSKSGbdUbK6FOsphGe81exNCfcpdGFhfd2QcBAsUlESYyOkvam
        gROGc/twSDTKU2OoUS2pSg34TqnC7+87aaMgO2dLYzftp6lV5jbGWzPvDPnJE+zwBh0m7O645lROV
        NximJkP32vjiSYYEmto0mRv40ulkg55JaZiuV2l7w4EM+1PWS5A/Vk00uXkp0GljwePvJ299vFAnU
        rrN5PQzm0v2mKV+5mXHmIOAGFlwJBMqKrIrqjg/Q44QVXvH+ZpjV+cgt58Va9AlBHyk7Kd+AR8yfb
        xEe561QQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU6Gu-008fTr-Ik; Fri, 02 Sep 2022 12:59:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE79D300431;
        Fri,  2 Sep 2022 14:59:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A49622B8AE594; Fri,  2 Sep 2022 14:59:42 +0200 (CEST)
Date:   Fri, 2 Sep 2022 14:59:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Major Chen <major.chen@samsung.com>,
        stable <stable@kernel.org>, Kuyo Chang <kuyo.chang@mediatek.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] sched/debug: fix dentry leak in
 update_sched_domain_debugfs
Message-ID: <YxH+PlfhOV6ZrnrA@hirez.programming.kicks-ass.net>
References: <20220902123107.109274-1-gregkh@linuxfoundation.org>
 <20220902123107.109274-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902123107.109274-2-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:31:07PM +0200, Greg Kroah-Hartman wrote:
> Kuyo reports that the pattern of using debugfs_remove(debugfs_lookup())
> leaks a dentry and with a hotplug stress test, the machine eventually
> runs out of memory.
> 
> Fix this up by using the newly created debugfs_lookup_and_remove() call
> instead which properly handles the dentry reference counting logic.

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/sched/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index bb3d63bdf4ae..667876da8382 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -416,7 +416,7 @@ void update_sched_domain_debugfs(void)
>  		char buf[32];
>  
>  		snprintf(buf, sizeof(buf), "cpu%d", cpu);
> -		debugfs_remove(debugfs_lookup(buf, sd_dentry));
> +		debugfs_lookup_and_remove(buf, sd_dentry);
>  		d_cpu = debugfs_create_dir(buf, sd_dentry);
>  
>  		i = 0;
> -- 
> 2.37.3
> 
