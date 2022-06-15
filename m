Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CAF54C005
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbiFODNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351653AbiFODNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:13:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994D14D6B0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:13:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so5594446wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzv5eaByYVX50lBqPhTHyIiI1jj84Kw6BozZseArlPM=;
        b=IIWBoco614YCy/2/A9fNn0flfIzyV0vqrFQEateuhiigUnx6irUW0zgzvfcILyEN01
         TZABkUIKmyKLvnNn3RPwkpw4MEV2x81hVQ53g6qOwcVImPorfrQ29VVqbmRufGt4IPEy
         qLFRdRB60fbIU61X6LJwgmS7pri7yQQBxhZ2bIftmEpKUgycG66mLyTcIDk94Jz33Vhv
         R6dJSnm/bJsr5mBEe2/oNqYv2GhoaY4nOyfjEyyoLVPyKW0OXKr/lGsibl3XlCIdNSDu
         bEAqQaRCW3mi2HTtnI1jl1tKV865cvoAk4BKFHbjOx3AU8pJ/sphrM3vqaGNRIFeK1Po
         CJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzv5eaByYVX50lBqPhTHyIiI1jj84Kw6BozZseArlPM=;
        b=sRDogxi8w0dJls5rRDyMe3UZCOMaRMBYBNw/UN0CJdin7fNLxOYDgLQQX9IA/yC9MB
         ikiwckKwh3ADK+zapqVzuvwgwrHkEdqawrnfg7l5IqtqxGu0QDH0FL9BL/ucHifwX4Tf
         tbmm957+f8jBml72TgLVj9ZNm3hAVVjiuB/fitSSPlAcuiyTPPQ1PpcZgmLe2FDUMa8a
         /fiJItcM8AootBenCb8+mZYIyzchXH+9uHcPXL+h2ljAacQZkZT4yqOdKEtVHkeZzItL
         cFQdmLkJv/UkvPgdSR+BCYI9LLYPLSWDME5ZXhQJG/SDm+UD1gFryQCpey2sgHQCEEgH
         9GIQ==
X-Gm-Message-State: AOAM531iDn4w7rQb33LjHR8lT3hAkVX/eWXLSmz99hcrBlkOot07wU3r
        evTII94JXbtU/QGG0NmDAkR4FVy4mhhifg8R4vgFyQ==
X-Google-Smtp-Source: ABdhPJyc+ioiwIvkUk170KWMBDq2nVqmUPY6DdWy8K66yWGIowx8HzKwMmlFrJy62UL41mTc2zY97koi2C0sOYql2WQ=
X-Received: by 2002:a05:600c:29d3:b0:397:4730:ee75 with SMTP id
 s19-20020a05600c29d300b003974730ee75mr7465039wmd.149.1655262828974; Tue, 14
 Jun 2022 20:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220527185426.240235-1-irogers@google.com> <d9056bc2-f640-f676-2599-c283479376a4@huawei.com>
 <CAP-5=fU8Wn8wV0whYOraU+5tGf+kKUk73gSwOg+LHp19vzua3A@mail.gmail.com>
 <f94710b3-4ca8-47c5-939c-1ad01d712d5f@huawei.com> <CAP-5=fWO8wd2xqi2acJ0FGyLgE3dQDw2m9=AUCC_veseyuybJw@mail.gmail.com>
 <350b905c-1ac1-3577-6b56-c13f2aeab712@huawei.com>
In-Reply-To: <350b905c-1ac1-3577-6b56-c13f2aeab712@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jun 2022 20:13:36 -0700
Message-ID: <CAP-5=fVHtt41ifoWxr7ifd6FSosfhaxRFEJ_ez4KHT3wUQd5Kw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Rewrite jevents program in python
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
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

On Tue, Jun 14, 2022 at 9:10 AM John Garry <john.garry@huawei.com> wrote:
>
> On 14/06/2022 17:03, Ian Rogers wrote:
> >> diff -u tools/perf/trace/beauty/include/linux/socket.h
> >> include/linux/socket.h
> >> Makefile.config:259: *** which python-config not found. Stop.
> >> Makefile.perf:239: recipe for target 'sub-make' failed
> >> make[1]: *** [sub-make] Error 2
> >> Makefile:69: recipe for target 'all' failed
> >> make: *** [all] Error 2
> >> john@debian:~/linux/tools/perf$
> >>
> >> JFYI, this is my alternatives:
> >>
> >> sudo update-alternatives --config python
> >> There are 3 choices for the alternative python (providing
> >> /usr/bin/python).
> >>
> >>     Selection    Path                     Priority  Status
> >> ------------------------------------------------------------
> >>     0            /usr/local/bin/python3.6   50        auto mode
> >>     1            /usr/bin/python2.7         1         manual mode
> >>     2            /usr/bin/python3.5         2         manual mode
> >> * 3            /usr/local/bin/python3.6   50        manual mode
> >>
> >> Press <enter> to keep the current choice[*], or type selection number:
> > Thanks Gary,
> >
> > Perhaps it relates to dev packages. Perhaps, apt-get install
> > python-dev-is-python3 which should resolve the symlinks. I wonder that
> > you have python dev for python2 but python3 installed without the dev.
> > We should be able to make a Makefile test for this.
>
> So I was trying another system here as a sanity test (as my main dev box
> is not working either). And this other system is debian and only
> supports python up to 3.5, so that is why I have
> /usr/local/bin/python3.6 as an alt, i.e. I downloaded and built myself.
>
> Anyway, I do have python3-dev:
>
> john@debian:~/linux/tools/perf$ sudo apt-get install python3-dev
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> python3-dev is already the newest version (3.5.3-1).
>

It turned out to be something simple. The build is set up to prefer
python2 over python3, so if you have both you get python2. I've fixed
this now in v4 (PTAL):
https://lore.kernel.org/lkml/20220615030438.51477-1-irogers@google.com/

I think we should remove python2 build support as it is confusing and
python2 doesn't support setuptools meaning this patch fails:
https://lore.kernel.org/lkml/20220615014206.26651-1-irogers@google.com/
and without that patch python3 generates deprecated module warnings.

Thanks,
Ian
