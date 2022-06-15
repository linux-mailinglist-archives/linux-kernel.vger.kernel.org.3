Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916D654BE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiFOAKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiFOAKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:10:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF044488B8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:10:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j6so979731lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZT+Efo6l+fWT1GirYyYwbz0NJsp81iiUhfjEirzp/k=;
        b=LJsnOP4CoKnvqaCcnqWlC4bwcEXcXTiyFVB96RpleJz6aoN2TOWXDruPGAL1t4uyav
         fRwNhAGBhBCG9FfgAJ3paUHXoFOmWAnAYo1suprtZZ5mS25tQZhwbQv5FyI4sSd70YS5
         4iXFdClQRAb4nXx27awSKYV5VKjXYyh/yvDxkXzfADWYsMrv9kWXj6lqX392Jp0L5Q+M
         RDCj8GS+HyFvJrKemFToSdK9WwmAtasMd38Kf+NkdI70HOZ8A3ykXi6gR0SaKrJY9Ils
         E0AXh2805qHeURJmVGo7/Yvc/7e+kFMmIUCTpAoz7cqgZ/Ep3kXXQ2MoSBlIpIlTi9El
         knfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZT+Efo6l+fWT1GirYyYwbz0NJsp81iiUhfjEirzp/k=;
        b=C3FfQM1vcZZ3qKW7xwNRYbkC+eUN08A1v3+Vgrwxy0Md0Xmm8eW/xnWWMxrQVUelTO
         wgSIycogkdZyzc5glzMzWB743WQRDMu+NdSCOt8dizcg82eYGImQUpZBoDuekRFCS9eM
         7fkArF+GskQQ0kjRZB1mFRoP5LXZLSzYs5uFkhxHSLc4r6EsRfPfJVIUI3/ygaDVs2vV
         CJXP6NK35tCJ8IPrdRBYpSdFO5B56SXigIZKNk8REM0+1Kd6+3n2mgsM5um2TU5/bGrt
         bgA/evN5lkE3NRNjur/PlD+P/cYTBOjTPRuqpLDcPTOEB/GwHFRvi4AcPJysl0HAatuT
         /WxQ==
X-Gm-Message-State: AJIora8h/eiuNp33GSh5C81XepRS4LFlmFJC5tZ3h7o2dRXhdMVqr2A6
        H+oTOv/bpmMMn8vcYvHsplrgOaxlb6NYQ2AHd/A9Fw==
X-Google-Smtp-Source: AGRyM1tc8Y8MD8cs3DZZWCSYKv3VbS7+QZXAjenyYqIarR/gDOwbvsPN4LNGaN/+GpwS+/adL0KUFlgsnQ6JCoCkOaE=
X-Received: by 2002:a05:651c:44f:b0:255:889c:d100 with SMTP id
 g15-20020a05651c044f00b00255889cd100mr3827072ljg.352.1655251820395; Tue, 14
 Jun 2022 17:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220607191550.4141024-1-blakejones@google.com>
 <YqZmSRS8UPQJzWFE@krava> <CAP_z_CgkJ8RgWevJnDiq-+JjB=ni0OzJ3npwW+S9RZ66i0Y3Kg@mail.gmail.com>
 <Yqh/EkVy99Bej46S@krava>
In-Reply-To: <Yqh/EkVy99Bej46S@krava>
From:   Blake Jones <blakejones@google.com>
Date:   Tue, 14 Jun 2022 17:10:09 -0700
Message-ID: <CAP_z_Ci+Zm5v33hc-WaaLKj9ruJtBY-FMVhrcR7ZX1uJdquLvA@mail.gmail.com>
Subject: Re: [PATCH RESEND] Add a "-m" option to "perf buildid-list".
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 5:29 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> still there's kernel map included, so it's strange to me call it modules
>
>   --m/--kernel-maps ?

Sure, I'll go with that.

> > > also please state that it's from running kernel
> >
> > Happy to make this change.
> >
> > > any reason why not use the dso fields directly?
> >
> > I was just following my general software engineering instincts to
> > encapsulate implementation details, so that e.g. the caller doesn't need to
> > know about details such as the "has_build_id" boolean. I haven't made
> > changes to perf before, so if that's not the preferred style, I can do it
> > a different way.
>
> we have some helpers for dso fields, but AFAICS long_name and has_build_id
> are used directly all over the place

Okay, I've switched the code over to use those fields directly.

New patch coming shortly.

Blake
