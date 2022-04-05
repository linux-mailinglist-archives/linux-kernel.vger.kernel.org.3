Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB24F46B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380298AbiDEUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457468AbiDEQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:16 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184D82D0E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:50:42 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id s11so11760524qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+fdSoVNNjnUGmCkMRGF7bz1AtuvXBZQ7NRsX5hjdRI=;
        b=nSLAdzBHyiQ5igCN4Pe6k+8/suWInm+i+4F+PDAx12UoG9Wdgv11CKWTvsSnOxjBNh
         hJzJZlhJTrUqTKt1NdbTqNI0VsqnOwA6Hsy54rxPyOJL14XQrRmMxQtgC2GBxmeFvQgS
         3wr1mQSQv/TXUMSOWSVMn9tJTJJAq4+C6j3DdT8bNd7LbDWgs11ug0SOZNi8UjzYeC0P
         QauhEEB5eLT7e4KcJ3Gc/fU+7UkpnUS3RhTSnjzzWDKEg68bGVx717LCcZ8PYyvtaQlj
         OtVKj2qoJniFPjznF5QgXS0pKNIuxxenWe9zowzts8QyExdLxqzZKfiPvzZ3cn74wm9I
         4dSg==
X-Gm-Message-State: AOAM5337h5bv6xUufm5naZodkPtQUqLMHKUhh/gnxxs64EsjINKmjLco
        A3wRbUlonTlLKmp0nbixP3Q6uwCiQN+m
X-Google-Smtp-Source: ABdhPJzKzm30OD+0rRZKNl7Nej0zc6frKnnX46QEawCBiKw/KCb8ayvLrIXfjw+ycf+lOxvjqpd0gA==
X-Received: by 2002:ac8:5b50:0:b0:2eb:8756:d7c1 with SMTP id n16-20020ac85b50000000b002eb8756d7c1mr3615358qtw.378.1649173841365;
        Tue, 05 Apr 2022 08:50:41 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id de8-20020a05620a370800b0067ec34c9f27sm8282351qkb.129.2022.04.05.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:50:40 -0700 (PDT)
Date:   Tue, 5 Apr 2022 11:50:39 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
Subject: Re: [RFC PATCH] md: dm-init: Wait devices if it's not find on first
 adpet
Message-ID: <YkxlTyMFNNdBqFRd@redhat.com>
References: <20220401220705.82077-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401220705.82077-1-michael@amarulasolutions.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01 2022 at  6:07P -0400,
Michael Trimarchi <michael@amarulasolutions.com> wrote:

> The device driver can be deferrable and can be a race during
> the dm-init early. We need to wait all the probe are really finished
> in a loop as is done in do_mounts. This is was tested on kernel 5.4
> but code seems was not changed since that time
> 
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
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/md/dm-init.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
> index b0c45c6ebe0b..d3b754036484 100644
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
> @@ -267,6 +269,7 @@ static int __init dm_init_init(void)
>  	LIST_HEAD(devices);
>  	char *str;
>  	int r;
> +	bool fail = false;
>  
>  	if (!create)
>  		return 0;
> @@ -275,6 +278,7 @@ static int __init dm_init_init(void)
>  		DMERR("Argument is too big. Limit is %d", DM_MAX_STR_SIZE);
>  		return -EINVAL;
>  	}
> +retry:
>  	str = kstrndup(create, DM_MAX_STR_SIZE, GFP_KERNEL);
>  	if (!str)
>  		return -ENOMEM;
> @@ -288,12 +292,21 @@ static int __init dm_init_init(void)
>  
>  	list_for_each_entry(dev, &devices, list) {
>  		if (dm_early_create(&dev->dmi, dev->table,
> -				    dev->target_args_array))
> +				    dev->target_args_array)) {
> +			fail = true;
>  			break;
> +		}
>  	}
> +
>  out:
>  	kfree(str);
>  	dm_setup_cleanup(&devices);
> +	if (fail) {
> +		msleep(5);
> +		fail = false;
> +		goto retry;
> +	}
> +
>  	return r;
>  }
>  
> -- 
> 2.25.1
> 

I'm cannot take this as proposed.

If you're going to do something like this, the retries need to be
bounded. And retry should only be possible for select cases
(e.g. "verity: Data device lookup failed", which is emitted due to
dm_get_device failure with a return -ENODEV).

So please narrow this as much as possible (by only allowing retry if
-ENODEV) and bound the retries to a finite amount.. 5? 10? 20? *shrug*

And please take care to use variable names that are more appropriate
("fail" is not one of them when you're writing retry code)

Mike
