Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58B6468C4C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhLERFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhLERFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:05:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63247C061751;
        Sun,  5 Dec 2021 09:02:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E69C961118;
        Sun,  5 Dec 2021 17:02:06 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 847C7C341C4;
        Sun,  5 Dec 2021 17:02:02 +0000 (UTC)
Date:   Sun, 5 Dec 2021 17:07:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v11 0/3] Add AD74413R driver
Message-ID: <20211205170713.3ddf0434@jic23-huawei>
In-Reply-To: <20211205114045.173612-1-cosmin.tanislav@analog.com>
References: <20211205114045.173612-1-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Dec 2021 13:40:42 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> V1 -> V2
>  * sign off using company email
> 
> V2 -> V3
>  * replace gpo config firmware flag with flag specifying whether gpo is in
>    comparator mode
>  * create two separate gpiochips, one output-only gpiochip for GPO pins not
>    in comparator mode and one input-only for the value of digital input
>    channels
>  * wire up all gpo functionalities using pinconf
>  * keep number of characters per line under 80
>  * rework locking
>  * do not invalidate other chip revisions
>  * do not set indio device parent
>  * print probe error for refin regulator
>  * move conversion from range register value to range / offset / raw offset
>    into separate function
>  * module.h -> mod_devicetable.h
>  * use generic firmware interface functions
>  * add comment regarding cache alignment
>  * add comment regarding ADC channels buffered read setup
>  * un-inline comment regarding 100us delay for conversion start
>  * inline return statements
>  * remove assignments to val2 where not necessary
>  * local_channels -> chans
>  * index -> i
>  * channel_config -> config
>  * IIO_ALTVOLTAGE -> IIO_VOLTAGE
>  * .info_mask_shared_by_type_available -> .info_mask_separate_available
>  * remove unlikely probe error messages
>  * use an array indexed by channel function for retrieving iio channels
>  * count iio channels while parsing
>  * move HART rate rejection outside of setter
>  * move channel function validation outside of setter
>  * use SPI messages for read and write
>  * validate DAC code earlier
>  * simplify switches to only handle existing iio channels
>  * pass indio_dev into functions needing access to it
>  * pass spi into devm_regmap_init
>  * dt-bindings: sort compatibles
>  * dt-bindings: remove driver word from description
>  * dt-bindings: remove refin supply description
>  * dt-bindings: specify channel function default value
>  * dt-bindings: remove maxItems from scalar value
> 
> V3 -> v4
>  * remove double gpo from macro name
>  * reset at probe
>  * config -> chip_info and store chip name inside chip info
>  * cacheline align every DMA buffer
>  * simplify generation of adc samples message by caching xfer, tx_buf and
>    rx_buf
>  * use mask itself for writing the value of channel enable and gpo data
>  * move reg read and write transfers to the same buffers and use local
>    variables for transfers
>  * merge the two for loops handling gpio configuration
>  * let firmware decide irq edge
>  * remove INDIO_BUFFER_SOFTWARE already set by iio framework
>  * do not set trigger device parent
>  * return dev_err_probe for regulator error case
>  * do not set cs_change to 0 when not needed
>  * do not set spi device drvdata as it is not needed
>  * fix bug regarding wrong channels being created for resistance input,
>    digital input, and current input with hart
>  * use voltage input channels spec for high impedance mode
>  * put () around macro parameters
>  * merge AD74413R_CHANNEL macro into its uses
>  * remove unused switch case scope
>  * inline return IIO_VAL_INT
>  * use {get,put}_unaligned_be16
>  * use proper types for reg and val
>  * move default case handling into switch statements
>  * pass driver state into regmap functions
>  * use genmask for generating a 16bit max value
>  * alphanumeric order for part numbers
>  * dt-bindings: remove $ref from ohms value
> 
> V4 -> V5
>  * dt-bindings: include headers necessary
>  * dt-bindings: add IRQ_TYPE_EDGE_FALLING to interrupt flags
>  * dt-bindings: ohm -> ohms
>  * dt-bindings: spi0 -> spi
> 
> V5 -> V6
>  * fix warnings regarding overflows
> 
> V6 -> V7
>  * remove extra cache-line alignment
>  * adi,rsense-resistance-ohms -> shunt-resistor-micro-ohms
>  * dt-bindings: add product page links
> 
> V7 -> V8
>  * also check DAC code lower bound
>  * fix checkpath --strict complaints
>  * add comment regarding mutex lock usage
>  * propagate error when converting adc result to resistance
> 
> V8 -> V9
>  * fix spelling mistake
>  * undo propagate error when converting adc result to resistance
>  * return void from adc result to resistance function
>  * limit max adc value when doing resistance calculation to avoid
>    a potential division-by-zero case
> 
> V9 -> V10
>  * pick up Reviewed-By tags
>  * fix odd alignment in header
>  * add dev_err_probe to irq request error path
> 
> V10 -> V11
>  * fix compile error

Applied with one minor tweak to regmap_config which should have been marked
static and turned up in my build tests.

Applied to the togreg branch of iio.git and pushed out initially as testing
to see if 0-day finds anything.

Thanks,

Jonathan


> 
> Cosmin Tanislav (3):
>   iio: add addac subdirectory
>   dt-bindings: iio: add AD74413R
>   iio: addac: add AD74413R driver
> 
>  .../bindings/iio/addac/adi,ad74413r.yaml      |  158 ++
>  MAINTAINERS                                   |    9 +
>  drivers/iio/Kconfig                           |    1 +
>  drivers/iio/Makefile                          |    1 +
>  drivers/iio/addac/Kconfig                     |   20 +
>  drivers/iio/addac/Makefile                    |    7 +
>  drivers/iio/addac/ad74413r.c                  | 1475 +++++++++++++++++
>  include/dt-bindings/iio/addac/adi,ad74413r.h  |   21 +
>  8 files changed, 1692 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>  create mode 100644 drivers/iio/addac/Kconfig
>  create mode 100644 drivers/iio/addac/Makefile
>  create mode 100644 drivers/iio/addac/ad74413r.c
>  create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
> 

