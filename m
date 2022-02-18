Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369804BC18C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbiBRVI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:08:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBRVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 156CF10FD3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645218517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nVamlfcTUZABNPWHwKiYsy4zyINV7sFAe+6maTrLNFs=;
        b=b8JGLl9auDqAqL52B64UGT61SpexBWaCRkuujItA9QmDBl5litWRGFlhv+NNcJHHJYN/Co
        MeoKHSwCascsbOrmEQlpO0wc2JwxkYUdgkC7GiLR1tGYfgb9n9MVysJEhwj4tAYGJpytI+
        jdCm5+AO+n0sZFgsT2CX++nwCTuVJ3E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-4NIKvOHnP2-DULaEF8mOmA-1; Fri, 18 Feb 2022 16:08:35 -0500
X-MC-Unique: 4NIKvOHnP2-DULaEF8mOmA-1
Received: by mail-qk1-f199.google.com with SMTP id bi17-20020a05620a319100b0050850bdcbb2so8452570qkb.17
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nVamlfcTUZABNPWHwKiYsy4zyINV7sFAe+6maTrLNFs=;
        b=oVarvXfYowVe6zXp6rn94aRd1e2zgXee4ddD3IDn9f7pV4P4uG32bNbB4L9vZRxARP
         CP5zSi98iUS591+dgvaGQi94mE8rspgTGewRq9ER+EtTwdgQCiJ/LfSjGYTTeLDCBsKB
         9ZtAY4rf3QrSK7A1236U4CfKVldG5bV9wrQME5CY5z1gUg7nnUjBExMlkr2nvL+FNsCZ
         FM1p3qZ8N/gpOVsFOmBvu3+exlc6n9I88/kEcVc7yTjrULip5q1jQ5gBnVrty6PyxYeP
         yiJ/Ifsk4l+yRK4D+bdokVEyd12LkA/+wa4NBIJ/byEE8draTwOZhoc1TUQnOP3IzsYo
         WvTA==
X-Gm-Message-State: AOAM531yYHgZXJSfs9CDbZLR1xsq6dBPbGUaZoYTlq4yEbzzMm97pp1P
        w1PaRyJ2c2NUrj0hj/aAgg6ZtZvyIK5BRWd/IQ6zep2im8ieJEDfznzzMYD+Oy1X6maeWdz3uyu
        7IYRlB8NlpPHLl1jIy4udPKMO
X-Received: by 2002:ad4:5d45:0:b0:42c:37fe:6e48 with SMTP id jk5-20020ad45d45000000b0042c37fe6e48mr7389166qvb.37.1645218515278;
        Fri, 18 Feb 2022 13:08:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7zCa8lEAZHm4WLScv/y+Zt4e8ZY+GUHayOI7MzRLhV614dIKefKQ6PUFkiNnP9+b+sJmd9g==
X-Received: by 2002:ad4:5d45:0:b0:42c:37fe:6e48 with SMTP id jk5-20020ad45d45000000b0042c37fe6e48mr7389147qvb.37.1645218515072;
        Fri, 18 Feb 2022 13:08:35 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id t30sm2994581qtc.57.2022.02.18.13.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:08:34 -0800 (PST)
Date:   Fri, 18 Feb 2022 13:08:31 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
Message-ID: <20220218210831.u2ugtfr7gxllk4cs@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.808810436@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171408.808810436@infradead.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:06PM +0100, Peter Zijlstra wrote:
> Currently livepatch assumes __fentry__ lives at func+0, which is most
> likely untrue with IBT on. Override the weak klp_get_ftrace_location()
> function with an arch specific version that's IBT aware.
> 
> Also make the weak fallback verify the location is an actual ftrace
> location as a sanity check.
> 
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/livepatch.h |    9 +++++++++
>  kernel/livepatch/patch.c         |    2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/include/asm/livepatch.h
> +++ b/arch/x86/include/asm/livepatch.h
> @@ -17,4 +17,13 @@ static inline void klp_arch_set_pc(struc
>  	ftrace_instruction_pointer_set(fregs, ip);
>  }
>  
> +#define klp_get_ftrace_location klp_get_ftrace_location
> +static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
> +{
> +	unsigned long addr = ftrace_location(faddr);
> +	if (!addr && IS_ENABLED(CONFIG_X86_IBT))
> +		addr = ftrace_location(faddr + 4);
> +	return addr;

I'm kind of surprised this logic doesn't exist in ftrace itself.  Is
livepatch really the only user that needs to find the fentry for a given
function?

I had to do a double take for the ftrace_location() semantics, as I
originally assumed that's what it did, based on its name and signature.

Instead it apparently functions like a bool but returns its argument on
success.

Though the function comment tells a different story:

/**
 * ftrace_location - return true if the ip giving is a traced location

So it's all kinds of confusing...

-- 
Josh

