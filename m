Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2156327E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiGALZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiGALZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 872847B34B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656674732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5OmlA/t9RccN7KSRkjLQlSW9pQ8XucLvZm0GyPWgBPo=;
        b=fDw/8ApdxWwGk/KpKDJW5O3er5VSsD8SxjF2g+NaduXzpU07+O6oR+cIUPNerQeTv0VzMd
        RWeGBOmZ1eE5eSS5j7bCVJA+dE+NO4A/QS8qn4iI5AFC3XvEJFaHsUmJ2EzP9phw09Mbmv
        T2cYsjuzbnXTlUGuKpRp3aMFH0l9oCo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-034TTLxxOD2edDV_xLTQGQ-1; Fri, 01 Jul 2022 07:25:31 -0400
X-MC-Unique: 034TTLxxOD2edDV_xLTQGQ-1
Received: by mail-wm1-f70.google.com with SMTP id j35-20020a05600c1c2300b003a167dfa0ecso1268567wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 04:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5OmlA/t9RccN7KSRkjLQlSW9pQ8XucLvZm0GyPWgBPo=;
        b=uf91WdYe9Zy73juyyr7821l8+7/UogScb3w5cRSEMqQy/rWdjl1x9TO7w7tMxUVUdS
         qVTuHpH77qAVG1FMKhqXgTRchw7cagv2eDN8Zi5od2dKc1Bm82InlHClCCMKVJ7w84gX
         UzXng19mCma1GRKgSBFXYYP2TBcUb9aEkpi9unfJcbedw8ppzqdcpHJHaDx5wcEFLZ9A
         +KSpCYcu0u3AzFa/0f8eNCr9cclxCsw45qJahjxWsyCSJ4QCYAHjU0xeY1+PJtWTk5TB
         tI0MzN0xpDTUgoZ9cus/PiGyp7cmo0VMlUyZQLqovo8lKEmAblWCjgObFX3HLksuX3S0
         QjiA==
X-Gm-Message-State: AJIora8717vGJsKSsMOLKJ7djZ62216/KfmU1ywwUMSUqzM55jJV3uHf
        QAj+mx4StieaCxF4pLNvqXgHbBTbZyygja3zdHnTHhgDZ5pGyX4LtNRGjotl+vkn7OT6qiejIUp
        MAXCOrFNbwWloD6NzqE7gfKJ3
X-Received: by 2002:a1c:720f:0:b0:3a0:2ac9:5231 with SMTP id n15-20020a1c720f000000b003a02ac95231mr15818998wmc.39.1656674730549;
        Fri, 01 Jul 2022 04:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/lwU2oxUG3naM8CeuP8DCWGu05RJ3M2eBqVXS9RJaaGCh4Va3ISeKKIPp16rjvj7DLxzF0w==
X-Received: by 2002:a1c:720f:0:b0:3a0:2ac9:5231 with SMTP id n15-20020a1c720f000000b003a02ac95231mr15818981wmc.39.1656674730362;
        Fri, 01 Jul 2022 04:25:30 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4b46000000b0021d3fbf1d29sm3862405wrs.97.2022.07.01.04.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 04:25:29 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com
Cc:     bristot@redhat.com, cmetcalf@ezchip.com, mgorman@suse.de,
        bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, mtosatti@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: [PATCH] nohz/full, sched/rt: Fix missed tick-reenabling bug in
 dequeue_task_rt
In-Reply-To: <20220628092259.330171-1-nsaenzju@redhat.com>
References: <20220628092259.330171-1-nsaenzju@redhat.com>
Date:   Fri, 01 Jul 2022 12:25:28 +0100
Message-ID: <xhsmhedz55b2v.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/22 11:22, Nicolas Saenz Julienne wrote:
> dequeue_task_rt() only decrements 'rt_rq->rt_nr_running' after having
> called sched_update_tick_dependency() preventing it from re-enabling the
> tick on systems that no longer have pending SCHED_RT tasks but have
> multiple runnable SCHED_OTHER tasks:
>
>   dequeue_task_rt()
>     dequeue_rt_entity()
>       dequeue_rt_stack()
>         dequeue_top_rt_rq()
>         sub_nr_running()	// decrements rq->nr_running
>           sched_update_tick_dependency()
>             sched_can_stop_tick()	// checks rq->rt.rt_nr_running,
>             ...
>         __dequeue_rt_entity()
>           dec_rt_tasks()	// decrements rq->rt.rt_nr_running
>         ...
>
> Every other scheduler class performs the operation in the opposite
> order, and sched_update_tick_dependency() expects the values to be
> updated as such. So avoid the misbehaviour by inverting the order in
> which the above operations are performed in the RT scheduler.
>

I can't see anything wrong with your approach, though I did have to spend
some time re-learning RT_GROUP_SCHED. The designated Fixes: commit looks
about right too.

> Fixes: 76d92ac305f2 ("sched: Migrate sched to use new tick dependency mask model")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

