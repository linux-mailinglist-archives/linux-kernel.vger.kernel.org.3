Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7960D570D02
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiGKVwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiGKVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:52:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F4961139
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:52:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h23so11041896ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esp4On95It78UY+94ldWZ+H1EyZMthkKoxOCUCFzVnU=;
        b=obZrw5Lqskc4Y5dqaR7jt3QEsxsxFtfK7lWukJ43RxLFVf3xc931wi+gIrLdntuB/V
         U4unyM+XOaDIFZfJeJXkhqKqKro2lhZt8+lGJ867bS2QIfrwdd/Tr68a7iCX6HPXFfAL
         w0d/IscwKtQIeqyS6B2aKyx/lQZZMNjdcIg3dl1XKyTEeITZTqB3UePB3KTWO9JqQ/4P
         R+WqcNtoy4bqZ+WdtPTcyP4URUoFOkzJfwvD/EOSSKeW33RsBo6LLxdtTZHXuraFLbzr
         pOBYRiabq2poPMfeuRmOrSP3Lahh4llmWHqTEIX/DOoe9BQR5ya5LOi2ifuw314sAfSZ
         OBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esp4On95It78UY+94ldWZ+H1EyZMthkKoxOCUCFzVnU=;
        b=vVMs6esIe4g3X4+dpgY/tD29TK3u1XnoYj/01Aog3T2kUsHg1FjqonFeRIRd/RJcqu
         GaRYXwHJFvLJBa5eKcN/YcVMW5wRdqbMZn9m1ID61AvGP15UGeqKi4nUaC2NW45fxdwy
         TQytN7fCIWApRLq9pdUevDyRm8oDi43PU1mwPpaQ1n5OlPLynYjN8RJnR+OX1VFiSPTW
         pULtYUHmccHL2Da8duZx1elu/FXtXdhEgLAgRBtItgmfvqNlA01pLQik5lU1W1fT6gI8
         zWv2PIU8/5x2UqWBzomjLgHRQcIcfF5wrJLEosQoLYhRxjXayNzGNkaRsjPlG+tDhGZY
         btMg==
X-Gm-Message-State: AJIora+u9WjthgSfp5D/YjTe4ylhG48kFg08bL/P+IiZMKUaU4K18FU+
        sI5WVCqD3CsCvDO4DQJoF4KBxhWlbDRT4IRs0is=
X-Google-Smtp-Source: AGRyM1u59cVfgB6SirEAFalQkMDM8+sQXz1+b0lXP2xgQiKF5yRdjU5dilhpzgMjFPx8opC242eWorAoKBNcGxTprOU=
X-Received: by 2002:a17:907:2808:b0:72b:4d49:b2e9 with SMTP id
 eb8-20020a170907280800b0072b4d49b2e9mr9693124ejc.176.1657576331202; Mon, 11
 Jul 2022 14:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <OSZP286MB1725A2361FA2EE8432C4D5F4B8879@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OSZP286MB1725A2361FA2EE8432C4D5F4B8879@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jul 2022 14:51:59 -0700
Message-ID: <CAEf4BzYCtsY71mCeacg4TXuVNa-K80WGHK9VEoBbi2_jVX0RUQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix the name of a reused map
To:     "anquan.wu" <leiqi96@hotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Jul 11, 2022 at 3:25 AM anquan.wu <leiqi96@hotmail.com> wrote:
>
> BPF map name was limited to BPF_OBJ_NAME_LEN.
> If a map name is defined as being longer than BPF_OBJ_NAME_LEN,
> it will be truncated to BPF_OBJ_NAME_LEN
> when a userspace program calls libbpf to create the map.
> A pinned map also generates a path in the /sys.
> If the previous program wanted to reuse the map=EF=BC=8Cit can not get bp=
f_map
> by name, because the name of the map is only partially the same as
> the name which get from pinned path.
>
> The syscall information below show that map name
> "process_pinned_map" is truncated to process_pinned_"
>
> bpf(BPF_OBJ_GET, {pathname=3D"/sys/fs/bpf/process_pinned_map",
> bpf_fd=3D0, file_flags=3D0}, 144) =3D -1 ENOENT (No such file or director=
y)
>
> bpf(BPF_MAP_CREATE, {map_type=3DBPF_MAP_TYPE_HASH, key_size=3D4, value_si=
ze=3D4,
> max_entries=3D1024, map_flags=3D0, inner_map_fd=3D0, map_name=3D"process_=
pinned_",
> map_ifindex=3D0, btf_fd=3D3, btf_key_type_id=3D6, btf_value_type_id=3D10,
> btf_vmlinux_value_type_id=3D0}, 72) =3D 4
>
> This patch check that if the name of pinned map are the same as the
> actual name for the first (BPF_OBJ_NAME_LEN - 1),
> bpf map still uses the name which is included in bpf object.
>
> Signed-off-by: anquan.wu <leiqi96@hotmail.com>

please use your complete and capitalized name in Signed-off-by

Overall, looks good, I have a few stylistical nits, see below. But
also you forgot to cc bpf@vger.kernel.org, please send v2 and don't
forget to add mailing list. Without that our CI can't test your patch
properly.


> ---
>  tools/lib/bpf/libbpf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e89cc9c885b3..5ad52a8accd1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4328,6 +4328,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>  {
>         struct bpf_map_info info =3D {};
>         __u32 len =3D sizeof(info);
> +       __u32 name_len;

nit: __u32 len =3D sizeof(info), name_len;

>         int new_fd, err;
>         char *new_name;
>
> @@ -4337,7 +4338,12 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>         if (err)
>                 return libbpf_err(err);
>
> -       new_name =3D strdup(info.name);
> +       name_len =3D strlen(info.name);
> +       if ((BPF_OBJ_NAME_LEN - 1) =3D=3D name_len && !strncmp(map->name,=
 info.name, name_len))

nit, unnecessary () around BPF_OBJ_NAME_LEN, plus the order is a bit
weird. I also have general preference with strncmp/strcmp to compare
against zero explicitly, so can you rewrite this as:

if (name_len =3D=3D BPF_OBJ_NAME_LEN - 1 && strncmp(map->name, info.name,
name_len) =3D=3D 0)

?

> +               new_name =3D strdup(map->name);
> +       else
> +               new_name =3D strdup(info.name);
> +
>         if (!new_name)
>                 return libbpf_err(-errno);
>
> --
> 2.32.0
>
