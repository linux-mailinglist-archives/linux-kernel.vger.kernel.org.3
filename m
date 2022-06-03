Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4453CD57
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiFCQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiFCQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:36:38 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD9D33EB3;
        Fri,  3 Jun 2022 09:36:37 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 253Ga570012954;
        Sat, 4 Jun 2022 01:36:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 253Ga570012954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654274165;
        bh=y9/o8slDJ+sIhWwDON3kj1DgvkXcnvtnKrUDQ3BsCBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=prFLXjsoYgB7ijohnFW7p4Yq1bBZ3k3ioYTFI59MUD8cdROQY9ONC+UQM/Tw3F7Fd
         SJ8Tz3BhZwNF5h9ydAkBX0tyes5AbKGSIGay8g8gOZnblLNbT2t85FNtUk5kh2/FJk
         z5xC0J304vBxEbogqnCJxZqQbfq8YuUOlpWJapfn200ufoRR6ks7VLOCtggPSZ0Wrr
         1jrOIS5YWDErf+DPCIw7KHO2Da22FNnkZrRrALpI0WEAYAQJmn8oZlYPYfDeotmwFc
         1yZrJpCIlHzc6N+H4GP/Hry+9ZO0MGPrruk66X5GuUd7wgqrQjuSgSoXy4/L1rpY22
         5gkmi1GUap0IQ==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id o6so2109589plg.2;
        Fri, 03 Jun 2022 09:36:05 -0700 (PDT)
X-Gm-Message-State: AOAM533KFlllEZsLeTnQ5wT/zFIlQz3j+VWKdrs69Mf2kO/mLMksdmDE
        46obM2PyorfsKvxLYpEWxkTN4v5J1GXbfjDDWbs=
X-Google-Smtp-Source: ABdhPJxHTWnsHRa1laYe16TntCcCFe6eXBafdiRH0+z/EC8W7Chtcst5x0RGUQyP1BdiYs+nb+7DHDQtOr1vohmT2OY=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr10697850plp.162.1654274164458; Fri, 03
 Jun 2022 09:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220603093852.13818-1-schspa@gmail.com>
In-Reply-To: <20220603093852.13818-1-schspa@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 4 Jun 2022 01:35:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6JWgrjFiCHpj=ZMHVM-xddCQgOVWv0N_-YxL+v1f4=g@mail.gmail.com>
Message-ID: <CAK7LNAS6JWgrjFiCHpj=ZMHVM-xddCQgOVWv0N_-YxL+v1f4=g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Allow to select bash in a modified environment
To:     Schspa Shi <schspa@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 6:39 PM Schspa Shi <schspa@gmail.com> wrote:
>
> This fixes the build error when the system has a default bash version
> which is too old to support associative array variables.
>
> The build error log as fellowing:
> linux/scripts/check-local-export: line 11: declare: -A: invalid option
> declare: usage: declare [-afFirtx] [-p] [name[=value] ...]
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---


Applied to linux-kbuild. Thanks.


>  scripts/check-local-export | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/check-local-export b/scripts/check-local-export
> index 017119d89cd2..2defd0bf3552 100755
> --- a/scripts/check-local-export
> +++ b/scripts/check-local-export
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  # Copyright (C) 2022 Masahiro Yamada <masahiroy@kernel.org>
> --
> 2.24.3 (Apple Git-128)
>


-- 
Best Regards
Masahiro Yamada
