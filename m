Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE75ACE24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiIEIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbiIEIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD94FC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662367135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILMwA9fkaPSQbnEjTCgZSueaFo6DDmAJP8o22EUbbXE=;
        b=G4JQS9IbI8KXtLw/0/yZSDapodiMzS/pzvnY6z2ON2+i6f+2UHdWb86bKj9kbXBcfK0zrH
        DAwdHtWA8iOPeqnLvQtQYN1kTlh1xNFRGjREU8pH7r4sEkBt9ndAn1hvjU9fznz/7a4wHO
        j06MRc5ozJtZKms06eeWSIw7eZTjv/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-v7q0yT3jOMKb1nXEmG0emg-1; Mon, 05 Sep 2022 04:38:54 -0400
X-MC-Unique: v7q0yT3jOMKb1nXEmG0emg-1
Received: by mail-wm1-f72.google.com with SMTP id r83-20020a1c4456000000b003a7b679981cso7148104wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ILMwA9fkaPSQbnEjTCgZSueaFo6DDmAJP8o22EUbbXE=;
        b=yOuYgwc+RgzP5t8pXWJYae4Fky4U75nIhgRlE+TBhFDaWLoslPhQGqMSQRXLW1UG77
         zXJDopXF42J0otF5GFrRoyhNrKXwa3EZpvUz+k5zWm/QHXFYtH4lOiEt8e+CLV/tMq8w
         4RKYTp/gI52n7/AMGezvAJEYdpcGJBj/KTGnC7Hz+puxv7RHwbTT43MzRxiW2XqenPUK
         +zlXW1zSiGAXVAX4vZpfwYW6ve2wsotXg+sHZomtUWSjyJNB7bk6ayBo4SL+UU3CV10e
         CYRmNPpipyZ+m8f0QmO0k4Q33SLIPCpiHFnYgtQKaHtyEQdcSNnBLIRfIjRA4nYNYsp5
         OMVg==
X-Gm-Message-State: ACgBeo08gf+/BDAQTIOaLkhs5/fpKjtYkBoZz+h+KiCYYAP595xqdA43
        Xd377Q51CVMeFMBkFvAVsm2rH28q5kV2jJfr8dRrcTNR4XN69+Qu33UJTEQsqrInVcaJ+g3j9Ya
        aNOyWPKYxmQJqLugtvnEhhIUm
X-Received: by 2002:adf:edc9:0:b0:228:60de:1d4b with SMTP id v9-20020adfedc9000000b0022860de1d4bmr5046583wro.306.1662367133630;
        Mon, 05 Sep 2022 01:38:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR60WICcIrDNSZs4MSw41DvHhNAQ05OE2uoMX1kpOkCLtV4PSb7MnlZqTDufmIRJIblolcu2Ng==
X-Received: by 2002:adf:edc9:0:b0:228:60de:1d4b with SMTP id v9-20020adfedc9000000b0022860de1d4bmr5046569wro.306.1662367133370;
        Mon, 05 Sep 2022 01:38:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b003a540fef440sm17340137wmb.1.2022.09.05.01.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:38:52 -0700 (PDT)
Message-ID: <8e1aaa19-0d28-3381-3ec6-920a474f5f3f@redhat.com>
Date:   Mon, 5 Sep 2022 10:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Content-Language: en-US
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
 <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
 <YxD00K1lv151X/eq@xz-m1.local>
 <CAHbLzkrA-jKzTBq_Mn3NZYc91exovv1gH2LNzetCNiVu8+W6Kg@mail.gmail.com>
 <2368d91f-8442-076f-f33a-64b51b44825c@redhat.com>
 <e87bad0c-47fa-5e6d-9c43-f2f66da32a76@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <e87bad0c-47fa-5e6d-9c43-f2f66da32a76@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.22 18:52, Aneesh Kumar K V wrote:
> On 9/2/22 12:02 PM, David Hildenbrand wrote:
>> On 01.09.22 20:35, Yang Shi wrote:
>>> On Thu, Sep 1, 2022 at 11:07 AM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Thu, Sep 01, 2022 at 10:50:48AM -0700, Yang Shi wrote:
>>>>> Yeah, because THP collapse does copy the data before clearing pte. If
>>>>> we want to remove pmdp_collapse_flush() by just clearing pmd, we
>>>>> should clear *AND* flush pte before copying the data IIRC.
>>>>
>>>> Yes tlb flush is still needed.  IIUC the generic pmdp_collapse_flush() will
>>>> still be working (with the pte level flushing there) but it should just
>>>> start to work for all archs, so potentially we could drop the arch-specific
>>>> pmdp_collapse_flush()s, mostly the ppc impl.
>>>
>>> I'm don't know why powperpc needs to have its specific
>>> pmdp_collapse_flush() in the first place, not only the mandatory IPI
>>> broadcast, but also the specific implementation of pmd tlb flush. But
>>> anyway the IPI broadcast could be removed at least IMO.
>>>
>>
>> pmdp_collapse_flush() is overwritten on book3s only. It either translates
>> to radix__pmdp_collapse_flush() or hash__pmdp_collapse_flush().
>>
>>
>> radix__pmdp_collapse_flush() has a comment explaining the situation:
>>
>>
>> +       /*
>> +        * pmdp collapse_flush need to ensure that there are no parallel gup
>> +        * walk after this call. This is needed so that we can have stable
>> +        * page ref count when collapsing a page. We don't allow a collapse page
>> +        * if we have gup taken on the page. We can ensure that by sending IPI
>> +        * because gup walk happens with IRQ disabled.
>> +        */
>>
>>
>> The comment for hash__pmdp_collapse_flush() is a bit more involved:
>>
>> 	/*
>> 	 * Wait for all pending hash_page to finish. This is needed
>> 	 * in case of subpage collapse. When we collapse normal pages
>> 	 * to hugepage, we first clear the pmd, then invalidate all
>> 	 * the PTE entries. The assumption here is that any low level
>> 	 * page fault will see a none pmd and take the slow path that
>> 	 * will wait on mmap_lock. But we could very well be in a
>> 	 * hash_page with local ptep pointer value. Such a hash page
>> 	 * can result in adding new HPTE entries for normal subpages.
>> 	 * That means we could be modifying the page content as we
>> 	 * copy them to a huge page. So wait for parallel hash_page
>> 	 * to finish before invalidating HPTE entries. We can do this
>> 	 * by sending an IPI to all the cpus and executing a dummy
>> 	 * function there.
>> 	 */
>>
>> I'm not sure if that implies that the IPI is needed for some other hash-magic.
>>
>> Maybe Aneesh can clarify.
>>
> 
> We still need the IPI for the hash. Another reason for architecture to override that
> function is to help them use the right page size when flushing the TLB.

Thanks for clarifying. So the radix variant wouldn't need the IPI 
anymore, once GUP-fast is handled differently, correct?

-- 
Thanks,

David / dhildenb

