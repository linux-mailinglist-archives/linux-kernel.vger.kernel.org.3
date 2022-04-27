Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1062512757
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiD0XKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiD0XKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:10:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A9E4F9FD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:07:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m62so1941784wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCMuMxFVDueXSdsssZ7NkvR2GebkCDSm3O2foS8iyt0=;
        b=lI03Sf6n1sFHiTmB3QuhD2zTIpq2cQaW9ilXhtkjF+ugvzsH8im7FgHQByrq960XNv
         +PudeiasGjWqQsZ9eq9+aUe1TDWptD89pBn7jXPIU5iELE5eIYaLjgSEX71trF6mkMeA
         1ZmaWbOLmZwXk0K+jfK3C98Duq0l+wREvqWA8T1e5JBN9z6zU0H7+n1KHHchR7rkVzIj
         LpNhgP0SAGX2MQ2n9MLo9azwBX78Vvn4Jo1xmitsUBQljGQkdd76ga29sQx3ZvVWkM+S
         UMjFrTKITNp+wJ9AYUuTJ3i+g5mMCyJntgDRBihhidQUDBtuKVrUrxH663Zj5y02z/ds
         q15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCMuMxFVDueXSdsssZ7NkvR2GebkCDSm3O2foS8iyt0=;
        b=FotYyi+TpK7v+SXMzsUR8Erv3c/qQXRixHh61tE3xKvMvsZmWaR6nVqJCAk5I7wF1h
         8jYGRIjS1z7siV5ulxiVKkUkgG2tsKftZI8kj8ksmEFsawVpv8r096Wu8/zrPHBuxiJn
         UsGwuR4FI4szWOvzX8PKUtPl07MUtkMKiV6H4VjBryTsgMzR2M/BNeEQtuoYePM3Rnf2
         Gy1jN+B/QGaBAdYnvYFo9DvD5aD4ANYif/LBWzBD2H3XhCKlCM75qz4zV9eZqiwNqGTd
         NTOKiAlnfp2tLtnfUytMPiWi+UJCe1MVUtLdqrxCOFyfbAz5yjmIyPXWZnCOSWv74Yhd
         AZUg==
X-Gm-Message-State: AOAM5337stk1QYLAT4Z7AlaS5Z61e1PoSYuSdXNH6qviJbu7/6ZkAzVh
        k6owAhLZh+f332vh+YVwHzW9x2RzTdgVgpKqcCjc512kggM=
X-Google-Smtp-Source: ABdhPJz76n8vrNwnrnWIGpRemBC6D8/Dji5ku3bVo0ANrd/hiH+XDReSHjhODQT92FyrlaNmynjVZKLvV0H/Zhl2w5I=
X-Received: by 2002:a1c:f605:0:b0:37b:b5de:89a0 with SMTP id
 w5-20020a1cf605000000b0037bb5de89a0mr27476548wmc.88.1651100856343; Wed, 27
 Apr 2022 16:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220422150507.222488-1-namhyung@kernel.org> <20220422150507.222488-3-namhyung@kernel.org>
In-Reply-To: <20220422150507.222488-3-namhyung@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 27 Apr 2022 16:07:25 -0700
Message-ID: <CA+khW7gvDaDiA458StkOEvUfvr1Rx4d65+530z2tq52VkJqaoA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf record: Enable off-cpu analysis with BPF
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Fri, Apr 22, 2022 at 8:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
>

[...]

>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Makefile.perf               |   1 +
>  tools/perf/builtin-record.c            |  21 +++
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/bpf_off_cpu.c          | 208 +++++++++++++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 137 ++++++++++++++++
>  tools/perf/util/off_cpu.h              |  22 +++
>  6 files changed, 390 insertions(+)
>  create mode 100644 tools/perf/util/bpf_off_cpu.c
>  create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c
>  create mode 100644 tools/perf/util/off_cpu.h
>

[...]

> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> new file mode 100644
> index 000000000000..2bc6f7cc59ea
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(struct tstamp_data));
> +       __uint(max_entries, MAX_ENTRIES);
> +} tstamp SEC(".maps");

I think using task local storage for this tstamp would be more
efficient. There is an example in
tools/bpf/runqslower/runqslower.bpf.c
