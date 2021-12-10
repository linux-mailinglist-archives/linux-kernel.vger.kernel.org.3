Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966C44701A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbhLJNd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhLJNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:33:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A9BC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 05:30:19 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so14960696wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dTdbuA9hIdKn4BfZbCPlTiSyHXJY337c3HR+lMVDle0=;
        b=YidYi3Fu8huIr5y4/jlAfPC5nI9PIDEuaSycwThZ8P4eSOoYrOSHDTNGlV8Z58MSq1
         nLViggv2CJ05+3TJ/iM8LaCSjxFV0xL0r9K1DPQUoZPryr9Daoa3+FYnJHcKrWuGoIf8
         Q4g7xaSyduPS4GhcYKKPAC60Eu5VSwzkcf8NtUc4GkZkdwWnXtTOnN4LHMJxxpmOvI2V
         jwUoLT+Y68ymEV/V9+33LhurOGp8YomH3pQb7qdJknEq6q+f/KzuLeMw9HuAvkMhTnl7
         /y5yZXF6PzIH2ayUQGHLWyJOUOTNtFQJEP5Dno2RQjsChi4DVoLDcXQ7BWszUzeSemnH
         qYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTdbuA9hIdKn4BfZbCPlTiSyHXJY337c3HR+lMVDle0=;
        b=SQqvoCXkM0Fqrs573cYsBV4/Gti/NVC/yQDH56cOGu/jvV7MA4SWWf/oaWllSxEuvI
         fSLz6L28szVJc28p9STafAgjCjCtArDC3nH/2pPcjMQ2fhelBN08drbO9Nvm08oaiTai
         CA4p6XTcn9zhXLtStndptIjSfNkLVVp2AW7zcJotCULKNJdkjrIVDcbfPlv9Ha4abkhB
         LNVvFv8KW8NIEADvL8bRX5eh8EKk2+9Xzbs+D6NExBxhxJoI1u/B1Fey1sRm/fEBJ5/q
         sLiAHDDGtpwMpJuK0j2xp1TzewWRxp2W+6vQcW2icJhM5Iyb48MzTpkHhQcxZwMmy17q
         lAew==
X-Gm-Message-State: AOAM532/W8m9IIt89VjwOa5DTQZ/cRqm79ZqG6CMy7++EDsRu5cU0iot
        VChoi0KVYePNTvilzCOhQRRZtw==
X-Google-Smtp-Source: ABdhPJwCcS9p25EiCqzxhRSk2Pa1gd4yTmwpBUlVZupz6pABIABSyQyupvZFwpKEK3nVmGN2yBv8pg==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr13746398wrw.628.1639143017223;
        Fri, 10 Dec 2021 05:30:17 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:13f9:8295:8923:1942])
        by smtp.gmail.com with ESMTPSA id m7sm2852886wml.38.2021.12.10.05.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 05:30:16 -0800 (PST)
Date:   Fri, 10 Dec 2021 14:30:09 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v4 7/7] selftests: test uaccess logging
Message-ID: <YbNWYSsZ7bpV13jp@elver.google.com>
References: <20211209221545.2333249-1-pcc@google.com>
 <20211209221545.2333249-8-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209221545.2333249-8-pcc@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:15PM -0800, Peter Collingbourne wrote:
> Add a kselftest for the uaccess logging feature.
> 
> Link: https://linux-review.googlesource.com/id/I39e1707fb8aef53747c42bd55b46ecaa67205199
> Signed-off-by: Peter Collingbourne <pcc@google.com>

It would be good to also test:

	- Logging of reads.

	- Exhausting the uaccess buffer, ideally somehow checking that
	  the kernel hasn't written out-of-bounds, e.g. by using some
	  canary.

	- Passing an invalid address to some syscall, for which the
	  access should not be logged?

	- Passing an invalid address to the
	  PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR prctl().

	- Passing a valid address to the prctl(), but that address
	  points to an invalid address.

> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../testing/selftests/uaccess_buffer/Makefile |   4 +
>  .../uaccess_buffer/uaccess_buffer_test.c      | 126 ++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 tools/testing/selftests/uaccess_buffer/Makefile
>  create mode 100644 tools/testing/selftests/uaccess_buffer/uaccess_buffer_test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c852eb40c4f7..291b62430557 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -71,6 +71,7 @@ TARGETS += timers
>  endif
>  TARGETS += tmpfs
>  TARGETS += tpm2
> +TARGETS += uaccess_buffer
>  TARGETS += user
>  TARGETS += vDSO
>  TARGETS += vm
> diff --git a/tools/testing/selftests/uaccess_buffer/Makefile b/tools/testing/selftests/uaccess_buffer/Makefile
> new file mode 100644
> index 000000000000..e6e5fb43ce29
> --- /dev/null
> +++ b/tools/testing/selftests/uaccess_buffer/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +TEST_GEN_PROGS := uaccess_buffer_test
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/uaccess_buffer/uaccess_buffer_test.c b/tools/testing/selftests/uaccess_buffer/uaccess_buffer_test.c
> new file mode 100644
> index 000000000000..051062e4fbf9
> --- /dev/null
> +++ b/tools/testing/selftests/uaccess_buffer/uaccess_buffer_test.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "../kselftest_harness.h"
> +
> +#include <linux/uaccess-buffer.h>
> +#include <sys/prctl.h>
> +#include <sys/utsname.h>
> +
> +FIXTURE(uaccess_buffer)
> +{
> +	uint64_t addr;
> +};
> +
> +FIXTURE_SETUP(uaccess_buffer)
> +{
> +	ASSERT_EQ(0, prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, &self->addr, 0,
> +			   0, 0));
> +}
> +
> +FIXTURE_TEARDOWN(uaccess_buffer)
> +{
> +	ASSERT_EQ(0, prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, 0, 0, 0, 0));
> +}
> +
> +TEST_F(uaccess_buffer, uname)
> +{
> +	struct uaccess_descriptor desc;
> +	struct uaccess_buffer_entry entries[64];
> +	struct utsname un;
> +
> +	desc.addr = (uint64_t)(unsigned long)entries;
> +	desc.size = 64;
> +	self->addr = (uint64_t)(unsigned long)&desc;
> +	ASSERT_EQ(0, uname(&un));
> +	ASSERT_EQ(0, self->addr);
> +
> +	if (desc.size == 63) {
> +		ASSERT_EQ((uint64_t)(unsigned long)(entries + 1), desc.addr);
> +
> +		ASSERT_EQ((uint64_t)(unsigned long)&un, entries[0].addr);
> +		ASSERT_EQ(sizeof(struct utsname), entries[0].size);
> +		ASSERT_EQ(UACCESS_BUFFER_FLAG_WRITE, entries[0].flags);
> +	} else {
> +		/* See override_architecture in kernel/sys.c */
> +		ASSERT_EQ(62, desc.size);
> +		ASSERT_EQ((uint64_t)(unsigned long)(entries + 2), desc.addr);
> +
> +		ASSERT_EQ((uint64_t)(unsigned long)&un, entries[0].addr);
> +		ASSERT_EQ(sizeof(struct utsname), entries[0].size);
> +		ASSERT_EQ(UACCESS_BUFFER_FLAG_WRITE, entries[0].flags);
> +
> +		ASSERT_EQ((uint64_t)(unsigned long)&un.machine,
> +			  entries[1].addr);
> +		ASSERT_EQ(UACCESS_BUFFER_FLAG_WRITE, entries[1].flags);
> +	}
> +}
> +
> +static bool handled;
> +
> +static void usr1_handler(int signo)
> +{
> +	handled = true;
> +}
> +
> +TEST_F(uaccess_buffer, blocked_signals)
> +{
> +	struct uaccess_descriptor desc;
> +	struct shared_buf {
> +		bool ready;
> +		bool killed;
> +	} volatile *shared = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
> +				  MAP_ANON | MAP_SHARED, -1, 0);

I know it's a synonym, but to be consistent with other code, MAP_ANONYMOUS?

> +	struct sigaction act = {}, oldact;
> +	int pid;
> +
> +	handled = false;
> +	act.sa_handler = usr1_handler;
> +	sigaction(SIGUSR1, &act, &oldact);
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		/*
> +		 * Busy loop to synchronize instead of issuing syscalls because
> +		 * we need to test the behavior in the case where no syscall is
> +		 * issued by the parent process.
> +		 */
> +		while (!shared->ready)
> +			;
> +		kill(getppid(), SIGUSR1);
> +		shared->killed = true;
> +		_exit(0);
> +	} else {
> +		int i;
> +
> +		desc.addr = 0;
> +		desc.size = 0;
> +		self->addr = (uint64_t)(unsigned long)&desc;
> +
> +		shared->ready = true;
> +		while (!shared->killed)
> +			;
> +
> +		/*
> +		 * The kernel should have IPI'd us by now, but let's wait a bit
> +		 * longer just in case.

Is IPI = signalled? Because in the kernel, IPI = inter-processor
interrupt.

> +		 */
> +		for (i = 0; i != 1000000; ++i)
> +			;

This is probably optimized out.  usleep() should work, or add compiler
barrier if usleep doesn't work.

> +
> +		ASSERT_FALSE(handled);
> +
> +		/*
> +		 * Returning from the waitpid syscall should trigger the signal
> +		 * handler. The signal itself may also interrupt waitpid, so
> +		 * make sure to handle EINTR.
> +		 */
> +		while (waitpid(pid, NULL, 0) == -1)
> +			ASSERT_EQ(EINTR, errno);
> +		ASSERT_TRUE(handled);
> +	}
> +
> +	munmap((void *)shared, getpagesize());
> +	sigaction(SIGUSR1, &oldact, NULL);
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
