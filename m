Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9365B4ACBC3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiBGWEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243426AbiBGWEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:04:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63B1C0401C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:04:05 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i17so15369239pfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wB2wNNBjDeB7xd47LkadhfzPzcILlJMzbh4HCzVCTCI=;
        b=Fryh6FqckFDJZEwyuCJCwgBdeocLIRVy93ekHfyVJqa7hnR0uWSAGcBMO4QcjW3SB/
         8bxg0fQi1clmZEoRI5CBfZ+2c20R7hixj6PeyxjN0AsI3hJyi8tEb7awB+VP4nsZEzO5
         pU2+4EZb8Xo8ZyXtok3JNVPZk79fkxnYdm+YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wB2wNNBjDeB7xd47LkadhfzPzcILlJMzbh4HCzVCTCI=;
        b=08oIZHMQwfHl7gjO097a+j8KJ65EYxWcSroic1fvbVXb88gBt/XSO1E9ZdX7b66Si3
         6r8zSR58SVmFbsVObBtzKyEN/xy62f8L64cBrB96l5aaPO8YsGda1PjTxUCZhfx7U2OV
         Vr9sDebqT+ZReMtkJzeJNKPFo0lgbjzuY5a1ozIK+UBFF7BOWcuoguxqvX6/CrYY9js6
         rpZfwSUn9RGlqnQQKS4AH3OAmfPpgZbEuClyIy/QAoMCvQxuGdURzT6fjePF7/D0d0oG
         n91Z0aqMWXu0JH+5qNSw+L7NynzUm7tTHg2/QiD4iGUmtpWldYS8Ru3w7iOcP9Hbd+DH
         ULbA==
X-Gm-Message-State: AOAM531moPpDIzT6ilgRBuOaXFCDMZ0C6JQ00hk4grfcxTwjwWJag+ma
        JItOooZOOkBtJWBSa0MKTBYzIGuUVgaNPA==
X-Google-Smtp-Source: ABdhPJxX7YuXGyZENQqivjKR5uXkPv67v+MC3taCuTHOigYx5QDCRnRqpUEZL2f3QEibkxmf7imySg==
X-Received: by 2002:aa7:81c9:: with SMTP id c9mr1514722pfn.9.1644271445300;
        Mon, 07 Feb 2022 14:04:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z15sm5735338pfh.82.2022.02.07.14.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:04:04 -0800 (PST)
Date:   Mon, 7 Feb 2022 14:04:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] x86/cpu: Allow feature bit names from
 /proc/cpuinfo in clearcpuid=
Message-ID: <202202071402.DEFD6C9@keescook>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127115626.14179-2-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:56:21PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Having to give the X86_FEATURE array indices in order to disable a
> feature bit for testing is not really user-friendly. So accept the
> feature bit names too.
> 
> Some feature bits don't have names so there the array indices are still
> accepted, of course.
> 
> Clearing CPUID flags is not something which should be done in production
> so taint the kernel too.
> 
> An exemplary cmdline would then be something like:
> 
>   clearcpuid=de,440,smca,succory,bmi1,3dnow
> 
> ("succory" is wrong on purpose). And it says:
> 
> [    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

I like the taint flag addition!

Even though it reports what it does actually clear, do you think it
might be more "friendly" to yell about unknown stuff too? i.e.:

[    0.000000] Clearing CPUID bits: unknown bit 'succory'
[    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
