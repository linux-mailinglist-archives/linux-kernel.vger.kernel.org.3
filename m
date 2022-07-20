Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B057BEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiGTTdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiGTTdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E2995D0DC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658345619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mn98tBM+3OLRK7fELHKIBmz9kutRk009kDVFdDSnBwY=;
        b=Vas/bP/5TsPL6oAw/oOAvNTFRsm5bou99WPnXUH52FHZRntNX4t0OxAkWCWW9gchDF9atl
        MdY1FK0BCL6bvGpHGBGbgPsyIpdUmtgRnqkfyRoBZqVrYLUnlYyK8GDpcbhn5hzebARNjp
        julkUsNnIT1w7miUZewt+t1CeJnyEeM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-CUG1rFvBMmKmewIw6c80tw-1; Wed, 20 Jul 2022 15:33:37 -0400
X-MC-Unique: CUG1rFvBMmKmewIw6c80tw-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1190607wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Mn98tBM+3OLRK7fELHKIBmz9kutRk009kDVFdDSnBwY=;
        b=GxqczahXBANSLOsEYmDrh0/2+xMFhP1nvJQJht/20BaB+o1sJpnbl7uNHnvOMX8Jzh
         6JaE/P+14BlqnQ50OvJk3Yjjnd+o5Dwqq5IiYN0u8beLL2dVUDNzNhaZ8ljpfwClqCap
         qScASbWaVSbeB2lW47naTM3wh0+2RczvcdXgFVrqCP+nj8djgd3zvGB+w3KpoDh10lFm
         2mZoevOxXHvuXHyaXL3BTSKUs4uU2WULn4JgQ0+TtYz4DsJLR3pjUWJHEZYBjoJQ8Ct0
         rf55GX3k0BOJmPvMBJU1vpiHY+3H1MEKYCDQ51+y9RpzJkX6HkU9nS1TPQfGWzFSBruW
         YYtA==
X-Gm-Message-State: AJIora/yMdBDDuDcHjP7PZKRBrbaL/fcD4mumdwOF14MFSuu5GYQNVk9
        Sr32es17D6WHBZtA4anDhPCxa3aE3k0sGCUKZE1WilazwJzmeLk/OXbFSmGaXKf76PUu2duP99B
        A3Bf0xh4/qhDWEtA4sBP1yO5D
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id bj4-20020a0560001e0400b0021d7ec3fe5amr32280359wrb.116.1658345616774;
        Wed, 20 Jul 2022 12:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tBqSfg7bH069Byd/vRG4bt0BOfT4AODrDs7R/jaof9TDEfBaGFUwZYl1U3qluoU6u2j0rASQ==
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id bj4-20020a0560001e0400b0021d7ec3fe5amr32280339wrb.116.1658345616505;
        Wed, 20 Jul 2022 12:33:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id bp7-20020a5d5a87000000b0021d80f53324sm16981122wrb.7.2022.07.20.12.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 12:33:36 -0700 (PDT)
Message-ID: <69022bad-d6f1-d830-224d-eb8e5c90d5c7@redhat.com>
Date:   Wed, 20 Jul 2022 21:33:35 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
In-Reply-To: <YthUYF3invrjlzUc@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 21:15, Peter Xu wrote:
> On Wed, Jul 20, 2022 at 05:10:37PM +0200, David Hildenbrand wrote:
>> For pagecache pages it may as well be *plain wrong* to bypass the write
>> fault handler and simply mark pages dirty+map them writable.
> 
> Could you elaborate?

Write-fault handling for some filesystems (that even require this
"slow path") is a bit special.

For example, do_shared_fault() might have to call page_mkwrite().

AFAIK file systems use that for lazy allocation of disk blocks.
If you simply go ahead and map a !dirty pagecache page writable
and mark it dirty, it will not trigger page_mkwrite() and you might
end up corrupting data.

That's why we the old change_pte_range() code never touched
anything if the pte wasn't already dirty. Because as long as it's not writable,
the FS might have to be informed about the write-unprotect.

And we end up in the case here for VM_SHARED with vma_wants_writenotify().
Where we, for example, check

/* The backer wishes to know when pages are first written to? *
if (vm_ops && (vm_ops->page_mkwrite || vm_ops->pfn_mkwrite))$
	return 1;


Long story short, we should be really careful with write-fault handler bypasses,
especially when deciding to set dirty bits. For pagecache pages, we have to be
especially careful.

For exclusive anon pages it's mostly ok, because wp_page_reuse()
doesn't really contain that much magic. The only thing to consider for ordinary
mprotect() is that there is -- IMHO -- absolutely no guarantee that someone will
write to a specific write-unprotected page soon. For uffd-wp-unprotect it might be
easier to guess, especially, if we un-protect only a single page.

-- 
Thanks,

David / dhildenb

