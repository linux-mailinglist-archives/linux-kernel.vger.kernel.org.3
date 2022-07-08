Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF056C4E9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiGHXRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbiGHXRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:17:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FDC22B2E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:17:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z16so89713qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEpqZ3mGcZFuGVY/60/YxsPdqVYz+C2jqWw/2774RQI=;
        b=Ixk4vk0BF/h3tA1u84YeWwn1BK/PukzP5AJ63goagamizvEgvX3cL01n9W0BElB1+y
         HaJLmIDDCV40Cf/m52APuQbKDLS9n/5xwy8Msru0FwNLmQ6imK8dhqxLJTSARGkiX3mv
         SbDgV2chJm8yzQTBFuqyyrNEeigjfcgduAOAE9l+zUQruizU1A9IbOhzVw3lLBh3ml35
         v6mKnw+LblTOU/sPwal5CZ97vME50rcXYSo3+p+IVR3aYGs174qzYy5jt/WsbmwSB8pA
         LE3TvIllf5hbbFhIuYf7wmhzY9oZMhFCRZ8eDc+q746PIrdMKYNkNKBkb029hXp8VH94
         VcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEpqZ3mGcZFuGVY/60/YxsPdqVYz+C2jqWw/2774RQI=;
        b=sC4dhi92gMlEKgRWHWEGHrRHsETTPttArL2Fa06E6O7D2NR26aIHYPAMwLnY9St1ay
         ZWnjYttCpASEDG9DwYnIXi8MSjkDPlp6GXQnPfPM5ffj2aE8quPfLGZZ5ApZVIcK30T/
         SP2cV/17lB/rq9hP7dhDwIZUM1UQE+IeOtyouE5xFEvqzzkZGWOwVy1QgWGWq6yc0isK
         A0EayocAL9X+QgEzISv1Zpt5JvhnLwUq1XCUuuDWPmMJJ5Pw0I4Ht1yyyNFNia7f0Bw1
         emXCENXrrcPv3bZSU3z+5vd9bijAq2Nvtnf9OMa8db07LL6nrEEsmWoCnNxD+HkN0VAt
         eTSQ==
X-Gm-Message-State: AJIora/RQgMsfDqZpXNen5r0eJEQHWsQYmigmtcprN0o8Kgj4pLAulP5
        BbHSUx3fXB9cdkFaqkkibIJXgYtfgxmvwauUH9YJHQ==
X-Google-Smtp-Source: AGRyM1tIPWcFlePAGHQYyXwBHQcoLJlC18/o7LXhR7c818g4fm/vLhfnI+CRDiqq2xs2srtXUKMmTFlKWv1M7V8cZ+w=
X-Received: by 2002:a05:620a:f0e:b0:6b5:48f6:91da with SMTP id
 v14-20020a05620a0f0e00b006b548f691damr3951482qkl.446.1657322241720; Fri, 08
 Jul 2022 16:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com> <1657113391-5624-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1657113391-5624-2-git-send-email-alan.maguire@oracle.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 8 Jul 2022 16:17:10 -0700
Message-ID: <CA+khW7h80NeCvUneKw1Sscpqt6xHhfV-pA8R_ygEBNharXnRSA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: add a ksym BPF iterator
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Alan,

On Wed, Jul 6, 2022 at 6:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> add a "ksym" iterator which provides access to a "struct kallsym_iter"
> for each symbol.  Intent is to support more flexible symbol parsing
> as discussed in [1].
>
> [1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/kallsyms.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
[...]
> +
> +static struct bpf_iter_reg ksym_iter_reg_info = {
> +       .target                 = "ksym",
> +       .ctx_arg_info_size      = 1,
> +       .ctx_arg_info           = {
> +               { offsetof(struct bpf_iter__ksym, ksym),
> +                 PTR_TO_BTF_ID_OR_NULL },
> +       },
> +       .seq_info               = &ksym_iter_seq_info,
> +};
> +

Can we add allow resched here?

 .feature = BPF_ITER_RESCHED,

I think this will improve the responsiveness of the kernel when iterating ksyms.

Thanks,
Hao

> +BTF_ID_LIST(btf_ksym_iter_id)
> +BTF_ID(struct, kallsym_iter)
> +
> +static int __init bpf_ksym_iter_register(void)
> +{
> +       int ret;
> +
> +       ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
> +       ret = bpf_iter_reg_target(&ksym_iter_reg_info);
> +       if (ret)
> +               pr_warn("Warning: could not register bpf ksym iterator: %d\n", ret);
> +       return ret;
> +}
> +
> +late_initcall(bpf_ksym_iter_register);
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
>  static inline int kallsyms_for_perf(void)
>  {
>  #ifdef CONFIG_PERF_EVENTS
> --
> 1.8.3.1
>
