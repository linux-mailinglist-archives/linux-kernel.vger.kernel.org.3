Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D414D2D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiCIKrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiCIKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:47:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55C6C941;
        Wed,  9 Mar 2022 02:46:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C878BB82021;
        Wed,  9 Mar 2022 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3B8C340F5;
        Wed,  9 Mar 2022 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646822805;
        bh=GvTSs4P6z3GIxElft6y3pJ5+df73IMKa3LB60AFyHIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aErSMPJJ6BLrUbfxJ4lK0iPuz5ZuRX8lqChT4uFXgldtX75U6Qr9UF9jajFgG84mp
         9CPa16zaTn6UbfEgN9IoDS8ZYf+nMiDaDfl+QCFpc8JWV8ldt7SdBhhgO/0U9XCz9I
         ntncqIBXDiF2WfbW2rHZIdjX6tFXtZAEvwboN27Du4f+3MU7MxFWW18CHbOWuci9hs
         YrO7DJc2IRWpMc7W4dGPoo3rbg5mLqSHXpQgSuK5BPai26DOFtpBgDlnW5n+1QG39C
         hVDx7ZGfsLbpbVJA45FWQjaU2VoN+02ua/ClUNlteYNfAKHbCAv8JyKR018tahxO0M
         dt71slNyClHkA==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2d07ae0b1c4so17630087b3.11;
        Wed, 09 Mar 2022 02:46:45 -0800 (PST)
X-Gm-Message-State: AOAM530fbUalr2mYeELCCLc9Fm95ALfggsmHKw4NfbuIB72XRgZxeQaH
        EJmy6RtwU1OdOnbGZ1CXhaVY6wCZG3p6Gw6288E=
X-Google-Smtp-Source: ABdhPJxebShjEm9UHUIQxwem6w1TszlWZWcH9CKYz0YyIgdmSyNqydFUrpONgEXdLimdVAv3xZM5ZuE9kunQrOg0sNg=
X-Received: by 2002:a81:e90c:0:b0:2db:d63e:56ff with SMTP id
 d12-20020a81e90c000000b002dbd63e56ffmr16991596ywm.60.1646822804316; Wed, 09
 Mar 2022 02:46:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtpy8VgK+ag6OsA9TDrwi5YGU4hu7GM8xwpO7v6LrCD4Q@mail.gmail.com>
 <YiiDZ7jjG38gqP+Q@shell.armlinux.org.uk>
In-Reply-To: <YiiDZ7jjG38gqP+Q@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Mar 2022 11:46:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
Message-ID: <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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

On Wed, 9 Mar 2022 at 11:37, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 09, 2022 at 03:18:12PM +0530, Naresh Kamboju wrote:
> > While boting linux next-20220308 on BeagleBoard-X15 and qemu arm the following
> > kernel crash reported which is CONFIG_KASAN enabled build [1] & [2].
>
> The unwinder is currently broken in linux-next. Please try reverting
> 532319b9c418 ("ARM: unwind: disregard unwind info before stack frame is
> set up")
>

Yeah.

This is the same spot Corentin hit before, where the double
dereference of vsp is not guarded by anything like
get_kernel_nofault(). We should probably fix that, but that doesn't
address the underlying issue, of course.

I'm a bit puzzled, though, that this appears now, and didn't before.

Naresh, I take it you did not see this occurring on earlier linux-nexts?

I'll try to reproduce this, and see if I can make sense of it. In the
mean time, please do the revert Russell suggested, and if that doesn't
help, maybe try a bisect?
