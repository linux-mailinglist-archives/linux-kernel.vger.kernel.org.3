Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E088957BEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiGTTz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGTTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1FB54C81
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658346940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mr8pnCTauYjzOGkOniK7GloDn5urX/KaCQJ8ZGemUEM=;
        b=dhvMHqaEfEEftQYqBttR4djOLBA8JRp4hShVkc00BGkBOombMxor2UC54iLb/9YUiHgLH3
        mmOLhx82cAIfvFV9dXNDB0Ci8FsE+Y6aFM7M70i6OCT866Y2FUGFVA3D9ccdcGNMG0sKaY
        aMsweBSaEUBn7uisiqbLfalssaKy10s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-h5lwaHfROuio37Z_4bnaMw-1; Wed, 20 Jul 2022 15:55:39 -0400
X-MC-Unique: h5lwaHfROuio37Z_4bnaMw-1
Received: by mail-wr1-f72.google.com with SMTP id h1-20020adfa4c1000000b0021e43452547so1007746wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=mr8pnCTauYjzOGkOniK7GloDn5urX/KaCQJ8ZGemUEM=;
        b=UpmEjdhGED4uuujUJuDG9FAGEgdK6aEd6NcqPbM4rIjHf+9seiTnhU5LFgX6vz3BgM
         hVIke2M9ClWckMdWE5VSzHvobefgzpLVkUbrdqow0nWSLotHcpcKu+bswYtP08uTCoRM
         vcovumjn86yMRwSAvpRLo5vTnrLvpDtb4ZI4ynwfdYGOHMW0tiCwrQf8U6r6zftpIuqZ
         X5bfaX9hxlMRL9sIpovhqa22m6ShpVy/hLVfBZZ2W57TH2Hyj97xAaYwHY0/AWznyX75
         q4ypm7qIDCbfRFgl3bxa8socMNx6fx0s23OtRx6AuYLMbNccUbeORZNg62Yu11PY4cPG
         /APA==
X-Gm-Message-State: AJIora9U2DiVskh3U/fQZays6bQTU05xJJ4oqFxqkJ1Lbyidh8Y2HsEA
        C6shjhOxUKNbfne6W7eog2jhtSsEX2lWzfNa5LGaFZBgSAY1VbO115hB+XfvUwki0WlE2Kxo+9b
        snuU8AC/kqXXNchJPQgvIJPoW
X-Received: by 2002:a05:6000:15ce:b0:21d:b177:a8f0 with SMTP id y14-20020a05600015ce00b0021db177a8f0mr32417141wry.370.1658346937488;
        Wed, 20 Jul 2022 12:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tJEQZKBMArtmW7WMPAxcqPwpk9+YRx+an8bBYKNXh8934xY+EHCPUzX4kL3p8wx50YKReHzg==
X-Received: by 2002:a05:6000:15ce:b0:21d:b177:a8f0 with SMTP id y14-20020a05600015ce00b0021db177a8f0mr32417127wry.370.1658346937235;
        Wed, 20 Jul 2022 12:55:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id g14-20020adff40e000000b0021bbf6687b1sm19731824wro.81.2022.07.20.12.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 12:55:36 -0700 (PDT)
Message-ID: <4ad140b5-1d5b-2486-0893-7886a9cdfd76@redhat.com>
Date:   Wed, 20 Jul 2022 21:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
In-Reply-To: <YthcC78q1hdd7mNT@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 21:48, Peter Xu wrote:
> On Wed, Jul 20, 2022 at 09:33:35PM +0200, David Hildenbrand wrote:
>> On 20.07.22 21:15, Peter Xu wrote:
>>> On Wed, Jul 20, 2022 at 05:10:37PM +0200, David Hildenbrand wrote:
>>>> For pagecache pages it may as well be *plain wrong* to bypass the write
>>>> fault handler and simply mark pages dirty+map them writable.
>>>
>>> Could you elaborate?
>>
>> Write-fault handling for some filesystems (that even require this
>> "slow path") is a bit special.
>>
>> For example, do_shared_fault() might have to call page_mkwrite().
>>
>> AFAIK file systems use that for lazy allocation of disk blocks.
>> If you simply go ahead and map a !dirty pagecache page writable
>> and mark it dirty, it will not trigger page_mkwrite() and you might
>> end up corrupting data.
>>
>> That's why we the old change_pte_range() code never touched
>> anything if the pte wasn't already dirty.
> 
> I don't think that pte_dirty() check was for the pagecache code. For any fs
> that has page_mkwrite() defined, it'll already have vma_wants_writenotify()
> return 1, so we'll never try to add write bit, hence we'll never even try
> to check pte_dirty().
> 

I might be too tired, but the whole reason we had this magic before my
commit in place was only for the pagecache.

With vma_wants_writenotify()=0 you can directly map the pages writable
and don't have to do these advanced checks here. In a writable
MAP_SHARED VMA you'll already have pte_write().

We only get !pte_write() in case we have vma_wants_writenotify()=1 ...

  try_change_writable = vma_wants_writenotify(vma, vma->vm_page_prot);

and that's the code that checked the dirty bit after all to decide --
amongst other things -- if we can simply map it writable without going
via the write fault handler and triggering do_shared_fault() .

See crazy/ugly FOLL_FORCE code in GUP that similarly checks the dirty bit.

But yeah, it's all confusing so I might just be wrong regarding
pagecache pages.

-- 
Thanks,

David / dhildenb

