Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFA14FE913
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiDLTuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiDLTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D19366C8E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649792721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WpG5ULDIWtR6MAD2NZ7Y0GsTIabSBZ3X6PEQkqyZxBI=;
        b=D8c08brRT73HVKkzCUdNgqwgxTFbPbt76GBalgmj0MgjdT5ViKqzEAEPoASxSCu89qfm2k
        j5wh65KDz72WoUDIqPGYUu8ocXP5ftTKVVJwz7JUVVrGS15fllbVna11xuVU5D2u7kpENJ
        RPkW7tryhAS6EkKPE/9kQzx69Oh57p0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-Huai4W5bNAeQv8Y0AnYZTQ-1; Tue, 12 Apr 2022 15:45:20 -0400
X-MC-Unique: Huai4W5bNAeQv8Y0AnYZTQ-1
Received: by mail-il1-f199.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so13341324ilu.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WpG5ULDIWtR6MAD2NZ7Y0GsTIabSBZ3X6PEQkqyZxBI=;
        b=6DDGFTUWKKtvyxBaYCUDlWRtji6Tn6ujXPvHK7Gglyl5Crw5k3uL13o7L7T0hvcugG
         vJPb6JVNb4n/5eOZWApCLAnSjqLRTV19ZrxkEI01LMqNYEolb69Z2WqQy2GDzrAZ2ZZV
         Kb3pMQWJBsm+H4HUyrF2XrqBS097jCjpsEqTVbbdi5z8MFIPMOLDIwPJfD36qrlMlM1L
         8CiKePM304+Qpc/e/To87x9R/XsSnk99o5yG20l8+2GO/YgZbhHUdXqCcf0wseERfKA1
         3l9GbdQHY8xmrTF0IJqWgLNmiYS6dcCQPhw9L8nCqGnVRNtxsz6b1c2y0ctnZd95yko+
         2JDw==
X-Gm-Message-State: AOAM531wHHlX321LWis2mZBkIJqAp6IZOGk/nAVcOYSCbhSnQHfRwRbn
        tRBGGC8fjy8dSjfksaipw3qwO7nW0DdLK1d/JOh3/GiXII4auisMl7mI1fvslyOXB0KXdfLC8En
        67fz4+lqewys9mJmbu5uMRIVz
X-Received: by 2002:a05:6638:2041:b0:323:b749:f52d with SMTP id t1-20020a056638204100b00323b749f52dmr17008227jaj.306.1649792719346;
        Tue, 12 Apr 2022 12:45:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcjlWXnaygTtgjP1hPyx4RLhLUfitY3W7bEerI41T+XUGE4bcRNUUxW1dD8cXewiOn0M3SEA==
X-Received: by 2002:a05:6638:2041:b0:323:b749:f52d with SMTP id t1-20020a056638204100b00323b749f52dmr17008209jaj.306.1649792719089;
        Tue, 12 Apr 2022 12:45:19 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id w1-20020a056e021a6100b002caa71d8d98sm5359586ilv.49.2022.04.12.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:45:18 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:45:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 01/23] mm: Introduce PTE_MARKER swap entry
Message-ID: <YlXWzf3nF+lGA5fn@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014646.13522-2-peterx@redhat.com>
 <87bkx7ayfs.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkx7ayfs.fsf@nvdebian.thelocal>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 11:07:56AM +1000, Alistair Popple wrote:
> Hi Peter,

Hi, Alistair,

> 
> I noticed this while reviewing the next patch in the series. I think you need to
> add CONFIG_PTE_MARKER to the below as well:
> 
> #if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
>     defined(CONFIG_DEVICE_PRIVATE)
> static inline int non_swap_entry(swp_entry_t entry)
> {
> 	return swp_type(entry) >= MAX_SWAPFILES;
> }
> #else
> static inline int non_swap_entry(swp_entry_t entry)
> {
> 	return 0;
> }
> #endif
> 
> Otherwise marker entries will be treated as swap entries, which is wrong for
> example in swapin_walk_pmd_entry() as marker entries are no longer considered
> pte_none().

Thanks for the comment, that makes sense.

Instead of adding PTE_MARKER into this equation, I'm going backward and
wondering purely on why we need to bother with non_swap_entry() at all if
MAX_SWAPFILES is already defined with proper knowledges of all these bits.

#define MAX_SWAPFILES \
	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM)

So, I agree with your analysis, but instead of adding PTE_MARKER, what do
you think about we dropping that complexity as a whole (possibly with a
standalone patch)?

---8<---
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d356ab4047f7..5af852b68805 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -387,18 +387,10 @@ static inline void num_poisoned_pages_inc(void)
 }
 #endif
 
-#if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
-    defined(CONFIG_DEVICE_PRIVATE)
 static inline int non_swap_entry(swp_entry_t entry)
 {
        return swp_type(entry) >= MAX_SWAPFILES;
 }
-#else
-static inline int non_swap_entry(swp_entry_t entry)
-{
-       return 0;
-}
-#endif
 
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
---8<---

Thanks,

-- 
Peter Xu

