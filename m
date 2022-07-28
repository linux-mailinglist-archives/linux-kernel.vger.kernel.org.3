Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267A584549
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiG1SEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiG1SES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:04:18 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2840F74CDD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:04:17 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e69so1958838iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/dJeOyrY32LeD/c96pF29k6qqscTBj4IUisD45XkhKs=;
        b=sfv2k4Xm/tn87w1RZLO8FOjzLhbfRZ0VkvQC5BbL/cU3dSAR0fGGSWuGDy7PS4Cf2f
         efiIq/KFORaO2gEA48T7SvGYCKCscEVhfGRFs5O4YJzqED4oPrEa3lEO9bs5pK6+gpdg
         r9PAOeTZ9Khc2/SXLRmw9PIEB1q0UZzhbK+g9j9mPKWD9YuYhezt5UvTlpKSEHvzBf+w
         IRxpsZvc/FQmtQcaQCGgqr0cSBCuvPBole5a7rDbCFO4/qdxRrQmiADCJ1lvC5MA3ykg
         dKve/rltNo6BZvZ6OgzUKyf9YHcI75r9uGfoA1vKeQst05fk23opemZQsmStdWHggfDK
         3g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/dJeOyrY32LeD/c96pF29k6qqscTBj4IUisD45XkhKs=;
        b=WTkpnwgUHmRGpDQefaNSlym7kJpDdWN+i9dTaBt8/hZkhRmn+zhyS96eWSVnQvL9wg
         vb4gtMqwHNtKg2pkaIo9d7cmNrQCu9kI3cPTCPLVoHHDm4csYtcMKJ2+ZRM+sRKbLcTI
         kR80S9+xzjHrC5thrKnf3Ya6ImXsSbn6BBdruC5DnN/1bjmIJrqtbkkvt/H8m9nryGAM
         bwMnGbJbcemYA11oaNsM77GsNidWcLzhLLd6ZBVeheZsF+/IWxLhx7UXT9MmJxvCSb8K
         iMdkbIeQ7KosEDscqdKxRLIMeNatCuOYMzHbHd5Un301ZmgxI/rsKkgvUkDoURmOai3z
         eJ2A==
X-Gm-Message-State: AJIora/qvDvO/+yAfLRebfCXNc7XN9z858xpv/BVYeoaJuvLQ3y3Rd8+
        rRwaMjGMow5iY5SEWbFgFTcOJgRwI17d/sCyVI2264o26Us=
X-Google-Smtp-Source: AGRyM1vQouBSbAXh5O9Co4to1ZBdIZlO3QBZ2cX2OKYPjdi49u5yXuFGSy0ITyOAjSOdTKXHvq2mIvJKxK/+OdyCBn8=
X-Received: by 2002:a02:854b:0:b0:341:7894:6c50 with SMTP id
 g69-20020a02854b000000b0034178946c50mr6545jai.234.1659031456487; Thu, 28 Jul
 2022 11:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220728121949.20985-1-linmiaohe@huawei.com> <20220728121949.20985-7-linmiaohe@huawei.com>
In-Reply-To: <20220728121949.20985-7-linmiaohe@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 28 Jul 2022 11:04:05 -0700
Message-ID: <CAHS8izPxm=77DHd_2=_oXboGp8qGYa=W+dwT5ktusqLpopaA=A@mail.gmail.com>
Subject: Re: [PATCH 6/6] hugetlb_cgroup: use helper for_each_hstate and hstate_index
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 5:20 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Use helper for_each_hstate and hstate_index to iterate the hstate and get
> the hstate index. Minor readability improvement.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb_cgroup.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 13ec091385af..8f20082df4c8 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -74,11 +74,11 @@ parent_hugetlb_cgroup(struct hugetlb_cgroup *h_cg)
>
>  static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
>  {
> -       int idx;
> +       struct hstate *h;
>
> -       for (idx = 0; idx < hugetlb_max_hstate; idx++) {
> +       for_each_hstate(h) {
>                 if (page_counter_read(
> -                               hugetlb_cgroup_counter_from_cgroup(h_cg, idx)))
> +                   hugetlb_cgroup_counter_from_cgroup(h_cg, hstate_index(h))))
>                         return true;
>         }
>         return false;
> @@ -224,17 +224,14 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
>         struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);
>         struct hstate *h;
>         struct page *page;
> -       int idx;
>
>         do {
> -               idx = 0;
>                 for_each_hstate(h) {
>                         spin_lock_irq(&hugetlb_lock);
>                         list_for_each_entry(page, &h->hugepage_activelist, lru)
> -                               hugetlb_cgroup_move_parent(idx, h_cg, page);
> +                               hugetlb_cgroup_move_parent(hstate_index(h), h_cg, page);
>
>                         spin_unlock_irq(&hugetlb_lock);
> -                       idx++;
>                 }
>                 cond_resched();
>         } while (hugetlb_cgroup_have_usage(h_cg));
> --
> 2.23.0
>
