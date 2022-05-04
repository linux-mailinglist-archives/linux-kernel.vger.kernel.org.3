Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6F95192F7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbiEDAtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiEDAth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D82522283;
        Tue,  3 May 2022 17:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAD97618A3;
        Wed,  4 May 2022 00:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A322C385A9;
        Wed,  4 May 2022 00:45:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OZpBZzv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651625158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhAiVHXQWmhs81Nrt7gvkFVDwI8H9x6MfqjaLzCCJ78=;
        b=OZpBZzv6Q/S+weWbYxSCd2P5gOmkFxyC3ZFm1TSb9pf656IRdrw2NOKGrQUpDck1lKpwM9
        HxaxB7AiRZHGdCAZ3cfp/Z6J1NctIZoVhuvic9IvzRPfQbxxsvv0B2PR0mhHBUJGOmHUdo
        WGKyVy4C0Vt9Hgbydm0mAc05qajGPCs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 11dd7b67 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 00:45:57 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2f7ca2ce255so565057b3.7;
        Tue, 03 May 2022 17:45:57 -0700 (PDT)
X-Gm-Message-State: AOAM530BSzqWIqznK9egzj4SRMZjf/yv8NrXE9nCUJlJI+0NAVRD+TrZ
        3G3tvHkrVJroNBcH0zKF8Vp5dtbChYC1Zv+VJAk=
X-Google-Smtp-Source: ABdhPJw2U8dilBujiplVWnwWPnq6AoB6zAETj6rRKMpGI4/rNa1BeoG/ZIj/+lFIicpd3pP4wjy1JTaNwpC9yaRaAWY=
X-Received: by 2002:a81:5ad6:0:b0:2f8:f7d5:dc6c with SMTP id
 o205-20020a815ad6000000b002f8f7d5dc6cmr14505979ywb.396.1651625156924; Tue, 03
 May 2022 17:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220503195141.683217-1-Jason@zx2c4.com> <YnGI4lZVJ/FZEkcn@owl.dominikbrodowski.net>
In-Reply-To: <YnGI4lZVJ/FZEkcn@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 4 May 2022 02:45:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9o1zhtq=bMetwEx7YEzoW79z36BQ=vTWEv4M_ocChm5eA@mail.gmail.com>
Message-ID: <CAHmME9o1zhtq=bMetwEx7YEzoW79z36BQ=vTWEv4M_ocChm5eA@mail.gmail.com>
Subject: Re: [PATCH] random: mix hwgenerator randomness before sleeping
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Dominik,

On Tue, May 3, 2022 at 9:56 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Am Tue, May 03, 2022 at 09:51:41PM +0200 schrieb Jason A. Donenfeld:
> > The add_hwgenerator_randomness() function is called in a loop from a
> > kthread by the hwgenerator core. It's supposed to sleep when there's
> > nothing to do, and wake up periodically for more entropy. Right now it
> > receives entropy, sleeps, and then mixes it in. This commit reverses the
> > order, so that it always mixes in entropy sooner and sleeps after. This
> > way the entropy is more fresh.
>
> ... however, the hwgenerator may take quite some time to accumulate entropy
> after wakeup. So now we might have a delay between a wakeup ("we need more
> entropy!") and that entropy becoming available. Beforehand, the thread only
> went to sleep when there is no current need for "fresh" entropy.

Huh, interesting consideration. I didn't think about that. You wrote,
"hwgenerator may take quite some time to accumulate entropy" -- any
idea how long in the worst case? A second? A minute?

Jason
