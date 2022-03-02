Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5514C9F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiCBIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbiCBIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:23:43 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC14BB93
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:23:00 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d07ae0b1c0so8485147b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzapgAUyKoJq0tJStFGL7TnQDA9QwFfn3d0fRWN05EI=;
        b=Mb6EF1IqUQplrdckkYJaWOPWFlbpamBSXlnWHkeFzL5xVU8l9Af4VjCCYjJ1rXGtHF
         ktCj77UQ8uZK6tLF105LmuwST4YlAMKLP8Vu2XVKUtyhpTap4PpVmLWKOPNdCBp4WNrb
         nIKcJ2aD+N9+yZAOMdtrZUB8U5akWovR4/vxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzapgAUyKoJq0tJStFGL7TnQDA9QwFfn3d0fRWN05EI=;
        b=clU6mxxhm5/uHWYuRaqTZ3UD3yvHBC3Sqg6nKMdZK26OBoVBrAX/K/n5ITiZnVlPcG
         b6jhM5kuis8NwPPnaCRHW7I6SlcV2nTYDcT67wUHNqTR7utT+rM133koCQM1Co1r6Yf8
         VrbgAdPQH5SpNAN3kSVT4mmF6zxfZHs6T2WU5AWODdmtEtwCwmD/NXTpLJ4+G0GwNhLY
         SLbkWYiU7OleD/24JrgqWSFSdNUoULrjI/qKtvcEIltflSleLESEkwHRw037r3PbsiGo
         JynHhupIQLX1DxSvbfk2uZiRzv2pMiJdw0+VmHO6iQ3/4qvYGIutWC8EsgdPwSeG6c/C
         ejfQ==
X-Gm-Message-State: AOAM533I6LKM0NnlM8nSt5y3kBTGQ6F8ZS351ZGEsYqZ6VE/PF5qQl5c
        dKceAnceW0Ytamh9u3zhZcG7OchXZfcHfAlwp+Vzmg==
X-Google-Smtp-Source: ABdhPJzeeVdz4NAS+ovirSZ++TOJF6ZtWiQgMOOEOXtVPqJgdpLR0WgLjmNaqBKPWjmOCGSRyv9eGGJMetKEcbJ704o=
X-Received: by 2002:a81:6e44:0:b0:2d0:b675:a0 with SMTP id j65-20020a816e44000000b002d0b67500a0mr28372775ywc.352.1646209379370;
 Wed, 02 Mar 2022 00:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-5-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-5-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 09:22:48 +0100
Message-ID: <CAM4kBB+kHtNNhvHrQJ8JQyDwf02nMGq_vmyPfYaQwrRn0neo_A@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm/z3fold: remove unneeded page_mapcount_reset and ClearPagePrivate
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
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

On Sat, Feb 19, 2022 at 10:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Page->page_type and PagePrivate are not used in z3fold. We should remove
> these confusing unneeded operations. The z3fold do these here is due to
> referring to zsmalloc's migration code which does need these operations.

Absolutely, thanks for pointing this out.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>

> ---
>  mm/z3fold.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index eb89271aea83..2f848ea45b4d 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -420,7 +420,6 @@ static void free_z3fold_page(struct page *page, bool headless)
>                 __ClearPageMovable(page);
>                 unlock_page(page);
>         }
> -       ClearPagePrivate(page);
>         __free_page(page);
>  }
>
> @@ -1635,7 +1634,6 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>         INIT_LIST_HEAD(&new_zhdr->buddy);
>         new_mapping = page_mapping(page);
>         __ClearPageMovable(page);
> -       ClearPagePrivate(page);
>
>         get_page(newpage);
>         z3fold_page_lock(new_zhdr);
> @@ -1655,7 +1653,6 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>
>         queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
>
> -       page_mapcount_reset(page);
>         clear_bit(PAGE_CLAIMED, &page->private);
>         put_page(page);
>         return 0;
> --
> 2.23.0
>
