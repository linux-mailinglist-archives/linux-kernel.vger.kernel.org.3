Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78D05988BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbiHRQYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344754AbiHRQX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:23:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DF3C578F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:21:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u14so2294237wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+GXISQvtaIcczS69+RKhoaC+BLvnMP0XhURL22EwPBU=;
        b=WHexSDDDQjVU9NY71f0bjUOuwxytNIer3Tv63ip49uSINYcJORiqINdb07+ix16PGN
         5PTNc8T9hJVyDH2RBz+as8zwM86Low33SAwdhadn5Asd98HMnXqseX6qBMKS6dQXOoAa
         vT6Hb3DQv/tzL6xGVBpBT/n80onTny5H2Zlxs3yHwQjNdjdU9C9Nfqq834Ov3MYpTbiO
         XNtbNG8hsPIRN7xIE5HM3NpvkCiui38PbAj1aLUOCu+H6rh7bfyxAhQ4pEunBo90wawO
         WPSaXyYDe2ba+NXiUBFeQBqP+3eC7YvjoahD/Pzm2bVnbFwMWn0ijoCDtRR5SDdxq5Gu
         B/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+GXISQvtaIcczS69+RKhoaC+BLvnMP0XhURL22EwPBU=;
        b=hSWIHyAk18Y8W/txu9w3iKCD0p031i1z4Vkt/YvFZA3C/a731UKw1WaQuuKXIyoU3P
         ZXTehhl3dyz3sZrz0cC3133gGb3Tmlkkw7zLkVBxsTepwxTSHlB7fcW+2oTY0Hn1OnU2
         MQQfRR28kylhzO3UVLez5KIywaXPSeO0BhABZAnHZEfgci0KSEwKjedNMLQTb5XDhbCf
         4SMtQBGGwANgOyas0Jw+uolsdWflReZh/FMaoJz79YUkHPxN8KTE1R1WBvfaag7cXHB3
         8s0TInJpeNcB2cSQNIVH5x+nCjbR6Ojqr2T+iQ/7M0PO9tUp+9MoI4hvpOWtqDoxeGPd
         b1BQ==
X-Gm-Message-State: ACgBeo3qyL5cSgQUunAy2vhtsKUusjzGx42wm4Ba5Duba+DqkXGXPhmB
        +e0orUvLk151qCsqcXEayEe67kAun2YwqvoXcZvulg==
X-Google-Smtp-Source: AA6agR5WiRUlNtYVxk55SwJWX8bStnebINMwUik3f8z7aHgP2E1PlCV+C4Trq6lf6Yo0nPXPOIntbx+RvWDS+Cb/vq0=
X-Received: by 2002:a05:6000:1a87:b0:222:2c85:2f5b with SMTP id
 f7-20020a0560001a8700b002222c852f5bmr2110287wry.654.1660839664062; Thu, 18
 Aug 2022 09:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com> <20220817053930.769840-7-irogers@google.com>
 <CAM9d7cgd-KsqJNxh_MbX9h4tr8rOtAqKe-t7Qfck0m9pTxWK7w@mail.gmail.com>
 <CAP-5=fVVV8UPppzet7jwvrf9ig8RpWE1x4mxAJBAnuqbdSbP-Q@mail.gmail.com> <CAM9d7ciGRnz-wP+Riz5AYf8k9QOztV-Acfg=jivijeM8UUAPEw@mail.gmail.com>
In-Reply-To: <CAM9d7ciGRnz-wP+Riz5AYf8k9QOztV-Acfg=jivijeM8UUAPEw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 18 Aug 2022 09:20:52 -0700
Message-ID: <CAP-5=fVuSMcTnjRvjg-xT7yNuAHDcGMrHFE6CZUdPbMtG9eO-w@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] perf build: Enable -Wthread-safety with clang
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        llvm@lists.linux.dev
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

On Thu, Aug 18, 2022 at 8:59 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, Aug 18, 2022 at 6:17 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Aug 17, 2022, 11:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, Aug 16, 2022 at 10:39 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > If building with clang then enable -Wthread-safety warnings.
> > >
> > > Do you know the minimal supported version for the option?
> > > I'm not sure we have a check for that kind of thing.
> >
> >
> > It has been supported for a long time, close to 10 years. Looking
> > around it looks like clang 3.5 had the support. For context, BPF was
> > supported after clang 3.7. Given this long support, and we don't
> > version check for BPF, I think it is okay to assume the flag is
> > supported.
>
> Good, thanks for checking it.

It was a good point, thanks for the reminder!

Ian
