Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49004C39F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiBXXz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiBXXzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5D8F29A560
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645746922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9E09i9rW+J6vekvARH8o2H2vbvxRXniUVAYHryF0eTs=;
        b=CqIDkKfruJOTODui8H/3ap9nDOI1RFWBH3xdZveh3H2XboSKzxm5jMm7ScugLF80Bx30uL
        TJh2gY6j7gpYMvh+3INpUb9ma9fmYf23YNcLRf3GW4fWb2DGP/saYkk66x5jG16i3HoWca
        q9SUmxB6zPaSa+e/R45Zt3apRh7J3w8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534--h95dIrbPQmesoYHqu14SA-1; Thu, 24 Feb 2022 18:55:21 -0500
X-MC-Unique: -h95dIrbPQmesoYHqu14SA-1
Received: by mail-qk1-f200.google.com with SMTP id i10-20020a05620a144a00b00648d4fa059dso4256876qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9E09i9rW+J6vekvARH8o2H2vbvxRXniUVAYHryF0eTs=;
        b=LDfRCr/R7VTafGeIvdNbPPyZMSGBf5vDycoO6j+4xrXKMNCKeQuTfzNvOrdppLahW4
         toZ+158NMztOxxLS3y7Ov1+W3vGASbszp8370WnHAI/MxJM6JFlZjm1vUWRbQpFFyYV3
         HS2YqGMx33o0MJE8dEZEu67+prDOmjUQx9ndMNUtFhRw8MEgg2EUfM+qcv45QMgGni7z
         FKIO3JehwRXJPLPF5xuBhHX9KrpM903Upf04LOJZcVmB8U1+hRDOBaycABv1NGbHv68z
         EWnMeQrmr3F5r+5p1ICA5lO8HNP8YHMMVh6V/g6TTnMasIZZJYsuATINNWaKTm2Qarl2
         beoQ==
X-Gm-Message-State: AOAM532QlZ1ONxkxQ+B0M8aFS7vJrAq47HQoORRPDLnEVA4wJjlFNGkR
        Sk0gv4MPilsSHUwksDK9TcA2gwICgEq7k+G4Z5viCGCJMwYQm+DoKrpDSGGit1e1w+sYhMfjAGr
        X2q9yZ3Rbfed08fWhyUe6u3LG
X-Received: by 2002:ac8:7f01:0:b0:2dd:bab8:6885 with SMTP id f1-20020ac87f01000000b002ddbab86885mr4816494qtk.130.1645746920637;
        Thu, 24 Feb 2022 15:55:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/VsATmojth2uqM5nUm6t1vpGEWqqogoXeU81tqIBlCIjhSne2BXUb+VcNp3pgGNjqCsI86Q==
X-Received: by 2002:ac8:7f01:0:b0:2dd:bab8:6885 with SMTP id f1-20020ac87f01000000b002ddbab86885mr4816481qtk.130.1645746920419;
        Thu, 24 Feb 2022 15:55:20 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a136400b0060dda40b3ecsm509760qkl.30.2022.02.24.15.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:55:19 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:55:16 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220224235516.qdikcfdl7jo35iu6@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151323.069205370@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:56PM +0100, Peter Zijlstra wrote:
> +static __always_inline void setup_cet(struct cpuinfo_x86 *c)
> +{
> +	u64 msr = CET_ENDBR_EN;
> +
> +	if (!HAS_KERNEL_IBT ||
> +	    !cpu_feature_enabled(X86_FEATURE_IBT))
> +		return;

If you add X86_FEATURE_BIT to arch/x86/include/asm/disabled-features.h,
the HAS_KERNEL_IBT check becomes redundant.

> +bool ibt_selftest(void)
> +{
> +	unsigned long ret;
> +
> +	asm ("1: lea 2f(%%rip), %%rax\n\t"
> +	     ANNOTATE_RETPOLINE_SAFE
> +	     "   jmp *%%rax\n\t"
> +	     ASM_REACHABLE
> +	     ANNOTATE_NOENDBR
> +	     "2: nop\n\t"
> +
> +	     /* unsigned ibt_selftest_ip = 2b */
> +	     ".pushsection .rodata,\"a\"\n\t"
> +	     ".align 8\n\t"
> +	     ".type ibt_selftest_ip, @object\n\t"
> +	     ".size ibt_selftest_ip, 8\n\t"
> +	     "ibt_selftest_ip:\n\t"
> +	     ".quad 2b\n\t"
> +	     ".popsection\n\t"

It's still seems silly to make this variable in asm.

Also .rodata isn't going to work for CPU hotplug.

-- 
Josh

