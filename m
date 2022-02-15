Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14BC4B622C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiBOEhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:37:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiBOEhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07F23658B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 20:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644899843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=laXOEz3XJdYs1LRtIBGtVU1b1vkDx30bGp7eg3VkwMk=;
        b=eedXwCesZtTFqtHOt/UMSC7EOP4zEfrvhKbyiJtYg6zYLW3lw//xvqo5T+dtXK6Mmt8E0h
        8u/V1kRxee3FzYeVtvEkn+2OfzoQiOOrQ/JPb7suR0nMsUnyzZkeiMtWjtuBx9nM9qJUco
        Iji4Sg2RHXm9jsULZaFACqejkph9fE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-iwVetfnMPOqHWCamb6Z0eA-1; Mon, 14 Feb 2022 23:37:19 -0500
X-MC-Unique: iwVetfnMPOqHWCamb6Z0eA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56C691091DA1;
        Tue, 15 Feb 2022 04:37:18 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41CBA5BC3C;
        Tue, 15 Feb 2022 04:37:07 +0000 (UTC)
Date:   Tue, 15 Feb 2022 12:37:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuyufen@huawei.com,
        guohanjun@huawei.com
Subject: Re: [RFC PATCH] blk-mq: avoid housekeeping CPUs scheduling a worker
 on a non-housekeeping CPU
Message-ID: <Ygst7R+X7u2OBgUW@T590>
References: <20220210093532.182818-1-wangxiongfeng2@huawei.com>
 <881ae7a8-5dff-ff50-9bc2-a983b6a53c30@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <881ae7a8-5dff-ff50-9bc2-a983b6a53c30@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xiongfeng,

On Tue, Feb 15, 2022 at 10:29:51AM +0800, Xiongfeng Wang wrote:
> Hi Ming,
> 
> Sorry to disturb you. It's just that I think you may be interested at this
> patch. I found the following commit written by you.
>   commit 11ea68f553e244851d15793a7fa33a97c46d8271
>   genirq, sched/isolation: Isolate from handling managed interrupts
> It removed the managed_irq interruption from non-housekeeping CPUs as long as
> the non-housekeeping CPUs do not request IO. But the the work thread
> blk_mq_run_work_fn() may still run on the non-housekeeping CPUs.
> Appreciate it a lot if you can give it a look.

Yeah, commit 11ea68f553e24 touches irq subsystem to try not assign
isolated cpus for managed irq's effective affinity.

Here blk-mq just selects one cpu and calls mod_delayed_work_on()
to execute the run queue handler on specified cpu. There are lots of
such bound wq usage in tree, so I guess it might belong to one wq or
scheduler generic problem instead of blk-mq specific issue. Not sure
if it is good to address it in block layer.

thanks,
Ming

> 
> Thanks,
> Xiongfeng
> 
> On 2022/2/10 17:35, Xiongfeng Wang wrote:
> > When NOHZ_FULL is enabled, such as in HPC situation, CPUs are divided
> > into housekeeping CPUs and non-housekeeping CPUs. Non-housekeeping CPUs
> > are NOHZ_FULL CPUs and are often monopolized by the userspace process,
> > such HPC application process. Any sort of interruption is not expected.
> > 
> > blk_mq_hctx_next_cpu() selects each cpu in 'hctx->cpumask' alternately
> > to schedule the work thread blk_mq_run_work_fn(). When 'hctx->cpumask'
> > contains housekeeping CPU and non-housekeeping CPU at the same time, a
> > housekeeping CPU, which want to request a IO, may schedule a worker on a
> > non-housekeeping CPU. This may affect the performance of the userspace
> > application running on non-housekeeping CPUs.
> > 
> > So let's just schedule the worker thread on the current CPU when the
> > current CPU is housekeeping CPU.
> > 
> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > ---
> >  block/blk-mq.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 1adfe4824ef5..ff9a4bf16858 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/sched/sysctl.h>
> >  #include <linux/sched/topology.h>
> >  #include <linux/sched/signal.h>
> > +#include <linux/sched/isolation.h>
> >  #include <linux/delay.h>
> >  #include <linux/crash_dump.h>
> >  #include <linux/prefetch.h>
> > @@ -2036,6 +2037,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
> >  static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
> >  					unsigned long msecs)
> >  {
> > +	int work_cpu;
> > +
> >  	if (unlikely(blk_mq_hctx_stopped(hctx)))
> >  		return;
> >  
> > @@ -2050,7 +2053,17 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
> >  		put_cpu();
> >  	}
> >  
> > -	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
> > +	/*
> > +	 * Avoid housekeeping CPUs scheduling a worker on a non-housekeeping
> > +	 * CPU
> > +	 */
> > +	if (tick_nohz_full_enabled() && housekeeping_cpu(smp_processor_id(),
> > +							 HK_FLAG_WQ))
> > +		work_cpu = smp_processor_id();
> > +	else
> > +		work_cpu = blk_mq_hctx_next_cpu(hctx);
> > +
> > +	kblockd_mod_delayed_work_on(work_cpu, &hctx->run_work,
> >  				    msecs_to_jiffies(msecs));
> >  }
> >  
> > 
> 

-- 
Ming

