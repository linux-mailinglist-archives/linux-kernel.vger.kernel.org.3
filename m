Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB88A4B619E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiBOD2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:28:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiBOD2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:28:49 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02E362B246;
        Mon, 14 Feb 2022 19:28:38 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:33306.1647321622
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id EE8B710023D;
        Tue, 15 Feb 2022 11:28:34 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 2b6fe703291b44efb88e993a70779992 for maxime@cerno.tech;
        Tue, 15 Feb 2022 11:28:36 CST
X-Transaction-ID: 2b6fe703291b44efb88e993a70779992
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <14340eb2-2557-e6f1-9252-8533f5a814df@189.cn>
Date:   Tue, 15 Feb 2022 11:28:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 1/7] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
References: <20220213141649.1115987-1-15330273260@189.cn>
 <20220213141649.1115987-2-15330273260@189.cn>
 <20220214101031.kerresldiuopil6l@houat>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20220214101031.kerresldiuopil6l@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/14 18:10, Maxime Ripard wrote:
> On Sun, Feb 13, 2022 at 10:16:43PM +0800, Sui Jingfeng wrote:
>> From: suijingfeng <suijingfeng@loongson.cn>
>>
>> There is a display controller in loongson's LS2K1000 SoC and LS7A1000
>> bridge chip, the DC is a PCI device in those chips. It has two display
>> pipes but with only one hardware cursor. Each way has a DVO interface
>> which provide RGB888 signals, vertical & horizontal synchronisations,
>> data enable and the pixel clock. Each CRTC is able to scanout from
>> 1920x1080 resolution at 60Hz. The maxmium resolution is 2048x2048
>> according to the hardware spec.
>>
>> Loongson display controllers are simple which require scanout buffers
>> to be physically contiguous. LS2K1000 is a SOC, Only system memory is
>> available. Therefore CMA helper based driver is intended to be use,
>> although it is possible to use VRAM helper based solution by carving
>> out part of system memory as VRAM.
>>
>> On LS7A1000/LS7A2000 bridge chip, the DC is equipped with a dedicated
>> video memory which is typically 64MB or more. In this case, VRAM helper
>> based solution which scanout from local VRAM is reconmended to use.
>> It is reliable to use for massive production, but CMA based helper
>> solution is still usable on ls7a1000 and ls7a2000, at the price of
>> the CRTC must access the FB in RAM through the PCIe bus and HT3.0 bus.
>> This causes continuous traffic on the bus regardless of whether the FB
>> image is updating or not. Sadly, it suffer from screen flickering under
>> RAM pressure on LS7A1000. Luckily, It show extremely good condition on
>> LS7A2000 even under stressapptest, Maybe the hardware engineer resolve
>> this issue. Integrating two distict helpers based driver into one piece
>> allow code sharing.
>>
>> We have also implemented demage update on top of CMA helper which copy
>> the demaged region from the shadow framebuffer in system RAM to the real
>> framebuffer in VRAM manually. This is intend to overcome the screen
>> flicking issue on LS7A1000, but the performance is not good.
>> Using "lsdc.dirty_update=1" in the kernel commmand line if you would like
>> to have a try.
>>
>> For LS7A1000, there are 4 dedicated GPIOs whose control register is
>> located at the DC register space, They are used to emulate two way i2c.
>> One for DVO0, another for DVO1. This is the reason why this driver is
>> not switch to drm bridge framework yet. LS2K1000 and LS2K0500 SoC don't
>> have such GPIO hardwared, they grab i2c adapter from other module,
>> either general purpose GPIO emulated i2c or hardware i2c adapter.
>> Drm bridge and drm panel driver for the external encoder is suitable for
>> those SoC. We have already implemented this on our downstream 4.19.190
>> kernel. But due to the GPIO, PWM and I2C device driver support for
>> LS2K1000 is not upstreamed yet, this driver still can be use to bring
>> the graphic environment up by providing display timings or similar things
>> in the device tree.
>>
>> The DC in LS7A1000 has only one hardware cursor, we simply let the two
>> CRTC share it. The DC in LS7A2000 have two cursor, two built-in hdmi
>> encoder and one transparent vga encoder and more, surport for LS7A2000
>> is on the way. In short, we have built-in gpio emulated i2c support,
>> we also have hardware cursor support. LS7A2000 The kind of tiny drivers
>> in drm/tiny is not suitable for us.
>>
>>      +------+            +-----------------------------------+
>>      | DDR4 |            |  +-------------------+            |
>>      +------+            |  | PCIe Root complex |   LS7A1000 |
>>         || MC0           |  +--++---------++----+            |
>>    +----------+  HT 3.0  |     ||         ||                 |
>>    | LS3A4000 |<-------->| +---++---+  +--++--+    +---------+   +------+
>>    |   CPU    |<-------->| | GC1000 |  | LSDC |<-->| DDR3 MC |<->| VRAM |
>>    +----------+          | +--------+  +-+--+-+    +---------+   +------+
>>         || MC1           +---------------|--|----------------+
>>      +------+                            |  |
>>      | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
>>      +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DVI/HDMI
>>                        +-------+                      +------+
>>
>> The above picture give a simple usage of LS7A1000, note that the encoder
>> is not necessary adv7125 or tfp410, it is a choice of the downstream board
>> manufacturer. Other candicate encoders can be ch7034b, sil9022 and ite66121
>> lt8618 etc. Besides, the DC in both ls2k1000 and ls7k1000 has the same of
>> PCI vendor id and pci device id. Both is 0x0014:0x7a06, the reverison id
>> is also same. This is the firmware engineer's mistake, but such firmware
>> and various boards ship with such firmware already released. We choose to
>> deduce the chip's identification from information provided by device tree.
>> For lsdc, there is only a 1:1 mapping of encoders and connectors.
>>
>> v2: fixup warnings reported by kernel test robot
>>
>> v3: fix more grammar mistakes in Kconfig reported by Randy Dunlap and give
>>      more details about lsdc.
>>
>> v4:
>>     1) Add dts required and explain why device tree is required.
>>     2) Give more description about lsdc and vram helper base driver.
>>     3) Fix warnings reported by kernel test robot.
>>     4) Introduce stride_alignment member into struct lsdc_chip_desc, the
>>        stride alignment is 256 bytes for ls7a1000, ls2k1000 and ls2k0500.
>>        But ls7a2000 improve it to 32 bytes, for extend the support for the
>>        device on coming
>>
>> v5:
>>     1) using writel and readl replace writeq and readq, to fix kernel test
>>        robot report build error on other archtecture
>>     2) set default fb format to XRGB8888 at crtc reset time.
>>     3) fix typos.
>>
>> v6:
>>     1) Explain why we are not switch to drm dridge subsystem on ls2k1000.
>>     2) Explain why tiny drm driver is not suitable for us.
>>     3) Give a short description of the trival dirty uppdate implement based
>>        on CMA helper.
>>     4) code clean up
>>
>> v7:
>>     1) Remove select I2C_GPIO and I2C_LS2X in Kconfig, it is not ready now
>>     2) Licensing issues are fixed suggested by Krzysztof Kozlowski.
>>     3) lsdc_pixpll_print() is removed, part of it move to debugfs.
>>     4) Set prefer_shadow to true if vram based driver is in using.
>>     5) Replace double blank lines with single line in all files
>>     6) Verbose cmd line parameter is replaced with drm_dbg()
>>     7) All warnnings reported by ./scripts/checkpatch.pl --strict are fixed
>>     8) Get edid from dtb support is removed as suggested by Maxime Ripard
>>     9) Fix typos and various improvement
> you *need* to have a DT bindings description

Ok, I know that, it takes some time to document it though.

