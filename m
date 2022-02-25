Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD754C3A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiBYAnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:43:24 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BB247767
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:42:53 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so3459132pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4cAS+/3h4MUU51Rzui2xjVWumdcptWrEXmcCEWitpSQ=;
        b=I+C9jDYxCXbFG2nT7ztQIAa/jeqoO04uIrnCQcSMqV1euZoSiTEWcUkpQil1hoZOq7
         NDU1QAqOg8HtOBdSg3ORgLBWuERxlirsyao8AD0mfs23+IgA8klROLzJJiHcgZz5pz4Z
         GqPxXSbO30JZ9wjz+95CKLD20GzESWaJH/VPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4cAS+/3h4MUU51Rzui2xjVWumdcptWrEXmcCEWitpSQ=;
        b=JrrcP+jg/IwJK+0A0c+330eqbE45qZ4R1seB0nkPZyJNwXo2lEE29mn5v0r0J9f04b
         lJ8U5ZKFXEFDItsPsMQIk0ZuuGEnt12GoXStYqbchPFtFJPEs8AUBSdnyg0FVKsBXgMP
         ftVm++SbDFUhFBPdLSCLpvGkQdgrfSjNm2WOrRYgPLpUNDtw3esgFzPIqFS8qzRUKLCT
         MBLAC8RxtDQCUaeQV8k6XV86SbYs1FT0aJIkiKldLuAytOq273CyN8DIETY+ZAV8ErKi
         TimMkfUhOinWdgZJkvlE6GJMUE+rTpBxQLhdsjXgQwHiKpLJNx6PVFo9fY7RKzZHOWKQ
         +b/A==
X-Gm-Message-State: AOAM5335vGBlECQ56Hnc7DVa3zSKmqlAvzAdCJ5SerNmqZxeymmVkCb5
        PoLRp0/RPuVBWzNmfWLT4ci/0g==
X-Google-Smtp-Source: ABdhPJzNdymjkQHFibKXjY96jtZwPV6cSBqKumlEIGbcLKg4I0R7AmHNwjFKhM9VKBj6xJ+knwFl+w==
X-Received: by 2002:a17:90b:4c8e:b0:1b9:d23f:bf62 with SMTP id my14-20020a17090b4c8e00b001b9d23fbf62mr678664pjb.160.1645749772842;
        Thu, 24 Feb 2022 16:42:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b004df51429f31sm712559pfz.79.2022.02.24.16.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:42:52 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:42:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 07/39] x86/entry: Sprinkle ENDBR dust
Message-ID: <202202241638.B89211A@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.423131356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.423131356@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:45PM +0100, Peter Zijlstra wrote:
> The SYSCALL entry points are found through taking their respective
> address in order to program them in the MSRs, while the exception
> entry points are found through UNWIND_HINT_IRET_REGS.

Stupid question: does CET consider exception and syscall entry points to
be indirect calls? (I would expect so, but they're ever so slightly
differently executed...)

> [...]
>  0 :
> +	ENDBR
>  	.byte	0x6a, vector
>  	jmp	asm_common_interrupt
> -	nop
> -	/* Ensure that the above is 8 bytes max */
> -	. = 0b + 8
> +	/* Ensure that the above is IDT_ALIGN bytes max */
> +	.fill 0b + IDT_ALIGN - ., 1, 0x90

IIUC, these are just padding -- let's use 0xcc instead of 0x90 as we do
in other places (e.g. vmlinux.lds.S).

-- 
Kees Cook
