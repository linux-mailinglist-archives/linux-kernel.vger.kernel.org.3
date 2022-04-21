Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEC350A5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiDUQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiDUQer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:34:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ABC496A1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:31:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bf11so6430868ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDHwtTdktvnVaIW/2JWrDjqUVZR9rEX/QovVhwcUaVw=;
        b=e6Q+A3Cw3J49kCJ+zuxnLYRX59f2aqNTPi2FdOE+44LcRv2+/Tqms9+royj30R+qv/
         63foTaGKolV/B5vsrdf60lb4GSXIYbkMeCbebG+BNfRQhUzdwp519h0mbz2f64vTXqFz
         juJRK/yjfkTO3d+BGRR8pOmGa0TnE6PJDsDrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDHwtTdktvnVaIW/2JWrDjqUVZR9rEX/QovVhwcUaVw=;
        b=5aETt+BkHKkl/s7cWMz/c127ojHFsZn0+yc53B+C/KkQtLIqg0YFV3gPB3eYp7KyFJ
         wphC2kE2iNoUCQpbgxgteoSfB3a7oT6uC84zxVjzsdGNaqYjUl3yMb+ZHVayGhNVRH8b
         9LexaMIyqF9MrVzStKT776LK5yXJkR4rcVzkm/nQTZMQxsJKK9UqzVCTAAMDUk3zHVrl
         pVRWcJaCyZ0b93OeAFvr5/I81QvsE061ca8Izx/cTb+uxoNWkiSQ8q3zMdMTpPyCDQJ3
         5Q45+Ix2X3m9TR7+T3qakP4Ha9Xbjo7HLN8zm/mzG3Qmy9DwjDzVOgLm0NsdPdhc4DjT
         A0OQ==
X-Gm-Message-State: AOAM531Z44He6qS06kBRKTvA2/bQZx99CG8S49mDMJQiQAN71Iz5u+Lv
        6i0Gm1jY+PaBvcG+VxGA5zbkcPxEBAJ3jTFXcVE=
X-Google-Smtp-Source: ABdhPJz5lUUlZmS1yxuVZNFobbnjiHgF4N3PpPIH2nxHb1VfNP9d6RYqBQz/lICgTMv2/nog8X3F3g==
X-Received: by 2002:a05:651c:1791:b0:24b:1797:53b1 with SMTP id bn17-20020a05651c179100b0024b179753b1mr306237ljb.269.1650558680905;
        Thu, 21 Apr 2022 09:31:20 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z1-20020a195041000000b0046d191d1e91sm2222433lfj.169.2022.04.21.09.31.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:31:16 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id v1so3037656ljv.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:31:16 -0700 (PDT)
X-Received: by 2002:a2e:b818:0:b0:24c:ce86:e6d6 with SMTP id
 u24-20020a2eb818000000b0024cce86e6d6mr297100ljo.443.1650558675957; Thu, 21
 Apr 2022 09:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220420073717.GD16310@xsang-OptiPlex-9020> <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
 <CANaxB-yVLCSHAi3QKMYzsSDRYC5Wz05iWx8yrb57cbiJ__5ThA@mail.gmail.com>
In-Reply-To: <CANaxB-yVLCSHAi3QKMYzsSDRYC5Wz05iWx8yrb57cbiJ__5ThA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 09:30:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSW3gB1=rf3atv=3Xvn0pNBtKUKJ2VF81ue-xagS7F4w@mail.gmail.com>
Message-ID: <CAHk-=wgSW3gB1=rf3atv=3Xvn0pNBtKUKJ2VF81ue-xagS7F4w@mail.gmail.com>
Subject: Re: [fs/pipe] 5a519c8fe4: WARNING:at_mm/page_alloc.c:#__alloc_pages
To:     Andrei Vagin <avagin@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
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

On Thu, Apr 21, 2022 at 8:35 AM Andrei Vagin <avagin@gmail.com> wrote:
>
> The operation of injecting/curing parasite code from the
> process is expensive and requires freezing a process. This is why we
> want to maximize the load that we can carry on for each iteration.

Honestly, it sounds like what you want is just process_vm_readv().

The pipe part sounds like a horrible hacky thing.

I also assume you already tried that, and hit some performance issues.
But it does sound like the better interface, more directly what you
want.

So what are the problems with using process_vm_readv?

                   Linus
