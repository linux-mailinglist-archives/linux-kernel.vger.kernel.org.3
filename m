Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E804E9BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiC1P4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbiC1P43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:56:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1E4CD68
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:54:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id x20so26657872ybi.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31O2LB6AcOml2RvdEO4cG6BOTLKDOLVfeCmGtEajMX8=;
        b=S98nLmUUrDhBhHegmQ5svh/O0gzKAdC3PNpDyhpSw32nh071Ot7mN3sU4DnO2NbkGT
         jCUnY1si56ypC/v3LdAd5DDzfonYfJNRsJJ7ewOzYNOMA95Nkx994w+O4JPfBIgD0A4i
         Xia5QSO1bXP1+O1OMGgPD8DY/8GLSmc1axTuYAh/qFy1eQ29TKEM2UT6xZPQU/0NaZrz
         rdT3B+SCmeBv1bzWbyyfPS629Vm+Q0cklx2lR9kpsMEgZh65GUpqEV0ih08QEaqnSPln
         tG8ZsPJ5RC4DjeEmnRPgSjWsg5a1eQwc7g1Q16uhkzMmepJxMgpg9drYPFqvUEB1GUiw
         MViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31O2LB6AcOml2RvdEO4cG6BOTLKDOLVfeCmGtEajMX8=;
        b=sdhRbLxdYBXBTQJ9a7FRUkZV25pfwj8uo5QvCGTO3DmiXpG1JdoQHAkoE1cifDYXLt
         nLchO40GprHDfOWc1Yk7pDpr0fJxppaLjkaBeysKQVarkhz1zRmjZCfra6Ab1kCpdiwZ
         akbo+0L+OJgw5YWRSsSE/1qe0DUl4AMx1W68qIOJJc6Vpm0q+nPRVXCxkVp0OEt4Ckkx
         q/Kfyjib+Grms4pvGTtudD9lI0/TzyOdsBMTXyvknVW92zBW3cymHzG5C5FR+YPZIffe
         SMWKIyeZb6YGXDNh9dEjU5VvPrS9NE6LbncjP6xy98+nqgXw9MzW1pf67WW9lYyxCP3h
         DQ5g==
X-Gm-Message-State: AOAM5336OKMO7BFiuhnBdnJ5sUsgmP/GpdCVoVqcVhg6UqgHCPsFOkYv
        XByNKTHjkOMBitI+QCRrZJo1NVtIMcfIgCcGA+hGtA==
X-Google-Smtp-Source: ABdhPJzXbFEqKHmcIxRIlfeH0PTYtoH4ZUZ9rq3o2b2Qr7LYC3v04DKb1Lgb4m2+iRheFiZfoS8MtkQkEqQ61wPtDVo=
X-Received: by 2002:a05:6902:70c:b0:634:73ef:e663 with SMTP id
 k12-20020a056902070c00b0063473efe663mr24680640ybt.246.1648482888370; Mon, 28
 Mar 2022 08:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220328132843.16624-1-songmuchun@bytedance.com>
 <CANpmjNO=vMYhL_Uf3ewXvfWoan3q+cYjWV0jEze7toKSh2HRjg@mail.gmail.com> <CAMZfGtWfudKnm71uNQtS-=+3_m25nsfPDo8-vZYzrktQbxHUMA@mail.gmail.com>
In-Reply-To: <CAMZfGtWfudKnm71uNQtS-=+3_m25nsfPDo8-vZYzrktQbxHUMA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Mar 2022 23:54:12 +0800
Message-ID: <CAMZfGtVkp+xCM3kgLHRNRFUs_fus0f3Ry_jFv8QaSWLfnkXREg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: fix objcgs vector allocation
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Mon, Mar 28, 2022 at 11:43 PM Marco Elver <elver@google.com> wrote:
> >
> > On Mon, 28 Mar 2022 at 15:28, Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > If the kfence object is allocated to be used for objects vector, then
> > > this slot of the pool eventually being occupied permanently since
> > > the vector is never freed.  The solutions could be 1) freeing vector
> > > when the kfence object is freed or 2) allocating all vectors statically.
> > > Since the memory consumption of object vectors is low, it is better to
> > > chose 2) to fix the issue and it is also can reduce overhead of vectors
> > > allocating in the future.
> > >
> > > Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
>
> Thanks.
>
> >
> > Btw, how did you test this?
> >

I have tested it with syzkaller with the following configs.
And I didn't find any issues.

CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=10
CONFIG_KFENCE_NUM_OBJECTS=2550
CONFIG_KFENCE_DEFERRABLE=n
CONFIG_KFENCE_STATIC_KEYS=y
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
