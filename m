Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2C48A363
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbiAJXGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbiAJXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:06:50 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47CC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:06:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q14so14382070plx.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y+VBsHBfwIdG2OzWHPdI/WIqfhyYeKNFkPIFzGKgGjs=;
        b=X/BYePGBzH1Y0U06VN7h0LTAx5XkiSMJkjX4bzEruFI1kwOUOCZ/UQD5Hz1I4ruAQl
         PKrgHenyxeASQaRZZvzIOgMnuzQdonH1VvyAbdvdjbchbZ2+uMZc22CuQapKF6//7uez
         U7SEtzQCYOhll5kuSGrRuD3424eXtMM1K2q20cLcgofjiBKZpwYAGGu/G+SgPu+Ah0Ai
         cMXFe7zrtF2HSeLvPaMRp85OO6XQzOWT5yW68a8WQ+brErvfPeLpyOXHT8jSayE1ssES
         B/xCP4larnCmFQsqFp3LTl28pqvPRHXZOcO2unNP2YugKO4xbE5RD1x5r36xyKuMboWr
         viJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+VBsHBfwIdG2OzWHPdI/WIqfhyYeKNFkPIFzGKgGjs=;
        b=P7Q+VVJCYSLS/Z3NbXXrkZG/hW/2fSS43jvcrHKZqOEkOzqVzgzLBkI37jjMZsxYcp
         2YV8POmF1L2113giycHG6F9+hKuRk7UUbxXOJVcfhQooYBb5dYQ5pl2S28svAob7Q3dW
         osvlpy3eQFoIHOyD2l0fpOJD3t2wmsOdfxWHIBytPUFkmcdsZlLPXzCoZXeQt7UqGpA+
         TOiUCSZA/jjfTzDUrxPzTMSsQj3BpRQof/QhrMAnZB+deeIehWlJ13vD7XBAKeogOdjF
         /3UYgg5xtH4Ps0O/e3Cwfm4bO4YGcbUgnqlUOz9fxkq4IZx9RRZtsyU3lQwxa7VHTST5
         AfVg==
X-Gm-Message-State: AOAM533z2P5WSaxC+ckwauvXO5MKZ27TSrPHIl4o+ArV7Lbo3RjNq9tY
        ZnSs57+myA0cu8AxHMhUwE0nAQ==
X-Google-Smtp-Source: ABdhPJwuqul2WTZrr6xhkm1p+58Y11+q37mOxYmOZK51ca5s/4q/F/MIfrRIm+VTh9ySZMN7V9F+qQ==
X-Received: by 2002:a17:90a:d90b:: with SMTP id c11mr37450pjv.211.1641856009160;
        Mon, 10 Jan 2022 15:06:49 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d1sm4554170pgd.66.2022.01.10.15.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 15:06:48 -0800 (PST)
Date:   Mon, 10 Jan 2022 23:06:44 +0000
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
Message-ID: <Ydy8BCfE0jhJd5uE@google.com>
References: <20211227081515.2088920-1-chao.gao@intel.com>
 <20211227081515.2088920-4-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227081515.2088920-4-chao.gao@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021, Chao Gao wrote:
> No arch implementation uses this opaque now.

Except for the RISC-V part, this can be a pure revert of commit b99040853738 ("KVM:
Pass kvm_init()'s opaque param to additional arch funcs").  I think it makes sense
to process it as a revert, with a short blurb in the changelog to note that RISC-V
is manually modified as RISC-V support came along in the interim.
