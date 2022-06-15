Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71D54BEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiFOAUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiFOAT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:19:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0542ED1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:19:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so2228850pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oMov4wFWvNmWJaOJdvhmv3NfKMweecxQ+mO9ged/+xM=;
        b=Po/Sow6vk85gTDqn2BkFUfKSFu9i/WK5FbqzzJtopiwGsTUiOPMMWut5wh1VbNTR6+
         8tMtGQN8DxusxWrwcnQmztQFN4R5MWX26AX1DRHspXSYNgOZ4xIvvkewPWD5Kuhx61FE
         dG3N/rcg4/4kMGvfh7NjfX067b5aZM6QxdS3hnkVwOY86/5659QfOyWsXfPC90WkWl1A
         X69jBPvalRWxnaTxB4TPLh1wHx1q/BCv+CuaT5udBVOsOHTYnnDMJd24O+tfqGQGIk+F
         Wk62pr4rcxtHzXRj6lTeRtrQ5Kcpg0jck8+MiMLEmoWehxkvNUt7GZ0ZULSDmxJ5asf6
         HSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMov4wFWvNmWJaOJdvhmv3NfKMweecxQ+mO9ged/+xM=;
        b=34nDwyN0lp+xRPbr9/K0gs86SwlJ4+grPmaCKq5wL5Krar9yLw0bgODNb6CMEDIhKb
         jol8pmzrj+LMXJI71fRCCX9anXeHBRmIpnIOZXjE70Sbr8Tw/Ial1xtn0i1RlRYg/T7U
         LOc2OnZRHL6mBo3hh8Tan5SlxbAYcbtyjdMI1abyk6cRqv6mq7/OhWyXS2L+OQFEhOpW
         P85DOk5W7fv1iln/P0Bs0nrtvyrhZf9wrAyX0uKCqvB9sMjGHkjEctcaxlqqRtRBYkfR
         5dL2CooavJNr5O9eyyyjqyr/hchekaB4YfjBX0rGuTyS5xAGc8uxShGh12xsqZKgqdyt
         AkYw==
X-Gm-Message-State: AJIora/d6WRrrRmw+7DifPp7uptFPW+UkSDCteFiIxA7y6U6unDld6gb
        ebh0VbgoNwLwm6UzMeDbAtB0Ww==
X-Google-Smtp-Source: AGRyM1v7s+R8tc6lXddRMbpNAieBv3aBiJ0242s3yA/5umhDQ+FLKPKWC0n6kd7x9btBboHypDTo5Q==
X-Received: by 2002:a17:903:1104:b0:168:d336:cd1e with SMTP id n4-20020a170903110400b00168d336cd1emr6732257plh.72.1655252396220;
        Tue, 14 Jun 2022 17:19:56 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id f4-20020a62db04000000b005184fe6cc99sm8195319pfg.29.2022.06.14.17.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:19:55 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:19:51 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm/khugepaged: remove unneeded return value of
 khugepaged_add_pte_mapped_thp()
Message-ID: <Yqklp74e1shs94bM@google.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-7-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611084731.55155-7-linmiaohe@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 16:47, Miaohe Lin wrote:
> The return value of khugepaged_add_pte_mapped_thp() is always 0 and also
> ignored. Remove it to clean up the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/khugepaged.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 142e26e4bdbf..ee0a719c8be9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1372,7 +1372,7 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
>   * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
>   * khugepaged should try to collapse the page table.
>   */
> -static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> +static void khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>  					 unsigned long addr)

Since this is a cleanup, should keep the second param aligned with opening
bracket to satisfy checkpatch.

Otherwise can add Reviewed-by: Zach O'Keefe <zokeefe@google.com>

>  {
>  	struct mm_slot *mm_slot;
> @@ -1384,7 +1384,6 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>  	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
>  		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
>  	spin_unlock(&khugepaged_mm_lock);
> -	return 0;
>  }
>  
>  static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
> -- 
> 2.23.0
> 
> 
