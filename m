Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2475534FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347484AbiEZNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbiEZNR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:17:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB9CD02A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:17:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ck4so2897823ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Tums9sSBFm64JACZICEeaJP4n2qB4OZ4M0MNbuB31s=;
        b=F04feQsX0xtaTMBBAIJ0ZM+soGiLto1TlYo8OhYxfKtXyZTXTedLY95EAHuqpAQ2Rw
         vhGMZLsQ0F1Xm8sCodqH/nso/UcewPDGeJPOFABGTeR2sloWV0vVUaiys3f89CFFwhJC
         p8yE4d5bu5QX+rSvVTcsbQLgksjy/MZlCeJaPrpFmZMCs1Muzb1smSiB9AMbSuJQJ1ut
         K+eyrNWUC79mn8xF3N5bNPxOBF9ucs4YO3II8PQESLvWiB3303TXV6YMPuAaQA/lKzl1
         L1vRRV+dKBtm8nPyGLuSBEO0MrJ/MjIHWhLUO8CfCiKO91o0XgLpoYaSo8W3MnkbAmmc
         JwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Tums9sSBFm64JACZICEeaJP4n2qB4OZ4M0MNbuB31s=;
        b=a4nOzQVecLKWrqowC2HPjEWAuB7n6Pej8z1ItbnsDuKdhadbnCUk1bw/AMQBJRGCEY
         FOfotO3R0p1/dtsP6urydJzFHobumSzeZDb82YUj244sY8F1lVwURFEBd8qxGQGyoAVr
         En1awnAAnLLeVVJcY8L5hrp4oFDqm0Z4C0Z4fOu4DSW51o1LLhPDOIm0X2lnhVGqj32X
         wXSYaZY3L8+ll1Akv8VKo3eLboh1znEeOtMNaaVqVIJU5ekS2h8r5JZD4df3vDmF79q/
         V2vN7j6Sd7S9erNrKerVKDiC4J51A7/GnsYLX9O9mXsIocu0jyajU+MJ/4e2xrwIH8aG
         /wbQ==
X-Gm-Message-State: AOAM533mIYLxq6pImfNUB8GVqaQhYwfORG/Pi15wLcQ0haJ57X0mz0ZU
        yUFpBomjHZuJ2eYR4mcRBBmEW6lIucpdnNz5ssFlEA==
X-Google-Smtp-Source: ABdhPJwt2DDvHgTg3x1ZOOEX1n+YPivbXaH4Zo/aUAeNSS2EIe9RQvn5zW/kTp+wlypm6G+UT4rkqjenFUrrI+C6Cwc=
X-Received: by 2002:a17:907:86a9:b0:6ff:45d:c05b with SMTP id
 qa41-20020a17090786a900b006ff045dc05bmr12015950ejc.492.1653571072192; Thu, 26
 May 2022 06:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220526113350.30806-1-linmiaohe@huawei.com>
In-Reply-To: <20220526113350.30806-1-linmiaohe@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 26 May 2022 09:17:14 -0400
Message-ID: <CA+CK2bARAVPq6N_V-Wjfzgu9eHPw4eX8DPm2xn6sjbZF14_0Ng@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 7:33 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> ptep is unmapped too early, so ptep will be accessed while it's unmapped.
> Fix it by deferring pte_unmap() until page table checking is done.

I would re-word this as a cleanup. While pte_unmap() is currently
unused, it is still better to call it after we are done with *ptep in
case of future changes in other architectures.

>
> Fixes: 80110bbfbba6 ("mm/page_table_check: check entries at pmd levels")

This is more a clean-up, there is no existing bug, so no need to
backport to stable. Please remove the above.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

With the above changes:
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>


> ---
>  mm/page_table_check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 3692bea2ea2c..971c3129b0e3 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -234,11 +234,11 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
>                 pte_t *ptep = pte_offset_map(&pmd, addr);
>                 unsigned long i;
>
> -               pte_unmap(ptep);
>                 for (i = 0; i < PTRS_PER_PTE; i++) {
>                         __page_table_check_pte_clear(mm, addr, *ptep);
>                         addr += PAGE_SIZE;
>                         ptep++;
>                 }
> +               pte_unmap(ptep);
>         }
>  }
> --
> 2.23.0
>
