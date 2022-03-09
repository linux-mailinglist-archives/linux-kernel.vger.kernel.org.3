Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB14D3156
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiCIO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiCIO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:58:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D824CBCB7;
        Wed,  9 Mar 2022 06:57:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9338BB8219D;
        Wed,  9 Mar 2022 14:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDECC340F8;
        Wed,  9 Mar 2022 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646837865;
        bh=6BJrQm2h1J2OY3VK6//zKnwW77BTHtKjFjCTeghGA24=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CsKyANBK4z4QOk3hQM4mL19WS2r/c/+81pSYudaqm6XlDTwNu8/ByTI3DYl4XPEig
         SN+kg+7HVG4gDAEjJOwoFHsmIzOwUkVqYEOnIaOZ02jZC/kdg4morOGJEOftfYLPkk
         C0KKEBFOs8cDwnyJBw2OpLq/XrcYTclHyd3P4VE2A0GWNQjbLB9NQMw140iHhYZy9g
         mFQfSJqLvrs1KCsif3RXSaPkhYOARZRXbrk247hwSbF2slQN5jWnzixgz2cerrF6Y5
         Af1CFV8EAiwDoFY/AMziNkAYHVzLuH3stF3w5vrMUIvv/PONzG11vYvUGo5dBTsSBN
         TCxW76RMLaBzQ==
Received: by mail-yb1-f179.google.com with SMTP id l2so4886717ybe.8;
        Wed, 09 Mar 2022 06:57:45 -0800 (PST)
X-Gm-Message-State: AOAM533BIh3CQTN3vMMoYZth/avZHYJo9DljqTFxJAg7eKA49sE4GWIz
        t6RdKrRInOxff9GdaaXmt8QbQRTwhPq+lCjEX0Y=
X-Google-Smtp-Source: ABdhPJzpd3QIfptlaX4atYC2iUwUOczKrcEYHMBJ02IWhhij4ZlS3aT9tYdD3uGnF0iP1VVsnn20E+LWbDoMgo3bQCI=
X-Received: by 2002:a25:53c4:0:b0:628:a0de:b4d6 with SMTP id
 h187-20020a2553c4000000b00628a0deb4d6mr6487ybb.299.1646837864344; Wed, 09 Mar
 2022 06:57:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtpy8VgK+ag6OsA9TDrwi5YGU4hu7GM8xwpO7v6LrCD4Q@mail.gmail.com>
 <YiiDZ7jjG38gqP+Q@shell.armlinux.org.uk> <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
 <CA+G9fYvCvBBi+dZ+CnUy=ZK6GhCFhBw72_==Cav=Q8QP5T1r5w@mail.gmail.com> <CA+G9fYt73AYs=z-BeZh22RBp==sf73pKky6m4iPSH7a4FssK7w@mail.gmail.com>
In-Reply-To: <CA+G9fYt73AYs=z-BeZh22RBp==sf73pKky6m4iPSH7a4FssK7w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Mar 2022 15:57:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
Message-ID: <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 15:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 9 Mar 2022 at 19:37, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Wed, 9 Mar 2022 at 16:16, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 9 Mar 2022 at 11:37, Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Wed, Mar 09, 2022 at 03:18:12PM +0530, Naresh Kamboju wrote:
> > > > > While boting linux next-20220308 on BeagleBoard-X15 and qemu arm the following
> > > > > kernel crash reported which is CONFIG_KASAN enabled build [1] & [2].
> > > >
> > > > The unwinder is currently broken in linux-next. Please try reverting
> > > > 532319b9c418 ("ARM: unwind: disregard unwind info before stack frame is
> > > > set up")
>
> I have reverted the suggested commit and built and boot failed due to reported
> kernel crash [1].
>
> - Naresh
>

Thanks Naresh,

This looks like it might be related to the issue Russell just sent a fix for:
https://lore.kernel.org/linux-arm-kernel/CAMj1kXEqp2UmsyUe1eWErtpMk3dGEFZyyno3nqydC_ML0bwTLw@mail.gmail.com/T/#t

Could you please try that?
