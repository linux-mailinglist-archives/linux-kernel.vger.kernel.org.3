Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A424507C09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357606AbiDSVoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbiDSVoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 810D0393F1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650404491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2BuLYItnkwfQS9K8R0LN9N0nlBZ1mpVZxwoKDS2jotM=;
        b=Xw/IHqjqjCXkE67LMMj62wehy4GoN2PWyuaOco/piXS9KOELslhSNLerSdLwXwiQbbOc3s
        8rJldcyHjYv+QfU5YPpTFKgsRR0ulmYFk9ju5UEYDN+vEpO5a43BqSccnLnwdY8k7E/mO4
        etTY3Hjhd4RObPbac91dMJV0mByA1yU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-bXQLjDzPMvOPdW2o6rtokQ-1; Tue, 19 Apr 2022 17:41:29 -0400
X-MC-Unique: bXQLjDzPMvOPdW2o6rtokQ-1
Received: by mail-qt1-f200.google.com with SMTP id ay26-20020a05622a229a00b002f20573a0faso3545658qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2BuLYItnkwfQS9K8R0LN9N0nlBZ1mpVZxwoKDS2jotM=;
        b=jq1fXi8FrmNSSHdO8QADJix9hLb4HTmwDXMTxZVePc9AQ1eL9jSX8dCBeqbpxF6bNw
         RizW2fDEW27TsGKaeMq9IuLGDPLFpWqoZcqT9Ox+N1ibUoH6WPbAFdFIZu+yEbCVXfuS
         CrFxNZzN40f9EwbETIJnTb+2du+v1o5W022b2yYdBrzwuzJ3NQXacwLBZUOW8bitgDqn
         gC1ybRPFpgXE3kJspM7zosEQUywZ1EmIb11WLBJnW+R+YzYV/OGLn2hVAnwjmdaEOjWS
         Na654/TjPjO5owlXbras/XZvLucDPA0zGnXHx0LWoMJJJMCsIY+XG+gWR5D5S+IPC3KH
         N8tw==
X-Gm-Message-State: AOAM531nybUo2K2lYL5bw2N0vunEWBVIntia4BW4NmZuQDT8rQC1/R0u
        rWdlEscEdOkLlEIsdpbA8DstkVpH2n1FaHukKSwxZ/v0nMqmilEFfcMeU3bIAWGOxAoZlm+poMF
        vNuA+vKKkn/EFfbvKwVwZGh3J
X-Received: by 2002:a05:622a:1056:b0:2f1:f76a:eb6c with SMTP id f22-20020a05622a105600b002f1f76aeb6cmr10613873qte.437.1650404488962;
        Tue, 19 Apr 2022 14:41:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLOwoKeKC/NOqLifSl0qJ28u0Q4eOUIHEl/YjuVzDXYswqUfK1RL4tmll1p6668MUp83O06A==
X-Received: by 2002:a05:622a:1056:b0:2f1:f76a:eb6c with SMTP id f22-20020a05622a105600b002f1f76aeb6cmr10613860qte.437.1650404488743;
        Tue, 19 Apr 2022 14:41:28 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id w15-20020ac857cf000000b002f33f220c76sm489099qta.32.2022.04.19.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:41:28 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:41:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] scripts: Create objdump-func helper script
Message-ID: <20220419214125.hnwust76a7qay3dd@treble>
References: <fe61d8835ba60ef20920d2d0e6493748c80e4d7e.1650384661.git.jpoimboe@redhat.com>
 <Yl8SaZbqXPJQyoXB@zn.tnic>
 <20220419201435.GY2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419201435.GY2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:14:35PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 19, 2022 at 09:50:01PM +0200, Borislav Petkov wrote:
> > On Tue, Apr 19, 2022 at 09:12:23AM -0700, Josh Poimboeuf wrote:
> > > Add a simple script which disassembles a single function from an object
> > > file.  Comes in handy for objtool warnings and kernel stack traces.
> > > 
> > > Originally-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > ---
> > > v2:
> > > - require gawk
> > > 
> > >  scripts/objdump-func | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >  create mode 100755 scripts/objdump-func
> > 
> > Was that supposed to be user-friendly too?
> > 
> > $ ./scripts/objdump-func -h
> > ./scripts/objdump-func: line 16: $1: unbound variable
> > 
> > :-)

You mean you don't want to read the script to reverse engineer the usage
before running it???

> > It works tho:
> > 
> > $ ./scripts/objdump-func vmlinux rewind_stack_and_make_dead
> > 0000 ffffffff81001c00 <rewind_stack_and_make_dead>:
> > 0000 ffffffff81001c00:  31 ed                   xor    %ebp,%ebp
> > 0000 ffffffff81001c02:  65 48 8b 04 25 d0 ec 01 00      mov    %gs:0x1ecd0,%rax
> > 0000 ffffffff81001c0b:  48 8d a0 58 ff ff ff    lea    -0xa8(%rax),%rsp
> > 0000 ffffffff81001c12:  e8 39 24 07 00          call   ffffffff81074050 <make_task_dead>
> > ^^^^
> > 
> > I guess those zeros at the beginning are supposed to mean something...
> 
> Use the .o file and it'll work:

Should probably get fixed to work on vmlinux too...

-- 
Josh

