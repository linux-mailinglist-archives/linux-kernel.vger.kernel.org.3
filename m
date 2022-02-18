Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0CC4BC12E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiBRU2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:28:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBRU2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E978621D0A4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645216106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNaUEreaifOp/OglB8GJSgfLwiBjVBu/cwnxKYI2cd8=;
        b=esZiUYThHK6XVdsAcw1v7Mb/7D4AL9uoqkL/rCFlAF5wuHU22eLCF0Ef0F3EbBfImqCs6u
        351VTKNDeoX26mpAe0WV65tWMleKZTWkraS6oxxgxKqSIvmArZhkW3WT9U+sOnDFeBWg+W
        aOXxmEnE/Nk8BuvE/sc2qwC4sVvMP5k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-XR1IhEs3NUOW0IZo1rqXvA-1; Fri, 18 Feb 2022 15:28:24 -0500
X-MC-Unique: XR1IhEs3NUOW0IZo1rqXvA-1
Received: by mail-qk1-f197.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so8380544qkb.23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GNaUEreaifOp/OglB8GJSgfLwiBjVBu/cwnxKYI2cd8=;
        b=K7CydGTncgU1R3JZjARIReIgAVNZSu45TkPtkliq/FEAd5L5hlITAVbVLf+8ImWBsc
         0tpls3WcbOWlIWCi0wM858OZHobOqCn4W2WmgcW8o/Xuiam9El59sIE14ik/U6ZpdHE4
         Grs46rDMOs7pmd653Ktd6VPAaJR/aV0F5a6jvExXJyUwTdm774M/LSK8H1Bmk3OJfWh+
         zpCwUiMhw35Cshuy1vQz7tbiUUF9qRlfX0QCLMm+8PTM/uI197mEEwvbgJJekCzL7bi8
         VvpPII6uGAnyNUYXGwUozG+tQrdZfgaalXJTP+WLhJXh7kJhvK8a+j60fjjJrYiz/FhW
         jjlg==
X-Gm-Message-State: AOAM533y085ydnM88j4Gfe0CbX3YzJGYoIdVeJU5huDQ5kz18Kg9ORqR
        arsQkTr4TdT0q8B2iytALXPr/BEliNQyqk0iMolANnrM43xETFa8i1badT2F0UxjD6NdgSwXO4g
        nc2G8m/uOih8Ht3NTZyDboB4C
X-Received: by 2002:ac8:4e51:0:b0:2dd:53e9:6c14 with SMTP id e17-20020ac84e51000000b002dd53e96c14mr7314966qtw.673.1645216104222;
        Fri, 18 Feb 2022 12:28:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxniQmFIzkrLcfHl2hy/x0o/5qpoUVyvMeEHjF76JH0Ipx2ay7glvX+6BCr/2T4UQBNO9GAdQ==
X-Received: by 2002:ac8:4e51:0:b0:2dd:53e9:6c14 with SMTP id e17-20020ac84e51000000b002dd53e96c14mr7314950qtw.673.1645216104002;
        Fri, 18 Feb 2022 12:28:24 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id c2sm18333613qkp.0.2022.02.18.12.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:28:23 -0800 (PST)
Date:   Fri, 18 Feb 2022 12:28:20 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 02/29] x86/module: Fix the paravirt vs alternative order
Message-ID: <20220218202820.7tvwxytkyqtngiks@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.691941184@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171408.691941184@infradead.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:04PM +0100, Peter Zijlstra wrote:
> Ever since commit 4e6292114c741 ("x86/paravirt: Add new features for
> paravirt patching") there is an ordering dependency between patching
> paravirt ops and patching alternatives, the module loader still
> violates this.
> 
> Fixes: 4e6292114c741 ("x86/paravirt: Add new features for paravirt patching")
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Probably a good idea to put the 'para' and 'alt' clauses next to each
other and add a comment that the ordering is necessary.

> ---
>  arch/x86/kernel/module.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -272,6 +272,10 @@ int module_finalize(const Elf_Ehdr *hdr,
>  			retpolines = s;
>  	}
>  
> +	if (para) {
> +		void *pseg = (void *)para->sh_addr;
> +		apply_paravirt(pseg, pseg + para->sh_size);
> +	}
>  	if (retpolines) {
>  		void *rseg = (void *)retpolines->sh_addr;
>  		apply_retpolines(rseg, rseg + retpolines->sh_size);
> @@ -289,11 +293,6 @@ int module_finalize(const Elf_Ehdr *hdr,
>  					    tseg, tseg + text->sh_size);
>  	}
>  
> -	if (para) {
> -		void *pseg = (void *)para->sh_addr;
> -		apply_paravirt(pseg, pseg + para->sh_size);
> -	}
> -
>  	/* make jump label nops */
>  	jump_label_apply_nops(me);
>  
> 
> 

-- 
Josh

