Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67DF4E4125
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiCVOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiCVORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:17:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3D66CA68
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:14:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bx5so15743631pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KmpoxwlpdTAmi630hXs8vMPAHLsHiDF3ysmYDpSnUTk=;
        b=JWxzsQssqkgSNvCTgcwwzwsdqz1p75+shTj5YzO8qnOEiIAYKrq9yRyt4y62hW5uwx
         1VLaJ3pKRVpsclR29L1T5rIj3E+BqAXwWWq+jF90OKXC3niaLCSNvSZh9YF5mKa34AWJ
         6Tp54RpBjaCtrh9eVbCVrM58OwU3GbGESyf04GnEOXw6xY6aZ2pVEWE4f6lb0yTxwsTr
         +rCLN9bNmozUETJ/gK3nAwXybZ4+RseB2J/IU71WP1aju3osHxK51DIloW+bqLQ5EUwl
         kwLx767RVMYLbN6fPCfv8iaxw9Rfe47gNr344YO3vInL4ZH9Wll7gAHR/rgswxH8fLIg
         P7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KmpoxwlpdTAmi630hXs8vMPAHLsHiDF3ysmYDpSnUTk=;
        b=M+TPY1MkUu/NbF6AbS67yEl2QMKqfjFHQqr+eoNV5uPMi8d/tdrEjpAq4b3FAQJgP6
         SlPPqDhLHCNUD2+/Mpe+iWL5YbN6nVymKLzU69PJTcKtsW+Ub+tLMjWgUtmWmNV7Awm4
         HQAYldUmHQ9WpEHp3ZnG6r8vjaz4boNdwzWlAEcfTDe5wZdFKyvncf97U4MtfjBYTR5K
         e97p4getczX3Rpj6a4DMEpbtR/Cl8cGfVA1voG49YM7M7nyLrEq8ZGhyuaq/QeUmmoxV
         Y5axV1R3Ul4fsZXaaKfkTrclCNDQ3OeZQGl+ryCG75EsHVT2u7tm+fzT/vOKllzWBZJ5
         wFQw==
X-Gm-Message-State: AOAM532L0LKNS+1Cc9cSZK/u0lELeu5Y/e2uLPIeT5GkO9c921qwuBA/
        6q2NWOzbcrejyivzQD8pGiN/Jw==
X-Google-Smtp-Source: ABdhPJy3vkob5aeMtKN+V8UhtCkWt2UnP72EwVNaLFPfcPOK35s1aHFtUwtyWCN6Veqy2oRF19cNNg==
X-Received: by 2002:a17:902:d508:b0:154:2f99:a531 with SMTP id b8-20020a170902d50800b001542f99a531mr16804442plg.133.1647958460998;
        Tue, 22 Mar 2022 07:14:20 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:4de5:990f:881e:dd0e? ([2409:8a28:e62:3990:4de5:990f:881e:dd0e])
        by smtp.gmail.com with ESMTPSA id g1-20020a056a000b8100b004faa79a72e8sm7149447pfj.156.2022.03.22.07.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 07:14:20 -0700 (PDT)
Message-ID: <7807fc23-c6c9-b6a9-62ef-e34e8beefdea@bytedance.com>
Date:   Tue, 22 Mar 2022 22:14:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v3 3/3] arm64/ftrace: Make function graph
 use ftrace directly
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mark.rutland@arm.com, mingo@redhat.com, tglx@linutronix.de,
        catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, broonie@kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com
References: <20220224093251.49971-1-zhouchengming@bytedance.com>
 <20220224093251.49971-3-zhouchengming@bytedance.com>
 <c8b7508b-ce2a-c7dc-92c4-ca5f17992844@bytedance.com>
 <20220322094100.73dc3ad0@gandalf.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220322094100.73dc3ad0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/22 9:41 下午, Steven Rostedt wrote:
> On Tue, 22 Mar 2022 20:48:00 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
> 
>> Hello,
>>
>> ping... have any comments?
> 
> Hi Chengming,
> 
> BTW, if you don't hear back for a week, it's OK to send a ping. You don't
> need to wait a month. Usually, it's just that the maintainers have other
> priorities and will try to look at it when they get a chance, but then
> forget to do so :-/

Hi Steve, ok, I got it ;-)

> 
> 
>>
>> Thanks.
>>
>> On 2022/2/24 5:32 下午, Chengming Zhou wrote:
>>> As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
>>> use ftrace directly"), we don't need special hook for graph tracer,
>>> but instead we use graph_ops:func function to install return_hooker.
>>>
>>> Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
>>> implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
>>> the same cleanup on arm64. And this cleanup only changes the
>>> FTRACE_WITH_REGS implementation, so the mcount-based implementation
>>> is unaffected.
>>>
>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>> ---
>>> Changes in v3:
>>>  - Add comments in ftrace_graph_func() as suggested by Steve.
>>>
>>> Changes in v2:
>>>  - Remove FTRACE_WITH_REGS ftrace_graph_caller asm as suggested by Mark.
>>> ---
>>>  arch/arm64/include/asm/ftrace.h  |  7 +++++++
>>>  arch/arm64/kernel/entry-ftrace.S | 17 -----------------
>>>  arch/arm64/kernel/ftrace.c       | 17 +++++++++++++++++
>>>  3 files changed, 24 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
>>> index 1494cfa8639b..dbc45a4157fa 100644
>>> --- a/arch/arm64/include/asm/ftrace.h
>>> +++ b/arch/arm64/include/asm/ftrace.h
>>> @@ -80,8 +80,15 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>>  
>>>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>>  struct dyn_ftrace;
>>> +struct ftrace_ops;
>>> +struct ftrace_regs;
>>> +
>>>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>>>  #define ftrace_init_nop ftrace_init_nop
>>> +
>>> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>>> +		       struct ftrace_ops *op, struct ftrace_regs *fregs);
>>> +#define ftrace_graph_func ftrace_graph_func
>>>  #endif
>>>  
>>>  #define ftrace_return_address(n) return_address(n)
>>> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
>>> index e535480a4069..d42a205ef625 100644
>>> --- a/arch/arm64/kernel/entry-ftrace.S
>>> +++ b/arch/arm64/kernel/entry-ftrace.S
>>> @@ -97,12 +97,6 @@ SYM_CODE_START(ftrace_common)
>>>  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>>>  	bl	ftrace_stub
>>>  
>>> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>> -SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
>>> -	nop				// If enabled, this will be replaced
>>> -					// "b ftrace_graph_caller"
>>> -#endif
>>> -
>>>  /*
>>>   * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
>>>   * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
>>> @@ -127,17 +121,6 @@ ftrace_common_return:
>>>  	ret	x9
>>>  SYM_CODE_END(ftrace_common)
>>>  
>>> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>> -SYM_CODE_START(ftrace_graph_caller)
>>> -	ldr	x0, [sp, #S_PC]
>>> -	sub	x0, x0, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
>>> -	add	x1, sp, #S_LR			// parent_ip (callsite's LR)
>>> -	ldr	x2, [sp, #PT_REGS_SIZE]	   	// parent fp (callsite's FP)
>>> -	bl	prepare_ftrace_return
>>> -	b	ftrace_common_return
>>> -SYM_CODE_END(ftrace_graph_caller)
>>> -#endif
>>> -
>>>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>>  
>>>  /*
>>> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
>>> index 4506c4a90ac1..35eb7c9b5e53 100644
>>> --- a/arch/arm64/kernel/ftrace.c
>>> +++ b/arch/arm64/kernel/ftrace.c
>>> @@ -268,6 +268,22 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>>>  }
>>>  
>>>  #ifdef CONFIG_DYNAMIC_FTRACE
>>> +
>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> 
> Is there a case were we have DYNAMIC_FTRACE but not
> DYNAMIC_FTRACE_WITH_REGS?

Yes, when HAVE_DYNAMIC_FTRACE_WITH_REGS is not selected because of low gcc version.

> 
>>> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>>> +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>>> +{
>>> +	/*
>>> +	 * Athough graph_ops doesn't have FTRACE_OPS_FL_SAVE_REGS set in flags,
>>> +	 * regs can't be NULL in DYNAMIC_FTRACE_WITH_REGS. By design, it should
>>> +	 * be fixed when DYNAMIC_FTRACE_WITH_ARGS is implemented.
>>> +	 */
>>> +	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
>>> +	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
>>> +
>>> +	prepare_ftrace_return(ip, parent, frame_pointer(regs));
>>> +}
>>> +#else
> 
> You deleted ftrace_graph_caller above from entry-ftrace.S, if we can get
> here with some options, wouldn't that break the build?

The above ftrace_graph_caller deleted is only for CONFIG_DYNAMIC_FTRACE_WITH_REGS,
and I tried using a low gcc version that doesn't select HAVE_DYNAMIC_FTRACE_WITH_REGS,
it can build success.

Thanks.

> 
> -- Steve
> 
> 
>>>  /*
>>>   * Turn on/off the call to ftrace_graph_caller() in ftrace_caller()
>>>   * depending on @enable.
>>> @@ -297,5 +313,6 @@ int ftrace_disable_ftrace_graph_caller(void)
>>>  {
>>>  	return ftrace_modify_graph_caller(false);
>>>  }
>>> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>>  #endif /* CONFIG_DYNAMIC_FTRACE */
>>>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */  
> 
