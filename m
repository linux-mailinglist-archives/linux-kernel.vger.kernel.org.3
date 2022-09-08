Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF335B1620
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiIHH7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiIHH72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:59:28 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1878CCE38
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:59:19 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-333a4a5d495so154951317b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AED3bGnj1lFXZEETrGBbS5jh6P5l9CcrTpBF9lOrNE0=;
        b=HkUFRA8CPFJAvpaFZE0A48bh8ebNvRB0c9TxZNw2wdVrMoeLJdR4QnLUPPcniJEcKY
         VNaFMEeLnmR7AJ9Lbgz25CYZ94/GBFshTL5meP9gXvTjKp6JSXBNwu1vmE3RdSN+oxET
         0pKAeWTyTxvf9nXIJYIVEG7+0eeGUB3FAh/IYdLo1NfWohokuzLXDvbWU6mF9v+UKcUd
         pVlXqPU7xT9Zm+riPxfay1Dr8EHuoKrj2TOgjNijoKvfzP+kMXfiQje1gC3rVWy4ZtDs
         YAA/J1b5zmDei7hTit3O4zQ+eNvcbntqnMQB2lnuY+1qegnjgPbTWdVMZTw1i1yH2GDj
         +RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AED3bGnj1lFXZEETrGBbS5jh6P5l9CcrTpBF9lOrNE0=;
        b=jlsPIu4StdqhmyOTv2dXAuhxP2Ah98a4R5hsZ4Qu8dL2Tle6g1zC7RsjHekJQOOPyJ
         G8P7tK+ywUORJVdfbIW/Yfwk7ILYLmFpWMSaDvchh9vCPUsZ7ujrouRcrsQE3YUqEHDV
         EDKtjjxtXuOQQygzqVi3w/R7PhIDd5gFn7AXXF/x9owiFMTbVp8UvdhFE1A9aK1uwbaF
         q763n7AJn7A9UqIywr+4e+BwQ+ZFTL4WkUbThyfr+5mh6SoEcTFGpAZaVADjl8dhgXvJ
         D7kfErRcQePh1gOTK9xSV96FyrKZtOLNqH0WzauGR7vOGq31uKXqvM40jkrNL+UuvgM0
         bIYw==
X-Gm-Message-State: ACgBeo2Q2Dvue25aQSN5J4M5USj20GHJpwMklGyKDxrqSTYhZUcUFIRF
        EEsfqjy5D3RhoOHrHIQKfT68pRuU0zSBs8F9VeavOQ==
X-Google-Smtp-Source: AA6agR4X0jTEHkYV5U40zvcN89k17FaKDFHNabGZ3PT+KFUU19cT6H4djk8nh2JaC2JxqJ8Gtff8FgF8cCPzupgqq20=
X-Received: by 2002:a81:a16:0:b0:345:afa:5961 with SMTP id 22-20020a810a16000000b003450afa5961mr6297647ywk.11.1662623958715;
 Thu, 08 Sep 2022 00:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220902100057.404817-1-elver@google.com> <YxiQ87X1eUB2rrtF@hirez.programming.kicks-ass.net>
In-Reply-To: <YxiQ87X1eUB2rrtF@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 8 Sep 2022 09:58:42 +0200
Message-ID: <CANpmjNPwtmRbj3zRTWS9hL0wawuSQV_2SL0fvnb5e0J43MaNag@mail.gmail.com>
Subject: Re: [PATCH] perf: Allow restricted kernel breakpoints on user addresses
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Wed, 7 Sept 2022 at 14:39, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 02, 2022 at 12:00:57PM +0200, Marco Elver wrote:
>
> > +/*
> > + * Check if unprivileged users are allowed to set up breakpoints on user
> > + * addresses that also count when the kernel accesses them.
> > + */
> > +static bool perf_allow_kernel_breakpoint(struct perf_event_attr *attr)
> > +{
> > +     if (attr->type != PERF_TYPE_BREAKPOINT)
> > +             return false;
> > +
> > +     /*
> > +      * The sample may contain IPs, registers, or other information that may
> > +      * disclose kernel addresses or timing information. Disallow any kind of
> > +      * additional sample information.
> > +      */
> > +     if (attr->sample_type)
> > +             return false;
>
> This feels a bit weird; should that perhaps be is_sampling_event()?

is_sampling_event() just checks for sample_period. In fact, we still
want to set sample_period to get overflow events. That in itself is
not dangerous.

What's problematic is if the samples contain additional information,
which can be specified in sample_type. For example if PERF_SAMPLE_IP
is set, it might leak kernel IPs, and that's bad. Since it's safest to
disallow any kind of extra information, we just check if sample_type
is zero.

> > +
> > +     /*
> > +      * Only allow kernel breakpoints on user addresses.
> > +      */
> > +     return access_ok((void __user *)(unsigned long)attr->bp_addr, attr->bp_len);
> > +}
> > +
> > +int perf_allow_kernel(struct perf_event_attr *attr)
> > +{
> > +     if (sysctl_perf_event_paranoid > 1 && !perfmon_capable() &&
> > +         !perf_allow_kernel_breakpoint(attr))
>
> I'm on the fence about this; one the one hand it feels weird to have a
> breakpoint exception here and not a pmu specific callback for instance;
> OTOH, leaving security policy like that up to pmu drivers sounds like a
> really bad idea too.
>
> Keep it as is I suppose, just me thinking out loud or so.

Ack. I also think this should stay in core, as it's also easier to audit.
