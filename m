Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178195894F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiHCXnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiHCXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:43:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7CC5D0E6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 16:43:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m4so12262586ejr.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lgOA02+HwCaP4zKHggG8OC7Keut/1grVFRI+0RIkn4Q=;
        b=LufboehCuxeEuDV9oa12YE8xVcg0hXsGKqXDPs1LhGh8BIdrrINPAuvSCTpU10TMD/
         VGEosdbgCowe20oYYLhzJMNjPqi2Y/StpYT90cJmAAqZlBC3BnyypkO8MOPzyDcJp3K7
         vtDSS2o+GQ3BVHP5foN9lbi7evncrZccgyM0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lgOA02+HwCaP4zKHggG8OC7Keut/1grVFRI+0RIkn4Q=;
        b=YUhQVS4ue4xKPLeKMmE6L2GnS6jhPHivbwQpde/ZVuXcigPNY4WyEDuiBC9jd7GdFx
         W/CvOKNOSywC/83/6+AWjcR2UX/PZl8LOrAp/kSdpNHlpMtUvy7JWdaAUiNMxZnV590c
         0ANVtwqTnUhACG6EONwfb7gL0qO7560tB5rcjzKTDjK897juggiG3pVi+JI4XnKB4iki
         W+X6dlnU6URKo+TVvjV3AYlTVo3CwjBH3mUMxG7wkTCRojk64yswNUh/Sxl6QTaYfASY
         EsO4UXZK+OMEZ4Q4ki1fclpljd42vnvQf3ky03Dkp3AvWU71z8FiJlZf2mf1fcYtkHmy
         jRoQ==
X-Gm-Message-State: AJIora9G13J1kAnqfJPwuzceWsDV/14da9qRRYmglzaQpIv1UdxKrftA
        QfH2I56l+N8xXt1Pv7btzhrHRajrMDwhe1l1
X-Google-Smtp-Source: AGRyM1ub0fs3BioBK40JtoBIBNdJFnVt+UYdRrxDeSn9LwnLPNuIUrkTqN1Xe1RNTh2Y0lxfgRmDEQ==
X-Received: by 2002:a17:906:5d16:b0:72f:9f40:d1eb with SMTP id g22-20020a1709065d1600b0072f9f40d1ebmr21574305ejt.403.1659570180402;
        Wed, 03 Aug 2022 16:43:00 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b0071cef8bafc3sm7732419ejg.1.2022.08.03.16.42.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 16:42:59 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso2233883wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:42:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr3011922wms.8.1659570179354; Wed, 03 Aug
 2022 16:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <YurA3aSb4GRr4wlW@ZenIV> <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org> <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home> <YusDmF39ykDmfSkF@casper.infradead.org>
In-Reply-To: <YusDmF39ykDmfSkF@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 16:42:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
Message-ID: <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 4:24 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Aug 03, 2022 at 06:59:36PM -0400, Steven Rostedt wrote:
> >
> >       preempt_disable_inlock() ?
>
> preempt_disable_locked()?

Heh. Shed painting in full glory.

Let's try just "preempt_enable_under_spinlock()" and see.

It's a bit long, but it's still shorter than the existing usage pattern.

And we don't have "inlock" anywhere else, and while "locked" is a real
pattern we have, it tends to be about other things (ie "I hold the
lock that you need, so don't take it").

And this is _explicitly_ only about spinning locks, because sleeping
locks don't do the preemption disable even without RT.

So let's make it verbose and clear and unambiguous. It's not like I
expect to see a _lot_ of those. Knock wood.

We had a handful of those things before (in mm/vmstat, and now added
another case to the dentry code. So it has become a pattern, but I
really really hope it's not exactly a common pattern.

And so because it's not common, typing a bit more is a good idea - and
making it really clear is probably also a good idea.

                Linus
