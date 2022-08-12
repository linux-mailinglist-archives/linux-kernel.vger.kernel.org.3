Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E54590D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiHLIdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:33:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743629DB55;
        Fri, 12 Aug 2022 01:33:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy5so838932ejc.3;
        Fri, 12 Aug 2022 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=0mFuBwdVPqFlV7N56fSA5adSdmVH4jP4hL7xdmNu1TE=;
        b=pS5SodMoU4hQS4XknHVjinNRjg577EauBYA6bS5qrDsjfMvBJvYU21NvSHcjUOBVPS
         612iHeuvowrJW9LiJ5jXaZPZC5MJ4jchKgXxq6vJte8QSlI/Xi2dLNoQd3WqefxWLCJN
         BxdF6/o0jab2c2P2IVGxMcXlpYeCm4gRjhZTkr9HRhgGz8Ez2IW1lBOgDUTdl6FU+kBD
         Ox6vBglTUlQvT5PxIlvHBbqRWzmXYuStvL7U6Br1F9wcRz7+y22Yxs7PwRk7X/1lPVm2
         P3BtctD056FcgzakKCLlvZOmKHkOvH1fD61L4SL+ECnH1qq/8MAaXE+wtYdzrKSPVhjt
         5Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=0mFuBwdVPqFlV7N56fSA5adSdmVH4jP4hL7xdmNu1TE=;
        b=TIdeTdx333GWTm6kFut3AG8CpXu5+vkVSIlsdB6TrR/uNCdWcQe5KwxUuK/wCkQFxl
         aiijykmatuALeSkdA5CllmoV/L4IThUGs+y37xh9odIhSads97BnD+DE0aNViKX0QN74
         KH+9PUhRWEScLtliTy9taLtRjmauymgTn0ayJBm/yIxV0HPLvWLkoP8kZnsG+U+d0qKa
         9D1bWcENTvsJ8HLdaXBuOQjMugYWG8M1AaYUKUyzvv1ABrp7APQaUp5h4Sa35uRDKfmI
         vs41MmG4HB0H6x4saHbNjmmJ0yRKlfqZMzRHUG55cJ6iwKDDDeqf+wQDDLCFTMdRSjBV
         zgRw==
X-Gm-Message-State: ACgBeo1zWBC1xadl1tJLc4u3EzZZZ9H9MiYN5idJH86eKwVNmJahxz6X
        aRpQQi3/ARPYfmfCbCxbV4M=
X-Google-Smtp-Source: AA6agR5S4uhyQ3nI0Nn/eQye9nDWyDILAYvxeXbLOBdagee4RU0xBAuPKCS25E29hPDFJj6Jesoy4w==
X-Received: by 2002:a17:907:6e08:b0:731:83a3:58b6 with SMTP id sd8-20020a1709076e0800b0073183a358b6mr2027569ejc.12.1660293189500;
        Fri, 12 Aug 2022 01:33:09 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709066d1100b007305b8aa36bsm538022ejr.157.2022.08.12.01.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 01:33:08 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 12 Aug 2022 10:33:06 +0200
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        like.xu.linux@gmail.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 2/4] tools headers x86: Sync msr-index.h with kernel
 sources
Message-ID: <YvYQQr5VenglbpWM@krava>
References: <cover.1660217326.git.sandipan.das@amd.com>
 <ffb9a9f0aa46a4339bb61282e26810112700ae97.1660217326.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb9a9f0aa46a4339bb61282e26810112700ae97.1660217326.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 06:16:47PM +0530, Sandipan Das wrote:
> Sync msr-index.h with the kernel sources by adding the new AMD Last Branch
> Record Extension Version 2 (LbrExtV2) MSRs.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  tools/arch/x86/include/asm/msr-index.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
> index cc615be27a54..7f9eaf497947 100644
> --- a/tools/arch/x86/include/asm/msr-index.h
> +++ b/tools/arch/x86/include/asm/msr-index.h
> @@ -574,6 +574,9 @@
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
>  
> +/* AMD Last Branch Record MSRs */
> +#define MSR_AMD64_LBR_SELECT			0xc000010e

curious do we actualy use this in tools somewhere?

jirka

> +
>  /* Fam 17h MSRs */
>  #define MSR_F17H_IRPERF			0xc00000e9
>  
> @@ -745,6 +748,8 @@
>  #define MSR_AMD_DBG_EXTN_CFG		0xc000010f
>  #define MSR_AMD_SAMP_BR_FROM		0xc0010300
>  
> +#define DBG_EXTN_CFG_LBRV2EN		BIT_ULL(6)
> +
>  #define MSR_IA32_MPERF			0x000000e7
>  #define MSR_IA32_APERF			0x000000e8
>  
> -- 
> 2.34.1
> 
