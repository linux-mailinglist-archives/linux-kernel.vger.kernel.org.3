Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C83598D75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbiHRUKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345892AbiHRUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32594D21DB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CCD461458
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3FBC433C1;
        Thu, 18 Aug 2022 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660853027;
        bh=IeUfviVB25387GkpWnclXYp8ePJifeEM+3lrJ3qxfwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZG4UqLSfbXDvPv8EIV23mRe6BfblTvnqOMdcHvLUKp2+AhZk71SXjlr2EglrMefSs
         yb0hWyDhJSEa+5W9kB++u/dymS58r7nwgBfYNpKUDpBGjt1dVXFAuMQ7cK7rKM64nH
         UxiGYtdVFdVYHk3f5SyhG9WsCZ4+SpoN5vtPtKauDQuJifGjmVJqI0W5gvFnBo5nbR
         B3tVzeUatQt0l+wKQ1GmxAkksTKPgi27iNYFMVnegLKkzKvaE36G12piO0OAB7vFJH
         nhvaSU2O69ea+fI0VsA8hUHgyKxn/XyP3kMXZbYZqNSwhHk8itVFjgEPRNBKqZt2VG
         KgH/7SLleK0Ew==
Date:   Thu, 18 Aug 2022 22:03:40 +0200
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
Message-ID: <20220818220340.78901438@thinkpad>
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

Very well. Thanks for the review.

Marek
