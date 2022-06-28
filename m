Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB455EB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiF1R31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiF1R3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:29:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D2B37ABF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:29:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ge10so27219101ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dx3l2MSmg5XWbOR1OWuFQ03j1hQZ9DqmJP1QmQJJp+4=;
        b=YXz38QsAHp7j0txc9BEDHmLno0dZnbMbhhPf2IdvRQO8BIOX8HheRNM9YejvnygQsL
         VH+g/o09U4hbC88JR+4hotOKsgh4zXYEkxaZCR2A9QQNOf2N1MDZccpoQF5bJORYlCTL
         E12iw170ePfbGmQo4HXtIrUHTjmPL7yCPI2oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dx3l2MSmg5XWbOR1OWuFQ03j1hQZ9DqmJP1QmQJJp+4=;
        b=Wp+P+E6a5LyNtY41HkGLnQGxJXmVf267k74rAIObjf2JPTrqj6qKC26WDiZCHDAAOm
         jbms4kdq5VoNuru4tB+wmkhjRffVIwS78NyT4oUkosrMy6M/2IOjULXm1wrFtI9nhQHI
         h92NBpxMzYQtspiySPlC6ac9vY/g1F+UI4GPL1pW48M7AiQx9FJSF3B4I1y/d2KIMXTV
         jcHHPzj5YQO+g0MHPM6MqmQYe8n+NIOGS6wEkTbyIhEcbTlSgWQcUMnJWO+zP3THpbL2
         plsO+lRbSdD4mHY7VkBy3L/55HKPgURiPF1iBYoetgJGdjIJxAd+eP1x8QqMNuMdmbNp
         7kOA==
X-Gm-Message-State: AJIora+QhamDsVm9YgbQLglpz7mRnLGC0cwQ3mnaEy+LcUxXok1qipF1
        XBogMjSQZ3I9V0exnQ1G3hLy7KxBE0D/TLInx2E=
X-Google-Smtp-Source: AGRyM1vNKOnKcwxC5oxNV2wLuBD+BYrLywzYn7JmTb61SAKPgCPWbCRl7ip1DHS/NMGxTsa5+Dc0aw==
X-Received: by 2002:a17:907:72d6:b0:722:e59a:72f4 with SMTP id du22-20020a17090772d600b00722e59a72f4mr19097659ejc.158.1656437362590;
        Tue, 28 Jun 2022 10:29:22 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906860700b00722d5f07864sm6557460ejx.225.2022.06.28.10.29.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 10:29:21 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v14so18698096wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:29:21 -0700 (PDT)
X-Received: by 2002:a5d:59a5:0:b0:21d:205b:3c5b with SMTP id
 p5-20020a5d59a5000000b0021d205b3c5bmr3879527wrr.97.1656437361049; Tue, 28 Jun
 2022 10:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220628032439.3314451-1-kent.overstreet@gmail.com>
 <CAHk-=wiGMNvKaVuSDD7y2JeK+NsNyXtqZEusOLmEw9uE+0ZySg@mail.gmail.com> <20220628172321.gbgfif7zgz5ny3mo@moria.home.lan>
In-Reply-To: <20220628172321.gbgfif7zgz5ny3mo@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jun 2022 10:29:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTGmf5=f1JdzK22Jw88veKxB2YHbxL0Sgy9EQzMs_MBA@mail.gmail.com>
Message-ID: <CAHk-=whTGmf5=f1JdzK22Jw88veKxB2YHbxL0Sgy9EQzMs_MBA@mail.gmail.com>
Subject: Re: [PATCH v5whatever, now with typechecking] vsprintf: %pf(%p)
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:23 AM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
>  - We need to be able to specify the pretty-printer function, and not just have
>    one per type

I even showed you how toi do that, you just deleted it.

Anyway, I'm done with this discussion. I think this is all pointless.
I think you are making things worse, you are making things more
complex, and I don't think this is a direction we want to take things
in.

              Linus
