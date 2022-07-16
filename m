Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F5577105
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGPTXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPTXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:23:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F517E37;
        Sat, 16 Jul 2022 12:23:41 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DB4566016A1;
        Sat, 16 Jul 2022 20:23:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657999419;
        bh=Hzk9ep426NKaWWxmuzF3OGnr6jyChpNw7cVZGou7UbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FI5KRhwedJm46o+g5HPlupVcJO5uiEfzDGo99BFMBPOvW6H0kVILoaGwxkuaMkSji
         tXitWs97JkxCvEf+Ycgc/4VuraZYSJj9HNGF03GhoRBYrUuPxSoyH+7F8dJLCdBJIQ
         rKtp5Zrxyc0hfriHZ8LDPuvJDXoSAutOUW9Y1xfIBzQGHvQtIskDB1DQ+dlPH1iT2q
         MguBsYjvH2WgKFpZluUST17eiTv7SBOf6JYJmwb31cxcD6vBsWDz16LgD+DNA9oBKX
         PH5bRzdydUWTh5i+q4k7XtgkNSl+GUZk9yR/vRUCmdXceW/wgIJAxxVfMja5pWXMQc
         Q0kdr1jkS466A==
Received: by mercury (Postfix, from userid 1000)
        id DC9DE106069E; Sat, 16 Jul 2022 21:23:36 +0200 (CEST)
Date:   Sat, 16 Jul 2022 21:23:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     t.schramm@manjaro.org, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] power: supply: cw2015: Found a bug when removing the module
Message-ID: <20220716192336.ccxwopvaurtcef4p@mercury.elektranox.org>
References: <CAMhUBjkMyRP2iyMpovN7=GFP2SSpt+Na453RR6nNSBeyQR6oww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgwp5xb6gbex7tbk"
Content-Disposition: inline
In-Reply-To: <CAMhUBjkMyRP2iyMpovN7=GFP2SSpt+Na453RR6nNSBeyQR6oww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgwp5xb6gbex7tbk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 16, 2022 at 04:50:08PM +0800, Zheyu Ma wrote:
> I found a bug in the cw2015 driver.
>=20
> When I insmod the kernel module, I get the following log:
>=20
> [  199.445154] cw2015 0-0010: probe
> [  199.445447] cw2015 0-0010: No battery-profile found, using current
> flash contents
> [  199.447198] cw2015 0-0010: Can't check current battery profile, no
> profile provided
> [  199.448577] cw2015 0-0010: No monitored battery, some properties
> will be missing
> [  199.449556] i2c-core: driver [cw2015] registered
> [  199.482970] cw2015 0-0010: No profile specified, continuing without pr=
ofile
> [  199.486086] cw2015 0-0010: Failed to get supply state: -19
>=20
> And when I remove the module, I got the following warning:
>=20
> [  200.470198] cw2015 0-0010: remove
> [  200.471445] ------------[ cut here ]------------
> [  200.472752] WARNING: CPU: 0 PID: 413 at drivers/base/devres.c:1058
> devm_kfree+0x2a8/0x330
> [  200.478314] RIP: 0010:devm_kfree+0x2a8/0x330
> [  200.485019] Call Trace:
> [  200.485226]  <TASK>
> [  200.485405]  ? power_supply_put_battery_info+0xc2/0xe0
> [  200.486169]  cw_bat_remove+0x89/0xa0 [cw2015_battery]
> [  200.486570]  i2c_device_remove+0x181/0x1f0
>=20
> I think the problem is that the driver fails to call the function
> power_supply_get_battery_info(). However, when removing the module,
> the driver executes power_supply_put_battery_info(), causing a
> warning.

Indeed that seems to happen. Easiest solution is to remove the call
to power_supply_put_battery_info(), because power_supply_get_battery_info()
is now using device managed memory allocation for everything and memory
will be free'd automatically when the device is removed. Can one of you
send a patch for that, since I cannot test it due to lack of hardware?

Also while at it maybe use 'devm_delayed_work_autocancel()' instead
of 'INIT_DELAYED_WORK', so that all resources are device managed and
the remove function can be removed.

> Since I'm not familiar with this driver, I will just report the bug to yo=
u.
>=20
> regards,
>=20
> Zheyu Ma

Thanks,

-- Sebastian

--lgwp5xb6gbex7tbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTEDUACgkQ2O7X88g7
+pq6pw/+N0oP/9DNfQ+aQ3gDTnCOlfh5BTwOTsXJf5psMgErsswM1gtp0LcN0nxZ
LhZhTBUslXwAerbXMFN+FKqL1L1KNH/Mu41EmUY6isH2XGD/WmVQxk6NvGSnmq40
3JMgkMK0FvSdILng9j95hw/AkKOJFTIZkwcLLiWekTfhVjJUcqJSIilULCxQBYld
WGsWqsONpA1NNkE3QYsOzXbl3SHDAtQXedetKgYk1T3ACku1/sL/0VTH/GMJAftv
YlQNWpGCiuujDpJQLyXzPa989oSepDEhaTD+ZMkxwiGsQ22uzlWyGRCMCn0bWnie
qs37MkS+CqVF/PA/4vvWzWsjWek6SMw0Q7rVgcaZSjYoinZnJwJj3uajRAZe7/gA
vpxxI2Tt8GSKv9harrH1xKVbNkHWEM8L996oWNPDSJ8odkb8jnvBexej6zhuhUGp
5qScXd9cRdpHgYwSfmIw8pF27+RRatmYInu3qbCJUlsy6fG8s3d+BlE0Bj+ZT0Wt
Lz7Am8u1gPgau0tJTFpC8kJQwRQk4m48QznR7ctcVUbw7cd7U/pxDpFA/YTsq4rP
C59vLtYae9YR5j/Lm0BUMv3k3I+lJixq6EDpaXuC1GKwKthtuXz9CyRHN24hBsQz
8lfEVdpchzREQViVMgUez6WYJyGokeNgmAc3tmdZJygixJ9FrTY=
=5PWL
-----END PGP SIGNATURE-----

--lgwp5xb6gbex7tbk--
