Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08086599055
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbiHRWPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbiHRWPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:15:52 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862F5D7CC7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:15:51 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y18so2200000qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=M/XssIYSX7PJg8XX/OCwv5wRKVVolBwpSHoWeNBAk0o=;
        b=xoHgdM10FkEZrJRvbAzjNs+u9Vf/qJ1doeu8xZyyXN6mMoz8mDgrZUodjLXDlk+GDt
         N5r/Q1l6A1v9GdZTNIkDwjaS4G5ZMBpXUS5pCfQWAxa+UhYzbUiVIY1xUt92TdOheSwX
         3fn9RG63YVwPngMu1rk6XeZXjNxIMeLWCo1x3BVFIM6V/ZLl+beToVE0Oql0StwL68bw
         WBxa5CzdmnKq5ouC29fRL+MJ1o1ggXw3N0kK6QEGL5YeqCCy8RU+z/hP5ZL3i+uaHl0g
         /hCyvxpWCyCmIk566j8mEBzvzZFg8u5SWskVtjZureKGqNhqJSp5BfVurThxg0d6PgtA
         f2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=M/XssIYSX7PJg8XX/OCwv5wRKVVolBwpSHoWeNBAk0o=;
        b=XtoREXFbNy/bv4zpVvGU5PKcq2PgTLEaYvkYrTHOqh4Rr3lFawUvAXNuPlMR8tOMvR
         yJsj2UXhx4/CZQySICC9nIGEWN4iSiKY269PJXTeb/joJiwvdPdfoOw0E/h8cm6Fz50V
         ai/OeDppj34+sRlKFrmPnvhxCwvfw07bnozPRm091IsDkiUvFeE4/12b362VQ9BdzhNR
         3FumFK2UV8LDph3d7pKImr9NaF7b0tpbhb9l+wUoVCfuPDolDwVW+QfYBlfmNtEOvwBS
         doS+6+Slvb+U6xhGEmE0QXu/CqonEZeq+C/YxJJqlqS6fndSquh3f1ZHctKo+l8CDZBU
         CkkQ==
X-Gm-Message-State: ACgBeo0RmQyXE6SepXU5Z5r7KvSjTEoN/7wwMmEgTKihLnibbJNeZHhv
        8NGoLmxJJW1mDYAF5YMjmYE/B1VDFKJNA4W4bw1X0A==
X-Google-Smtp-Source: AA6agR6U7sSVnmtcyjZ12uDaiox6o3b0HNoOrrTnSONCtwkuDnMGLQqWGXAZtpVkEMp71YegJeJwVyN3DbKZMBcbE5I=
X-Received: by 2002:ac8:570e:0:b0:344:88d7:5ee3 with SMTP id
 14-20020ac8570e000000b0034488d75ee3mr4317394qtw.522.1660860950704; Thu, 18
 Aug 2022 15:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
 <20220818120957.319995-3-roberto.sassu@huaweicloud.com> <Yv46EW6KbUe9zjur@kernel.org>
 <71544d2970e246e1f0d5f5ec065ea2437df58cd9.camel@huaweicloud.com>
 <23da162e-1018-9bfa-bc5c-ec09eba9428b@isovalent.com> <Yv6BaHgC4E4J0TTT@kernel.org>
In-Reply-To: <Yv6BaHgC4E4J0TTT@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 18 Aug 2022 23:15:39 +0100
Message-ID: <CACdoK4LLuxCd49y3dUoi7wyq-OLF2xjurvpc5C3n15bsYeMNKg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 at 19:14, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Thu, Aug 18, 2022 at 05:40:04PM +0100, Quentin Monnet escreveu:
> > On 18/08/2022 14:25, Roberto Sassu wrote:
> > > On Thu, 2022-08-18 at 10:09 -0300, Arnaldo Carvalho de Melo wrote:
> > >> Em Thu, Aug 18, 2022 at 02:09:57PM +0200,
> > >> roberto.sassu@huaweicloud.com escreveu:
> > >>> From: Roberto Sassu <roberto.sassu@huawei.com>
> > >>>
> > >>> Sometimes, features are simply different flavors of another
> > >>> feature, to
> > >>> properly detect the exact dependencies needed by different Linux
> > >>> distributions.
> > >>>
> > >>> For example, libbfd has three flavors: libbfd if the distro does
> > >>> not
> > >>> require any additional dependency; libbfd-liberty if it requires
> > >>> libiberty;
> > >>> libbfd-liberty-z if it requires libiberty and libz.
> > >>>
> > >>> It might not be clear to the user whether a feature has been
> > >>> successfully
> > >>> detected or not, given that some of its flavors will be set to OFF,
> > >>> others
> > >>> to ON.
> > >>>
> > >>> Instead, display only the feature main flavor if not in verbose
> > >>> mode
> > >>> (VF != 1), and set it to ON if at least one of its flavors has been
> > >>> successfully detected (logical OR), OFF otherwise. Omit the other
> > >>> flavors.
> > >>>
> > >>> Accomplish that by declaring a FEATURE_GROUP_MEMBERS-<feature main
> > >>> flavor>
> > >>> variable, with the list of the other flavors as variable value. For
> > >>> now, do
> > >>> it just for libbfd.
> > >>>
> > >>> In verbose mode, of if no group is defined for a feature, show the
> > >>> feature
> > >>> detection result as before.
> > >>
> > >> Looks cool, tested and added this to the commit log message here in
> > >> my
> > >> local branch, that will go public after further tests for the other
> > >> csets in it:
> > >>
> > >> Committer testing:
> > >>
> > >> Collecting the output from:
> > >>
> > >>   $ make -C tools/bpf/bpftool/ clean
> > >>   $ make -C tools/bpf/bpftool/ |& grep "Auto-detecting system
> > >> features" -A10
> > >>
> > >>   $ diff -u before after
> > >>   --- before    2022-08-18 10:06:40.422086966 -0300
> > >>   +++ after     2022-08-18 10:07:59.202138282 -0300
> > >>   @@ -1,6 +1,4 @@
> > >>    Auto-detecting system features:
> > >>    ...                                  libbfd: [ on  ]
> > >>   -...                          libbfd-liberty: [ on  ]
> > >>   -...                        libbfd-liberty-z: [ on  ]
> > >>    ...                                  libcap: [ on  ]
> > >>    ...                         clang-bpf-co-re: [ on  ]
> > >>   $
> > >>
> > >> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >>
> > >> Thanks for working on this!
> > >
> > > Thanks for testing and for adapting/pushing the other patches!
> > >
> > > Roberto
> > >
> >
> > Tested locally for bpftool and I also observe "libbfd: [ on  ]" only.
> > This looks much better, thank you Roberto for following up on this!
>
> So I'll add your Tested-by: to this one as well, maybe to all the
> patches in this series?

Sorry, I haven't tested the first two patches other than by applying
them, so just for the third one preferably. Thanks!
