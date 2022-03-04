Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1A4CDD27
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 20:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiCDTK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 14:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiCDTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF0E8207A39
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646421003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G2sZk6dLYdhFwcKdrdyqy6nboj6tlidLKSDaiBbFpCU=;
        b=dIt0nngKrgHNWb/1zJZFW13q139gD2u46rt9LFw/c+AmYI64wfOM/SLtkcMMFD1lE6suoh
        uUjhrFSqKVR2mgyTjHJvDyc4S3+RLwfthvsLhg4oWR+IQdl+b99t3kCiUSiJgUR1JKUhVe
        kvYQAOA3RSNrwKagm5SIGm6YLL/0LCI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-HqTcDkbfNHKA_9e_fH6jQQ-1; Fri, 04 Mar 2022 14:10:02 -0500
X-MC-Unique: HqTcDkbfNHKA_9e_fH6jQQ-1
Received: by mail-ot1-f69.google.com with SMTP id q2-20020a9d5782000000b005ad0c39a8b5so6494297oth.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 11:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G2sZk6dLYdhFwcKdrdyqy6nboj6tlidLKSDaiBbFpCU=;
        b=LX4uYtPQQuSUrnZ/tcyF0pZq03yUYz26p1+RUKTRAiKM4vdHma6oLO1qUGQo+U9tcM
         ZUizkmomWX3QHHKuTfoGXkSXDSSzV4ruW3NgsukghnUSny9CT75Mwo+tsjSNeclYuHho
         MNuQMEHU3mUrXmSBoGIWcfHJQ7d9e8jTfjiRV3hZzDSyX8BuIPiW1avYHwXBiV25kflU
         iJYbvxMHkg1UdoUo04Ct6Uv04vc9fNvmrPC4mEiugFd/3UKHzcPWxhIHTBYKYehkN2Hj
         tPhL3qA+3ufCR5lNBRY8s79RdvOdarvFN4zi1SEGL5q76O2/tNu4rUb+dSNFa+C6D1Tg
         4PqA==
X-Gm-Message-State: AOAM533HxCjkfoJloLC32Xk4jlNo+LsNApG8Qnnb9569mE09wkXZUD80
        +8urrDyMPPZPW8RHwfHzR83DzKCucflseXA2Z+P72BTnevDom94sFf8jw3WLXD35N4RrGAK2heu
        bJ8B+sP6FxeJ5DrPhtV/05c6X
X-Received: by 2002:a05:6870:8892:b0:d9:f80f:73b4 with SMTP id m18-20020a056870889200b000d9f80f73b4mr1110oam.59.1646421001824;
        Fri, 04 Mar 2022 11:10:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlsjDjrgK7z3zsDtyPvK9ZGrXfNbSX7xTjQcfV1WGBWOThRmAUXfrw04u6LH2YKktmugIA0Q==
X-Received: by 2002:a05:6870:8892:b0:d9:f80f:73b4 with SMTP id m18-20020a056870889200b000d9f80f73b4mr1087oam.59.1646421001536;
        Fri, 04 Mar 2022 11:10:01 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id e29-20020a4a91dd000000b002df9015e234sm2723205ooh.41.2022.03.04.11.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 11:10:01 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:09:58 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 00/39] x86: Kernel IBT
Message-ID: <20220304190958.comlw5wt7zdgeakc@treble>
References: <20220303112321.422525803@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303112321.422525803@infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:21PM +0100, Peter Zijlstra wrote:
> Hi, another week, another series.
> 
> Since last time:
> 
>  - fixed and tested kexec (redgecomb)
>  - s/4*HAS_KERNEL_IBT/ENDBR_INSN_SIZE/ (jpoimboe)
>  - re-arranged Xen patches to avoid churn (andyhpp)
>  - folded IBT_SEAL Kconfig and objtool options (jpoimboe)
>  - dropped direct call/jmp rewrite from objtool (jpoimboe)
>  - dropped UD1 poison (jpoimboe)
>  - fixed kprobe selftests (masami,naveen)
>  - fixed ftrace selftests (rostedt)
>  - simplified CET/INT3 selftests (jpoimboe)
>  - boot time msg on IBT (kees)
>  - objtool WARN_FUNC sym+off fallback (jpoimboe)
>  - picked up tags for unchanged patches
>  - probably more
> 
> Supposedly clang-14-rc2 will work on this series, I'll validate the moment the
> Debian package gets updated.
> 
> Patches go on top of tip/master + arm64/for-next/linkage. Also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

I'm getting some warnings with CONFIG_X86_KERNEL_IBT=n:

  arch/x86/entry/entry_64.o: warning: objtool: irq_entries_start()+0x7: unreachable instruction
  arch/x86/kernel/ftrace_64.o: warning: objtool: return_to_handler()+0x2a: unreachable instruction

And a warning with CONFIG_X86_KERNEL_IBT=y:

  vmlinux.o: warning: objtool: .text+0xaf0: unreachable instruction

And if I remove the per-file limiting on "unreachable instruction"
warnings, I get a boat-load more warnings for vmlinux.o.

The last two patches (IBT sealing) aren't going to be viable until all
the "unreachable instruction" warnings get cleaned up, because that
means we have missing coverage.

-- 
Josh

