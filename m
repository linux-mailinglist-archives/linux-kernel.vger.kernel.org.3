Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97151509A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378973AbiD2QVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378565AbiD2QVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:21:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC77BD4C53
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:17:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v12so11398709wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IsSb+U9lj5TDQys64OHrXJ7Bp8pF8so0qUpGgwWiM5o=;
        b=ibQ7SYZ9/CELmgjYNU6/xI5FE8wWqPApzl0HkrDDwV9h69BXWk7YGajUXWVHaguGeS
         sJeD/SK8AEEamPOZ0hwlccfu11s4HaKin+OB2e+NrHtaLKcq+Qn5xdyKLuVkstaHI6ic
         j3DdgJynYqoLVPudmX+q7YorqR19CrSKHBiUv2pU5l31GB768gihdv6dqtnjCCOo9oKE
         UJ8n9KexRWRIV5jfiuDA+Fi8orDSzCdTP2/U0a736uTypS07B49YfpShiXbKXxQ5aJt9
         R6JutpE99/lK3wXL2j6pUOQykz77c1y6131q9rWGfVp0UOQCiyHgDjCkaczmj6wL1ME/
         fVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IsSb+U9lj5TDQys64OHrXJ7Bp8pF8so0qUpGgwWiM5o=;
        b=5PdshvxDbRPSHvhXmh0dHJYdYy4haYjcZq736K+M0MFaV8LS0yh6kfvI5z2mLDCQrB
         CzBZ/LleTM0h28gRfrVpeQTL+cqZJeo8GYArlmEJfyPZINnNNq7nnO4+tDlwjb8sQmD5
         hm42r94Hg0ScC8TnaUKA7YqQtMy7R/4Tl0JyiKgMXELN4PB7RWDY/WPM44xewWX/XIK7
         2eDwmURFnSFJQRWDPdCuyMWXtSvFvGcxcNnO28Rm4qvbzF+1chM5KSu2+EyXtVHM8dgX
         le8zdCzRkRZ05KUjy8SUKtkgyAIuZWucb20EqkSdK+NGJcvLcJulZWUQFBn/7TgVYitc
         QXGw==
X-Gm-Message-State: AOAM530KDNSbNLR23xrfVhh3AcTzqImlG8zCDn1qhNq/h34drhsFUgOB
        BWfTrWW9mqJeBnjP+Tryvu+9dQ==
X-Google-Smtp-Source: ABdhPJzUMis/+FAvdfF5VoTvms8Jdw1M+f6DpRNLfCX2cOFtfv6u3ERkDJfZ/5wszUndsK5XUFFc4A==
X-Received: by 2002:adf:f6d1:0:b0:20a:cb60:3fd9 with SMTP id y17-20020adff6d1000000b0020acb603fd9mr29356725wrp.440.1651249065058;
        Fri, 29 Apr 2022 09:17:45 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:3ed8:cdc:7970:57b8])
        by smtp.gmail.com with ESMTPSA id n2-20020a1ca402000000b003942429cd1esm1212458wme.10.2022.04.29.09.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:17:44 -0700 (PDT)
Date:   Fri, 29 Apr 2022 18:17:37 +0200
From:   Marco Elver <elver@google.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [next] i386: kunit: ASSERTION FAILED at
 mm/kfence/kfence_test.c:547
Message-ID: <YmwPocGA9vRSvAEN@elver.google.com>
References: <CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:50PM +0530, Naresh Kamboju wrote:
[...]
> snippet of Kconfigs from the build:
>     CONFIG_CC_HAS_KASAN_GENERIC=y
>     CONFIG_KFENCE=y
>     CONFIG_KFENCE_KUNIT_TEST=y
>     CONFIG_KUNIT=y
>     CONFIG_KUNIT_DEBUGFS=y
>     CONFIG_KUNIT_TEST=y
>     CONFIG_KUNIT_EXAMPLE_TEST=y
>     CONFIG_KUNIT_ALL_TESTS=y
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Regressions found on qemu_i386;:
[...]
> [   33.495833] not ok 1 - kfence

Thank you for reporting. I did a bisection and landed here:

 | git bisect start
 | # good: [38d741cb70b30741c0e802cbed7bd9cf4fd15fa4] Merge tag 'drm-fixes-2022-04-29' of git://anongit.freedesktop.org/drm/drm
 | git bisect good 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
 | # bad: [5469f0c06732a077c70a759a81f2a1f00b277694] Add linux-next specific files for 20220429
 | git bisect bad 5469f0c06732a077c70a759a81f2a1f00b277694
 | # bad: [8aceb3338349dbda8fa0caf194b775335106343c] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
 | git bisect bad 8aceb3338349dbda8fa0caf194b775335106343c
 | # bad: [ee45eb58be0352e34825f74c3f0187ffd9802cf8] Merge branch 'docs-next' of git://git.lwn.net/linux.git
 | git bisect bad ee45eb58be0352e34825f74c3f0187ffd9802cf8
 | # good: [79ff65e50b2275296c8a12e823e0b50d573b7716] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
 | git bisect good 79ff65e50b2275296c8a12e823e0b50d573b7716
 | # good: [040c491d3a03e71a4c8c7aa0d24921f9a0cb8057] Merge branch 'master' of git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 | git bisect good 040c491d3a03e71a4c8c7aa0d24921f9a0cb8057
 | # good: [52a97e777288db02be4211911c884c3a4810bbbd] Merge branch 'master' of https://github.com/Paragon-Software-Group/linux-ntfs3.git
 | git bisect good 52a97e777288db02be4211911c884c3a4810bbbd
 | # bad: [565f64656a35d673d8a9a61e570024a5fa3d369b] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 | git bisect bad 565f64656a35d673d8a9a61e570024a5fa3d369b
 | # good: [513df2cd1c0bbf378fcf9d7f9a288e736ca74286] Merge branch 'locks-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
 | git bisect good 513df2cd1c0bbf378fcf9d7f9a288e736ca74286
 | # bad: [bfc1f2749c23a4748dc4993df37cf75fa2602aba] Merge branch 'rework/kthreads' into for-next
 | git bisect bad bfc1f2749c23a4748dc4993df37cf75fa2602aba
 | # good: [c5f75d490fc2dd706898c005a05a933b39e880d3] Merge branch 'for-5.18' into for-next
 | git bisect good c5f75d490fc2dd706898c005a05a933b39e880d3
 | # good: [a699449bb13b70b8bd10dc03ad7327ea3993221e] printk: refactor and rework printing logic
 | git bisect good a699449bb13b70b8bd10dc03ad7327ea3993221e
 | # bad: [8e274732115f63c1d09136284431b3555bd5cc56] printk: extend console_lock for per-console locking
 | git bisect bad 8e274732115f63c1d09136284431b3555bd5cc56
 | # good: [3b604ca81202eea2a917eb6491e90f610fba0ec7] printk: add pr_flush()
 | git bisect good 3b604ca81202eea2a917eb6491e90f610fba0ec7
 | # bad: [09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7] printk: add kthread console printers
 | git bisect bad 09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7
 | # good: [2bb2b7b57f81255c13f4395ea911d6bdc70c9fe2] printk: add functions to prefer direct printing
 | git bisect good 2bb2b7b57f81255c13f4395ea911d6bdc70c9fe2
 | # first bad commit: [09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7] printk: add kthread console printers

And looking at your log [1], it shows that KFENCE is working just fine,
but the logic that is supposed to intercept the kernel log (via
tracepoint) to check that reports are being generated correctly seems to
be broken.

And this is not only i386-specific, it's also broken on a x86-64 build.

At first I thought maybe with the printk changes we'd now have to call
pr_flush(), but that doesn't work, so I'm missing something still:

 | --- a/mm/kfence/kfence_test.c
 | +++ b/mm/kfence/kfence_test.c
 | @@ -73,11 +73,18 @@ static void probe_console(void *ignore, const char *buf, size_t len)
 |  }
 |  
 |  /* Check if a report related to the test exists. */
 | -static bool report_available(void)
 | +static bool __report_available(void)
 |  {
 |  	return READ_ONCE(observed.nlines) == ARRAY_SIZE(observed.lines);
 |  }
 |  
 | +/* Check if a report related to the test exists; may sleep. */
 | +static bool report_available(void)
 | +{
 | +	pr_flush(0, true);
 | +	return __report_available();
 | +}
 | +
 |  /* Information we expect in a report. */
 |  struct expect_report {
 |  	enum kfence_error_type type; /* The type or error. */
 | @@ -165,7 +172,7 @@ static bool report_matches(const struct expect_report *r)
 |  	cur += scnprintf(cur, end - cur, " 0x%p", (void *)addr);
 |  
 |  	spin_lock_irqsave(&observed.lock, flags);
 | -	if (!report_available())
 | +	if (!__report_available())
 |  		goto out; /* A new report is being captured. */

John, Petr, any hints what's going on?

Thanks,
-- Marco

> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 088fb7eff3496e0f61fdf68bda89b81a4d0a4434
>   git_describe: next-20220426
>   kernel-config: https://builds.tuxbuild.com/28KafYBlDWOxI3qyNmGDwb63GuX/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> [1] https://lkft.validation.linaro.org/scheduler/job/4950383#L770
> [2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220426/testrun/9235043/suite/kunit/test/test_use_after_free_read/log
