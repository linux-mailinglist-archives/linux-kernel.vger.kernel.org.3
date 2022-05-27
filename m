Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B15535E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbiE0Khg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiE0Khe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:37:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1BDFD346
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:37:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t26so4929134edt.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W7So3PhdjMp2KqaM3P3rQkSF+4mUlCLPgYovIk/NSCw=;
        b=PUNht9tdP2C3Y0PIKz6i9gtrFmX5JYDN+SFx9BcvHPe7WZ5grwHH0ZBECn0W/r19w7
         zA4gwdCw9lJ4dBRXH+KW5K1Pt2GaIUXYtfSrMLIO2gYh8+AOJYQp3IqKPzSjQkkn557m
         jjEE/Oiz8tv8c3ALgpqeBRpPuqK7sZG5QrY69q6sUqjCIdi8m9a2LEv7OWADoxoyDiKe
         fxR1olI4lOgUqF4n3yNYok4YnYPEOeC+FDy12b7l3zISaS2KUQxX+rDo8p4Y3F8FSW/D
         7o3RU8OJsTFTOtCqkABeInsEy9xkU1a3ntiJfQxMMmKjeZhTa1HgR0tXv+SrNV8oUxxT
         ZXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=W7So3PhdjMp2KqaM3P3rQkSF+4mUlCLPgYovIk/NSCw=;
        b=LyPHcuvY7mZwA0GogXCFqNdI/Ut7ZyRhZ9I5c3COXfHG2s6P327krFW8oICAUUicRZ
         iABp39nVujerW5ULHxnoSTNSpaqPXe4rZP+V63+Sj4eQqepP6Qlyzie5cPky5rhy61F2
         xTHVNrpie+zNakJEO7uXFfPN0wUl0RmkxXIXcMW6N99LAOo2bN5WxuC0LAnwRWxtDOMP
         /G1pDvCv8gGlut5EFnGa+XXPpdhiRnY4S7TeUwdfipjUUaMg4NAXwOgxvw+e8Xdfhadb
         YOBxheEG0gvHXilKLA/0XvVvn+PerHfkuWMK5aOvsyJPq2wTSFnlkMxH6r35/UjnMc+8
         VA2A==
X-Gm-Message-State: AOAM532H7ZmwmbEYPtkmx6WWaxHUVP91TgJiwxIsjk6XgsVy4r4vtmIT
        laZuksp3Laxm6B7dQ9k4rgscLX955eg=
X-Google-Smtp-Source: ABdhPJyrKJcw27l2xBcyc43CQC+hE9P1wSWSmQlKC2t+8P6LD18L9aqjR/BvIXhIB/J4a4118sln8Q==
X-Received: by 2002:a05:6402:350f:b0:428:43a1:647d with SMTP id b15-20020a056402350f00b0042843a1647dmr6677317edd.62.1653647849163;
        Fri, 27 May 2022 03:37:29 -0700 (PDT)
Received: from gmail.com (563BA16F.dsl.pool.telekom.hu. [86.59.161.111])
        by smtp.gmail.com with ESMTPSA id b17-20020a056402351100b0042bc97322desm1984603edd.43.2022.05.27.03.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:37:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 27 May 2022 12:37:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/3] x86/microcode: Default-disable late loading
Message-ID: <YpCp5B7noKAt+91A@gmail.com>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-3-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524185324.28395-3-bp@alien8.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> It is dangerous and it should not be used anyway - there's a nice early
> loading already.
> 
> Requested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/Kconfig                     | 11 +++++++++++
>  arch/x86/kernel/cpu/common.c         |  2 ++
>  arch/x86/kernel/cpu/microcode/core.c |  7 ++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1c0da2dbfb26..33891b82fb65 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1345,6 +1345,17 @@ config MICROCODE_AMD
>  	  If you select this option, microcode patch loading support for AMD
>  	  processors will be enabled.
>  
> +config MICROCODE_LATE_LOADING
> +	bool "Late microcode loading (DANGEROUS)"
> +	default n
> +	depends on MICROCODE
> +	help

( Small nit: 'default n' is the default, there's no need to list it 
  explicitly - and that's the convention as well. )

> +	  Loading microcode late, when the system is up and executing instructions
> +	  is a tricky business and should be avoided if possible. Just the sequence
> +	  of synchronizing all cores and SMT threads is one fragile dance which does
> +	  not guarantee that cores might not softlock after the loading. Therefore,
> +	  use this at your own risk. Late loading taints the kernel too.

Might make sense to outline here valid circumstances under which late 
loading is used? Such as some weird kernel package that doesn't have the 
latest firmware included in the initrd?

Because it's hard (for me) to see any valid circumstance under which late 
loading should be supported at all TBH: new kernels where this patch is 
active would come with a modern package.

Ie. we should consider removing late loading altogether.

Thanks,

	Ingo
