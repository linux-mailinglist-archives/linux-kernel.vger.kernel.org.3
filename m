Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8A4C7A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiB1UTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiB1UTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 433AE532E0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646079533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMbhGFqICXc9zz+taMDylt5/xD3hSAylr2/hy4plK9c=;
        b=GfB0GYkvn86kN+WkvxNBXUP20A5S1Dmpr5fo8ecz1URHEwDRj96cMFMeb3WuGAQOHJnzxN
        WU1lkFNPWTgJNyT+NN/C3z+obedzbGgoPeZ06VSmglcKxD+VuW6zIoMw4Xhhdl83sGzD4f
        nYxuM75gWOgAVdL9fTl8uhyf2qgce0g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-YSAedkCkM3exJrRaTyz5iA-1; Mon, 28 Feb 2022 15:18:52 -0500
X-MC-Unique: YSAedkCkM3exJrRaTyz5iA-1
Received: by mail-qk1-f197.google.com with SMTP id 3-20020a370603000000b0060de5e49129so12350406qkg.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BMbhGFqICXc9zz+taMDylt5/xD3hSAylr2/hy4plK9c=;
        b=Vl+yfjsZdJTT/OQ2VuMS+af0+Gt9A4lam1N8NAiK6L6SKJ/4gH/cz1N5/5cralTK0+
         pTZj2z04qjcYHxdLKTu6hicmRfCcbqy7lheJ/G1BTsVG0FvNlSYQA5nKpsIKKq2pMIUx
         GSxF1nR06251tLowAss0tGoe+iO5XCxhwFGdo4kJtkrCJlBexcRO3MWbHh3HXZ6lKTSq
         VXX4gm274MPwM+ifsgHHAE+d9jDoSI3jWsUmJn6jlyPAX4KHuRlUkBTYR9GwxWnXAjG8
         FE5iB4aef0iVMx9aIXtiF+mfU1YV13ENCjB6uWpN1oOlDBoTHptq0rl+tGTGea8jsOVt
         XyOw==
X-Gm-Message-State: AOAM531i8zZpBDMIPF2JrE6279jfaP1GjEMyfrrQ6gNyDzI+CziD/vTI
        iBjB89c3gME8ag0rxaqXeKFegtOKPh+Ngd332CS0Uhkz1X4UQNkwSenIxh21D5g/NQwW9KLlLFO
        ekMGpCGlc31P12oBWuh4iiB+3
X-Received: by 2002:a37:a5c6:0:b0:46c:e3c1:7216 with SMTP id o189-20020a37a5c6000000b0046ce3c17216mr12224668qke.721.1646079531631;
        Mon, 28 Feb 2022 12:18:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/kvdAcmlg00cBArw3rYuFLuKSUGwvQYCaHp2wkho9pcwAZ7Zeor1QLcXvlqB3qZnEiTioVA==
X-Received: by 2002:a37:a5c6:0:b0:46c:e3c1:7216 with SMTP id o189-20020a37a5c6000000b0046ce3c17216mr12224657qke.721.1646079531387;
        Mon, 28 Feb 2022 12:18:51 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id z196-20020a3765cd000000b0050848cdb596sm5446810qkb.101.2022.02.28.12.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 12:18:50 -0800 (PST)
Date:   Mon, 28 Feb 2022 12:18:47 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 21/29] objtool: Rename --duplicate to --lto
Message-ID: <20220228201847.x2i5frlmuwprfgap@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.814392411@infradead.org>
 <20220226194209.bvv3t65hhtnwltmk@treble>
 <20220226214802.4chmsrtstlerefmu@treble>
 <YhysYkcfwLr68Job@hirez.programming.kicks-ass.net>
 <20220228183228.splleoatuxxjr5kq@treble>
 <20220228200934.GF11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228200934.GF11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 09:09:34PM +0100, Peter Zijlstra wrote:
> > So how about we just get rid of the magical --vmlinux and --lto options
> > altogether, and make --noinstr additive, like all the other options?
> >
> >   A) legacy mode:
> >      .o files: objtool check [--module]
> >       vmlinux: N/A
> >        module: N/A
> >
> >   B) CONFIG_NOINSTR_VALIDATION=y && !(CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y):
> >      .o files: objtool check [--module]
> >       vmlinux: objtool check --noinstr-only
> >        module: objtool check --module --noinstr-only
> >
> >   C) CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y:
> >      .o files: N/A
> >       vmlinux: objtool check --noinstr
> >        module: objtool check --module --noinstr
> 
> I like the --noinstr-only thing. But I think I still like a flag to
> differentiate between TU/.o file and vmlinux/whole-module invocation.

I'm missing why that would still be useful.

> Anyway, you ok with me cleaning this up later, in a separate series?

Sure.  It's already less than ideal today anyway, with '--vmlinux' and
'--duplicate'.

-- 
Josh

