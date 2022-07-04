Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3464565FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiGDXsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGDXsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 19:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58842B1FE;
        Mon,  4 Jul 2022 16:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8C38617A1;
        Mon,  4 Jul 2022 23:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3336DC3411E;
        Mon,  4 Jul 2022 23:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656978480;
        bh=czJkJvkoEWZl+FwWFr/1n65f9w7bYYQrRhp+rXLnpVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dX1fnVGXpq5bNbC0vIi9SaFHXukiCZDlOrthEH385SVVJq/3lIcYa8FitHjC67W++
         jM8tKKVPbz1Lx1ziHzA7fDfheaKntsqclogbQ4bX4V5jHsHym+ilE7Vj0RBA4ftwTk
         8k/QHMxy9NNhOGEwhlJctYmewQVMtIDRop0zqy4Q+js1eKV4PwYuvOc+Ll9EOigPBK
         VgvK/cyBmzMrBXrgLG0ikviKzC8ahBlclCP/SB71W2URrY5GIeIY4YAulvwbNSHkfF
         DMVCVsd7i2Wf3NU/HGpOkeGQbmOW8YYpXmSoDIXZfVXbCEhV2n8dKNy+BrPTbxSlzA
         cjWcmwoYul8Xg==
Received: by mail-vs1-f50.google.com with SMTP id a184so1298871vsa.1;
        Mon, 04 Jul 2022 16:48:00 -0700 (PDT)
X-Gm-Message-State: AJIora8P6JbwiDij75Oy86uV55sm/a3nKUbcLM7hin2epkKAdl3p7JR3
        i9KstgvMebF1ZczmgaO0PDlYbUSmmkE7n+VneLc=
X-Google-Smtp-Source: AGRyM1vC+q0evW03lAEHy0LgBjOjCwHACiPzqq7mXPQk2Qfejb9rG028Xg72JWEg0wNXW/JN6HR5+5fHLHDeqja6f1Q=
X-Received: by 2002:a05:6102:366f:b0:356:352f:9de2 with SMTP id
 bg15-20020a056102366f00b00356352f9de2mr18387731vsb.2.1656978479097; Mon, 04
 Jul 2022 16:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <07685c3184d2d9e3ee3b83e8f608e3a178cfabe3.1656961592.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <07685c3184d2d9e3ee3b83e8f608e3a178cfabe3.1656961592.git.christophe.jaillet@wanadoo.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 5 Jul 2022 07:47:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjywpxzRBFwM79JugqRWP1ABdDUbA3PLqy9k9RAd9ujA@mail.gmail.com>
Message-ID: <CAJF2gTTjywpxzRBFwM79JugqRWP1ABdDUbA3PLqy9k9RAd9ujA@mail.gmail.com>
Subject: Re: [PATCH] csky: Use the bitmap API to allocate bitmaps
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx and looks good to me.

On Tue, Jul 5, 2022 at 3:08 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
>
> It is less verbose and it improves the semantic.
>
> While at it, turn a bitmap_clear() into an equivalent bitmap_zero(). It is
> also less verbose.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/csky/mm/asid.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/csky/mm/asid.c b/arch/csky/mm/asid.c
> index b2e914745c1d..7fb6c417bbac 100644
> --- a/arch/csky/mm/asid.c
> +++ b/arch/csky/mm/asid.c
> @@ -27,7 +27,7 @@ static void flush_context(struct asid_info *info)
>         u64 asid;
>
>         /* Update the list of reserved ASIDs and the ASID bitmap. */
> -       bitmap_clear(info->map, 0, NUM_CTXT_ASIDS(info));
> +       bitmap_zero(info->map, NUM_CTXT_ASIDS(info));
>
>         for_each_possible_cpu(i) {
>                 asid = atomic64_xchg_relaxed(&active_asid(info, i), 0);
> @@ -178,8 +178,7 @@ int asid_allocator_init(struct asid_info *info,
>          */
>         WARN_ON(NUM_CTXT_ASIDS(info) - 1 <= num_possible_cpus());
>         atomic64_set(&info->generation, ASID_FIRST_VERSION(info));
> -       info->map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
> -                           sizeof(*info->map), GFP_KERNEL);
> +       info->map = bitmap_zalloc(NUM_CTXT_ASIDS(info), GFP_KERNEL);
>         if (!info->map)
>                 return -ENOMEM;
>
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
