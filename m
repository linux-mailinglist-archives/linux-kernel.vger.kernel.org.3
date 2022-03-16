Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4E4DA6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352737AbiCPAFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbiCPAFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:05:11 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AB7112A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:03:58 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q64so434830vkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0PTuaHeE9lpotEmrMS9hZ6VD8ms3czKbwFkF1x19UY=;
        b=VhUGhZAOPvyHLUT+A1umGpZ/vZ/peaapiKxXbjVGYOUgeQqQQFjLjN7wvo/W5fNBxx
         VXgmvEKngcIkG4Qyl7Ry2lps9rIuWHW0c2xY14UXB7PjSw5GoOC9cFQTXiKBR6Fm3iYG
         Yb8dT8PzQrrkbhHVoF+ELGt0n9uLWtYHWF+HAZOrjiqKFJ217PGXu9zQK3YMwNutEHDw
         9CYm/Xi1Lpqz4fgO4lu2Ma59HcT+R5WKXA6Jw34FCNn3Ke7bziCEO9K3ev/M5Bg6wpNV
         RXWtEOvkLs9doxLKLcYmKTQPkD5sxDZSzzi6y5jjQwNK3hlNpYwJUPqMbd7U8YPdKc3D
         V/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0PTuaHeE9lpotEmrMS9hZ6VD8ms3czKbwFkF1x19UY=;
        b=jgxzxyhmAX+8SLNOFcXUWTzY63BL6KXJ4X9YkMWjLqm0IEfxCP3R0JGPNzbqTq9Yp2
         c1iOLW2NSVFMLDE2GwukFsdOd40tY/NHGwPCdt7JpAS2bHL9khANlZ+BmjE+GyRQLokl
         YyTavzgcJ6QYC8vP5yYVYAm2/SwcJXKFFyrb5oijk+oaHsgx16RrVIZZWk7iP5lnAdSf
         4to7jCX/d1v/PIt0lrLXaVSswB792uHeHxXaUNN+mYOn05hyCbIpVG3csSVOEt2MvFWz
         xv7w+ULoloWtsOt3ouELlHrbtDW0lLyKwEyJqI5xdSPADl6zc8EizkS0wxXV0AonDdeK
         ZyYg==
X-Gm-Message-State: AOAM53226IsWMSYwbvFJlUmMdrD7QYgvwcTJm+MZ9Qz5ZExLhz1Lcvej
        /Cxf85c35Psg1n0XvbVIWjHYF4MkjdHq5kKNAIQk4w==
X-Google-Smtp-Source: ABdhPJyiuueZES60P29M2uU+hIBGuqPnvQJcyvCNzltziRQdUno7JkUh/vUPMMY2Ghyh3T4y5/f9r7EkABjMilV9AA0=
X-Received: by 2002:a05:6122:551:b0:338:9106:479b with SMTP id
 y17-20020a056122055100b003389106479bmr11665939vko.22.1647389037245; Tue, 15
 Mar 2022 17:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com> <20220208211637.2221872-11-eranian@google.com>
 <aa641092-98e6-114d-b423-13e0bff248fa@amd.com>
In-Reply-To: <aa641092-98e6-114d-b423-13e0bff248fa@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 15 Mar 2022 17:03:45 -0700
Message-ID: <CABPqkBQZRVqWPFG0Dvc6HGxNcDDb0raaRw4Ur27CvR5O8vwALg@mail.gmail.com>
Subject: Re: [PATCH v6 10/12] perf tools: Improve IBS error handling
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com,
        linux-kernel@vger.kernel.org
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

On Tue, Mar 15, 2022 at 12:46 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Stephane,
>
> On 09-Feb-22 2:46 AM, Stephane Eranian wrote:
> > From: Kim Phillips <kim.phillips@amd.com>
> >
> > improve the error message returned on failed perf_event_open() on AMD when
> > using IBS.
> >
> > Output of executing 'perf record -e ibs_op// true' BEFORE this patch:
> >
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
> > /bin/dmesg | grep -i perf may provide additional information.
> >
> > Output after:
> >
> > AMD IBS cannot exclude kernel events.  Try running at a higher privilege level.
> >
> > Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:
> >
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
> > /bin/dmesg | grep -i perf may provide additional information.
> >
> > Output after:
> >
> > Error:
> > AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity
>
> This patch seems to be causing regression to perf python test.
>
> Without this patch:
>
>   $ sudo ./perf test -vvv 19
>    19: 'import perf' in python                                         :
>   --- start ---
>   test child forked, pid 145391
>   python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
>   test child finished with 0
>   ---- end ----
>   'import perf' in python: Ok
>
> With this patch:
>
>   $ sudo ./perf test -vvv 19
>    19: 'import perf' in python                                         :
>   --- start ---
>   test child forked, pid 144415
>   python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
>   Traceback (most recent call last):
>     File "<stdin>", line 1, in <module>
>   ImportError: python/perf.so: undefined symbol: perf_env__cpuid
>   test child finished with -1
>   ---- end ----
>   'import perf' in python: FAILED!
>

The fix I sent you is just to prevent a potential SEGFAULT in
is_amd_ibs(). I bet the test fails some perf_event_open()
and ends up in strerror function and from there I don't see how the
patch could impact the test, given you'd segfault
otherwise.

I tried on my side and with or without this patch this test fails. I
think this looks like an unrelated issue.
