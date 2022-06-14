Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEF54AF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbiFNLmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiFNLmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30633152D;
        Tue, 14 Jun 2022 04:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FAE761319;
        Tue, 14 Jun 2022 11:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB12C3411B;
        Tue, 14 Jun 2022 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655206956;
        bh=Wjy0k6PpJbFhFOoNlE9Qv+v/Zpxwj3EDjUSlAzHy1lQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDoa8lrQ/UJsPIGpXTSPoztcA47Nzq2VGRDj+vnWpeHDyoB5SkvkZ5oO6oXjJwD7z
         3OOpNMTPM4KJQ6EcNnsqNSScju/mzdGhISeIpr7DN8WZmpVoYB4Mp9ZTjJSSP7+bvN
         bvjYZj4Nw0zpnIfuCXqZXIMkLmTBe0Hh32jbWodrPqFGo+syhrawBCdx+iBUbc/7qq
         559JQcBMGSleUCTs1LlnxNQjLkSocFOSxK0/SdmI2P22fa9M6x0xX++xKcM40UwZ/K
         t745G8Bu1O0/qxiwX7GEmOnYKnN59SELUBzUDjiFcpdHuIbF2lFEu9zGetpziZ2hcS
         UeoACwW4tkwIA==
Date:   Tue, 14 Jun 2022 12:51:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        andy.shevchenko@gmail.com, digetx@gmail.com
Subject: Re: [PATCH v5 0/2] Add LTRF216A Driver
Message-ID: <20220614125146.35b8288d@jic23-huawei>
In-Reply-To: <20220608113553.32083-1-shreeya.patel@collabora.com>
References: <20220608113553.32083-1-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jun 2022 17:05:51 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> This patchset adds support for ltrf216a Ambient Light Sensor
> and documents the DT bindings for the same.
> 
As Andy already gave some valuable feedback and you have
a few autobuilder checks to fix up (plus I'm low on time this week)
I'll wait for v6 before taking another look.

Thanks,

Jonathan

> 
> Changes in v5
>   - Add power management support.
>   - Add reset functionality.
>   - Use readx_poll_timeout() to get data.
>   - Cleanup some of the redundant code.
>   - Update int_time_fac after I2C write is successful.
>   - Rename mutex to lock.
>   - Use Reverse Xmas tree pattern for all variable definitions.
>   - Improve error handling messages and add error codes.
>   - Add one more MODULE_AUTHOR.
>   - Remove cleardata which was reading data for infrared light.
>   - Remove patch for deprecated vendor prefix [PATCH v4 3/3].
>   - Remove deprecated string from DT binding document.
> 
> Changes in v4
>   - Add more descriptive comment for mutex lock
>   - Fix mutex locking in read_raw()
>   - Use i2c_smbus_read_i2c_block_data()
> 
> Changes in v3
>   - Use u16 instead of u8 for int_time_fac
>   - Reorder headers in ltrf216a.c file
>   - Remove int_time_mapping table and use int_time_available
>   - Fix indentation in the bindings file.
> 
> Changes in v2
>   - Add support for 25ms and 50ms integration time.
>   - Rename some of the macros as per names given in datasheet
>   - Add a comment for the mutex lock
>   - Use read_avail callback instead of attributes and set the
>     appropriate _available bit.
>   - Use FIELD_PREP() at appropriate places.
>   - Add a constant lookup table for integration time and reg val
>   - Use BIT() macro for magic numbers.
>   - Improve error handling at few places.
>   - Use get_unaligned_le24() and div_u64()
>   - Use probe_new() callback and devm functions
>   - Return errors in probe using dev_err_probe()
>   - Use DEFINE_SIMPLE_DEV_PM_OPS()
>   - Correct the formula for lux to use 0.45 instead of 0.8
>   - Add interrupt and power supply property in DT bindings
>   - Add vendor prefix name as per the alphabetical order.
> 
> 
> Shreeya Patel (2):
>   dt-bindings: Document ltrf216a light sensor bindings
>   iio: light: Add support for ltrf216a sensor
> 
>  .../bindings/iio/light/liteon,ltrf216a.yaml   |  50 ++
>  drivers/iio/light/Kconfig                     |  10 +
>  drivers/iio/light/Makefile                    |   1 +
>  drivers/iio/light/ltrf216a.c                  | 441 ++++++++++++++++++
>  4 files changed, 502 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
>  create mode 100644 drivers/iio/light/ltrf216a.c
> 

