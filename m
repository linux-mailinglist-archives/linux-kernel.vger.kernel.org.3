Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED34A4D99
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347646AbiAaRzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiAaRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:55:36 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFBBC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:55:35 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id s1-20020a1ca901000000b0034ece94dd8cso10688677wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=VrZHx8N8g0O6dwodQoj1XNHskBjb0HhFafa31s7VMgk=;
        b=nWvfixk4yh5PbGt79V2iCqFfkTKH5zKzS8MudKMCUHNxfzJ4GZQ4rDpJ5LZnx64IfZ
         82NcdxxTdh7gbNVTzwrGx2wnF+7hFQBoEg41y98HTzrEGgvdt46ilZZ9pmOnUaPQDpqr
         eeuTcLIulvK64P6i1YryEEYbWwUZwQ9od/5QIircH4FpZHy9HTEQF/IcTTObip1vvPcd
         bQzec5cMP3yP01KrIg3SqLrkAYSGz4Hui7eAaDKjGyaJKT1e35L8b7zZNk4gV+wBJ1ru
         OdKKIA4pqS8D5PuNyTT8LZ4RtMfZ1xup6/C4Ypo/eB3/zLpb97esmkvf1iXzYSAtdxtv
         k3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=VrZHx8N8g0O6dwodQoj1XNHskBjb0HhFafa31s7VMgk=;
        b=iSl1EqJKAA3EzWStExyazjhulhWtjvY5AkoPJ8KrnpWO8KtpPAh8/PfoBQMa/OK/y1
         Pr6hyTUhj7sfuhF6AAw3W1uGyhXELcCP0KofPb/vBgbt4rDQCL5AFE2H3J/dYXpK276P
         j627UYo9C9u7Wx3FgzS9Uj8+SO9sasdZle8bZNAgun2dkZYmUeOUGX+QdrM4niqnHPr9
         fLr7nWshmL7K0CZn+ePdpOL9FsmEBSbVsdamaP3ijZdxcqiaAJ8RK78+oOTKGqjHXXgL
         fZpcr/RUPfdOBsYHn3s0Ujqru4FMSdfGxVIPRM/J3/TfveXSt1m3L/oIi2LfJbK66yns
         nRFA==
X-Gm-Message-State: AOAM531F6eqgpfwisD5+QyKzccoSFd1fHT2vh3wR9p3wBTSJqw7It2b1
        QksCXWUEjQ9CFX6lsYbEgbMY+HIDqUQK
X-Google-Smtp-Source: ABdhPJxHennodC/+cd6ZOUruQWTb8/+u1dzSds30IHTelkH7rDf5BlnRcQNdPhCCRMet202osOz3eiou1nVC
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:70c0:d6e6:d591:3fd1])
 (user=dvyukov job=sendgmr) by 2002:a5d:518c:: with SMTP id
 k12mr18236072wrv.169.1643651734018; Mon, 31 Jan 2022 09:55:34 -0800 (PST)
Date:   Mon, 31 Jan 2022 18:55:26 +0100
In-Reply-To: <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
Message-Id: <20220131175526.1777801-1-dvyukov@google.com>
Mime-Version: 1.0
References: <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: Test 73 Sig_trap fails on arm64
From:   Dmitry Vyukov <dvyukov@google.com>
To:     john.garry@huawei.com, will@kernel.org
Cc:     acme@kernel.org, elver@google.com, gor@linux.ibm.com,
        hca@linux.ibm.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 18/01/2022 12:43, Leo Yan wrote:
>
> Hi Will,
>
> Can you kindly check below the question from Leo on this issue?
>
> You were cc'ed earlier in this thread so should be able to find more
> context, if needed.

Hi Will, John,

I wonder if PSTATE.D flag can be used to resolve this
(similar to x86's use of EFLAGS.RF)?
I naively tried to do:

void OnSigtrap(int sig, siginfo_t* info, void* uctx) {
  auto& mctx =3D static_cast<ucontext_t*>(uctx)->uc_mcontext;
  mctx.pstate |=3D PSR_D_BIT;
}

But then I got a SIGSEGV from kernel.
But I wasn't able to track yet what part of the kernel did
not like setting of D bit.


> Cheers,
> John
>
> > On Tue, Jan 18, 2022 at 12:40:04PM +0100, Marco Elver wrote:
> >
> > [...]
> >
> >>> Both Arm and Arm64 platforms cannot support signal handler with
> >>> breakpoint, please see the details in [1]. =C2=A0So I think we need
> >>> something like below:
> >>>
> >>> static int test__sigtrap(struct test_suite *test __maybe_unused, int =
subtest __maybe_unused)
> >>> {
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> >>>
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!BP_SIGNAL_IS_SUPPORTED) {
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debu=
g("Test not supported on this architecture");
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
TEST_SKIP;
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >>>
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> >>> }
> >>>
> >>> Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse it=
 at
> >>> here.
> >>>
> >>> [1]https://lore.kernel.org/lkml/157169993406.29376.124737710291797557=
67.tip-bot2@tip-bot2/
> >> Does this limitation also exist for address watchpoints? The sigtrap
> >> test does not make use of instruction breakpoints, but instead just
> >> sets up a watchpoint on access to a data address.
> > Yes, after reading the code, the flow for either instrution breakpoint
> > or watchpoint both use the single step [1], thus the signal handler wil=
l
> > take the single step execution and lead to the infinite loop.
> >
> > I am not the best person to answer this question; @Will, could you
> > confirm for this? =C2=A0Thanks!
> >
> > Leo
> >
> > [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/arch/arm64/kernel/hw_breakpoint.c
