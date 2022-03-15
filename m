Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3AE4D9F02
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbiCOPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiCOPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8494013D6D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647359117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYl1LSBqhgpJOo7T6+g24bgPe/Xpp9f9wR/UlrFgmkY=;
        b=bEimwjB7kvETAn4XMfFwiJe0hZNoakIphJPVkHcRW+9p6sUdJncxyQff4sa0HOi1T4nrH2
        ub9OJ/UdwYfYqFd/fGhZaHFoqg5i0GOM3+lMZ05Ls5/UrQM10rc5bqJQR/qBgCAVv/M0g9
        DeQKoAqTaRzFZFVSFjY+OR+PDUA31yY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-d44pE-LWNOGMALu-vjHiuQ-1; Tue, 15 Mar 2022 11:45:16 -0400
X-MC-Unique: d44pE-LWNOGMALu-vjHiuQ-1
Received: by mail-wr1-f69.google.com with SMTP id t8-20020adfa2c8000000b001e8f6889404so5418362wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=bYl1LSBqhgpJOo7T6+g24bgPe/Xpp9f9wR/UlrFgmkY=;
        b=EZrkTxOpkHuxNNSdjSOhN9S1GHvlHqEWOB3BcQcwK337V/SCSfRX0tzfRAa1z/CVuN
         95HCXvRamXx5djwYCumwNP3KcPxv5BxmGkSpASdWKfytBbW0wScEY+eZ4eswmoH/1C6T
         88Au3AWooY0hMvLe99hiVegNPVn+qjxN9xujOcJyFt3HiRN4+pPrVPxwDZv9o50VobOa
         LfKRZFDP/Ey0JSRGyEHMVskFDXvhIFaL6iLQaRDR5wEbPUbP68SOlnn/sTyx+z8lYnQv
         jH+CIK7lscZlwPLhxx8KRbQ5RpAwDa47sRXKwseWu5tbcTRJC7kBGQ7HJPDBslyGQPns
         DQvw==
X-Gm-Message-State: AOAM5317FNuxq4WpKzbTnELlW6hcIaHfU+UeLqQRUyGKMDqJD0SBS/Pa
        xr+PUo0gR8zaSjPEin0M8ROO2JCk9YCc3fAtBH5Vuxu+WCoi7UuKFvBoPtqZPBY0xb+ZonQ2eMO
        UNhmofXaJG0ZZ/z3Z0+dURPf4
X-Received: by 2002:a5d:5887:0:b0:1f1:eb44:724e with SMTP id n7-20020a5d5887000000b001f1eb44724emr21315063wrf.44.1647359114942;
        Tue, 15 Mar 2022 08:45:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPoEJ1GBznl0gSlJSA8PP9PMIE7udTKKIyZAmfT4CMnFBi93qUV9w8thhZ2jRKEb3NPxfnVA==
X-Received: by 2002:a5d:5887:0:b0:1f1:eb44:724e with SMTP id n7-20020a5d5887000000b001f1eb44724emr21315036wrf.44.1647359114709;
        Tue, 15 Mar 2022 08:45:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1800:42bd:3cac:d22a:3c62? (p200300cbc708180042bd3cacd22a3c62.dip0.t-ipconnect.de. [2003:cb:c708:1800:42bd:3cac:d22a:3c62])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c2b04000000b0038a0e15ee13sm2637525wmr.8.2022.03.15.08.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 08:45:14 -0700 (PDT)
Message-ID: <4cb789a5-c49c-f095-1f7e-67be65ba508a@redhat.com>
Date:   Tue, 15 Mar 2022 16:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/migrate: fix race between lock page and clear
 PG_Isolated
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrew Yang <andrew.yang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Yang Shi <shy828301@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
References: <20220315030515.20263-1-andrew.yang@mediatek.com>
 <20220314212127.a2797926ee0ef8a7ad05dcaa@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220314212127.a2797926ee0ef8a7ad05dcaa@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.22 05:21, Andrew Morton wrote:
> On Tue, 15 Mar 2022 11:05:15 +0800 Andrew Yang <andrew.yang@mediatek.com> wrote:
> 
>> When memory is tight, system may start to compact memory for large
>> continuous memory demands. If one process tries to lock a memory page
>> that is being locked and isolated for compaction, it may wait a long time
>> or even forever. This is because compaction will perform non-atomic
>> PG_Isolated clear while holding page lock, this may overwrite PG_waiters
>> set by the process that can't obtain the page lock and add itself to the
>> waiting queue to wait for the lock to be unlocked.
>>
>> CPU1                            CPU2
>> lock_page(page); (successful)
>>                                 lock_page(); (failed)
>> __ClearPageIsolated(page);      SetPageWaiters(page) (may be overwritten)
>> unlock_page(page);
>>
>> The solution is to not perform non-atomic operation on page flags while
>> holding page lock.
> 
> Sure, the non-atomic bitop optimization is really risky and I suspect
> we reach for it too often.  Or at least without really clearly
> demonstrating that it is safe, and documenting our assumptions.

I agree. IIRC, non-atomic variants are mostly only safe while the
refcount is 0. Everything else is just absolutely fragile.

-- 
Thanks,

David / dhildenb

