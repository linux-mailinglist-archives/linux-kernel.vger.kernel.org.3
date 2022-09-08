Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38C5B24DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiIHRjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiIHRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A691E917A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662658724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u3VyZ3w1bOu5Udrn5Alq1L+olcWnXxs8SfgOS75iA0c=;
        b=G2VBfV2PEPKkaOEi2/g74kmduVLuVZi+lqjK6jko21u7sS1Wl3tZ574uEX2RymZK6tVLIz
        9ZoaLxl3QhBi7806Jc08kXj28Ls4hK6xS/K9TBMsDfO9AdjMJbIWMZQVDLO2SORFTD9lX6
        LZO/QA7iyjvTx0C5Ez9Lc/FzP05mUyA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-rMXqd207PtW8IIE_uWUEcw-1; Thu, 08 Sep 2022 13:38:33 -0400
X-MC-Unique: rMXqd207PtW8IIE_uWUEcw-1
Received: by mail-qv1-f71.google.com with SMTP id c1-20020a0cfb01000000b00495ad218c74so13212597qvp.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=u3VyZ3w1bOu5Udrn5Alq1L+olcWnXxs8SfgOS75iA0c=;
        b=GQxVe7AeEU2obiQnEPvxwLhAagAk2+1pbvjT+hw0+JY5oV1+ntBAw275y8mu4oqkgM
         5FEU4rpbov3GJa3IycZJQ17nMOOtE/w+boRzEex8Yo33VC9e7pStUQF4w2jEN0uhVVzm
         mI2fE1zoPtCfcB4ZhxzSNi+ZpDQVKHpb9SogQr9smR2LF8YdxvUH3PIYP9ZY3BdOa03K
         bBpexpnOo9fqIm/jLagcxzAb2hy2Rs8+0IsBnUXRfQqWvlynZYMcjwcB5WyuTXYWtkJ+
         WnbCSw2fZxfcE6QXRgLcElEYtZxHjIPLzr8mAAyxHIie/jQylpBW8CaIA0Wr7CMs8AX9
         Opnw==
X-Gm-Message-State: ACgBeo3clLyEu6jGOrrAJeldfHtf5rL6WYSmVSonEHNGL/e+Qj1FguU4
        nvG6q92euktLuX/Lk9WIjYcfHFP+ancx5JHId3+9XKMeE//Wv724EZCEXjLQv6YyBKVN5EKW/HO
        PL9bFXRWpRPS3XP7CO82JedeV
X-Received: by 2002:a05:6214:2aae:b0:496:cf51:bacf with SMTP id js14-20020a0562142aae00b00496cf51bacfmr8541625qvb.29.1662658713332;
        Thu, 08 Sep 2022 10:38:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6xoeqcxpfkCjwLToZdiSnU4SU+olAUgAizlwk76xC6Z+dQWjOGeSXKAZ5YEKu/VRuFnik+Mg==
X-Received: by 2002:a05:6214:2aae:b0:496:cf51:bacf with SMTP id js14-20020a0562142aae00b00496cf51bacfmr8541609qvb.29.1662658713038;
        Thu, 08 Sep 2022 10:38:33 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87a98000000b003431446588fsm14638554qtr.5.2022.09.08.10.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:38:32 -0700 (PDT)
Date:   Thu, 8 Sep 2022 13:38:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
Message-ID: <Yxool80IgkXnqS5Y@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-8-jthoughton@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Fri, Jun 24, 2022 at 05:36:37PM +0000, James Houghton wrote:
> +static inline
> +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +
> +	BUG_ON(!hpte->ptep);
> +	// Only use huge_pte_lockptr if we are at leaf-level. Otherwise use
> +	// the regular page table lock.
> +	if (hugetlb_pte_none(hpte) || hugetlb_pte_present_leaf(hpte))
> +		return huge_pte_lockptr(hugetlb_pte_shift(hpte),
> +				mm, hpte->ptep);
> +	return &mm->page_table_lock;
> +}

Today when I re-read part of this thread, I found that I'm not sure whether
this is safe.  IIUC taking different locks depending on the state of pte
may lead to issues.

For example, could below race happen where two threads can be taking
different locks even if stumbled over the same pmd entry?

         thread 1                          thread 2
         --------                          --------

    hugetlb_pte_lockptr (for pmd level)
      pte_none()==true,
        take pmd lock
    pmd_alloc()
                                hugetlb_pte_lockptr (for pmd level)
                                  pte is pgtable entry (so !none, !present_leaf)
                                    take page_table_lock
                                (can run concurrently with thread 1...)
    pte_alloc()
    ...

-- 
Peter Xu

