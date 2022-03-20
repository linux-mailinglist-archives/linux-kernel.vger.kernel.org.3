Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C334E1DDE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbiCTVLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbiCTVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:11:11 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1C9473BB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 14:09:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h21so9243299ila.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yhe1yZzGEpebfSEI4NmtuOUmADVwotj/x5O7U8D/9Y=;
        b=pUR9BPsXnC/s1tR3UVEal3RV8LChzsf1b1v9T9WywlfOCsYkMrsSY+8c44AWBGWRLf
         j2q+DKY+2f3NmkcWerih3TRQlbTxsqu4iaIKNjWDiuIcJBjXlwZUyWwHuxc7wpmItisT
         FO/6cEVsAZAs1oJbhpq/tBeSWy7DcQk9CXx3IOsxGziPWQrI7Uqgxtq1o1pNUgQBxPuV
         hLW4+sBJIL+uzsGplKp2LvwhegquH9PlD81VtV/boIomK/1LFEoBOTVy3upOOC4JrG64
         j+B6amMkJ/FjVm1mMMy4DxE32hMURAJo9Y8ObXkQDKpfgW3yLP1II5YTMFhLkbGycQEb
         fmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yhe1yZzGEpebfSEI4NmtuOUmADVwotj/x5O7U8D/9Y=;
        b=wB5/ZZFIAWqFpm7pBx8wXIX/CS/jdlZJ1hICs7/vM9z2/QMOLLCZbnSnXCuHxzeNZF
         yTeDRFckLhPDektfiv386LduZ9ObWwZnYAzyuJwfizlUdHAlq6yYS+ZmlLbRC6h44TYl
         LIPDWhM98D9hPnZKceZzLcJNl0K0j6BvH9qBAHBZ7+MA0BcLuWy8MkCUDtpmV4y2NFRU
         ku75IpqoVpxy9tGqMKzMMPCRwhofij+EfgU6pL7YX/2mkFNBrjok82oyPFaWDFnpejuT
         f3F4lS/hahjsdrH3FFtqB7JoXyc+4FGg1/TnPlVqFlbYl08MnLGtFDhsam515i+FwbAo
         q5KQ==
X-Gm-Message-State: AOAM531DVemRWT3W9fonXwV1Y3EhdvvE/6ykxOY5ZiliPeHtgFvjO03I
        5AYyT5HQ2O7FB62+D7l+GE1pAxId+nYc9gTmEUo=
X-Google-Smtp-Source: ABdhPJwIoODScvpi9PY+6LRF4Xwic1LYWBkU/8s3NZ0lS1WTTcxw7GTnajy3EaHxusV+xoc1fpOVQ/rAbY8fISKENvM=
X-Received: by 2002:a05:6e02:1a4c:b0:2c7:c6fc:79f4 with SMTP id
 u12-20020a056e021a4c00b002c7c6fc79f4mr8215769ilv.235.1647810587864; Sun, 20
 Mar 2022 14:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
 <CACT4Y+ZtahUje36PKfGYLVkb2SawMXOC9aPNwgfNgZ1ujCAVBA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZtahUje36PKfGYLVkb2SawMXOC9aPNwgfNgZ1ujCAVBA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 20 Mar 2022 22:09:37 +0100
Message-ID: <CA+fCnZekEu705yAX85wsCQeN21rk0tgS8ib6V8jrH_AscubbBA@mail.gmail.com>
Subject: Re: [PATCH] kasan, scs: collect stack traces from shadow stack
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, Mar 14, 2022 at 8:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > +static unsigned int save_shadow_stack(unsigned long *entries,
> > +                                     unsigned int nr_entries)
> > +{
> > +       unsigned long *scs_sp = task_scs_sp(current);
> > +       unsigned long *scs_base = task_scs(current);
>
> Just to double-check: interrupt frames are also appended to the the
> current task buffer, right?

Looked into this and found a few issues, will fix in v2. Interrupt
frames will be collected then.
