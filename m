Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9994E2DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351059AbiCUQZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350273AbiCUQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEB13ECC42
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647879851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e821vFLY1EVDn4KoyJpKz5Am72wN4KzbQq0gwbdYqhA=;
        b=ah2KKNCfJpVy338nDEed8XYc1DVCgwGaiXmz80898hEKjIViG+3fCRxF1XxiztTW/27GDG
        9O0bKL84KnxiY8G3iDSRtACWnio8+OEv7Hu+Xuq33AmENelSrI0lXE2deinAQc19Irww+D
        XMhRsGzdZeqMDQfm/BHR7hNT5VhBkJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-30ZD5cimNIqDxga7Q0mPwg-1; Mon, 21 Mar 2022 12:24:09 -0400
X-MC-Unique: 30ZD5cimNIqDxga7Q0mPwg-1
Received: by mail-wm1-f70.google.com with SMTP id n19-20020a7bcbd3000000b0038c94b86258so2563035wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=e821vFLY1EVDn4KoyJpKz5Am72wN4KzbQq0gwbdYqhA=;
        b=zPMAucFtOSgHyJ9xQMN4EO5TB5MIJgBOu+0JL9ZUw3Zok/L9wLyr4QmcLM+P17kwRA
         8nPjuFKwVBlgIirW1wZl/tG5RpbVVBgzSXL5H4mjaBCSJFnyBEXigHsbVTbYuvJ9+2vx
         iSZBgqm1kJtCImGXEA3rcHyVkBBpoX5wz8vtBp03JVgt/LrAeMJmEqp+D1jr5l8Per91
         8teJqO/QnbN0mEm0oH887CtvhArZ30LfKjnnft9tiOxfGRqmDLp3P3gE8MZW3Z14fL6x
         bMO/8vGDHePH6zAPtsQo67V04a3F0o1lOW2oSHGU7B8q0nrTosCIeht+7PmRYiQsL8fw
         Pklg==
X-Gm-Message-State: AOAM532CjQ/0ue4tFmBi3eOnAt1ZbW9mAOdKvOhy11biwhSoYxi/rvNf
        0us8OhJ/JmWaUeU9DANAypZZlmwD5Pn2d5iU2sK4KoEyvAOn1N3XYGW79bfHrDYmVOrb9tfPZ4A
        bOzG6ZH+//e7YPhFkQoVYRvzI
X-Received: by 2002:a5d:6944:0:b0:203:e024:7cdd with SMTP id r4-20020a5d6944000000b00203e0247cddmr12197771wrw.503.1647879848168;
        Mon, 21 Mar 2022 09:24:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9CE39kD76mAvrAOZrfYAEauMmpFPCc+soZrVq94VaBpoGBRsY6R30BdbSebl0p+LNgjGRBg==
X-Received: by 2002:a5d:6944:0:b0:203:e024:7cdd with SMTP id r4-20020a5d6944000000b00203e0247cddmr12197752wrw.503.1647879847940;
        Mon, 21 Mar 2022 09:24:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id i10-20020a0560001aca00b00203daf3759asm15006242wry.68.2022.03.21.09.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 09:24:07 -0700 (PDT)
Message-ID: <77272de6-2c30-ea2a-c0e3-be89e47cf415@redhat.com>
Date:   Mon, 21 Mar 2022 17:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 13/15] mm: support GUP-triggered unsharing of anonymous
 pages
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-14-david@redhat.com>
 <20220318233035.GA11336@nvidia.com>
 <de543fbc-0051-120b-c91a-74cf4dd6156b@redhat.com>
 <20220321161823.GZ11336@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220321161823.GZ11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.22 17:18, Jason Gunthorpe wrote:
> On Mon, Mar 21, 2022 at 05:15:06PM +0100, David Hildenbrand wrote:
>> On 19.03.22 00:30, Jason Gunthorpe wrote:
>>> On Tue, Mar 15, 2022 at 11:47:39AM +0100, David Hildenbrand wrote:
>>>> Whenever GUP currently ends up taking a R/O pin on an anonymous page that
>>>> might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
>>>> on the page table entry will end up replacing the mapped anonymous page
>>>> due to COW, resulting in the GUP pin no longer being consistent with the
>>>> page actually mapped into the page table.
>>>>
>>>> The possible ways to deal with this situation are:
>>>>  (1) Ignore and pin -- what we do right now.
>>>>  (2) Fail to pin -- which would be rather surprising to callers and
>>>>      could break user space.
>>>>  (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
>>>>      pins.
>>>>
>>>> We want to implement 3) because it provides the clearest semantics and
>>>> allows for checking in unpin_user_pages() and friends for possible BUGs:
>>>> when trying to unpin a page that's no longer exclusive, clearly
>>>> something went very wrong and might result in memory corruptions that
>>>> might be hard to debug. So we better have a nice way to spot such
>>>> issues.
>>>>
>>>> To implement 3), we need a way for GUP to trigger unsharing:
>>>> FAULT_FLAG_UNSHARE. FAULT_FLAG_UNSHARE is only applicable to R/O mapped
>>>> anonymous pages and resembles COW logic during a write fault. However, in
>>>> contrast to a write fault, GUP-triggered unsharing will, for example, still
>>>> maintain the write protection.
>>>
>>> Given the way this series has developed you might want to call this
>>> FAULT_FLAG_MAKE_ANON_EXCLUSIVE
>>>
>>> Which strikes me as more directly connected to what it is trying to
>>> do.
>>
>> I thought about something similar along those lines, and I think it
>> would apply even when extending that mechanism to anything !anon inside
>> a MAP_PRIVATE mapping.
>>
>> The whole
>>
>> const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
> 
> I think the extra words are worthwhile, share makes me think about
> MAP_SHARED as we don't really use shared anywhere else FWICT..

Yeah, my point would be that you can only "unshare" in MAP_PRIVATE
(!MAP_SHARED) :)

-- 
Thanks,

David / dhildenb

