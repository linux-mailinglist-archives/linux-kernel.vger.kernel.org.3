Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB64A52922C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbiEPVG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349153AbiEPVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:06:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F02248DE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:45:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v11so15082243pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l5jUETdQtHEXCwQFA5Ufebx16mwsRUyyujdOiTy28og=;
        b=GaemBa1gF02qzUZdNW2AE28Uzqwx+75YoAHrLpwUHFK1R8hxxzjrSh8Q5SZMGiEPXl
         /FhnCNkUH6ejeeR6wOWUc9lqnC/0EEUljPupDtKy8+ETy8XDqPtWO4ziRtuK86sZu9Ev
         SqLp+wIJq4/hnPdDgrw1XE6gGoVYtTidWQeH1DBVN1QXaTI9CjDMkZ7hpDPoy8ouxBC2
         RwydQ7n1LENQqO30MwKKJf5W5P98Zml6TQ0efgBviMPmyclbGwciZEr7A4q4Hh3atmW2
         zhNFDHyhOJRo3UBbRiY9/KJD2c2iGTWUPcINfwtzau5htXKjRWbCPdVyaMpkpLn7+NP9
         +A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l5jUETdQtHEXCwQFA5Ufebx16mwsRUyyujdOiTy28og=;
        b=KB1OIccUtgJupywKN4zX2rhPbIrQ9deyHtELpTU4HOJ4i+RkHHDDT2J5fzQm1VzTWc
         9Pk2B6o1eJf28seSyJdw/NPwvuNWsOK2vV3XSr7+RESMlgxWnCsFbIHvXmLPEoLS6lN7
         90LNAhsbVQUvKtGO31M7+VHIzjY6RaMZ2bKiRa6wHq1gZjP/Tbz6ci2BYtON0PEh7Uja
         vZKRjXXvLBt14nGjPbJtxfp9ooWmp/OvjyXaCdCSJ6kg2V1tEb7qyBcu1oMTdSpUtTRq
         QRORiAJV3m66VdXaf35a53qwT+TlKx0Sp9fv4tdtsoQ1ypw7XpYY/7VeyRWUaKxOHfaG
         CtqQ==
X-Gm-Message-State: AOAM531Ezkehibu8OgCEXaeJ9T1p2l1wSGDRKM6lfZeJKH+OtHYvDcKr
        3RVlSv75ClAWln/pAX4DGpKbhA==
X-Google-Smtp-Source: ABdhPJyRB0U0e6IhW4ELB2usOGhx6N4mS/LgNnRGAxfxluRfGpgT0F+X9R60+xNZF13kv2acFOHZhg==
X-Received: by 2002:a63:3c05:0:b0:3f2:6ea8:aff2 with SMTP id j5-20020a633c05000000b003f26ea8aff2mr5855767pga.340.1652733904295;
        Mon, 16 May 2022 13:45:04 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 131-20020a621489000000b0050dc76281e9sm7211287pfu.195.2022.05.16.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:45:03 -0700 (PDT)
Date:   Mon, 16 May 2022 20:45:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: x86/svm/nested: Cache PDPTEs for nested NPT in PAE
 paging mode
Message-ID: <YoK3zEVj+DuIBEs7@google.com>
References: <20220415103414.86555-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415103414.86555-1-jiangshanlai@gmail.com>
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

On Fri, Apr 15, 2022, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> When NPT enabled L1 is PAE paging, vcpu->arch.mmu->get_pdptrs() which
> is nested_svm_get_tdp_pdptr() reads the guest NPT's PDPTE from memroy
> unconditionally for each call.
> 
> The guest PAE root page is not write-protected.
> 
> The mmu->get_pdptrs() in FNAME(walk_addr_generic) might get different
> values every time or it is different from the return value of
> mmu->get_pdptrs() in mmu_alloc_shadow_roots().
> 
> And it will cause FNAME(fetch) installs the spte in a wrong sp
> or links a sp to a wrong parent since FNAME(gpte_changed) can't
> check these kind of changes.
> 
> Cache the PDPTEs and the problem is resolved.  The guest is responsible
> to info the host if its PAE root page is updated which will cause
> nested vmexit and the host updates the cache when next nested run.

Hmm, no, the guest is responsible for invalidating translations that can be
cached in the TLB, but the guest is not responsible for a full reload of PDPTEs.
Per the APM, the PDPTEs can be cached like regular PTEs:

  Under SVM, however, when the processor is in guest mode with PAE enabled, the
  guest PDPT entries are not cached or validated at this point, but instead are
  loaded and checked on demand in the normal course of address translation, just
  like page directory and page table entries. Any reserved bit violations ared
  etected at the point of use, and result in a page-fault (#PF) exception rather
  than a general-protection (#GP) exception.

So if L1 modifies a PDPTE from !PRESENT (or RESERVED) to PRESENT (and valid), then
any active L2 vCPUs should recognize the new PDPTE without a nested VM-Exit because
the old entry can't have been cached in the TLB.

In practice, snapshotting at nested VMRUN would likely work, but architecturally
it's wrong and could cause problems if L1+L2 are engange in paravirt shenanigans,
e.g. async #PF comes to mind.

I believe the correct way to fix this is to write-protect nNPT PDPTEs like all other
shadow pages, which shouldn't be too awful to do as part of your series to route
PDPTEs through kvm_mmu_get_page().
