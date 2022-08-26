Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3EB5A2251
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbiHZHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbiHZHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27947D3E7A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661500373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0BsyNMBraTf2zRdBdEtcVEbOWZN+F6n2yPd2BDqPgFc=;
        b=LYxs4GeYm9+8utnjFIqj4ejLTpWxIdG4mjxhE1Orp1kHZzYyzqJvWp7uU5jptmL7g+S0m0
        xxaQzOV2YRfH3UwhqhO1CkgCMl4RdE6q3MLNRwb3Z8o92sVMnUnV/IEJyb8wUphCxXzKko
        R7qf+TdkKNWLy1yourVMxJPwKw0PGjg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-rgStA0ErPiGW0UhyN8KFAA-1; Fri, 26 Aug 2022 03:52:50 -0400
X-MC-Unique: rgStA0ErPiGW0UhyN8KFAA-1
Received: by mail-wr1-f72.google.com with SMTP id e14-20020adf9bce000000b002254afda62aso73167wrc.18
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=0BsyNMBraTf2zRdBdEtcVEbOWZN+F6n2yPd2BDqPgFc=;
        b=IwwurRoAKjP4pUkv02m+jWTM6D5Clv7KHOTu18WzMIeflj6qKWQ5pVSJambo2VRbAW
         dNtcDIpyrZrLXnIfaIPOaoZqZcNrrP2AZ89ev0nlPiPT/T2XZEQd+bF0e5MyZaaVnFK9
         ET+N8n/ZpMKCOHu8rG7QoqSN+1mXPJBH9gqvUcuT52PAsrM/86/6QUNNbQp2axL3NHR9
         qrtjVzqNFzU/Tzwpmgr5XPMA2Zqii1Yr0bFnGIHXlb84eSMSJHeupNp8mr/2TA63iflr
         7qCHNEx+f4B66JK+9CVnGmsMOy3oPss/eOJeBt0UarCR4pE8RiQVqb3auiBdbiJdTvOd
         Zv9w==
X-Gm-Message-State: ACgBeo0l5JWoo8aBPtVbIhoy0UMlOert4PH7F9DbKw/YIG9+Iv3S61vp
        JldSeKJ76XKT+G1hicgona+cIqi59KCBPeu23vwqMaqAB5zk6CbaOz7szlzjA3dgdTBBXFNduSf
        qMYXY/GRekqYhDxQ+dM2sp/ZF
X-Received: by 2002:a1c:7315:0:b0:3a5:ff61:4080 with SMTP id d21-20020a1c7315000000b003a5ff614080mr4358187wmb.196.1661500369355;
        Fri, 26 Aug 2022 00:52:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4VAAESIWC7QgaM7o6uZkV22WGTbUbGcDRIewk8Fd5LU+8TzRqdXa3r1xehrlBDRJhIhirevQ==
X-Received: by 2002:a1c:7315:0:b0:3a5:ff61:4080 with SMTP id d21-20020a1c7315000000b003a5ff614080mr4358174wmb.196.1661500369061;
        Fri, 26 Aug 2022 00:52:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f600:abad:360:c840:33fa? (p200300cbc708f600abad0360c84033fa.dip0.t-ipconnect.de. [2003:cb:c708:f600:abad:360:c840:33fa])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c219000b003a5537bb2besm1564624wme.25.2022.08.26.00.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 00:52:48 -0700 (PDT)
Message-ID: <3ba51e8c-52f5-29b6-4727-52f00b0d74d3@redhat.com>
Date:   Fri, 26 Aug 2022 09:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V5] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        pasha.tatashin@soleen.com, shakeelb@google.com, sieberf@amazon.com,
        sjpark@amazon.de, william.kucharski@oracle.com,
        willy@infradead.org, quic_pkondeti@quicinc.com, minchan@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.22 08:56, Charan Teja Kalla wrote:
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
> just representing the page_flags (check [3] for why this design is
> chosen).
> 
> The above mentioned race is just one example __but the problem persists
> in the other paths too involving page_ext->flags access(eg:
> page_is_idle())__.
> 
> Fix all the paths where offline races with page_ext access by
> maintaining synchronization with rcu lock and is achieved in 3 steps:
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
> Note: If synchronize_rcu() takes time then optimizations can be done in
> this path through call_rcu()[2].
> 
> Thanks to David Hildenbrand for his views/suggestions on the initial
> discussion[1] and Pavan kondeti for various inputs on this patch.
> 
> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
> [2] https://lore.kernel.org/all/a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com/T/#u
> [3] https://lore.kernel.org/all/6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!


-- 
Thanks,

David / dhildenb

