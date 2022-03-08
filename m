Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42BE4D1CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348012AbiCHQGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbiCHQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:05:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370AE4FC5F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:05:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A441B1F380;
        Tue,  8 Mar 2022 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646755500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFXVe88c1y/NL2/upYftgWSKkejjurmLEVpRnE2EA/Y=;
        b=iI3lDH21RP0cKXGVnGPKUzmdG7NTt0kRACKOMEZL2kTUMlChz3rZ/J4bZreY7DtNPP0PgC
        KhnRnS7eRAH19aCMd0HINZm5+w0AqDiv2kkHF8yUmzANU7pza0gz092RVDyg00t7ZL/mPK
        Hu41KZBCV8SHYzeTjb0UF3Yijzfa0pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646755500;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFXVe88c1y/NL2/upYftgWSKkejjurmLEVpRnE2EA/Y=;
        b=XwizUuTzRGXwU7cSsun7gDcguu+KX475OmeMHBlEtERedLd1nYjgKma3V28BUw33vPN6K5
        ZwRh1s6msbgEUxBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85F9D13CCE;
        Tue,  8 Mar 2022 16:05:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fcA4IKx+J2IKaAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 08 Mar 2022 16:05:00 +0000
Message-ID: <aab854b3-d9fd-3454-c06b-01ff441dec08@suse.cz>
Date:   Tue, 8 Mar 2022 17:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        wangjianxing <wangjianxing@loongson.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
 <20220302153433.719caef31bd9e99319c5e6a2@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220302153433.719caef31bd9e99319c5e6a2@linux-foundation.org>
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

On 3/3/22 00:34, Andrew Morton wrote:
> On Tue,  1 Mar 2022 20:38:25 -0500 wangjianxing <wangjianxing@loongson.cn> wrote:
> 
>> free a large list of pages maybe cause rcu_sched starved on
>> non-preemptible kernels
>>
>> rcu: rcu_sched kthread starved for 5359 jiffies! g454793 f0x0
>> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=19
>> [...]
>> Call Trace:
>>   free_unref_page_list+0x19c/0x270
>>   release_pages+0x3cc/0x498
>>   tlb_flush_mmu_free+0x44/0x70
>>   zap_pte_range+0x450/0x738
>>   unmap_page_range+0x108/0x240
>>   unmap_vmas+0x74/0xf0
>>   unmap_region+0xb0/0x120
>>   do_munmap+0x264/0x438
>>   vm_munmap+0x58/0xa0
>>   sys_munmap+0x10/0x20
>>   syscall_common+0x24/0x38
> 
> Thanks.
> 
> How did this large list of pages come about?

Looks like it came from TLB batching. But I got lost in the maze of it
trying to figure out how large the batch can grow.

> Will people be seeing this message in upstream kernels, or is it
> specific to some caller code which you have added?
> 
> Please always include details such as this so that others can determine
> whether the fix should be backported into -stable kernels.
> 
> 

