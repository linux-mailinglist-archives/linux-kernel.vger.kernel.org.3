Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB871515ABF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiD3GP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiD3GPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:15:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F4852D4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:12:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k14so8040815pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hq6TEPU4jhshR+PB+EisgeeHk2b5bFNKkTEflIlyJDs=;
        b=mh1IbT4OCl3SdGY0Ln5xYG7mjCYqg2hM+n05W3AOqjWUHqTls6Mfzj6hVvjqPyi7NU
         HqqbZJixHZGeDFZ48NZclNKb0fkso+tZq5/VUo3crZs6eOPCj7eChjerc/jfCal4uIWh
         KmnNnChMV1mgiEShx8g9GSiYsMq9EbtZknMW9/VxDkK+s8dkFmact1rhPhsqq3SlWSIW
         sWqewlBLWInHE94q0/v+Hw9TH+Zl7TTWVsEcBSy7kKIYzo0w6LHPf4H1mIwimzUd7P2D
         5X5lQD2sTKbL4/NUq5t3n9aBj/0B4FxcEtRvF8RL6AJXq/qkGOQu7+/h7fxpor2j/QPD
         evaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hq6TEPU4jhshR+PB+EisgeeHk2b5bFNKkTEflIlyJDs=;
        b=QBJS9yqwYPhxZt3Ht0fOak2r+ouwU+cPY5fnaNYdFRtrC46Ct33GxZkIjcjKVwMNqu
         VnzH996FObqCTPi+UrbLamp9zLcQX52+ixus6xScC/7Gqem5tTdlbihc6GteA2sv/LqF
         Gbou+oLb99sNwSqAV7LIpYPp/YLNbzIV6QD8LHtwjJCPc8cCqncL2eoJMTA3CDZSvbvj
         UGzX1UhhSHo76qoXQhTbIK+nYDSfaAb2ImYhqChdl5q0MmXJwgh/RUfF+NAA2N5DnXIv
         +3g8GhUsxXoINPAy2FlosNIqzSI1R7DEUWrgunVpggQwxIsSsxJwZMus2bagwX5JBFp3
         Q26Q==
X-Gm-Message-State: AOAM533D3+ET7OYvKONr/I3WGDE903xl0L6ssoBXwltCb1vDfyDZumnJ
        c3AFT+fRtW2b9e2MW4GgsamdTQ==
X-Google-Smtp-Source: ABdhPJx2PKiEgSvIKKt+CFwwR5+HO+xqLKeXqJ3vxbNu6QtZlkgFQPQ/sC5ZNQHX9Dfnb0mY7ZY6iA==
X-Received: by 2002:a63:354f:0:b0:398:4ead:866e with SMTP id c76-20020a63354f000000b003984ead866emr2187341pga.322.1651299153008;
        Fri, 29 Apr 2022 23:12:33 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6e:ab40:9d7e:4700:2d24:29fc? ([2409:8a28:e6e:ab40:9d7e:4700:2d24:29fc])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79205000000b0050dc7628175sm692631pfo.79.2022.04.29.23.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 23:12:32 -0700 (PDT)
Message-ID: <6a86e452-d24d-b371-f343-7e77faeed7ca@bytedance.com>
Date:   Sat, 30 Apr 2022 14:12:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [External] [mark:arm64/ftrace/per-callsite-ops 1/6]
 kernel/trace/fgraph.c:37:12: warning: no previous prototype for
 'ftrace_enable_ftrace_graph_caller'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <202204300758.ces9aD6G-lkp@intel.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <202204300758.ces9aD6G-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/30 07:56, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/per-callsite-ops
> head:   2aaba224d039a36f7eca5ad68c77686d3546e4fa
> commit: 718b0fd1ccf6f04340cb3ad48b667ca05bb7a31c [1/6] ftrace: cleanup ftrace_graph_caller enable and disable
> config: sh-buildonly-randconfig-r002-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300758.ces9aD6G-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=718b0fd1ccf6f04340cb3ad48b667ca05bb7a31c
>         git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
>         git fetch --no-tags mark arm64/ftrace/per-callsite-ops
>         git checkout 718b0fd1ccf6f04340cb3ad48b667ca05bb7a31c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash kernel/trace/
> 

Thanks for the report.

BTW, there are so many "-Wmissing-prototypes" warnings if build kernel with "W=1"...

I can't reproduce this warning on x86_64 because the declarations in <linux/ftrace.h>

#ifdef CONFIG_DYNAMIC_FTRACE
...
#ifdef CONFIG_FUNCTION_GRAPH_TRACER
extern void ftrace_graph_caller(void);
extern int ftrace_enable_ftrace_graph_caller(void);
extern int ftrace_disable_ftrace_graph_caller(void);
#else
static inline int ftrace_enable_ftrace_graph_caller(void) { return 0; }
static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
#endif
...
#endif

Since x86_64 select HAVE_FUNCTION_GRAPH_TRACER only when DYNAMIC_FTRACE,
so these declarations can be seen by fgraph.c

But on ARCH=sh, HAVE_FUNCTION_GRAPH_TRACER can be selected when !DYNAMIC_FTRACE,
so these declarations can't be seen by fgraph.c. But in this case, these
functions are not used anywhere. So there are no real problems exist.

Maybe it's better to put ftrace_[enable,disable]_ftrace_graph_caller definitions
in "#ifdef CONFIG_DYNAMIC_FTRACE" in fgraph.c, to suppress this warning.

Thanks.

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> kernel/trace/fgraph.c:37:12: warning: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Wmissing-prototypes]
>       37 | int __weak ftrace_enable_ftrace_graph_caller(void)
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> kernel/trace/fgraph.c:46:12: warning: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Wmissing-prototypes]
>       46 | int __weak ftrace_disable_ftrace_graph_caller(void)
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/fgraph.c:241:15: warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
>      241 | unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/fgraph.c:356:6: warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]
>      356 | void ftrace_graph_sleep_time_control(bool enable)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/ftrace_enable_ftrace_graph_caller +37 kernel/trace/fgraph.c
> 
>     32	
>     33	/*
>     34	 * archs can override this function if they must do something
>     35	 * to enable hook for graph tracer.
>     36	 */
>   > 37	int __weak ftrace_enable_ftrace_graph_caller(void)
>     38	{
>     39		return 0;
>     40	}
>     41	
>     42	/*
>     43	 * archs can override this function if they must do something
>     44	 * to disable hook for graph tracer.
>     45	 */
>   > 46	int __weak ftrace_disable_ftrace_graph_caller(void)
>     47	{
>     48		return 0;
>     49	}
>     50	
> 
