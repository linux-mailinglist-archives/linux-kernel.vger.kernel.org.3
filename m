Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856FA598D83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbiHRUO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbiHRUOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:14:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1CFD276D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB2A61488
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B010FC433D6;
        Thu, 18 Aug 2022 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660853562;
        bh=kqSDJYDlk+GZoTBDy/G+LCULfAbmCJdE3oXWaVevqOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KATih+84YFLy5PxMeIZjKJkIsTKk+XKcG8JcMHzR4IJVXlJQRhy82ziejaEos1i7s
         Y3i0nL2ImEBYVKuHb1X0HbRV+wvGQ1kHwQpDKlfaDqIR8PMCcXCDI1RR+jMP/peh2P
         G5c/qGo5TKeEtPYrBU5Eym6FeP3HE4VPlG0sdtxo/BZwl75K+jUwmehnTZao5fc/2i
         D01Nc/SjxwGeEjcXP3I37isiViWdp/03rwNXUw0VWxoqrBkHzwc1PhxhBCk3s5OXUv
         hZhAbum/QDM9Hi9c7Ic/HJhQ9DtPfuO6NmNQpoxcuFZyMerhxMyiAw2ehuq+BUIrOM
         EqCq9AVQtztaw==
Date:   Thu, 18 Aug 2022 22:12:36 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        josef.schlehofer@nic.cz
Subject: Re: [PATCH linux-phy v2 1/4] string.h: Add str_has_proper_prefix()
Message-ID: <20220818221236.7b16db07@thinkpad>
In-Reply-To: <CAHp75VfN1_0Wgop3Fx4DP2ECRTi9gUV87eUQhKgs4LfYGTzbpA@mail.gmail.com>
References: <20220817200335.911-1-kabel@kernel.org>
        <20220817200335.911-2-kabel@kernel.org>
        <CAHp75VecURpGCBY3WVKqhd64Ngobjvi-w=PuHQBH2V-MqCzkuw@mail.gmail.com>
        <20220818214828.22023dc7@thinkpad>
        <CAHp75VfN1_0Wgop3Fx4DP2ECRTi9gUV87eUQhKgs4LfYGTzbpA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 22:56:14 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 18, 2022 at 10:48 PM Marek Beh=C3=BAn <kabel@kernel.org> wrot=
e:
> > On Thu, 18 Aug 2022 22:10:58 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > On Wed, Aug 17, 2022 at 11:06 PM Marek Beh=C3=BAn <kabel@kernel.org> =
wrote: =20
>=20
> ...
>=20
> > > Besides not the good naming (what 'proper' means), =20
> >
> > The naming comes from similar naming in math: proper subset is as
> > subset that is not equal to the superset. See
> > https://en.wikipedia.org/wiki/Substring :
> >   "A proper prefix of a string is not equal to the string itself" =20
>=20
> It's nice to learn something, but I still think that name has too
> broad meaning(s) that may easily confuse the developers.
>=20
> > =20
> > > the entire function is not needed. You may simply call
> > >
> > >   str_has_prefix() && p[len] !=3D '\0';
> > >
> > > Correct? =20
> >
> > Do you mean that I should implement this function to simply return
> >   str_has_prefix() && p[len] !=3D '\0'
> > or that this function should not exist at all and I should do that in
> > the code where I would have used the function? =20
>=20
> The latter since this seems do not have users, except a single newcomer,
>=20

Just out of curiosity I grepped for all usages of str_has_prefix() and
there are some where it str_has_proper_prefix() could detect failure
earlier. For example in kernel/trace/trace_events_user.c in function
user_field_size().

Do you think I should propose converting those? There aren't that many
uses, so probably not.

Marek

