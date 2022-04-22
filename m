Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7583250C58A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiDVXzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiDVXzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:55:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9AF13F4E;
        Fri, 22 Apr 2022 16:52:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p10so16852305lfa.12;
        Fri, 22 Apr 2022 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsvO2wMB3Qbk/iytHzkt7IglSjEYbp/i0Cu+gkwdE44=;
        b=QTMnY2AJSnPps5jnuwUy0IP3g9WIU7vI2GX27pJHOpnbbtPaRa+vQEmZFfNUkXkmDZ
         SEzwmZQtzHCI4fOj6Rjh3G6vnouUPLcSt5gjptd0b5YhvwnqttqFH4vV3YbpJocDAYBz
         vCHo9u1/cYRJ28jtI3UdcqSgiZLI70n4L0+jNSCA65HWDTIm9Oh1u1jysrm9K0CtlJAd
         f1Zpf4DJhQdpSFE/zC0JLnjNEoNIrGH4p8kZrGvZUO7n3KdfYAYeD6tZFnaB7AOE/9my
         W6rMyEFemk/ePCVZGUbV9JWkbKQURYRc0u2BMqPoMVbDU3StBwVKyQeoR6rPfjkcO/up
         bVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsvO2wMB3Qbk/iytHzkt7IglSjEYbp/i0Cu+gkwdE44=;
        b=P8KOOZTYIQwmPLezcv1nL/Tkf+ZW/1ZfL5gzPtFqVzsTC70o+eDEHvCfR3vGAxdx/7
         ey/xg4YgCRXK1P2eDY58GFxhtriPfqVaa3mGeJAsMo2z9vuTzh7m0qlQZSHQhyT7nBli
         JOFws5eE/a3bRNQ6ChdYKX8h1UrZVvn3z8D5buEKTrt6uk/qNhKPS50tGJighl3JPwgP
         SK6tkbqvtK0DTsg9uPAWah5vOKeMWKVbcp4HL1x9JbwU13UQ+qHd8p5S4Qmk58RKzi4s
         McgInRYmf9LF7Qdkw0j6+zpJrrSpbhOTNSBGJZPLJFIggNZQ3I6TImuUSgLM8e4GxynO
         izyg==
X-Gm-Message-State: AOAM5315WGZYODyoo/+vdL9IPISmYCD0RjD+NDoTQsZVQMaCrONTIf6H
        KqCUXmX4oX8Vu46ldA86ImgvZReKIrMg/n86Qck=
X-Google-Smtp-Source: ABdhPJzyC9nBLD31XHA+XWLnKx0DQ/mq+sCUdsn6Cf/9Q2vs4h+vocDyxZ2AQeGXwHRGFcttUV1CKSXFg783SBx67Rc=
X-Received: by 2002:ac2:5dd3:0:b0:471:f6fd:441e with SMTP id
 x19-20020ac25dd3000000b00471f6fd441emr211405lfq.454.1650671531572; Fri, 22
 Apr 2022 16:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220420102354.468173-1-florian.fischer@muhq.space> <YmA48V09iBbqy6su@kernel.org>
In-Reply-To: <YmA48V09iBbqy6su@kernel.org>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 22 Apr 2022 16:52:00 -0700
Message-ID: <CAM9d7cjcA0aYC1otY4WvCJ_h71P9wiHu42GK7iyv3=i01rQ26Q@mail.gmail.com>
Subject: Re: [PATCHSET v4 next 0/3] perf stat: add user_time and system_time
 tool events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Apr 22, 2022 at 3:05 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Apr 20, 2022 at 12:23:51PM +0200, Florian Fischer escreveu:
> > This patch series adds new internal events to perf stat exposing the times spend
> > in user and kernel mode in nanoseconds reported by rusage.
> >
> > During some benchmarking using perf it bothered me that I could not easily
> > retrieve those times from perf stat when using the machine readable output.
> >
> > But perf definitely knows about those values because in the human readable output
> > they are present.
> >
> > Therefore I exposed the times reported by rusage via the new tool events:
> > user_time and system_time.
> >
> > This allows to retrieved them in machine-readable output:
> >
> > $ ./perf stat -x, -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time tools/perf
> > 72134524,ns,duration_time:u,72134524,100.00,,
> > 65225000,ns,user_time:u,65225000,100.00,,
> > 6865000,ns,ssystem_time:u,6865000,100.00,,

ssystem?  Looks like a typo.

Anyway it looks a little bit strange to me if we can get
system time in user mode only (the 'u' modifier).

Thanks,
Namhyung


> > 38705,,cache-misses:u,71189328,100.00,,
> >
> > The changes are mostly inspired by the code for the only other available
> > tool event: 'duration_time'.
