Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3934D6AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiCKW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiCKW4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:56:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A783A707
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:46:00 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id q13so8800529plk.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3sE0hsTRFQr0UR7ZgIkijg0A6cF4rdyBGwexFxGWak0=;
        b=d4j1wnZLFeuAP6pe6UmjizutXxjN/90i+itzVjXCw2tnraFMFGpaudB2AOr/xydZvO
         s5MLqtnNGw19UEgDSOITvnGk3dn/z82IX0y467iJceT6Qzxe5ppnqcnfZaS6Fi5AMK7e
         qxtcOicC/1HajhvzsoBHIS5ptoXtfJL+DhrK2uxfin5HHPIz9UFQ2AOkoeT5Lge1BG/s
         1WQq3Me/i4z8VRVIGKKt4uUgkHkHU/QTQSWDJF4zSbbeFZhD2+OopSRlkP7lZzhpB6PH
         gpMQjxrJNV1ntUKRjymq9bgB+LouxmRjJtuEkwwmPldZuPoDWy/jgvTetw8M7QFK6tqG
         gg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3sE0hsTRFQr0UR7ZgIkijg0A6cF4rdyBGwexFxGWak0=;
        b=n3JU70lLVKmQ8CH3tVLZGZQDF8+0bXa8wOOCUiTrxvlEX9hb18RNE4k4LPwspiOQTz
         kr0y6x2aVP6OvphIFItQu0AafzUvItVge2/O8xgZA1zQ5vMeKdRUL3v39VJqTIFeO4sp
         KzXuJ/kSF/wUfkzigT+ECH4WYFy7OmcvwSWF8hqAU64OGDRmLhzcVwzCUqa3LGgcBe6U
         y2/unbEjauF1jcPlZzV9ruG3BLDyyUCC5aVk57lhoRP8/zUHlpmeJ3LoQgkDpQ8jB2Ku
         y9g/uuqYJ1r6FuVuNMJNPKbzZCZ0CyXoGvLX2ms4wjamhBRQtCFHvRxoJDibWFvbaX6u
         JFIA==
X-Gm-Message-State: AOAM532SH+fso3QmpHiCl/vICadEADAoXSBwxOXd/5ElL0y2yFg3bqOV
        d4wS1cwbur+gaCjrRr40WjY=
X-Google-Smtp-Source: ABdhPJylAwO6QX8/w4gOqjI6xnaSrwUgdOE0iIVt39rYKpjRjDT6cNHot8whX/kC1AnL3Q9pggcJvg==
X-Received: by 2002:a17:90b:4f44:b0:1bf:61b2:4560 with SMTP id pj4-20020a17090b4f4400b001bf61b24560mr23619520pjb.245.1647038759513;
        Fri, 11 Mar 2022 14:45:59 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j13-20020a63594d000000b003639cf2f9c7sm9422236pgm.71.2022.03.11.14.45.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2022 14:45:59 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RESEND PATCH v3 4/5] mm/mprotect: do not flush on permission
 promotion
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220311190749.338281-5-namit@vmware.com>
Date:   Fri, 11 Mar 2022 14:45:57 -0800
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0FFB7FA7-4F08-47EB-8AAE-400867E96DE4@gmail.com>
References: <20220311190749.338281-1-namit@vmware.com>
 <20220311190749.338281-5-namit@vmware.com>
To:     linux-mm@kvack.org
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 11, 2022, at 11:07 AM, Nadav Amit <nadav.amit@gmail.com> wrote:
> 
> From: Nadav Amit <namit@vmware.com>
> 
> Currently, using mprotect() to unprotect a memory region or uffd to
> unprotect a memory region causes a TLB flush. At least on x86, as
> protection is promoted, no TLB flush is needed.
> 
> Add an arch-specific pte_may_need_flush() which tells whether a TLB
> flush is needed based on the old PTE and the new one. Implement an x86
> pte_may_need_flush().
> 
> For x86, besides the simple logic that PTE protection promotion or
> changes of software bits does require a flush, also add logic that
> considers the dirty-bit. If the dirty-bit is clear and write-protect is
> set, no TLB flush is needed, as x86 updates the dirty-bit atomically
> on write, and if the bit is clear, the PTE is reread.
> 
> 

[snip]

> + */
> +static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
> +{
> +	/* !PRESENT -> * ; no need for flush */
> +	if (!pte_present(oldpte))
> +		return false;
> +
> +	/* PRESENT -> !PRESENT ; needs flush */
> +	if (!pte_present(newpte))
> +		return true;
> +
> +	/* PFN changed ; needs flush */
> +	if (pte_pfn(oldpte) != pte_pfn(newpte))
> +		return true;
> +
> +	return pte_flags_need_flush(pte_flags(oldpte), pte_flags(newpte),
> +				    _PAGE_ACCESSED);
> +}


Looking again at this patch, I think the PRESENT -> !PRESENT is
not needed:

1. It might trigger unnecessary flushes for PROT_NONE (or NUMA)
2. Real PRESENT -> !PRESENT is already checked by
   pte_flags_need_flush().


Let me know if I am missing something. Otherwise I will change it
for v4.

