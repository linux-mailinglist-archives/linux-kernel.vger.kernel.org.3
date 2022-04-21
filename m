Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7250A27E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389488AbiDUOc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389404AbiDUOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C66C45AD7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650551328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wygw0NEtPf4TediRWceCbgQsFgBpsCEztkqk6rmC+rU=;
        b=JQUZJdFnDoqcbGGFuvX2byUXZIF1gmuNF210UTxh8GXvWrQ4hCTy1AP+8S9at4MmSoMnLG
        45eafi+lesqAiDVMSVLxTQf1eAVBKWiNfZWWUs/NHCCEAxHyANFmtbMgEBwbzw3w5pYJB1
        vY2f7X8octXZVSvqB2/XN7S/T9oeyuU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-64_Kfo5sOx2TunFIQoaoWg-1; Thu, 21 Apr 2022 10:28:47 -0400
X-MC-Unique: 64_Kfo5sOx2TunFIQoaoWg-1
Received: by mail-io1-f71.google.com with SMTP id o9-20020a0566022e0900b00654b599b1eeso3368824iow.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wygw0NEtPf4TediRWceCbgQsFgBpsCEztkqk6rmC+rU=;
        b=EORnx9PHrIg1u3DdNL50bw1owgikWHV9ZhstAcjgEYPydJE3lCX5P+MGhMf4Q1lNIS
         y7iRZzviA1SHnUd2D6AKzcK4Th0dFeUj/Uh31/FQ1eXCEP05U7jMH7qVNBHUnWbzDjKo
         l25j6g6JP2a99nKtmUyXEe2nsXiEiAPUr9TNllAAG0eqfdA82xF/dsanRwrzB7XM46LK
         vpCJKAKHWl8tZHEXV9DBw+7tmwf9KtvUMD5pq0444qE06IR54QK2LELv6HVhRpDJ0wf8
         ZzMHlx3qzDTj/b7PBKTRIsYSzEo4pKaEyL1KyjGM3cKDeG/jRHeWgGanclwM6ae+tS9k
         WpXA==
X-Gm-Message-State: AOAM532RZBdO7NJbQ0tH4Zzs+gxWyd6DXwUs/fXCZEIhqwPRzvqYbLFB
        wzheCbipw9Yhe87EyqvRGiKkzfP+lyu16rssnqe4PS8CjTp8iTGcegUPoMs+vXnnV3gitI2s1oZ
        +3H93f23BcUR75Bk2uL2i2OUr
X-Received: by 2002:a02:7058:0:b0:326:70d9:5917 with SMTP id f85-20020a027058000000b0032670d95917mr12003848jac.254.1650551326246;
        Thu, 21 Apr 2022 07:28:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa92KTjTpe4VCY6SMwA1NEdHcOfaIh8J/D2S1w9pa/SeRX6hhRfCCy3Mvu+V31RvSiJqqOUA==
X-Received: by 2002:a02:7058:0:b0:326:70d9:5917 with SMTP id f85-20020a027058000000b0032670d95917mr12003827jac.254.1650551326023;
        Thu, 21 Apr 2022 07:28:46 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id y10-20020a92c74a000000b002caca951762sm12219334ilp.19.2022.04.21.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:28:45 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:28:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        apopple@nvidia.com, surenb@google.com, minchan@kernel.org,
        sfr@canb.auug.org.au, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/madvise: free hwpoison and swapin error entry
 in madvise_free_pte_range
Message-ID: <YmFqHBMtNKqib8lt@xz-m1.local>
References: <20220421125348.62483-1-linmiaohe@huawei.com>
 <20220421125348.62483-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421125348.62483-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:53:48PM +0800, Miaohe Lin wrote:
> Once the MADV_FREE operation has succeeded, callers can expect they might
> get zero-fill pages if accessing the memory again. Therefore it should be
> safe to delete the hwpoison entry and swapin error entry. There is no
> reason to kill the process if it has called MADV_FREE on the range.
> 
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/madvise.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4d6592488b51..5f4537511532 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -624,11 +624,14 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  			swp_entry_t entry;
>  
>  			entry = pte_to_swp_entry(ptent);
> -			if (non_swap_entry(entry))
> -				continue;
> -			nr_swap--;
> -			free_swap_and_cache(entry);
> -			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);

Nitpick: IMHO you don't need to invert non_swap_entry() then it'll generate
a smaller diff, just add the new code above "continue".

> +			if (!non_swap_entry(entry)) {
> +				nr_swap--;
> +				free_swap_and_cache(entry);
> +				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> +			} else if (is_hwpoison_entry(entry) ||
> +				   is_swapin_error_entry(entry)) {
> +				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);

Since it's been discussed and you're reposting a new version anyway, why
not start with either reusing hwpoison or pte markers?  Or do you think it
should be for future to drop the new swap entry again?

Thanks,

-- 
Peter Xu

