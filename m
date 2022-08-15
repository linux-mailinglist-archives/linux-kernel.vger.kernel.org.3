Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97C59403D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiHOVX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbiHOVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:17:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E987E58B56
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:20:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l5so6198707qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nWWEkKmSWnkiiy7izskbbW/D3F+ai2DNKOALKhXWG58=;
        b=Q+lR3j7XMHncwQKjvVizFCVhptT2wAkxQ5WP4Vm9d7Ve1iU/nluBn4VgyQ1LKBw3GN
         y52YyiniQ2XwvERCQR8ZtSu6jFs7CBpOP/7amWa0XbR6s3IHXPAyGisMQAmL/N2EkKTA
         2mEAoVQePhhbclw0+7IE8QxXpjAcLcOdXmj0E3v3EcbufXUO3NAZThDTXMjhgPZU5OH/
         Q9ku6RyWxdDjpyXxKGcnXPCGsWSW1rUnOy894nd08RV0ckFJIg9osYXYShH3lpuUV0il
         056+gvm3WEG0zQLQlqUVMe72BiAbuV/XT/0cRZ7GtGCmpvH5slAC0gRfEngfdONlSCOm
         Vo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nWWEkKmSWnkiiy7izskbbW/D3F+ai2DNKOALKhXWG58=;
        b=qipqftxcLZIr6R0CKcVzKqgoeAGi6eNYzwhVfwZ9fJjcoEpVOVL6qJS+LUlMmcFhpO
         Z93OHd/4BBRs1GlWTZ2b4CDdtcxLGsGVIyLlOPfClOJ8AOw9knZKGo2L+cvFYqKFkamW
         NGLm+slQhxdP6gSTNST8bTlOiXFFsHT3WwSZAoj5Kit94p9ganOx0flnIWG869CRyVZq
         7qWmdAGMKuxSPBJviECQSeck3EVq1HVZwFxQ9T8kKugiOufeeYZYfR5PZJRX9sDekcs2
         UEeUCzschWLYYWtc5VMSbqexuqwaEybfenWtmW+hHMXTcJtcITfgpekbQBf5R4pIGCSM
         zBLg==
X-Gm-Message-State: ACgBeo00SBL3qyCrf9i24/P2ewQsfk0I/7OOFStK7kgf5+BD5MRATIkq
        CkVePFUKp6STOXHUZQz+qBtndv5gvad3VGhr2hFX1r2ZQIU8aA==
X-Google-Smtp-Source: AA6agR6DqfhPz6GTIOlcUAsYF3qsJEJzQ53rL8tIr+uvAiEkMDyI4i60c5howf2bzhpVTY9Tfc0lCcgMdx7pgJof35U=
X-Received: by 2002:a05:622a:205:b0:343:282:3d0e with SMTP id
 b5-20020a05622a020500b0034302823d0emr15445268qtx.436.1660591257986; Mon, 15
 Aug 2022 12:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712144917.4497-1-ubizjak@gmail.com> <20220814184823.c6ca2c396db0d8817e518ef9@linux-foundation.org>
In-Reply-To: <20220814184823.c6ca2c396db0d8817e518ef9@linux-foundation.org>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 15 Aug 2022 21:20:46 +0200
Message-ID: <CAFULd4YuYhNmhx3tBwBeR=ascfy=BZfZKk4e7vMq6gy06zk41Q@mail.gmail.com>
Subject: Re: [PATCH] llist: Use try_cmpxchg in llist_add_batch and llist_del_first
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 3:48 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 12 Jul 2022 16:49:17 +0200 Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > llist_add_batch and llist_del_first. x86 CMPXCHG instruction returns
> > success in ZF flag, so this change saves a compare after cmpxchg.
> >
> > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when
> > cmpxchg fails, enabling further code simplifications.
> >
> > No functional change intended.
>
> Well this is strange.  Your innocuous little patch:

[...]

> Does this:
>
> x1:/usr/src/25> size lib/llist.o-before lib/llist.o-after
>    text    data     bss     dec     hex filename
>     541      24       0     565     235 lib/llist.o-before
>     940      24       0     964     3c4 lib/llist.o-after
>
> with x86_64 allmodconfig, gcc-11.1.0.
>
> No change with allnoconfig, some bloat with defconfig.
>
> I was too lazy to figure out why this happened, but it'd be great if
> someone could investigate.  Something has gone wrong somewhere.

Sanitizer is detecting a comparison with a constant and emits:

 132:    f0 48 0f b1 2b           lock cmpxchg %rbp,(%rbx)
 137:    41 0f 94 c6              sete   %r14b
 13b:    31 ff                    xor    %edi,%edi
 13d:    44 89 f6                 mov    %r14d,%esi
 140:    e8 00 00 00 00           call   145 <llist_add_batch+0xc5>
            141: R_X86_64_PLT32    __sanitizer_cov_trace_const_cmp1-0x4

Since a new call is inserted, the compiler has to save all
call-clobbered variables around the call, this triggers another call
to __kasan_check_write. Finally, stack checking is emitted for patched
functions.

Without sanitizer (make defconfig), the code is as expected, with a
couple of bytes saved due to unneeded mov/cmp.

Uros.
