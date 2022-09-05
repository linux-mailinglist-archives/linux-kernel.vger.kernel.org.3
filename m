Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4715AC973
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 06:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiIEEZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 00:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiIEEZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 00:25:46 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C60255BF;
        Sun,  4 Sep 2022 21:25:44 -0700 (PDT)
Received: from [10.88.37.128] (10.88.37.128) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2507.6; Mon, 5 Sep 2022
 12:25:40 +0800
Message-ID: <4a96523d-6f11-00be-0c37-4716d1289989@amlogic.com>
Date:   Mon, 5 Sep 2022 12:25:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 2/4] docs/perf: Add documentation for the Amlogic G12
 DDR PMU
To:     Chris Healy <cphealy@gmail.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>
References: <20220901024526.2833232-1-jiucheng.xu@amlogic.com>
 <20220901024526.2833232-2-jiucheng.xu@amlogic.com>
 <CAFXsbZoFYp_SNEjH0QE=A09JQe8qt1APwnNb9u6KsO5UAL50-A@mail.gmail.com>
Content-Language: en-US
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <CAFXsbZoFYp_SNEjH0QE=A09JQe8qt1APwnNb9u6KsO5UAL50-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.37.128]
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/4 1:35, Chris Healy wrote:
> [ EXTERNAL EMAIL ]
>
> On Wed, Aug 31, 2022 at 7:45 PM Jiucheng Xu <jiucheng.xu@amlogic.com> wrote:
>> Add a user guide to show how to use DDR PMU to
>> monitor DDR bandwidth on Amlogic G12 SoC
>>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> Changes v6 -> v5:
>>    - No change
>>
>> Changes v5 -> v4:
>>    - Fix building warning
>>
>> Changes v3 -> v4:
>>    - No change
>>
>> Changes v2 -> v3:
>>    - Rename doc name from aml-ddr-pmu.rst to meson-ddr-pmu.rst
>>
>> Changes v1 -> v2:
>>    - Nothing was changed
>> ---
>>   Documentation/admin-guide/perf/index.rst      |  1 +
>>   .../admin-guide/perf/meson-ddr-pmu.rst        | 70 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   3 files changed, 72 insertions(+)
>>   create mode 100644 Documentation/admin-guide/perf/meson-ddr-pmu.rst
>>
>> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
>> index 69b23f087c05..997a28e156c1 100644
>> --- a/Documentation/admin-guide/perf/index.rst
>> +++ b/Documentation/admin-guide/perf/index.rst
>> @@ -17,3 +17,4 @@ Performance monitor support
>>      xgene-pmu
>>      arm_dsu_pmu
>>      thunderx2-pmu
>> +   meson-ddr-pmu
>> diff --git a/Documentation/admin-guide/perf/meson-ddr-pmu.rst b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
>> new file mode 100644
>> index 000000000000..28e9910940d0
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
>> @@ -0,0 +1,70 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===========================================================
>> +Amlogic SoC DDR Bandwidth Performance Monitoring Unit (PMU)
>> +===========================================================
>> +
>> +There is a bandwidth monitor inside the DRAM contorller. The monitor include
> Fix spelling of word "controller" and add an s to the end of include
Oh, I will update it in next version.
>
>> +4 channels which can count the read/write request of accessing DRAM individually.
>> +It can be helpful to show if the performance bottleneck is on DDR bandwidth.
>> +
>> +Currently, this driver supports the following 5 Perf events:
>> +
>> ++ meson_ddr_bw/total_rw_bytes/
>> ++ meson_ddr_bw/chan_1_rw_bytes/
>> ++ meson_ddr_bw/chan_2_rw_bytes/
>> ++ meson_ddr_bw/chan_3_rw_bytes/
>> ++ meson_ddr_bw/chan_4_rw_bytes/
>> +
>> +meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are the channel related events.
>> +Each channel support using keywords as filter, which can let the channel
>> +to monitor the individual IP module in SoC.
>> +
>> +The following keywords are the filter:
>> +
>> ++ arm             - DDR access request from CPU
>> ++ vpu_read1       - DDR access request from OSD + VPP read
>> ++ gpu             - DDR access request from 3D GPU
>> ++ pcie            - DDR access request from PCIe controller
>> ++ hdcp            - DDR access request from HDCP controller
>> ++ hevc_front      - DDR access request from HEVC codec front end
>> ++ usb3_0          - DDR access request from USB3.0 controller
>> ++ hevc_back       - DDR access request from HEVC codec back end
>> ++ h265enc         - DDR access request from HEVC encoder
>> ++ vpu_read2       - DDR access request from DI read
>> ++ vpu_write1      - DDR access request from VDIN write
>> ++ vpu_write2      - DDR access request from di write
>> ++ vdec            - DDR access request from legacy codec video decoder
>> ++ hcodec          - DDR access request from H264 encoder
>> ++ ge2d            - DDR access request from ge2d
>> ++ spicc1          - DDR access request from SPI controller 1
>> ++ usb0            - DDR access request from USB2.0 controller 0
>> ++ dma             - DDR access request from system DMA controller 1
>> ++ arb0            - DDR access request from arb0
>> ++ sd_emmc_b       - DDR access request from SD eMMC b controller
>> ++ usb1            - DDR access request from USB2.0 controller 1
>> ++ audio           - DDR access request from Audio module
>> ++ sd_emmc_c       - DDR access request from SD eMMC c controller
>> ++ spicc2          - DDR access request from SPI controller 2
>> ++ ethernet        - DDR access request from Ethernet controller
>> +
>> +
>> +The following command is to show the total DDR bandwidth:
>> +
>> +  .. code-block:: bash
>> +
>> +      perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
>> +
>> +This command will print the total DDR bandwidth per second.
>> +
>> +The following commands are to show how to use filter parameters:
>> +
>> +  .. code-block:: bash
>> +
>> +      perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=1/ -I 1000 sleep 10
>> +      perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=1/ -I 1000 sleep 10
>> +      perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=1,gpu=1/ -I 1000 sleep 10
>> +
>> +The 1st command show how to use channel 1 to monitor the DDR bandwidth from ARM.
>> +The 2nd command show using channel 2 to get the DDR bandwidth of GPU.
>> +The 3rd command show using channel 3 to monitor the sum of ARM and GPU.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ac8a98dfbacc..8ee68e699e6d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1054,6 +1054,7 @@ AMLOGIC DDR PMU DRIVER
>>   M:     Jiucheng Xu <jiucheng.xu@amlogic.com>
>>   S:     Supported
>>   W:     http://www.amlogic.com
>> +F:     Documentation/admin-guide/perf/meson-ddr-pmu.rst
>>   F:     drivers/perf/amlogic/
>>   F:     include/soc/amlogic/
>>
>> --
>> 2.25.1
>>
-- 
Thanks,
Jiucheng

