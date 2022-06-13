Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466AA549B78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbiFMS1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiFMS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:27:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B051FBF5D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:42:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7F48F1F37C;
        Mon, 13 Jun 2022 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655131378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UHKdjPy6Bns5JU9HOJ8DtOlOS3bAJA+b5m8rgKgBio=;
        b=VlIj+b5wp6wNoC8k9sphH8CkQ8KHHJSXYaUqGAzVkngoAqegTWfJcffEGDokC6INtsEddy
        g7c+noQRC5WXz1xD5pkZ1IAIoh7KDqK6zk5dz52DVVnWQR3h7fbgrvoQCouktpkVupf6K/
        iMzWP6doIajR/FOTbIl5cb9dQcsmADA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE8B22C141;
        Mon, 13 Jun 2022 14:42:57 +0000 (UTC)
Date:   Mon, 13 Jun 2022 16:42:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <YqdM8ZIi0/35IhzF@dhcp22.suse.cz>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-06-22 17:35:25, Kirill A. Shutemov wrote:
[...]
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 1962008fe743..93c8eba1a66d 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -742,6 +742,32 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
>  }
>  #endif
>  
> +static int prctl_enable_tagged_addr(unsigned long nr_bits)
> +{
> +	struct mm_struct *mm = current->mm;
> +
> +	/* Already enabled? */
> +	if (mm->context.lam_cr3_mask)
> +		return -EBUSY;
> +
> +	/* LAM has to be enabled before spawning threads */
> +	if (get_nr_threads(current) > 1)
> +		return -EBUSY;

This will not be sufficient in general. You can have mm shared with a
process without CLONE_THREAD. So you would also need to check also
MMF_MULTIPROCESS. But I do remember that general get_nr_threads is quite
tricky to use properly. Make sure to CC Oleg Nesterov for more details.

Also how does this work when the mm is shared with a kernel thread?

> +
> +	if (!nr_bits) {
> +		return -EINVAL;
> +	} else if (nr_bits <= 6) {
> +		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
> +		mm->context.untag_mask =  ~GENMASK(62, 57);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	/* Update CR3 to get LAM active */
> +	switch_mm(current->mm, current->mm, current);
> +	return 0;
> +}

-- 
Michal Hocko
SUSE Labs
