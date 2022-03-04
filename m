Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B74CDA57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiCDR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCDR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:27:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EFB1B8C95
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:26:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A3FC02114E;
        Fri,  4 Mar 2022 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646414803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhAxvF4MTxlRRR85V256T8Duw15Qw7Ui26o4qjTYYjk=;
        b=Ul/8iEfxv1kuEZzmBpLlQlDjoFqPnY9EjqqTVpr2ZlwdHY9J01h4yow7MdOIf1rPRoolfd
        uoiTNwlFbwT3xsVjXbErWvmcZ+4io5ptjyMYbnhwZJeRebhKpKZcgR9yVTrRVOo3Z9JuUG
        HMUIJPT6/MvNOC0wRMv8Gw1sS5RlEJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646414803;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhAxvF4MTxlRRR85V256T8Duw15Qw7Ui26o4qjTYYjk=;
        b=aW63fyXJfMKEb2/gIKUqGTZCafRcqJnu6rWx/pZ3QkSs3MKMnP1RQc6fbteDBdSdethQCv
        VMBIQjdA3V99QLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 394B613B68;
        Fri,  4 Mar 2022 17:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LftoDNNLImJvaQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 17:26:43 +0000
Message-ID: <c12b430b-2096-466f-e24b-0da82c71b0bf@suse.cz>
Date:   Fri, 4 Mar 2022 18:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhoakP7Kih/YUgiN@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YhoakP7Kih/YUgiN@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/22 13:18, Hyeonggon Yoo wrote:
> On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
>> Hi,
>>
>> this series combines and revives patches from Oliver's last year
>> bachelor thesis (where I was the advisor) that make SLUB's debugfs
>> files alloc_traces and free_traces more useful.
>> The resubmission was blocked on stackdepot changes that are now merged,
>> as explained in patch 2.
>>
>> Patch 1 is a new preparatory cleanup.
>>
>> Patch 2 originally submitted here [1], was merged to mainline but
>> reverted for stackdepot related issues as explained in the patch.
>>
>> Patches 3-5 originally submitted as RFC here [2]. In this submission I
>> have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
>> be considered too intrusive so I will postpone it for later. The docs
>> patch is adjusted accordingly.
>>
> 
> This problem is not caused by this patch series.
> But I think it's worth mentioning...
> 
> It's really weird that some stack traces are not recorded
> when CONFIG_KASAN=y.
> 
> I made sure that:
> 	- Stack Depot did not reach its limit
> 	- the free path happen on CONFIG_KASAN=y too.
> 
> I have no clue why this happen.
> 
> # cat dentry/free_traces (CONFIG_KASAN=y)
>    6585 <not-available> age=4294912647 pid=0 cpus=0

I think it's some kind of KASAN quarantining of freed objects, so they
haven't been properly freed through the SLUB layer yet.

> # cat dentry/free_traces (CONFIG_KASAN=n)
>    1246 <not-available> age=4294906877 pid=0 cpus=0
>     379 __d_free+0x20/0x2c age=33/14225/14353 pid=0-122 cpus=0-3
>         kmem_cache_free+0x1f4/0x21c
>         __d_free+0x20/0x2c
>         rcu_core+0x334/0x580
>         rcu_core_si+0x14/0x20
>         __do_softirq+0x12c/0x2a8
> 
>       2 dentry_free+0x58/0xb0 age=14101/14101/14101 pid=158 cpus=0
>         kmem_cache_free+0x1f4/0x21c
>         dentry_free+0x58/0xb0
>         __dentry_kill+0x18c/0x1d0
>         dput+0x1c4/0x2fc
>         __fput+0xb0/0x230
>         ____fput+0x14/0x20
>         task_work_run+0x84/0x17c
>         do_notify_resume+0x208/0x1330
>         el0_svc+0x6c/0x80
>         el0t_64_sync_handler+0xa8/0x130
>         el0t_64_sync+0x1a0/0x1a4
> 
>       1 dentry_free+0x58/0xb0 age=7678 pid=190 cpus=1
>         kmem_cache_free+0x1f4/0x21c
>         dentry_free+0x58/0xb0
>         __dentry_kill+0x18c/0x1d0
>         dput+0x1c4/0x2fc
>         __fput+0xb0/0x230
>         ____fput+0x14/0x20
>         task_work_run+0x84/0x17c
>         do_exit+0x2dc/0x8e0
>         do_group_exit+0x38/0xa4
>         __wake_up_parent+0x0/0x34
>         invoke_syscall+0x48/0x114
>         el0_svc_common.constprop.0+0x44/0xfc
>         do_el0_svc+0x2c/0x94
>         el0_svc+0x28/0x80
>         el0t_64_sync_handler+0xa8/0x130
>         el0t_64_sync+0x1a0/0x1a4

