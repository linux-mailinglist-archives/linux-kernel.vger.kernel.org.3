Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7E74C9F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbiCBIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiCBIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:22:21 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9100EB8234
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:21:38 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id j12so1760146ybh.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0JEyvT4sRgBeuNX2LNvd5n4DsQZeLFTyxYihUMzHKM=;
        b=gG8Evc6NzK22q0g35QqXRb3TUYTC/6aIy14Wcb9wYeA/FK6C/owoQ6qE/reZ2FxKjG
         jNE/whE3+7OncF09l5PPD/LTeQIYb8Cf40M5FTNA6/AK5ljfnZ7oK4rZYCsJL6ePvAeg
         zOaYcON7uBXijDR23d9gE4vG2uYmkA327GuF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0JEyvT4sRgBeuNX2LNvd5n4DsQZeLFTyxYihUMzHKM=;
        b=qqxp+r0Mow4qlTT24oubWalF56UQYRH4+vbgoD7shg+yWDWpn8d0+8pGfsY9hHSH24
         jPGexqW2Wg6SLfBpNGPA/ga62bZ/KFvdlZW9FoOykAnXQ0aJYldSCn9X05NW7lCGNHdN
         HE78fHCDGByyHFbcjOQEphNm0fjvz9xBnlHAlRGMub7rHXqNH1X3JZGTt6MN7YmYU52w
         3/PVn553bflxkvDIJDuRLWaSdOYVRlonf3RwCjZd1dN2la+h1Li7KOQtfpDhz9kwFe9Y
         3v5DFZeYREz69I5GHiVVU9hruljHbmQkTukWUo2fQmldv6JAzcRatDpEQLHOA+3PQQ4s
         wx0Q==
X-Gm-Message-State: AOAM531lLes2BnMFSD6I5nW+GLRyeH377wMfgWCfNq3SyR5n0RM5KxMm
        BPsH8GIZdW0hlZ8S8NZWKJhYZhy+6wHfCLQ2sZifRuaoGwg=
X-Google-Smtp-Source: ABdhPJxngj7bqTtU+kHzTH8YKDlxhC4TIDYb8jPFRKCeGt3hWnobuDPa98/M1pFHj1eOducxWK7gNHsUughJdOa4DI4=
X-Received: by 2002:a25:f904:0:b0:628:a84d:a105 with SMTP id
 q4-20020a25f904000000b00628a84da105mr551866ybe.53.1646209297827; Wed, 02 Mar
 2022 00:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-4-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-4-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 09:21:26 +0100
Message-ID: <CAM4kBBL3ZDTnB4bWLRZSow1jaAeVwuJx4rbnzsVdy06p1Fnf-A@mail.gmail.com>
Subject: Re: [PATCH 3/9] mm/z3fold: minor clean up for z3fold_free
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
> Use put_z3fold_header() to pair with get_z3fold_header. Also fix the wrong
> comments. Minor readability improvement.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---
>  mm/z3fold.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 87689f50f709..eb89271aea83 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1187,9 +1187,9 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>   * @handle:    handle associated with the allocation returned by z3fold_alloc()
>   *
>   * In the case that the z3fold page in which the allocation resides is under
> - * reclaim, as indicated by the PG_reclaim flag being set, this function
> - * only sets the first|last_chunks to 0.  The page is actually freed
> - * once both buddies are evicted (see z3fold_reclaim_page() below).
> + * reclaim, as indicated by the PAGE_CLAIMED flag being set, this function
> + * only sets the first|middle|last_chunks to 0.  The page is actually freed
> + * once all buddies are evicted (see z3fold_reclaim_page() below).
>   */
>  static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
>  {
> @@ -1247,7 +1247,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
>         }
>         if (page_claimed) {
>                 /* the page has not been claimed by us */
> -               z3fold_page_unlock(zhdr);
> +               put_z3fold_header(zhdr);
>                 return;
>         }
>         if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
> --
> 2.23.0
>
