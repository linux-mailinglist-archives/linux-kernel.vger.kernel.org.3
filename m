Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5515C4C781E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiB1Sl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbiB1SkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:40:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94C2424596
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646073155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1t6rYRbTMQR99dgTTwzmR0JbGj6Nz3pGfTv0NpS6LGk=;
        b=CEDg+T4L1Me93wwUV5hyx74ud/Wtv08W9uUudIt69IBCyeLwy9w+V1+ZdYts+ymWN/N4N5
        4+XW74MNufYIU4ZKS1W2TbZZxJp8U/43g9I9RrzqVogMB10XmdXTygN/8uadIExuqGQegj
        cDWTpDGkBpiAuf3Oe+jdsPPUMVJKcLM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-GiTrhr1UNDGgPCkH4G3DCw-1; Mon, 28 Feb 2022 13:32:33 -0500
X-MC-Unique: GiTrhr1UNDGgPCkH4G3DCw-1
Received: by mail-qv1-f69.google.com with SMTP id z3-20020a0cf003000000b004328f6a7131so12538127qvk.19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1t6rYRbTMQR99dgTTwzmR0JbGj6Nz3pGfTv0NpS6LGk=;
        b=yqmAlOOrb5qndGdmC8F7h915UYADMlx8549/0eHf/DNPlGWXGaXj2DFK3zcYShorVP
         0Kh8EYSj/WD0Vdg/5qs6v8oqi9LKINs2lnHvJj2UeL0i4xaEC7YZVYQxvFBQ9Bj6MOIg
         GXemjeOsnT/r7ZNWrLRdOBxLc7WsSNiPpnG5tBZGp9RoftXkxoG9WuCCQN/DxDoLXuN8
         v1A9Yv2uvhlMUkalQa6j/IGU5E+TqZ8mYVJ9QcQD45yg1XFBxzZ76yeS0XGDylu1bhKR
         KIXngILUoZ8aiqm+7YYg9fiX1lXmxzIUorShfT71D6LE14rstP63CXT+sMzCvfZ8sYCt
         sSzA==
X-Gm-Message-State: AOAM530LWlvXthQ9Z/pSEBV2UVF9WJzcu8uwDx2Axz6tPKiU5LQBYXoy
        G1zhcd11aXvkZDvhlEDqdXNFP72GUC44ZplkO/gKlN3WmgHgpSXxfJC/skmHUvqS8MY0racVqRZ
        SA/OvADDHZj8ldXcmuDpiwu32
X-Received: by 2002:a05:622a:40e:b0:2df:f698:f1ef with SMTP id n14-20020a05622a040e00b002dff698f1efmr8420578qtx.595.1646073153379;
        Mon, 28 Feb 2022 10:32:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdovyLTQzK8AKram1AGlxe6VTSsqEeiNq9UKZ0U02LnVrZkEYIoDqjD8fD0kPN0rfyrV1OYQ==
X-Received: by 2002:a05:622a:40e:b0:2df:f698:f1ef with SMTP id n14-20020a05622a040e00b002dff698f1efmr8420541qtx.595.1646073153037;
        Mon, 28 Feb 2022 10:32:33 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id e9-20020a05620a014900b005084ce66b44sm5347108qkn.88.2022.02.28.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:32:31 -0800 (PST)
Date:   Mon, 28 Feb 2022 10:32:28 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 21/29] objtool: Rename --duplicate to --lto
Message-ID: <20220228183228.splleoatuxxjr5kq@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.814392411@infradead.org>
 <20220226194209.bvv3t65hhtnwltmk@treble>
 <20220226214802.4chmsrtstlerefmu@treble>
 <YhysYkcfwLr68Job@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhysYkcfwLr68Job@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 12:05:06PM +0100, Peter Zijlstra wrote:
> > It just dawned on me that "--noinstr" already exists.  But I'm
> > scratching my head trying to figure out the difference between
> > "--noinstr" and omitting "--lto".
> 
> If you run: "objtool check --vmlinux --noinstr vmlinux.o", it'll only do
> the shallow .noinstr.text/.entry.text checks. If OTOH you do: "objtool
> check --vmlinux --noinstr --lto vmlinux.o" it'll do everything
> (including noinstr).

I think I got all that.  But what does "--vmlinux" do by itself?

> Similarlt, "--module --lto" will come to mean whole module (which is
> currently not distinguishable from a regular module part run).
> 
> (barring the possible 's/--lto/--whole-archive/' rename proposed up top)

Thanks for the explanations.  To summarize, we have:

  A) legacy mode:

     translation unit: objtool check [--module]
     vmlinux.o:        N/A
     module:           N/A

  B) CONFIG_VMLINUX_VALIDATION=y && !(CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y)

     translation unit: objtool check [--module]
     vmlinux:          objtool check --vmlinux --noinstr
     module:           objtool check --module --noinstr
     
  C) CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y:

     translation unit: N/A
     vmlinux:          objtool check --vmlinux --noinstr --lto
     module:           objtool check --module --noinstr --lto

Right?

I think I get it, but it's mental gymnastics for me to remember how the
options interact.  It still seems counterintuitive, because whatever
"objtool check" does to a translation unit, I'd expect "objtool check
--vmlinux" to do the same things.

I suppose it makes sense if I can remember that --vmlinux is a magical
option which disables all that other stuff.  And it's counteracted by
--lto, which removes the magic.  But that's all hard to remember and
just seems weird.

There are a variety of ways to run objtool against vmlinux.  The "lto"
approach is going to be less of an exception and may end up being the
default someday.  So making --vmlinux do weird stuff is going to be even
less intuitive as we go forward.  Let's make the default sane and
consistent with other file types.

So how about we just get rid of the magical --vmlinux and --lto options
altogether, and make --noinstr additive, like all the other options?

  A) legacy mode:
     .o files: objtool check [--module]
      vmlinux: N/A
       module: N/A

  B) CONFIG_NOINSTR_VALIDATION=y && !(CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y):
     .o files: objtool check [--module]
      vmlinux: objtool check --noinstr-only
       module: objtool check --module --noinstr-only
     
  C) CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y:
     .o files: N/A
      vmlinux: objtool check --noinstr
       module: objtool check --module --noinstr

(notice I renamed VMLINUX_VALIDATION to NOINSTR_VALIDATION)


Isn't that much more logical and intuitive?

  a) objtool has sane defaults, regardless of object type

  b) no magic options, other than --noinstr-only, but that's
     communicated in its name

  c) --vmlinux is no longer needed -- fewer options to juggle

-- 
Josh

