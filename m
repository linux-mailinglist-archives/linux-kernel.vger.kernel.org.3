Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290B5A2CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbiHZQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343974AbiHZQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD44D4F0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661532367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aM/0vWRQhG6l7795J8Sv+413xc0zb7CfNl42O6VQfck=;
        b=FBxHiUqU9FVpa7Horoiw5XLQf84aODDYVcVdXQTPTBqa548PgpKeq6u5jPC7wPlIq5rwHm
        wUtmrL4APmTS/c3/qKNtaVL9Hd/jUIi4vT1fecTD1koa8ild7yJizT5pDCsE1PRPTq8jr9
        1T17Yxox02xa/7JAlfQJks3MVVr5O3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-nRQnTZl_NLmLU1YT7-IYQw-1; Fri, 26 Aug 2022 12:46:05 -0400
X-MC-Unique: nRQnTZl_NLmLU1YT7-IYQw-1
Received: by mail-wr1-f72.google.com with SMTP id d1-20020adfa341000000b0022571fbdfe2so222172wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=aM/0vWRQhG6l7795J8Sv+413xc0zb7CfNl42O6VQfck=;
        b=HlT3oWzOhdZHlB9Q9ib/8V4C7P3HcWp1BV+5MDot4z1Iso1rHGHc7CPb1kyRATDn8n
         ZU/3+QK1UKZb+SuE/hT3uD1nUwlxlzCyVwaxIEBMzuh+Nq9yUxIBJwQKnRCnGMVjBLtq
         4t0dlzOd0UxHrKP0dGm3PiLTsqNzxPB/n1cBWIL/PcHCUhvO2og5KOfgHxbjEMrFJzbb
         dG5eW1HkExC2q3tJY9x1PfDW2SKTzlKrICQ3tagC3HWxcv2B9Z0NBaUCnQUhYavXa46x
         vQZI0yMsPyz8u8KLtLj72ulL30F5cG/QFH2EZXotGHgVMHLcoNE91o+NecLAhOiXkK+0
         pfLw==
X-Gm-Message-State: ACgBeo2dkbqkz/phFC+G1kQd1MwS2nk/VeMlSzkhCJuKOySPKfRUmkBS
        VxbdfwBjjhrCdaHOKX7SpJ/N/WoiyvI+oP74R5o5j4F3dyf+9CRmLR59UwUDek2wB7BsiE28CWO
        ryucjyPnB3RdenmmpufyjAFGK
X-Received: by 2002:a7b:cd0f:0:b0:3a5:ec59:daf0 with SMTP id f15-20020a7bcd0f000000b003a5ec59daf0mr279197wmj.13.1661532364613;
        Fri, 26 Aug 2022 09:46:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR40NbGvjbiWl5L8l+XuL5Rh4KAQqMtg/LZ8GOIke5nZFYZHD6d6ipQhIpQgrK46S3HVwjTkJA==
X-Received: by 2002:a7b:cd0f:0:b0:3a5:ec59:daf0 with SMTP id f15-20020a7bcd0f000000b003a5ec59daf0mr279186wmj.13.1661532364308;
        Fri, 26 Aug 2022 09:46:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f600:abad:360:c840:33fa? (p200300cbc708f600abad0360c84033fa.dip0.t-ipconnect.de. [2003:cb:c708:f600:abad:360:c840:33fa])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc349000000b003a5fa79007fsm162159wmj.7.2022.08.26.09.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 09:46:03 -0700 (PDT)
Message-ID: <140e7688-b66d-2f6d-fed8-e39da5045420@redhat.com>
Date:   Fri, 26 Aug 2022 18:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>
References: <3b01af093515ce2960ac39bb16ff77473150d179.1661309831.git-series.apopple@nvidia.com>
 <ffbc824af5daa2c44b91c66834a341894fba4ce6.1661309831.git-series.apopple@nvidia.com>
 <YwZGHyYJiJ+CGLn2@xz-m1.local> <8735dkeyyg.fsf@nvdebian.thelocal>
 <YwgFRLn43+U/hxwt@xz-m1.local> <8735dj7qwb.fsf@nvdebian.thelocal>
 <YwjZamk4n/dz+Y/M@xz-m1.local>
 <72146725-3d70-0427-50d4-165283a5a85d@redhat.com>
 <Ywjs/i4kIVlxZwpb@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 2/3] mm/migrate_device.c: Copy pte dirty bit to page
In-Reply-To: <Ywjs/i4kIVlxZwpb@xz-m1.local>
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

On 26.08.22 17:55, Peter Xu wrote:
> On Fri, Aug 26, 2022 at 04:47:22PM +0200, David Hildenbrand wrote:
>>> To me anon exclusive only shows this mm exclusively owns this page. I
>>> didn't quickly figure out why that requires different handling on tlb
>>> flushs.  Did I perhaps miss something?
>>
>> GUP-fast is the magic bit, we have to make sure that we won't see new
>> GUP pins, thus the TLB flush.
>>
>> include/linux/mm.h:gup_must_unshare() contains documentation.
> 
> Hmm.. Shouldn't ptep_get_and_clear() (e.g., xchg() on x86_64) already
> guarantees that no other process/thread will see this pte anymore
> afterwards?

You could have a GUP-fast thread that just looked up the PTE and is
going to pin the page afterwards, after the ptep_get_and_clear()
returned. You'll have to wait until that thread finished.

Another user that relies on this interaction between GUP-fast and TLB
flushing is for example mm/ksm.c:write_protect_page()

There is a comment in there explaining the interaction a bit more detailed.

Maybe we'll be able to handle this differently in the future (maybe once
this turns out to be an actual performance problem). Unfortunately,
mm->write_protect_seq isn't easily usable because we'd need have to make
sure we're the exclusive writer.


For now, it's not too complicated. For PTEs:
* try_to_migrate_one() already uses ptep_clear_flush().
* try_to_unmap_one() already conditionally used ptep_clear_flush().
* migrate_vma_collect_pmd() was the one case that didn't use it already
 (and I wonder why it's different than try_to_migrate_one()).

-- 
Thanks,

David / dhildenb

