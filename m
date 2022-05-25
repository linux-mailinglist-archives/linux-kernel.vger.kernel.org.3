Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662085342F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbiEYSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiEYSaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:30:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23F6B0D22
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:30:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so43360330ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUPOWrnWYG2slQmT/3VeC1AcGFORkCFgaKQE4X/RHDA=;
        b=R6aB8fP9pXh4hwqOoBWTR2Xa0tql8u9D5G1OIwlU3BtL9xkcnR8mFdbDe1RUN8UGDB
         M8UZIi8F34PJnXVcdavCnLyCXg/7VaJk9hcDFEZi5+scJUn/33F/UiOadDpaBFNwoesD
         SjxHJejls7YoLiENznvp/43y/U1FCYBx+Ik/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUPOWrnWYG2slQmT/3VeC1AcGFORkCFgaKQE4X/RHDA=;
        b=q9W5ZYYBy655ZrHrG8Q73fxRhJjvAMrPO3eUmbCHAiGnM0XC0PSzHcJAMezAyXAf7F
         aoQuKrl/HPoBNz5FRzBqKvPsnCahTxqQy6G7r/oDlE8t2ljrTJgw6anK3tG4JwqIdHyN
         WCKeR8egnjiXgoKP4DG42F5QPM9PL19CV1W6RqldLvIVEvtoPMXUup2jfUCmBlXB25xn
         n5dm/XCwDpD8lvF78fYT+VJSfpv3DSuTs7ea1yglzboYA3hFgvEuuPXr8NPHP+2C1ipK
         mrqAejktMgBnNpdqQT0D/TV8tApfG4sWY/w8cpiJFKCptCEs82Rp/bsZ8hfVlLu4+UFn
         Ag1A==
X-Gm-Message-State: AOAM533O7L/h2p7J4aBTF+O2OPqTeMEEGF6dN2n+lu2uA5Y6xPLdQdSw
        CiJwk/mWMOoIzj9RV8sH6CfBnF4Nx+6iqoLyrpw=
X-Google-Smtp-Source: ABdhPJxdjDliCFiDzmz48MV9CGmwRjY2+grUhF1KhSlW0zfpOMGJ+P4BK8WmL2lQGe7BhpEjpVr6lQ==
X-Received: by 2002:a17:906:6a07:b0:6fe:ec47:b64d with SMTP id qw7-20020a1709066a0700b006feec47b64dmr13730547ejc.765.1653503404132;
        Wed, 25 May 2022 11:30:04 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906c18600b006f3ef214e72sm3088196ejz.216.2022.05.25.11.30.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 11:30:01 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id s28so31130565wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:30:01 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr25884560wrr.442.1653503401048; Wed, 25
 May 2022 11:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <8062f61e-5a4d-00a5-be1a-7921d3277e9d@suse.cz>
In-Reply-To: <8062f61e-5a4d-00a5-be1a-7921d3277e9d@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 11:29:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiztQWhEw4tLiH3t5gw=gKB7XtoTXC=S2bhxBxoxOVZLw@mail.gmail.com>
Message-ID: <CAHk-=wiztQWhEw4tLiH3t5gw=gKB7XtoTXC=S2bhxBxoxOVZLw@mail.gmail.com>
Subject: Re: [GIT PULL] slab for 5.19
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

On Mon, May 23, 2022 at 2:54 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
>   The stackdepot conversion was already attempted last year but
>   reverted by ae14c63a9f20. The memory overhead (while not actually
>   enabled on boot) has been meanwhile solved by making the large
>   stackdepot allocation dynamic.

Why do I still see

  +config STACK_HASH_ORDER
  +       int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
  +       range 12 20
  +       default 20

there then?

All that seems to have happened is that it's not a static allocation
any more, but it's still a big allocation very early at boot by
default.

The people who complained about this last time were on m68k machines
iirc, and 1MB there is not insignificant.

It's not at all clear to me why that allocation should be that kind of
fixed number, and if it's a fixed number, why it should be the maximum
one by default. That seems entirely broken.

I've pulled this, but considering that it got reverted once, I'm
really fed up with this kind of thing.  This needs to be fixed.

Because I'm _this_ close to just reverting it again, and saying "No,
you tried this crap already, didn't learn from the last time, and then
did the same thing all over again just in a different guise".

                    Linus
