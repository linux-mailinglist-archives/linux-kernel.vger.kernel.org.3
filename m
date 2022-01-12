Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51048C939
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355546AbiALRVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355549AbiALRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:20:51 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA9C061756
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:20:49 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l8so4950194plt.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QRCI1RlLdVZvt5lKUzeK60PXJ4E91izm9CxbrCuYWiw=;
        b=iD4ax0W/ZQejkpiTV+wC/BTGkgvydCG1+oy9k4x41xcYsxdOIrYBD3Jg5pNLFotLn3
         4lS1DP/A5h5rWv9t8jIgjAfIWRHyWSXlvlM7IaIgxX7hDAUmIgxXIoU5b+8CgT0R9dt0
         iCbsvCcrQj4kpbl/NpitUUKIbg7rTypIFxqdxfB2feMrGc8niiEgwy4Jncc/4d2meNQg
         hKQ5yFTrProqxoFW6AG+GqRq3CQHFwiDeSswlB6x17ayzfA94e4NsXmAcxNN0/DUQR5b
         DQXQiXIgM3bNMe/5PUo8aj95UIBHAUjKy79FkjU/HbhRpV61hkglUgnEV5dHn1QxLypF
         YTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QRCI1RlLdVZvt5lKUzeK60PXJ4E91izm9CxbrCuYWiw=;
        b=Biny6LMUaRZsHVtarkRROaXH8Pf/x+c5otYY2ALF92MTse1zj8D5JnxPePld83tCVV
         EcbiuzS8/sCpVOpBHDyxBi4bx0vn7ebc1kEBIWwVdsNNOAd4YWC2FyFSkVOZv8TUpfMs
         nFA46lhoEINava0L6C/iXjIm4nRZzvQy+HBjxfUup1sSz9Fs2Zusjqk9pCfQhKKyXT0u
         IMdVbHtTcnaiuE0R4/lDI6E5ewX8yhXbKqyyaqyjxnELQfkC0h1MrVaj4OAIqXyQ1dKy
         57sp6RqASqVhzh4Y83WlmAlcI6e2eD0JJZgvYGneltqIyU5r5T/xqBiJFe/2b6pE9BKE
         sjXw==
X-Gm-Message-State: AOAM531oBjww+UejJg9h5BrOYlqtTLs5l9KTHwmjtHYYzSMuMdNHqCPa
        2MnmEAzf3xh4eLAsrboSW/Jt1Q==
X-Google-Smtp-Source: ABdhPJzSQE5HuAs9ufGKv8GVZpWcgq8Jooiv84LWQSj+pdxhdpdaB4H7DHBA1IqNFc1FS00InVj1vA==
X-Received: by 2002:a05:6a00:2442:b0:4bc:e7ac:b5aa with SMTP id d2-20020a056a00244200b004bce7acb5aamr553091pfj.56.1642008049112;
        Wed, 12 Jan 2022 09:20:49 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id kb1sm266614pjb.45.2022.01.12.09.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 09:20:48 -0800 (PST)
Date:   Wed, 12 Jan 2022 17:20:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, kevin.tian@intel.com,
        tglx@linutronix.de, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/6] KVM: Remove opaque from
 kvm_arch_check_processor_compat
Message-ID: <Yd8N7PFqZbACzh2r@google.com>
References: <20211227081515.2088920-1-chao.gao@intel.com>
 <20211227081515.2088920-4-chao.gao@intel.com>
 <Ydy8BCfE0jhJd5uE@google.com>
 <20220111031933.GB2175@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111031933.GB2175@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022, Chao Gao wrote:
> On Mon, Jan 10, 2022 at 11:06:44PM +0000, Sean Christopherson wrote:
> >On Mon, Dec 27, 2021, Chao Gao wrote:
> >> No arch implementation uses this opaque now.
> >
> >Except for the RISC-V part, this can be a pure revert of commit b99040853738 ("KVM:
> >Pass kvm_init()'s opaque param to additional arch funcs").  I think it makes sense
> >to process it as a revert, with a short blurb in the changelog to note that RISC-V
> >is manually modified as RISC-V support came along in the interim.
> 
> commit b99040853738 adds opaque param to kvm_arch_hardware_setup(), which isn't
> reverted in this patch. I.e., this patch is a partial revert of b99040853738
> plus manual changes to RISC-V. Given that, "process it as a revert" means
> clearly say in changelog that this commit contains a partial revert of commit
> b99040853738 ("KVM: Pass kvm_init()'s opaque param to additional arch funcs").
> 
> Right?

What I meant is literally do

  git revert -s b99040853738

and then manually handle RISC-V.
