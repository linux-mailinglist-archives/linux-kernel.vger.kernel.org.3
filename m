Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C359D52AE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiEQXbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiEQXbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:31:42 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6C8140C0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:31:41 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id a23-20020a4ad5d7000000b0035ee70da7a9so112329oot.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbJnv+Q8W2lOneYxVgQd5toq0C0HnubkZSjTfIJJzkg=;
        b=kNIun7Wvg7EdkIRwWpe5pZdHGveMlW9MuwiM1zuqDj73/GELZDZe8RaqXh9T9Bdt8d
         Fy/4zmV8yoBGOSxTRm4H3+xXortOT4JqTrfW+Aj5AREEXmxH/ks5MW+w+ezkGgHDUbkP
         b1HHBbaBQn7hCi04ngl0F2cCWUha8eEOmhofLOSXY3jSGQ7pLkJlZVKszj83figwfnyS
         YAuJvIHgHBC3a8ycFIAPqtYT6syg5HATjZzTmk1Tpz/usqeZAiYaq8Iu3Rc7mYJ6b1em
         E9/p06FxbJ7nz6pl+VO2PvLZe/pGhyIVzy1NwBpjSlMwFUjx7VoPjVreHVMrBniZKgdr
         n5+Q==
X-Gm-Message-State: AOAM532xzvH0SQlAUk56ltCyS0/5YYfKabIIMBeeM60dawCw9e2LJi0c
        xAxyO5bPpGmezUtkxD2TksIJeeL7C9QZ407JWpw=
X-Google-Smtp-Source: ABdhPJy40dAnhDXUTMK3mIZZbpZmb6u5LYDrp3paBvJgncJ/GFnX8jLyPyelIBdvD+F2DwU9ymcRKknicBJMj3rgSmY=
X-Received: by 2002:a4a:d102:0:b0:35f:7825:195a with SMTP id
 k2-20020a4ad102000000b0035f7825195amr9024078oor.44.1652830300405; Tue, 17 May
 2022 16:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-23-adrian.hunter@intel.com> <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
 <52f201d4-4fab-c2f4-9c4d-af887900732f@intel.com> <CAM9d7cgDCd2uUJbWcvqmCDGMoPc9kppx--_rcO2OVp_GarLJkg@mail.gmail.com>
 <f92a7681-30ca-eaf5-6f3e-de54bc19adec@intel.com> <Yn+wJlzymeAaHHcI@kernel.org>
In-Reply-To: <Yn+wJlzymeAaHHcI@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 May 2022 16:31:29 -0700
Message-ID: <CAM9d7cjJups443_V8062cFWn3XNxGCnjM1FeWU9_AHnJnibjVg@mail.gmail.com>
Subject: Re: [PATCH V2 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 6:35 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, May 13, 2022 at 07:48:40AM +0300, Adrian Hunter escreveu:
> > On 12/05/22 21:53, Namhyung Kim wrote:
> > > I'm not sure if it's intended.  I expect it runs on
> > > cpu 0 or one of the given cpus.  Or it runs on both
> > > cpus and returns value in half so that the sum is
> > > the same as the original value (from a cpu).
> >
> > I don't know if there is anything wrong with the way
> > we are handling uncore PMUs, except that I don't know
> > if it is documented anywhere.
>
> Good thing about this conversation is that it will result in
> documentation :-)
>
> Thank you guys for having it and detailing it so nicely.

To move things forward,

Acked-by: Namhyung Kim <namhyung@kernel.org>

for the patchset.  I'll try to cleanup the cpu map propagation
with hybrid events later.

Thanks,
Namhyung
