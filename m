Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890C522626
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiEJVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiEJVMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:12:30 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F5A2670AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:12:28 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e17so299805qvj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYVHi22m1+mXSFa7Nc0RAjeQBwpnm2Xj7XiJSm9Cw/Q=;
        b=bg0OJPq+1ifxyjjTiknBIfD7bywHGJRstK0TY4IrD//sypqPQuAu3G5PLlFk8jLsA8
         BEQB49EYqZHFcSpANBU9k4Y4McljWHHn2nRCFpO5phZwcXHOwS+0YCcMXrkqWuM2yrPi
         CyKeidXdVQPHVG6HF5DB6+aF6PCg7NLaSemz7x8nLmDOcotb7t/kqV/y62a4g6mQjj0D
         WTAVCIve7Uw+uKvbL0lArYC8g7crryu2JrsgF2yAeDqDPrj42kkWhTaSjTVlUcz7xGi1
         XdNRaMFLU5TIpjY4TmcWhK5EdQ+fYDZNJOTnvtHUVaNSVIwMzJ/RrAqI8ijt0Lz1unjN
         hh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYVHi22m1+mXSFa7Nc0RAjeQBwpnm2Xj7XiJSm9Cw/Q=;
        b=L1xGCETEgTDKTgDgvyS+nySFDlrLoXRW6Uny+Sq2G/FNuC9iyN1Fih03i6HUWS5dpb
         Ai0izI8Ydpo0Y5nSSdKgksa10IIFVXMb84WjuIKUotmUCpkGR2euexz0fnJQZuuY0shW
         wMPqDzoLpf5OZgw8wbpa/wk6kTmXpdygMVOhlMYfu+gebzRVRmgheHgk2tlkYqVJoyBT
         xUgHcnYI+7mhsFDjsc2jSFoMrLTsIHwoIBPM9aSZFGvoiA9hl5wjb2rIN2AwWrMCs7jQ
         3RgKj8Y4HHWIEqfWR42TnVwqmg14XEdQc3SpkDuYxzkuafphYtAAtH0y6cJPnMJwo+9H
         1QHQ==
X-Gm-Message-State: AOAM5336/l+T3AmY8bH9C4baRUxdYCnIzsxaWaXpCsnoSzgrsNBnGkNx
        sY9wCppdeI/OGLW0nIqo/df23dVarbtzykrIQeILXQ==
X-Google-Smtp-Source: ABdhPJwAcCwCJeGY/PbbQTEOy1WFFk31KQkfG7qJ7XtUwaSdP+qPOIHxjDRC9A/Yzd+WuzSVbR54vLjJfgZqyGIwmRQ=
X-Received: by 2002:ad4:4753:0:b0:456:34db:614b with SMTP id
 c19-20020ad44753000000b0045634db614bmr19646103qvx.17.1652217147364; Tue, 10
 May 2022 14:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com>
 <20220510001807.4132027-9-yosryahmed@google.com> <Ynq04gC1l7C2tx6o@slm.duckdns.org>
In-Reply-To: <Ynq04gC1l7C2tx6o@slm.duckdns.org>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 10 May 2022 14:12:16 -0700
Message-ID: <CA+khW7girnNwap1ABN1a4XuvkEEnmkztTV+fsuC3MsxNeB08Yg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 8/9] bpf: Introduce cgroup iter
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org
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

Hello Tejun,

On Tue, May 10, 2022 at 11:54 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, May 10, 2022 at 12:18:06AM +0000, Yosry Ahmed wrote:
> > From: Hao Luo <haoluo@google.com>
> >
> > Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
> > iter doesn't iterate a set of kernel objects. Instead, it is supposed to
> > be parameterized by a cgroup id and prints only that cgroup. So one
> > needs to specify a target cgroup id when attaching this iter. The target
> > cgroup's state can be read out via a link of this iter.
>
> Is there a reason why this can't be a proper iterator which supports
> lseek64() to locate a specific cgroup?
>

There are two reasons:

- Bpf_iter assumes no_llseek. I haven't looked closely on why this is
so and whether we can add its support.

- Second, the name 'iter' in this patch is misleading. What this patch
really does is reusing the functionality of dumping in bpf_iter.
'Dumper' is a better name. We want to create one file in bpffs for
each cgroup. We are essentially just iterating a set of one single
element.

> Thanks.

>
> --
> tejun
