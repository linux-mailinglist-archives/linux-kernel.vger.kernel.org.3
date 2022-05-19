Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C072352CB47
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiESErx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiESErt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:47:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E168F8F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:47:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so2079122wmr.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDQ/G9si/q6pRTY57bn5CgRuv91q+1D0ytzIM8aSkDs=;
        b=oFKE2nPdHnGrvcWjxHD2eCwSLCOSsA83NfLxEqD1p8o6kI0wWHqsV3lIywRoQtAVry
         0OFZN8srxVDvo8k9KaVSfxjJBPqSvIpOeQTRx4J+yxhCzb17cNEieKVgO7CegkQnCdrk
         JHV2575zQvgaqPrRdAD9uJB6v/6z+OvVNHWtZjr2yYJn2IPpB6eod/3vrA7OTY6AletY
         ous3BDm4Upw7E+2X0FHyiMYXGFI1uDfMjAHr50L1B8379EpWizDErANAO1uH4jTKAMeP
         fgajW7jgBiSeAJ9BzDb9P4e4FT/UpeG2Nd+M2bubOdVzETm1Ur99zWtuIyNesvvk9RL4
         XeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDQ/G9si/q6pRTY57bn5CgRuv91q+1D0ytzIM8aSkDs=;
        b=qYF5MTqrl/sW5aiKIJ1mXf7ft4ol0V79DJIY3C/aC/RFym5qh9Ibl1t3cKcEPt1J5X
         sCwKhS2+TWSW2c3K32jpaTmnBN0f6s5r4+TJxbFV/jmQiVAsvHCFDt0HwpwSqPLK1nd1
         zvs11ybfp9sNfbx3Y1YFHL/R9SV0/jzuHb4r5A3LQ6lvIc5udXfJlcIAcRnJm6P920xN
         nxYcS3Pjzsf2qlOE5I3PK5diJovk2mNCQ77Sm6BwtnxHS42ly6dvDQ8CVorqktnr76dw
         5qwM95bzaH9wc9wtTwxbe3BncUv2maNnh0oyvSppOweSDOJp1KM3smjLwHY4PgS3AnDL
         eD+g==
X-Gm-Message-State: AOAM532zgRz4SN7CjgLoHNR91rPzB6yMgdeYPpbrPTnnn9JDaxfTb1MB
        v2mXhr5aFTVpIG3MVMcn3HZo/2dLP2En3IdViHyzOg==
X-Google-Smtp-Source: ABdhPJwAjL2vm0z/tecnByHz7WpBGfucjFhqdlps0840g+H/jdv3q1dWo9FdsNLcwkJ8EMq3AOlExs2O4+fpbeECxZ8=
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id
 m1-20020a1ca301000000b003929bc5203cmr1995463wme.67.1652935667259; Wed, 18 May
 2022 21:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220503213704.2524229-1-blakejones@google.com>
 <YnqW68rLssWA8uba@kernel.org> <CAP_z_CjM=xdogE7YMhwPj25rG7cvK6=TS_0O_bJ22+SgW6pxhQ@mail.gmail.com>
In-Reply-To: <CAP_z_CjM=xdogE7YMhwPj25rG7cvK6=TS_0O_bJ22+SgW6pxhQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:47:35 -0700
Message-ID: <CAP-5=fXdC_opBmFRY_F5xXwVybnx3aagg3nv54ykfmpwYBknMg@mail.gmail.com>
Subject: Re: [PATCH] Add an "-m" option to "perf buildid-list".
To:     Blake Jones <blakejones@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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

On Tue, May 10, 2022 at 11:13 AM Blake Jones <blakejones@google.com> wrote:
>
> Thanks for taking a look at this!
>
> On Tue, May 10, 2022 at 9:46 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Tue, May 03, 2022 at 02:37:04PM -0700, Blake Jones escreveu:
> > > +-m::
> > > +--modules::
> > > +     Show buildid, start/end text address, and path of kernel and modules.
> >
> > Hi,
> >
> >         Wouldn't it be better to have -m show just modules, name +
> > buildid, then have -v show more verbose info, i.e. the start, end and
> > switch from just the module name to its full path?
> >
> >         Then to get what your patch produces now one would use:
> >
> >         $ perf buildid-list -kmv
> >
> >         That would be more flexible, wdyt?
>
> I'm open to using "-v" like this if you think it would be useful; is
> there a use case you have in mind for the non-verbose mode? For doing
> external symbolization of stack traces, the BuildID isn't useful without
> also knowing the starting and ending addresses.
>
> If "-m" only showed information about modules and not about the kernel,
> then "perf buildid-list -km" (without "-v") would have different output
> formats for the kernel and for the modules. So I'm inclined to have "-m"
> include information about the kernel as well as the modules.
>
> How does that sound?
>
> Blake

Using "-m" sounds okay to me, Arnaldo?

Thanks,
Ian
