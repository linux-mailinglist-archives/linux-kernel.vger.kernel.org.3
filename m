Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0EB5896DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbiHDEYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiHDEYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:24:40 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31F2B187
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:24:39 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id w129so9661363vkg.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lcJgZtls2CTirMKeOXiFocO+aRaEekUb/H2SoND/Yd4=;
        b=i1KHvKFaa8ngFoTixU4mlnYzNxdw+de1oW9vryq05o4rZpYSCSEi8CAON7NjnUFdSD
         KRFG/cfqhaWA4aQFC7YNTABDVetWeAeoFDTLQuPjiabvUA1A2R4bA4uL+Ap4Plg8jWIT
         91UzBBctxMZqhlQNJo3Rykm//O8Yuh8EqudlMsEhtT52rtO+pzBYpEVm6ZUaNW3itEJX
         MlOzx1sRyXlyVWHepBmzCWOT+t79Nc05LUEAndQKVVbKb8rzM3r8xiGJAXpgPS0dVR0V
         i5iEuPDt34A6/6lc0HMmxgo1XyUnMKB6xJX9uiU/LWQHKL34HO3gXB04rjkbSYUr4iF7
         ZZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lcJgZtls2CTirMKeOXiFocO+aRaEekUb/H2SoND/Yd4=;
        b=G/+XC5AiIIaMWuEPwp91vRvJ3yyXd8NnZI/eXRwhvF1XboHHOut2PggYItyetVzOiZ
         EAlvvqWeQxiTTCu7Nz5Bs+D5skqEt60Unh5nMnLVhi8kmw5BaWcURwCjUHciU/MmzX8E
         8jRpNmL728epBp5xi2KXZdFNtqFGFCP137a2v/vCJHyKt9r6iI+rA//HhVtYsn3hLGYf
         LIksocPuJILl5UyoiDGn21pgcfY9cW7nCaCxOo9JAanROCeHgCIOdkev47Tf7LAhOBRY
         QkoQYwZyKT/ZZfDHkcI8oS36WLf7cGIDDjJ6MnYIe02W9WXxbALjNTuWSDxhm88YMrq5
         FaOw==
X-Gm-Message-State: AJIora8ife7CwISnELgzsyoGTxvXWZtTpQUTrSr4cLWGCLWl3a8OW6PY
        lzSwIMP4FdFO+hiH3mF5MnrElZGdKrbfqfIIsQaOjjHM
X-Google-Smtp-Source: AGRyM1t1e2zapiNYQ/JIIzS87OOq3/E7MJAYPwL5oMiuvgU1Y8LCnID6eVs2gdFIlnUBC7JIzD1iP5yUMLkyoiOtoZo=
X-Received: by 2002:a1f:2bc8:0:b0:375:21ea:25ca with SMTP id
 r191-20020a1f2bc8000000b0037521ea25camr11174701vkr.37.1659587078212; Wed, 03
 Aug 2022 21:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
 <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
 <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
 <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
 <CAPM=9txkjJg5uArn1ann7Hf+JFCukQFGwqv+YHAx97Cdxezs_Q@mail.gmail.com> <CAHk-=whWcektQzPJgSPa2DC3wMPxgLh8fJVQWeo8i99XMXPjfg@mail.gmail.com>
In-Reply-To: <CAHk-=whWcektQzPJgSPa2DC3wMPxgLh8fJVQWeo8i99XMXPjfg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 4 Aug 2022 14:24:26 +1000
Message-ID: <CAPM=9twUvRoVcWHhBH7yuDDVj8K8aM0APQ8Yx3cx19keLJP8Gg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 at 14:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 3, 2022 at 8:53 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > > It works on my intel laptop, so it's amdgpu somewhere.
> >
> > I'll spin my ryzen up to see if I can reproduce, and test against the
> > drm-next pre-merge tree as well.
>
> So it's not my merge - I've had a bad result in the middle of the DRM
> history too.
>
> On a positive note, my arm64 machine works fine, but that's just using
> fbdev so ...
>
> But another datapoint to say that it's amdgpu-specific. Not that that
> was really in doubt.

I've reproduced it, I'll send you a revert pile when I confirm it is
the buddy allocator.

Dave.
