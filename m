Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6664EB1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiC2Q1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiC2Q1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:27:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38822296C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:25:38 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b9so12723534ila.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QyDFxy0YW7xWZDfpc1FK0Ed2nDEvjN/mE8B1+6pJVAM=;
        b=n2XunwIM1rA43NFhSIbUPVLssT+4UHVAXlm3bJ+lXbjS6yoYiWHsPIbBBuSAjHDuU+
         rd7Yfcl2ZTSAoQRU0kCOKeq92TZ3F8E+gh3lnK4RnkMmOKJtDBqoARWDdtSaqwmQhK0F
         +6ccwF7KYXrSuI7PJS7aXjbFuly3vU1318Jj+WC/bVmB2RbTfQHQGTbWPmbB51WpXmbv
         qFSvgmyEaLcBcfu04KoqwKDb0UtBCN40pywq9gZpWPRZGyZV8EsMHWX5AWzaxvZ6zT8Q
         cNZAMRo+6VBA+SlsXfZ4zRmX7LG4lw1zkRpcaogldg3yjEWHuJL6T5ef/HYHXF7u5lIS
         +U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QyDFxy0YW7xWZDfpc1FK0Ed2nDEvjN/mE8B1+6pJVAM=;
        b=YMf3MySN1ROh4myI1yt0KNkRnO8UlOtSrP9YzcZZv2GfLvhlGc/8YVDKycFExK5Gun
         MtIGBN+RcUUWzqIEnm5b47Y7H17R1zMA+NdVuGAQ8Od+QSCRdx9zgKdAAnWz6ZcHTQOU
         7tCoh3Tp1sJicADl8ZiCu5oy2ibKvPbb+/khCMj5PAUaOH0Yvu8292MTR6Ypons1fhEk
         G/um0i/Jsc49/45PjyIW5yGUhwBTX6oSzXf6Lm3TbDHkJBGnfr4QP4mxoI87tFCBZc8+
         Kec/dvwWasqqtHdPCz8zjTZp0ny5LV888iHLmR2fpZ9OCe8Bf3wtIj/YzMqcJM5nRFfw
         r0nQ==
X-Gm-Message-State: AOAM5322Ym2A3VlA9EhiOdjRJjC+Nj5Id5jK7zlu5S3Q/zsBcSWW/VoO
        CgVu4qh0oJ0BLzpWGTMwBkxHlKM0yWZ5mv5ca8YwnsJR
X-Google-Smtp-Source: ABdhPJySqNEdI4uBBG5sDjay6ty0hl+VwFFmm5Fqk9usiIKb4IWFSUlY5daAkK2fklkzPoA5YokOuAETmxa3D+r4n1A=
X-Received: by 2002:a05:6e02:1a23:b0:2c9:c008:8ad6 with SMTP id
 g3-20020a056e021a2300b002c9c0088ad6mr4477604ile.98.1648571138158; Tue, 29 Mar
 2022 09:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <YkMb2SAIai2VeuUD@kernel.org>
In-Reply-To: <YkMb2SAIai2VeuUD@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 29 Mar 2022 09:25:27 -0700
Message-ID: <CAEf4Bza8Pwb1=Fky5fg6QZONsFrpMNtba=78=jWVVLRQmSxHQA@mail.gmail.com>
Subject: Re: [FYI PATCH 1/1] perf tools: Update copy of libbpf's hashmap.c
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?Q?Mauricio_V=C3=A1squez?= <mauricio@kinvolk.io>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 7:46 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Just FYI, I'm carrying this patch in the perf tools tree.
>

Cool. I have some tentative plans to do some more changes to hashmap
for improved API usability and performance, so you might need to pull
a few more patches in the near future.

> - Arnaldo
>
> ---
>
> To pick the changes in:
>
>   fba60b171a032283 ("libbpf: Use IS_ERR_OR_NULL() in hashmap__free()")
>
> That don't entail any changes in tools/perf.
>
> This addresses this perf build warning:
>
>   Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from =
latest version at 'tools/lib/bpf/hashmap.h'
>   diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
>
> Not a kernel ABI, its just that this uses the mechanism in place for
> checking kernel ABI files drift.
>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/hashmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
> index 3c20b126d60d869a..aeb09c2887162d16 100644
> --- a/tools/perf/util/hashmap.c
> +++ b/tools/perf/util/hashmap.c
> @@ -75,7 +75,7 @@ void hashmap__clear(struct hashmap *map)
>
>  void hashmap__free(struct hashmap *map)
>  {
> -       if (!map)
> +       if (IS_ERR_OR_NULL(map))
>                 return;
>
>         hashmap__clear(map);
> @@ -238,4 +238,3 @@ bool hashmap__delete(struct hashmap *map, const void =
*key,
>
>         return true;
>  }
> -
> --
> 2.35.1
>
