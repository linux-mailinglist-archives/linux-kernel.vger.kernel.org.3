Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF157AB08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiGTAh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiGTAhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:37:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD77A4E862
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:37:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e15so18688020wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgH1tvYEEyqwJwI8paE3cVCRS3k0UqWKM/aSARN/AlY=;
        b=IHQFVbJ2j/kFQMtawDxdtL48gU6cv5afOPcRO0W2ZDG5pvEKlX77+broRNagpeQ7La
         tEchT3E2a3zgqhdunNjx6KwUOvtdxW8bl0mjfc6+tOu7AVrxNqxjdEh9NtQhroPxNp3X
         173CTmYSLmwd7ZQNwaE7taU8Dj+FSIIn3iblCA0qS0tT3j9XER/csO/qwIcwD+YcpLqJ
         xv/XM84JfIBzAYedh7zwIdilNxafsYZBB+FEJ7+7nuw6BUWTbcfsXjtbzsD8qRpNrOmW
         ziNSJcC0KK+eZ4UPpHocVz7n+90suqMa6Cbovi1DzSEf26qGg7hz0ELGrC/eLL16/7YQ
         Xcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgH1tvYEEyqwJwI8paE3cVCRS3k0UqWKM/aSARN/AlY=;
        b=u1MgHYxODv4Smuf4nD6WN34eXoWtUj9466rORkboSpFgX7Fxp8O4f0VeLHPnqZcGuG
         pcsNVDLz+n3VXipM+rUbOUvVS/8J9GYl7FDQ1wzbAMlsnknBRORif69Yo56KbHLb4q10
         v4BcmNiqhBt0dFh5ViJFFPH4AW64lLxxXkpnWjN6lsco828fWnXRVcMbmQqxR/pweg84
         70HdRmIGGaYgnhB3xL6rc1fP1tcrln2rdjmxQrW7dY8THg+rK6YVbv5UrX6nAI5rpkJp
         3ysIyqhjQYOJxWpgslKzHJfvEJDOJJJv3d5UKjS+yw5EX1lNou/6sbs58XBbH8wuRSJB
         3K0w==
X-Gm-Message-State: AJIora/GlH0fxTS5x8D9s68GrX/j2BmFAJBimQ0JmOYiqif1j7otPnks
        tVj1d2oDG8/4jXAJlpo29/aY/TqqzlZHqCsPp2grWA==
X-Google-Smtp-Source: AGRyM1vBIk0Bn9MU6iede+X74KkkMjq/dsZs7yta7t6pINmUxXjkocvZi/cehVzzSEMz5IxQGmQxmEM1tG8297o+viA=
X-Received: by 2002:a5d:4d8e:0:b0:21d:68d4:56eb with SMTP id
 b14-20020a5d4d8e000000b0021d68d456ebmr27742751wru.40.1658277472130; Tue, 19
 Jul 2022 17:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-15-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-15-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 17:37:40 -0700
Message-ID: <CAP-5=fW2UaXJbDB7_YMWCQBEzJLVyBCOCx=tQv-0Ku-iyf-=+A@mail.gmail.com>
Subject: Re: [PATCH 14/35] perf tools: Use sample->machine_pid to find guest machine
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 2:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> If machine_pid is set, use it to find the guest machine.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/session.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 91a091c35945..f3e9fa557bc9 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1418,7 +1418,9 @@ static struct machine *machines__find_for_cpumode(struct machines *machines,
>              (sample->cpumode == PERF_RECORD_MISC_GUEST_USER))) {
>                 u32 pid;
>
> -               if (event->header.type == PERF_RECORD_MMAP
> +               if (sample->machine_pid)
> +                       pid = sample->machine_pid;
> +               else if (event->header.type == PERF_RECORD_MMAP
>                     || event->header.type == PERF_RECORD_MMAP2)
>                         pid = event->mmap.pid;
>                 else
> --
> 2.25.1
>
