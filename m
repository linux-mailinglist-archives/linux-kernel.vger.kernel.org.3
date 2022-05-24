Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3ED531F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiEXACm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiEXACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:02:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0B664BC0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:02:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g12so21062104edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1eTZ4hb49pR2erCcYpdM+JetWRdmkZ/mYod+1f/sdw=;
        b=Xp2iSed7rwzxZTvbzFQb9UMn+rcCPvtOG2HSLmQj3mkyE8mNqQhZPWYcra8zP4PDQN
         QL5zej6FU5K1K1NYFMJMFHLPFPAZfqkRYowFZLJcwHEygqlsGu1ZKi3XDPSVOnTggK32
         dqw/0hXOgeFQI/+HUYWnDPlY9ql3oBcx/emn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1eTZ4hb49pR2erCcYpdM+JetWRdmkZ/mYod+1f/sdw=;
        b=d1SAGsJr6dgUYtKzrzDcxbO7f4xZHKa8Lwdj00Z0w4sbRvu389TSMp3ob6JP5jj44y
         88uquSUtbw7RICSVWrtn8kW5LcGlMFIWsYod5WXIBCaaeK9sOzgh/wXSFDpyrSJ1gF2I
         J/8R0yWUc8oKtXYN/ulh/nnRF09NmuQ/wCZHys7FSt6dDCLj38uBvbtg987kH4m22HlD
         zg+CPQuX1TBapiZAdsBcO1fsJKrQee4In6qMvo2LN/sRgBG0MVyoJrNnS43T3p6W1V7P
         6HUTYU60fcuI92ypG+q7ftSppJel/oZb+vKsuEp3JhDOAnlv/JyL+96cAFMAGVBsfu2c
         fb+w==
X-Gm-Message-State: AOAM532fbyOZcOBrVKerJjQ60bMu2maHjSwQA5Q2i6vI/QFYBqkV4LVE
        mVUHSn/jPRMQ8RlBA07hjDvBebFyLlgqO2zyRz0=
X-Google-Smtp-Source: ABdhPJxf0ltW8jySLPbrEW9d2ZHwQEZ8RHHCG10W1sH7wnuqFALQ7x7eahrlEe4EbYDDqv+Zi3NlfA==
X-Received: by 2002:a05:6402:5207:b0:42a:d723:a699 with SMTP id s7-20020a056402520700b0042ad723a699mr26449125edd.208.1653350553917;
        Mon, 23 May 2022 17:02:33 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090627c900b006febc1e9fc8sm3226279ejc.47.2022.05.23.17.02.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 17:02:32 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so472154wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:02:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4f:b0:397:2ca:2363 with SMTP id
 e15-20020a05600c4e4f00b0039702ca2363mr1252497wmq.38.1653350552288; Mon, 23
 May 2022 17:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <165329267741.3801280.534077656528571075.tglx@xen13> <165329268046.3801280.14650675869745686928.tglx@xen13>
In-Reply-To: <165329268046.3801280.14650675869745686928.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 17:02:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-Jpp8t6B_HbmGyAQwwEWMJ3Q0tK3HGiRh_KTEzUGn+A@mail.gmail.com>
Message-ID: <CAHk-=wh-Jpp8t6B_HbmGyAQwwEWMJ3Q0tK3HGiRh_KTEzUGn+A@mail.gmail.com>
Subject: Re: [GIT pull] irq/core for 5.19-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Mon, May 23, 2022 at 1:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>     - No new irqchip drivers and not even a new device tree binding!
>       100+ interrupt chips are truly enough.

Oh you sweet optimistic child.

              Linus
