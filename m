Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9B58320D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiG0Sby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiG0Sb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C6619581
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658942985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEIQ19tql/jpfio1zfIhkIdZRcHX2TtLFigEENlwyz4=;
        b=U/I9XcHoqcgBYe5FPJ59Y2+WylQr9IqgBBlDTEU01nXlLO/O0tHzW2tCIsYRHlfbmoHMA3
        DZUGrADIR7At0+wHIYhGLHc9uT56cGvcwk6XCQZawT/Ta6yWd3qEr2WAV3a4pOomujcPJM
        jupW7+v4YFSOTDSuxHmKNq498eyLjLY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-Hmr_WctMOa-NeBuuGVhVKA-1; Wed, 27 Jul 2022 13:29:43 -0400
X-MC-Unique: Hmr_WctMOa-NeBuuGVhVKA-1
Received: by mail-wm1-f70.google.com with SMTP id ay19-20020a05600c1e1300b003a315c2c1c0so1191182wmb.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fEIQ19tql/jpfio1zfIhkIdZRcHX2TtLFigEENlwyz4=;
        b=oTORclElWcd8abpyEcSz0228RUKO+SzMQOqY9yB2bK3RByWfChwkOwVidG7eqSSRQr
         m4nJklsAzXSOmV4SyOOIH3eR7fH+Erz+qYZAMHUZQfD6HhKz6szn+0bF7Q40cB68ZIkH
         sDsF1RRDzqja2zmiKk3eVZuj8VznpC7hIMdbxxUr+s7GM68ZotYcOYO62zf+5JklNEnI
         uzPq4ggVfAtmDFIDvxUP6iAqIZQeWFAyybPD/KolXZz+DqCu1HltKHNL6NTiduKctJqn
         bHoRbLkO+bBy9i6vOj9aqRXG5Xi5059h7p9R6W09vpDXppXej/usJGcqh7Zer854MjTj
         6Ruw==
X-Gm-Message-State: AJIora9GVE5OlXMoz/Wmbpy8u7iybwAcbHnxoEJFFnc3HRg/Wph0d6ls
        v8V8bKdQ7BePAoUvB2QxiqvhIQzBXeE/ATJCPMEiV6YVdKtcy2RjqX2X19JX0vumpyRPs9da3+J
        +fiDikFbggzE9TTfT5KGfU7wO
X-Received: by 2002:a5d:4b81:0:b0:21e:e3c8:7055 with SMTP id b1-20020a5d4b81000000b0021ee3c87055mr1548060wrt.519.1658942981994;
        Wed, 27 Jul 2022 10:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u5hDE/h2o9jh/qDvlEby7XGmrwuGF7oyOoDEodiimeOGJhTSLMZ6f9RZk732dM12pzMnP8MQ==
X-Received: by 2002:a5d:4b81:0:b0:21e:e3c8:7055 with SMTP id b1-20020a5d4b81000000b0021ee3c87055mr1548040wrt.519.1658942981643;
        Wed, 27 Jul 2022 10:29:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:7b00:d3e8:c80b:4abc:d55c? (p200300cbc7137b00d3e8c80b4abcd55c.dip0.t-ipconnect.de. [2003:cb:c713:7b00:d3e8:c80b:4abc:d55c])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b0021e6277bc50sm17578329wrw.36.2022.07.27.10.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:29:41 -0700 (PDT)
Message-ID: <6168cf49-bf75-2ebb-ab55-30de473835e3@redhat.com>
Date:   Wed, 27 Jul 2022 19:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, hocko@suse.com,
        quic_pkondeti@quicinc.com, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org,
        liuting.0x7c00@bytedance.com, minchan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.22 16:15, Charan Teja Kalla wrote:
> The below is one path where race between page_ext and  offline of the
> respective memory blocks will cause use-after-free on the access of
> page_ext structure.
> 
> process1		              process2
> ---------                             ---------
> a)doing /proc/page_owner           doing memory offline
> 			           through offline_pages.
> 
> b)PageBuddy check is failed
> thus proceed to get the
> page_owner information
> through page_ext access.
> page_ext = lookup_page_ext(page);
> 
> 				    migrate_pages();
> 				    .................
> 				Since all pages are successfully
> 				migrated as part of the offline
> 				operation,send MEM_OFFLINE notification
> 				where for page_ext it calls:
> 				offline_page_ext()-->
> 				__free_page_ext()-->
> 				   free_page_ext()-->
> 				     vfree(ms->page_ext)
> 			           mem_section->page_ext = NULL
> 
> c) Check for the PAGE_EXT flags
> in the page_ext->flags access
> results into the use-after-free(leading
> to the translation faults).
> 
> As mentioned above, there is really no synchronization between page_ext
> access and its freeing in the memory_offline.
> 
> The memory offline steps(roughly) on a memory block is as below:
> 1) Isolate all the pages
> 2) while(1)
>   try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
> 3) delete the pages from this buddy list.
> 4) Then free page_ext.(Note: The struct page is still alive as it is
> freed only during hot remove of the memory which frees the memmap, which
> steps the user might not perform).
> 
> This design leads to the state where struct page is alive but the struct
> page_ext is freed, where the later is ideally part of the former which
> just representing the page_flags.
> 
> The above mentioned race is just one example __but the problem persists
> in the other paths too involving page_ext->flags access(eg:
> page_is_idle())__. Since offline waits till the last reference on the
> page goes down i.e. any path that took the refcount on the page can make
> the memory offline operation to wait. Eg: In the migrate_pages()
> operation, we do take the extra refcount on the pages that are under
> migration and then we do copy page_owner by accessing page_ext. For
> 
> Fix those paths where offline races with page_ext access by maintaining
> synchronization with rcu lock and is achieved in 3 steps:
> 1) Invalidate all the page_ext's of the sections of a memory block by
> storing a flag in the LSB of mem_section->page_ext.
> 
> 2) Wait till all the existing readers to finish working with the
> ->page_ext's with synchronize_rcu(). Any parallel process that starts
> after this call will not get page_ext, through lookup_page_ext(), for
> the block parallel offline operation is being performed.
> 
> 3) Now safely free all sections ->page_ext's of the block on which
> offline operation is being performed.
> 
> Thanks to David Hildenbrand for his views/suggestions on the initial
> discussion[1] and Pavan kondeti for various inputs on this patch.
> 
> FAQ's:
> Q) Should page_ext_[get|put]() needs to be used for every page_ext
> access?
> A) NO, the synchronization is really not needed in all the paths of
> accessing page_ext. One case is where extra refcount is taken on a
> page for which memory block, this pages falls into, offline operation is
> being performed. This extra refcount makes the offline operation not to
> succeed hence the freeing of page_ext.  Another case is where the page
> is already being freed and we do reset its page_owner.
> 
> Some examples where the rcu_lock is not taken while accessing the
> page_ext are:
> 1) In migration (where we also migrate the page_owner information), we
> take the extra refcount on the source and destination pages and then
> start the migration. This extra refcount makes the test_pages_isolated()
> function to fail thus retry the offline operation.
> 
> 2) In free_pages_prepare(), we do reset the page_owner(through page_ext)
> which again doesn't need the protection to access because the page is
> already freeing (through only one path).
> 
> So, users need not to use page_ext_[get|put]() when they are sure that
> extra refcount is taken on a page preventing the offline operation.
> 
> Q) Why can't the page_ext is freed in the hot_remove path, where memmap
> is also freed ?
> 
> A) As per David's answers, there are many reasons and a few are:
> 1) Discussions had happened in the past to eventually also use rcu
> protection for handling pfn_to_online_page(). So doing it cleanly here
> is certainly an improvement.
> 
> 2) It's not good having to scatter section online checks all over the
> place in page ext code. Once there is a difference between active vs.
> stale page ext data things get a bit messy and error prone. This is
> already ugly enough in our generic memmap handling code.
> 
> 3) Having on-demand allocations, such as KASAN or page ext from the
> memory online notifier is at least currently cleaner, because we don't
> have to handle each and every subsystem that hooks into that during the
> core memory hotadd/remove phase, which primarily only setups the
> vmemmap, direct map and memory block devices.
> 
> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
> 

I guess if we care about the synchronize_rcu() we could go crazy with
temporary allocations for data-to-free + call_rcu().

-- 
Thanks,

David / dhildenb

