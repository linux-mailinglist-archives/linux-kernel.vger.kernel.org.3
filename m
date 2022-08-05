Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B7C58B279
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 00:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiHEWjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 18:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiHEWje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:39:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E71AF15
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 15:39:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v5so2024731wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=a4+alUb2V+A+FrnxdAfx95t0xsifhWlq+vFrSrgmIiw=;
        b=GLKZ3acW7kyjSzl8FTgV7hTdmon7BqyPQJ9gE7JaEMFcR609IsISTVm1E2MPaaMOB2
         bDT5IiITAqvcb/od/wDtbLYaiCF/q/CPhQqI0eAhe7tVfC73sI/hqY8ewv2ZZH4iDNy/
         +q2EycnykKC1/E91JFv9KG312V+rrS9wpRWbr0H+Aai1ctTHKe6hViIDegmpPOL0fDOg
         fC0hM154DKNYySj7EEkhzp1no6yVpdNJ1t4EKTw0sY0+WwOVnpx/9SvppwkVxg9pIC7Q
         Q/U66K4J+HOeN3qfrYlHQbVGyhRsbW4PmPRoiEz4/b61aG2N4Cuzpab/ab9XCTfIeI7Y
         CfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=a4+alUb2V+A+FrnxdAfx95t0xsifhWlq+vFrSrgmIiw=;
        b=VMeE4Pa+uKhm6Y8BoKmYi1hJFdPaLHthzDKsnulfbnDS6tlPB/CgTbabfaYw4oS9aB
         cw+skrfjT5vjJktNsSQ3n0vHV555wmYsrQvXCLKI3/B4OAlPwU/I//WRLy54z8rNNcop
         6UlArkZ4tfOzBoCo3zEbvJbx+LgbrpaVTnQepwd6FyG9T9xh8NTmxydrfLDkQm87cIQ7
         NNh0sSxUiv84H/arDP/wkuVsaWF8S0VfFHfBIl/Yfvr+tRhMIsLeYSKDIlSRXklRZ95x
         GQ2JjG86Sg7yAjHsb+savMv6pFSBLA/sHKLZU7FPQVfKhW9eOVEwyISCazAH6UVtw5ko
         XOwQ==
X-Gm-Message-State: ACgBeo0bURh7j1/wh1Et+JKpVaS6xCaX5vCRCyRAAZPOSkK8EdxMDeVj
        4CN43kpp9/lfdZJSkZusYdPJXD5zrAxSAFXaacMbZQ==
X-Google-Smtp-Source: AA6agR7AHekHXLe5no7RXaVKXf0rP2CNhnvxhSm2gC5BYXCEhjXzSalxmhI9FqE9JMTUwofhlW4WId6korNGY+Dg5C4=
X-Received: by 2002:a05:600c:4e86:b0:3a3:417a:2fcd with SMTP id
 f6-20020a05600c4e8600b003a3417a2fcdmr6046018wmq.149.1659739172136; Fri, 05
 Aug 2022 15:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220805220645.95855-1-brianrob@linux.microsoft.com>
In-Reply-To: <20220805220645.95855-1-brianrob@linux.microsoft.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 5 Aug 2022 15:39:20 -0700
Message-ID: <CAP-5=fVhwVcNqr+z+KfUrH1Rq=3sbrkwX3U1nZBbW6_ASVp13w@mail.gmail.com>
Subject: Re: [PATCH v2] perf inject jit: Ignore memfd and anonymous mmap
 events if jitdump present
To:     Brian Robbins <brianrob@linux.microsoft.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 5, 2022 at 3:06 PM Brian Robbins
<brianrob@linux.microsoft.com> wrote:
>
> Some processes store jitted code in memfd mappings to avoid having rwx
> mappings.  These processes map the code with a writeable mapping and a
> read-execute mapping.  They write the code using the writeable mapping
> and then unmap the writeable mapping.  All subsequent execution is
> through the read-execute mapping.
>
> perf inject --jit ignores //anon* mappings for each process where a
> jitdump is present because it expects to inject mmap events for each
> jitted code range, and said jitted code ranges will overlap with the
> //anon* mappings.
>
> Ignore /memfd: and [anon:* mappings so that jitted code contained in
> /memfd: and [anon:* mappings is treated the same way as jitted code
> contained in //anon* mappings.
>
> Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/jitdump.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index a23255773c60..4e6632203704 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -845,8 +845,13 @@ jit_process(struct perf_session *session,
>         if (jit_detect(filename, pid, nsi)) {
>                 nsinfo__put(nsi);
>
> -               // Strip //anon* mmaps if we processed a jitdump for this pid
> -               if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
> +               /*
> +                * Strip //anon*, [anon:* and /memfd:* mmaps if we processed a jitdump for this pid
> +                */
> +               if (jit_has_pid(machine, pid) &&
> +                       ((strncmp(filename, "//anon", 6) == 0) ||
> +                        (strncmp(filename, "[anon:", 6) == 0) ||
> +                        (strncmp(filename, "/memfd:", 7) == 0)))
>                         return 1;
>
>                 return 0;
> --
> 2.25.1
>
