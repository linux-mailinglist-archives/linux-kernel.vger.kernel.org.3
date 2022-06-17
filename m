Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5BB54F4E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381578AbiFQKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiFQKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:08:58 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BE02182A;
        Fri, 17 Jun 2022 03:08:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3176b6ed923so37502437b3.11;
        Fri, 17 Jun 2022 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ZtTCbfKlPy1sL/nTBNWOhi7Cc4DXnL97uQEVaSoU5Y=;
        b=Bn9B64Pt3h6XPuX2xWZhh1L40RUgLFZn8YPoo453y7DYbt3jiKhoxaPdbdQoM2OVlP
         qGRR8vPqBRWgs7M+UljIO+i2rZ1i3HpW+C4AcrVhmPYbsLuxo7l/VPKjIVCqSJRqLxBo
         QdVQGH61qRJDbo/9XXdrSkyteARSwL8wSWzAdZBUPNNKJtG6QDwoc9RpKtbXrzQQ1F/n
         0WNVbXlY7jIQuhm8gAcQX9kDW83Y1z+RtOy/uWoFpWKWcEjoZfTeUtOwcTb+hBAZ+120
         bN+5PjBi1XEZSDWy7N4dujgTcYlKy6Gq+wQ1GiMlrZDkz+wr40dPA9HD2RTDfNG2kMyV
         xZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ZtTCbfKlPy1sL/nTBNWOhi7Cc4DXnL97uQEVaSoU5Y=;
        b=5JSF1HCLpkqQylzXv+F4FzmmZrCBzzKkKiB52xLFqFLvkhQQ5lNdGjQ1R8HlgVBf/E
         /6ACMXNTzJz+x64dISuGwmd96s2yAQ5UlzqjFZIRbV2re8oLkKhNILmfhoqiQYdiWmFV
         E80Iz0Thb4P6J1OqUI0RtXccIefPrjROwSTxt05uUCAxXpYdJ8h3hYVC4WTPlJ+56bWr
         xlXMJcQl2V+zw0arUoD/Ou9XWL7yd3Ber5EJoN4EcA5MlS3pYlHhVJTNOHCDryYQL/PT
         HrPkUpP+Z6DOZFkbS3V0AVIX2g+F24vGapsblmOKtCrC5EUENTMZyiDsdol2NliOk0j+
         dg9Q==
X-Gm-Message-State: AJIora8IpAv6UGP0KjqNQiU+i1TjgaZUIDwci17HtbCyPZbqANcULMGl
        OD2gVAem0usCWWfYrUA5IGjSmFnkPZrKaMdnHgo=
X-Google-Smtp-Source: AGRyM1uHItNie6E+DKP/KEFCrtfManttjsqKWZrVKmAP7oSq4xHHGuslFvTiGJSYcaPG3Jb3ElMPpoeai9beNh+z4Cs=
X-Received: by 2002:a81:a24c:0:b0:314:4396:5aca with SMTP id
 z12-20020a81a24c000000b0031443965acamr10979392ywg.386.1655460536806; Fri, 17
 Jun 2022 03:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220605145835.26916-1-wuchi.zero@gmail.com>
In-Reply-To: <20220605145835.26916-1-wuchi.zero@gmail.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Fri, 17 Jun 2022 18:08:45 +0800
Message-ID: <CA+tQmHAkkxFkuabjh1Apwp1ZkNEtY+7ijLEs931aFA+MZngECA@mail.gmail.com>
Subject: Re: [PATCH] lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()
To:     axboe@kernel.dk, mwilck@suse.com, andriy.shevchenko@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping....

wuchi <wuchi.zero@gmail.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=885=E6=97=A5=E5=
=91=A8=E6=97=A5 22:58=E5=86=99=E9=81=93=EF=BC=9A
>
> 1. Getting next index before continue branch.
> 2. Checking free bits when setting the target bits. Otherwise,
> it may reuse the busying bits.
>
> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> ---
>  lib/sbitmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index ae4fd4de9ebe..29eb0484215a 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -528,7 +528,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitma=
p_queue *sbq, int nr_tags,
>
>                 sbitmap_deferred_clear(map);
>                 if (map->word =3D=3D (1UL << (map_depth - 1)) - 1)
> -                       continue;
> +                       goto next;
>
>                 nr =3D find_first_zero_bit(&map->word, map_depth);
>                 if (nr + nr_tags <=3D map_depth) {
> @@ -539,6 +539,8 @@ unsigned long __sbitmap_queue_get_batch(struct sbitma=
p_queue *sbq, int nr_tags,
>                         get_mask =3D ((1UL << map_tags) - 1) << nr;
>                         do {
>                                 val =3D READ_ONCE(map->word);
> +                               if ((val & ~get_mask) !=3D val)
> +                                       goto next;
>                                 ret =3D atomic_long_cmpxchg(ptr, val, get=
_mask | val);
>                         } while (ret !=3D val);
>                         get_mask =3D (get_mask & ~ret) >> nr;
> @@ -549,6 +551,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitma=
p_queue *sbq, int nr_tags,
>                                 return get_mask;
>                         }
>                 }
> +next:
>                 /* Jump to next index. */
>                 if (++index >=3D sb->map_nr)
>                         index =3D 0;
> --
> 2.20.1
>
