Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248455A46D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiH2KKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiH2KKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3CBD56
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661767787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0iJeEEMiB2DCikCIjHSgM1lSRaaW/hXlDWBwCpAOeg=;
        b=Al7EFHbtTm7vaYeDLad5xbAAm8duHVgE1P5Hd1yX/j3QDwtu592YWaNj3Vdbu6SpLI9fjh
        g+mcNw3275YHFZ7gc2722/eXQ7nTOqv7mlgG44JavGEA+hn6/WLrgnemAXB3PfxXZYRXNX
        WjM1lctoX3r8NVyRtsNu3hFVE+TvwQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-OF7Lfw75MM6oueyNAWXLXA-1; Mon, 29 Aug 2022 06:09:46 -0400
X-MC-Unique: OF7Lfw75MM6oueyNAWXLXA-1
Received: by mail-wm1-f71.google.com with SMTP id 203-20020a1c02d4000000b003a5f5bce876so8255658wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=h0iJeEEMiB2DCikCIjHSgM1lSRaaW/hXlDWBwCpAOeg=;
        b=we1mFsI3IgrI245Qxo6WKxprpyaOmiF4sC/8UZ0XPS7USNNC/Lm/eAT+vW2XBvzDlT
         R6ZQC/sEofwZRsBlgIRVYuPtu1jJi259a8IqqFXx4WCF2ygAfWSF3628o5PpsbYGlgnD
         3K38dnSasNCLQ/6nrhPuEFJliOwEXUyEAdG6IuS9ldXbuTRLwpThHO7Nrc+toy8i60Ms
         dsn2u7EM+E5l1mjUINhDA08m0fFceR7oPDzhAOqk2EbGiP7Oy20i/Li0b+FY0SxYm6eU
         bUn7H3wwookrd7baiQ7iPyrw3mIOxaQnMhLPFxYfhxH+tdfUgZolMq89gxGPzsLrnTk0
         vOHA==
X-Gm-Message-State: ACgBeo0IuHt9Gmkve3fadI76i1qwKRU4l0LmPgd6sEanl+ZDtIg4OLFY
        j/G8bd+YZfeINFO4KsN27UA6GK2zl9G9H7AGER62EE6hdA6aoDvxgc7Mp0RP6y+HXD6duROgQwc
        F6pwE9cvEziiJ9OSbY5QVYFrK
X-Received: by 2002:adf:e18e:0:b0:225:5e7c:3621 with SMTP id az14-20020adfe18e000000b002255e7c3621mr5745105wrb.183.1661767785080;
        Mon, 29 Aug 2022 03:09:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Uz0seJ1E4OF755dE5cBZQF6ifsbu5oFppvT/FnFXCk4E6RGBkH5JlKIfh9ZfcMI7RtROe2g==
X-Received: by 2002:adf:e18e:0:b0:225:5e7c:3621 with SMTP id az14-20020adfe18e000000b002255e7c3621mr5745096wrb.183.1661767784794;
        Mon, 29 Aug 2022 03:09:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:658b:bed0:4260:4c25? (p200300cbc7073900658bbed042604c25.dip0.t-ipconnect.de. [2003:cb:c707:3900:658b:bed0:4260:4c25])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b0022571d43d32sm1269298wrt.21.2022.08.29.03.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 03:09:44 -0700 (PDT)
Message-ID: <cf2dee71-0b01-1df2-f97e-12c27ed6d630@redhat.com>
Date:   Mon, 29 Aug 2022 12:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
References: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/7] Try to free empty and zero user PTE page table
 pages
In-Reply-To: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.22 12:10, Qi Zheng wrote:
> Hi,
> 
> Before this, in order to free empty user PTE page table pages, I posted the
> following patch sets of two solutions:
>  - atomic refcount version:
> 	https://lore.kernel.org/lkml/20211110105428.32458-1-zhengqi.arch@bytedance.com/
>  - percpu refcount version:
> 	https://lore.kernel.org/lkml/20220429133552.33768-1-zhengqi.arch@bytedance.com/
> 
> Both patch sets have the following behavior:
> a. Protect the page table walker by hooking pte_offset_map{_lock}() and
>    pte_unmap{_unlock}()
> b. Will automatically reclaim PTE page table pages in the non-reclaiming path
> 
> For behavior a, there may be the following disadvantages mentioned by
> David Hildenbrand:
>  - It introduces a lot of complexity. It's not something easy to get in and most
>    probably not easy to get out again
>  - It is inconvenient to extend to other architectures. For example, for the
>    continuous ptes of arm64, the pointer to the PTE entry is obtained directly
>    through pte_offset_kernel() instead of pte_offset_map{_lock}()
>  - It has been found that pte_unmap() is missing in some places that only
>    execute on 64-bit systems, which is a disaster for pte_refcount
> 
> For behavior b, it may not be necessary to actively reclaim PTE pages, especially
> when memory pressure is not high, and deferring to the reclaim path may be a
> better choice.
> 
> In addition, the above two solutions are only for empty PTE pages (a PTE page
> where all entries are empty), and do not deal with the zero PTE page ( a PTE
> page where all page table entries are mapped to shared zero page) mentioned by
> David Hildenbrand:
> 	"Especially the shared zeropage is nasty, because there are
> 	 sane use cases that can trigger it. Assume you have a VM
> 	 (e.g., QEMU) that inflated the balloon to return free memory
> 	 to the hypervisor.
> 
> 	 Simply migrating that VM will populate the shared zeropage to
> 	 all inflated pages, because migration code ends up reading all
> 	 VM memory. Similarly, the guest can just read that memory as
> 	 well, for example, when the guest issues kdump itself."
> 
> The purpose of this RFC patch is to continue the discussion and fix the above
> issues. The following is the solution to be discussed.

Thanks for providing an alternative! It's certainly easier to digest :)

> 
> In order to quickly identify the above two types of PTE pages, we still
> introduced a pte_refcount for each PTE page. We put the mapped and zero PTE
> entry counter into the pte_refcount of the PTE page. The bitmask has the
> following meaning:
> 
>  - bits 0-9 are mapped PTE entry count
>  - bits 10-19 are zero PTE entry count

I guess we could factor the zero PTE change out, to have an even simpler
first version. The issue is that some features (userfaultfd) don't
expect page faults when something was aleady mapped previously.

PTE markers as introduced by Peter might require a thought -- we don't
have anything mapped but do have additional information that we have to
maintain.

> 
> In this way, when mapped PTE entry count is 0, we can know that the current PTE
> page is an empty PTE page, and when zero PTE entry count is PTRS_PER_PTE, we can
> know that the current PTE page is a zero PTE page.
> 
> We only update the pte_refcount when setting and clearing of PTE entry, and
> since they are both protected by pte lock, pte_refcount can be a non-atomic
> variable with little performance overhead.
> 
> For page table walker, we mutually exclusive it by holding write lock of
> mmap_lock when doing pmd_clear() (in the newly added path to reclaim PTE pages).

I recall when I played with that idea that the mmap_lock is not
sufficient to rip out a page table. IIRC, we also have to hold the rmap
lock(s), to prevent RMAP walkers from still using the page table.

Especially if multiple VMAs intersect a page table, things might get
tricky, because multiple rmap locks could be involved.

We might want/need another mechanism to synchronize against page table
walkers.

-- 
Thanks,

David / dhildenb

