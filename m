Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B04FC5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiDKUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiDKUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF54835DE8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649709162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=21ZYGLIAhG6/MZbPQ2hoxMmydyuembtu3axgi8kDkCM=;
        b=FEOZcsaMBndkSp/r/qJL8Gep6a+2sPCBUKU5TEZWlhPy7F6zs5F+cOAfim64gl8B2OnANL
        aQnsFKxs8cRwvgSJcQ7jytdSizFyNv0qDGXNGy+Vlf3tEEcgkOCCuQ6XIYBDSaxb36dsaz
        IhznOcb0eo1uG7b93+cVMI+Hu26gF+M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-TdAIWlpSN7OZIpvM_LYGSw-1; Mon, 11 Apr 2022 16:32:41 -0400
X-MC-Unique: TdAIWlpSN7OZIpvM_LYGSw-1
Received: by mail-qk1-f197.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso8290674qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21ZYGLIAhG6/MZbPQ2hoxMmydyuembtu3axgi8kDkCM=;
        b=ixIRpA/g7Zr9N4PpWwys2DEjyu4bU4UX3aWyxDyF+TnkcHjU+IkuEaPGqjXzHn9dmy
         ZAtfYzKg9i0l97QkiN2LPuihecfQULeC/XLhUaCVI71K6NUWBVzgcQlOAvNUT7mC+Bly
         M9rLlalfWIAZqtrVNR/Vk6Fw/vG/elqg4Tw9fNSV/ghrA6bxHGcpD0u7UpUrcVq1ME/T
         sG4UItuiBoyN/vP9gfd8D3+Q380URL4GjHd2qwMHcXRChIdwId1c0aeKRmJjldAQvsHf
         rHQCg8tJV3kJ3HWsJCFiFwlhl+7b6sXKOnvPqn2DHPEeSoYRa8KOpcJbANPPBZmo5GPk
         xp/w==
X-Gm-Message-State: AOAM530iT680YTgy16Co7RWtAAjqhSKYqS8CsTPi9Ox8d2ORuiyT4vXY
        zn7F2aj9QmPcC9w39NrnuzgnCgoIkq9sXBhf9ZYtGFHGTX/rEe0JgZlCFzzypRb4EMvqx9YgiNc
        XRfQMmH6N9bsx8ZXmmZ028ipX
X-Received: by 2002:ac8:45cb:0:b0:2ed:bcd:a6f1 with SMTP id e11-20020ac845cb000000b002ed0bcda6f1mr872579qto.501.1649709160684;
        Mon, 11 Apr 2022 13:32:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuKuTG37lgSWU0Nh0km44571g+rl0BXhYFoTScq/Hp8RNUsJfRLg2Z316WHAkHSf8l0P8f0g==
X-Received: by 2002:ac8:45cb:0:b0:2ed:bcd:a6f1 with SMTP id e11-20020ac845cb000000b002ed0bcda6f1mr872561qto.501.1649709160430;
        Mon, 11 Apr 2022 13:32:40 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id w17-20020ac857d1000000b002e19feda592sm25912130qta.85.2022.04.11.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:32:39 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:32:37 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH 3/4] x86,objtool: Mark cpu_startup_entry() __noreturn
Message-ID: <20220411203237.v2eqjiee4kcmug6s@treble>
References: <20220408094552.432447640@infradead.org>
 <20220408094718.383658532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408094718.383658532@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

I just ran into this:

  init/main.o: warning: objtool: rest_init() falls through to next function kernel_init()

so we need this as well:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 565fec451d69..fab2235599a0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -184,6 +184,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
                "do_group_exit",
                "stop_this_cpu",
                "__invalid_creds",
+               "cpu_startup_entry",
        };

        if (!func)

