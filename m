Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0235A538670
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiE3Qz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiE3Qzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:55:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4D2A8886;
        Mon, 30 May 2022 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653929748;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=3stp/0ZU+iCDZnHMwdfUDlVByYs+4oPnlnDY02SV4QE=;
    b=J+BmhvkW2r5Tp7brxW57HQc+WtIYnBopbETIufk52yfnEvEFZ5As8kM5YKq4bAeGYz
    Lq9pdn7aVwRmbiF4vU+XGkAtqEeSjMpZlu9OgnNTYuhqhJDRhN56iQcrsCy7aAA81dzw
    tKltgUOZ7AM3AO/f8TdkxL+cZTQiFvB69uQqeP2hIgaPuOyCRMbhETDw+QesRd8hk6gk
    bPC30m21FHJXIbRuc8VIOTsZ5uBngHNsAPoOYkGnKMdUTK1nGq49uY78BPNuS6X/nUjz
    gxZRcK2VBNtjVmjF9bPGvvHE1QotP/2rYvjPo36gnYBVQeUC+djtXht5AhSB5vDVEQqo
    yawQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iMIVeg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.44.0 DYNA|AUTH)
    with ESMTPSA id e48d97y4UGtlN5H
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 30 May 2022 18:55:47 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Date:   Mon, 30 May 2022 18:55:46 +0200
Subject: BUG in mmc: core: Disable card detect during shutdown
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com, aTc <atc@k-n-p.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <55A0788B-03E8-457E-B093-40FD93F1B9F3@goldelico.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,TRACKER_ID,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,
users did report a strange issue that the OMAP5 based Pyra does not
shutdown if a kernel 5.10.116 is used.

Someone did a bisect and found that reverting

0d66b395210c5084c2b7324945062c1d1f95487a

resp. upstream

66c915d09b942fb3b2b0cb2f56562180901fba17

solves it.

I could now confirm that it also happens with v5.18.0.
But interestingly only on the Pyra handheld device and not
on the omap5evm (which is supported by mainline).

The symptom is:

a) without revert

root@letux:~# poweroff

Broadcast message from root@letux (console) (Sat Jan  1 01:08:25 2000):

The system is going down for system halt NOW!
INIT: Sending processes the TERM signal
root@letux:~# [info] Using makefile-style concurrent boot in runlevel 0.
[....] Stopping cgroup management proxy daemon: cgproxy[....] Stopping =
cgroup management daemon: cgmanager[....] Stop[ ok bluetooth: =
/usr/sbin/bluetoothd.
[FAIL] Stopping ISC DHCP server: dhcpd failed!
dhcpcd[3055]: sending signal 15 to pid 2976
dhcpcd[3055]: waiting for pid 2976 to exit
[ ok ] Shutting down ALSA...done.
[ ok ] Asking all remaining processes to terminate...done.
[ ok ] All processes ended within 2 seconds...done.
[ ok [[c[....] Stopping enhanced syslogd: rsyslogd.
[ ok ....] Deconfiguring network interfaces...done.
^[[c[info] Saving the system clock.
[info] Hardware Clock updated to Sat Jan  1 01:08:30 UTC 2000.
[ ok ] Deactivating swap...done.
^[[c[   77.289332] EXT4-fs (mmcblk0p2): re-mounted. Quota mode: none.
[info] Will now halt.

b) with reverting your patch

root@letux:~# uname -a
Linux letux 5.18.0-letux-lpae+ #9678 SMP PREEMPT Mon May 30 18:02:28 =
CEST 2022 armv7l GNU/Linux
root@letux:~# poweroff

Broadcast message from root@letux (console) (Sat Jan  1 01:39:15 2000):

The system is going down for system halt NOW!
INIT: Sending processes the TERM signal
root@letux:~# [info] Using makefile-style concurrent boot in runlevel 0.
[FAIL] Stopping cgroup management proxy daemon: cgproxy[....] Stopping =
ISC DHCP server: dhcpd failed!
[....] Stopping cgroup management daemon: cgmanagerdhcpcd[3100]: sending =
signal 15 to pid 3013
dhcpcd[3100]: waiting for pid 3013 to exit
[ ok ] Stopping bluetooth: /usr/sbin/bluetoothd.
[ ok ] Shutting down ALSA...done.
[ ok ] Asking all remaining processes to terminate...done.
[ ok ] All processes ended within 3 seconds...done.
[ ok [[c[....] Stopping enhanced syslogd: rsyslogd.
[ ok ....] Deconfiguring network interfaces...done.
^[[c[info] Saving the system clock.
[info] Hardware Clock updated to Sat Jan  1 01:39:21 UTC 2000.
[ ok ] Deactivating swap...done.
^[[c[   44.563256] EXT4-fs (mmcblk0p2): re-mounted. Quota mode: none.
[info] Will now halt.
[   46.917534] reboot: Power down


What I suspect is that we have multiple mmc interfaces and have
card detect wired up in the Pyra while it is ignored in the
EVM. Is it possible that __mmc_stop_host() never returns in
.shutdown_pre if card detect is set up (and potentially
shut down earlier)?

Setup of mmc is done in omap5-board-common.dtsi and omap5.dtsi.

Out Pyra has a non-upstream device tree where we use
omap5-board-common.dtsi and overwrite it by e.g.

&mmc4 { /* second (u)SD slot (SDIO capable) */
	status =3D "okay";
	vmmc-supply =3D <&ldo2_reg>;
	pinctrl-names =3D "default";
	pinctrl-0 =3D <&mmc4_pins>;
	bus-width =3D <4>;
	cd-gpios =3D <&gpio3 13 GPIO_ACTIVE_LOW>;	/* gpio3_77 */
	wp-gpios =3D <&gpio3 15 GPIO_ACTIVE_HIGH>;	/* gpio3_79 */
};

But I have tried to remove the cd-gpois and wp-gpois. Or make the
mmc interface being disabled (but I may not have catched everything
in first place).

Then I added some printk to mmc_stop_host() and __mmc_stop_host().

mmc_stop_host() is not called but __mmc_stop_host() is called 4 times.
There are 4 active MMC interfaces in the Pyra - 3 for (=C2=B5)SD slots
and one for an SDIO WLAN module.

Now it looks as if 3 of them are properly teared down (two of them
seem to have host->slot.cd_irq >=3D 0) but on the fourth call
cancel_delayed_work_sync(&host->detect); does not return. This is
likely the location of the stall why we don't see a "reboot: Power down"

Any ideas?

BR and thanks,
Nikolaus

printk hack:

void __mmc_stop_host(struct mmc_host *host)
{
printk("%s 1\n", __func__);
	if (host->slot.cd_irq >=3D 0) {
printk("%s 2\n", __func__);
		mmc_gpio_set_cd_wake(host, false);
printk("%s 3\n", __func__);
		disable_irq(host->slot.cd_irq);
printk("%s 4\n", __func__);
	}

	host->rescan_disable =3D 1;
printk("%s 5\n", __func__);
	cancel_delayed_work_sync(&host->detect);
printk("%s 6\n", __func__);
}

resulting log:

[info] Will now halt.
[  282.780929] __mmc_stop_host 1
[  282.784276] __mmc_stop_host 2
[  282.787735] __mmc_stop_host 3
[  282.791030] __mmc_stop_host 4
[  282.794235] __mmc_stop_host 5
[  282.797369] __mmc_stop_host 6
[  282.800918] __mmc_stop_host 1
[  282.804269] __mmc_stop_host 5
[  282.807541] __mmc_stop_host 6
[  282.810715] __mmc_stop_host 1
[  282.813842] __mmc_stop_host 2
[  282.816984] __mmc_stop_host 3
[  282.820175] __mmc_stop_host 4
[  282.823302] __mmc_stop_host 5
[  282.826449] __mmc_stop_host 6
[  282.830941] __mmc_stop_host 1
[  282.834076] __mmc_stop_host 5

--- here should be another __mmc_stop_host 6
--- and reboot: Power down=
