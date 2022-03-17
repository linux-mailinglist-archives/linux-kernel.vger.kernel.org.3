Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF44DC9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiCQPZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiCQPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:25:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF121F6358
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:23:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647530635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9cEPJf6Rvg0hdWsT85pmNe1Smxcfs3s+Osq5CFFhGk=;
        b=4IB31NtfbKNAEWvOfuPBYFecHq31MlrUczQENPaUn0X2IBaDcL0eJg2BVKA3PYOyq9TRJx
        A5GVmdIoU6MfjnMQ8ep1DRB76bzazJ8GhV1VA7aR/SMcZttaoMTP7gd+dinNoYmkveGMHA
        6fF9yt/Hkqtym4cLKSxzm27bxxsUT9V3yiifQ180avo/gRzh7aDSZeilKvBDAqi9BjXdcB
        ZnO37VN4d1qh0KqYnh20BWLKlFTp9GOalAkAoLneFxayUe4uMDCX0ru/PGUI69OhiwARif
        RiKUtqUub2xoZ339DTFOdluWUb61Qzlrw0zFcbdk5LUeO+lFniP+lLgCUCFvyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647530635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9cEPJf6Rvg0hdWsT85pmNe1Smxcfs3s+Osq5CFFhGk=;
        b=RpbKIv5rc3Bj3skSwXX4wyf5z3SIG9JisfHyWFnKO52OVezA2RFiG4vioLQR/SevwESZRP
        tOCTfiu3ZJuHwPDw==
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
Subject: Re: [PATCHv6 29/30] ACPICA: Avoid cache flush inside virtual machines
In-Reply-To: <20220316020856.24435-30-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-30-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 16:23:55 +0100
Message-ID: <87ilscd2lw.ffs@tglx>
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

> While running inside virtual machine, the kernel can bypass cache
> flushing. Changing sleep state in a virtual machine doesn't affect the
> host system sleep state and cannot lead to data loss.
>
> Before entering sleep states, the ACPI code flushes caches to prevent
> data loss using the WBINVD instruction.  This mechanism is required on
> bare metal.
>
> But, any use WBINVD inside of a guest is worthless.  Changing sleep
> state in a virtual machine doesn't affect the host system sleep state
> and cannot lead to data loss, so most hypervisors simply ignore it.
> Despite this, the ACPI code calls WBINVD unconditionally anyway.
> It's useless, but also normally harmless.
>
> In TDX guests, though, WBINVD stops being harmless; it triggers a
> virtualization exception (#VE).  If the ACPI cache-flushing WBINVD
> were left in place, TDX guests would need handling to recover from
> the exception.
>
> Avoid using WBINVD whenever running under a hypervisor.  This both
> removes the useless WBINVDs and saves TDX from implementing WBINVD
> handling.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
