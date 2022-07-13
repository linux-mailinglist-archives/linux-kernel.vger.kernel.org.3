Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BA573F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiGMVw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiGMVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:52:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482BB2DA8D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:52:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o15so304369pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCIFkLMKMpX+Y9w6k09/VmA+FsaqBvsnLjSpd/VlknQ=;
        b=cihlpN/vfaDChG8MTo9W5WeMIOQfXXNWECGHf1HDlDXBYyCjsCAYPeelb9V5ZyOcKg
         mTPe9mheim3oEAA8uH2+y6eYsBaSw+JMAT0/W0jVXpezPPfTA2KpvtVMWeKd8DsTa2yf
         +Gspm9hN28/JftaE7+Au2YHp5zUpIZMXo3qsoHjQyqCtaevLrclv3GixxvwFkXUPk0fN
         YkhgtJljyJ/gN4mMexJ3DkffpNXLsc0ktjcRL4iLC3hIdBEEUyogsW+hKJWlkI0mhNEe
         XtvUxkqzdrqOF/gdKxbvfw//5KRops9oO6WblxZtcHiGKiqWcjU3lDAV++DoXJI6genB
         h/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCIFkLMKMpX+Y9w6k09/VmA+FsaqBvsnLjSpd/VlknQ=;
        b=szyPkbgV9lrAowv2yxo2iWKCh6UY99AY7HwyY2jzqk1eG7QgqiLbq4/n/qCxS4VCD8
         ubuFkjooGGAj2oWDR4fI+pzrDDS4rSwEUZ7c9/VEvqeolftxG8S8Y6mw2QW5mHoub/uS
         pGK84Pr/HAITfEBVqAV+Gq/p5c1VAYE1O0k5pXAOB+ePmSPPPcVww9WEKBbpmgiW2ZYK
         d1KYTm5r+Y1B48IY7Z2flwjxRs381WCx/awbETWrO8TVwbUF4GM/NqnNp0t2BzU/qtLM
         fUPnWb/KQg/S6AUtwt88bbVBJza+tciSk30+Zq/lSkCiESLo4FMQG6SXvuUimR5lCZNB
         L3UA==
X-Gm-Message-State: AJIora/M/vPX/7n87he+ORALasPEkVJ1AJls9+Z3BKiYStP0chngpPoC
        p3I5iC/q2T/6afIDGXsnhlZHGCuHIU18DFf4w2mmIw==
X-Google-Smtp-Source: AGRyM1vKMYk0b+0emPkAYMmZ1ZAYRZzj99+X3wWYqskLaFDHhWx7Hz2L/kSCzWTjfX2ZvhaRQJGlVx2mJs4LWleAJhg=
X-Received: by 2002:a17:90b:4b4d:b0:1ef:bff5:de4f with SMTP id
 mi13-20020a17090b4b4d00b001efbff5de4fmr12341485pjb.120.1657749145553; Wed, 13
 Jul 2022 14:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220713214246.2545204-1-jevburton.kernel@gmail.com>
In-Reply-To: <20220713214246.2545204-1-jevburton.kernel@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jul 2022 14:52:14 -0700
Message-ID: <CAKH8qBtkgsQ9snhno3aYnhyc8vG2a0xhgg_sCb4KFhcQt+gfqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_map__set_name()
To:     Joe Burton <jevburton.kernel@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Burton <jevburton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 2:43 PM Joe Burton <jevburton.kernel@gmail.com> wrote:
>
> From: Joe Burton <jevburton@google.com>
>
> Add the capability to set a `struct bpf_map` name.
>
> bpf_map__reuse_fd(struct bpf_map *map, int fd) does the following:
>
> 1. get the bpf_map_info of the passed-in fd
> 2. strdup the name from the bpf_map_info
> 3. assign that name to the map
> 4. and some other stuff
>
> While `map.name` may initially be arbitrarily long, this operation
> truncates it after 15 characters.
>
> We have some infrastructure that uses bpf_map__reuse_fd() to preserve
> maps across upgrades. Some of our users have long map names, and are
> seeing their maps 'disappear' after an upgrade, due to the name
> truncation.
>
> By invoking `bpf_map__set_name()` after `bpf_map__reuse_fd()`, we can
> trivially work around the issue.

Asked you internally, but not sure I follow. Can you share more on why
the following won't fix it for us:

https://lore.kernel.org/bpf/OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/

?

The idea seems to be to get the supplied map name (from the obj)
instead of using pin name? So why is it not enough?

> Signed-off-by: Joe Burton <jevburton@google.com>
> ---
>  tools/lib/bpf/libbpf.c | 22 ++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h |  3 ++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 72548798126b..725baf508e6f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9089,6 +9089,28 @@ const char *bpf_map__name(const struct bpf_map *map)
>         return map->name;
>  }
>
> +int bpf_map__set_name(struct bpf_map *map, const char *name)
> +{
> +       char *new_name;
> +
> +       if (!map)
> +               return libbpf_err(-EINVAL);
> +
> +       new_name = strdup(name);
> +       if (!new_name)
> +               return libbpf_err(-ENOMEM);
> +
> +       if (map_uses_real_name(map)) {
> +               free(map->real_name);
> +               map->real_name = new_name;
> +       } else {
> +               free(map->name);
> +               map->name = new_name;
> +       }
> +
> +       return 0;
> +}
> +
>  enum bpf_map_type bpf_map__type(const struct bpf_map *map)
>  {
>         return map->def.type;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index e4d5353f757b..e898c4cb514a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -731,8 +731,9 @@ LIBBPF_API bool bpf_map__autocreate(const struct bpf_map *map);
>   */
>  LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
> -/* get map name */
> +/* get/set map name */
>  LIBBPF_API const char *bpf_map__name(const struct bpf_map *map);
> +LIBBPF_API int bpf_map__set_name(struct bpf_map *map, const char *name);
>  /* get/set map type */
>  LIBBPF_API enum bpf_map_type bpf_map__type(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_type(struct bpf_map *map, enum bpf_map_type type);
> --
> 2.37.0.144.g8ac04bfd2-goog
>
