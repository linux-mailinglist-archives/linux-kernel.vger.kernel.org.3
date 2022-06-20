Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7626551527
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbiFTKDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiFTKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE3D13E94
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F02B460A75
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82D4C3411B;
        Mon, 20 Jun 2022 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655719363;
        bh=o96UY7ctQbfQ+9tK5lG6lV/L3xcpN6cyu1f67SgzsaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f5k8Bw25wH9UfZHPLy2Tiv5ciWchqhncf+sL98HL6CKewM721O+P+FzGM+G6mpYvN
         SPqiEyAsXLp/MovNAXDQ6o+OH16wtIKNQLlGAY51o6EQhmRQzajTOlyK4XuYebWTkS
         uM7ffuz9feoonojr41osJIzBYWfHvpGN2UfqQB+8wd59uHvUUImqOYfGeJPnQPWtZL
         kuiyU3RCyjstpESfbadMV6CNQwcPEbpe4XGxm0q4tUTsTwj6VTt/ApwgXrc5LnKRUQ
         e6KQP/drumJ8aELQEhYpQwgtHofMzusEcVhOrHfvrD08pbThQvJvCLwp+SfL4KVIX/
         8Rk5DvYT2JUuA==
Date:   Mon, 20 Jun 2022 12:02:34 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot stall regression from "printk for 5.19" merge
Message-ID: <20220620120234.5a65ac97@thinkpad>
In-Reply-To: <YrAEUM20n3Rc4aOn@google.com>
References: <20220619204949.50d9154d@thinkpad>
        <YrAEUM20n3Rc4aOn@google.com>
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

On Mon, 20 Jun 2022 14:23:28 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (22/06/19 20:49), Marek Beh=C3=BAn wrote:
> [..]
> > causes a regression on arm64 (Marvell CN9130-CRB board) where the
> > system boot freezes in most cases (and is unusable until restarted by
> > watchdog), or, in some cases boots, but the console output gets mangled
> > for a while (the serial console spits garbage characters). =20
>=20
> Can you please try disabling console kthreads and see how the boot
> process goes? Just `return 0` from printk_activate_kthreads() (I think
> this should do the trick).

This indeed makes the problem go away...

>=20
> > The stall example:
> >=20
> >   ...
> >   [    1.108141] io scheduler mq-deadline registered
> >   [    1.108143] io scheduler kyber registered
> >   [    1.163484] armada-ap806-pinctrl f06f4000.system-controller:pinctr=
l: registered pinctrl driver
> >   [
> >=20
> > Or another:
> >=20
> >   ...
> >   [    1.108155] io scheduler mq-deadline registered
> >   [    1.108156] io scheduler kyber registered
> >   [    1.162991] armada-ap806-pinctrl f06f4000.system-controller:pinctr=
l: registered pinctrl driver
> >   [    1.163361] armada-cp110-pinctrl f2440000.system-controller:pinctr=
l: registered pinctrl driver
> >   [    1.180827] mv_xor_v2 f0400000.xor: Marvell Version 2 XOR driver
> >   [ =20
> >=20
> > The garbage example:
> >=20
> >   ...
> >   [    0.920951] raid6: using neon recovery algorithm
> >   [    0.921228] iommu: Default domain type: Translated
> >   %
> >=20
> >           gb@k+cFL/[    4.954974] DSA: tree 0 setup
> >   [    4.955286] cfg80211: Loading compiled-in X.509 certificates for r=
egulatory database =20
>=20
> This is pretty suspicious. I don't see how console kthreads would
> corrupt the output. I suspect that something else is going on, some
> memory corruption, etc.

Maybe multiple threads are writing to serial registers, or something...

Marek
