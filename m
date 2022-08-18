Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217FB597BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242560AbiHRDDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHRDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:03:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CC1B48B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:03:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pm17so454886pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dSpYxwksBDIEEwhUV+31aBldVgM9AT/PeqWp8SlrZ9k=;
        b=bUTUH5+k1T/s7/iyLQofWL2urbMS2u+hA9q6wARrQNxpXg97Wpu4kIVKMhsrrWu6L8
         bP2cMkJI4Tc2md6VPh3KRsVqzcXpuVEaoWL7VkWpeU3XygeKT2OBQBdsxQiFwyHMEum7
         p4kLEsnkx1kN3JtNREJ1OY2gcrHI9DNDy2ay70XgFxObbZrowwAxMrsudxpH41maoST0
         FQpnMW2jBgc7P5ALSNi1tKzMSyilZcbGFbOClZLGEYnbawtB437x+5ghP5MeGLh+4Lgx
         jn4eJmjDNNJvoXkLozXiqv2PqoO8aTKvkHaT+4CKt7Bmog+R9NQ1MZv8DaFDXpfYHe8C
         l9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dSpYxwksBDIEEwhUV+31aBldVgM9AT/PeqWp8SlrZ9k=;
        b=7U44+gKBkj+NC3VU+e81AJ9akSNz/yW9CTTGCcJlUGYgCc1BzFxhCom2etL9wXsMis
         eUFbkzYc6/vjB/7KTMoIjeiPZUXtmUTjMVzjTkW/iWGMwvZHLnIB4E0sQK5bVCtDwQGO
         /XImlp5vgfAffkjuGswlPgVwbx1I4tYV/SW+zv5ORU5Re0hpAvTjGEhwo4u0o6WOOvPE
         vxY6bZlkQZEvaQ1cWRiCdjsOaqwr3qtwGJ7kqXXdt9mjNOU/mqEsABgW1AZ7BHMoJcZI
         ZjmIv0XWWoN1KETLs1V3pFG5JVSv5bKwsO+67CMKsSHlZ5yyke8fN/nzAia8TksNVg2s
         uRAA==
X-Gm-Message-State: ACgBeo1+D6mk4s+vPEYPl/iOj7vcFIQu/FwS0yKE4yJ9I3L3Sd6ER/xk
        ux4m7lyETgZ8qeo5i6DfHHAa6A==
X-Google-Smtp-Source: AA6agR7KvXLMxpuGzjZ0uQpsub3E6tIZL/TQwIMQDPTUmVVBFlxapTcA9Kz4AUB1bRwA2HKVnbGf+A==
X-Received: by 2002:a17:902:d54e:b0:16e:f3e4:8c88 with SMTP id z14-20020a170902d54e00b0016ef3e48c88mr851073plf.94.1660791822025;
        Wed, 17 Aug 2022 20:03:42 -0700 (PDT)
Received: from leoy-huanghe (ec2-54-176-161-147.us-west-1.compute.amazonaws.com. [54.176.161.147])
        by smtp.gmail.com with ESMTPSA id i62-20020a626d41000000b0052d27ccea39sm289059pfc.19.2022.08.17.20.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:03:41 -0700 (PDT)
Date:   Thu, 18 Aug 2022 11:03:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Chuck Zmudzinski <brchuckz@netscape.net>
Cc:     Ian Rogers <irogers@google.com>,
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
Message-ID: <20220818030335.GB30503@leoy-huanghe>
References: <20220725104220.1106663-1-leo.yan@linaro.org>
 <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
 <YuBDw/+7McESS05X@kernel.org>
 <CAP-5=fV4+KeGcyyODTNjS01dw1iTXpFyaLXwZ8nBkek+NHL37w@mail.gmail.com>
 <11781d7e-d9de-f889-ff57-9d26d92ada44@netscape.net>
 <16cb5f73-ac85-5094-3cd1-ec91cb47fb99@netscape.net>
 <CAP-5=fXjBBbU3EHD5iY6VMKMo3wj+dJteeqBf5B9m464HtdF3Q@mail.gmail.com>
 <806d152f-358b-572a-64f2-798fe7783f93@netscape.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806d152f-358b-572a-64f2-798fe7783f93@netscape.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:12:24PM -0400, Chuck Zmudzinski wrote:

[...]

> > > > > > Someone reported a problem in a system they used, the author of the code
> > > > > > in question posted a patch allowing perf to be used in such old systems,
> > > > > > doesn't get in the way of newer systems, small patch, merged, life goes
> > > > > > on.
> > > >
> > > > Considering the proposed patch, can you be sure that replacing the
> > > > f-string format with the legacy format won't cause a regression for
> > > > some python3 user somewhere when this hits the real world? Even
> > > > if it does not cause a regression today, as new versions and features
> > > > are added to python3, can you be sure none of those new features
> > > > will depend on the upgrade from the legacy format to the f-string
> > > > format here to work properly? So many regressions happen because
> > > > the people who write patches cannot possibly foresee how their
> > > > patch is going to affect the millions of Linux users out there, but still
> > > > they are certain it will not cause a regression somewhere. So how
> > > > can the chances that this patch will cause a regression be minimized?
> > > >
> > > > It seems to me for this to be suitable for the Linux kernel, the
> > > > default should be to use the modern python3 format and only
> > > > enable python2 compatibility via a sysctl setting and/or kernel boot
> > > > option for those who are still using python2. There should be no
> > > > change to the behavior of the kernel for users who have upgraded
> > > > to python3. But I don't see any such consideration for python3
> > > > users in this patch.
> > >
> > > Sorry, I didn't see this is a script, LOL! So obviously a sysctl or boot option
> > > does not apply. But can't the script implement this simple logic:
> > >
> > > If python version = 3 use f-string format
> > > if python version = 2 use traditional string format
> >
> > Doing this in the script would be noisy, having two scripts less than
> > ideal. I'd suggest we wait two weeks, declare the official death of
> > RHEL7 without "rpm -i python3" and then revert the python3 to python2
> > patch. There are plenty of things to worry about and python2 shouldn't
> > be one of them (it died over 2 years ago).
> 
> I see this has already been committed. I agree it should not
> stay in the kernel tree for long. At some point in the future
> it will most likely cause problems if it is not reverted.

It is a bit confused me that here actually we are worrying about the
python distro issue, e.g. python2 is obsolete, so it's risky to keep
using python2 in the system, especially if python2 has potential
security issue.  So the system (e.g. RHEL7) needs to upgrade its python
distro from python2 to python3.

But this doesn't mean the python script cannot be compatible for both
python2 and python3.  I verified this patch, it should can work for
both python2 and python3 on my PC.

Another concern is there have some python scripts in perf, I think most
of them are python2 compatible, should we update all of them to be only
python3 compatible?

Thanks,
Leo
