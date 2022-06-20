Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFAD5515DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiFTK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiFTK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:29:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F714037
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E30EB81015
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F9DC3411C;
        Mon, 20 Jun 2022 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655720958;
        bh=k/cfrxW1y5fQVkYFe7aqp8xYU2NtiTYd7uNodGG4c3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mcmlT9NjEjG2YgqIp2JdN/d+SHL1kw4w6Rxr4hf6KsWRqUKlKZzXuFBSL46dIeRK4
         srcoEAFWEeamz/chlHQDNOh52ocyiBLPiHIByAK3DbDjSxZP6qasJG/7I4b5wNYJgn
         4zwfbYuzJ2lWoLj+6S8LHXjkfk3DdkbH/o7N8BPWOOkAL9YAF8bmnX62xmU7x+l/ex
         pJUo2+bEUNEXrAIIZ0WmOLkkmFQUfAC+ii/CC7pf82KDNHY2xY7XXbs9px+joCwRlp
         0js5dEkiJuUmewpIvIFcgYUKl9hWB0z7EiYLJRz8jI0gYzZfjdv3i8/ODH18WnGWTp
         titt2W96mpX+g==
Date:   Mon, 20 Jun 2022 12:29:04 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot stall regression from "printk for 5.19" merge
Message-ID: <20220620122904.30c06c4e@thinkpad>
In-Reply-To: <YrBIURn7lxykWghw@google.com>
References: <20220619204949.50d9154d@thinkpad>
        <YrAEUM20n3Rc4aOn@google.com>
        <20220620120234.5a65ac97@thinkpad>
        <YrBIURn7lxykWghw@google.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 19:13:37 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (22/06/20 12:02), Marek Beh=C3=BAn wrote:
> > > On (22/06/19 20:49), Marek Beh=C3=BAn wrote:
> > > [..] =20
> > > > causes a regression on arm64 (Marvell CN9130-CRB board) where the
> > > > system boot freezes in most cases (and is unusable until restarted =
by
> > > > watchdog), or, in some cases boots, but the console output gets man=
gled
> > > > for a while (the serial console spits garbage characters).   =20
> > >=20
> > > Can you please try disabling console kthreads and see how the boot
> > > process goes? Just `return 0` from printk_activate_kthreads() (I think
> > > this should do the trick). =20
> >=20
> > This indeed makes the problem go away... =20
>=20
> Oh... OK. Didn't expect that :)
>=20
> > > > The garbage example:
> > > >=20
> > > >   ...
> > > >   [    0.920951] raid6: using neon recovery algorithm
> > > >   [    0.921228] iommu: Default domain type: Translated
> > > >   %
> > > >=20
> > > >           gb@k+cFL/[    4.954974] DSA: tree 0 setup
> > > >   [    4.955286] cfg80211: Loading compiled-in X.509 certificates f=
or regulatory database   =20
> > >=20
> > > This is pretty suspicious. I don't see how console kthreads would
> > > corrupt the output. I suspect that something else is going on, some
> > > memory corruption, etc. =20
> >=20
> > Maybe multiple threads are writing to serial registers, or something...=
 =20
>=20
> That's possible. Console drivers usually should grab port->lock for
> write(), but maybe something is missing in the driver you use. What
> console driver are you using?

compatible =3D "snps,dw-apb-uart", so drivers/tty/serial/8250/8250_dw.c

seems that the function dw8250_serial_out() does not use the spinlock...

Marek
