Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2876F58DC74
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbiHIQv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiHIQv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:51:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1102B1CFD3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:51:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a18-20020a05600c349200b003a30de68697so912885wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iy/1XmBiuRbVyQ9VjMhkr31/h7f8V7s2+gD7x4clZGc=;
        b=RT+NGH10T+vxWyxJVnjXYJemGvYO3mFotDCID6F2SmpEVs1TffVJFCLoajxzr6unQ9
         xUL9KTjBNUPf5XnYYX7mKA6mvSJSAJzZjHDMkO8tLmhg67j6Okpv6FBbIcNJFi86FxaQ
         kIMAtkQBEQd1SyI/PB2LSfl6L8tkbtp7UOLzH48Jl1p+Mwq9yyaapKBicG04tJVFUW18
         w2iwrPE8BItD1UppLv0L78nBMeBjHAhpfoEy5UFKRJ0seC0LhkvY2KEQtmYC9+8f3ESw
         qrdpdYze/kNEWfibMCOW/Whprm22DyFBtDI++45WtDKbIouIoNJkvKXOrx0KDHXXzZYu
         9Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iy/1XmBiuRbVyQ9VjMhkr31/h7f8V7s2+gD7x4clZGc=;
        b=MTafo76flrlbAlWO3W8buikWXm/F/ZhX9PVUOX8mRB1vWFuSV0S8CsYWQzwtPvWyeb
         I8aU+bUWWD41Bgj/tKcCvJlSFF0ZcR5biSpnJZCmPgPib0FHWO4iO/Ij38Zxyp1jYcTF
         BdGv6W8EzFyqDmAEAzGxEY5on0wtuBIW8bqJ5zRHKzw/VB262UhEgsEf73T2X/OOFir0
         IaVwrdNc/mDBQ1KlivsSo7Jeoa26PVxIZG54AUy/Ll2EOHwV0VM1zxx/cRmPGwfYGpLO
         rn4So2hBhUKFCbMy9HOz3kfwvIx5SwcBpMpYJfi3wJfSjG3rQ+zCuzPtASAXvDZJsCih
         KLPQ==
X-Gm-Message-State: ACgBeo11bAEKWLmRwqAu9IKYn06tN5mdOz39tlMIVC+sj20dGHJ7mL5K
        P/GUy6s1wjvl930Qxb3dfsZjeGc89g3o7qfdksCzuQ==
X-Google-Smtp-Source: AA6agR71dk06F03/9JYr+c16z7iefxZq0eRPvLRcFoeXlx3ImCfDutuAbfBkIkc7V3Ck/8JlRnSrjtCiZc1Hu8Kvzrg=
X-Received: by 2002:a05:600c:25ce:b0:3a5:a3b7:bbfe with SMTP id
 14-20020a05600c25ce00b003a5a3b7bbfemr2156946wml.115.1660063884445; Tue, 09
 Aug 2022 09:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220809130758.12800-1-adrian.hunter@intel.com>
In-Reply-To: <20220809130758.12800-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 9 Aug 2022 09:51:12 -0700
Message-ID: <CAP-5=fWx_evrzai1Q_6FsowHG-V2H5jX58-s5AetJJcG4C0+2g@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix missing free of machine->kallsyms_filename
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 9, 2022 at 6:08 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add missing free of machine->kallsyms_filename to machine__exit().
>
> Fixes: a5367ecb5353 ("perf tools: Automatically use guest kcore_dir if present")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/machine.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index facc13fbf16e..2a16cae28407 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -236,6 +236,7 @@ void machine__exit(struct machine *machine)
>         zfree(&machine->root_dir);
>         zfree(&machine->mmap_name);
>         zfree(&machine->current_tid);
> +       zfree(&machine->kallsyms_filename);
>
>         for (i = 0; i < THREADS__TABLE_SIZE; i++) {
>                 struct threads *threads = &machine->threads[i];
> --
> 2.25.1
>
