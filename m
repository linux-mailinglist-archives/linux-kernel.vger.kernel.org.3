Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424AB52F62A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbiETXaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiETXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0251A6ADF;
        Fri, 20 May 2022 16:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C83461E4A;
        Fri, 20 May 2022 23:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C0FC385A9;
        Fri, 20 May 2022 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653089417;
        bh=P2DRkR32s1NsMQQYdV69P9AP9FWKxnSxvUzmxP2UTfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFVuDPyLOIgq5/gp0vFI0m4iG1e6x7YD5eJ2kPMDn/VIcatZdMgpdluKZy2mBMZtX
         knxjLbbEso3dCFrNebOOFKdAI8LwT4dJgGhOJm0J9UDgxgEz0TEd6Jbl2o+xbR3CUS
         25aFWx7YU6EJrRjgiTdkw6hIHgKn4pMbqEhrnhPT3lr1XZem18X+i9CJYpSUqAo2MR
         lSj3XRTDdBM2zh5y66b3X4FnmTZdSgYfXMYP341H0lCORsBOqduq79NwUbybfr11V8
         8W6wKgpEo+Jk4S0RbRD+kqLMWsMdtEdrl2+TNQ53v8kkyvD4do9AgaQYwRbchQS+wS
         p3UuzRLAmIJEw==
Date:   Fri, 20 May 2022 16:30:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
Message-ID: <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
References: <20220429220933.1350374-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429220933.1350374-1-saravanak@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> The deferred probe timer that's used for this currently starts at
> late_initcall and runs for driver_deferred_probe_timeout seconds. The
> assumption being that all available drivers would be loaded and
> registered before the timer expires. This means, the
> driver_deferred_probe_timeout has to be pretty large for it to cover the
> worst case. But if we set the default value for it to cover the worst
> case, it would significantly slow down the average case. For this
> reason, the default value is set to 0.
> 
> Also, with CONFIG_MODULES=y and the current default values of
> driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> drivers will cause their consumer devices to always defer their probes.
> This is because device links created by fw_devlink defer the probe even
> before the consumer driver's probe() is called.
> 
> Instead of a fixed timeout, if we extend an unexpired deferred probe
> timer on every successful driver registration, with the expectation more
> modules would be loaded in the near future, then the default value of
> driver_deferred_probe_timeout only needs to be as long as the worst case
> time difference between two consecutive module loads.
> 
> So let's implement that and set the default value to 10 seconds when
> CONFIG_MODULES=y.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Saravana Kannan <saravanak@google.com>

I bisected a boot hang with ARCH=s390 defconfig in QEMU down to this
change as commit 2b28a1a84a0e ("driver core: Extend deferred probe
timeout on driver registration") in next-20220520 (bisect log below).

$ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- defconfig bzImage

$ timeout --foreground 15m stdbuf -oL -eL \
qemu-system-s390x \
-initrd ... \
-M s390-ccw-virtio \
-display none \
-kernel arch/s390/boot/bzImage \
-m 512m \
-nodefaults \
-serial mon:stdio
...
[    2.077303] In-situ OAM (IOAM) with IPv6
[    2.077639] NET: Registered PF_PACKET protocol family
[    2.078063] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    2.078795] Key type dns_resolver registered
[    2.079317] cio: Channel measurement facility initialized using format extended (mode autodetected)
[    2.081494] Discipline DIAG cannot be used without z/VM
[  260.626363] random: crng init done
qemu-system-s390x: terminating on signal 15 from pid 3815762 (timeout)

We have a simple rootfs available if necessary:

https://github.com/ClangBuiltLinux/boot-utils/raw/bc0d17785eb67f1edd0ee0a134970a807895f741/images/s390/rootfs.cpio.zst

If there is any other information I can provide, please let me know!

Cheers,
Nathan

# bad: [18ecd30af1a8402c162cca1bd58771c0e5be7815] Add linux-next specific files for 20220520
# good: [b015dcd62b86d298829990f8261d5d154b8d7af5] Merge tag 'for-5.18/parisc-4' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect start '18ecd30af1a8402c162cca1bd58771c0e5be7815' 'b015dcd62b86d298829990f8261d5d154b8d7af5'
# good: [f9b63740b666dd9887eb0282d21b5f65bb0cadd0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good f9b63740b666dd9887eb0282d21b5f65bb0cadd0
# good: [1f5eb3e76303572f0318e8c50da51c516580aa03] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good 1f5eb3e76303572f0318e8c50da51c516580aa03
# bad: [4c1d9cc0363691893ef94fa0d798faca013e27d3] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect bad 4c1d9cc0363691893ef94fa0d798faca013e27d3
# bad: [dcb68304485c0ba5f84f1a54687c751b68263d93] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git
git bisect bad dcb68304485c0ba5f84f1a54687c751b68263d93
# good: [61271996dc46aecb40fd26f89a4ec0a6bd8f3a8f] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
git bisect good 61271996dc46aecb40fd26f89a4ec0a6bd8f3a8f
# good: [d4db45a71f56032b552e161968bb0e5fdd2767f8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
git bisect good d4db45a71f56032b552e161968bb0e5fdd2767f8
# good: [d090c7a2ab84663185e4abda21d7d83880937c8a] USB / dwc3: Fix a checkpatch warning in core.c
git bisect good d090c7a2ab84663185e4abda21d7d83880937c8a
# bad: [b232b02bf3c205b13a26dcec08e53baddd8e59ed] driver core: fix deadlock in __device_attach
git bisect bad b232b02bf3c205b13a26dcec08e53baddd8e59ed
# good: [4c32174a24759d5ac6dc42b508fcec2afb8b9602] Documentation: dd: Use ReST lists for return values of driver_deferred_probe_check_state()
git bisect good 4c32174a24759d5ac6dc42b508fcec2afb8b9602
# good: [38ea74eb8fc1b82b39e13a6527095a0036539117] rpmsg: use local 'dev' variable
git bisect good 38ea74eb8fc1b82b39e13a6527095a0036539117
# good: [1f7ff11ca68f464b6a9a71b8fbe9e5219e7cac57] driver core: location: Add "back" as a possible output for panel
git bisect good 1f7ff11ca68f464b6a9a71b8fbe9e5219e7cac57
# good: [6ee60e9c9f2f83ad218159af6a175c57a395ae69] MAINTAINERS: add Russ Weight as a firmware loader maintainer
git bisect good 6ee60e9c9f2f83ad218159af6a175c57a395ae69
# bad: [15f214f9bdb7c1f560b4bf863c5a72ff53b442a4] topology: Remove unused cpu_cluster_mask()
git bisect bad 15f214f9bdb7c1f560b4bf863c5a72ff53b442a4
# bad: [2b28a1a84a0eb3412bad1a2d5cce2bb4addec626] driver core: Extend deferred probe timeout on driver registration
git bisect bad 2b28a1a84a0eb3412bad1a2d5cce2bb4addec626
# first bad commit: [2b28a1a84a0eb3412bad1a2d5cce2bb4addec626] driver core: Extend deferred probe timeout on driver registration
