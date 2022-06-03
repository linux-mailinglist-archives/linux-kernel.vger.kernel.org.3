Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD9353C8EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiFCKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243838AbiFCKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:47:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203AEB1DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:47:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i10so12056803lfj.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RuxiiRr7rF1MUtH6zyEJXG+qpZDviq1FdaqXVZ6VyQo=;
        b=Tz2Fyeczkog0lzxlLJ3ukxJj/pDd7b4Whi/orXkhshX7QoZ2AW2bbQKe07ceZZqV3R
         4ImLVn2E4ak2XK1tWzclxoxuaB1G0l3SWvzPJVp+dtp6IzdxAxvghiIDRypsZgHoe+FS
         buXf56GdJWNy6s+qg7H0+Wghx8uDcALR1E7r3eeYhxK/nCPUIPw58IWgR0VXf41DrnoE
         Nq5a4+QKtftFZ2L8foOlPUVMhv/7e8g8qI7JKXOz7GKJWxQX02FjoeLze3GtdsnwkdDd
         TRA6m6pQW769Tnt9XziHVwBOCpifKKQ958jGo8Fgdz01rgYMaPxxJ2EgkNFz+q1jgqLJ
         60sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RuxiiRr7rF1MUtH6zyEJXG+qpZDviq1FdaqXVZ6VyQo=;
        b=sEbC/i9Taks8RQcoBz6XVWmyy1JNbzM3lDmWIIUAS7L/FDKm/2IIP6KxIvCWB4Ch0C
         P2W5r3NHfUTZW5+xfXd5wZfB5ogRkPPu0Xou8rGjnNkCs+T46hhNiDj3c85tCdUdpGrv
         9bT1yxgiVOPTtR+MUqC0G4HX/qONjbzYw8cLK3CvPZdnxpifHrCPspzQaRf/KePFZwxN
         IEg2qjzR4SRgMsiviWCclrF15lmNVhVv5cZAU2hlRZfbEp84Fal+8GILW4kvqIMvb0yz
         TdAiG7mfT6HqjJfC7ZFKBwxsv9wzFhtHpADfjL8v4N6c3VHmuw0pcskvhZjeUBHJUQKV
         zlPQ==
X-Gm-Message-State: AOAM532w3j4F7a9vDfG0d8BJvLPTEUZS4nOfBPOAru8fouF8O3AO/ljv
        wmybqIHVjvzzHofQc7Kvq2z+wyHeRSFkxH85+fHxLw==
X-Google-Smtp-Source: ABdhPJx7EenVzEen8Z45Wdj8n7/9C/HhCuAPPbgq11H3VQhxJe3Va13Q/K3T2vm7BF0zrkhbyWy1CamMA/oE1TCLrhM=
X-Received: by 2002:a05:6512:303:b0:479:1baf:7e5b with SMTP id
 t3-20020a056512030300b004791baf7e5bmr1401766lfp.184.1654253224621; Fri, 03
 Jun 2022 03:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <55A0788B-03E8-457E-B093-40FD93F1B9F3@goldelico.com>
In-Reply-To: <55A0788B-03E8-457E-B093-40FD93F1B9F3@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Jun 2022 12:46:28 +0200
Message-ID: <CAPDyKFrjH8c=2LYkzj81jm7t-sy-EBs3AMzAS7M=LEHsh9qCCA@mail.gmail.com>
Subject: Re: BUG in mmc: core: Disable card detect during shutdown
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com, aTc <atc@k-n-p.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 at 18:55, H. Nikolaus Schaller <hns@goldelico.com> wrot=
e:
>
> Hi Ulf,
> users did report a strange issue that the OMAP5 based Pyra does not
> shutdown if a kernel 5.10.116 is used.
>
> Someone did a bisect and found that reverting
>
> 0d66b395210c5084c2b7324945062c1d1f95487a
>
> resp. upstream
>
> 66c915d09b942fb3b2b0cb2f56562180901fba17
>
> solves it.
>
> I could now confirm that it also happens with v5.18.0.
> But interestingly only on the Pyra handheld device and not
> on the omap5evm (which is supported by mainline).
>
> The symptom is:
>
> a) without revert
>
> root@letux:~# poweroff
>
> Broadcast message from root@letux (console) (Sat Jan  1 01:08:25 2000):
>
> The system is going down for system halt NOW!
> INIT: Sending processes the TERM signal
> root@letux:~# [info] Using makefile-style concurrent boot in runlevel 0.
> [....] Stopping cgroup management proxy daemon: cgproxy[....] Stopping cg=
roup management daemon: cgmanager[....] Stop[ ok bluetooth: /usr/sbin/bluet=
oothd.
> [FAIL] Stopping ISC DHCP server: dhcpd failed!
> dhcpcd[3055]: sending signal 15 to pid 2976
> dhcpcd[3055]: waiting for pid 2976 to exit
> [ ok ] Shutting down ALSA...done.
> [ ok ] Asking all remaining processes to terminate...done.
> [ ok ] All processes ended within 2 seconds...done.
> [ ok [[c[....] Stopping enhanced syslogd: rsyslogd.
> [ ok ....] Deconfiguring network interfaces...done.
> ^[[c[info] Saving the system clock.
> [info] Hardware Clock updated to Sat Jan  1 01:08:30 UTC 2000.
> [ ok ] Deactivating swap...done.
> ^[[c[   77.289332] EXT4-fs (mmcblk0p2): re-mounted. Quota mode: none.
> [info] Will now halt.
>
> b) with reverting your patch
>
> root@letux:~# uname -a
> Linux letux 5.18.0-letux-lpae+ #9678 SMP PREEMPT Mon May 30 18:02:28 CEST=
 2022 armv7l GNU/Linux
> root@letux:~# poweroff
>
> Broadcast message from root@letux (console) (Sat Jan  1 01:39:15 2000):
>
> The system is going down for system halt NOW!
> INIT: Sending processes the TERM signal
> root@letux:~# [info] Using makefile-style concurrent boot in runlevel 0.
> [FAIL] Stopping cgroup management proxy daemon: cgproxy[....] Stopping IS=
C DHCP server: dhcpd failed!
> [....] Stopping cgroup management daemon: cgmanagerdhcpcd[3100]: sending =
signal 15 to pid 3013
> dhcpcd[3100]: waiting for pid 3013 to exit
> [ ok ] Stopping bluetooth: /usr/sbin/bluetoothd.
> [ ok ] Shutting down ALSA...done.
> [ ok ] Asking all remaining processes to terminate...done.
> [ ok ] All processes ended within 3 seconds...done.
> [ ok [[c[....] Stopping enhanced syslogd: rsyslogd.
> [ ok ....] Deconfiguring network interfaces...done.
> ^[[c[info] Saving the system clock.
> [info] Hardware Clock updated to Sat Jan  1 01:39:21 UTC 2000.
> [ ok ] Deactivating swap...done.
> ^[[c[   44.563256] EXT4-fs (mmcblk0p2): re-mounted. Quota mode: none.
> [info] Will now halt.
> [   46.917534] reboot: Power down
>
>
> What I suspect is that we have multiple mmc interfaces and have
> card detect wired up in the Pyra while it is ignored in the
> EVM. Is it possible that __mmc_stop_host() never returns in
> .shutdown_pre if card detect is set up (and potentially
> shut down earlier)?
>
> Setup of mmc is done in omap5-board-common.dtsi and omap5.dtsi.
>
> Out Pyra has a non-upstream device tree where we use
> omap5-board-common.dtsi and overwrite it by e.g.
>
> &mmc4 { /* second (u)SD slot (SDIO capable) */
>         status =3D "okay";
>         vmmc-supply =3D <&ldo2_reg>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&mmc4_pins>;
>         bus-width =3D <4>;
>         cd-gpios =3D <&gpio3 13 GPIO_ACTIVE_LOW>; /* gpio3_77 */
>         wp-gpios =3D <&gpio3 15 GPIO_ACTIVE_HIGH>;        /* gpio3_79 */
> };
>
> But I have tried to remove the cd-gpois and wp-gpois. Or make the
> mmc interface being disabled (but I may not have catched everything
> in first place).
>
> Then I added some printk to mmc_stop_host() and __mmc_stop_host().
>
> mmc_stop_host() is not called but __mmc_stop_host() is called 4 times.
> There are 4 active MMC interfaces in the Pyra - 3 for (=C2=B5)SD slots
> and one for an SDIO WLAN module.
>
> Now it looks as if 3 of them are properly teared down (two of them
> seem to have host->slot.cd_irq >=3D 0) but on the fourth call
> cancel_delayed_work_sync(&host->detect); does not return. This is
> likely the location of the stall why we don't see a "reboot: Power down"
>
> Any ideas?

I guess the call to cancel_delayed_work_sync() in __mmc_stop_host()
hangs for one of the mmc hosts. This shouldn't happen - and indicates
that there is something else being wrong.

See more suggestions below.

>
> BR and thanks,
> Nikolaus
>
> printk hack:
>
> void __mmc_stop_host(struct mmc_host *host)
> {
> printk("%s 1\n", __func__);
>         if (host->slot.cd_irq >=3D 0) {
> printk("%s 2\n", __func__);
>                 mmc_gpio_set_cd_wake(host, false);
> printk("%s 3\n", __func__);
>                 disable_irq(host->slot.cd_irq);
> printk("%s 4\n", __func__);
>         }
>
>         host->rescan_disable =3D 1;
> printk("%s 5\n", __func__);

My guess is that it's the same mmc host that causes the hang. I
suggest you print the name of the host too, to verify that. Something
along the lines of the below.

printk("%s: %s 5\n", mmc_hostname(host), __func__);

>         cancel_delayed_work_sync(&host->detect);
> printk("%s 6\n", __func__);

Ditto.

> }
>
> resulting log:
>
> [info] Will now halt.
> [  282.780929] __mmc_stop_host 1
> [  282.784276] __mmc_stop_host 2
> [  282.787735] __mmc_stop_host 3
> [  282.791030] __mmc_stop_host 4
> [  282.794235] __mmc_stop_host 5
> [  282.797369] __mmc_stop_host 6
> [  282.800918] __mmc_stop_host 1
> [  282.804269] __mmc_stop_host 5
> [  282.807541] __mmc_stop_host 6
> [  282.810715] __mmc_stop_host 1
> [  282.813842] __mmc_stop_host 2
> [  282.816984] __mmc_stop_host 3
> [  282.820175] __mmc_stop_host 4
> [  282.823302] __mmc_stop_host 5
> [  282.826449] __mmc_stop_host 6
> [  282.830941] __mmc_stop_host 1
> [  282.834076] __mmc_stop_host 5
>
> --- here should be another __mmc_stop_host 6
> --- and reboot: Power down

When/if you figured out that it's the same host that hangs, you could
try to disable that host through the DTS files (add status =3D
"disabled" in the device node, for example) - and see if that works.

Kind regards
Uffe
