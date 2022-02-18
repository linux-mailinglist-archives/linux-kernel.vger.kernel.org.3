Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB604BC12B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiBRU13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:27:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBRU12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:27:28 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD115C192
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:27:10 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id v3so258897ilc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hdfNSNhRw+L/FJ84RFkhuGnrjkbL34umetIyVHK2Fz0=;
        b=awM/WyJj8Im8lw/ob2O7iZVxy9Ud0hfj8S6TU6y4/TeHmvzk2W++LzzGDPyCrHoYNl
         /xeOhCZsHV8Gom2JN6+OvCDdvNRaigp35QWGQTvl1ownxY4K8QWqOz2ItmM/Xt/50H8X
         KjMA9BCyB2EGB7R/DHgq7W0omcrEL3y8uD9Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdfNSNhRw+L/FJ84RFkhuGnrjkbL34umetIyVHK2Fz0=;
        b=sQVn6qfTROeOwrcK+dYUkP4uUdd4S7Jx6uBONLcQJC/Y8p0HwcnvPgVr6l+YHC3M/f
         c467vnuL3o7G+dKebHIGEYI36X4cxpwdcDv+vBGIbbldB4D/t0A4stwDkyh1sP9d062t
         Fvk3gK6l09UNWx73xrEWouw4TJKqaADExiRtc7+O80gW0KYQy8F+3eYMmvLWhaArwwuZ
         NLa396dckQ/OIbsXZEj5kH7+0j9lkmtkS0rsUiFMFDR85G+OCfT5Z7OrlZwANjAESr7v
         OYUVoIT+Eb5pSmB0oXodByY2bJltzO5ciVHjF1T7WilVjhtmu1mKjHcnTfBTcuuBGX4o
         NcTw==
X-Gm-Message-State: AOAM533ughV6eq0UfeGyx3g1SQhrxf9vUHHERfAAjQypumdjcJFtzdVn
        nSST2o6rRVm77BxtzG4pnQz7WfC79JFgKQ==
X-Google-Smtp-Source: ABdhPJyQF+xAafBhMOif6g4tMge18w7Z1QH9nW9puw+/H2uol05DPRdrkjPqf1tRSuYIPVBxxtpw8Q==
X-Received: by 2002:a05:6e02:1a2c:b0:2c1:d84b:1987 with SMTP id g12-20020a056e021a2c00b002c1d84b1987mr1962451ile.45.1645216029917;
        Fri, 18 Feb 2022 12:27:09 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w4sm3977445ilo.53.2022.02.18.12.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:27:09 -0800 (PST)
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-3-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1bbc4049-2c08-39be-d82b-9d98ee663e72@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 13:27:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216022641.2998318-3-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> In kselftest framework, all tests can be build/run at a time,
> and a sub test also can be build/run individually. As follows:
> $ make -C tools/testing/selftests run_tests
> $ make -C tools/testing/selftests TARGETS=ptrace run_tests
> 
> However, resctrl_tests cannot be run using kselftest framework,
> users have to change directory to tools/testing/selftests/resctrl/,
> run "make" to build executable file "resctrl_tests",
> and run "sudo ./resctrl_tests" to execute the test.
> 
> To build/run resctrl_tests using kselftest framework.
> Modify tools/testing/selftests/Makefile
> and tools/testing/selftests/resctrl/Makefile.
> 
> Even after this change, users can still build/run resctrl_tests
> without using framework as before.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Some important feedbacks from v1&v2 are addressed as follows:
> 
> - The changelog mentions that changes were made to the resctrl
>    selftest Makefile but it does not describe what the change accomplish
>    or why they are needed.
>    => By changing the Makefile, resctrl_tests can use kselftest
>       framework like other sub tests. I described this in changelog.
> 
> - The changelog did not describe how a user may use the kselftest
>    framework to run the resctrl tests nor the requested information
>    on how existing workflows are impacted.
>    => I described how to build/run resctrl_tests with kselftest framework,
>       and described the existing workflows are not impacted that users can
>       build/run resctrl_tests without using kselftest framework as before.
> 
> - tools/testing/selftests/resctrl/README should be updated.
>    => I separate the update of README to a new patch.[patch v3 3/5]
> 
> - Why is the meaning of "EXTRA_SOURCES" (i.e. what is "extra"?) and
>    why is "SRCS" no longer sufficient?
>    => I referred to other Makefiles, and found "SRCS" is better
>       than "EXTRA_SOURCES". So, I updated it to use "SRCS".
> 
>   tools/testing/selftests/Makefile         |  1 +
>   tools/testing/selftests/resctrl/Makefile | 20 ++++++--------------
>   2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c852eb40c4f7..7df397c6893c 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -51,6 +51,7 @@ TARGETS += proc
>   TARGETS += pstore
>   TARGETS += ptrace
>   TARGETS += openat2
> +TARGETS += resctrl
>   TARGETS += rlimits
>   TARGETS += rseq
>   TARGETS += rtc
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 6bcee2ec91a9..de26638540ba 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,17 +1,9 @@
> -CC = $(CROSS_COMPILE)gcc
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
> -SRCS=$(wildcard *.c)
> -OBJS=$(SRCS:.c=.o)
> +CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>   
> -all: resctrl_tests
> +TEST_GEN_PROGS := resctrl_tests
> +SRCS := $(wildcard *.c)
>   
> -$(OBJS): $(SRCS)
> -	$(CC) $(CFLAGS) -c $(SRCS)
> +all: $(TEST_GEN_PROGS)
>   
> -resctrl_tests: $(OBJS)
> -	$(CC) $(CFLAGS) -o $@ $^
> -
> -.PHONY: clean
> -
> -clean:
> -	$(RM) $(OBJS) resctrl_tests
> +$(TEST_GEN_PROGS): $(SRCS)

This patch breaks the test build - the below use-cases fail

make kselftest-all TARGETS=resctrl
make -C  tools/testing/selftests/ TARGETS=resctrl

Also a simple make in tools/testing/selftests/resctr

thanks,
-- Shuah
