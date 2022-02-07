Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8394AB8DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351618AbiBGKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiBGKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11773C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644229971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8N7gZUufVPClDbzqByvGZXGwhEjMnnKtUKzAi7ogJj4=;
        b=axKKS0tNfsVVan3LR31QVIANXqiJaBwV+/FpMrey55LqjYe56O9iZPsELvqRqVHtaUpWma
        G8MWdyj1Ilwj6NIuSd2WM42MmPoS1B/kbwP7837+QBTRNNohdJCcZ4ia5EJ4gZ0BnYUJDd
        AjMJTe5sJvOsuYiBAVNjNb9yaJvCybU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-PVwSG1Y9MOuRAo_5T0vDMA-1; Mon, 07 Feb 2022 05:32:50 -0500
X-MC-Unique: PVwSG1Y9MOuRAo_5T0vDMA-1
Received: by mail-ej1-f69.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso4141782ejj.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 02:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=8N7gZUufVPClDbzqByvGZXGwhEjMnnKtUKzAi7ogJj4=;
        b=r9QRrcdUzSiZ8HGE47gUB7TbR9/ORbyWNs0Zb8QgkKfcxXsI8OL33ldWfg4Ve3JvtD
         c9RjzGd6JjkkixQVzEvUqDAQTcsJyvGoyQ8tm3KwKASsq7Icg5l375Eci5jsQlnWmTlj
         keQZrtWTfnoM4G6jMXyIecZgcocd0WGhF8Pu9NRf4K9vhXdmYaa6laIbQwf8eAja5xpL
         rWbE+ZJF7DfMtYrkoxLQ5/xgg+6eDGH2FRibewX/4a9IMgMIFoz/fiYHh29HyDYhYsEx
         mjd44estOlbnvuiyAtH/aGChah9carJ4RrQXmSWuta4cfMa/LgwzY5EbowyrLF8Tu2Jc
         0xTA==
X-Gm-Message-State: AOAM531VvYn5ncDCYb2Q+1Mm95So2oxjXu3BC9oUnPXD32ZnCuM60L16
        7wzGZ8GD/MIE1Xfr/WuBvErBIgfdz+iVBiF+rdLacaJGfT+KQ5STC61dzLVZR1RmfxSVnzrZMe3
        wpzDRryOJTnK1tNbYGeJUtBUK
X-Received: by 2002:a17:907:94d2:: with SMTP id dn18mr9620388ejc.304.1644229968899;
        Mon, 07 Feb 2022 02:32:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvKF96YRq6NwS53FrZhG1mLqCL5ivXYdlf5pr+exgpBaE1m8iBSzQAIw7i1vALdWUV19fCqQ==
X-Received: by 2002:a17:907:94d2:: with SMTP id dn18mr9620367ejc.304.1644229968625;
        Mon, 07 Feb 2022 02:32:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6300:a751:d742:1f76:8639? (p200300cbc7096300a751d7421f768639.dip0.t-ipconnect.de. [2003:cb:c709:6300:a751:d742:1f76:8639])
        by smtp.gmail.com with ESMTPSA id ek21sm2838797edb.27.2022.02.07.02.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 02:32:48 -0800 (PST)
Message-ID: <c4128a09-1dc7-24b3-8ff2-eaf61f3de5e5@redhat.com>
Date:   Mon, 7 Feb 2022 11:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
References: <20220203131237.298090-1-pedrodemargomes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/damon: Add option to monitor only writes
In-Reply-To: <20220203131237.298090-1-pedrodemargomes@gmail.com>
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

On 03.02.22 14:12, Pedro Demarchi Gomes wrote:
> When "writes" is written to /sys/kernel/debug/damon/counter_type damon will monitor only writes.
> This patch also adds the actions mergeable and unmergeable to damos schemes. These actions are used by KSM as explained in [1].

[...]

>  
> +static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
> +{
> +	struct page *page;
> +
> +	if (!pte_write(pte))
> +		return false;
> +	if (!is_cow_mapping(vma->vm_flags))
> +		return false;
> +	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
> +		return false;
> +	page = vm_normal_page(vma, addr, pte);
> +	if (!page)
> +		return false;
> +	return page_maybe_dma_pinned(page);
> +}
> +
> +static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> +		unsigned long addr, pmd_t *pmdp)
> +{
> +	pmd_t old, pmd = *pmdp;
> +
> +	if (pmd_present(pmd)) {
> +		/* See comment in change_huge_pmd() */
> +		old = pmdp_invalidate(vma, addr, pmdp);
> +		if (pmd_dirty(old))
> +			pmd = pmd_mkdirty(pmd);
> +		if (pmd_young(old))
> +			pmd = pmd_mkyoung(pmd);
> +
> +		pmd = pmd_wrprotect(pmd);
> +		pmd = pmd_clear_soft_dirty(pmd);
> +
> +		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> +	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
> +		pmd = pmd_swp_clear_soft_dirty(pmd);
> +		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> +	}
> +}
> +
> +static inline void clear_soft_dirty(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *pte)
> +{
> +	/*
> +	 * The soft-dirty tracker uses #PF-s to catch writes
> +	 * to pages, so write-protect the pte as well. See the
> +	 * Documentation/admin-guide/mm/soft-dirty.rst for full description
> +	 * of how soft-dirty works.
> +	 */
> +	pte_t ptent = *pte;
> +
> +	if (pte_present(ptent)) {
> +		pte_t old_pte;
> +
> +		if (pte_is_pinned(vma, addr, ptent))
> +			return;
> +		old_pte = ptep_modify_prot_start(vma, addr, pte);
> +		ptent = pte_wrprotect(old_pte);
> +		ptent = pte_clear_soft_dirty(ptent);
> +		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> +	} else if (is_swap_pte(ptent)) {
> +		ptent = pte_swp_clear_soft_dirty(ptent);
> +		set_pte_at(vma->vm_mm, addr, pte, ptent);
> +	}
> +}

Just like clearrefs, this can race against GUP-fast to detect pinned
pages. And just like clearrefs, we're not handling PMDs properly. And
just like anything that write-protects random anon pages right now, this
does not consider O_DIRECT as is.

Fortunately, there are not too many users of clearreefs/softdirty
tracking out there (my search a while ago returned no open source
users). My assumption is that your feature might see more widespread use.

Adding more random write protection until we fixed the COW issues [1]
really makes my stomach hurt on a Monday morning.

Please, let's defer any more features that rely on write-protecting
random anon pages until we have ways in place to not corrupt random user
space.

That is:
1) Teaching the COW logic to not copy pages that are pinned -- I'm
working on that.
2) Converting O_DIRECT to use FOLL_PIN instead of FOLL_GET. John is
working on that.

So I'm not against this change. I'm against this change at this point in
time.

[1]
https://lore.kernel.org/all/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com/

-- 
Thanks,

David / dhildenb

