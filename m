Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C874DC8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiCQOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiCQOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:34:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE140E6A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:33:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647527602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E6jSLgp6vZhfdAK44ACKMKH/9V1Jw4C3dIr67YNBl4Y=;
        b=h1gj4TK+dlGMciIVGk6QttgNkv9b5NCqSnnHjsl/P8Ksx7gqicWQpDBAS0j/9C4O/6l+Yq
        tHm3rxPd2xsI+PpCfywxJfATy9er4s9vj4HMo2J1MDMA5UkpSsUWBfDZogL+eUeTQfWVdt
        8ItfqQkzGC1TnKfqRrWORqfLlwMX1sGfEnuoa214yRzrp4kBIuEh/YgbDW6PJNjmMcEwRu
        tQL7JQUu7J+rt9Ms24K755yKp1EC6jFa46KiDUzLXhxn/A9pIftSqGJ2pgaPb8Y9y9Xdck
        BCXJ4guDKWh8PSFpPF9LhpGUpTiz/dsugWnIMrtOk5BKP8m280f5d6nNFTCcPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647527602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E6jSLgp6vZhfdAK44ACKMKH/9V1Jw4C3dIr67YNBl4Y=;
        b=rHiOw3CSkMm6jj4/trxgs2e2wjOn84lMdH8J/QuarotUapOZGSwXnf81sHHO5mu/dD/lp2
        j92dJa3+xz5SiOBA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 25/30] x86/tdx: Make pages shared in ioremap()
In-Reply-To: <20220316020856.24435-26-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-26-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 15:33:21 +0100
Message-ID: <87tubwd4y6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> In TDX guests, guest memory is protected from host access. If a guest
> performs I/O, it needs to explicitly share the I/O memory with the host.
>
> Make all ioremap()ed pages that are not backed by normal memory
> (IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.
>
> The permissions in PAGE_KERNEL_IO already work for "decrypted" memory
> on AMD SEV/SME systems.  That means that they have no need to make a
> pgprot_decrypted() call.
>
> TDX guests, on the other hand, _need_ change to PAGE_KERNEL_IO for
> "decrypted" mappings.  Add a pgprot_decrypted() for TDX.
>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
