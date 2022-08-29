Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB015A542F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiH2SrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiH2SrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649785A98
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661798831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3SRr/ruP6S24ttwv/V3z+xdM2OxhFCLUfvkhaDf3xjo=;
        b=DdDMvj7hM4JdBK1k9U2V1D3DcrOCCcrSDp/xnGP6C9a84pMv0RhsH2I5P2a5c7KZB+oDar
        sTVEkkAyD78P4gbf3j1SJ+2b8X7M4vtlkiFmtdviWENNcZTiHJ9mwoh7g2Y8iCcLgd8UTR
        gV9eS2RvMv1WeoJtCsFrNSklMbAAapU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-V5V5MiYtPn6SchxYTIkH3Q-1; Mon, 29 Aug 2022 14:47:05 -0400
X-MC-Unique: V5V5MiYtPn6SchxYTIkH3Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7FF838005CB;
        Mon, 29 Aug 2022 18:47:04 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F0F1401473;
        Mon, 29 Aug 2022 18:47:04 +0000 (UTC)
Message-ID: <05c68678-5bb3-a7fd-863d-d3e0cf11e914@redhat.com>
Date:   Mon, 29 Aug 2022 14:47:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] mm/slab_common: Deleting kobject in
 kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220812183033.346425-1-longman@redhat.com>
 <093f6a32-40f8-78ea-0070-600cfe08a3dd@suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <093f6a32-40f8-78ea-0070-600cfe08a3dd@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 07:33, Vlastimil Babka wrote:
> On 8/12/22 20:30, Waiman Long wrote:
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
> Thanks, added to slab.git for-6.0/fixes

Thanks for taking it.

Cheers,
Longman

