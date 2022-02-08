Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCDD4AD361
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349467AbiBHI2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiBHI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:28:35 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFBCC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:28:34 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id c188so20164644iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IaBXYZ+vat/5ri8bP0Swu84ZGYn0w01tNU9IeoBlMPo=;
        b=JThnxs6ZEyP2u3Voeo1JuquQn0t749qV+dqgrkX/eEyw4qMNSGPIULygJERycpC1iy
         +AQd2m1QIjqNSDwOFk46qn5AYDIHYzXVdEM3dtSWuOvlvT8+KthV+E99Rhvtvxn5ILCs
         haxC3B8Gsf1Pi5Nq/N2zOQ5W0mAhVJkCxyJb4lWDFgta0RejGctd0RcYBY8sIBBL0aWd
         APCE23snVKHhFdcAW9iyip/mQUSd+NwczXDE1llk0vN/RqI0nPxmqbqcbxTylIaE2XnI
         bHheeZVK7BT++iatU0uIk/jvo2r77n8slx8g5GX2AeL6By3N4E4LbJMw2D/Drc+Yqdfa
         sodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IaBXYZ+vat/5ri8bP0Swu84ZGYn0w01tNU9IeoBlMPo=;
        b=YIqqEGlkKPW++puqczM0Mo3sF6bbslYfQqSlI1TTI46ggmUlZjqtjGEqXEk0g618mQ
         WSbG28mZB2y69Lx/asrN/TLngEhts94G50hEAyPvT77qWTX6AzSJ+5TlNtE5O30wO5zX
         xE9c5t1UWz4bwqHSIvzJ4qoRmMOzw2wKQWGMPZeupQjfIcNsn3wRDC6cTkt962tAU+9s
         38P32EE9vQeKTD585iX4Z1pfPKHxVIrxw+yNbH87aCVyPbROzw1/QstaKM5m33OjzURT
         U4M2MWPvesq50SYzXQkR0Ecnt7PViyNWz0XyCCi+9s9LSn2Reozr8AgywS2TYUcb5627
         JlMQ==
X-Gm-Message-State: AOAM530iWwD9ZkCVbkVzRC9gAXeZMwEYnluxppHqEdKCSP29xfbVlMYq
        iEPG7zwlwNbCZ7wTkgDd2dX3JA==
X-Google-Smtp-Source: ABdhPJzqrwOWjbsRUGOLxbeEThZwwHRnlRXbd7OEIRH/TeA65mA64JA5hXRJTjnC0IbwzU+6RJs/Ng==
X-Received: by 2002:a05:6638:13c8:: with SMTP id i8mr1687217jaj.125.1644308914113;
        Tue, 08 Feb 2022 00:28:34 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
        by smtp.gmail.com with ESMTPSA id y9sm2780137ilg.58.2022.02.08.00.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:28:33 -0800 (PST)
Date:   Tue, 8 Feb 2022 01:28:29 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
Message-ID: <YgIpreheobw2M5k3@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-5-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208081902.3550911-5-yuzhao@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:18:54AM -0700, Yu Zhao wrote:

<snipped>

> diff --git a/mm/memory.c b/mm/memory.c
> index a7379196a47e..d27e5f1a2533 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4754,6 +4754,27 @@ static inline void mm_account_fault(struct pt_regs *regs,
>  		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
>  }
>  
> +#ifdef CONFIG_LRU_GEN
> +static void lru_gen_enter_fault(struct vm_area_struct *vma)
> +{
> +	/* the LRU algorithm doesn't apply to sequential or random reads */
> +	current->in_lru_fault = !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ));
> +}
> +
> +static void lru_gen_exit_fault(void)
> +{
> +	current->in_lru_fault = false;
> +}
> +#else
> +static void lru_gen_enter_fault(struct vm_area_struct *vma)
> +{
> +}
> +
> +static void lru_gen_exit_fault(void)
> +{
> +}
> +#endif /* CONFIG_LRU_GEN */

Moved task_enter_lru_fault() from mm.h to memory.c as requested here:
https://lore.kernel.org/linux-mm/CAHk-=wib5-tUrf2=zYL9hjCqqFykZmTr_-vMAvSo48boCA+-Wg@mail.gmail.com/

Also renamed it to lru_gen_enter_fault().

<snipped>
