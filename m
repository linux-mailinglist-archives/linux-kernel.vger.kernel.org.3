Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83C589B23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiHDLk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiHDLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39944BCAB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659613225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbYCfDx16AQ9sgwijlUuh401ek0hMQBtuoovmaTnARM=;
        b=Qruzck462GaWq4hoF2Qvr24WsJxwPbqrTKM1cO5PEYx8HpyIGYxYGJq9D5B9FPK4PvN1Qb
        FKuMrrtBOmE2BIXpqn1GoPtJ5m31534lQqp8F+ZlwJ8ixfj/GB4nYz5o90b5pg7nxPUCO7
        EB3ekpu46mBTGwMs8yloEDh+Ki9LpiI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-N_Y8QoZEMZyD46BRsMmVAw-1; Thu, 04 Aug 2022 07:40:24 -0400
X-MC-Unique: N_Y8QoZEMZyD46BRsMmVAw-1
Received: by mail-wr1-f70.google.com with SMTP id n7-20020adfc607000000b0021a37d8f93aso4778101wrg.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=jbYCfDx16AQ9sgwijlUuh401ek0hMQBtuoovmaTnARM=;
        b=rRmIv0xn+muazEcOyyHY2l2AWzIsD0FWKpso6rtSBKtIemafAnZggY72DrmbMhqTzF
         qH2qOM652ROHpY7Nz3PCvW6s+b0H9CHl5kpMG4oY0W7Qq79tlF6DoErY+5pNbDBixj1t
         6wbnbdchXS8+lICqJyT5Y0HPz010GloUzFZqptj87LB0Bu8XJurDFmU+0AhK6cHx8P47
         TZsBf0dbTs/dQ8RjnohY/DBDZwNZOHmWTn0n/1QfIa2lWNG6d5W2Vjoz0n+Hx7RIgti/
         fqwi2A6zhyaUcbWdXOUgXXL7o+9APVg7kiIngcou8blsVWt6vs0FKsmVdjbAl3OnDzfW
         DXOA==
X-Gm-Message-State: ACgBeo2ydZDNT5epvO1MtZSAuBrdKtz03PaEth9BcpeevdN4wFYq4Mgs
        FjpexK0krzfDrjCCqSqFwPs9yNeN1nSfNU0r1gQhARxN8juQBntu+y0EF0miSxh2MdXwcwngENH
        0HL9zLUqF/evJJU1EFe+jt8E3
X-Received: by 2002:a05:600c:4f0e:b0:3a3:44ee:d40b with SMTP id l14-20020a05600c4f0e00b003a344eed40bmr5939828wmq.199.1659613223103;
        Thu, 04 Aug 2022 04:40:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6DBVbgziTGZUxaJ0PMfDj+tkyA5Gr3bEeI67TCLzd1/KVqox527H7OT2KmdBFOk1iAcKjHGA==
X-Received: by 2002:a05:600c:4f0e:b0:3a3:44ee:d40b with SMTP id l14-20020a05600c4f0e00b003a344eed40bmr5939818wmq.199.1659613222877;
        Thu, 04 Aug 2022 04:40:22 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id u11-20020adfeb4b000000b0021f15514e7fsm1128588wrn.0.2022.08.04.04.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 04:40:22 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v3 1/3] workqueue: Hold wq_pool_mutex while affining
 tasks to wq_unbound_cpumask
In-Reply-To: <c13c3fb4-4936-a5fd-cd28-1136d07d5f54@gmail.com>
References: <20220802084146.3922640-1-vschneid@redhat.com>
 <20220802084146.3922640-2-vschneid@redhat.com>
 <c13c3fb4-4936-a5fd-cd28-1136d07d5f54@gmail.com>
Date:   Thu, 04 Aug 2022 12:40:21 +0100
Message-ID: <xhsmhh72sck4a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/22 11:40, Lai Jiangshan wrote:
> On 2022/8/2 16:41, Valentin Schneider wrote:
>> When unbind_workers() reads wq_unbound_cpumask to set the affinity of
>> freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
>> sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.
>>
>> This is made more obvious as of recent commit
>>
>>    46a4d679ef88 ("workqueue: Avoid a false warning in unbind_workers()")
>>
>> e.g.
>>
>> unbind_workers()                             workqueue_set_unbound_cpumask()
>>    kthread_set_per_cpu(p, -1);
>>    if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
>>                                             cpumask_copy(wq_unbound_cpumask, cpumask);
>>      WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
>>
>> Make workqueue_offline_cpu() invoke unbind_workers() with wq_pool_mutex
>> held.
>
> I would prefer to protect wq_unbound_cpumask with wq_pool_attach_mutex.

That looks alright to me, do you want to push that separately as it's a
standalone patch, or should I carry it with this series?

