Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E38588CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiHCNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiHCNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:05:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E096B14D24;
        Wed,  3 Aug 2022 06:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B4C5B8224F;
        Wed,  3 Aug 2022 13:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDC9C433C1;
        Wed,  3 Aug 2022 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659531904;
        bh=fMUxhUc7uJ8+imfhsLv+MT5zBVy0Cj9HcWTQiwMqhn4=;
        h=From:To:Cc:Subject:Date:From;
        b=jJpSzA+/lwXrK0Xy9LM9rH6WHNlE6xLiFiLro2d5f35C26BN2f3fLzU9bh4UjrsI5
         Q3EGnQY3+2O0xYJ1eDw0+W/X8DGEIJScfQPV4LWEIpDRQDPlJ71+BNrUCLwCDxetRq
         ohevZN8qDvlCWZSI6BNDHNfJ7bjo9nOaotivcq+zMDucLhih+BIM2C/8KK3ouonrTC
         TswIt5A6asrHkfJM+V0WGgPSj/BhqaxuMuceMxHFER5LGvzphEzw4lozdGCsrEnYAq
         wW7ayosrmZ8OXAG3wWW7/FXXPg7/MCXnY7iO1/jCqjvKb0PfjoTaTAkZS32UZ9dVKP
         nQiP1k3NA4TjQ==
From:   broonie@kernel.org
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the thermal tree
Date:   Wed,  3 Aug 2022 14:05:00 +0100
Message-Id: <20220803130500.223005-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the thermal tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c: In function 'sun4i_gpadc_probe':
/tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c:640:44: error: passing argument 1 of 'thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
  640 |   info->tzd = thermal_of_zone_register(info->sensor_device,
      |                                        ~~~~^~~~~~~~~~~~~~~
      |                                            |
      |                                            struct device *
In file included from /tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c:31:
/tmp/next/build/include/linux/thermal.h:301:29: note: expected 'struct device_node *' but argument is of type 'struct device *'
  301 | struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c: In function 'sun4i_gpadc_remove':
/tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c:684:2: error: implicit declaration of function 'thermal_zone_of_sensor_unregister'; did you mean 'thermal_zone_device_unregister'? [-Werror=implicit-function-declaration]
  684 |  thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |  thermal_zone_device_unregister
cc1: all warnings being treated as errors

Caused by commit

   990ee4496499ef61c06bbf ("iio/drivers/sun4i_gpadc: Switch to new of thermal API")

I have used the version of the tree from 20220728 instead.


