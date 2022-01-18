Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44576492270
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbiARJSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345515AbiARJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:18:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D24C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:18:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a18so76626581edj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=epXjxVZYGdrS5V2vncnZJ3QtAgAqtwFKvMdQBktjbpw=;
        b=IFjPIDyeHD1pa5vazociaIVltQeXFZP1IdZTMMldhbplf7rS2ghHX6lhePpdxZDlN4
         pyD/vK623ixNxbD156KLjuu+xovW29aHl7KMyPjoM8UHmrx0T7gaExFrg5dtNLneIk05
         8lHTr3rAmRDP7a2x25z+hqUWZb4eJTe1/KLbmMqJCuvy5aEcVQaoFB9Y/IbA/Cl7yQu5
         BkkBu3jJR9BBK5r3tgF2Me27nwdmkXjKyBULFKE08+siXHIPY9zyLt/FdMe23siMG10V
         7HfCoKachHeLruBO0zJHVKKgNXN+sGZ/jOnJqWyjKFs2zwicoBfakSbE6GN7QxVFweur
         WZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=epXjxVZYGdrS5V2vncnZJ3QtAgAqtwFKvMdQBktjbpw=;
        b=WikBn4vJ/w/S/GBwX+AFURLU9W2BDoHJA4o7YypVSiti6r9B7tJngDhXsnls5PKTfE
         ospIuaJ1zfAPoOnF9E1yzB3gazP6fpDd2XJh1gdLCdPknCewrcjYks/2+v83ro2LaQQs
         Gr+mB70SHYBhBKtkBrdnjQqGhQzlKVxKtsucYtJ52hzNhIRC9eG2H5acaa3cF9lRkI+K
         tTgTjTlcGXoLZh7qOTTrctjXlDEfzvIXqTLo1378YfoFFOPvwAMScc2M0vt87MsCX2WI
         1SSILV2RO4h814GWbImR8oWjlU6Y7AfNhW5MRs2Yg0bKv6DroS0os1pjz6SFmOwSQLYv
         uEdw==
X-Gm-Message-State: AOAM533cjFvEj/RZjr0Xw6fuiyfz8d7jyDqO7BpPiC/wEj2uqQzAiGvQ
        B8gu8eD5SvnPEWOgyPz6teTC2w==
X-Google-Smtp-Source: ABdhPJzdwWCxEjIeT5KJlR/Ba2GZ8dPe4vxd5ULvLy5WwNe9MrQCFdDTOTcEXmSEqqi1EyMCLYF1kA==
X-Received: by 2002:a05:6402:158:: with SMTP id s24mr25490055edu.144.1642497513890;
        Tue, 18 Jan 2022 01:18:33 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.239])
        by smtp.gmail.com with ESMTPSA id w22sm3411723eji.87.2022.01.18.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 01:18:33 -0800 (PST)
Date:   Tue, 18 Jan 2022 17:18:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Marco Elver <elver@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf test: Test 73 Sig_trap fails on s390
Message-ID: <20220118091827.GA98966@leoy-ThinkPad-X240s>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 03:39:10PM +0000, John Garry wrote:
> On 16/12/2021 15:48, Marco Elver wrote:
> 
> +
> 
> > On Thu, 16 Dec 2021 at 16:15, Thomas Richter<tmricht@linux.ibm.com>  wrote:
> > > In Linux next kernel
> > > Commit 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
> > > introduced the new test which uses breakpoint events.
> > > These events are not supported on s390 and PowerPC and always fail:
> > > 
> > >   # perf test -F 73
> > >   73: Sigtrap                                                         : FAILED!
> > >   #
> > > 
> > > Fix it the same way as in the breakpoint tests in file
> > > tests/bp_account.c where these type of tests are skipped on
> > > s390 and PowerPC platforms.
> > > 
> > > With this patch skip this test on both platforms.
> > > 
> > > Output after:
> > >   # ./perf test -F 73
> > >   73: Sigtrap
> > > 
> > > Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
> > > 
> > > Cc: Marco Elver<elver@google.com>
> > > Signed-off-by: Thomas Richter<tmricht@linux.ibm.com>
> > Acked-by: Marco Elver<elver@google.com>
> > 
> > Thanks, and sorry for missing this case!
> > 
> 
> I am finding that this test hangs on my arm64 machine:
> 
> john@debian:~/kernel-dev2/tools/perf$ sudo ./perf test -vvv 73
>  73: Sigtrap:
> --- start ---
> test child forked, pid 45193

Both Arm and Arm64 platforms cannot support signal handler with
breakpoint, please see the details in [1].  So I think we need
something like below:

static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
{
        ...

        if (!BP_SIGNAL_IS_SUPPORTED) {
                pr_debug("Test not supported on this architecture");
                return TEST_SKIP;
        }

        ...
}

Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse it at
here.

[1] https://lore.kernel.org/lkml/157169993406.29376.12473771029179755767.tip-bot2@tip-bot2/

> And fails on my x86 broadwell machine:
> 
> john@localhost:~/kernel-dev2/tools/perf> sudo ./perf test -v 73
> 73: Sigtrap                                                         :
> --- start ---
> test child forked, pid 22255
> FAILED sys_perf_event_open(): Argument list too long
> test child finished with -1
> ---- end ----
> Sigtrap: FAILED!
> john@localhost:~/kernel-dev2/tools/perf>

It is a bit suprise for the failure on x86, as I remembered x86 platform
can support signal handler with hw breakpoint.  And from the error
"Argument list too long", it should be a different issue from other
archs.

Thanks,
Leo
