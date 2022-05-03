Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5C517EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiECHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiECHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:32:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5F36335;
        Tue,  3 May 2022 00:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E7B8B81CA7;
        Tue,  3 May 2022 07:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E63C385B4;
        Tue,  3 May 2022 07:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651562936;
        bh=An4l1Y7GJUH5wN5pzbLPaMxdyCEWxfCi8+OSUuFew+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eOyf0uVjMcK9EXBoXNGlPtOBO9/w14atentNejxZz2Qh2BaUWL+xwrx1XZ0sC4+sS
         RSSYpdy5sMK3Cylrd3WbuN9jPBQH0RJlsyPxfHcOSfa//EMznMrN1If2Xn2zqekEwg
         8Y/Agkwnn0lcag+0lBGEhz/r5QGGbVIW5x/RN5VI/ONKJRG2hfXEBFNKjRXmyrcfc5
         igtm0h6qmvos1FZvHVPb8JKO6Cs3UnTAgL1IE8WyALOhKagSJIwFMwsRX3GCnKXJA4
         0HngM3H5GwMG3hBEOLXruISHesArZkECfTWkVXW8Nj8q3YPRGDOcFFGelO+lscLWAH
         kZtqxlP1bdKGA==
Received: by mail-oi1-f179.google.com with SMTP id q8so16981360oif.13;
        Tue, 03 May 2022 00:28:56 -0700 (PDT)
X-Gm-Message-State: AOAM531yL7Hgh1aJiFmMdATZxRKjqjLYrkomvvKUBhCmpQN2JQ4Enqsm
        wSKZHA7LvzLzN6ci41s6YnALiHn3+XV+trmlHo4=
X-Google-Smtp-Source: ABdhPJwz8zIqcnZCZlrTwbBgWNwYTu8rDQC1tRxTgPIW3hyqDf8vMF3Z9MVR4qYEOJtB7xs67ZpYrhzx9nYB4zBxmI4=
X-Received: by 2002:a05:6808:1141:b0:325:cd92:ef8d with SMTP id
 u1-20020a056808114100b00325cd92ef8dmr1302131oiu.228.1651562935307; Tue, 03
 May 2022 00:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com>
 <YmkBAsa+fKlp/GcV@atomide.com> <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
 <4CE23DC3-B3E5-45C1-91F3-B88E5444AE7C@goldelico.com> <CAK8P3a3EFfF0gr5kFkboRfJifrY-D+NgHFekBfSePWuY2c8PMA@mail.gmail.com>
 <11504A17-6B50-4D6C-A9E1-CA943C157C93@goldelico.com> <CAK8P3a2RN77ajZD4xRhKsqozPizneLcLYhm0rTE6qX25-4cJsw@mail.gmail.com>
In-Reply-To: <CAK8P3a2RN77ajZD4xRhKsqozPizneLcLYhm0rTE6qX25-4cJsw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 May 2022 09:28:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqHCt9G+HEawsWmba2Z=WVbp6wRrivAQvQCn2iph9kXg@mail.gmail.com>
Message-ID: <CAMj1kXHqHCt9G+HEawsWmba2Z=WVbp6wRrivAQvQCn2iph9kXg@mail.gmail.com>
Subject: Re: kernel panic with v5.18-rc1 on OpenPandora (only)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 at 20:48, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Apr 30, 2022 at 7:18 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> > > Am 30.04.2022 um 17:36 schrieb Arnd Bergmann <arnd@arndb.de>:
> > >
> > >
> > > I suppose this could be anywhere then. The backtrace seems to point
> > > to re-enabling interupts in do_work_pending, so something probably
> > > accessed DMA memory asynchronously.
> >
> > Yes. I now (or still) sometimes see the same omap l3 irq issue when plugging in/out the USB/OTG
> > cable. Not with a kernel panic, but in the same driver omap_l3_smx.c.
> > This happens even if the wl1251 driver is removed.
>
> Is this also a regression, or did it happen before the vmap-stack
> change? If this only
> appeared now, then this points to another bug somewhere that you
> should find using
> CONFIG_DMA_API_DEBUG.
>
> I think what is going on here is that your platform is able to detect
> the broken DMA
> because of the l3 interrupt handler telling the kernel about it, when
> on other platforms
> we would see either silent data corruption or a DMA that never reaches
> its target.
>

I wonder if we could narrow this down by adding the possibility to use
IRQ stacks in the linear map, while using vmap'ed task stacks.
