Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7E4FE466
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356862AbiDLPQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiDLPQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D53BD5DA00
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649776439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyHmXD8IxpU6JDF08eJz7bwB6YAvy1zmS3NcrgnlzE0=;
        b=VAa5jQ9qRXF5mdk1ARca6pq6axSc2OF7esPn8DRhbPnAMXXCogB6uA9Ywlx2BPgiUMasjY
        1TgnxmwltquPZutmqq0dcFybKkOfxW3vcz1q3rO8J6aYVxFkAvrFaUd2u2Wb+jgc0jhBjh
        aLnx76vhnR3oBS9mD0FFs/dRxhEjZWU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-9jR7ZGNtPvSf3mpSJ2V-gg-1; Tue, 12 Apr 2022 11:13:59 -0400
X-MC-Unique: 9jR7ZGNtPvSf3mpSJ2V-gg-1
Received: by mail-qk1-f197.google.com with SMTP id bq6-20020a05620a468600b00699e63cfda4so9817416qkb.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PyHmXD8IxpU6JDF08eJz7bwB6YAvy1zmS3NcrgnlzE0=;
        b=5tb1RIBET1wyvGl5UkpOfBFFSEGkZVStkLMDxGDdeXOURKnoF1nlF+psGk5nQU94N9
         RVj5+XI7ynQyb5z/FSIob1Lf8rO3CHvi1fm5R5HzfzGsa91bA5YUU6en1nUg8RpfqkAb
         CsbXL+JX/plnEhZkajhkzjx2qsB0E7Moj6Xv7BJcnLy1CiSCtlHgTG820LJ4kGNBUoQp
         6lRK6V61yeCP90sluiqCMGNUZ26ypxIBAMp9GvNEahlvsh0lfEjFhfFQiKWOxuGkdtr2
         m+lMZQcjZfnaCSi3kih3qNGoKrineAF7A88Fo0zPHk+wU5R3sGWjPF+lttUX5RgbtW+U
         RSdg==
X-Gm-Message-State: AOAM5331s/X822x11gS1aUqWNz4KzQ6iGFKRej/8/gh1TZUYAoha2DR4
        nuYq/YCDXr9+rwiZLgvxryYD0L1IMHfTgFhyFbQ1i6/XMGQN7Sy2Lgh3Ro+fkvb8OcI3pM4u2v5
        Ne2rmVepyeRXmEINeecpa+bcb
X-Received: by 2002:ad4:5b89:0:b0:441:7bd1:2999 with SMTP id 9-20020ad45b89000000b004417bd12999mr31562820qvp.60.1649776438163;
        Tue, 12 Apr 2022 08:13:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUylYTThCsEM4A44riKT1G++SVBz83yHnYf40SfEjAEAbfF/L9Fqu58X0eExWgh6ngHDoW7A==
X-Received: by 2002:ad4:5b89:0:b0:441:7bd1:2999 with SMTP id 9-20020ad45b89000000b004417bd12999mr31562796qvp.60.1649776437894;
        Tue, 12 Apr 2022 08:13:57 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h7-20020ac85e07000000b002ed1036f131sm8321181qtx.41.2022.04.12.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:13:57 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:13:54 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH 3/4] x86,objtool: Mark cpu_startup_entry() __noreturn
Message-ID: <20220412151354.tjx2fxqxibdhzenq@treble>
References: <20220408094552.432447640@infradead.org>
 <20220408094718.383658532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408094718.383658532@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:45:55AM +0200, Peter Zijlstra wrote:
> GCC-8 isn't clever enough to figure out that cpu_start_entry() is a
> noreturn while objtool is. This results in code after the call in
> start_secondary(). Give GCC a hand so that they all agree on things.
> 
>   vmlinux.o: warning: objtool: start_secondary()+0x10e: unreachable
> 
> Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/cpu.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -167,7 +167,7 @@ static inline int suspend_disable_second
>  static inline void suspend_enable_secondary_cpus(void) { }
>  #endif /* !CONFIG_PM_SLEEP_SMP */
>  
> -void cpu_startup_entry(enum cpuhp_state state);
> +void __noreturn cpu_startup_entry(enum cpuhp_state state);
>  
>  void cpu_idle_poll_ctrl(bool enable);

Also needs added to the objtool noreturn list.

-- 
Josh

