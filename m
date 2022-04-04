Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910F54F1823
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378502AbiDDPU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356457AbiDDPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:20:49 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4273E1EEED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:18:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y38so18179484ybi.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VxKE2AF5CaxNXJB6azVDEKw7atOLqH2N7X5sbmlz7w=;
        b=qgvOKqP7mwT72Kdyn1pQiRXBm1hg7vV8g9aRSrPJRBem1N/PNdhCbaZFMjvQba3l0m
         /ejLnk37Q8AR/Pnqvv2j6S40dC7+fktYVmQKnKDpvE095ZhaFtR/Ln4k4zV1BYEQp1FE
         OZSrDzRnpm4Ms5Rel+ZWDk5KLGuh82BzzgPhMvDH9YW4b7fKg/DCWeCR47z2kOP82KaG
         O5Fx8Im2o/doRmeONC+aSTvCWD7ASBDNGD4gu+WFNXR3BJuWGnfGHxQOApZuMDNmNaN0
         0GDpG8i5CkGswIxCzYAx/yZxs/2HBqXQ+CX6ay/OP1Qig0XkLHQHm4Lzc5B4eqRNK87L
         OtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VxKE2AF5CaxNXJB6azVDEKw7atOLqH2N7X5sbmlz7w=;
        b=M3TUpmxhJ9mt83IGwy5pafkFYK0g99+PxFP1VvL5SJ6ILEr+2dH9QG/W3vgv6Vfd6k
         xmEQFM7zH42H9ZAgkuF1K8RZawiZh0bA8f1LFfZ26gvuv9T9Icrce/aIusbSYFvnwqSK
         NHYEtw2hhlw0NjtQZvvHtUdRbcSbU2gGpYM0Xji5n89ldZ7vKeh6PGlZCV2FiBBBELvc
         4eEfDjtHDvCLHZ8TDRDVjnlZidDtTd4JvS4znjbJMy538BlLZXT2YyTAAckwGiWtceNG
         7TDfY2QaBszoxhahMKX09U+I642dIRs9Rvp2B3NXBQwxWO1Nv5jg46e3v9tu6s+wKnlr
         0pJg==
X-Gm-Message-State: AOAM532WSbouFH4fWX886UrSgJIwSg9HmJb/8fvI6VnWo4SNe2/a/zSl
        AOJylQ1EuvOR8+bZuSOlrtSEA6orHwY49QuYLPLz+w==
X-Google-Smtp-Source: ABdhPJwf6GddFAzNwff1T7O2bqehRsev2EcIU/mkMhEyZkZKubk/JJpVqk9zSQE96tAMKHwTLfyuokDLG3uiAHKMnOE=
X-Received: by 2002:a25:9b85:0:b0:63d:ad6c:aae8 with SMTP id
 v5-20020a259b85000000b0063dad6caae8mr223324ybo.609.1649085532340; Mon, 04 Apr
 2022 08:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220323090520.GG16885@xsang-OptiPlex-9020> <20220324095218.GA2108184@odroid>
 <YkcfNjZJSXNsAlLt@hyeyoo> <YkpgjgM/aSXd29uj@hyeyoo> <Ykqn2z9UVfxFwiU+@elver.google.com>
 <8368021e-86c3-a93f-b29d-efed02135c41@suse.cz>
In-Reply-To: <8368021e-86c3-a93f-b29d-efed02135c41@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Apr 2022 17:18:16 +0200
Message-ID: <CANpmjNMupGGbTDD-ZEY=acTbqguvWgLzb1ZVRbG9TyuF50Ch+Q@mail.gmail.com>
Subject: Re: [mm/slub] 555b8c8cb3: WARNING:at_lib/stackdepot.c:#stack_depot_fetch
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zqiang <qiang.zhang@windriver.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 4 Apr 2022 at 16:20, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/4/22 10:10, Marco Elver wrote:
> > On Mon, Apr 04, 2022 at 12:05PM +0900, Hyeonggon Yoo wrote:
> > (Maybe CONFIG_KCSAN_STRICT=y is going to yield something? I still doubt
> > it thought, this bug is related to corrupted stackdepot handle
> > somewhere...)
> >
> >> I noticed that it is not reproduced when KASAN=y and KFENCE=n (reproduced 0 of 181).
> >> and it was reproduced 56 of 196 when KASAN=n and KFENCE=y
> >>
> >> maybe this issue is related to kfence?
>
> Hmm kfence seems to be a good lead. If I understand kfence_guarded_alloc()
> correctly, it tries to set up something that really looks like a normal slab
> page? Especially the part with comment /* Set required slab fields. */
> But it doesn't seem to cover the debugging parts that SLUB sets up with
> alloc_debug_processing(). This includes alloc stack saving, thus, after
> commit 555b8c8cb3, a stackdepot handle setting. It probably normally doesn't
> matter as is_kfence_address() redirects processing of kfence-allocated
> objects so we don't hit any slub code that expects the debugging parts to be
> properly initialized.
>
> But here we are in mem_dump_obj() -> kmem_dump_obj() -> kmem_obj_info().
> Because kmem_valid_obj() returned true, fooled by folio_test_slab()
> returning true because of the /* Set required slab fields. */ code.
> Yet the illusion is not perfect and we read garbage instead of a valid
> stackdepot handle.
>
> IMHO we should e.g. add the appropriate is_kfence_address() test into
> kmem_valid_obj(), to exclude kfence-allocated objects? Sounds much simpler
> than trying to extend the illusion further to make kmem_dump_obj() work?
> Instead kfence could add its own specific handler to mem_dump_obj() to print
> its debugging data?

I think this explanation makes sense!  Indeed, KFENCE already records
allocation stacks internally anyway, so it should be straightforward
to convince it to just print that.

Thanks,
-- Marco
