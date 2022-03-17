Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2864DC5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiCQMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiCQMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:33:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E921EB81D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:32:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647520323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZAss5PpoQiQl8HGFKzo/rtXi5/xki0U6t8UCkJThoU=;
        b=bufAGOl4KVt+u5vkreXiJ8K/j7zGbV9vg3uxcNXPq7YRa/zSjoKLnqx06aOlaIiE1/HWPf
        3NHJUn0ltwUxPkhXaCWNMzukQlsTb7WtPExKcZ8alpYQKthWQNCNEZ2uBphfBCi98JJezH
        E/9uJMxqVjTnKpmBzMdAs97jZ9BXLjOkSYvKkZCGm/crA00baj6oClLgc0ZV5Dyg9xO45y
        SS79TELRVWAaLo4o/G63w77IO4bF0JZWgnPm6MPTnwqvJINqQrVMvAUTxzqiXEyS8rge/e
        pRXXUE9zsI+incwkl5MpEruccosUHv8k09jooCDZlXbWyTNpfNiNBfcu4L1MtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647520323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZAss5PpoQiQl8HGFKzo/rtXi5/xki0U6t8UCkJThoU=;
        b=jcnMCvvQ6p+YHLLqBJO8lyNmyPqX8lHzqPOxNMkDiBO+n9YF+qKJVb8RhzMs3EscPDUfd4
        vbSzpOLlyxCw6eBA==
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 20/30] x86/boot: Add a trampoline for booting APs via
 firmware handoff
In-Reply-To: <20220316020856.24435-21-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-21-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 13:32:03 +0100
Message-ID: <8735jg220s.ffs@tglx>
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
> There is no TDX-specific detection for this new boot method. The kernel
> will rely on it as the sole boot method whenever the new ACPI structure
> is present.
>
> The ACPI table parser for the MADT multiprocessor wake up structure and
> the wakeup method that uses this structure will be added by the following
> patch in this series.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
