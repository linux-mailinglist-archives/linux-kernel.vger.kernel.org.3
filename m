Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A9585FCD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiGaQYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiGaQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:24:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CBBFD1B;
        Sun, 31 Jul 2022 09:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80F4FB80DA2;
        Sun, 31 Jul 2022 16:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA57C433C1;
        Sun, 31 Jul 2022 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659284675;
        bh=zIfT12tnwJq/DHxO3JDHCrsfY6cAZhMxyMpQL4k8BlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RHk92vJOFgnmG5gh1fBtXiDrUesy9CCx/dyDtAkatVjGDE38kWwdjK1Fda6hzMyrj
         Yej741/bTVNdk76J0ZZ48AWj+bsPKLu54a97FYSkyUAJcN6CwV8/j2LGh9k22N8HAi
         2wUzzTy74cass+mSMnsp2JAKBIWBYh/guGxtwx2vf9Cji+4T4D4GQ5FLgVOfVPXbxF
         j9GHIBEFYnRa6hGh4Bn1LUA9ziSFHAwZUTmOrNfGxMl2uW2v8bRSOY+zzKqptqAQ+Q
         bsQdKgCiRj84ztxkqwy23LXgny87CQsEwe3Na0Oe8+BdxCaVXLdBG98Mb4j9MvarGa
         PMA7E2n+fcmWA==
Date:   Sun, 31 Jul 2022 17:34:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        dmitry.osipenko@collabora.com, krisman@collabora.com,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH v10 0/2] Add LTRF216A Driver
Message-ID: <20220731173446.7400bfa8@jic23-huawei>
In-Reply-To: <20220725104050.491396-1-shreeya.patel@collabora.com>
References: <20220725104050.491396-1-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 16:10:48 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> This patchset adds support for ltrf216a Ambient Light Sensor
> and documents the DT bindings for the same.

Series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to see if they can find anything we missed.

Thanks for persisting with this!  Note that it will be queued up for
next cycle and that I'll rebase my tree on rc1 once available.
I won't push out as togreg (which is picked up by linux-next) until
after that rebase.

Thanks,

Jonathan

> 
> Changes in v10
>   - Handle !CONFIG_PM scenario similar to how other IIO drivers
>     do it.
>   - Fix kernel test robot warning.
> 
> Changes in v9
>   - Add LTRF216A_MAIN_STATUS register in volatile function.
>   - Update the datasheet link.
> 
> Changes in v8
>   - Add caching mechanism to restore register state after h/w resume.
>   - Add callback functions and disable locking in regmap config.
>   - Update mutex comment as per it's current scope in the driver.
>   - Add Shreeya as author of the driver.
>   - Make some minor cleanups.
> 
> Changes in v7
>   - Add regmap support.
>   - Fix runtime power management implementation.
>   - Fix the ordering of devm and non-devm functions.
>   - Use DEFINE_RUNTIME_DEV_PM_OPS macro
>   - Fix the error reported by kernel test robot for bindings.
> 
> Changes in v6
>   - Fix some errors reported by kernel test robot.
>   - Add protocol details for the datasheet link.
>   - Remove useless assignments.
>   - Add unit details for read data delay macro.
>   - Use pm_sleep_ptr().
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
>  .../bindings/iio/light/liteon,ltrf216a.yaml   |  49 ++
>  drivers/iio/light/Kconfig                     |  11 +
>  drivers/iio/light/Makefile                    |   1 +
>  drivers/iio/light/ltrf216a.c                  | 537 ++++++++++++++++++
>  4 files changed, 598 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
>  create mode 100644 drivers/iio/light/ltrf216a.c
> 

