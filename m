Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1217B576578
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiGOQyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGOQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35FFF7A519
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657904072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f68FcbXZ0g9TjJ9n4Wp7AGTeKBQTeaGnrFF7gAH+ZUo=;
        b=UN1kTJQImmTv/VZcq+GPKa16LLV5vtSDYEtvmhFyo23pC2XhYu/wca/Indbe7Tu0fLOOLd
        UqslLEbvB82xrvcqsy2Lzy5MUasefeRf+QBoYI6xyZQH6T4ptp6S1tTEINxgU/cnjU/urL
        uNWnjH8FbxOAzECgyFLp1YakwNkD/KM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-gbneN4JdPU6RSbPPbDMYbQ-1; Fri, 15 Jul 2022 12:54:31 -0400
X-MC-Unique: gbneN4JdPU6RSbPPbDMYbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B25F9811E7A;
        Fri, 15 Jul 2022 16:54:30 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.193.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63409C28118;
        Fri, 15 Jul 2022 16:54:25 +0000 (UTC)
Date:   Fri, 15 Jul 2022 12:54:21 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        bristot@redhat.com, vschneid@redhat.com, cmetcalf@ezchip.com,
        mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        mtosatti@redhat.com
Subject: Re: [PATCH] nohz/full, sched/rt: Fix missed tick-reenabling bug in
 dequeue_task_rt
Message-ID: <YtGbvaia8oOulMEo@lorien.usersys.redhat.com>
References: <20220628092259.330171-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628092259.330171-1-nsaenzju@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:22:59AM +0200 Nicolas Saenz Julienne wrote:
> dequeue_task_rt() only decrements 'rt_rq->rt_nr_running' after having
> called sched_update_tick_dependency() preventing it from re-enabling the
> tick on systems that no longer have pending SCHED_RT tasks but have
> multiple runnable SCHED_OTHER tasks:
> 
>   dequeue_task_rt()
>     dequeue_rt_entity()
>       dequeue_rt_stack()
>         dequeue_top_rt_rq()
> 	  sub_nr_running()	// decrements rq->nr_running
> 	    sched_update_tick_dependency()
> 	      sched_can_stop_tick()	// checks rq->rt.rt_nr_running,
> 	      ...
>         __dequeue_rt_entity()
>           dec_rt_tasks()	// decrements rq->rt.rt_nr_running
> 	  ...
> 
> Every other scheduler class performs the operation in the opposite
> order, and sched_update_tick_dependency() expects the values to be
> updated as such. So avoid the misbehaviour by inverting the order in
> which the above operations are performed in the RT scheduler.
> 
> Fixes: 76d92ac305f2 ("sched: Migrate sched to use new tick dependency mask model")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

That's been around for a while. This change looks right and makes sense
to me.

Thanks,
Phil

Reviewed-by: Phil Auld <pauld@redhat.com>

-- 

