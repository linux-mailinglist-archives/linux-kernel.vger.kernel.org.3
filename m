Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3C4C9F81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiCBIlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiCBIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:41:43 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EFCB91EA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:41:01 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d07c4a0d06so8536737b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwMioHCl9Ph8eWOImmniTuBw63TpPfziFubOm/sEXr8=;
        b=gEaPbwXdXoBPUhBU1qYUb+mWBtCc1FFu9FTQhyaHcYakYRSYnscz5mDrIPWjDqQlBX
         qcS28j00iaRWfwkxxuzxbhB2C3RZg5BGJsCEjj+Wcn8tyCPhENJ2M1eMXEvzmdduAXNC
         iS1rrj3qFEcIRpuTMiaqr46KkdiOoVHJcL1VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwMioHCl9Ph8eWOImmniTuBw63TpPfziFubOm/sEXr8=;
        b=GS9vS/vVpkwbbQVdEhZMQKthdDcIV4Om1cQDCy7CYdOyKRrQRPhOi9S3LSctLXNnVW
         0ey2naQ2zrcThBih7MwXPwXS8ciP6kGfFwDK3ltCdYNjC17aBoo7jJaXi3bP9XbW9/4I
         bC0aVCHyQuyZetlxOrzRq2dZykGq414pD2gC6iUDXtCFQp903FgJR3G2u6Qt6I9MSIPa
         Pp3ZVjenaWyy5NZDKY9Cr+CnJnNRLbUwkiLll10EOwWWBQOkolYtVvDQYSoIq+F3VR4k
         v18imgET9t5+NwO+GBdL/fs8UTViAvaIxVzu28qqLat6XruJ6bkcE26iTPsNmdj0OHb6
         VDmA==
X-Gm-Message-State: AOAM533U5lDQW8HJstuti7ZJYrsml3bVeSBp/x5ZUE1ltbD0ZM1oPVYj
        OEvYid1kn8An2ubH8+UlGsfYGJbq8sCveNIoTB5uEIu7ku0=
X-Google-Smtp-Source: ABdhPJw91B6/5J4Hf19SaEnixGP84dBaoO6UieG1QDiBm8ydxmNwVI3nGXbW986eTX4giyzEyaAa8QwPX746DuUocPg=
X-Received: by 2002:a81:846:0:b0:2db:f920:5c62 with SMTP id
 67-20020a810846000000b002dbf9205c62mr5093359ywi.489.1646210460323; Wed, 02
 Mar 2022 00:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-10-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-10-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 09:40:49 +0100
Message-ID: <CAM4kBBK_a_2d5f7=OF2euGacnGoKM-8oVu0uQ86cTMvuAtPuPA@mail.gmail.com>
Subject: Re: [PATCH 9/9] mm/z3fold: remove unneeded return value of z3fold_compact_page()
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
> Remove the unneeded return value of z3fold_compact_page() as it's
> never checked.

It was a sort of hook for gathering extended compaction statistics in
future. Do you really gain a lot by removing this?

~Vitaly

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 83b5a3514427..db41b4227ec7 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -746,18 +746,18 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
>
>  #define BIG_CHUNK_GAP  3
>  /* Has to be called with lock held */
> -static int z3fold_compact_page(struct z3fold_header *zhdr)
> +static void z3fold_compact_page(struct z3fold_header *zhdr)
>  {
>         struct page *page = virt_to_page(zhdr);
>
>         if (test_bit(MIDDLE_CHUNK_MAPPED, &page->private))
> -               return 0; /* can't move middle chunk, it's used */
> +               return; /* can't move middle chunk, it's used */
>
>         if (unlikely(PageIsolated(page)))
> -               return 0;
> +               return;
>
>         if (zhdr->middle_chunks == 0)
> -               return 0; /* nothing to compact */
> +               return; /* nothing to compact */
>
>         if (zhdr->first_chunks == 0 && zhdr->last_chunks == 0) {
>                 /* move to the beginning */
> @@ -766,7 +766,7 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>                 zhdr->middle_chunks = 0;
>                 zhdr->start_middle = 0;
>                 zhdr->first_num++;
> -               return 1;
> +               return;
>         }
>
>         /*
> @@ -778,7 +778,6 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>                         BIG_CHUNK_GAP) {
>                 mchunk_memmove(zhdr, zhdr->first_chunks + ZHDR_CHUNKS);
>                 zhdr->start_middle = zhdr->first_chunks + ZHDR_CHUNKS;
> -               return 1;
>         } else if (zhdr->last_chunks != 0 && zhdr->first_chunks == 0 &&
>                    TOTAL_CHUNKS - (zhdr->last_chunks + zhdr->start_middle
>                                         + zhdr->middle_chunks) >=
> @@ -787,10 +786,7 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>                         zhdr->middle_chunks;
>                 mchunk_memmove(zhdr, new_start);
>                 zhdr->start_middle = new_start;
> -               return 1;
>         }
> -
> -       return 0;
>  }
>
>  static void do_compact_page(struct z3fold_header *zhdr, bool locked)
> --
> 2.23.0
>
