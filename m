Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF26E53C4B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbiFCF5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiFCF53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:57:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A683713CFB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 22:57:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso4531333wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 22:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trTQR6/qmHbTlyde/rCm8sSQSJS5wB9n1+cCV0e7RK0=;
        b=ZAEQlvgbKN0qmgFxrTlMgeUTBFJXXFKPGvElq+AAseoFgNf59kxTsxHeEbxmFDnMHf
         yqCgrHtHA67lNq4umZptjzUyVwVGgy4bf9VrDrNdLXNQ3zUE+/2buWyY254UiuESAryW
         ZER1hri8yIHaeqDwdfKZxWq2F/8nbyO/A+X9MpIT4A7JkizxtVv9QISQ9ba5RH9fp2Hk
         mQoWAhv2rWQOFueFLIjRj8RQyoqodVdB/rGuRkR570sXIwoOa7SX6LO3VOC9T10N5NVZ
         GZYUCjeWl5+yLn2TdQXE95+Wqz/Lz/AbtnWmgI7r6gdrWAm8HYZqdzkWF+hxaM9VH50v
         TtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trTQR6/qmHbTlyde/rCm8sSQSJS5wB9n1+cCV0e7RK0=;
        b=12rwgTbs8QAMMGy74Vi8LzfwU0aemuIOVZFRArE3dIPS8FTJl7RgHxBS2YPL7lPYDe
         kQjfHIsTLXsu2kEVGan+tQPlZ9sX7sXo66tylQzMp3s133SJ67NBkFOGEHvQMLohhWXf
         apEtOqoEOlTnPWOJ3CLG2GpEPUjrCRej40c2PATmaV7OIBr4JhFKghisv96h21DO+IVa
         Ps65ZbpIx/Slwlos8PMbLtcVHQ9pV2Mxm47wuvxBPP2P+dB6yl7fhTluEWU4LJwpXWYQ
         DojSkZxb4+YYY7eB2JstgznhDpF1FKt7EZ8KOhtJhm8MZBq84AqAG3+0h3znGOAQgv9G
         Y2sA==
X-Gm-Message-State: AOAM5314QUeUDDmLnKZbgji7MTvaz8qiUQ+3YFz5KKVrbSqinV1KflUy
        aSkUygaCer/nQvW9diyHMHaCBDRzhpH6FQB1ngwC3Q==
X-Google-Smtp-Source: ABdhPJwGoN6bmXgIXunf+Gu7h7634zKT6i0mHxKvT2pqhggzXPcroF5Muv7BO3o3uEbGWmJsG7M3rqIXWSfircn1Yqk=
X-Received: by 2002:a7b:c015:0:b0:397:3685:5148 with SMTP id
 c21-20020a7bc015000000b0039736855148mr6967957wmb.174.1654235846995; Thu, 02
 Jun 2022 22:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220603055156.2830463-1-irogers@google.com>
In-Reply-To: <20220603055156.2830463-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Jun 2022 22:57:13 -0700
Message-ID: <CAP-5=fVhVLWg+c=WJyOD8FByg_4n6V0SLSLnaw7K0J=-oNnuaA@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Fix is_pow_of_2
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yuze Chi <chiyuze@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 10:52 PM Ian Rogers <irogers@google.com> wrote:
>
> From: Yuze Chi <chiyuze@google.com>
>
> Move the correct definition from linker.c into libbpf_internal.h.
>

Sorry I missed this:
Fixes: 0087a681fa8c ("libbpf: Automatically fix up
BPF_MAP_TYPE_RINGBUF size, if necessary")

Thanks,
Ian

> Reported-by: Yuze Chi <chiyuze@google.com>
> Signed-off-by: Yuze Chi <chiyuze@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/bpf/libbpf.c          | 5 -----
>  tools/lib/bpf/libbpf_internal.h | 5 +++++
>  tools/lib/bpf/linker.c          | 5 -----
>  3 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3f4f18684bd3..346f941bb995 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4954,11 +4954,6 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>
>  static void bpf_map__destroy(struct bpf_map *map);
>
> -static bool is_pow_of_2(size_t x)
> -{
> -       return x && (x & (x - 1));
> -}
> -
>  static size_t adjust_ringbuf_sz(size_t sz)
>  {
>         __u32 page_sz = sysconf(_SC_PAGE_SIZE);
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 4abdbe2fea9d..ef5d975078e5 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -580,4 +580,9 @@ struct bpf_link * usdt_manager_attach_usdt(struct usdt_manager *man,
>                                            const char *usdt_provider, const char *usdt_name,
>                                            __u64 usdt_cookie);
>
> +static inline bool is_pow_of_2(size_t x)
> +{
> +       return x && (x & (x - 1)) == 0;
> +}
> +
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 9aa016fb55aa..85c0fddf55d1 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -697,11 +697,6 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
>         return err;
>  }
>
> -static bool is_pow_of_2(size_t x)
> -{
> -       return x && (x & (x - 1)) == 0;
> -}
> -
>  static int linker_sanity_check_elf(struct src_obj *obj)
>  {
>         struct src_sec *sec;
> --
> 2.36.1.255.ge46751e96f-goog
>
