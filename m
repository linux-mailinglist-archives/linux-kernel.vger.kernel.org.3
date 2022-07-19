Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F957A464
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiGSQ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiGSQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:56:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CADE4A804
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:56:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h17so22577662wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGiA6ckYRiubKjgpRJXUtNtdjW9CpRo2ZKSumqtjes8=;
        b=c/q9gFkWi8Ec4wGMmFvun9zo+/LIbDeMaMKwcrXbQWo0rQesInT//edyGk5wYGc78D
         svpmR36zodRYVVyXkCzQBEw0OS2MuwOXvSZXsMvZ2yHfs7WfajS9Q8ztNuiYry8fOc+i
         BtSTTBp7Dy4zHfT0ODMmWp+jIuY+bmtJBOK4KOeha0KWAZKcPVBNbmqZr0ABqad+Tvrv
         kzb2W0riTOCx9S5qKVG5cP6IWHbVRlbDboCfDmy0WBf3oiVXtVkwGUc2TMSztA+jlth5
         ypRACkDQnR+L83TE224+uq75z1ival1O0Sunq3ROeAgFPYI4mf/bjMXKRjkl/+bt7QnC
         NKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGiA6ckYRiubKjgpRJXUtNtdjW9CpRo2ZKSumqtjes8=;
        b=3Dk8QN+NPdmdGKykJa/g/ztG4Lt90Wwn3whxM4Th/ivgSzBNBYUaOnonXKRDEC6cHB
         XcQLinaibBO5ycQgOhZYvxwfqkVV7V/9IIV6sXa5Gzit1XaskrqcGH8nKQmPIwuN3Xym
         TULplFHzStK07mBe0qSnK/58BtIlQal1NpkdygB8pLe5faSnUpdERyfj1mLKxls/YFeZ
         ZkHmKlD5CnBeDZGydXWmxiKF+gntT2dlxTwgR2DDAf8JH+iP2cnaTe5AH0i/6H1UBfl5
         mq+jjx6yGrUDbJLsLMJlkiUJ+Mi75jkEcNQyjVM/OARfibPX0mWO42WGrxQHv3mXv+ms
         oItw==
X-Gm-Message-State: AJIora/G/r1MYniCdVaKSLdFG5XBF+cK/1ow0pRdWEMJKafezv9B1OpW
        uYMnVycGd++aXHSjQdd7l/1XYIssob7dkT2liX3ArciOKTqeVw==
X-Google-Smtp-Source: AGRyM1u+nGoF3aNLBHbjiNHtUbf7L583xpdSE+hNRiQ3pEMVcPk8iojvNZpzMEuEhSVRlqxslbs6wF/2Qwk5ehx9790=
X-Received: by 2002:a5d:4d8e:0:b0:21d:68d4:56eb with SMTP id
 b14-20020a5d4d8e000000b0021d68d456ebmr26769704wru.40.1658249760787; Tue, 19
 Jul 2022 09:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-3-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-3-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 09:55:48 -0700
Message-ID: <CAP-5=fXVrKir6VfkDOQ+sK-vqs-aCNBCu5uUVNAUPzW=G-z=cg@mail.gmail.com>
Subject: Re: [PATCH 02/35] perf tools: Export dsos__for_each_with_build_id()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
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

On Mon, Jul 11, 2022 at 2:32 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Export dsos__for_each_with_build_id() so it can be used elsewhere.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/build-id.c | 6 ------
>  tools/perf/util/dso.h      | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 328668f38c69..4c9093b64d1f 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -300,12 +300,6 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>         return __dso__build_id_filename(dso, bf, size, is_debug, is_kallsyms);
>  }
>
> -#define dsos__for_each_with_build_id(pos, head)        \
> -       list_for_each_entry(pos, head, node)    \
> -               if (!pos->has_build_id)         \
> -                       continue;               \
> -               else
> -
>  static int write_buildid(const char *name, size_t name_len, struct build_id *bid,
>                          pid_t pid, u16 misc, struct feat_fd *fd)
>  {
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 97047a11282b..66981c7a9a18 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -227,6 +227,12 @@ struct dso {
>  #define dso__for_each_symbol(dso, pos, n)      \
>         symbols__for_each_entry(&(dso)->symbols, pos, n)
>
> +#define dsos__for_each_with_build_id(pos, head)        \
> +       list_for_each_entry(pos, head, node)    \
> +               if (!pos->has_build_id)         \
> +                       continue;               \
> +               else
> +
>  static inline void dso__set_loaded(struct dso *dso)
>  {
>         dso->loaded = true;
> --
> 2.25.1
>
