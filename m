Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2152F665
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbiETXu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbiETXu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:50:27 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D75D185C93
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:50:26 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ff1ed64f82so102099587b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0Le7Rq4fTu505Kt4mjcZ5QrRzFD1sSCiaVoQbTgwnE=;
        b=I9SJex6ygJZ1pp76zWJBCVjNvHpiageorAIK0z4YKhKCvrOTdK4IMBrzUt6oCQLw+C
         CwMGSbD4YC0AcJJcvp5ATb59Pkrj5uczJYfjvnrKgkqgKJ2ukvnkjeqpeF75eq2Zbj4o
         OeZjIhAzLBBKuK1S+q+MLn6eOvJho6gsxd66qsCJgVQbleEVxeYgNeZ/gdt9xbwdzxki
         kWELtGQ0JIQYA+W6lPYQeoZpy3Gn1mSlk03I3TyWOz85bSL7oCNsvPFKA5NhY/ckrPHv
         snJfUtNpBkBM4BTNte3FB4yUk0hf0kZFX6WjUnTvzlIWQg8w1a6Gh3bHomyeWm4kFfku
         JnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0Le7Rq4fTu505Kt4mjcZ5QrRzFD1sSCiaVoQbTgwnE=;
        b=avPqlLzLqtSWKjcZtM7ePoZvnfgBXV0YVnJf1q49At8nKUTG32ARvv5YVbJqLB0WFx
         XFhI8C2LdsNchpmu5SQoc3p/D2XLWR7wIek3byH5EECBqVl7r2k3N6pQuUB13Bt3eIqF
         cS2TzDEGyk2css3lyVtg3jCkcv5LxzFAHC9I8WK424ltnCyWowYSuotBacTdK0pRQAeq
         mlxVm66ZM7zRlj60/vLDdPvqwTanHshNcydMXYJ2IPMMLRpfykirY2sLlWOeCV0hkX2X
         Qz4CCScfAirvtIIUg4M7fpkD7EjPoVUDqvTl/L16g/7sacjwQUIAquNNEXGT/PVv7mOt
         CdFQ==
X-Gm-Message-State: AOAM532KtRa3NjKKwXjHdekLbYt+cog/gt/quXjmzvVi7xFm7wAxY7uZ
        TUGJOoTd1lyN90yyaUaEyQpITk04Jgp9++7UDhFxCQ==
X-Google-Smtp-Source: ABdhPJy7RRRfvjlN4OrvzSSQJiCcbKTTbZ4L6dC/tqEEDIC/UreYL/mP4r6UwgGxmDbNNIr6P2AXtuTleBjO7QN02cw=
X-Received: by 2002:a81:2154:0:b0:2f4:d79e:35dc with SMTP id
 h81-20020a812154000000b002f4d79e35dcmr13128670ywh.126.1653090625081; Fri, 20
 May 2022 16:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com> <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
In-Reply-To: <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 20 May 2022 16:49:48 -0700
Message-ID: <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Nathan Chancellor <nathan@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 4:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Saravana,
>
> On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> > The deferred probe timer that's used for this currently starts at
> > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > assumption being that all available drivers would be loaded and
> > registered before the timer expires. This means, the
> > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > worst case. But if we set the default value for it to cover the worst
> > case, it would significantly slow down the average case. For this
> > reason, the default value is set to 0.
> >
> > Also, with CONFIG_MODULES=y and the current default values of
> > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > drivers will cause their consumer devices to always defer their probes.
> > This is because device links created by fw_devlink defer the probe even
> > before the consumer driver's probe() is called.
> >
> > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > timer on every successful driver registration, with the expectation more
> > modules would be loaded in the near future, then the default value of
> > driver_deferred_probe_timeout only needs to be as long as the worst case
> > time difference between two consecutive module loads.
> >
> > So let's implement that and set the default value to 10 seconds when
> > CONFIG_MODULES=y.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Cc: linux-gpio@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> I bisected a boot hang with ARCH=s390 defconfig in QEMU down to this
> change as commit 2b28a1a84a0e ("driver core: Extend deferred probe
> timeout on driver registration") in next-20220520 (bisect log below).
>
> $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- defconfig bzImage
>
> $ timeout --foreground 15m stdbuf -oL -eL \
> qemu-system-s390x \
> -initrd ... \
> -M s390-ccw-virtio \
> -display none \
> -kernel arch/s390/boot/bzImage \
> -m 512m \
> -nodefaults \
> -serial mon:stdio
> ...
> [    2.077303] In-situ OAM (IOAM) with IPv6
> [    2.077639] NET: Registered PF_PACKET protocol family
> [    2.078063] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> [    2.078795] Key type dns_resolver registered
> [    2.079317] cio: Channel measurement facility initialized using format extended (mode autodetected)
> [    2.081494] Discipline DIAG cannot be used without z/VM
> [  260.626363] random: crng init done
> qemu-system-s390x: terminating on signal 15 from pid 3815762 (timeout)
>
> We have a simple rootfs available if necessary:
>
> https://github.com/ClangBuiltLinux/boot-utils/raw/bc0d17785eb67f1edd0ee0a134970a807895f741/images/s390/rootfs.cpio.zst
>
> If there is any other information I can provide, please let me know!

Hmm... strange. Can you please try the following command line options
and tell me which of these has the issue and which don't?
1) deferred_probe_timeout=0
2) deferred_probe_timeout=1
3) deferred_probe_timeout=300

That should help me narrow down where the error might be.

Thanks,
Saravana

>
> Cheers,
> Nathan
>
> # bad: [18ecd30af1a8402c162cca1bd58771c0e5be7815] Add linux-next specific files for 20220520
> # good: [b015dcd62b86d298829990f8261d5d154b8d7af5] Merge tag 'for-5.18/parisc-4' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> git bisect start '18ecd30af1a8402c162cca1bd58771c0e5be7815' 'b015dcd62b86d298829990f8261d5d154b8d7af5'
> # good: [f9b63740b666dd9887eb0282d21b5f65bb0cadd0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect good f9b63740b666dd9887eb0282d21b5f65bb0cadd0
> # good: [1f5eb3e76303572f0318e8c50da51c516580aa03] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> git bisect good 1f5eb3e76303572f0318e8c50da51c516580aa03
> # bad: [4c1d9cc0363691893ef94fa0d798faca013e27d3] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> git bisect bad 4c1d9cc0363691893ef94fa0d798faca013e27d3
> # bad: [dcb68304485c0ba5f84f1a54687c751b68263d93] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git
> git bisect bad dcb68304485c0ba5f84f1a54687c751b68263d93
> # good: [61271996dc46aecb40fd26f89a4ec0a6bd8f3a8f] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> git bisect good 61271996dc46aecb40fd26f89a4ec0a6bd8f3a8f
> # good: [d4db45a71f56032b552e161968bb0e5fdd2767f8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
> git bisect good d4db45a71f56032b552e161968bb0e5fdd2767f8
> # good: [d090c7a2ab84663185e4abda21d7d83880937c8a] USB / dwc3: Fix a checkpatch warning in core.c
> git bisect good d090c7a2ab84663185e4abda21d7d83880937c8a
> # bad: [b232b02bf3c205b13a26dcec08e53baddd8e59ed] driver core: fix deadlock in __device_attach
> git bisect bad b232b02bf3c205b13a26dcec08e53baddd8e59ed
> # good: [4c32174a24759d5ac6dc42b508fcec2afb8b9602] Documentation: dd: Use ReST lists for return values of driver_deferred_probe_check_state()
> git bisect good 4c32174a24759d5ac6dc42b508fcec2afb8b9602
> # good: [38ea74eb8fc1b82b39e13a6527095a0036539117] rpmsg: use local 'dev' variable
> git bisect good 38ea74eb8fc1b82b39e13a6527095a0036539117
> # good: [1f7ff11ca68f464b6a9a71b8fbe9e5219e7cac57] driver core: location: Add "back" as a possible output for panel
> git bisect good 1f7ff11ca68f464b6a9a71b8fbe9e5219e7cac57
> # good: [6ee60e9c9f2f83ad218159af6a175c57a395ae69] MAINTAINERS: add Russ Weight as a firmware loader maintainer
> git bisect good 6ee60e9c9f2f83ad218159af6a175c57a395ae69
> # bad: [15f214f9bdb7c1f560b4bf863c5a72ff53b442a4] topology: Remove unused cpu_cluster_mask()
> git bisect bad 15f214f9bdb7c1f560b4bf863c5a72ff53b442a4
> # bad: [2b28a1a84a0eb3412bad1a2d5cce2bb4addec626] driver core: Extend deferred probe timeout on driver registration
> git bisect bad 2b28a1a84a0eb3412bad1a2d5cce2bb4addec626
> # first bad commit: [2b28a1a84a0eb3412bad1a2d5cce2bb4addec626] driver core: Extend deferred probe timeout on driver registration
