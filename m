Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2120F4C0DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiBWH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbiBWH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:56:09 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725B65156
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:55:42 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id l8so17915060pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=45JlznYV8wk7xzGv1ZTp3w27P+Mtc49R+loIGdcFvZU=;
        b=1lczeAJwMH+l1Qox/69jWR11DW2NEebE1vf559Pc8qjyRdfobs/DpDH87fccPifd8d
         z2uHx4GJdfH9VwtBQWX0q2RMzwZH63Nf97fT6Vl/sJB2uQJ81OQen3d4OZJJtHe3G/99
         wlaOgwbFT7C547bYiSw8x8bSNLAqdpYLwhWthcFz/IeJyV8+6FLSyEkOT66/ZLN7UkMa
         DR3mKTC0kjETCUGU/haTaXYa0GDCx94rpEiIzeuuzWd3ySsdUfK1kkK58CBb2PkgdR4D
         uyaYmsDjKR2QsDaPldaKK9Iri5uI4UaPH1AAgZc1qhVlZ7nHfF2YEweKSMV8JOA7B+6x
         ji8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=45JlznYV8wk7xzGv1ZTp3w27P+Mtc49R+loIGdcFvZU=;
        b=czj/SeLk+Xdy/2RqUxDE8Czrft7G8YuWrq1ZlFBCGvmumLDqEbKdUom3LK7UeGEF6r
         nScNaqRWRVcJrlz0X/PubWtfLtv671XUpR4LiIkD7KKVucKimHDeCWSqE4krffwsgenD
         UJVw1Jn16MWZXXYhSgw7v2kjonPJl3VqEVCHWBYcL+HI8J3Noo78JJ3CiKAhEVguPl3r
         DtA8/89flxH8cIolKqeZa/lP/C1KFM2lLXacd/M2nLs+PtEy9JNJPS4lJexwS+ba3rfX
         c3OTsHngLdZM00n/WiG/51WVu+zoJlGOHfv7TTmzOvQR8lst7g18jg2UvfmqSfuod5nr
         5aQg==
X-Gm-Message-State: AOAM5328tYkRej83k9/fz98hmIn61wCVtNCq0tIF3/+mNIQYEapeF2jw
        7WnVGScQ12r8CVT61nXY3P8+Rw==
X-Google-Smtp-Source: ABdhPJwHaDtl0n4+YX7Vi3JBjCx5/EDgt44N5EsxLexHLjX8LUf2LkmoUCQzQYk7sOjAFypQfqq9Sg==
X-Received: by 2002:a17:902:e743:b0:14f:c274:cc2a with SMTP id p3-20020a170902e74300b0014fc274cc2amr11411722plf.70.1645602942223;
        Tue, 22 Feb 2022 23:55:42 -0800 (PST)
Received: from [10.255.215.56] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id m37sm2788359pgb.59.2022.02.22.23.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:55:41 -0800 (PST)
Message-ID: <ad3de853-35a7-0fc5-2ac8-4f54fee89cf5@bytedance.com>
Date:   Wed, 23 Feb 2022 15:55:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] Re: [PATCH] arm64/ftrace: Make function graph use
 ftrace directly
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220222130049.81284-1-zhouchengming@bytedance.com>
 <YhUHRIDaLqhAz0SV@lakrids>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YhUHRIDaLqhAz0SV@lakrids>
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

On 2022/2/22 11:54 下午, Mark Rutland wrote:
> On Tue, Feb 22, 2022 at 09:00:49PM +0800, Chengming Zhou wrote:
>> As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
>> use ftrace directly"), we don't need special hook for graph tracer,
>> but instead we use graph_ops:func function to install return_hooker.
>>
>> Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
>> implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
>> the same optimization on arm64.
> 
> This is a nice cleanup/refactoring, but I don't think this is an
> optimization as such; we're still doing the same work, just in
> marginally different place. So I'd suggest s/optimization/cleanup/ here.
> 
> It's probably worth noting that this *only* changes the FTRACE_WITH_REGS
> implementation, and the mcount-based implementation is unaffected by
> this patch.
> 

Agree, I will change the commit message in the next version.

>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  arch/arm64/include/asm/ftrace.h  |  7 +++++++
>>  arch/arm64/kernel/entry-ftrace.S |  6 ------
>>  arch/arm64/kernel/ftrace.c       | 21 +++++++++++++++++++++
>>  3 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
>> index 1494cfa8639b..dbc45a4157fa 100644
>> --- a/arch/arm64/include/asm/ftrace.h
>> +++ b/arch/arm64/include/asm/ftrace.h
>> @@ -80,8 +80,15 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>  
>>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>  struct dyn_ftrace;
>> +struct ftrace_ops;
>> +struct ftrace_regs;
>> +
>>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>>  #define ftrace_init_nop ftrace_init_nop
>> +
>> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>> +		       struct ftrace_ops *op, struct ftrace_regs *fregs);
>> +#define ftrace_graph_func ftrace_graph_func
>>  #endif
>>  
>>  #define ftrace_return_address(n) return_address(n)
>> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
>> index e535480a4069..eb4a69b1f84d 100644
>> --- a/arch/arm64/kernel/entry-ftrace.S
>> +++ b/arch/arm64/kernel/entry-ftrace.S
>> @@ -97,12 +97,6 @@ SYM_CODE_START(ftrace_common)
>>  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>>  	bl	ftrace_stub
>>  
>> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> -SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
>> -	nop				// If enabled, this will be replaced
>> -					// "b ftrace_graph_caller"
>> -#endif
>> -
> 
> You should also be able to delete the FTRACE_WITH_REGS implementation of
> ftrace_graph_caller since that's now unused.
> 
> Having that in the diff would also make it easier to compare to the
> logic in ftrace_graph_func().
> 

Yes, will do.

>>  /*
>>   * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
>>   * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
>> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
>> index 4506c4a90ac1..1b5da231b1de 100644
>> --- a/arch/arm64/kernel/ftrace.c
>> +++ b/arch/arm64/kernel/ftrace.c
>> @@ -268,6 +268,26 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>>  }
>>  
>>  #ifdef CONFIG_DYNAMIC_FTRACE
>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> +int ftrace_enable_ftrace_graph_caller(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +int ftrace_disable_ftrace_graph_caller(void)
>> +{
>> +	return 0;
>> +}
> 
> It's a shame the core code doesn't provide this if we provide an
> implementation of ftrace_graph_func.
> 

Maybe I can provide these weak version functions in the ftrace core code
with an additional patch.

>> +
>> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>> +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>> +{
>> +	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
>> +	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
>> +
>> +	prepare_ftrace_return(ip, parent, frame_pointer(regs));
>> +}
> 
> Other than my comments above, this looks about right, but I'd like to
> give this some testing before I give any tags.
> 
> Could you respin this with the FTRACE_WITH_REGS ftrace_graph_caller asm
> removed?
> 
> Thanks,
> Mark.
> 
Of course, will do.

Thanks!

>> +#else
>>  /*
>>   * Turn on/off the call to ftrace_graph_caller() in ftrace_caller()
>>   * depending on @enable.
>> @@ -297,5 +317,6 @@ int ftrace_disable_ftrace_graph_caller(void)
>>  {
>>  	return ftrace_modify_graph_caller(false);
>>  }
>> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>  #endif /* CONFIG_DYNAMIC_FTRACE */
>>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>> -- 
>> 2.20.1
>>
