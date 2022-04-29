Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28846514F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378533AbiD2Pgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378527AbiD2Pgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:36:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF08BE32
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:33:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l6so1072324pls.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SFOR3+kK83DlZHp2Arv4EDbveYV0BndynvOkcO0bSFs=;
        b=lnHn0cpnBt/cCr2F1HEbqTJiImyIs+WIfO9O9NvgYaBfSY7GpJZIuIZ2E3cZZadxKx
         PRgwd6deKCvb8Jmq2MbAMiG9Xb3F4mPELbQXTi66RHIArXVSfdrdntSHaWmWYqo2YPp4
         ulZ8r4SL1UE3xsdaq/l8hA2TZAoKU4icfH+hWRXABAhykS8vMuN5cluGTfiNMS4IjxB/
         CDKsA1nN0FbeT6lIcYJYS5qDTbDB/URSAtzZ2JipuMtoIbFEpyxCwemVRLvrVnMIxtuN
         T3g6y+KOFWB29UL7LT/9AlKskc1Y2Sj+C6MKW5Ufwv7IojQkxGOuvbadVxrcYQNGcU2h
         EEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SFOR3+kK83DlZHp2Arv4EDbveYV0BndynvOkcO0bSFs=;
        b=eNuK9m83ewdyD+a9UfoiapqfzOZyeusGXfY2/xxfCtuzxzqB2YUQkAdntoy2FmQXEp
         SQrJdq8N3ZVuy7GdQ3Mze9AhHaEUvTh9JIeLkdQ+UvDl+w03HkmjeFEO0vcXtiYLTnJ7
         X5texKjlwfyQPlilNU2cHFAAO7OkczvmdYlgldSv6Z0NuHEs0+cyq676Z+sfYBGq1pO0
         Ow1zZO4W9Gqnsi8uBaUUesSbhQ8a7y2GuKG+chTaW3CJetmZdnOSNyhe9IZUkFKIYq23
         aAzKocJJQZJ88p9P6poj/aH9mSHU7xcjvn8mip5Y/o7p3nvj1EHDEjWPMGLUAHgbZzgS
         oJLg==
X-Gm-Message-State: AOAM5339KPPGZgUrCimZi1d9QHFiSW506F9GnTphxeW4D8VDs5u21uBU
        CjyxqgnXP5kA/ENbrPpQ7Dqg4g==
X-Google-Smtp-Source: ABdhPJwaHxxP2xbQYaQ/TMxhawzB6ccVBu6Fbil5fW1Ac6jD13Vv3+3p7s0/VSfrvWEqN3TiknScBw==
X-Received: by 2002:a17:90b:f03:b0:1d9:a8e9:9e35 with SMTP id br3-20020a17090b0f0300b001d9a8e99e35mr4653596pjb.48.1651246393962;
        Fri, 29 Apr 2022 08:33:13 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id mj2-20020a17090b368200b001cd4989ff4esm10494225pjb.21.2022.04.29.08.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:33:13 -0700 (PDT)
Date:   Fri, 29 Apr 2022 15:33:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: fix potential races when walking host page
 table
Message-ID: <YmwFNbYy4tlxOJRG@google.com>
References: <20220429031757.2042406-1-mizhang@google.com>
 <4b0936bf-fd3e-950a-81af-fd393475553f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0936bf-fd3e-950a-81af-fd393475553f@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022, Paolo Bonzini wrote:
> On 4/29/22 05:17, Mingwei Zhang wrote:
> > +	ptep = pte_offset_map(&pmd, address);
> > +	pte = ptep_get(ptep);
> > +	if (pte_present(pte)) {
> > +		pte_unmap(ptep);
> > +		level = PG_LEVEL_4K;
> > +		goto out;
> > +	}
> > +	pte_unmap(ptep);
> 
> Not needed as long as PG_LEVEL_4K is returned for a non-present PTE.
> 
> > +out:
> > +	local_irq_restore(flags);
> > +	return level;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_lookup_address_level_in_mm);
> 
> Exporting is not needed.
> 
> Thanks for writing the walk code though.  I'll adapt it and integrate the
> patch.

Can you also remove the intermediate pointers?  They are at best a wash in terms
of readability (net negative IMO), and introduce unnecessary risk by opening up
the possibility of using the wrong variable and/or re-reading an entry.

Case in point, this code subtly re-reads the upper level entries when getting
the next level down, which can run afould of huge page promotion and use the
wrong address (huge pfn instead of page table address).

The alternative is to use the p*d_offset_lockless() helper, but IMO that's
unnecessary and pointless because it just does the same thing under the hood.

E.g. (compile tested only at this point)

static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
				  const struct kvm_memory_slot *slot)
{
	unsigned long flags;
	unsigned long hva;
	int level;
	pgd_t pgd;
	p4d_t p4d;
	pud_t pud;
	pmd_t pmd;

	if (!PageCompound(pfn_to_page(pfn)) && !kvm_is_zone_device_pfn(pfn))
		return PG_LEVEL_4K;

	/*
	 * Note, using the already-retrieved memslot and __gfn_to_hva_memslot()
	 * is not solely for performance, it's also necessary to avoid the
	 * "writable" check in __gfn_to_hva_many(), which will always fail on
	 * read-only memslots due to gfn_to_hva() assuming writes.  Earlier
	 * page fault steps have already verified the guest isn't writing a
	 * read-only memslot.
	 */
	hva = __gfn_to_hva_memslot(slot, gfn);

	level = PG_LEVEL_4K;

	/*
	 * Disable IRQs to block TLB shootdown and thus prevent user page tables
	 * from being freed.
	 */
	local_irq_save(flags);

	pgd = READ_ONCE(*pgd_offset(kvm->mm, hva));
	if (pgd_none(pgd))
		goto out;

	p4d = READ_ONCE(*p4d_offset(&pgd, hva));
	if (p4d_none(p4d) || !p4d_present(p4d))
		goto out;

	if (p4d_large(p4d)) {
		level = PG_LEVEL_512G;
		goto out;
	}

	pud = READ_ONCE(*pud_offset(&p4d, hva));
	if (pud_none(pud) || !pud_present(pud))
		goto out;

	if (pud_large(pud)) {
		level = PG_LEVEL_1G;
		goto out;
	}

	pmd = READ_ONCE(*pmd_offset(&pud, hva));
	if (pmd_none(pmd) || !pmd_present(pmd))
		goto out;

	if (pmd_large(pmd))
		level = PG_LEVEL_2M;
out:
	local_irq_restore(flags);
	return level;
}

