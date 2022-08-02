Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087C55881A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiHBSEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiHBSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:04:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B118E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:04:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t22so23095661lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DT1Fy6516QHYclkQUbxl4Uh7gxM9Qp3F1M1t05YgLg=;
        b=rF0SUPED2ACYPQZq1h5mNpta4oJoviVm17CUjbyoD1axNgFVSREzmdgRmOVX2kBu3D
         kPuOSYwU0htUfwM9LrbI7oqV1Pw2FfDzf7AqqsiavpxLq5pRtxzFPaZpRS5vPxZksFT1
         Mmh3NH6283K5IYzbMfmuy/cKN1bh4YwpRPGIMK4A7mFlTxPrr1B6JpXcA8T07WLRtyHx
         4Q3rJfosX07DgZOametHSsDOQNZrBkA2WtO6qZnYJ3K35FnIbwj/OJ5AJG/nRWEopU5e
         f+VRpHtZqOXdx0KWRRs9d4Eo83HJpI0O0Er4Y6VkNcxh3DeL3dwjXM3zPx79avTMI362
         SBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DT1Fy6516QHYclkQUbxl4Uh7gxM9Qp3F1M1t05YgLg=;
        b=ugA+isNwrLB0l3YjH4VqR2ICEACRaWAE5U2c/ouE7Ba7+WB/184loCnBSESTL3mgUR
         LsaZAj7PeNqgrkhP1TdTt3QT9WUx5LcoqRepm6sDB8mXhjCdeyjqcgadeuaowTJ9cJk2
         80prljhNxfxEy1YNV5+5tt50V82AGTzpXDK/4OenKkwtlalI9bLchB49PQqk6vASLBf7
         KxZmwwZgXumXOHyviaLUiq/uGzK/XzFfXSQpFO5ySPWPe2ZujAQ9hux7j3ElKPkCtKnl
         Uh4l/AXnFwDNpcGXjKmKqI2eWfqB9RN/GqRIko9HkyPkNN+90XsxjIb+vHULGPK9YxAW
         U69w==
X-Gm-Message-State: AJIora+s7ElildK6S7Pox7aOxFbADLZzO9wMjh7GZ/IqkjtHvNn3gqqa
        VnNTmgMa4Yix2wSylhjTjW/ebD6tUgdd91tI/95mnw==
X-Google-Smtp-Source: AGRyM1vu0sUfmiHEHs+AbWugSM1Hy1w9DSdDY4CfuIAb+XNsl36yCC0sqbLUTpYAdo5k4VuT7bIk0WhXsX/2W8EaSvY=
X-Received: by 2002:a05:6512:1307:b0:47f:baa4:52c5 with SMTP id
 x7-20020a056512130700b0047fbaa452c5mr7342378lfu.103.1659463463620; Tue, 02
 Aug 2022 11:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220730173636.1303357-1-masahiroy@kernel.org> <20220730173636.1303357-3-masahiroy@kernel.org>
In-Reply-To: <20220730173636.1303357-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Aug 2022 11:04:12 -0700
Message-ID: <CAKwvOdkq1or=UOWJLU2DaS=MFGO9OmH7HG6=FDKS6h_saoKLAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Revert "Kbuild, lto, workaround: Don't warn for
 initcall_reference in modpost"
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
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

On Sat, Jul 30, 2022 at 10:37 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This reverts commit 77ab21adae509c5540956729e2d03bc1a59bc82a.
>
> That commit was 8 years old, and it said "This is a workaround".
> If this is needed for GCC LTO, it should be added in a proper way.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Please don't forget to cc the author & reviewers for a patch when
submitting a revert.

+ Jiri in case a patch needs to be carried in any downstream trees for
re-application.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


> ---
>
>  scripts/mod/modpost.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index c6a055c0291e..a8ee27496da7 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1462,9 +1462,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
>         from = find_elf_symbol2(elf, r->r_offset, fromsec);
>         fromsym = sym_name(elf, from);
>
> -       if (strstarts(fromsym, "reference___initcall"))
> -               return;
> -
>         tosec = sec_name(elf, get_secindex(elf, sym));
>         to = find_elf_symbol(elf, r->r_addend, sym);
>         tosym = sym_name(elf, to);
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
