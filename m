Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC4570F09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiGLAo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiGLAoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:44:23 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822321146C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:44:22 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g6so8367879qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGTGuYa2fBktqF6ANS0pW/MRRXdihHucX+zpCB0BRDY=;
        b=YwfcYXk+tBGkgAD3HXPtacLw/NXJE4IHNS8mmUc5VhFYxm5hRuUexGwuzoMx7kF9Y5
         qE+cjG2m+mxPSQY8BfNUdmZb+6qgMoRUpUbOgsU/j4PzA0py9L0yQW1UP5hkqQIXCzas
         h9ZFY5+0K8rVQ8HBcODnA4HMnTYqBj4tqH+WMv2E04k8XMPD0CJG2vyVsg/sSayAB1ZO
         4FXj1p1zHQXIFVo73u3QBcewEQQrP5+2/uy6sM93i8G8AqkEux/9LNB5XxZopCzN9EUR
         NoL9uA4jmsf+por4SZA2GMvGF8eQBFWHgqGynpeMPShrW3SbFfgl4wfCjWAKjydi887h
         fHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGTGuYa2fBktqF6ANS0pW/MRRXdihHucX+zpCB0BRDY=;
        b=XZRBL2aN1X7/RiMplMdFxw8UqYi+AHVIdwUOFSPuVyTMdyB9/mRmY16Bj29xegGSak
         87z4PH7AunxAY5pnT5XUAe5ye61o6LY2ho2Av6jtcDWeR5M3WV8y5aYhXOKo+ELiLi7j
         e+l2XKfcIqRxGpXj14huOi+V+vFHJVyv+PACQRLJ1qLEPiMvG3BtE/tcTmb7/tLJ1a3w
         zjloKQQOZBd/zf1Gq0lDCGCbEx+BjnuWvuM2r8ivCCxk0PwcKpt3PdB70bet7aEXMJQN
         lH+0b+LmEJcdXU8HaUH1yW8GV29Bw1HEbqtrfoZ4mq5jYg3Q0qboQ0Kjy+U6jgXsUIX2
         Yi2A==
X-Gm-Message-State: AJIora+Gk1ZSryEuxZZuHz+d6tE8tL9zJnlfcwNJ1pDPzJOYYbgbxTqf
        vypIVjAUJm7DPEkVpxtfh5s6KL7PDo4EyFahkqgPMg==
X-Google-Smtp-Source: AGRyM1vFyCdW9dSrujokTr0N8KUMJS8IIAY1zP93BiNl32HbT763Dw2R7A2EHAIh+3eYGGZxitxW2lqF469EZO9GX/E=
X-Received: by 2002:ac8:4b42:0:b0:31b:efb7:7e9c with SMTP id
 e2-20020ac84b42000000b0031befb77e9cmr15818369qts.566.1657586661560; Mon, 11
 Jul 2022 17:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220709000439.243271-1-yosryahmed@google.com>
 <20220709000439.243271-9-yosryahmed@google.com> <b4936952-2fe7-656c-2d0d-69044265392a@fb.com>
 <9c6a0ba3-2730-eb56-0f96-e5d236e46660@fb.com> <CA+khW7gu73pRFi73BR20OCJhzrs8-kHfTYYR38+MJUpt6wqXoA@mail.gmail.com>
 <e2f8fcd8-9219-1119-86ca-69714789d494@fb.com>
In-Reply-To: <e2f8fcd8-9219-1119-86ca-69714789d494@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 11 Jul 2022 17:44:10 -0700
Message-ID: <CA+khW7iE=qQTCMGteBysz509eSufc2EGu7T7A2ODMT1TZDsgug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] bpf: add a selftest for cgroup
 hierarchical stats collection
To:     Yonghong Song <yhs@fb.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org
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

On Sun, Jul 10, 2022 at 11:19 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/10/22 11:01 PM, Hao Luo wrote:
> > On Sun, Jul 10, 2022 at 5:51 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 7/10/22 5:26 PM, Yonghong Song wrote:
> > [...]
> >>
> >> BTW, CI also reported the test failure.
> >> https://github.com/kernel-patches/bpf/pull/3284
> >>
> >> For example, with gcc built kernel,
> >> https://github.com/kernel-patches/bpf/runs/7272407890?check_suite_focus=true
> >>
> >> The error:
> >>
> >>     get_cgroup_vmscan_delay:PASS:cgroup_id 0 nsec
> >>     get_cgroup_vmscan_delay:PASS:vmscan_reading 0 nsec
> >>     check_vmscan_stats:FAIL:child1_vmscan unexpected child1_vmscan:
> >> actual 28390910 != expected 28390909
> >>     check_vmscan_stats:FAIL:child2_vmscan unexpected child2_vmscan:
> >> actual 0 != expected -2
> >>     check_vmscan_stats:PASS:test_vmscan 0 nsec
> >>     check_vmscan_stats:PASS:root_vmscan 0 nsec
> >>
> >
> > Yonghong,
> >
> > I noticed that the test only failed on test_progs-no_alu32, not
> > test_progs. test_progs passed. I believe Yosry and I have only tested
>
> In my case, both test_progs and test_progs-no_alu32 failed the test.
> I think the reason for the failure is the same.
>
> > on test_progs. I tried building and running the no_alu32 version, but
> > so far, not able to run test_progs-no_alu32. Whenever I ran
> > test_progs-no_alu32, it exits without any message. Do you have any
> > clue what could be wrong?
>
> It works fine in my environment. test_progs should be very similar to
> test_progs-no_alu32. The only difference is bpf programs with different
> insn set. Some tests may not run with test_progs-no_alu32, e.g., newer
> atomic insn tests.
>
> I have no idea why test_progs-no_alu32 won't work for you, I guess you
> may need to debug it a little bit.
>

Yonghong, I reproduced the failure using vmtest.sh now. Yosry and I
are debugging it. Once we have any result, we will report back. Thanks
for taking a look.

> >
> >>>
> > [...]
