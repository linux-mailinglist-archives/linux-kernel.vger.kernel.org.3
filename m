Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B181F4BCE52
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 12:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbiBTL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 06:57:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiBTL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 06:57:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFF2DD4;
        Sun, 20 Feb 2022 03:57:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A4276116C;
        Sun, 20 Feb 2022 11:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46655C340E8;
        Sun, 20 Feb 2022 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645358234;
        bh=q/QZ+77EAZGS4K6gv46acDRSLF/0acLiMNlTnPSfmOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IF12N46lgFOz1wG31rlO/0+lZT5Z0/qHI6hmiU36007UG9IokrwC6X2DS/Oq6hTLa
         xbdkHIEsQ0wIxFv+nH3VCKtoRi9fx0Nr+gwA9GQVLcFQMH1dspavZNb0JS5POHe7Ly
         U4tBB5gx+aKM0e0OyZ1p2ifu1oat0O8Kl2hjEbDCUtkAmCnRDu5iVB1nXw1bABcJWj
         ysZlesMqS/2e59wOPkMUJsr0QAUWLTU09EMVE4+O1hZgjEH2dhKMIwKyFFByarGFC+
         u+Db66tOFVdigxvylkRcFPS2WXbi4ZEZbCq5XRVx2hsb+rZJuXQD5oafMUy6SRc3lW
         iHuOwtNqNkstQ==
Date:   Sun, 20 Feb 2022 12:04:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Add ADXL367 driver
Message-ID: <20220220120336.193d17b0@jic23-huawei>
In-Reply-To: <20220214073810.781016-1-cosmin.tanislav@analog.com>
References: <20220214073810.781016-1-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 09:38:05 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> 
> The ADXL367 does not alias input signals to achieve ultralow power
> consumption, it samples the full bandwidth of the sensor at all
> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> with a resolution of 0.25mg/LSB on the +-2 g range.
> 
> In addition to its ultralow power consumption, the ADXL367
> has many features to enable true system level power reduction.
> It includes a deep multimode output FIFO, a built-in micropower
> temperature sensor, and an internal ADC for synchronous conversion
> of an additional analog input.

Looks good to me.

Series applied to the togreg branch of iio.git and pushed out as testing
to let the autobuilders see if they can find anything we missed.

Thanks,

Jonathan

> 
> V1 -> V2
>  * add support for vdd and vddio supplies
>  * lock fifo_watermark retrieval
>  * fix indentation of sysfs_emit for fifo_mode
>  * dt-bindings: add spi-max-frequency: true
>  * dt-bindings: remove cs-gpios property
>  * dt-bindings: remove status property
>  * dt-bindings: add support for vdd
> 
> V2 -> V3
>  * MAINTAINERS: use wildcard for adxl367
>  * dt-bindings: adxl367@addr -> accelerometer@addr
>  * put asm include after linux includes
>  * drop registers accessed implicitly
>  * fifo_full -> fifo_watermark
>  * print expected device id
>  * remove INDIO_BUFFER_HARDWARE
>  * inline ADXL367_EVENT macro
>  * inline ADXL367_14BIT_SCAN_INFO
>  * inline regulator enum
>  * remove of.h in spi driver
>  * cast const void * to const u8 * in spi read
>  * switch to trigger-less buffer
>  * increase reset time as advised by hardware team
>  * let iio framework validate available channel masks
>  * enable adc or temp channel automatically on single read
>  * wait for 100ms after enabling adc or temp for output
>    to settle on single read (waiting on hardware team input)
>  * enable adc or temp channel automatically on buffered read
>  * claim direct mode when setting range
>  * claim direct mode when setting odr
>  * claim direct mode when setting event config
>  * sort status masks in descending bit order
>  * hardcode indio_dev name
>  * add some comments regarding spi message layout
>  * use bulk_write for activity and inactivity threshold
>  * use bulk_write for inactivity time
>  * use bool as return type of fifo format finding function
>  * remove shift from channels scan type
> 
> V3 -> V4
>  * add a patch that introduces mag_referenced event type
>  * add a patch that documents mag_referenced event type
>  * add a patch that adds a note to the buffer/enable documentation
>    regarding configuration of other attributes during buffer capture
>  * remove unused adxl367_time_scale_tbl
>  * add static attribute to adxl367_write_raw_get_fmt
>  * return IRQ_HANDLED when FIFO read fails and print error message
>  * scale temperature value by 1000 to reach milli degrees C
>  * merge dev_to_iio_dev into useplace when indio_dev is not needed
>  * merge preenable into postenable and postdisable into predisable
>  * fix default inactivity threshold
>  * export probe symbol to namespace
>  * IIO_EV_TYPE_THRESH -> IIO_EV_TYPE_MAG_REFERENCED
>  * reset device and then verify dev id for 10ms
>  * share events by type so that they show up with iio_accel prefix in the
>    events subdirectory
>  * use a separate mask for extracting data
>    I previously removed the shift fron scan_type since the FIFO data does
>    not contain a shift but that broke single channel reads. Add it back
>    just for single channel reads.
> 
> V4 -> V5
>  * linux/module.h -> linux/mod_devicetable.h
>  * extract fifo_formats into separate array to allow arbitrary scan mask
>    order
>  * reorder channel_masks and fifo_formats
>  * prepend IIO_ to ADXL367 namespace
>  * use adxl367_fifo_formats array size to iterate over channel_masks table
> 
> Cosmin Tanislav (5):
>   iio: introduce mag_referenced
>   iio: ABI: document mag_referenced
>   iio: ABI: add note about configuring other attributes during buffer
>     capture
>   dt-bindings: iio: accel: add ADXL367
>   iio: accel: add ADXL367 driver
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   30 +
>  .../bindings/iio/accel/adi,adxl367.yaml       |   79 +
>  MAINTAINERS                                   |    8 +
>  drivers/iio/accel/Kconfig                     |   27 +
>  drivers/iio/accel/Makefile                    |    3 +
>  drivers/iio/accel/adxl367.c                   | 1588 +++++++++++++++++
>  drivers/iio/accel/adxl367.h                   |   23 +
>  drivers/iio/accel/adxl367_i2c.c               |   90 +
>  drivers/iio/accel/adxl367_spi.c               |  164 ++
>  drivers/iio/industrialio-event.c              |    1 +
>  include/uapi/linux/iio/types.h                |    1 +
>  tools/iio/iio_event_monitor.c                 |    1 +
>  12 files changed, 2015 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>  create mode 100644 drivers/iio/accel/adxl367.c
>  create mode 100644 drivers/iio/accel/adxl367.h
>  create mode 100644 drivers/iio/accel/adxl367_i2c.c
>  create mode 100644 drivers/iio/accel/adxl367_spi.c
> 

