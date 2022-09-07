Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8935B09FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiIGQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:22:54 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D5481CF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:22:53 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b2so10836676qkh.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nekiICsot4RR9hlxDU0J5imMIsaSvcgmKZwZKGl6pNA=;
        b=JcFqAmqsQUkw7LgrQ4hUzAYMoKZIjWv5PCiszH2shugD/deCxUNFP9dASl4i126T3u
         2HMZks0zHvY46rfLovkHzV+LqA/f1YERXnYg1r7XNfoflpnt+N+2v0BE7/0xpGn+Gbop
         EhNcDbm8m5Zc27vGbrdR1ssMvK6NGzhXHzZg+osmX+cagrT9ibXmNeiw71xFctIDp8tx
         a/8yz5JXwZlFG4okD7eTYVREq2Esdi4cS5DC9tnDKS8+pVwrlRsLxrZPuuRyF3RlMlAb
         B/qESnh8+xTmrLlYsG28sbNBX6G2fVhURAF9sWTVWuDktdBYKBS65+XBm52exkgUlbUe
         ZGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nekiICsot4RR9hlxDU0J5imMIsaSvcgmKZwZKGl6pNA=;
        b=W2XjlfSml9aAmKzXFzTfYDDGoU31biuVXkwHilG4CLTy7Xzc4x44ElKQutahgSoQbr
         ezjNdyyfg5FoN3rLHcgC/Jkk2t8I4Jnabyw6V1DbeKB1VtEoZz1vxwz/TPHCom3Ikt9r
         g4ejE9iYdS1ckvcQ4Ay5LNGom+FAeIaMTvCSUFULLNneVRtiKZzvQwUrUkkZ7MJhtSjk
         t1gDb8vA/jqQoOOwn8qdZQi/wxIjBv2ILWegPr5/6EEt9SLuzty0yVJ0YKCTwy6PEYCe
         ZE7n9n4M6L0gZSwl/kU+clk6TZFhoozltzsEpP1KbnukT2EG3+E6XgSiMmBzDm2NZoSW
         pdnA==
X-Gm-Message-State: ACgBeo2tPVuRm0s1+tI5eSrFs2d5DV6KtBstBXQEi5ZcnlxFFAtax/Ui
        s5O6MBM6m7zujeh1wmkzxX8uN8mjqjt6UOPZ9gaHcLDJQig=
X-Google-Smtp-Source: AA6agR6F5XDirhoLKYmTdzkheCE6ubmPKsfUatGv+lYDS62N8U0diNRJ9KEz1E+by0oRoJWCavd2wmzfPwVW91rVVBU=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr3355681qkf.320.1662567772754; Wed, 07
 Sep 2022 09:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220907103041.0a88d5c4@endymion.delvare> <CAHp75VdzgWfQ=7nTvYmuxWMaPH0weF=Bzj+AEqsEhyQNeH1XHg@mail.gmail.com>
 <20220907172146.72460eda@endymion.delvare> <CAHp75Vf+PdP2AiLOHYnKUWn5KDgvy+1poBHjHZd0hnJKTsGHtg@mail.gmail.com>
 <20220907180903.5a14d3c4@endymion.delvare>
In-Reply-To: <20220907180903.5a14d3c4@endymion.delvare>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Sep 2022 19:22:16 +0300
Message-ID: <CAHp75Ve=cmB-uXcLuQUHWAOLxe-nQ0aeTx93O9B4DkDC8NqHaA@mail.gmail.com>
Subject: Re: [PATCH] firmware: dmi: Fortify entry point length checks
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Wed, Sep 7, 2022 at 7:09 PM Jean Delvare <jdelvare@suse.de> wrote:
> On Wed, 7 Sep 2022 18:48:03 +0300, Andy Shevchenko wrote:
> > On Wed, Sep 7, 2022 at 6:21 PM Jean Delvare <jdelvare@suse.de> wrote:
> > > On Wed, 7 Sep 2022 17:52:10 +0300, Andy Shevchenko wrote:

...

> > > > "NOTE: This value was incorrectly stated in version 2.1 of this specification as
> > > > 1Eh. Because of this, there might be version 2.1 implementations that
> > > > use either the 1Eh or the 1Fh value, but version 2.2 or later
> > > > implementations must use the 1Fh value."
> > >
> > > Good point, so maybe we should accept 0x1E and treat is silently as
> > > 0x1F (which is what we have been doing implicitly so far) for maximum
> > > compatibility?
> >
> > At least the previous comparison covers this case, if I'm not mistaken.
>
> Before my proposed change, yes. After my proposed change, no longer.
> Let's not risk a regression, I'll change the check to:
>
>         if (memcmp(buf, "_SM_", 4) == 0 &&
>             buf[5] >= 30 && buf[5] <= 32 &&
>             dmi_checksum(buf, buf[5])) {
>
> I'll also add a comment stating why we are allowing length 30.
>
> Thanks for the valuable feedback,

You're welcome! You may add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
to the resulting patch.

-- 
With Best Regards,
Andy Shevchenko
