Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C000457C54D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiGUH2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiGUH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0AD07C199
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658388532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBu0C6SmChVBYE3EWfPl4wKuLdjdTei9NtZmcfmPFKU=;
        b=gjHiKbfHha18BIXy511cE17rvRU5z1YaX/lVEbiPaq1EdCTTMh9ctNfbvW1NtyJumAI+77
        iqkVouXoQlc/2hm625wbw8gv/y8AI6Np0I98aPswbrjhr55trsl4mtlQ3P1EWmhKkiUFef
        esWSTD4CQePdTKTGrVw5jRlTqXvvvBY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-Rxw2Ka8CNUuxeFEDtGMLiQ-1; Thu, 21 Jul 2022 03:28:50 -0400
X-MC-Unique: Rxw2Ka8CNUuxeFEDtGMLiQ-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so348605wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=gBu0C6SmChVBYE3EWfPl4wKuLdjdTei9NtZmcfmPFKU=;
        b=Eay8GxhekMVakmIJ5efuf/+FDClbfTpnyELX6iX1c70OLqPd2nz6xgKiHmlZ8E2Bv3
         2N/QN16qnqouLauz2vbrjmzNeVYTYt6dgwq101/nhHQ82h+D2X1LH5f2Nsy2UqEuYMBO
         Xm6x1nEOQCHP4gWxUGaUSzGcaKcTjcA+JZbnDGARsY9y1XAn++kk9rvZKmpk72VPmQqm
         f78LVOWGOXBVg8Z8MiI7iBhZ3KkYK/nRXa0uad4VLAm8ol1VvhfvoEVZMDrPvkfYzv+r
         2hY4FAouyGoU88DjzUL+75TVDmDmX/Ytvaos09Fo4UeQqeE+3YsncE6F56Y8BcdKYFqx
         kbDQ==
X-Gm-Message-State: AJIora8UtqKdJr3NEDSIM96BGmnIL3GzI/X3olj5ARXaqG29Zwz7RV+R
        Og1/QNakHPv0gDOJ+KcCc3VvYjzxzcDhfCMbm4Eo1nGsuGGEy9j1Gu2TWj6Fb2TB92k5vzE1TEN
        1XU39HR+CWskibVs1V0OpaDbH
X-Received: by 2002:a5d:59a5:0:b0:21d:abc4:29ec with SMTP id p5-20020a5d59a5000000b0021dabc429ecmr33151770wrr.666.1658388529216;
        Thu, 21 Jul 2022 00:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzlvlSraysNcDTugirMAuzJNK+5byYzk1ueqL/RDMyI6446bYemuMQjrAQvkbKKV2hZBumYw==
X-Received: by 2002:a5d:59a5:0:b0:21d:abc4:29ec with SMTP id p5-20020a5d59a5000000b0021dabc429ecmr33151748wrr.666.1658388528719;
        Thu, 21 Jul 2022 00:28:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:e000:25d3:15fa:4c8b:7e8d? (p200300cbc707e00025d315fa4c8b7e8d.dip0.t-ipconnect.de. [2003:cb:c707:e000:25d3:15fa:4c8b:7e8d])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4e4600b003a3188bef63sm973238wmq.11.2022.07.21.00.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 00:28:48 -0700 (PDT)
Message-ID: <f0d193c2-9b23-6f3a-9208-2a615febe0c2@redhat.com>
Date:   Thu, 21 Jul 2022 09:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220720220324.88538-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
In-Reply-To: <20220720220324.88538-1-peterx@redhat.com>
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

On 21.07.22 00:03, Peter Xu wrote:
> The check wanted to make sure when soft-dirty tracking is enabled we won't
> grant write bit by accident, as a page fault is needed for dirty tracking.
> The intention is correct but we didn't check it right because VM_SOFTDIRTY
> set actually means soft-dirty tracking disabled.  Fix it.

Thanks for digging into this and writing the reproducer. The softdirty
logic was rather confusing for me.

> 
> It wasn't a bug for a long time because we used to only optimize the write
> bit settings in change_pte_range() for page caches, and since we've got a
> higher level check in vma_wants_writenotify(), we will never set the bit
> MM_CP_TRY_CHANGE_WRITABLE for soft-dirty enabled page caches, hence even if
> we checked with the wrong value of VM_SOFTDIRTY in change_pte_range() it'll
> just be an no-op.  Functionally it was still correct, even if cpu cycles
> wasted.

I don't quite follow that explanation and most probably I am missing
something.

Modifying your test to map page from a file MAP_SHARED gives me under
5.18.11-100.fc35.x86_64:


53,54d52
<       FILE *file = fopen("tmpfile", "w+");
<       int file_fd;
56d53
<       assert(file);
59,61d55
<
<       file_fd = fileno(file);
<       ftruncate(file_fd, psize);
63c57
<                   MAP_SHARED, file_fd, 0);
---
>                   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);


t480s: ~  $ sudo ./tmp
ERROR: Wrote page again, soft-dirty=0 (expect: 1



IMHO, while the check in vma_wants_writenotify() is correct and makes
sure that the pages are kept R/O by the generic machinery. We get
vma_wants_writenotify(), so we activate MM_CP_TRY_CHANGE_WRITABLE. The
wrong logic in can_change_pte_writable(), however, maps the page
writable again without caring about softdirty.

At least that would be my explanation for the failure. But maybe I
messes up something else :)



> 
> However after the recent work of anonymous page optimization on exclusive
> pages we'll start to make it wrong because anonymous page does not require
> the check in vma_wants_writenotify() hence it'll suffer from the wrong
> check here in can_change_pte_writable().
> 
> We can easily verify this with any exclusive anonymous page, like program
> below:
> 
> =======8<======
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <stdlib.h>
>   #include <assert.h>
>   #include <inttypes.h>
>   #include <stdint.h>
>   #include <sys/types.h>
>   #include <sys/mman.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <unistd.h>
>   #include <fcntl.h>
>   #include <stdbool.h>
> 
>   #define BIT_ULL(nr)                   (1ULL << (nr))
>   #define PM_SOFT_DIRTY                 BIT_ULL(55)
> 
>   unsigned int psize;
>   char *page;
> 
>   uint64_t pagemap_read_vaddr(int fd, void *vaddr)
>   {
>       uint64_t value;
>       int ret;
> 
>       ret = pread(fd, &value, sizeof(uint64_t),
>                   ((uint64_t)vaddr >> 12) * sizeof(uint64_t));
>       assert(ret == sizeof(uint64_t));
> 
>       return value;
>   }
> 
>   void clear_refs_write(void)
>   {
>       int fd = open("/proc/self/clear_refs", O_RDWR);
> 
>       assert(fd >= 0);
>       write(fd, "4", 2);
>       close(fd);
>   }
> 
>   #define  check_soft_dirty(str, expect)  do {                            \
>           bool dirty = pagemap_read_vaddr(fd, page) & PM_SOFT_DIRTY;      \
>           if (dirty != expect) {                                          \
>               printf("ERROR: %s, soft-dirty=%d (expect: %d)\n", str, dirty, expect); \
>               exit(-1);                                                   \
>           }                                                               \
>   } while (0)
> 
>   int main(void)
>   {
>       int fd = open("/proc/self/pagemap", O_RDONLY);
> 
>       assert(fd >= 0);
>       psize = getpagesize();
>       page = mmap(NULL, psize, PROT_READ|PROT_WRITE,
>                   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>       assert(page != MAP_FAILED);
> 
>       *page = 1;
>       check_soft_dirty("Just faulted in page", 1);
>       clear_refs_write();
>       check_soft_dirty("Clear_refs written", 0);
>       mprotect(page, psize, PROT_READ);
>       check_soft_dirty("Marked RO", 0);
>       mprotect(page, psize, PROT_READ|PROT_WRITE);
>       check_soft_dirty("Marked RW", 0);
>       *page = 2;
>       check_soft_dirty("Wrote page again", 1);
> 
>       munmap(page, psize);
>       close(fd);
>       printf("Test passed.\n");
> 
>       return 0;
>   }

Can we turn that into a vm selftest in
tools/testing/selftests/vm/soft-dirty.c, and also extend it by
MAP_SHARED froma  file as above?

> =======8<======
> 
> So even if commit 64fe24a3e05e kept the old behavior and didn't attempt to
> change the behavior here, the bug will only be able to be triggered after
> commit 64fe24a3e05e because only anonymous page will suffer from it.
> 
> Fixes: 64fe24a3e05e ("mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/mprotect.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0420c3ed936c..804807ab14e6 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -48,8 +48,11 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
>  	if (pte_protnone(pte) || !pte_dirty(pte))
>  		return false;
>  
> -	/* Do we need write faults for softdirty tracking? */
> -	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
> +	/*
> +	 * Do we need write faults for softdirty tracking?  Note,
> +	 * soft-dirty is enabled when !VM_SOFTDIRTY.
> +	 */
> +	if (!(vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
>  		return false;

I wonder if we now want, just as in vma_wants_writenotify(), an early
check for IS_ENABLED(CONFIG_MEM_SOFT_DIRTY), to optimize this out
completely.

>  
>  	/* Do we need write faults for uffd-wp tracking? */


-- 
Thanks,

David / dhildenb

