Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172C58004C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiGYN73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiGYN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECBF315FEA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658757564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sz4oM0IDHGPEgWtKcSAebAo6SpMhyBqLIAp4XwN/Ogo=;
        b=OGpqYNAtTQwbh6aOo6Cgborjd6Vis1qHYf87CW3PiaRrsemNmkgtvyN+iQ2xmlpMeTx/Hl
        7sbltBOER/SgJIfEUJI7k8wN32wGzbw1ycBM3BpZEnbF9vAyIkNzikaTi8yJUHbgiW0Ifp
        0qfuXZ3jBDpUiqngzF/94oU+YULB9Lc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-uU6C609SNmisyAQWZ-nuvQ-1; Mon, 25 Jul 2022 09:59:22 -0400
X-MC-Unique: uU6C609SNmisyAQWZ-nuvQ-1
Received: by mail-qt1-f199.google.com with SMTP id fz9-20020a05622a5a8900b0031eef501518so5592297qtb.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sz4oM0IDHGPEgWtKcSAebAo6SpMhyBqLIAp4XwN/Ogo=;
        b=QfaL8FEVQ14t7bexzDCNB0pe1B1GeuM42XmuIyJXNDAMDqdxCcdBn5bDkSugXUqRd5
         kVUSRInYv9xz0jww2umMfWhMKSEz7UoHNBdPbYud3+sS0JLEHPkMCieEL+g4X+LYYWUW
         5mDuItH990QXvNc7yk/27oywrl15QV1+5DnpwCelzmRL/I/FYTM6yTcjLzM7qXvfBV8M
         DXgbYff5+P3F7UukjvQZDB1JgH/4dA05tYZf4HB15IH7Gh4PSPjjcm0G6EcNroWA+ysW
         iUh4a+lZZyZ1h4bs3Zt44A3HGr24n9hTrLkji12dAVE9TxzO/hqd/42SLKbrGe9Dz4nT
         pZYw==
X-Gm-Message-State: AJIora9qpicvSDrHeUSPBWkjR5PZTCs9SHRAaNJitscjEtNZXJeLuAP9
        MOs75sOr7UzEeMmeavaDkdYqjXWOMuEu9JgaY7VhM0wso2C/fh1x8aG6bkkz7cInZIs9l90+xLr
        4722Glbuz/2i7g3Pt/WUpMGvi
X-Received: by 2002:ac8:7e88:0:b0:31f:a54:c7c5 with SMTP id w8-20020ac87e88000000b0031f0a54c7c5mr10329558qtj.369.1658757561170;
        Mon, 25 Jul 2022 06:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqSk4wFBDTtDsDvBWgWV1uumgTmnmG9ZtHQFKK8dfX4AsbLrchd50lM/ykeGmiZTJ7tb/P0w==
X-Received: by 2002:ac8:7e88:0:b0:31f:a54:c7c5 with SMTP id w8-20020ac87e88000000b0031f0a54c7c5mr10329531qtj.369.1658757560726;
        Mon, 25 Jul 2022 06:59:20 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id h22-20020ac87156000000b0031ef622a6a2sm7282097qtp.17.2022.07.25.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:59:19 -0700 (PDT)
Date:   Mon, 25 Jul 2022 09:59:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Message-ID: <Yt6htg03lqj7FFU2@xz-m1.local>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-2-peterx@redhat.com>
 <e35e42ce-e942-141d-09e7-a3a7868f4abb@redhat.com>
 <C2910936-FDCF-4ECF-B014-D985284B225A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C2910936-FDCF-4ECF-B014-D985284B225A@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:21:00AM -0700, Nadav Amit wrote:
> On Jul 22, 2022, at 12:08 AM, David Hildenbrand <david@redhat.com> wrote:
> 
> >> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> >> +{
> >> +	/*
> >> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
> >> +	 * enablements, because when without soft-dirty being compiled in,
> >> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> >> +	 * will be constantly true.
> >> +	 */
> >> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> >> +		return false;
> >> +
> >> +	/*
> >> +	 * Soft-dirty is kind of special: its tracking is enabled when the
> >> +	 * vma flags not set.
> >> +	 */
> >> +	return !(vma->vm_flags & VM_SOFTDIRTY);
> >> +}
> > 
> > That will come in handy in other patches I'm cooking.
> 
> clear_refs_write() also comes to mind as well (for consistency; I see no
> correctness or performance issue).

I explicitly didn't touch that because current code is better..

        mas_for_each(&mas, vma, ULONG_MAX) {
                if (!(vma->vm_flags & VM_SOFTDIRTY))
                        continue;
                vma->vm_flags &= ~VM_SOFTDIRTY;
                vma_set_page_prot(vma);
        }

It means when !CONFIG_MEM_SOFT_DIRTY the "if" will always be true and all
vma will be jumped.

If replaced with vma_soft_dirty_enabled() it'll be instead constantly false
returned.  We'll redo vma_set_page_prot() even if unnecessary.

Here if we want to add the "CONFIG_MEM_SOFT_DIRTY" into equation it can be:

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f8cd58846a28..ab6f2913b5a5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1290,6 +1290,8 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
                }
 
                if (type == CLEAR_REFS_SOFT_DIRTY) {
+                       if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+                               goto out_unlock;
                        mas_for_each(&mas, vma, ULONG_MAX) {
                                if (!(vma->vm_flags & VM_SOFTDIRTY))
                                        continue;

Or even at the entrance to not take the mm sem.  But it's not anything
important IMHO, so if no one asking for that I'll just leave it be.

Thanks,

-- 
Peter Xu

