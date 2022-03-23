Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414444E574E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbiCWRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCWRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:21:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE03527F0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:19:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so2824165lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQ5feCsABdz9+k4CxyxquQb4p5zlNK4tsxBnm9pTujw=;
        b=cwyo6konbea6YaaITQlVN7byMwcwTtepKnsurJlfRRSTJPQaKb/xw9vENJk3ihlAaA
         n0yLKguUSZfZOGiOzZsVSrpq5D5BcNhIRkAOqJwr2eUfdj3DWzg61SEanFGvw8KE470W
         VXdhWNglq4wVMtYI1xanEm4PD6WgPp+fT87rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQ5feCsABdz9+k4CxyxquQb4p5zlNK4tsxBnm9pTujw=;
        b=7rOaJfDhnVvIxxQdkbsrQvg+rhjwO1kpYQ6aNiAA4DJH5Dm0e320jXIHnb1b+cOjTO
         d6HfWwuLWpP6UWh0qnJwN3E4syZbihyiZeujBGhlZI9XJs9kvPr+lE41WEHRfHhxyiAy
         R9SgylYXVP30Sd90+1rH4lck4WJ7rPPogbPtKo+arcOLavi0UkVAqthY3D+Z7ctPcYkb
         rO+YwSfRHhcJiQij6Lxrv5ShKoIMvwwqbI3aAZsQKgw5th+5erL2H7VKgrCp3xMrd/Xp
         eLVmzzxQZN6qr4s01rY7kW9WTUlAPpjscYMXMeMl0uopnh2NVEnThPcOQgrKxXTZxkqA
         FFhg==
X-Gm-Message-State: AOAM530RVn8eavhaxqgCC3QSeDWiXcMWMfHePECuylZiyioD1RSHBdDT
        hOEvjZCUyTiaBVc7ugnAOvjQ7e61trFLRIpby5s=
X-Google-Smtp-Source: ABdhPJy+rmiLhxmVbaEeYjhEQEVG+n1+HZl8Zc9BMKFnL9NeUcIx0AYIrntcMtbzVUdoXecvWEAZ0g==
X-Received: by 2002:a2e:900a:0:b0:247:df2c:7607 with SMTP id h10-20020a2e900a000000b00247df2c7607mr882621ljg.262.1648055996401;
        Wed, 23 Mar 2022 10:19:56 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f14-20020a056512092e00b004423570c03asm43304lft.287.2022.03.23.10.19.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:19:55 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id c15so2794387ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:19:55 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr871674lja.443.1648055995082; Wed, 23
 Mar 2022 10:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <YjhdcJB4FaLfsoyO@gmail.com> <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic> <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic>
In-Reply-To: <YjsCpoRK7W4l6tSh@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 10:19:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
Message-ID: <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
Subject: Re: [PATCH] x86/defconfig: Enable WERROR
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

On Wed, Mar 23, 2022 at 4:21 AM Borislav Petkov <bp@alien8.de> wrote:
>
> So this should make at least the most obvious and common ones not go
> unnoticed.

Ack. I'm actually surprised people use "defconfig". It's kind of
pointless and unreal on x86 where there is no realistic "default". I'm
sorry it exists at all.

But since people clearly use it - presumably for testing - I very much
think it should have WERROR on.

                Linus
