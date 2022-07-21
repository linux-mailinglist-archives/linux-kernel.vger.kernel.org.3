Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6AD57D315
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiGUSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiGUSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FEAA3D5B8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658427261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoluNnyynHGUmuV72joXwEw3SFlNDiyppF7kCvhsj94=;
        b=QWXcS1KxHMb0NJ4S9N42MS3GDjxGfQrrtMymj6aBUopMoXVD+cyCjMvUjPlHlZeWxSBRx6
        VlNknmRw1jcqmUoFTScaTbKEPBS5UK5t8GtXn3Ok66r2xnmv8IFIOxpd9tm/Mp7ewklLGz
        kdu72L4TpG/pyLPuwl1VjVjVEixjNkM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-Ywsb4lX9PRmK15R9SRyI7A-1; Thu, 21 Jul 2022 14:14:17 -0400
X-MC-Unique: Ywsb4lX9PRmK15R9SRyI7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2502C80A0B9;
        Thu, 21 Jul 2022 18:14:17 +0000 (UTC)
Received: from [10.22.33.96] (unknown [10.22.33.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFB2C2166B26;
        Thu, 21 Jul 2022 18:14:16 +0000 (UTC)
Message-ID: <4953388d-bce4-37cd-f2b9-28dc3627c17d@redhat.com>
Date:   Thu, 21 Jul 2022 14:14:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC] rtmutex: Fix BUG_ON at kernel/locking/rtmutex.c:1331!
Content-Language: en-US
To:     "yuxin.ye" <yeyuxin0925@gmail.com>, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20220720072806.43445-1-yeyuxin0925@gmail.com>
 <62de0805-a6ec-f2a1-00f2-1b24a95c72f0@redhat.com>
 <20220721071656.GA8109@ubuntu>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220721071656.GA8109@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/21/22 03:17, yuxin.ye wrote:
> On Wed, Jul 20, 2022 at 10:25:17PM -0400, Waiman Long wrote:
>> On 7/20/22 03:28, yuxin.ye wrote:
>>> before rt_mutex_adjust_prio_chain(),unlock lock->wait_lock will cause
>>> BUG_ON at kernel/locking/rtmutex.c:1331:
>> The current upstream kernel/locking/rtmutex.c has no BUG_ON() call. Which
>> version of the kernel are you using?
>>
>> Cheers,
>> Longman
>>
> The Linux version is 5.10.
> The upstream has indeed removed the BUG_ON, But in rt_mutex_adjust_prio_chain()
> it is still possible to have a thread is blocked by two locks. Can this situation
> be ignored without BUG_ON?

No. However, we don't remove the lock like what you do with your patch. 
It will corrupt the data if multiple CPUs are allowed to run 
rt_mutex_adjust_prio_chain() for the same rt_mutex simultaneously. You 
need to find a way to fix the underlying problem.

BTW, I still can't see a BUG_ON at line 1331 of rtmutex.c with a v5.10 
kernel. Does your source tree have some out-of-tree patches that 
modifies rtmutex?

Cheers,
Longman

