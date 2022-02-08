Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEBC4AD339
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349259AbiBHIYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiBHIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:24:19 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A1C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:24:18 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h7so20172902iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xEJb5dGtkxnE3DtyMZwk9XL+cYr5+2XHsmtJGbNn9w=;
        b=EQfrfLZxUCkGh+GkX3mWS9OkZA/2OhdrueRQPYkMoFFyxvFSW2s2Il8NdOT6E+n9/O
         5x4ciq9rZpVLgGZObrl9GmF2Z0MA2sloPjyTHgo+7o2CUNDxQqt3zD/4o/R9DFBUMOFY
         YIMD8S8bgDHl2b26431AcMAeqYJ+7fZQujWRpHC0xYgfE74KQZdY4/+rebqFBI/3YstE
         0vUNNpqIRLp0Mssr4eK1bCBO+doe0IXOPB3V2GTfWyvMgI2Z+McTB/VzdXYsa/HPs5Qi
         JAEoHlzFaMya6tWxKtHQ5ksXavkCAunD7RQK3MNjE6AGrvICXgPgSD+J96OYRIru6PyF
         C3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xEJb5dGtkxnE3DtyMZwk9XL+cYr5+2XHsmtJGbNn9w=;
        b=JYPydGPRzSl8AMaLxlAXh6d1DsmcHqNrnvtKRTauun4oMVoAfCJVzfbLe8YbnmN8hA
         Kv2G2/9u/WPwPAg2WcDukyMOCbvAwcmTj5amGyJb8f7l3t/J+dwtVknG5Hn/9tX5janB
         xDRdakXLMKb8qvhhAzECEhEYQ3w0Z1zQSCHco4GTQ06FiJ49P/z714MAtM+Eq+6NMtj2
         efc9C5lnCM66ZumtqcGTQ38LdcxeGSnUN67kBRN3Inzs7NbXfS1esTvdLa3lxCVDmuWc
         XtDA5MUwIjJe7pzim3MsmhMwQtG9ZXXsWhCqvey+2sC+xs2Xr9GJ7kek+hzCeyXKi0dQ
         MqlQ==
X-Gm-Message-State: AOAM532ADjw5WIYe2SNMyGbTwkgkPZIj/vfxiGV6N3l2gHyWbfQfptTT
        cCIriCZVpzZud+QycsaAUc/IJw==
X-Google-Smtp-Source: ABdhPJz0275GX25s4HD4rXh2vegbV0ySFaSIArfKRzAwnXPerqERRCHYLW7W1lSQppGMHug4USPTww==
X-Received: by 2002:a05:6638:10c5:: with SMTP id q5mr1493113jad.113.1644308658203;
        Tue, 08 Feb 2022 00:24:18 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
        by smtp.gmail.com with ESMTPSA id x7sm2989090ilp.88.2022.02.08.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:24:17 -0800 (PST)
Date:   Tue, 8 Feb 2022 01:24:13 -0700
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
Subject: Re: [PATCH v7 01/12] mm: x86, arm64: add arch_has_hw_pte_young()
Message-ID: <YgIorS8g6N1YlpzB@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208081902.3550911-2-yuzhao@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:18:51AM -0700, Yu Zhao wrote:

<snipped>

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index c4ba047a82d2..990358eca359 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -999,23 +999,13 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>   * page after fork() + CoW for pfn mappings. We don't always have a
>   * hardware-managed access flag on arm64.
>   */
> -static inline bool arch_faults_on_old_pte(void)
> -{
> -	WARN_ON(preemptible());
> -
> -	return !cpu_has_hw_af();
> -}
> -#define arch_faults_on_old_pte		arch_faults_on_old_pte
> +#define arch_has_hw_pte_young		cpu_has_hw_af

Reworked arch_has_hw_pte_young() for arm64 according to:
https://lore.kernel.org/linux-mm/20220111141901.GA10338@willie-the-truck/

<snipped>
