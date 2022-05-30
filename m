Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD2537B39
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiE3NRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiE3NRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:17:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57EF3B578
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:17:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bg25so6350001wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2loAziqNhERzkIv8i37duQw2j1y8JUfAmT6kjwPqZ0=;
        b=KwYYKWhlIhh3l4N4cICO7brn1+7OxGWaU4COumZbiBwZ4VFqp9u+wX9k+G0YbVlMnE
         3F5WC/OoMM/slLp6rWmD1EGyIoYSFxtB0y4jzGXkaaXvnu2o+yFViteuX1pN/OpRgBk7
         UGoWAnxh08Y4zajj/5UCs1PfQrDB7f6QlAZy908BPsrikp+qWkykweT6+7deCm/IDFWD
         atIfN78IfE9SJqpCyeyNHL4cxzi4WbesQTBmMI3Xuwy+dE0AD7tDZk7x8DBFGpPNOeqb
         2zS/8lMS9PkNW8tL2GaUQHMOmHKz1EiA6QCNOZRIdTSIBVPzL8eguuKPuNlSem8y02zp
         G0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2loAziqNhERzkIv8i37duQw2j1y8JUfAmT6kjwPqZ0=;
        b=YQxTKrVt/uxXCPFycIlflOZEfuNk+L4g7E+dCG2qwEfd2TkyS1HnkdKBZq7bLCS0jv
         MXqjBzSX1+LXwx3C4uewutlPtLcYnteC+fqeYneePf4yP0ed0KlLHvvFaK7DO5wUwgNv
         C9MGNLuhZTfmuUVHwXVajVuTQVRUTl+8UoP/wr/vbhTQtiSMWGuXAEfyr9V5h6OJRdWR
         3L5gmZaOhVnZrPTnQb0ahghHBH5bia+Azu56HPR+8vh1MDBCWsLcr1W+fNpgWLjKFgjD
         3Za3iT9eG0YI0H0WQP5VMSM0CSaRHBAg+Fpo7fdbY3m0M6UhP6Tgk+7hmAixgp8UD2UU
         7XoQ==
X-Gm-Message-State: AOAM530q+VeVIV0K5Hi0p65nvxSViddQmryEjCQ3kWkDVInu3ESnVVfb
        LFwaaJEk7wRGXdwsFrsV12qI3w==
X-Google-Smtp-Source: ABdhPJxq1wtbPgPiWsaIvF0LsfgvrATmkZbeRau6FYu3krMyKIizLBhqo+Ag/CWDZ/RyBV1Zd+hM1Q==
X-Received: by 2002:a1c:f20f:0:b0:39c:388:f22a with SMTP id s15-20020a1cf20f000000b0039c0388f22amr5403146wmc.52.1653916656269;
        Mon, 30 May 2022 06:17:36 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:c918:d0ea:5b07:e1c3])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b0020cd8f1d25csm9213648wrv.8.2022.05.30.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:17:35 -0700 (PDT)
Date:   Mon, 30 May 2022 15:17:30 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        mark.rutland@arm.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/7] objtool: Mark __ubsan_handle_builtin_unreachable()
 as noreturn
Message-ID: <YpTD6k95/4dShUl1@elver.google.com>
References: <20220526105252.440440893@infradead.org>
 <20220526105957.879581277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526105957.879581277@infradead.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:52PM +0200, Peter Zijlstra wrote:
>   fs/ntfs3/ntfs3.prelink.o: warning: objtool: ni_read_frame() falls through to next function ni_readpage_cmpr.cold()
> 
> That is in fact:
> 
> 000000000000124a <ni_read_frame.cold>:
>     124a:       44 89 e0                mov    %r12d,%eax
>     124d:       0f b6 55 98             movzbl -0x68(%rbp),%edx
>     1251:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1254: R_X86_64_32S      .data+0x1380
>     1258:       48 89 c6                mov    %rax,%rsi
>     125b:       e8 00 00 00 00          call   1260 <ni_read_frame.cold+0x16>   125c: R_X86_64_PLT32    __ubsan_handle_shift_out_of_bounds-0x4
>     1260:       48 8d 7d cc             lea    -0x34(%rbp),%rdi
>     1264:       e8 00 00 00 00          call   1269 <ni_read_frame.cold+0x1f>   1265: R_X86_64_PLT32    __tsan_read4-0x4
>     1269:       8b 45 cc                mov    -0x34(%rbp),%eax
>     126c:       e9 00 00 00 00          jmp    1271 <ni_read_frame.cold+0x27>   126d: R_X86_64_PC32     .text+0x19109
>     1271:       48 8b 75 a0             mov    -0x60(%rbp),%rsi
>     1275:       48 63 d0                movslq %eax,%rdx
>     1278:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        127b: R_X86_64_32S      .data+0x13a0
>     127f:       89 45 88                mov    %eax,-0x78(%rbp)
>     1282:       e8 00 00 00 00          call   1287 <ni_read_frame.cold+0x3d>   1283: R_X86_64_PLT32    __ubsan_handle_shift_out_of_bounds-0x4
>     1287:       8b 45 88                mov    -0x78(%rbp),%eax
>     128a:       e9 00 00 00 00          jmp    128f <ni_read_frame.cold+0x45>   128b: R_X86_64_PC32     .text+0x19098
>     128f:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1292: R_X86_64_32S      .data+0x11f0
>     1296:       e8 00 00 00 00          call   129b <ni_readpage_cmpr.cold>     1297: R_X86_64_PLT32    __ubsan_handle_builtin_unreachable-0x4
> 
> 000000000000129b <ni_readpage_cmpr.cold>:
> 
> Tell objtool that __ubsan_handle_builtin_unreachable() is a noreturn.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20220502091514.GB479834@worktop.programming.kicks-ass.net

Acked-by: Marco Elver <elver@google.com>

> ---
>  tools/objtool/check.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -185,6 +185,7 @@ static bool __dead_end_function(struct o
>  		"stop_this_cpu",
>  		"__invalid_creds",
>                 "cpu_startup_entry",
> +		"__ubsan_handle_builtin_unreachable",
>  	};
>  
>  	if (!func)
> 
> 
