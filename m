Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1274C46C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiBYNkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbiBYNko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:40:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C9F210479
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:40:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8522B61D71
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7918C340E7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:40:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BP8PI9QX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645796408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8VXJAP3fuSvkaijaWBFyKjF1tvEq3GomC0BNGkN+AZA=;
        b=BP8PI9QXrOXf9xctrBWDKUQTHL3N9rtobRUngFvTdzhprgqDB6QWdPKvecq+PJRULNx8VX
        CVPOdHC8w6GbndfVwvNTy+1yjkundtaLokbU+bHMPjV4Vpqi15QLkcPVr+3oQ5Pw+Z1jW+
        BcETwwtclIQMU9+kXyQV9eRa66tEwhs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 843e17ea (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 25 Feb 2022 13:40:08 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id b35so5890690ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:40:07 -0800 (PST)
X-Gm-Message-State: AOAM530QXBAPPQDAQc4OgL4puRBaZN92x867DRz/ulEErLt6I4GNE631
        /QTXHbUVIMPksOm+TVDNrQwq2ZyD1r+KuvsG6Zo=
X-Google-Smtp-Source: ABdhPJx28OCrQPe/AoMYKtJYcemBkYQ/gfQvU2O4YL/eslqO4ol9lIq8Kvvo59Iv3HsHVK5ag0SnX9JhhA9kGxwfceg=
X-Received: by 2002:a5b:6cf:0:b0:61e:1371:3cda with SMTP id
 r15-20020a5b06cf000000b0061e13713cdamr7277226ybq.235.1645796407233; Fri, 25
 Feb 2022 05:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20220224173948.34045-1-Jason@zx2c4.com> <20220224213030.75400-1-Jason@zx2c4.com>
 <Yhh+IJftHEZcHdEn@owl.dominikbrodowski.net>
In-Reply-To: <Yhh+IJftHEZcHdEn@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 25 Feb 2022 14:39:56 +0100
X-Gmail-Original-Message-ID: <CAHmME9qsj-Ge0LAXwFjtaMpY6W-G_fB7fTdXQ3rKRGpVpHnDnw@mail.gmail.com>
Message-ID: <CAHmME9qsj-Ge0LAXwFjtaMpY6W-G_fB7fTdXQ3rKRGpVpHnDnw@mail.gmail.com>
Subject: Re: [PATCH v2] random: unify cycles_t and jiffies usage and types
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 8:06 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> maybe "flags, now = jiffies" is a bit more reader-friendly?

Good idea. Will do.

> >       enum { MIX_INFLIGHT = 1U << 31 };
> > +     cycles_t cycles = random_get_entropy();
> > +     unsigned long now = jiffies;
> >       struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
> >       struct pt_regs *regs = get_irq_regs();
> > -     unsigned long now = jiffies;
> > -     cycles_t cycles = random_get_entropy();
> >       unsigned int new_count;
> >
> >       if (cycles == 0)
>
>
> Why do you change the ordering here?

So that get_cycles() is called as closest to the actual interrupt as
possible, and so that we retain the order as elsewhere of reading
cycles before jiffies.

v+1 on its way.

Jason
