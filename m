Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5846959957C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbiHSGs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346541AbiHSGss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:48:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3BF58512
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:48:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so4537890edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Xb1kVFT7+z3GuAFsz4kFtI97p27AzWLLoZiCrTFIfdM=;
        b=S0kY5+NY2a7HM0V04lX+9VSIAqH+p5fiXJR6SFor+ALzbQ8FRT8Jqq+idE66fD0w9/
         LvxatrAV84xBHgtgiwmDmUIPInTNIg7sPLg0bNBG5WsZ7gCMaQ3fHUSFpD5djx8UNUyD
         0ULfKQnoWE3bD2UocnH3xTUE5LENnZ3ZxX3+2Su2r+29A+bW4yqcQx+WImGaGWkyzj6c
         Uz3E7w8ciknJ5cVXbxLj/eKtkMhO1XjekI8myGULitqW1MOGlNJN8YAdkfAIdShCsFPb
         9JhRwuonsQvSFfqidxWsnosSAICr0qmM6bI0uUZnDFv2tLnW+Dx9300qcpyi4nRr87JW
         UTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Xb1kVFT7+z3GuAFsz4kFtI97p27AzWLLoZiCrTFIfdM=;
        b=XQa4Aan/ftE4vmoSuwmSTz7orLMyytBuivKslmL5wfDt/NZRidbUPS+rKj8iuHeAeQ
         sP7P39Uo86hFJJ7vmTjIb2Ah4qMRC0GRT/oPmXIcIqDRwv28ve4y8WxACrjKgliuX/o9
         lJkXApiEhfiGcjdZ3y1oblLHevMhkVx1D34/jPM7q+jsMiuvAVQou+ILiaCL6etQQ7RQ
         CSzWkTa4oTfbn9Ap0i9O9aAyNhWyXxtZvLh322j7YMEZG95hokYMKEZjNx8mgjHNZdMj
         gQK/q0orJgmQivpoWxc+CQUXKh0ekyBsFOImtTCizhnrCAS5RcEdF3WKfFtM5gLlgjiV
         a3hw==
X-Gm-Message-State: ACgBeo2hXU5TYpgYkO+2YyqT4o79tKAbAFSC5JgxyGnmm1vHrY7pxP3a
        dFhoCtCv1pkdeRTtbicyFjZCSQ==
X-Google-Smtp-Source: AA6agR5aTWKWtoRfL/j9KlQjMvI80NDkmrLQbOAK7of2xm4V1jzWGUZWn9s8IY3appZNeFuDKLWeyA==
X-Received: by 2002:a50:ec08:0:b0:446:638:b3d4 with SMTP id g8-20020a50ec08000000b004460638b3d4mr4822960edr.278.1660891724930;
        Thu, 18 Aug 2022 23:48:44 -0700 (PDT)
Received: from leoy-yangtze.lan ([104.245.96.89])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0072abb95c9f4sm1859407eje.193.2022.08.18.23.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:48:44 -0700 (PDT)
Date:   Fri, 19 Aug 2022 14:48:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Chuck Zmudzinski <brchuckz@netscape.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Bartlett <ajb@elrepo.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Akemi Yagi <toracat@elrepo.org>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
Message-ID: <Yv8yRv2BMVgmb/n+@leoy-yangtze.lan>
References: <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
 <YuBDw/+7McESS05X@kernel.org>
 <CAP-5=fV4+KeGcyyODTNjS01dw1iTXpFyaLXwZ8nBkek+NHL37w@mail.gmail.com>
 <11781d7e-d9de-f889-ff57-9d26d92ada44@netscape.net>
 <16cb5f73-ac85-5094-3cd1-ec91cb47fb99@netscape.net>
 <CAP-5=fXjBBbU3EHD5iY6VMKMo3wj+dJteeqBf5B9m464HtdF3Q@mail.gmail.com>
 <806d152f-358b-572a-64f2-798fe7783f93@netscape.net>
 <20220818030335.GB30503@leoy-huanghe>
 <CAP-5=fX8OVBFGXAgshstMBMFo4ULvMBdZnE_2h-RsamJ6q1qow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX8OVBFGXAgshstMBMFo4ULvMBdZnE_2h-RsamJ6q1qow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 07:52:22AM -0700, Ian Rogers wrote:

[...]

> > > I see this has already been committed. I agree it should not
> > > stay in the kernel tree for long. At some point in the future
> > > it will most likely cause problems if it is not reverted.
> >
> > It is a bit confused me that here actually we are worrying about the
> > python distro issue, e.g. python2 is obsolete, so it's risky to keep
> > using python2 in the system, especially if python2 has potential
> > security issue.  So the system (e.g. RHEL7) needs to upgrade its python
> > distro from python2 to python3.
> >
> > But this doesn't mean the python script cannot be compatible for both
> > python2 and python3.  I verified this patch, it should can work for
> > both python2 and python3 on my PC.
> >
> > Another concern is there have some python scripts in perf, I think most
> > of them are python2 compatible, should we update all of them to be only
> > python3 compatible?
> 
> I think there are a lot of things that need to be done for python in
> the perf build. For example, perf script is using deprecated python C
> APIs. . As you say string formatting isn't the biggest issue. What I
> think we need to do is set a minimum bar for what is supported, for
> jevents.py that is python 3.6.
> 
> The problem with python2 compatibility can be seen with this:
> https://lore.kernel.org/all/20220615014206.26651-1-irogers@google.com/
> python3 is deprecating APIs which are the only API choices on python2.
> So we can:
> 1) have 2 scripts, one for python2 and one for python3, possibly
> varying by release of python3 depending on when a deprecated API is
> removed
> 2) always be stuck on python 2 as our lowest bar for compatibility
> 3) forget about python 2, set compatibility at some reasonably but not
> totally new version of python like 3.6 and move this forward inline
> with supported versions by the python community
> 
> I favor (3) not least as testing (1) is a challenge/chore and if
> something is wrong with python2, well it is on us. I think we
> shouldn't aim to support more python than what the python community
> itself aims to support. They are clear that python 2 is dead.

I agree that option 3 is the good way to move forward.

Thanks a lot for detailed explaination.

> Going back to f-strings, they are considered the more pythonic way to
> write things and make it easier to read code, eye-ball mistakes, etc.
> We want to have the best code possible in the perf codebase and so
> changes to use f-strings to the python scripts in perf should be
> welcomed - RHEL7 customers will just have to get with the program imo,
> well they should upgrade off of RHEL7. Python 3.6 is hardly new and
> this causes issues in jevents.py, for example, as I can't rely on the
> string removesuffix function being available (added in python 3.9).
> 
> There is a bunch of clean up necessary to get rid of python 2 from the
> build, and we took a step in this direction by defaulting to python 3
> (not without pain) in:
> https://lore.kernel.org/all/20220616044806.47770-2-irogers@google.com/
> 
> Should we make all the scripts python 3 only? It comes down to people
> writing patches. If someone updates a script and uses an f-string, I
> don't think we should code review and reject the patch. Should we
> proactively go and clean up python code in perf to make it more
> pythonic? Sounds good to me, and I might suggest a list of other clean
> ups we need to do given you have the time :-)

It's fine for me to revert this patch in an appropriate time.

Regard to other python scripts in Perf, seems to me a pragmatic method is
that as you said we can set a bar for python version (e.g. 3.6), then we
can go through python scripts one by one to test if any script is not
python 3.6 compatiable or not.  If not, then we can commit patch for
it.

"the more pythonic way" is a subjective words? :)  I am lack the
knowledge to judge if any things are more "pythonic" and can replace with
the existed code.  But I think it would be a good start to use f-string
to replace old print sentences.  When I have some free time, I will come
back to check with you and other maintainers if I can help a bit for this.

Thanks,
Leo
