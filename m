Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C57565137
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiGDJpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiGDJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:45:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD36305
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BEWy+0/wLCKIizaCXDa1U1tTt+9Nm7YQLTemCVOYvTA=; b=iZCNYJBuLIvccSOeR/1HhWjMvJ
        nUvNPxhEyRdkU4B2zOlRebHaawC8Pp5aXt+HU9ZcKfQE65DOrzKaFpr2/0MKvSQpr4kz+KM0GbfeS
        Zz6LiDPNsp7bEidhufzvoMFb09m7s1RL9G+M222eSC++5VecHs9/XQHkB+CVdDmRpmZh4RfxS6Qt/
        TAXGCdk63LTYjW/ra3g8zjXbPAqu/g5ag9Hzl9+ayt/9tHmeByumVFe1fujoAw0wWWvddSk2C4HrN
        SGdLzRJFKvwtJYEa+ApsxfXdhOLAHj9D3G4cvD43bw1CRji2/d301BSDASZxhD3xdSrzDO02l0blr
        Nz/ck02Q==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Idr-00H4of-4x; Mon, 04 Jul 2022 09:45:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4E0E30027E;
        Mon,  4 Jul 2022 11:45:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAE8D20295B20; Mon,  4 Jul 2022 11:45:18 +0200 (CEST)
Date:   Mon, 4 Jul 2022 11:45:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/core: Introduce nr_running percpu for each
 cookie
Message-ID: <YsK2riNersXeRgKM@hirez.programming.kicks-ass.net>
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1656403045-100840-3-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656403045-100840-3-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:57:24PM +0800, Cruz Zhao wrote:

>  static unsigned long sched_core_alloc_cookie(void)
>  {
>  	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
> +	int cpu;
> +
>  	if (!ck)
>  		return 0;
>  
>  	refcount_set(&ck->refcnt, 1);
> +
> +	ck->nr_running = alloc_percpu(unsigned int);

	if (!ck->nr_running)
		// do something

> +	for_each_possible_cpu(cpu)
> +		*per_cpu_ptr(ck->nr_running, cpu) = 0;

So I really, as in *really* dislike how this blows up the size of
cookies. Esp. with 100s of CPUs not actually being rare these days.
