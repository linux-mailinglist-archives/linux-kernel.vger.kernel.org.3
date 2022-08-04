Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124BC58997D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiHDItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiHDItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:49:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9AC3F;
        Thu,  4 Aug 2022 01:49:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b16so16941359edd.4;
        Thu, 04 Aug 2022 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDqST7Byow9W+iNy4StAr+ocDX/ur332SaJcGD+0QOs=;
        b=Iac/k5ega7/2roee9dVTuPSAofjPoyHYUAjuYJvvpKrIGY7b2AfJ5ZLodTuwTsj7pi
         yYh+Tf9dp/SG4ZE++/7FX3vZRBKuAqLAJ3PSzmxu2doTZRGj9T6BbRrTvNZ/6QZG4CyA
         QDOdbQGb3x7krNvtvMbwoP1UXgxt1TrsXSq21lEcmM48Vg/GTo/kBIDPyPixIMLddRCl
         65Cxm0kZZj6wyw3JWpE0ELMGU4WDxreJYTtlEXDH77ppjnfUwTUwSeIxj5ZhPwy7uecD
         Lhx8k5AvcU/yBMt/RF20fGIJ3ZAyklaR/bz1glW6xtuO95kGl3zPz42qLOUuBSf3tM8A
         jfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PDqST7Byow9W+iNy4StAr+ocDX/ur332SaJcGD+0QOs=;
        b=o+bRD27XiVY8iqjSeLNJBzBRzfpIChF9SPAdL06zeZ/c2H2sfXNyVoi/grRWTCRt0P
         QDhFAZds2USE+/mFQUZGw+irx8q0Dpe/zHDPXGZs7U5pm9anPZQulKhT22N2dY7hImhS
         UbBH7NtO1tkPaMHae6CjXT6RvcVtje9LF+ndSmWc7W3Dr22jk6MZZc8kzDu/E1iig0h7
         WV5la3gX7MPvMFZiw8EawsZgS+yk/eb4xnDLYJgC2iQ3TP2m8aBr4lRQgTfYRt9Wavea
         KSFrAWykWmooq+LDlNcb5dBy68JhJSh8B/Eju17o7n4kS4ao30kJKPqsFkvDkA9OOtl2
         U0jg==
X-Gm-Message-State: ACgBeo0rDrCydVUYNMAK/IqR6wIgtAqhZd8wRUI0udn/zeWFt50zPw0u
        v9zJju3ROz6CN0nArHvzt4k=
X-Google-Smtp-Source: AA6agR6EX97LVGRg3+3k1XQ4q9e9rO9X3J4o5LnVoZ/LF7tZx30N+5SegaDbFCgkQHVYF+mhZCbTYw==
X-Received: by 2002:a05:6402:84f:b0:437:6293:d264 with SMTP id b15-20020a056402084f00b004376293d264mr937597edz.317.1659602952927;
        Thu, 04 Aug 2022 01:49:12 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id d6-20020a056402144600b0043bbb3535d6sm325949edx.66.2022.08.04.01.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 01:49:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 4 Aug 2022 10:49:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/3] perf: Align user space counter reading with code
Message-ID: <YuuIBr2aqB+1992Q@gmail.com>
References: <20220719223946.176299-1-irogers@google.com>
 <20220719223946.176299-2-irogers@google.com>
 <ef5125e0-8265-8c16-e904-c95c8ddc2754@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5125e0-8265-8c16-e904-c95c8ddc2754@maine.edu>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vince Weaver <vincent.weaver@maine.edu> wrote:

> On Tue, 19 Jul 2022, Ian Rogers wrote:
> 
> > Align the user space counter reading documentation with the code in
> > perf_mmap__read_self. Previously the documentation was based on the perf
> > rdpmc test, but now general purpose code is provided by libperf.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/uapi/linux/perf_event.h       | 35 +++++++++++++++++----------
> >  tools/include/uapi/linux/perf_event.h | 35 +++++++++++++++++----------
> >  2 files changed, 44 insertions(+), 26 deletions(-)
> > 
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index d37629dbad72..6826dabb7e03 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
> >  	 *
> >  	 *     if (pc->cap_usr_time && enabled != running) {
> >  	 *       cyc = rdtsc();
> > -	 *       time_offset = pc->time_offset;
> >  	 *       time_mult   = pc->time_mult;
> >  	 *       time_shift  = pc->time_shift;
> > +	 *       time_offset = pc->time_offset;
> > +	 *       if (pc->cap_user_time_short) {
> > +	 *         time_cycles = pc->time_cycles;
> > +	 *         time_mask = pc->time_mask;
> > +	 *       }
> 
> From what I've been told, and from what perf_mmap__read_self() actually 
> does, many of these MMAP fields need to be accessed by READ_ONCE()
> (a GPLv2 only interface) to be correct.

BTW., for this purpose I guess we could add a READ_ONCE() variant to perf 
tooling that reimplements it with more relaxed licensing, so that the 
headers & sample code can be included in GPL-incompatible projects?

READ_ONCE() isn't a super complicated primitive, and we've always been 
permissive with simple primitives.

Thanks,

	Ingo
