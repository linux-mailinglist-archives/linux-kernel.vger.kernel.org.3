Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859AF4C3A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiBYAuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiBYAuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7760C2556CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645750186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+uLI1z9m6cGQimOUq+y8yAOwmkRmaC68D8Jcjr3NNY=;
        b=czPepapLm1vgfOlwYEqZmV4cJQ17oNweRaopwsM2oxNrQkFpfLY+hRFJkpz9U+8djjx2EK
        g++Y1P2+ffjY0EvHnwauWgrSTVD5jKXIoGft42kQHytmR7YM53Aaj1ROoIvs2NABLqCh8k
        G6DfYmPTE7AZcv5cVcqwBZpSI/7wreI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-XNdtBMQiNl2-MYp2AvRyeA-1; Thu, 24 Feb 2022 19:49:45 -0500
X-MC-Unique: XNdtBMQiNl2-MYp2AvRyeA-1
Received: by mail-qv1-f70.google.com with SMTP id cg14-20020a05621413ce00b0042c2706a4beso4454850qvb.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+uLI1z9m6cGQimOUq+y8yAOwmkRmaC68D8Jcjr3NNY=;
        b=V8Qb8+IZFD93RivfGi4OZKzNnLG+J/Vr3rtbg2ZPTDcjHljfJLq4kbH3+yGynfliGy
         cPhk9rFZEcSfIMlQlzoOavOKOuQEtEG39SPgU7pUTdQU3ruu0O9d+2AQuWp/Mrsgxp2U
         dG1Nx5sme9s7NoAZf85w/mdKzo8IfNDxHlAlT0eUNkksadjNuUC7SZCjZdbQOVN/G5d4
         du68gs6TCty7JX6pi9fd3/tyQFStgfd/kdYqMQ5V1ZOwgUQ5xGx6btCiFCXIFQQlKUZo
         WpL+zQ2B6gH+IWl9J+JaeLsGeW6yQ1MhoVIhUaNsYmzoCLB8vPqGnP91AteS+miWJ1s3
         /4lw==
X-Gm-Message-State: AOAM53103k2etXKpjHHHZWkNpYtE0nhMO2jdr9kk69pOvC0AMsRE9FV/
        V35CihEecohi3u1aldonsPkpBRGTJLP00dlFePis/CkG3TDC6FIWJL8TjBoPbq5XrIQPJCfBD2H
        EERAzQKAoH8sSRnAZ2w259zhh
X-Received: by 2002:a37:9646:0:b0:649:1d3f:f1d8 with SMTP id y67-20020a379646000000b006491d3ff1d8mr3336084qkd.729.1645750185050;
        Thu, 24 Feb 2022 16:49:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGIKxRrOjnhC0nS8SnB+/6lu1ShSi8TvITyPKdG2f1rsAXmbAXmub2DdSdYJViR5ZpMYwQmg==
X-Received: by 2002:a37:9646:0:b0:649:1d3f:f1d8 with SMTP id y67-20020a379646000000b006491d3ff1d8mr3336076qkd.729.1645750184828;
        Thu, 24 Feb 2022 16:49:44 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id u26-20020ae9c01a000000b0062ce6955181sm552230qkk.31.2022.02.24.16.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:49:44 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:49:40 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 24/39] x86/text-patching: Make text_gen_insn() IBT
 aware
Message-ID: <20220225004940.vjchjwghtf3laolu@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.421937384@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151323.421937384@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:52:02PM +0100, Peter Zijlstra wrote:
> +	/*
> +	 * Hide the addresses to avoid the compiler folding in constants when
> +	 * referencing code, these can mess up annotations like
> +	 * ANNOTATE_NOENDBR.
> +	 */
> +	OPTIMIZER_HIDE_VAR(addr);
> +	OPTIMIZER_HIDE_VAR(dest);
> +
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	if (is_endbr(*(u32 *)dest))
> +		dest += 4;
> +#endif

Another unnecessary ifdef.

-- 
Josh

