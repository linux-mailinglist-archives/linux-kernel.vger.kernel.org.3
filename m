Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6A4EB57C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiC2WAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiC2WAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:00:07 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B01DB80
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:58:23 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id o67so20641181vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+R8nWg8gGCqyBE2/fgJKiGa+Qo44g+mYwgsJhadgZ0=;
        b=ViR3vs9k60LkgoJr8NtlnIv6xSaqWuDRDdUz+1n5vCKNq6tYoi05tzOPWKN7y0KcA+
         FgqYwKHaiuyO6tP/PeBY+XCVlQMd+9vsbg1lZy8I4F7gR3tvSoHO1fqf5aT0N8/Y0NmK
         EJTmxk+sXoDojZ8uBsjCq5Gd7oi4E5TDjVjofAiwLiRhPLm5q9MYnWrv2rs1XwUE0utl
         LlYBJZ4pmBYblPhrAhtSw8uULipI6TktNojYnBicgCNGpc4QJa8NJ3q4YhH9NjRpNHxa
         Eoco9FB1U2+D2WWHI7ICSMCW8OAVZS9blBYhNeUXdKcfdVXBKtfCfHgkBuazu6EHe09n
         ltjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+R8nWg8gGCqyBE2/fgJKiGa+Qo44g+mYwgsJhadgZ0=;
        b=OHn+FYaBqcvGrTum3Pk0Eh7Ipr+0hYJfEZWZTkV7+cR1gcyFH9G6MZYDTucyz9UL0c
         gwTcK0L/pjpKg+2MYIvWPvDam2ITaN32beo9muM5eNuogum81lMHlMBRaiczeZ395Vhb
         w8lwghW3MlfBW7/bU/Be4AaZmrC4WRaxrJnL5qsF+VFLoHOsqD6kbr7fuDSueNN4ZI2y
         Ky8Gpxm3wvjZuBy5yQPpDRnfNy2prOoSwY8M9Fxi0451Xq6/iOEQIkq+niX7vgC2EhJh
         8MURq5iwwOjTABFWy3+Cful3NtiuvkM/RLJeoA13Xvl4F2WvUwl+9u2aNM2CzXEg6+UT
         jQrg==
X-Gm-Message-State: AOAM532XP2HzY+PyhwKF7I8YxzQjPzUlbBjri8kXXdtXx8X7UxRiSRvH
        NDvsMhviDrbnuTbJ5qRnUScaqiiwT1a9SlNdw2jhbQ==
X-Google-Smtp-Source: ABdhPJy0TKqQvveQKJR7SY0iUtvXF+ZpWYdJ1CnBL1HQ1Tnjn5nPRcSgicyUkZw8kjACaeRRimKd7LMP0ErFU3R79wc=
X-Received: by 2002:a05:6102:205a:b0:325:da19:bcb3 with SMTP id
 q26-20020a056102205a00b00325da19bcb3mr1091115vsr.37.1648591101901; Tue, 29
 Mar 2022 14:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com> <20220324145902.GG8939@worktop.programming.kicks-ass.net>
 <CABPqkBTVFNOW0Y-suYVRjf07aBC41gEw1m4Ym78sR39BRzLDcQ@mail.gmail.com> <20220325082855.GL8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220325082855.GL8939@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 29 Mar 2022 14:58:11 -0700
Message-ID: <CABPqkBSNG=kLae6dN9iCuyuMVAvt-n+waW9SL4AfNDCOc3px0A@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        rafael@kernel.org, ravi.bangoria@amd.com, Sandipan.Das@amd.com
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

On Fri, Mar 25, 2022 at 1:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 24, 2022 at 10:31:38PM -0700, Stephane Eranian wrote:
> > On Thu, Mar 24, 2022 at 7:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Mar 22, 2022 at 03:15:04PM -0700, Stephane Eranian wrote:
> > > > V7 makes the following changes:
> > > >    - rebased to 5.17-rc8
> > > >    - Restrict BRS to be used only with RETIRED_TAKEN_BRANCH event in order to
> > > >      avoid adding more skid to other events in case that are monitored
> > > >      concurrently
> > > >    - fixed bugs in the perf tool enhanced error handling for IBS and BRS
> > >
> > > But afaict you failed to pick up the build fixes I did in my tree :/ Let
> > > me try and be careful preserving those while munging this in.
> >
> > Sorry. I missed that. I can resubmit if you prefer.
>
> Nah, fixed it up again.. Even converted to static_call() this time.
>
> Could you please test this branch?

Started testing. BRS does not come up so far. Let me debug this.

>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/amd
>
> I've since done more Changelog edits, and I should do a comment with the
> static_call_mod() usage, but I think this ought to work.
>
> At least it now actually builds...
