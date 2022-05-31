Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33FC539310
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbiEaOVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbiEaOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 829BA70367
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654006878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=054tb8AogR5kqRpkgYxu+jA4/lLcTMkATpeGkVLSWIc=;
        b=Hl4m0BMnQzMusX6/hU2CKokGaBnOO97r8YUlBT0ACktb0zhErNfolKMk0hXddDLb3OLTOJ
        HMOxuk42dlwj9IeIxhQUqyuzUmiVVMfRZ8AUag4IlT45pr92Z3DwJIeGTKotaWcSqwMM8n
        asY7NJvHMXG8OG4qkQ5cfOWqRMmlDmE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-EylW6zkhOaC9wANYEmdqPg-1; Tue, 31 May 2022 10:21:12 -0400
X-MC-Unique: EylW6zkhOaC9wANYEmdqPg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAE191C16B49;
        Tue, 31 May 2022 14:21:04 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09D20492CA2;
        Tue, 31 May 2022 14:21:04 +0000 (UTC)
Message-ID: <6936d198-7ae4-e022-20d5-e60c17f119e8@redhat.com>
Date:   Tue, 31 May 2022 10:21:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
References: <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen> <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
 <20220530004049.GA1251147@lothringen>
 <YpR8PUlIraYE2+5L@worktop.programming.kicks-ass.net>
 <20220530105650.GA1257179@lothringen>
 <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 09:16, Peter Zijlstra wrote:
> On Mon, May 30, 2022 at 12:56:50PM +0200, Frederic Weisbecker wrote:
>
>>> This is ABI, you can't walk back on it. I would suggest starting with an
>>> 'all feature' isolation. Only if there's real demand for something more
>>> fine-grained add that on top. Simple first etc.
>> That's actually my worry. If we start with an all in one ABI, how do we later
>> mix that up with more finegrained features? Like what will be the behaviour of:
>>
>> cpuset.isolation.rcu_nocb = 0
>> cpuset.isolation.all = 1
> Well clearly that doesn't make sense. I was more thinking along the
> lines of cgroup.subtree_control, where instead all features are enabled
> by default.
>
> But only if there's a real usecase, otherwise there's no point in
> providing such knobs.

I am actually thinking about extending the cpuset partition interface 
for isolation. Right now, I have an outstanding patch [1] to add an 
"isolated" state to partition which disable load balancing somewhat 
similar to isolcpus command line option. In the future, we can add 
attribute to the isolation state like "isolated:full" to similar to 
nohz_full currently. If the needs arise, we can even  extend the 
attribute to allow list like "isolated:rcu_nocbs". I don't think it is 
good idea to keep on adding new cpuset control files extensively. I 
would prefer extending the existing ones.

[1] https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/

Cheers,
Longman

