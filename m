Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCA4E8C07
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiC1CX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiC1CX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:23:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029144F440
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:22:17 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KRbxw5HL5zCrBW;
        Mon, 28 Mar 2022 10:20:04 +0800 (CST)
Received: from [10.174.178.212] (10.174.178.212) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 10:22:15 +0800
Subject: Re: [PATCH v2 -next] drm/vc4: Fix build error when CONFIG_DRM_VC4=y
 && CONFIG_RASPBERRYPI_FIRMWARE=m
To:     Maxime Ripard <maxime@cerno.tech>
CC:     <emma@anholt.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <tangyizhou@huawei.com>
References: <20220325021831.2812735-1-zhengbin13@huawei.com>
 <20220325130541.tjxq4kjgmkaz32en@houat>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <601a9682-6afc-d87b-cfa7-5c683271f7a5@huawei.com>
Date:   Mon, 28 Mar 2022 10:22:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20220325130541.tjxq4kjgmkaz32en@houat>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.212]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/25 21:05, Maxime Ripard wrote:
> Hi,
>
> On Fri, Mar 25, 2022 at 10:18:31AM +0800, Zheng Bin wrote:
>> If CONFIG_DRM_VC4=y, CONFIG_RASPBERRYPI_FIRMWARE=m, CONFIG_COMPILE_TEST=n,
>> bulding fails:
>>
>> drivers/gpu/drm/vc4/vc4_drv.o: In function `vc4_drm_bind':
>> vc4_drv.c:(.text+0x320): undefined reference to `rpi_firmware_get'
>> vc4_drv.c:(.text+0x320): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_get'
>> vc4_drv.c:(.text+0x34c): undefined reference to `rpi_firmware_property'
>> vc4_drv.c:(.text+0x34c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_property'
>> vc4_drv.c:(.text+0x354): undefined reference to `rpi_firmware_put'
>> vc4_drv.c:(.text+0x354): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_put'
>>
>> Make DRM_VC4 depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST to fix this.
>>
>> Fixes: c406ad5e4a85 ("drm/vc4: Notify the firmware when DRM is in charge")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
>> ---
>> v2: follow Maxime's advise, add RASPBERRYPI_FIRMWARE as an additional depends
>>   drivers/gpu/drm/vc4/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
>> index de3424fed2fc..92d74ba7c449 100644
>> --- a/drivers/gpu/drm/vc4/Kconfig
>> +++ b/drivers/gpu/drm/vc4/Kconfig
>> @@ -2,6 +2,7 @@
>>   config DRM_VC4
>>   	tristate "Broadcom VC4 Graphics"
>>   	depends on ARCH_BCM || ARCH_BCM2835 || COMPILE_TEST
>> +	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> Why do we need the || COMPILE_TEST here?
>
> The rpi_firmware_get, _property and _put functions aren't define if
> RASPBERRYPI_FIRMWARE, so we need that dependency every time, even if
> COMPILE_TEST is set?

include/soc/bcm2835/raspberrypi-firmware.h

#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)

struct rpi_firmware *rpi_firmware_get(struct device_node 
*firmware_node);/_property/_put

#else    -->empty function

  static inline struct rpi_firmware *rpi_firmware_get(struct device_node 
*firmware_node)/_property/_put
{
          return NULL;
  }
#endif


We can refer to drivers/pwm/Kconfig

config PWM_RASPBERRYPI_POE
          tristate "Raspberry Pi Firwmware PoE Hat PWM support"
          # Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can 
only
         # happen when COMPILE_TEST=y, hence the added 
!RASPBERRYPI_FIRMWARE.
          depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && 
!RASPBERRYPI_FIRMWARE)  -->There is no need to add (&& 
!RASPBERRYPI_FIRMWARE)

>
> Maxime
