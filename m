Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF74BA757
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiBQRlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:41:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbiBQRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:41:13 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2E12B3ACC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:40:58 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d66f95f1d1so40066737b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xG7+45oqf2NS1ULMFZPBvVQbomZLDhmCLViBMWlu/5k=;
        b=hz0dRrKJ7PWqiodgggDAx7ROzkgUjtT6NmpVRxtVC0QGo4NeVEVB+VN8NLY0fNtCgt
         wzyYrGNpB+1/XQkvDm99hmXwydVFpwj/3e50GVor5HYxdiuqYMAtLXy35cJtPAE5O4hU
         ZlPQUm7v+e3K0QcJ+Zqzw+ojAU4xWZCsCwEttSE2Jejij1E/NqBgXXNugSl0kuEBo4Xc
         A+N2nZgn8yz4JqWgL4BIma/aSVex/ZKBdtImt9SNh9RlanaM7KXKElEDZK2z8mddp48V
         NjkVYIzvKFZGoR31t2+/F23ouE/xGT4rHAewpWqe4VAJ8gg7QMB8SA9AHAkEPjuUrTuQ
         1V4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xG7+45oqf2NS1ULMFZPBvVQbomZLDhmCLViBMWlu/5k=;
        b=iTTOgc+FOIyJ/vM7W2YFqLSFu39jC11QUHN3w9v+DJJ8n5h1w4/BwhyZ03tckQIs37
         Q0f1BaBW26PFxPnEtpbOn1aOlRdpqh3BrslMruCAYaYdK8cI9tjOJkIg1cBKAwsi0/9J
         VnP2TDW8b8JaRp5GtoY5iTUEvn6OiEVuIQM91S91jVJNwyNlzxuW52I3K1vV1uvqqw5y
         vQS/FZu17OqRTVswdqWw1YBhO4o8vqQtfmU4hwciMDyaMq5/IoSLthKBglbkd8WOX4CX
         QJZ0WIY/35VWrSlKaY3lM4jEWKDWdCyB2L+/kPl7/PWV4QtKvZKHKym0b0So0ntiko+Y
         fegw==
X-Gm-Message-State: AOAM533XEj7q4ixXFX9D9OJxpPAlU3C7Q/K/VreOCvX3TRygnIWOyHhd
        3snjKnzaqwifCDIhi7a91GB1AwZiGv0D1JJkR/UXlg==
X-Google-Smtp-Source: ABdhPJwwvBrGab+ahjvONXUZlOncszsPm0JyUwad3a8Qevmv31Bpy7OktCb6OFGKSZ+G4L3pvPjfzXQpuycf9DGgoNI=
X-Received: by 2002:a0d:ee41:0:b0:2d2:f0aa:d3ba with SMTP id
 x62-20020a0dee41000000b002d2f0aad3bamr3808690ywe.512.1645119656516; Thu, 17
 Feb 2022 09:40:56 -0800 (PST)
MIME-Version: 1.0
References: <1645114959-119064-1-git-send-email-john.garry@huawei.com>
 <CANpmjNOO6yxF+xXoatR==uvSaEwsWyZ=n7ExEM_=OJaDYBCeSw@mail.gmail.com> <f7782f09-7f12-b957-a1b2-d0673ec1304c@huawei.com>
In-Reply-To: <f7782f09-7f12-b957-a1b2-d0673ec1304c@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Feb 2022 18:40:45 +0100
Message-ID: <CANpmjNOO-fsU7PP_PqeT53_N=xmNruiT3mvE0e1y=EtKJUfFGg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip Sigtrap test for arm+aarch64
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        leo.yan@linaro.org, dvyukov@google.com, will@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        irogers@google.com, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 at 18:34, John Garry <john.garry@huawei.com> wrote:
[...]
> >> -#if defined(__powerpc__) || defined(__s390x__)
> >> +#if defined(__powerpc__) || defined(__s390x__) || \
> >> +       defined(__arm__) || defined(__aarch64__)
> >>   #define BP_ACCOUNT_IS_SUPPORTED 0
> >>   #else
> >>   #define BP_ACCOUNT_IS_SUPPORTED 1
> >
> > This is now equivalent to BP_SIGNAL_IS_SUPPORTED
> > tools/perf/tests/tests.h -- and different from the original
> > BP_ACCOUNT_IS_SUPPORTED (and makes me wonder why
> > BP_SIGNAL_IS_SUPPORTED wasn't just used from the beginning). Perhaps
> > just use BP_SIGNAL_IS_SUPPORTED.
> >
>
> We currently have BP_ACCOUNT_IS_SUPPORTED defined now in 2x locations:
>
> tests/sigtrap.c
> tests/bp_account.c
>
> bp_account works for arm64, and we don't want to skip that test. So, as
> long as the macro meaning is appropriate, we can reuse
> BP_SIGNAL_IS_SUPPORTED for sigtrap.c

BP_ACCOUNT seems to say something about the "breakpoint accounting /
measuring" test. BP_SIGNAL is about the tests that want to use
breakpoints to generate signals.

So it's very much appropriate to use BP_SIGNAL here if, as we have
discovered regardless how they're generated in response to
breakpoints, are broken on arm/arm64. On the day arm/arm64 decides to
fix signals, I'm assuming all tests being skipped with
BP_SIGNAL_IS_SUPPORTED can be re-enabled (or so we hope).

Thanks,
-- Marco
