Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9248653BDC2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiFBSId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiFBSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:08:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F6327CF2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:08:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e29so1692665wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HxLJgZtlHlK+K1gWFxW+a6tTn7Jn/932cs76W+wS5Q=;
        b=gXafYBazVGRnUdC1FD29atbaAVADiZ30i2Q/SVfn9cd8GZ7W0bWCWgy9yYb4jP8Oyu
         4hZmNacxn7qtAKDYOAQww+NmI4Hw7kk2P3klC22Jp8JrNyrVrHt6EtB7O+B0nWFZXw2t
         5fIy3zrAmE30DcEWfjsDrytlixzdc+lEhAJnTO/Pgu6lScO38ihATUwxB5utWsKxmcX8
         jkyCudn18LKGqzX9vJCyCtySxJo8QZeoebRRyDfu0FOin/VmtfLJWRjQtw4RUkHWf1rN
         TYZtwE+lCZ7vqpVYB7IDg4TLGvhdp0SsFsbGAfyqqC5/sg0GZpc5WFCD1Nh5jaF+2eO4
         QKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HxLJgZtlHlK+K1gWFxW+a6tTn7Jn/932cs76W+wS5Q=;
        b=6UkjCflVIIQWpYyCDgprhuDY1W7r7LyUDER6KhmTVdXXd4wPW8938FoU975uQx7MqR
         kz1ZXOoIe4pvLCnW45dyM7Fjpm2YUWDbiEz9iLAlUnxzNLbFNIGpBfSIlf+3sPeS8o5w
         V4pkX1VEHjwIGAVAJl4gIIFqx4gF+VSWuvSQtaDJZOqU7gc1rQnaZOdCsnuC3inuZPy9
         scF25jgbWzc1gU9Vp0TcvxPpE75o17Yn8zVlqevwdLQ5L+FxMhLzqnm+KmDEtaAyuRUv
         OAhRZGI3fkgoxmNUCI0/izEHa4L96MeCSE+xOMAp8d51ph+dyZhQhm2H3ZtrcHBur3u8
         gf4g==
X-Gm-Message-State: AOAM5319obbWtRUz0FaU6oZYfdaaf0C+vpEkZWhEQU0vpgV7y1SwGORb
        cHylG1AUbDlRnVVXxeai9u66YKyQ2N3Nv3qM9BnY4w==
X-Google-Smtp-Source: ABdhPJx5VCLYk+0/TVaEONygVnf++20yjQxm00tLoQZlGTbIZHx/1Gzbn0dkLv78dOY0suJYq+GgxsJlg8zECz0C21E=
X-Received: by 2002:adf:f5c4:0:b0:210:2ac2:6aa0 with SMTP id
 k4-20020adff5c4000000b002102ac26aa0mr4671812wrp.300.1654193300494; Thu, 02
 Jun 2022 11:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220525154114.718321-1-james.clark@arm.com> <20220525154114.718321-2-james.clark@arm.com>
 <b6cf9d34-313e-6b7d-3781-a8a5af203cd6@arm.com>
In-Reply-To: <b6cf9d34-313e-6b7d-3781-a8a5af203cd6@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Jun 2022 11:08:07 -0700
Message-ID: <CAP-5=fX6r31X7HeB-H4MjqwXMcdMSkzMzTk8Nr9F2=daQYhH3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf tools: arm64: Use perf's copy of kernel headers
To:     German Gomez <german.gomez@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        broonie@kernel.org, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        john.garry@huawei.com, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
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

On Wed, May 25, 2022 at 8:59 AM German Gomez <german.gomez@arm.com> wrote:
>
>
> On 25/05/2022 16:41, James Clark wrote:
> > Fix this include path to use perf's copy of the kernel header
> > rather than the one from the root of the repo.
> >
> > This fixes build errors when only applying the perf tools
> > part of a patchset rather than both sides.
> >
> > Reported-by: German Gomez <german.gomez@arm.com>
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Without this change "make -C tools/perf" was failing if kernel-side changes weren't applied
>
> Tested-by: German Gomez <german.gomez@arm.com>
>
> Thanks,
> German

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/util/libunwind/arm64.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
> > index 15f60fd09424..014d82159656 100644
> > --- a/tools/perf/util/libunwind/arm64.c
> > +++ b/tools/perf/util/libunwind/arm64.c
> > @@ -24,7 +24,7 @@
> >  #include "unwind.h"
> >  #include "libunwind-aarch64.h"
> >  #define perf_event_arm_regs perf_event_arm64_regs
> > -#include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
> > +#include <../../../arch/arm64/include/uapi/asm/perf_regs.h>
> >  #undef perf_event_arm_regs
> >  #include "../../arch/arm64/util/unwind-libunwind.c"
> >
