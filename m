Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8265A51CFBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388822AbiEFDj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388896AbiEFDjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:39:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43766CA9
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:34:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x52so5225192pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FFiNn28hsyBk4daR5wg/T0UPEe8cWAsBIukJqeiFwYM=;
        b=m5y0OkwjFPsmA8sRuOa5BnRtcYcscKEYoFsh//Iukq4jpQ9SCJvtHEeUE1b3D9ZvkJ
         uVXZvy2tLyorydqekBqhH0qkFA7VfuPsgSmVPj2igdy79pSl6f9kKoJ1ip7NjI1lsgv+
         ieDvB7AKxMlGQMClYIffwkDFKl3fWRZMT5+sBQY40gRa8YM1rjpIgF1dLmexiGvAlzHK
         h8mAf8+nZvWdaLKhM/CXEGUSTM8pSRIdjoIdZ2XUsLN4+teYPvynujQAQo8/eTizxnLF
         awC1cgzp7bwhkCmsCgj8joXbnqf+QA1om2sWIkmzX7wMfd5XNnnjQGN5HuhFGK8JWzMa
         yRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FFiNn28hsyBk4daR5wg/T0UPEe8cWAsBIukJqeiFwYM=;
        b=wvcFjrQ8ldj13i0Z/exdd2cX4GOnvlTGeTKz561TDpkABq+xqo+YQgXQnnVs54/qHR
         Zct5RbpYOa2K1x9kLKRlxFU/Ikx2w3nUwTRtUpQUDO4zjAif6sD4C13qcbl1x6b/XvFv
         EPv6RSMYMixUN2/yXgiZk4YLkdhXcd4GTFvi/DTKzIgxSPXLKwj40OtvH+og4/hEGFjR
         KZXlyEDB2bet/721Usf2i7XM69OLEVVE8J5KTT5hN9KYJLgcUPPrcNYX1JDFADl8ipOe
         PvtuGhqIxud4HktKECeW6LbQUNv9Vv22ZPqpHN+rrzkB1f0evSMNSrK3b8AEFeUVWTP1
         B5tw==
X-Gm-Message-State: AOAM531TIdHWzUnXqN8ijfrxpHy29BE2V7TsdK/8oX9winXlC2ljTtq5
        KWXgqYe7qNP/Cl0KXaZOoFjX+A==
X-Google-Smtp-Source: ABdhPJyQHmddut2poCsAvWVXA9udLP+Hzn3znsRmkEvS9rMfvpx/h+horXPxik2iLvgilZBQ3/1wCQ==
X-Received: by 2002:a05:6a00:a0e:b0:4fd:fa6e:95fc with SMTP id p14-20020a056a000a0e00b004fdfa6e95fcmr1573732pfh.17.1651808086746;
        Thu, 05 May 2022 20:34:46 -0700 (PDT)
Received: from [10.254.202.109] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79627000000b0050dc76281f8sm2192758pfg.210.2022.05.05.20.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 20:34:46 -0700 (PDT)
Message-ID: <4db027a7-1475-b86b-7852-9433efc01db4@bytedance.com>
Date:   Fri, 6 May 2022 11:33:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] ftrace/fgraph: fix increased missing-prototypes warnings
Content-Language: en-US
To:     rostedt@goodmis.org, mark.rutland@arm.com, catalin.marinas@arm.com
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        lkp@intel.com
References: <20220506032737.23375-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220506032737.23375-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/6 11:27, Chengming Zhou wrote:
> After commit e999995c84c3 ("ftrace: cleanup ftrace_graph_caller enable
> and disable") merged into the linux-next tree, the kernel test robot
> (lkp@intel.com) has send out report that there are increased missing-prototypes
> warnings caused by that commit.
> 
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 \
> 	O=build_dir ARCH=sh SHELL=/bin/bash kernel/trace/
> warning: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]
> 
> BTW there are so many missing-prototypes warnings if build kernel with "W=1".
> 
> The increased warnings for 'ftrace_[enable,disable]_ftrace_graph_caller'
> is caused by CONFIG_FUNCTION_GRAPH_TRACER && !CONFIG_DYNAMIC_FTRACE,
> so the declarations in <linux/ftrace.h> can't be seen in fgraph.c.
> 
> And this warning can't reproduce on x86_64 since x86_64 select
> HAVE_FUNCTION_GRAPH_TRACER only when DYNAMIC_FTRACE, so fgraph.c will
> always see the declarations in <linux/ftrace.h>.
> 
> This patch fix the increased warnings by put the definitions in
> CONFIG_DYNAMIC_FTRACE although there are no real problems exist.
> 

Sorry, forget to add:
Reported-by: kernel test robot <lkp@intel.com>

> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/trace/fgraph.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 289311680c29..2cd374294be7 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -30,6 +30,7 @@ int ftrace_graph_active;
>  /* Both enabled by default (can be cleared by function_graph tracer flags */
>  static bool fgraph_sleep_time = true;
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE
>  /*
>   * archs can override this function if they must do something
>   * to enable hook for graph tracer.
> @@ -47,6 +48,7 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
>  {
>  	return 0;
>  }
> +#endif
>  
>  /**
>   * ftrace_graph_stop - set to permanently disable function graph tracing
