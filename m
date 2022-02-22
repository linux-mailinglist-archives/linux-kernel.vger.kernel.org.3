Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB974C00F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiBVSJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiBVSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:09:05 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD634172263
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:08:38 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id w4so2192495ilj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MFpylEeTI6XidlITe8mkhmRrO1Ymt6z5H1OOXcy0qU=;
        b=E5GkLf4qEy+uKhfmwS9E+yY1OvOjM1XyV9x8NZY2UhTf9bgOMa0QvRvedtcLDR+t3t
         V4aWKPJ9Cq4nD7p1Gbp5uPVOkxIjJFOvVBwZyCv8MzT/QpVDlPSFBn8+NhETz8XE2rxy
         wYtZrVu/zkVfJUCaBJu6Gtklzoo1hdnzyRh7+hznLDVwsaj+Ul11+1dmSImsuBVKNbPS
         K0Zu5f+gkNZJqOwFHwt3YY60+QymuMa8qPIXYAYRV64/ZvoWztNDDTMuyiMNt59UNKGC
         zgQH/49PZmFlZEXWRwmwewEQTwIUiHq3rsoZ7XWhs/a5jJn5uyZXXqrA/CK4NFJY15Uu
         2Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MFpylEeTI6XidlITe8mkhmRrO1Ymt6z5H1OOXcy0qU=;
        b=5xNr0UPkJAUgeJQcfXkaDr9fJk03EuRq3A1xEqy4bjkE/YPrtJV0o8Xsy9llSQCYi4
         k4j4vJfJiuLgN5wlkrstbbJ8gQYamFSnaKow3EPU/GmD1RJAaEFARSnVYWh4nb8uqSPl
         2P+vqsRmiNaFwXuReSRQ83NRPCiMfHVVzrO2MXNb/qIrsBLJx6M/4OSybMyJ+l2BOmwJ
         6bXpn7U0eR4Q4q2eXK2eeJFpbeq6S3y/MWwPEsJHtp4fQvAabqyAVhWdHpCAKKmvMI7S
         rQdZDWjemMFrCU1+QXhftNv7wqAJzdq/JGTwM9OakDOj4pfqGyOlGubCuAz60HFCPoPk
         mTLg==
X-Gm-Message-State: AOAM531xt7ForTQtWlo5sidOqsOnBCwW4AcSXS1WtOkh4Rab76jatk3v
        PaFfvziyGD9XcvGbJyy4gZxtPN4uEaA/qZe4MKs=
X-Google-Smtp-Source: ABdhPJwHc7J+f7tj6fV7sYNacLBeV6cwmCJjs7Rt2xuMtzr0WDHDAbVMmhP5P27yvx+DPuvIVYaPzUBJ4R4RgCjJBxI=
X-Received: by 2002:a05:6e02:190c:b0:2c2:6851:bce3 with SMTP id
 w12-20020a056e02190c00b002c26851bce3mr2988283ilu.28.1645553318268; Tue, 22
 Feb 2022 10:08:38 -0800 (PST)
MIME-Version: 1.0
References: <2d44632c4067be35491b58b147a4d1329fdfcf16.1645549750.git.andreyknvl@google.com>
 <CANpmjNOnr=B_o83BJ6b1S6FKWe+p2vR58H8CHtGPNPnu6-cQZg@mail.gmail.com>
In-Reply-To: <CANpmjNOnr=B_o83BJ6b1S6FKWe+p2vR58H8CHtGPNPnu6-cQZg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 22 Feb 2022 19:08:27 +0100
Message-ID: <CA+fCnZf2jE1N8j9iQRtOnQsTP=2CQOGYqREbzypPQa-=UXjhDA@mail.gmail.com>
Subject: Re: [PATCH mm] another fix for "kasan: improve vmalloc tests"
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
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

On Tue, Feb 22, 2022 at 6:50 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 22 Feb 2022 at 18:10, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > set_memory_rw/ro() are not exported to be used in modules and thus
> > cannot be used in KUnit-compatible KASAN tests.
> >
> > Drop the checks that rely on these functions.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  lib/test_kasan.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index ef99d81fe8b3..448194bbc41d 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -1083,12 +1083,6 @@ static void vmalloc_helpers_tags(struct kunit *test)
> >         KUNIT_ASSERT_TRUE(test, is_vmalloc_addr(ptr));
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vmalloc_to_page(ptr));
> >
> > -       /* Make sure vmalloc'ed memory permissions can be changed. */
> > -       rv = set_memory_ro((unsigned long)ptr, 1);
> > -       KUNIT_ASSERT_GE(test, rv, 0);
> > -       rv = set_memory_rw((unsigned long)ptr, 1);
> > -       KUNIT_ASSERT_GE(test, rv, 0);
>
> You can still test it by checking 'ifdef MODULE'. You could add a
> separate test which is skipped if MODULE is defined. Does that work?

Yes, putting it under ifdef will work. I thought that having a
discrepancy between built-in and module tests is weird, but I see the
kprobes tests doing this, so maybe it's not such a bad idea. Will do
in v2.
