Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D331356B525
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiGHJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiGHJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:13:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BACE255A6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:13:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e69so30261010ybh.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t15woDQAKcLwTx4KSzr1H1UOGudxvBL6EDZDZBycJuo=;
        b=IFqYXn/QYAIeCOOZhukGgGtSiZtEQuOAXDtCdI81/WdiBbHokVGMy2W0YQ74nPISpl
         dDbbkZDodL5tCEFadouqwKtiGNWaAnXO/I7x4vOIKkDTil1CGYMgft78nJgEPtNLHCN7
         zNutOamYTU8snjH7UWD+vh1xmOhvHZo2/HHu/u1f+ymBEXdJ65RsXjA2uUlC9E1C21Dc
         gBwuQRZs2i/UdSBhI13OF2OdaResD3sdwEahDzvbt1ppyEO93sAC5oHpKcTSZijFVksu
         1WxhBD+YYLLMJTjAoj8mvno4O/iMVfAsku3pusIZ62riq+jYxDDXVTXpVTaCiJrCY5CO
         Hsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t15woDQAKcLwTx4KSzr1H1UOGudxvBL6EDZDZBycJuo=;
        b=5dlzNU/s/GjvV8UJ0PO+EsxHmnSKLu4YGZfIbAoTwylFEomPvlq9wdLrKy0FwZJRLb
         edyE4C1KDX0ytDPJ9lZbVOgfeSlQP/X3LSdICfJe2PLnprTkK4cVEVjuZber1kN+RhX/
         MWuSJGaN2W0NMgnOlqRLHwo8Rxh3VWZiPwt88p6duksltz7FCIX7Quh0xVSwUJdGgr9M
         iI/VzKGe2RfGLmaEGy00gBdXB2ocM2Vz3ICHsYVBpHo06oe2upFPA1wR17ddwuOjQnWK
         nYSSZeBFclmemV/xS8rMiUI5/FSGUsZgM1ZOKPfgzk144tgb1/2VfAK6M4JG/HMTv/i/
         y5+Q==
X-Gm-Message-State: AJIora/L9iZegxEJghlOqJrwAJt4VyKMVG8GPoih+CwmWO7B36xXutO7
        d0ngprWXxPWhkHAG3PZpQUyCf22sLU/vXJO6WWI=
X-Google-Smtp-Source: AGRyM1s0m/zQunZ0NH8/NYGY+Vr9KiOXctCX75dxdtDgNnaJTlSPuLZLRt5io0WBEQsAX8BJl5qDBspF+V5NkNitp5I=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr2610749ybk.296.1657271593413; Fri, 08
 Jul 2022 02:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220706182300.70862-1-yury.norov@gmail.com> <20220706182300.70862-2-yury.norov@gmail.com>
 <423c4368-0a1c-792c-2637-768532fc7782@rasmusvillemoes.dk> <YsdKMQzUFVwIaqtJ@yury-laptop>
 <d86ad462-fb4c-4768-b060-201511f9ff64@rasmusvillemoes.dk>
In-Reply-To: <d86ad462-fb4c-4768-b060-201511f9ff64@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 11:12:36 +0200
Message-ID: <CAHp75Vfx3RADfU0cm7Y0kYfOtba4K008xZSSVbACRa3OwbAKGw@mail.gmail.com>
Subject: Re: [PATCH 1/5] lib: add find_nth(,and,andnot)_bit()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Fri, Jul 8, 2022 at 10:55 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 07/07/2022 23.03, Yury Norov wrote:
>
> >> And I don't
> >> like that the index is apparently 1-based (and that surprising API isn't
> >> spelled out anywhere).
> >
> > Yeah... My motivation to start counting from 1 is to keep consistency
> > with ffs: __ffs(word) <=> fns(word, 1).
>
> I understand that you're translating that second f in ffs (find First
> set) to a 1. But I disagree that that's necessarily a logical thing to
> do. Everybody understands that (given a C or python or... context) when
> some prose talks about "the first element in an array", it's the one at
> [0]. So I find it much more natural that the set bits in a word are
> enumerated 0, 1, ..., popcount(w)-1.

I agree that here we operate with an array of bits, which naturally
starts from bit 0.

-- 
With Best Regards,
Andy Shevchenko
