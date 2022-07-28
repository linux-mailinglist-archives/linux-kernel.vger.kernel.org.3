Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5EF584525
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiG1Rok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiG1Rod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:44:33 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC29C747BA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:44:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id c185so1910515iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=euGCprHtfgeGD2lqEFLlu8boLeebQ0OwrWscZfMj3tw=;
        b=CGEsgy3vKfpdFOml8CXiObDyA3GwpotxCUspR08fALLfecVo+Kik7YFCYg6JG7GXhi
         PsDdbkkkBotpd3/JtocEn7l5WP3tMF6M0c0N6E8tDg6qqmYbme/B5GNAKUnQRgFRaESp
         jnVi6uUVr7qum/bGpT0hh3IPubgeTh2wsMLH9gM1W1Q+7dvqwDZ+4DnhLphHfiMxdWZR
         DL35hqWIl4KB91cqIpc6l44yBuradKIApi5uQnjY9cTMx9/NW4TBxT774xdoMsRzUNdX
         Ezgx3N2l71mHpsgC30sjhjoYfYGcNB0nu5RJvI2DD97/rDrBOuQ4lVzz6VRV61W8PC4K
         jX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=euGCprHtfgeGD2lqEFLlu8boLeebQ0OwrWscZfMj3tw=;
        b=G7zSvl+P3nkv6ojiUBWuSMu3wMZwWbfgyUML9X3gzHwVMAryGEoY/c16sgw30ZcwW1
         XKZ/50B6A3c+hF/CG0JwbDegmPaRyxkfy/m1eDo/I72rrzbxnjVZp8euP6V6UpEmdM7y
         eJ0tGgpe9NVmPGZ3VQ1/EjV57Oeeag5Mg9BEzpDz2xoVyWtYdozs/Bz+4Z8RD9zF4eMt
         nC2itctJiz4GrzsVyP94Jycgd+JCJcqJMiGBavQFp5qKnQPXFL0hkdBJAK9DeGKL6Uwd
         SmzFGsjIM7JeZ+SekoeAlUsCJF0uw7XrTD8POGyWud8Rl+6zvxdLQ8FFTgMjSdlOg6RL
         0h8w==
X-Gm-Message-State: AJIora+IamMErJ/YBy2wGivbzY5EeWaxA/lDqZB6JpIVWQLi3dyvaNab
        cVKfMq7Y8AcEw+QveTKgPiK5HwvVVbEm8Zlyn7Y++g==
X-Google-Smtp-Source: AGRyM1vBKjdqTQANcA4eGkbC4sZ++qu8EIsrbXnKuigxtdN/x9GAVHp9nfatADvkOirreJuOJJq2sCdcDDcdzfaobrs=
X-Received: by 2002:a05:6602:29c8:b0:678:7c44:c2fd with SMTP id
 z8-20020a05660229c800b006787c44c2fdmr9514661ioq.89.1659030271947; Thu, 28 Jul
 2022 10:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220728121949.20985-1-linmiaohe@huawei.com> <20220728121949.20985-2-linmiaohe@huawei.com>
In-Reply-To: <20220728121949.20985-2-linmiaohe@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 28 Jul 2022 10:44:20 -0700
Message-ID: <CAHS8izOgtAJN1cd5+FNT-TMk22xkaPn-doJZ4M8+f5wP5OehLw@mail.gmail.com>
Subject: Re: [PATCH 1/6] hugetlb_cgroup: remove unneeded nr_pages > 0 check
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
> When code reaches here, nr_pages must be > 0. Remove unneeded nr_pages > 0
> check to simplify the code.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks Miaohe,

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index c86691c431fd..d16eb00c947d 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -442,7 +442,7 @@ void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>         if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
>                 return;
>
> -       if (rg->reservation_counter && resv->pages_per_hpage && nr_pages > 0 &&
> +       if (rg->reservation_counter && resv->pages_per_hpage &&
>             !resv->reservation_counter) {
>                 page_counter_uncharge(rg->reservation_counter,
>                                       nr_pages * resv->pages_per_hpage);
> --
> 2.23.0
>
