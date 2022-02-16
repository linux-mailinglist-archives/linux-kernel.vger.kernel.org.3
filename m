Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2864B8C49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiBPPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:21:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiBPPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:21:13 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E642A39F5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:21:00 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x13so32336iop.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBW1C5wFk0wpTZVzu222A5UngO/IWRNu9ZiYVflWd9Y=;
        b=i56LMHidru/lux2u/YrSKgJU+bbEQdHAE1K799Dk4ygQBtMRJ/+pD99/xsKygtsqld
         VN34cOzYkmLCgxHXDM+1obWGrvvZWxXCE+trLuNyrktZnHsToGvVov33p1JGiyTJsnxr
         8nIb11yF8nh7Xk/g51JYSqFApDRYJEZMpPBMXbc9sNoUnXVyc8Os4ei8wwIp28C69Or1
         fHc/W55PuSxdLtfErtSFXVigC0z9TWrElvU0UD5I7h+LBOxLxu9bfcZGwnnF2DvC8WqM
         2BmmRGjBiC9P09ODUqL9vhfzOQjy9F4j/74CGUTtWHmtxgiwEBDCFlSSLJyIlVUuko0h
         dCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBW1C5wFk0wpTZVzu222A5UngO/IWRNu9ZiYVflWd9Y=;
        b=gSyKb/8r2lEkgMe1OIAhYwsWiP9C6vhwr8WvkQAkdFSnWSIeYgYhKvOY+j44Wk+622
         GLSfY73RuiWuBRpVsCg1oLrjkCyVkCskTfZ3Q2fCea+ff4fjpC4aVmIu7cZbdYMj2u57
         gLjm3PKpnKKwRtdIYwtpRPYLDRFNnE7WLjtAqFrv6r/8jH+xS2KnAitELDA1XEk4wIxJ
         GF8hS041btwQ0EALovg6+NCl7CEhnkPlIf1cbh5asagU8XWzMsNy8ps+qHrm+i119rtH
         h7UXCJiyf8L2DUCsdhdTbTjv4DMXBpHkEZyo7JlA03dpxvfNqxTBE5xrb6Lr6phOF2cJ
         FoVw==
X-Gm-Message-State: AOAM530vWntBU0fDaXNwoCSyBIGcfN2jyEZo0pxupetk43xqP4hNw+jp
        VHqbANicwg6JJ1kw433EN6HWzW6FKNzDqbQnHEY=
X-Google-Smtp-Source: ABdhPJwv6JqLq+tNlN1qIvpvO1TTUyqoC1Tw2tFERpxyFP+V+f/r5WWie9UqPKBbf/tYwmRuVvYKi/XQ7fcCjGyC08I=
X-Received: by 2002:a05:6638:1409:b0:30f:843:f953 with SMTP id
 k9-20020a056638140900b0030f0843f953mr2079611jad.22.1645024859660; Wed, 16 Feb
 2022 07:20:59 -0800 (PST)
MIME-Version: 1.0
References: <f50c5f96ef896d7936192c888b0c0a7674e33184.1644943792.git.andreyknvl@google.com>
 <CANpmjNPG2wP9xiGDJboMJzf-YD+skOO532O+bKkAz+tpvDsF=g@mail.gmail.com>
In-Reply-To: <CANpmjNPG2wP9xiGDJboMJzf-YD+skOO532O+bKkAz+tpvDsF=g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 16 Feb 2022 16:20:49 +0100
Message-ID: <CA+fCnZf3x3rWDNbDVYSbbO6PztWm7EfbhQN9bCHiXaScg8J+kw@mail.gmail.com>
Subject: Re: [PATCH mm] fix for "kasan, fork: reset pointer tags of vmapped stacks"
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
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

On Wed, Feb 16, 2022 at 10:59 AM Marco Elver <elver@google.com> wrote:
>
> On Tue, 15 Feb 2022 at 17:52, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > That patch didn't update the case when a stack is retrived from
> > cached_stacks in alloc_thread_stack_node(). As cached_stacks stores
> > vm_structs and not stack pointers themselves, the pointer tag needs
> > to be reset there as well.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> Did the test catch this? If not, can this be tested?

Kind of, the kernel crashes on boot. I got KASAN_STACK accidentally
disabled in my SW_TAGS config, so I didn't see the crash until now.
