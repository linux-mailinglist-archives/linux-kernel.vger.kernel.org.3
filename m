Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867658F12C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiHJRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiHJRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:06:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750024A820
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:06:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso2807014pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BloIoqd28Gq/iR4Kl8DFhiJxo48Wnl4+cYDJh7THU3o=;
        b=J+lmDtEx1spmwcuZ6nzWNtmyWixs3iQlKNfDN9GHbj7bwZHS4cMQbFPjooczgmAi28
         noJJpXytFM8RIKB8NHp+fliGadlVLNst/hyjPRLMP+3hYVf+8QDFzlQWS1fysWpJz0JD
         TbWYk4JzP8IUdumwwuedXE+kt3m43E1rT6SPPPJkx/7laJgMvWjE9w2M0GgCYu2+JIOK
         jPvzJBB08jggfJRS9Lm3GxdvpIfexx8h6llCHHLvJFDG21IrKwjyQ6jiUKR2XSkcQ1lQ
         ZRWokGoVdniJyH8OesMPG8L+Ipk2t5G7Yr78kywJZCIgsua3CC35c682Zwa4A4qSsXMZ
         7wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BloIoqd28Gq/iR4Kl8DFhiJxo48Wnl4+cYDJh7THU3o=;
        b=JDnIYIo8PsOSbisL4rP5eRrmBjCpEfWlOQxlI1hu7UVwmdFuhAgx0IDm7phf3iaAlz
         zhEyrcSbQsP7aJJQT38EfUwtZRgzAY6y1ReNdi88LAh+E9QEyb7QhKhblLdkvxWW+iXH
         J7QaiXZZiLrXtDYy8hz1S67O0kVt0saiLDAbQdrm99NzlnYME+Yx0m2kxz+8jbpUGnvu
         immlcOlsf28y/Y09KXS3wh+EesvD2yLsqOdcruBEvktmMuXRhmP6mnhRS8OgTRxxTQxR
         Gv8FIAncW6LAGM50gJsNghHa1Ap69Tj+UgpnSX+6qxsCJ/HR+/qCKU1GQW5q2Basu+Az
         +BdQ==
X-Gm-Message-State: ACgBeo0OaQ+d+CZOY2Hg0x1MKbruSIIAQPCQmO8WMl18Hmc+K1cVaAdt
        ye7t5zVSWE9yntcMz2Zwp91T7q3o+LjQTetI4TY=
X-Google-Smtp-Source: AA6agR7gaelm+IrsPpnI13nlpFFrvd9qLj+QGdfP1m8ePEL2ktkuUURsgHk47ox+qo60DBytLG8d7Wu8BIzH8gvt560=
X-Received: by 2002:a17:90b:1b45:b0:1f3:1974:eb8 with SMTP id
 nv5-20020a17090b1b4500b001f319740eb8mr4645072pjb.200.1660151193845; Wed, 10
 Aug 2022 10:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com>
In-Reply-To: <20220809142457.4751229f@imladris.surriel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 10 Aug 2022 10:06:21 -0700
Message-ID: <CAHbLzkr=QCD5i7X7ns5ZdakYZ3HVS4QnZGnx3UwuvDOqMR0=Wg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 11:25 AM Rik van Riel <riel@surriel.com> wrote:
>
> Align larger anonymous memory mappings on THP boundaries by
> going through thp_get_unmapped_area if THPs are enabled for
> the current process.
>
> With this patch, larger anonymous mappings are now THP aligned.
> When a malloc library allocates a 2MB or larger arena, that
> arena can now be mapped with THPs right from the start, which
> can result in better TLB hit rates and execution time.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
> v2: avoid the chicken & egg issue with MMF_VM_HUGEPAGE (Yang Shi)

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
>  mm/mmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c035020d0c89..1d859893436d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2229,6 +2229,9 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>                  */
>                 pgoff = 0;
>                 get_area = shmem_get_unmapped_area;
> +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +               /* Ensures that larger anonymous mappings are THP aligned. */
> +               get_area = thp_get_unmapped_area;
>         }
>
>         addr = get_area(file, addr, len, pgoff, flags);
> --
> 2.37.1
>
>
