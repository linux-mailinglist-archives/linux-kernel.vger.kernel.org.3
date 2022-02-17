Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761854B9F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiBQMAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:00:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiBQMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:00:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E829294126
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:00:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7DD113E;
        Thu, 17 Feb 2022 04:00:14 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65E833F66F;
        Thu, 17 Feb 2022 04:00:12 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:00:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm] kasan: print virtual mapping info in reports
Message-ID: <Yg44yQJ9tQMgmiZq@lakrids>
References: <5b120f7cadcc0e0d8d5f41fd0cff35981b3f7f3a.1645038022.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b120f7cadcc0e0d8d5f41fd0cff35981b3f7f3a.1645038022.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 08:01:37PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Print virtual mapping range and its creator in reports affecting virtual
> mappings.
> 
> Also get physical page pointer for such mappings, so page information
> gets printed as well.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> ---
> 
> Note: no need to merge this patch into any of the KASAN vmalloc patches
> that are already in mm, better to keep it separate.
> ---
>  mm/kasan/report.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 137c2c0b09db..8002fb3c417d 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -260,8 +260,18 @@ static void print_address_description(void *addr, u8 tag)
>  		pr_err(" %pS\n", addr);
>  	}
>  
> +	if (is_vmalloc_addr(addr)) {
> +		struct vm_struct *va = find_vm_area(addr);
> +
> +		pr_err("The buggy address belongs to the virtual mapping at\n"
> +		       " [%px, %px) created by:\n"
> +		       " %pS\n", va->addr, va->addr + va->size, va->caller);

The return value of find_vm_area() needs a NULL check here;
is_vmalloc_addr(addr) just checks that `addr` is within the vmalloc VA
range, and doesn't guarantee that there is a vmap_area associated with
that `addr`.

Without the NULL-check, we'll blow up on the `va->addr` dereference and
will fail to make the report, which would be unfortunate.

Thanks,
Mark.

> +
> +		page = vmalloc_to_page(page);
> +	}
> +
>  	if (page) {
> -		pr_err("The buggy address belongs to the page:\n");
> +		pr_err("The buggy address belongs to the physical page:\n");
>  		dump_page(page, "kasan: bad access detected");
>  	}
>  
> -- 
> 2.25.1
> 
