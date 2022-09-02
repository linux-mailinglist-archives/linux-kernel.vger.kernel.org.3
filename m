Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2682D5AB9AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIBU4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIBU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634BB4456E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662152158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzsHZ9MjnMZzdfiMHihwjai0c/sGHU3kdcnYVuqUnh0=;
        b=O+OpSKpfOH+wiNUemWL0l86QcafhzSNMsDq5qNww24J/Bu3RNaGRDBoDY6rqYO6L/jKgoy
        5RLtzZWmbpE83EvOdKtB0FUoFXLikiuYnQQvIUwXr6ItsnZUyjMHpugtfRECbF8eamcls5
        teELEG5TCObJnf9kk3cSYrrYPnHy5nQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-AZGk1fJ-OX2-UwDFUhpjrw-1; Fri, 02 Sep 2022 16:55:53 -0400
X-MC-Unique: AZGk1fJ-OX2-UwDFUhpjrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0788C85A589;
        Fri,  2 Sep 2022 20:55:53 +0000 (UTC)
Received: from [10.22.10.219] (unknown [10.22.10.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B65FF112131E;
        Fri,  2 Sep 2022 20:55:52 +0000 (UTC)
Message-ID: <8c33f989-8870-08c6-db12-521de634b34e@redhat.com>
Date:   Fri, 2 Sep 2022 16:55:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Disable preemption while trying for rwsem
 lock
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
References: <1662028090-26495-1-git-send-email-quic_mojha@quicinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <1662028090-26495-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/22 06:28, Mukesh Ojha wrote:
> From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>
> Make the region inside the rwsem_write_trylock non preemptible.
>
> We observe RT task is hogging CPU when trying to acquire rwsem lock
> which was acquired by a kworker task but before the rwsem owner was set.
>
> Here is the scenario:
> 1. CFS task (affined to a particular CPU) takes rwsem lock.
>
> 2. CFS task gets preempted by a RT task before setting owner.
>
> 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> RT throttling happens for the lock as the lock was taken by CFS task.

Note that the spinning is likely caused by the following code in 
rwsem_down_write_slowpath():

1163                 /*
1164                  * After setting the handoff bit and failing to acquire
1165                  * the lock, attempt to spin on owner to accelerate 
lock
1166                  * transfer. If the previous owner is a on-cpu 
writer and it
1167                  * has just released the lock, OWNER_NULL will be 
returned.
1168                  * In this case, we attempt to acquire the lock again
1169                  * without sleeping.
1170                  */
1171                 if (waiter.handoff_set) {
1172                         enum owner_state owner_state;
1173
1174                         preempt_disable();
1175                         owner_state = rwsem_spin_on_owner(sem);
1176                         preempt_enable();
1177
1178                         if (owner_state == OWNER_NULL)
1179                                 goto trylock_again;
1180                 }

rwsem_optimistic_spin() limits RT task one additional attempt if 
OWNER_NULL is returned. There is no such limitation in this loop. So an 
alternative will be to put a limit on the number of times an OWNER_NULL 
return values will be allowed to continue spinning without sleeping. 
That put the burden on the slowpath instead of in the fastpath.

Other than the slight overhead in the fastpath, the patch should work too.

Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman

