Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4964A692E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbiBBAZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiBBAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:25:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07B1C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:25:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643761529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w74ZJOaVt6Kmg8KSjRCPSyIsO9g1OFfRIBkrQ0IgAA8=;
        b=41y4R91CcSHQGOlDT3iuOWqB+NNVwY0JKiz89+Kn833qdRCKCeeldfT+iSq95IOiFHoaIx
        0u88tQ8mfiku13myi5DprMYZZnznOdzR74FtZ2LbdNWkmUzE5N0dM4NmNt1NgVn09lH2cc
        r5+Hq/6rW1m16ETgNR8cboEKKkq1FYPDyuPp8gb1yAtZUOfrl5zw7LCDhPmDzGMTIxSal0
        Tiow3R1nnFBhghTDxDJBtL2xZH+DertGwAID/8uYbvYdSCn7mdxyeh5HJ1t1HJHNV9UoEA
        cp2MSPmR888g4snsuya97LGnyigDKjwh40rd6TatzI2VIRPNNYmbMxJ0Rcj5lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643761529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w74ZJOaVt6Kmg8KSjRCPSyIsO9g1OFfRIBkrQ0IgAA8=;
        b=prX4tNmrK84+dA89yFUx0nz+y9YBx+7Pn+2k+86c8GwYaX+d0n4bIkV0qpFRLw0DuIVvyx
        /5HGp9mUSZgyyfDQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
In-Reply-To: <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 01:25:28 +0100
Message-ID: <87bkzqw1vr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:

> In TDX guests, guest memory is protected from host access. If a guest
> performs I/O, it needs to explicitly share the I/O memory with the host.
>
> Make all ioremap()ed pages that are not backed by normal memory
> (IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.
>
> Since TDX memory encryption support is similar to AMD SEV architecture,
> reuse the infrastructure from AMD SEV code.
>
> Add tdx_shared_mask() interface to get the TDX guest shared bitmask.
>
> pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio). Export
> both pgprot_encrypted() and pgprot_decrypted().

How so?

# git grep pgprot_encrypted
arch/x86/include/asm/pgtable.h:#define pgprot_encrypted(prot)   __pgprot(__sme_set(pgprot_val(prot)))
arch/x86/mm/ioremap.c:          prot = pgprot_encrypted(prot);
arch/x86/mm/ioremap.c:  return encrypted_prot ? pgprot_encrypted(prot)
arch/x86/mm/mem_encrypt_amd.c:          protection_map[i] = pgprot_encrypted(protection_map[i]);
arch/x86/mm/pat/set_memory.c:           cpa.mask_clr = pgprot_encrypted(cpa.mask_clr);
arch/x86/platform/efi/quirks.c:                           pgprot_val(pgprot_encrypted(FIXMAP_PAGE_NORMAL)));
fs/proc/vmcore.c:       prot = pgprot_encrypted(prot);
include/linux/pgtable.h:#ifndef pgprot_encrypted
include/linux/pgtable.h:#define pgprot_encrypted(prot)  (prot)

I cannot find any of the above mentioned subsystems in this grep
output. Neither does this patch add any users which require those
exports.

Thanks,

        tglx
