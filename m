Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9B4C2175
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiBXCAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiBXCAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:00:47 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1504948E51
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:00:18 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 12so509684pgd.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NXr8GTsfYUYw0E0HQ3a+CoAAlfrMzhnvy9nZp4X3tWk=;
        b=R5KDWon3/vHUDah33e/t2MCOcg8+WvOy4PFJc9cewBZqDsdjhhrSrf2LtCjXe8jnDB
         Eho9SihI3A/Jy616fyW/fv4b3GMm9Jy+fhqjYFIbchhyJBqZtuRJsCLUqC4x+Vhnm/8+
         3oVq8fzQWMOuqFEuA32pMpswFEfhMyvZNcDtxziyHpE/F2PgEfvLj17KNn4opIpPYtZz
         ZhuND6C7hPe6wa5ZTKYuyMjVjwqWhr/Nq/xrAtAw/xYiCVaR1c2pdebb/gVJrKdRABED
         RXEDNO/DW0iUjAJNqb+iIDWs70N/ViIM4LIBqJa3srBF9wPA7AXONlM8pO5dIptW8iWa
         apmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NXr8GTsfYUYw0E0HQ3a+CoAAlfrMzhnvy9nZp4X3tWk=;
        b=Y8ANCFRKKWB8lWg0eHI16ACPVkYrSnjZ8+gYz/dRkEtj2sMedoB/CVgBy1aqqQwoik
         ql2NRd41s7cBc1wuVmp6GwU8579VXUNfZSpzdqVoSnxyluG+6OC66csRtZtgayIfnzNR
         8TIBAXehLMw+KmZe4zx3MVPjsfp/iohYNLcgN46NQGvFBzdtn2HrKla+kqH6N61ghrKA
         FijkfBbhnjy+cvn8y20/fWp9UCeZQCb/tMHmMNgH8gbFCqjgm9/UR1maEbVxNchBxXgJ
         KPwBjGUVMJEamFi71TTmotFi0wljCHcqzgnq1zonVapwevU956cdYMgjhFJo0AslynqW
         OI9g==
X-Gm-Message-State: AOAM532x7xEtO6iL/AR5bauHBsrJBDsvidooDnnvGI4ZQXLUv+esGAwV
        Jrv6xitMap20tGV4N0XZZ3DDxw==
X-Google-Smtp-Source: ABdhPJw60uK/G32Bqxmg7RPw5lHoatBIlDVI1bpoaEesoX0yIl5b4opaBu9Eh5Km5H4jWJdc+VmSLw==
X-Received: by 2002:a62:7846:0:b0:4c7:f23e:1fd7 with SMTP id t67-20020a627846000000b004c7f23e1fd7mr569904pfc.67.1645668017590;
        Wed, 23 Feb 2022 18:00:17 -0800 (PST)
Received: from [10.70.253.117] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id h5sm843774pfc.69.2022.02.23.18.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 18:00:17 -0800 (PST)
Message-ID: <cd6720c7-bcc9-3938-4730-90fe551408ef@bytedance.com>
Date:   Thu, 24 Feb 2022 10:00:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] Re: [PATCH v2 1/2] ftrace: cleanup ftrace_graph_caller
 enable and disable
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        broonie@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com
References: <20220223090132.10114-1-zhouchengming@bytedance.com>
 <20220223201725.4cbb6d8a@rorschach.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220223201725.4cbb6d8a@rorschach.local.home>
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

On 2022/2/24 9:17 上午, Steven Rostedt wrote:
> On Wed, 23 Feb 2022 17:01:31 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
> 
>> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
>> index 7cc540e6de0c..c119ef7a9295 100644
>> --- a/arch/x86/kernel/ftrace.c
>> +++ b/arch/x86/kernel/ftrace.c
>> @@ -615,18 +615,8 @@ int ftrace_disable_ftrace_graph_caller(void)
>>  
>>  	return ftrace_mod_jmp(ip, &ftrace_stub);
>>  }
>> -#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>> -int ftrace_enable_ftrace_graph_caller(void)
>> -{
>> -	return 0;
>> -}
>> -
>> -int ftrace_disable_ftrace_graph_caller(void)
>> -{
>> -	return 0;
>> -}
>> -#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>> -#endif /* !CONFIG_DYNAMIC_FTRACE */
>> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>> +#endif /* CONFIG_DYNAMIC_FTRACE */
> 
> Since you are cleaning this up, and the above starts with:
> 
> #ifdef CONFIG_DYNAMIC_FTRACE
> 
> #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> 
> 
> They were separate because of the #else that you just removed. I would
> recommend consolidate them into a single #ifdef:
> 
> #if defined(CONFIG_DYNAMIC_FTRACE) && !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
> 
> [..]
> 
> #endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMI_FTRACE_WITH_ARGS */
> 

Good suggestion, this is better.

Thanks.

> 
> -- Steve
> 
> 
>>  
>>  /*
>>   * Hook the return address and push it in the stack of return addrs
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index f9feb197b2da..60ae009e6684 100644
