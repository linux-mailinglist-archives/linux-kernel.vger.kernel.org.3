Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F292F493430
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiASFCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:02:11 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36468 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiASFCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:02:09 -0500
Received: by mail-lf1-f54.google.com with SMTP id b14so4462992lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 21:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csG7BP0E5MCycApgls4Xoh4zoNViHjehFaQcFY5DDdE=;
        b=0Qrs1KSGmD+f6dWXqqL4Kxop73DOT3gZK7n+kmObPzjoQStzg6IG36Hxa63WE13Kv2
         qfNif3Uw2RC7/4ca57C5K4GVtindScnb/FC91aTAZl2WXCSw9l5wi7GeTYDsYdnvR4wl
         jFsZhlH+755q2o6XckWlrwwwu+893g+M8wfPbN6W+ZHfbsDDcQXuZj5tsukdlOQuBE/j
         ukvkzadeXUqG2zWZwRzh9d/OiNoS7GJKJXqapp0db5aIqeL4IOTp6LE8VRWToHLcXtTx
         bpxaFoOT5umdMijH2lbya3eZUMSwQ2fHswSGRiVKXu8mbmJg1FUAnren45X4vA7GFouu
         AA+w==
X-Gm-Message-State: AOAM5311M6vxK0+1/dHQ/n8dqpLF3Yv/xwEQmUXflnxJb3olohC1Y4ZZ
        9uGtRjwFc1ZB1wxS9G1uM+ggzvs/6OPwvEaWrJ3XtXiV
X-Google-Smtp-Source: ABdhPJw8bs/qPaSZ0J6ByA256QqQOWSxj3HGJjZC8N0POTY9+NfvcDvXrHV07aa8u82ABqUiIU4XSW4I5pkeSCsquJs=
X-Received: by 2002:a05:6512:10c6:: with SMTP id k6mr15634494lfg.99.1642568527871;
 Tue, 18 Jan 2022 21:02:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPqJEFoUyHiyNj8Hx-wRaw86NLb5hGo-WT4ysqV4RGerYyDyJA@mail.gmail.com>
In-Reply-To: <CAPqJEFoUyHiyNj8Hx-wRaw86NLb5hGo-WT4ysqV4RGerYyDyJA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 18 Jan 2022 21:01:56 -0800
Message-ID: <CAM9d7chL4_hY8BLHV=q2J_HJ14gUj07t5QvUvUBOj+4hmvY7hQ@mail.gmail.com>
Subject: Re: About perf tool set exclude_guest = 1 on guest environment
To:     Eric Lin <eric.lin@sifive.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yao Jin <yao.jin@linux.intel.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 17, 2022 at 8:05 PM Eric Lin <eric.lin@sifive.com> wrote:
>
> Hi all,
>
> Currently, I run the perf command 'perf record -e branches:u ls'  and
> 'perf record -e branches ls'. It will set exclude_guest = 1 as below:
>
> # perf record -e branches:u ls
> # perf evlist -v
> branches:u: .., exclude_kernel: 1, exclude_hv: 1,, exclude_guest: 1, ..
>
> # perf record -e branches ls
> # perf evlist -v
> branches: ..., exclude_guest: 1, ...
>
> As I understand it, set exclude_guest =1 will not include guest counting.
> May I ask if I run the above commands as a guest user, should the
> architecture implementation ignore this exclude_guest flags and still
> make perf can count guest events in Linux kernel?

So do you want to run the command in the host?
Then you can use both 'H' and 'G' modifiers like

  # perf record -e branches:HG ls

or (for user-mode only)

  # perf record -e branches:uHG ls

Thanks,
Namhyung
