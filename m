Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC2C57BF45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiGTUis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FD093F311
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658349524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYQic73id/AGT/OnkFuoiP1qth7L5pTxU/BQI9eja8w=;
        b=cPtsT6vE6Fob5SNsw2XMIgNTr5/dy8oksw/dPKqdoTAZC4DhlwwjnaPW5rQ2tbXl5QZj7s
        q1FLwm6n5qPpi79yTfvoxSB4i548o+Py2HNQ9S9Kw+xx9ucbbvClyRY7uA0DRjQnSquJxs
        K08DuQdFC5HXOWkDaCjWtqtiXzW+0Y4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-gEGLBq2pMWWGiNEA4waasA-1; Wed, 20 Jul 2022 16:38:43 -0400
X-MC-Unique: gEGLBq2pMWWGiNEA4waasA-1
Received: by mail-wr1-f71.google.com with SMTP id n10-20020a5d6b8a000000b0021da91e4a64so3292201wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=TYQic73id/AGT/OnkFuoiP1qth7L5pTxU/BQI9eja8w=;
        b=eo7qjIHUbK9NsQ2JEoe2lIgL5L2iEmYmr5y8UsTIhPAl5BV9KW6j35n6+uvTYPSyeM
         /6iAj6Z65wEm4JD2/f6d3TuB63LxTZt//AA7c9vHcOI4+XlrsdpFQ9zb2Bfn0W5DbVNY
         FOYl2UkWeatod7AZY83ZbAXvnWFiOgcTBoKAB9cIZv5DwigXR26ORUyC4r3P0Lf5EGwp
         t5xbpMe7zAe/zgkFNP+ylAX1wcN0oU5WZPuNBX3jwOfypFhoclInkjq+2WoJZ/uMx7xF
         AGRrs4ODv4B+scYSiunPeVG0aSy2Nelpee63MNoHWK/TUidJNyIzoQbtfkGkuhppd9Z0
         vcmA==
X-Gm-Message-State: AJIora+BhO3wrKDTDCGamw7rATIYueQjvu0wTc9zGA3kwiQSMH25iOif
        dkpxn/9hKGOfxOC1q52bIAMD3va6bUPWXcWtISwkNGDw7JdViUgsUXbNFlIBQK+dG/BJvGb+8xE
        erSbI2CR9Ed17sVeTfT417Sth
X-Received: by 2002:a7b:ce8e:0:b0:3a3:1b01:8e7 with SMTP id q14-20020a7bce8e000000b003a31b0108e7mr5439017wmj.31.1658349521748;
        Wed, 20 Jul 2022 13:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shvxtvZfdWloOMKGoHi916GZzdqgeyDDvSUbHd4Jb9RPJid+Nm4xr6sP20RXU9GZq1BhAaVA==
X-Received: by 2002:a7b:ce8e:0:b0:3a3:1b01:8e7 with SMTP id q14-20020a7bce8e000000b003a31b0108e7mr5438993wmj.31.1658349521491;
        Wed, 20 Jul 2022 13:38:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id d3-20020adffd83000000b0021da61caa10sm16765583wrr.56.2022.07.20.13.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 13:38:41 -0700 (PDT)
Message-ID: <468a7114-7541-0d5e-c1fc-083bbb95e78d@redhat.com>
Date:   Wed, 20 Jul 2022 22:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com> <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
 <Ytf+zIxVPTVXTZdp@xz-m1.local>
 <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
 <YthUYF3invrjlzUc@xz-m1.local>
 <69022bad-d6f1-d830-224d-eb8e5c90d5c7@redhat.com>
 <YthcC78q1hdd7mNT@xz-m1.local>
 <4ad140b5-1d5b-2486-0893-7886a9cdfd76@redhat.com>
 <95320077-52CF-4CB0-92F9-523E1AE74A3D@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
In-Reply-To: <95320077-52CF-4CB0-92F9-523E1AE74A3D@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 22:22, Nadav Amit wrote:
> On Jul 20, 2022, at 12:55 PM, David Hildenbrand <david@redhat.com> wrote:
> 
>> On 20.07.22 21:48, Peter Xu wrote:
>>> On Wed, Jul 20, 2022 at 09:33:35PM +0200, David Hildenbrand wrote:
>>>> On 20.07.22 21:15, Peter Xu wrote:
>>>>> On Wed, Jul 20, 2022 at 05:10:37PM +0200, David Hildenbrand wrote:
>>>>>> For pagecache pages it may as well be *plain wrong* to bypass the write
>>>>>> fault handler and simply mark pages dirty+map them writable.
>>>>>
>>>>> Could you elaborate?
>>>>
>>>> Write-fault handling for some filesystems (that even require this
>>>> "slow path") is a bit special.
>>>>
>>>> For example, do_shared_fault() might have to call page_mkwrite().
>>>>
>>>> AFAIK file systems use that for lazy allocation of disk blocks.
>>>> If you simply go ahead and map a !dirty pagecache page writable
>>>> and mark it dirty, it will not trigger page_mkwrite() and you might
>>>> end up corrupting data.
>>>>
>>>> That's why we the old change_pte_range() code never touched
>>>> anything if the pte wasn't already dirty.
>>>
>>> I don't think that pte_dirty() check was for the pagecache code. For any fs
>>> that has page_mkwrite() defined, it'll already have vma_wants_writenotify()
>>> return 1, so we'll never try to add write bit, hence we'll never even try
>>> to check pte_dirty().
>>
>> I might be too tired, but the whole reason we had this magic before my
>> commit in place was only for the pagecache.
>>
>> With vma_wants_writenotify()=0 you can directly map the pages writable
>> and don't have to do these advanced checks here. In a writable
>> MAP_SHARED VMA you'll already have pte_write().
>>
>> We only get !pte_write() in case we have vma_wants_writenotify()=1 ...
>>
>>  try_change_writable = vma_wants_writenotify(vma, vma->vm_page_prot);
>>
>> and that's the code that checked the dirty bit after all to decide --
>> amongst other things -- if we can simply map it writable without going
>> via the write fault handler and triggering do_shared_fault() .
>>
>> See crazy/ugly FOLL_FORCE code in GUP that similarly checks the dirty bit.
> 
> I thought you want to get rid of it at least for anonymous pages. No?

Yes. Especially for any MAP_PRIVATE mappings.

If you want to write to something that's not mapped writable in a
MAP_PRIVATE mapping it
a) Has to be an exclusive anonymous page
b) The pte has to be dirty

In any other case, you clearly missed to COW or the modifications might
get lost if the PTE is not dirty.

MAP_SHARED is a bit more involved. But whether the pte is dirty might be
good enough ... but this needs a lot more care.

> 
>>
>> But yeah, it's all confusing so I might just be wrong regarding
>> pagecache pages.
> 
> Just to note: I am not very courageous and I did not intend to change
> condition for when non-anonymous pages are set as writable. That’s the
> reason I did not change the dirty for non-writable non-anonymous entries (as
> Peter said). And that’s the reason that setting the dirty bit (at least as I
> should have done it) is only performed after we made the decision on the
> write-bit.

Good. As long as we stick to anonymous pages I roughly know what we we
can and cannot do at this point :)


The problem I see is that detection whether we can write requires the
dirty bit ... and whether to set the dirty bit requires the information
whether we can write.

Again, for anonymous pages we should be able to relax the "dirty"
requirement when detecting whether we can write.

> 
> IOW, after you made your decision about the write-bit, then and only then
> you may be able to set the dirty bit for writable entries. Since the entry
> is already writeable (i.e., can be written without a fault later directly
> from userspace), there should be no concern of correctness when you set it.

That makes sense to me. What keeps confusing me are architectures with
and without a hw-managed dirty bit ... :)

-- 
Thanks,

David / dhildenb

