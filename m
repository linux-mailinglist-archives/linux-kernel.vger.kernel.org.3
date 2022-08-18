Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D37598677
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbiHROwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343744AbiHROwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:52:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C269BC831
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:52:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u14so2006627wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9FRCT+qtp+vyx/FEeM2zjhMWbwEfzpU/Nc1Eb30iBdg=;
        b=j8b682twpvR4egkJTXFvbVZGBaDXgcOSQrK0FuvJfDjRfQ8ImPc4zYW30AFn6RGYap
         vffFONQijgvpYH6NVbPERgOalQn3S+KmgYgLm9M9oUOn/N64xF8qgTGur3f2kyqqlq9M
         cmDm2fw+Wto9auNbEhuMqbEdHoqHcmxrzJZCxQDRE4aFaY3T3Vw1sNx8KZYhhxWomf68
         6PrBvcBc6XDSyeVkCAtgakQgMZGNHp4IqrHfbgE3ThVVGVkG3ICmjq9RqunkiApiZdEM
         ehRV2KZdWjj+hTMaHL8Rcrl+v1NYkp9vVohnqDnao/zrF53zCnKO73yFQ5X6QgJm+I+N
         d/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9FRCT+qtp+vyx/FEeM2zjhMWbwEfzpU/Nc1Eb30iBdg=;
        b=XNs4cGrPhCRQNNsWv81MxhOUt7cK89D/oLQGrgtYRCGBL7HC+3igjl2u3a7eaK4EZb
         2JMut5wlpzoW2nrj1xjLrKEljiDIp0vAeVnngl6B+ztCcFhNuTkywwNhYCgTFyn+x+91
         9+WoL4aSXgdghROFBPcit04K3akEoyxpZX/kVBx4yVM3at14Hk7yV0UPNdatRSJk2P4E
         E23p7A0FnKoGnXzWCX/v4eu339ilN7jAgbiE4ab64fphcI3M/dfXStbGAZfEO0yyxPq8
         ceL2xJJIo2YjKklAhUvx3eiFID6/jFFkiDcw7oPbLhLcyph40g2/mjtu5TlEinegoNv4
         zZlQ==
X-Gm-Message-State: ACgBeo1pf7dJlWU5YNKnzWwAjfZoVrz8mArKOf0hOmMlX/L1se5MK2v2
        AgufmWwAm+63tXxJWOD+Q7dc+EVyIHSwo8GtfnyNpA==
X-Google-Smtp-Source: AA6agR7dn9uicZ9VwiA+UeZEVvBtEWj9Oo4SsEA7kXrGueDcKSkWvVXxjnH+HH3y52vPjLXpFqe8SjIMBlhhT/XXe8g=
X-Received: by 2002:a5d:6789:0:b0:225:2787:d44f with SMTP id
 v9-20020a5d6789000000b002252787d44fmr1756425wru.343.1660834355561; Thu, 18
 Aug 2022 07:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220725104220.1106663-1-leo.yan@linaro.org> <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
 <YuBDw/+7McESS05X@kernel.org> <CAP-5=fV4+KeGcyyODTNjS01dw1iTXpFyaLXwZ8nBkek+NHL37w@mail.gmail.com>
 <11781d7e-d9de-f889-ff57-9d26d92ada44@netscape.net> <16cb5f73-ac85-5094-3cd1-ec91cb47fb99@netscape.net>
 <CAP-5=fXjBBbU3EHD5iY6VMKMo3wj+dJteeqBf5B9m464HtdF3Q@mail.gmail.com>
 <806d152f-358b-572a-64f2-798fe7783f93@netscape.net> <20220818030335.GB30503@leoy-huanghe>
In-Reply-To: <20220818030335.GB30503@leoy-huanghe>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 18 Aug 2022 07:52:22 -0700
Message-ID: <CAP-5=fX8OVBFGXAgshstMBMFo4ULvMBdZnE_2h-RsamJ6q1qow@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Leo Yan <leo.yan@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 8:03 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Wed, Aug 17, 2022 at 09:12:24PM -0400, Chuck Zmudzinski wrote:
>
> [...]
>
> > > > > > > Someone reported a problem in a system they used, the author of the code
> > > > > > > in question posted a patch allowing perf to be used in such old systems,
> > > > > > > doesn't get in the way of newer systems, small patch, merged, life goes
> > > > > > > on.
> > > > >
> > > > > Considering the proposed patch, can you be sure that replacing the
> > > > > f-string format with the legacy format won't cause a regression for
> > > > > some python3 user somewhere when this hits the real world? Even
> > > > > if it does not cause a regression today, as new versions and features
> > > > > are added to python3, can you be sure none of those new features
> > > > > will depend on the upgrade from the legacy format to the f-string
> > > > > format here to work properly? So many regressions happen because
> > > > > the people who write patches cannot possibly foresee how their
> > > > > patch is going to affect the millions of Linux users out there, but still
> > > > > they are certain it will not cause a regression somewhere. So how
> > > > > can the chances that this patch will cause a regression be minimized?
> > > > >
> > > > > It seems to me for this to be suitable for the Linux kernel, the
> > > > > default should be to use the modern python3 format and only
> > > > > enable python2 compatibility via a sysctl setting and/or kernel boot
> > > > > option for those who are still using python2. There should be no
> > > > > change to the behavior of the kernel for users who have upgraded
> > > > > to python3. But I don't see any such consideration for python3
> > > > > users in this patch.
> > > >
> > > > Sorry, I didn't see this is a script, LOL! So obviously a sysctl or boot option
> > > > does not apply. But can't the script implement this simple logic:
> > > >
> > > > If python version = 3 use f-string format
> > > > if python version = 2 use traditional string format
> > >
> > > Doing this in the script would be noisy, having two scripts less than
> > > ideal. I'd suggest we wait two weeks, declare the official death of
> > > RHEL7 without "rpm -i python3" and then revert the python3 to python2
> > > patch. There are plenty of things to worry about and python2 shouldn't
> > > be one of them (it died over 2 years ago).
> >
> > I see this has already been committed. I agree it should not
> > stay in the kernel tree for long. At some point in the future
> > it will most likely cause problems if it is not reverted.
>
> It is a bit confused me that here actually we are worrying about the
> python distro issue, e.g. python2 is obsolete, so it's risky to keep
> using python2 in the system, especially if python2 has potential
> security issue.  So the system (e.g. RHEL7) needs to upgrade its python
> distro from python2 to python3.
>
> But this doesn't mean the python script cannot be compatible for both
> python2 and python3.  I verified this patch, it should can work for
> both python2 and python3 on my PC.
>
> Another concern is there have some python scripts in perf, I think most
> of them are python2 compatible, should we update all of them to be only
> python3 compatible?

I think there are a lot of things that need to be done for python in
the perf build. For example, perf script is using deprecated python C
APIs. . As you say string formatting isn't the biggest issue. What I
think we need to do is set a minimum bar for what is supported, for
jevents.py that is python 3.6.

The problem with python2 compatibility can be seen with this:
https://lore.kernel.org/all/20220615014206.26651-1-irogers@google.com/
python3 is deprecating APIs which are the only API choices on python2.
So we can:
1) have 2 scripts, one for python2 and one for python3, possibly
varying by release of python3 depending on when a deprecated API is
removed
2) always be stuck on python 2 as our lowest bar for compatibility
3) forget about python 2, set compatibility at some reasonably but not
totally new version of python like 3.6 and move this forward inline
with supported versions by the python community

I favor (3) not least as testing (1) is a challenge/chore and if
something is wrong with python2, well it is on us. I think we
shouldn't aim to support more python than what the python community
itself aims to support. They are clear that python 2 is dead.

Going back to f-strings, they are considered the more pythonic way to
write things and make it easier to read code, eye-ball mistakes, etc.
We want to have the best code possible in the perf codebase and so
changes to use f-strings to the python scripts in perf should be
welcomed - RHEL7 customers will just have to get with the program imo,
well they should upgrade off of RHEL7. Python 3.6 is hardly new and
this causes issues in jevents.py, for example, as I can't rely on the
string removesuffix function being available (added in python 3.9).

There is a bunch of clean up necessary to get rid of python 2 from the
build, and we took a step in this direction by defaulting to python 3
(not without pain) in:
https://lore.kernel.org/all/20220616044806.47770-2-irogers@google.com/

Should we make all the scripts python 3 only? It comes down to people
writing patches. If someone updates a script and uses an f-string, I
don't think we should code review and reject the patch. Should we
proactively go and clean up python code in perf to make it more
pythonic? Sounds good to me, and I might suggest a list of other clean
ups we need to do given you have the time :-)

Thanks,
Ian

> Thanks,
> Leo
