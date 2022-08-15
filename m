Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7E593067
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbiHOOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiHOOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E36222BCE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660572134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXDAAl+x9MWatG+p/VTcB+8mkDyPasS5scLcX2zyIyQ=;
        b=TvzVGGxy6wBroF3HDpgZMez/tbQQQZTYsEag4ryuBK25x3MLKX7AlAoHWZZWvDap1ezigE
        ZRBuMRqG+2fwVxzBQWR99AX+1EbZKHSO+Qn0H5IZI5bitw2aN+dAAD2HNA64zjdmA7wIOE
        1rL9w2mJZEiHB4qXRUWqWJVYPKC1/Zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-uMEmCIL0Nzqvc952K71zXw-1; Mon, 15 Aug 2022 10:02:11 -0400
X-MC-Unique: uMEmCIL0Nzqvc952K71zXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 663A880600D;
        Mon, 15 Aug 2022 14:01:51 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14A94140EBE3;
        Mon, 15 Aug 2022 14:01:51 +0000 (UTC)
Message-ID: <ccdc5718-a66c-da5a-4b0b-360f9d18f13f@redhat.com>
Date:   Mon, 15 Aug 2022 10:01:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] mm/slab_common: Deleting kobject in
 kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220812183033.346425-1-longman@redhat.com>
 <YvfsmNxDYp9Pz/+P@P9FQF9L96D.corp.robot.car>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvfsmNxDYp9Pz/+P@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/22 14:25, Roman Gushchin wrote:
> On Fri, Aug 12, 2022 at 02:30:33PM -0400, Waiman Long wrote:
>> A circular locking problem is reported by lockdep due to the following
>> circular locking dependency.
>>
>>    +--> cpu_hotplug_lock --> slab_mutex --> kn->active --+
>>    |                                                     |
>>    +-----------------------------------------------------+
>>
>> The forward cpu_hotplug_lock ==> slab_mutex ==> kn->active dependency
>> happens in
>>
>>    kmem_cache_destroy():	cpus_read_lock(); mutex_lock(&slab_mutex);
>>    ==> sysfs_slab_unlink()
>>        ==> kobject_del()
>>            ==> kernfs_remove()
>> 	      ==> __kernfs_remove()
>> 	          ==> kernfs_drain(): rwsem_acquire(&kn->dep_map, ...);
>>
>> The backward kn->active ==> cpu_hotplug_lock dependency happens in
>>
>>    kernfs_fop_write_iter(): kernfs_get_active();
>>    ==> slab_attr_store()
>>        ==> cpu_partial_store()
>>            ==> flush_all(): cpus_read_lock()
>>
>> One way to break this circular locking chain is to avoid holding
>> cpu_hotplug_lock and slab_mutex while deleting the kobject in
>> sysfs_slab_unlink() which should be equivalent to doing a write_lock
>> and write_unlock pair of the kn->active virtual lock.
>>
>> Since the kobject structures are not protected by slab_mutex or the
>> cpu_hotplug_lock, we can certainly release those locks before doing
>> the delete operation.
>>
>> Move sysfs_slab_unlink() and sysfs_slab_release() to the newly
>> created kmem_cache_release() and call it outside the slab_mutex &
>> cpu_hotplug_lock critical sections. There will be a slight delay
>> in the deletion of sysfs files if kmem_cache_release() is called
>> indirectly from a work function.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> Thank you, Waiman!
>
Thanks for your suggestions that make this patch better.

Cheers,
Longman

