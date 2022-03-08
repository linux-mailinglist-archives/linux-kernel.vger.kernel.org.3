Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28974D222C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349830AbiCHUHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiCHUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 426B14A3F2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646769980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elipnysKnwVcUg6EqGSfkpdeNGiB7Z2+ASCRq74nOM0=;
        b=SaeCvK65zMQ/dgdtSH9qi1mGe+s96wHlfbq6aghDfxaYANYxPK/fd3yNkAfL3wTL/Mq8rl
        gMgZFfddmrlkDr+DiskFRXfsL/zrEj0Sywt+XZ2wgkxgRdt4nrG+DZNu+cF4oDkh+bUj07
        8HKBV+M/JdJghCKsUIszeg7zZeTjhlw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-vv824g7oMzucns72dXYANQ-1; Tue, 08 Mar 2022 15:06:19 -0500
X-MC-Unique: vv824g7oMzucns72dXYANQ-1
Received: by mail-qk1-f198.google.com with SMTP id m123-20020a375881000000b0067af33d4ac1so17677qkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elipnysKnwVcUg6EqGSfkpdeNGiB7Z2+ASCRq74nOM0=;
        b=j2kOD/rjEi/n8T1qPOxQ0N8/TKUOvmJhskgbGS5EjCypslnxfH0Eo9d123dYZ/jVWQ
         ctVfI42nzGpHHhOdzy1rCsr3ihyhoS8Qd4ZC3XWX+LkuoK21ElnrYHmdN3hYmjFcncBT
         v0IUj7snqgMZMSILZsnLQ0wpw17i7+ddN1SD47i5ASBN1OQ+y3ckhzEoNiyYPYcWdnD8
         uzeoiPbS2EskUyNwKd6+0HVyQfFdocZe7WsfyPajncWcRx1qaJF1FmBNRUq2KMw83CcX
         uFoiIURcjQiP2k+GAL9HwH0XLqMMP7TATX/lzMHmLrnFM0Ahgqs8a0En53/X2k7NBGH6
         kC9Q==
X-Gm-Message-State: AOAM533+0Q9htnYi81hTZW3oHq/X8r/4hI3Xu05A2y//a7dF2OSD/rd5
        kHOS4m4zqOSewxMAU9VsOMbk1HNIrdUS9dNS6lhrewCNsh+0KSfHZqsMrdyc8fs9EXGnrteaiBZ
        HVQp9varqi8AUqzIwRGi0ssGm
X-Received: by 2002:a0c:c3c6:0:b0:42c:17e4:9a75 with SMTP id p6-20020a0cc3c6000000b0042c17e49a75mr13650526qvi.124.1646769978829;
        Tue, 08 Mar 2022 12:06:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzR3zmfz6FSXYwcl0bR5o15WDFhgLy2+B4pN+kytJHPEwLsbYJh8A0UHtJyjVFIP+c4N/FJXA==
X-Received: by 2002:a0c:c3c6:0:b0:42c:17e4:9a75 with SMTP id p6-20020a0cc3c6000000b0042c17e49a75mr13650497qvi.124.1646769978497;
        Tue, 08 Mar 2022 12:06:18 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id t207-20020a3746d8000000b0067b33b6a4efsm2547341qka.21.2022.03.08.12.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:06:17 -0800 (PST)
Date:   Tue, 8 Mar 2022 12:06:14 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <20220308200614.gyhp657bdq3rxapl@treble>
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308153011.021123062@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 04:30:11PM +0100, Peter Zijlstra wrote:
> Hopefully last posting...
> 
> Since last time:
> 
>  - updated the ftrace_location() patch (naveen, rostedt)
>  - added a few comments and clarifications (bpetkov)
>  - disable jump-tables (joao)
>  - verified clang-14-rc2 works
>  - fixed a whole bunch of objtool unreachable insn issue
>  - picked up a few more tags
> 
> Patches go on top of tip/master + arm64/for-next/linkage. Also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

<applause>  Nice work!!!  kernel shadow stacks next? ;-)

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

As talked about on IRC there are still a few outstanding issues, that
I'm fine with fixing after the merge window during the upcoming -next
cycle:

- xen hypercall page functions need 'ret' - (I think you already fixed)

- why don't unreachables need to fill up the entire sym hole?

- get rid of the 'c_file' hack

- improve cmdline option intuitive-ness

- properly integrate the retpoline "demotion" with the new Spectre BHI
  related patches - probably still needs more discussion - for example
  we might instead want to disable IBT and warn

-- 
Josh

