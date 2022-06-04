Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D5353D662
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiFDKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiFDKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:16:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC12CC93;
        Sat,  4 Jun 2022 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1654337789;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=k2CeLLJk8IKpfoJJqI76qTO2GTN4yxtENEPA2pWHYqA=;
    b=QBs1+O8KXbUjcO1J8on5lNuqCDK1imYSBsU9Q0VZBafHzdo8s2v+t0SINrSREEDJEY
    ChXMYdMXxu+gxT3OtgXoWUxvJGtZ7VeC5eJCKeMn28zLjg7tSxBa7AurabfNSO3lpgXn
    4t0qEBGWRianAsfAqLHdpR0t+1KvrPS62ofblIYXeD2KUrA1hk9uzl/Kjn9rUQDqIY7T
    BfkhUXHt017hO8KNyb+XtFY9ib6zfkr3sRkG0MzDLEFCbTgugTs748MitDL3mRExtg1N
    BYG4rOlIZJsFRlXGxVvGl3gHV2JFA4BZsRw+BNevwDTtL8VjxYSk7QUD9YJjgDsVYCpE
    gyyg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw43tkwA="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.44.0 DYNA|AUTH)
    with ESMTPSA id e48d97y54AGTlfJ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 4 Jun 2022 12:16:29 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: BUG in mmc: core: Disable card detect during shutdown
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAPDyKFrjH8c=2LYkzj81jm7t-sy-EBs3AMzAS7M=LEHsh9qCCA@mail.gmail.com>
Date:   Sat, 4 Jun 2022 12:16:28 +0200
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com, aTc <atc@k-n-p.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA636A4D-FA8F-48EE-80C4-EDDFD115FB25@goldelico.com>
References: <55A0788B-03E8-457E-B093-40FD93F1B9F3@goldelico.com>
 <CAPDyKFrjH8c=2LYkzj81jm7t-sy-EBs3AMzAS7M=LEHsh9qCCA@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 03.06.2022 um 12:46 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>=20
> On Mon, 30 May 2022 at 18:55, H. Nikolaus Schaller <hns@goldelico.com> =
wrote:
>>=20
>> Hi Ulf,
>> users did report a strange issue that the OMAP5 based Pyra does not
>> shutdown if a kernel 5.10.116 is used.
>>=20

...

>> mmc_stop_host() is not called but __mmc_stop_host() is called 4 =
times.
>> There are 4 active MMC interfaces in the Pyra - 3 for (=C2=B5)SD =
slots
>> and one for an SDIO WLAN module.
>>=20
>> Now it looks as if 3 of them are properly teared down (two of them
>> seem to have host->slot.cd_irq >=3D 0) but on the fourth call
>> cancel_delayed_work_sync(&host->detect); does not return. This is
>> likely the location of the stall why we don't see a "reboot: Power =
down"
>>=20
>> Any ideas?
>=20
> I guess the call to cancel_delayed_work_sync() in __mmc_stop_host()
> hangs for one of the mmc hosts. This shouldn't happen - and indicates
> that there is something else being wrong.

Yes, you were right...

>=20
> See more suggestions below.
>=20
>>=20
>> BR and thanks,
>> Nikolaus
>>=20
>> printk hack:
>>=20
>> void __mmc_stop_host(struct mmc_host *host)
>> {
>> printk("%s 1\n", __func__);
>>        if (host->slot.cd_irq >=3D 0) {
>> printk("%s 2\n", __func__);
>>                mmc_gpio_set_cd_wake(host, false);
>> printk("%s 3\n", __func__);
>>                disable_irq(host->slot.cd_irq);
>> printk("%s 4\n", __func__);
>>        }
>>=20
>>        host->rescan_disable =3D 1;
>> printk("%s 5\n", __func__);
>=20
> My guess is that it's the same mmc host that causes the hang. I
> suggest you print the name of the host too, to verify that. Something
> along the lines of the below.
>=20
> printk("%s: %s 5\n", mmc_hostname(host), __func__);

To my surprise, this did report an mmc6 host port where the OMAP5 only =
has 4...

Yes, we have a special driver for the txs02612 sdio switch and voltage =
translator
chip to make two ports out of the single mmc2 port of the OMAP5 SoC.

This driver was begun ca. 7 years ago but never finished...

The idea is to make a mmc port have several subports. For the Pyra =
handheld hardware
we needed 5 mmc/sdio interfaces but the omap5 only has 4 of them =
available to us.

So the txs02612 drivers is sitting between the omap5 mmc2 host pins and =
switches
between an =C2=B5SD slot and an eMMC.

Therefore, the driver is a mmc client driver (like e.g. the driver of =
some WiFi chip
connected to some SDIO port) and provides multiple mmc host interfaces.

It should intercept data transfer requests to its multiple mmc hosts, =
synchronize
(or enqueue) them, control the switch gpio and forward requests to the =
processor's
mmc host port so that they are processed (after switching).

We never continued to make this work...

What remained is simple code to manually throw the switch through some =
/sysfs
control file after doing an eject and before a fresh partprobe.

Still, the probe function of the txs02612 driver does two calls to =
mmc_add_host().
These seem to make=20

>=20
>>        cancel_delayed_work_sync(&host->detect);

get stuck. Most likely because the initialization is not complete for =
handling
card detection.

>>=20
>> --- here should be another __mmc_stop_host 6
>> --- and reboot: Power down
>=20
> When/if you figured out that it's the same host that hangs, you could
> try to disable that host through the DTS files (add status =3D
> "disabled" in the device node, for example) - and see if that works.

When not calling mmc_add_host() in our txs02612 driver fragment we can
properly shut down the OMAP5. That is the solution with the least =
efforts.
The other would be to make the txs02612 properly work...

So in summary there is no bug upstream. It is in our tree.

If you are interested in how our code fragment for the txs02612 looks =
like:

=
https://git.goldelico.com/?p=3Dletux-kernel.git;a=3Dshortlog;h=3Drefs/head=
s/letux/txs02612

Maybe you have some suggestions to make it work?

>=20
> Kind regards
> Uffe

BR and thanks,
Nikolaus

