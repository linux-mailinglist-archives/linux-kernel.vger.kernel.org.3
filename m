Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05565B0923
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIGPsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIGPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:48:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10809B9F9B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:48:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d2so3985256wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JTKHE/mFfLQpKZtovEaQfx9ypT3LHElNlUe4JnUW+14=;
        b=WAsZiFgX+fq4TgLbLKr1C2FPzy0zzLEBiLGhl7S10aI8B0ejD7vbYjtqDhvYDJa+pq
         PwrI9N/oSp4hcM4LN9fCMzDwBq1+dkcniJuvhnsFiZarDf7DC8bcF7vuSWsy39sjh90O
         Dfn8uE41jAcGdO3HapuR782JId+uUmYm+6U2vbqg2YK8/9G2QCzVS1kV8HQfswKKfUlw
         1wG4my2b8huUlHI/VocGop8xusQkcOI1r9jhAqLUCsEcFWRv/sXpPknUrY0ckyNsdK9M
         9e9+/nkcCXAa69f4f4O0HmDmNaUGk0IeyrWptGlPZkzGxun3nJ9/gaQEbMI0xqfh4qfV
         2ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JTKHE/mFfLQpKZtovEaQfx9ypT3LHElNlUe4JnUW+14=;
        b=Ul4Oa+sI5KfafIxgwz/mCpZ7M9JvEQQKX3I4U9nQLUqqPo5XhzwqZlfmuiMrEC577w
         bI1Czm3PeNskof82J+T2UOn2cnxBkaXpsip2hiL3TUF0SEup9OZdud0xnl3mknOakOeJ
         eOKp8lSnIf9AJOKP8neOEr06MqfHMXWR6Jt8tyuBTVfIYRkwODnSC5oO9gr0DstibOUO
         +DuzgkpnjRot7Nb0W7b3ZYWc0QdU2PXX5keI5xI2xPlJ7/JObXOr0FHYTTDuMREwC5QS
         rReW+fma0ZsWma9vv2Yx06y0+9/2T6sLZ7kOpnZOFv/W44NkM8IEEmwVIrTP1VNq7ilI
         cM5g==
X-Gm-Message-State: ACgBeo3RnIKV1h+EqDUT2L6WHkl++3e8HCU2tDZyImRXH8JMlQ25hhLs
        KkjifYHKKkN7OgpRm3E2gn1EtTwcHNu/PYHwaGlnrQ==
X-Google-Smtp-Source: AA6agR6svjr5kCW9JMi5qqKrWFsmgmj9cfash5uryDYATh7wRkTgMyGmvfsaiACCUup2oI4IwUoDACFRH5ioOWAE1r0=
X-Received: by 2002:a5d:64a8:0:b0:226:f3f3:9914 with SMTP id
 m8-20020a5d64a8000000b00226f3f39914mr2416185wrp.343.1662565689640; Wed, 07
 Sep 2022 08:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220907071203.2729746-1-namhyung@kernel.org>
In-Reply-To: <20220907071203.2729746-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Sep 2022 08:47:57 -0700
Message-ID: <CAP-5=fXyY_aGYW4R-PZvzG3FiTtHvLfS+s9bp_oCQUaRCGrcwg@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Skip sigtrap test on old kernels
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Marco Elver <elver@google.com>,
        Song Liu <song@kernel.org>
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

On Wed, Sep 7, 2022 at 12:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> If it runs on an old kernel, perf_event_open would fail because of the
> new fields sigtrap and sig_data.  Just skipping the test could miss an
> actual bug in the kernel.
>
> Let's check BTF if it has the perf_event_attr.sigtrap field.
>
> Cc: Marco Elver <elver@google.com>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> * move #include under #ifdef
> * return true when BPF is not supported
> * update comment
>
>  tools/perf/tests/sigtrap.c | 50 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index e32ece90e164..cdf75eab6a8a 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -54,6 +54,48 @@ static struct perf_event_attr make_event_attr(void)
>         return attr;
>  }
>
> +#ifdef HAVE_BPF_SKEL
> +#include <bpf/btf.h>
> +
> +static bool attr_has_sigtrap(void)
> +{
> +       bool ret = false;
> +       struct btf *btf;
> +       const struct btf_type *t;
> +       const struct btf_member *m;
> +       const char *name;
> +       int i, id;
> +
> +       btf = btf__load_vmlinux_btf();
> +       if (btf == NULL) {
> +               /* should be an old kernel */
> +               return false;
> +       }
> +
> +       id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
> +       if (id < 0)
> +               goto out;
> +
> +       t = btf__type_by_id(btf, id);
> +       for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> +               name = btf__name_by_offset(btf, m->name_off);
> +               if (!strcmp(name, "sigtrap")) {
> +                       ret = true;
> +                       break;
> +               }
> +       }
> +out:
> +       btf__free(btf);
> +       return ret;
> +}
> +#else  /* !HAVE_BPF_SKEL */
> +static bool attr_has_sigtrap(void)
> +{
> +       /* to maintain current behavior */

nit: I don't think this comment will age well and the behavior of the
function is a bit counterintuitive. Perhaps:

/* If we don't have libbpf then guess we're on a newer kernel with
sigtrap support. This will mean the test will fail on older kernels.
*/

> +       return true;
> +}
> +#endif  /* HAVE_BPF_SKEL */
> +
>  static void
>  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
>  {
> @@ -139,7 +181,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>
>         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>         if (fd < 0) {
> -               pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> +               if (attr_has_sigtrap()) {
> +                       pr_debug("FAILED sys_perf_event_open(): %s\n",
> +                                str_error_r(errno, sbuf, sizeof(sbuf)));
> +               } else {
> +                       pr_debug("perf_event_attr doesn't have sigtrap\n");
> +                       ret = TEST_SKIP;
> +               }
>                 goto out_restore_sigaction;
>         }
>
> --
> 2.37.2.789.g6183377224-goog
>
