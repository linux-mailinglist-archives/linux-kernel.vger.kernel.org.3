Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333D550C834
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiDWIRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDWIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:17:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00585106DDE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 01:14:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d15so15780748pll.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 01:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tEABhHPLdbb/U7q9ZbhGXPyRjuxdRV60qM4AkqCbUw=;
        b=jfc8iT+31p81mRPfrmKor5PkEPSt3Wvm51DwbLgVcwpJfnqQeQ3gE35ejaN5xt1v62
         Ljtt28LtLFOVZTkKK5GF0TgpLdrQBo8JS9jxB4e60aw4IxVBJPgZhiRM4ObJekeIkv7Y
         aIdI65XzVDqie4Q0wxSvh9eZPouaP1zij1318=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tEABhHPLdbb/U7q9ZbhGXPyRjuxdRV60qM4AkqCbUw=;
        b=CjcXKdXWhKu15mprDUKYKybexCopI+LYOzGH5jNdWpVyZsEW0wv5u4qWG9b8h1UjBJ
         mcpD5ejmw2e4g6XDgn15nEIwGmVg0O2bJzmLg+xs25vsr9Hr+4jHXuHKF2aONwGBZAtD
         JIZ7c6PCZniLz1TR2EXqkHlnB2NLecxVoJRRYVqTjk0gzLmwR0QSkIgF4clJpTKKyTv6
         0RsM89uLkzUAMufaqSj6EmI05DMhBvYxKI35kfuNLC5B0DX9SJn7bIvZxAOSmYkYVASU
         jzzfB6O5U7tZcACl0jmXmKbZNHcefymm0onL1HJwS1w1h1RKFH1com7gRkg7zhEbdCD7
         FHxQ==
X-Gm-Message-State: AOAM530Nmk/AXieBKuZJPZgPwr+LnkLzcFO8RyMbzboUSMyxfcXM2GuX
        y8joMQ/Km99xZo2DCOH09FGFTufzhS2of0ROxR6YPQ==
X-Google-Smtp-Source: ABdhPJxoch5J7AIZlt4Vw0WAxgGdzG3GmikwsJhG7Cf+opEU4XlyXdl2FNxO9SkpveyvaZkLeZyhGfisnK5byjcAnAQ=
X-Received: by 2002:a17:90a:94c2:b0:1d9:3fbd:bbe1 with SMTP id
 j2-20020a17090a94c200b001d93fbdbbe1mr561231pjw.59.1650701650360; Sat, 23 Apr
 2022 01:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220406154631.277107-1-fabio.aiuto@amarulasolutions.com>
In-Reply-To: <20220406154631.277107-1-fabio.aiuto@amarulasolutions.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sat, 23 Apr 2022 10:13:59 +0200
Message-ID: <CAOf5uwnHq1kMa+qDsieLUt_QRVr7-q5B7jvC2owYJjgU1wZL9Q@mail.gmail.com>
Subject: Re: [PATCH v3] md: dm-init: Wait devices if it's not find on first adpet
To:     Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

On Wed, Apr 6, 2022 at 5:46 PM Fabio Aiuto
<fabio.aiuto@amarulasolutions.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> The device driver can be deferrable and can be a race during
> the dm-init early. We need to wait all the probe are really finished
> in a loop as is done in do_mounts. This is was tested on kernel 5.4
> but code seems was not changed since that time
>

Any follow up?

Michael

> 003: imx8mq-usb-phy 381f0040.usb-phy: 381f0040.usb-phy supply vbus not found, using dummy regulator
> 003: imx8mq-usb-phy 382f0040.usb-phy: 382f0040.usb-phy supply vbus not found, using dummy regulator
> 003: imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 5 mkt segment 0 supported-hw 0x20 0x1
> 003: caam-dma caam-dma: caam dma support with 2 job rings
> 000: hctosys: unable to open rtc device (rtc0)
> 000: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 002: device-mapper: table: 254:0: verity: Data device lookup failed
> 002: device-mapper: ioctl: error adding target to table
> 002: crng init done
> 003: of_cfs_init
> 003: of_cfs_init: OK
> 003: Waiting for root device /dev/dm-0...
> 001: mmc2: new HS400 Enhanced strobe MMC card at address 0001
> 001: mmcblk2: mmc2:0001 IB2916 14.6 GiB
> 001: mmcblk2boot0: mmc2:0001 IB2916 partition 1 4.00 MiB
> 001: mmcblk2boot1: mmc2:0001 IB2916 partition 2 4.00 MiB
> 001: mmcblk2rpmb: mmc2:0001 IB2916 partition 3 4.00 MiB, chardev (249:0)
> 001:  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
> 001: VSD_3V3: disabling
>
> with the patch
>
> 003: device-mapper: init: waiting for all devices to be available before creating mapped devices
>
> 000: device-mapper: table: 254:0: verity: Data device lookup failed
> 000: device-mapper: ioctl: error adding target to table
> 002: crng init done
> 003: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 003: device-mapper: table: 254:0: verity: Data device lookup failed
> 003: device-mapper: ioctl: error adding target to table
> 003: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 000: device-mapper: table: 254:0: verity: Data device lookup failed
> 000: device-mapper: ioctl: error adding target to table
> 002: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 002: device-mapper: table: 254:0: verity: Data device lookup failed
> 002: device-mapper: ioctl: error adding target to table
> 000: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 000: device-mapper: table: 254:0: verity: Data device lookup failed
> 000: device-mapper: ioctl: error adding target to table
> 003: mmc2: new HS400 Enhanced strobe MMC card at address 0001
> 003: mmcblk2: mmc2:0001 DG4016 14.7 GiB
> 003: mmcblk2boot0: mmc2:0001 DG4016 partition 1 4.00 MiB
> 003: mmcblk2boot1: mmc2:0001 DG4016 partition 2 4.00 MiB
> 003: mmcblk2rpmb: mmc2:0001 DG4016 partition 3 4.00 MiB, chardev (249:0)
> 003:  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
> 002: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 003: device-mapper: verity: sha256 using implementation "sha256-caam"
> 000: device-mapper: ioctl: dm-0 (rootfs) is ready
>
> Wait loop is limited to 10 at the moment for our use case showed no
> more than 4 loops before successfully find data device.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
> ---
> Changes from v1:
>         - limit the loop to 10 iterations
>         - change variable names
>         - check only for -ENODEV failures
>
> Changes from v2:
>         - use a limit in seconds (not in retry
>           number)
>         - add a parameter
>         - update docs
>
>  .../admin-guide/device-mapper/dm-init.rst     | 13 +++++++++++
>  drivers/md/dm-init.c                          | 23 +++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/device-mapper/dm-init.rst b/Documentation/admin-guide/device-mapper/dm-init.rst
> index e5242ff17e9b..5c2f2bf1db03 100644
> --- a/Documentation/admin-guide/device-mapper/dm-init.rst
> +++ b/Documentation/admin-guide/device-mapper/dm-init.rst
> @@ -123,3 +123,16 @@ Other examples (per target):
>      0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
>      fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
>      51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584
> +
> +Delay for waiting deferred probes of block devices
> +==================================================
> +
> +Sometimes the late initcall starting the early creation of mapped
> +devices, starts too early. A loop waiting for probing of block
> +devices has been added; the default maximum delay is 1 second but
> +it can be set through the following kernel command::
> +
> +  dm-mod.delay=<seconds>
> +
> +This allows the procedure to retry the creation of a mapped device
> +after a short wait (5 msecs).
> diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
> index b0c45c6ebe0b..f4c5b4a46001 100644
> --- a/drivers/md/dm-init.c
> +++ b/drivers/md/dm-init.c
> @@ -7,7 +7,9 @@
>   * This file is released under the GPLv2.
>   */
>
> +#include <linux/async.h>
>  #include <linux/ctype.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/device-mapper.h>
>  #include <linux/init.h>
> @@ -18,8 +20,10 @@
>  #define DM_MAX_DEVICES 256
>  #define DM_MAX_TARGETS 256
>  #define DM_MAX_STR_SIZE 4096
> +#define DM_DEFAULT_MAX_PROBE_DELAY 1
>
>  static char *create;
> +static int delay = DM_DEFAULT_MAX_PROBE_DELAY;
>
>  /*
>   * Format: dm-mod.create=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
> @@ -267,6 +271,8 @@ static int __init dm_init_init(void)
>         LIST_HEAD(devices);
>         char *str;
>         int r;
> +       int loopcnt = delay * 1000 / 5;
> +       bool devnotfound = false;
>
>         if (!create)
>                 return 0;
> @@ -275,6 +281,7 @@ static int __init dm_init_init(void)
>                 DMERR("Argument is too big. Limit is %d", DM_MAX_STR_SIZE);
>                 return -EINVAL;
>         }
> +retry:
>         str = kstrndup(create, DM_MAX_STR_SIZE, GFP_KERNEL);
>         if (!str)
>                 return -ENOMEM;
> @@ -287,13 +294,23 @@ static int __init dm_init_init(void)
>         wait_for_device_probe();
>
>         list_for_each_entry(dev, &devices, list) {
> -               if (dm_early_create(&dev->dmi, dev->table,
> -                                   dev->target_args_array))
> +               r = dm_early_create(&dev->dmi, dev->table, dev->target_args_array);
> +               if (r == -ENODEV) {
> +                       devnotfound = true;
>                         break;
> +               }
>         }
> +
>  out:
>         kfree(str);
>         dm_setup_cleanup(&devices);
> +       if (devnotfound && loopcnt) {
> +               msleep(5);
> +               devnotfound = false;
> +               loopcnt--;
> +               goto retry;
> +       }
> +
>         return r;
>  }
>
> @@ -301,3 +318,5 @@ late_initcall(dm_init_init);
>
>  module_param(create, charp, 0);
>  MODULE_PARM_DESC(create, "Create a mapped device in early boot");
> +module_param(delay, int, 0);
> +MODULE_PARM_DESC(delay, "Max delay to wait for data/hash device probe in seconds");
> --
> 2.30.2
>
