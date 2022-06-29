Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246E8560BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiF2Vg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiF2VgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:36:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE633BA55
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:36:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y16so6435914lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8h16dBw6sz8iObiMOofBZlkMu51Vyu4qakRzQ8vggs=;
        b=Tvr3GdABTsiC5R8mfH5IZtdYKQmmgaMIZYsMfGKep9A6ApnT7WLJDwSwDCVW5aWxCE
         X3O3hcZnI8IOH4A8bD7+QWwafb6FCfOhp7iIqoi8qVrUPi0k2m96OuJDHJpiOLD7SYa5
         3bPjHWASkQJAzIZxoKEP6LWvCVsjwj7rVGpCXDj6cVPlGFDgpDhsy2qgOE7QU9DQdq9/
         aG0Yqj7jtoUvDZgvWreHL4uU5kpa4FncAiXWGYILJf16GBprjmBe4EEyi2wG525DNaGU
         M9rVcjcHeuPUQJOuIWi9gSyfgQBNs9Db1S/DqBhn8Id1Z/PWpV/SkZoC//IxYMyr+A6h
         WaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8h16dBw6sz8iObiMOofBZlkMu51Vyu4qakRzQ8vggs=;
        b=4jAouX9GR2Q7afVtPi3rF+jPb2ZIBlGhAXH6ENjcnBSmPy47/bOAV2NmEaaBkrDDAs
         lQJKIkkGXk/Sr6Wm16DD9+43tJ1ZFJFayZupKmKAe77ukfKf7nNVF2Gu3wh8KHvb2+02
         y+hCKQj/onMj9EtFpH4BFHpdLfuJbdKOd9IxPhL3bQe+a5dEoOf/PQ+Lb1+ZP5IaHFNw
         WUwzXkrloH+QYqgzW9M7ADrAm1w/qzwCJIgmLmHQ8gTmSG3GAuHi+lRszL/csHr6d/eX
         IxBsRyHG2b5pfvWvRkyp9MaaSZZ5cnV6jfkVHpi8AIGHPVC3tX5rIqI7+kl9c6Y8NNLS
         /PbA==
X-Gm-Message-State: AJIora956tiRLH1il/YznodUazD4MrajAHQIv0BOelcW5EKllDt0+FP2
        ZzFfanNEY7hfg94LPrcwAD7R83Fd4fNyaLz1lOs6YA==
X-Google-Smtp-Source: AGRyM1uSGPXGmFzglZU8sKDUqFQIIDNk10ImQ8Rh1d6LMvbsyslpO+AbuQTaEXGas+kuCXcld3gau0EoS71B6+4mgi8=
X-Received: by 2002:a05:6512:ac6:b0:47f:6f70:16e5 with SMTP id
 n6-20020a0565120ac600b0047f6f7016e5mr3477754lfu.170.1656538574425; Wed, 29
 Jun 2022 14:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220627224116.3015376-1-blakejones@google.com> <Yrwdm4eW+lFtByiZ@krava>
In-Reply-To: <Yrwdm4eW+lFtByiZ@krava>
From:   Blake Jones <blakejones@google.com>
Date:   Wed, 29 Jun 2022 14:36:03 -0700
Message-ID: <CAP_z_Cg4ZjfjYuCVZeCsReJZQnHrLZKvAk_Txb1OoiNojT3L6w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] Add a "-m" option to "perf buildid-list".
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

Thanks for taking a look at this!

On Wed, Jun 29, 2022 at 2:38 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > +static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
> > +{
> > +     const struct dso *dso = map->dso;
> > +     char bid_buf[SBUILD_ID_SIZE];
> > +
> > +     memset(bid_buf, 0, sizeof(bid_buf));
> > +     if (dso->has_build_id)
> > +             build_id__sprintf(&dso->bid, bid_buf);
> > +     printf("%s %16lx %16lx", bid_buf, map->start, map->end);
> > +     if (dso->long_name != NULL)
> > +             printf(" %s", dso->long_name);
>
> nit, should we display short_name in case long_name is missing?

I can do that.

> > +int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
> > +{
> > +     struct maps *maps = machine__kernel_maps(machine);
> > +     struct map *map;
> > +     int err = 0;
> > +
> > +     for (map = maps__first(maps); map != NULL; map = map__next(map)) {
> > +             if (fn(map, priv))
> > +                     err = -1;
>
> I think we should rather break in here and return user's error

I'd structured it this way to be analogous to machine_for_each_dso(),
immediately above it, but I'm happy to make this change.

> other than that, the patch looks good to me

Great, thanks! Updated patch coming shortly.

Blake
