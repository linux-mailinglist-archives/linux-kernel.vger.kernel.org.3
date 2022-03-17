Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC34DC5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiCQMqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiCQMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:46:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06859FA217
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:44:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647521093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIn0zIhA7b+Fd9t6EFv7mw9uKnRBWuqrQzy1BiPys1I=;
        b=PCgVvnWL+NhyiDEvSHgOREJVONFb7F7Ji5197BvAg1+KQkTBGRWFy5PGLMl44cMLpe7ZAw
        atNKsPM5PGRAI6zbgucxOCk3YqDh3RDn9HraN035hfyxdxkBZl3WneIo9oZU3QT7OW7JLv
        3/TLwh511QcoDbNDMjYK7rr4sOuYC+lXU9fId7nl/gDwHQOY+uEansWFM9gFi1LJQnVxhO
        TI/DRQs+Lq3Trs6lS0gKG51KbnbuC3EonKcABDAClXAg7NG/NDdixvY+iP7A9H/wn1Ei3N
        o+qT6+75xw+ZIWX0oJ6BO0ZPxVgzhtiOQHKTgp+AGv40OkjSOBXKS/PYrG66eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647521093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIn0zIhA7b+Fd9t6EFv7mw9uKnRBWuqrQzy1BiPys1I=;
        b=Ng3RYJkEj2oLQvblni5aeEkfxlKRtcBYn5X9VjKg2DRwuQPxjBmxSTGtPZtoaRkbd/IaVr
        pDUxiNR37D46FxAQ==
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
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 21/30] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
In-Reply-To: <20220316020856.24435-22-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-22-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 13:44:53 +0100
Message-ID: <87zglozr22.ffs@tglx>
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
> +#ifdef CONFIG_X86_64
> +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +{
> +	static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
> +	u8 timeout;
> +
> +	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
> +	if (physids_empty(apic_id_wakemap)) {

I had to read this condition twice.

Why not checking (!acpi_mp_wake_mailbox)? Too obvious, right?

> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> +						sizeof(*acpi_mp_wake_mailbox),
> +						MEMREMAP_WB);
> +	}
> +
> +	/*
> +	 * According to the ACPI specification r6.4, section titled
> +	 * "Multiprocessor Wakeup Structure" the mailbox-based wakeup
> +	 * mechanism cannot be used more than once for the same CPU.
> +	 * Skip wakeups if they are attempted more than once.
> +	 */
> +	if (physid_isset(apicid, apic_id_wakemap)) {
> +		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
> +		       apicid);
> +		return -EINVAL;
> +	}
> +
> +	spin_lock(&mailbox_lock);

What is this lock actually protecting? Wakeup of secondary CPUs is fully
serialized in the core code already.

Thanks,

        tglx
