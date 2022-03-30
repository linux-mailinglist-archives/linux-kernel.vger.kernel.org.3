Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE14EBC71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbiC3IPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244160AbiC3IP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:15:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3BD98
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:13:42 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2e5e176e1b6so209279877b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+K2owB2t+DyQbJlqnNOc4HsIBOKgjIwr1F8eYT47SAY=;
        b=L96kVudZpRgDc4Yt/oIj1RBcCzRw1KG7XKih3MPhLDooTQIKsvMLOgba9DqIS7VT07
         i4R0x5C4/4WgR3f+71vyARmUNbV1X8MrQwH7vZDAbuiOkJ58nn8sJWMh+pjzrSi1fETb
         fgEnPXL3fulDjgZZTsMToe2KPEYW61H2nE8khMJCRkOAaoxo6JWffKcRkzGh9v8vAbo1
         jGWK/HQ6Pin99Av4aobNB/qcyVS4zArGtL632WFz+l7f4QBuofP/hlL7Nn0s2gPZnAey
         g96bM2S+sEcj5HkPkUXv28NMphmtAFYK/X1mfGGdRibmJetHul+LW3fefsdAOjGYwcdv
         bb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+K2owB2t+DyQbJlqnNOc4HsIBOKgjIwr1F8eYT47SAY=;
        b=NxGYjRVSlXqUyfrc0y/DKAvxPt8QcYb7hlvKe3VcQP35KuiLPu8Yn0k8jcmKlLP/aP
         PrzaBkb7hs2fUZXpK08/VuX7VFhmw57onbhrXKsgyCCNpFbrfuQTRUotH9UotT6E6/IW
         1IOy0URt2jfniblYCqfgBVZmqvQ/hfe0a72QrttAEEFp1t7RvH7w/fkSTR5J56H02dlp
         pv6IQ2n1yEVjIR773GmD8DB244e/jkFCdw8k8ZSz9Ydn5wV1c9P899sq8dtI8zBPKVo0
         SjY3BmfltM+1agRbGJYpT6g+Dm9Z4tGcX2YhXHQDwBcMjD2t252bBH5yNFPjCRILlnsM
         OUMA==
X-Gm-Message-State: AOAM532HaCd/6kz75Bu5TEIltoGCAY6KieBiwbnGW486Ngaw5hxhZ+0j
        E4GgeXXjTEufrQrOmh894ekyX+twl5av3pEABdft0ynRERU2OA==
X-Google-Smtp-Source: ABdhPJyiJphZ0B4bNrtTJ592K7nKM80aJvrFgk7oeKtVKWMl4n3G2wQRnpMTonCi/3gEv7I+n3WHJrN2/z+CI9JQTU8=
X-Received: by 2002:a81:897:0:b0:2e5:f3b2:f6de with SMTP id
 145-20020a810897000000b002e5f3b2f6demr35424504ywi.141.1648628022097; Wed, 30
 Mar 2022 01:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220329132619.18689-1-linmiaohe@huawei.com> <20220329132619.18689-2-linmiaohe@huawei.com>
In-Reply-To: <20220329132619.18689-2-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 30 Mar 2022 16:13:06 +0800
Message-ID: <CAMZfGtUPQvgaxG_6A0n6HwD9VjqbQUbnF99Ei9WpMZbTbnz4zg@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm/vmscan: remove redundant folio_test_swapbacked
 check when folio is file lru
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 9:26 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> When folio is file lru, folio_test_swapbacked is guaranteed to be true. So
> it's unnecessary to check it here again. No functional change intended.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1678802e03e7..7c1a9713bfc9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1434,8 +1434,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>          * Anonymous pages are not handled by flushers and must be written
>          * from reclaim context. Do not stall reclaim based on them
>          */
> -       if (!folio_is_file_lru(folio) ||
> -           (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
> +       if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {

At least your login is no problem since folio_is_file_lru() is equal to
!folio_test_swapbacked().  But the new code is not clear to me.
The old code is easy to understand, e.g. folio_test_anon(folio) &&
!folio_test_swapbacked(folio) tells us that the anon pages which
do not need to be swapped should be skipped. So I'm neutral on
the patch.
