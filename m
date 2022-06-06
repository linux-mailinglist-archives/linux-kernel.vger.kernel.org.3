Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC65B53EC7C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbiFFPQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240346AbiFFPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:16:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BA5655499
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:16:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28595D6E;
        Mon,  6 Jun 2022 08:16:13 -0700 (PDT)
Received: from [10.57.82.168] (unknown [10.57.82.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03ACB3F73B;
        Mon,  6 Jun 2022 08:16:11 -0700 (PDT)
Message-ID: <367f8d3d-7890-12bd-6caf-c470b0b4c614@arm.com>
Date:   Mon, 6 Jun 2022 16:16:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v6 2/2] Documentation: Add document for UltraSoc SMB
 drivers
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
References: <20220606130223.57354-1-liuqi115@huawei.com>
 <20220606130223.57354-3-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220606130223.57354-3-liuqi115@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi

Please find my comments below.

On 06/06/2022 14:02, Qi Liu wrote:
> This patch bring in a documentation for UltraSoc SMB drivers.
> It simple descripts the device, sysfs interface and the
> firmware bindings.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   .../trace/coresight/ultrasoc-smb.rst          | 80 +++++++++++++++++++
>   1 file changed, 80 insertions(+)
>   create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst
> 
> diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation/trace/coresight/ultrasoc-smb.rst
> new file mode 100644
> index 000000000000..b4cfea82deb8
> --- /dev/null
> +++ b/Documentation/trace/coresight/ultrasoc-smb.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +UltraSoc - HW Assisted Tracing on SoC
> +======================================
> +   :Author:   Qi Liu <liuqi115@huawei.com>
> +   :Date:     March 2022
> +
> +Introduction
> +------------
> +
> +UltraSoc SMB is a per SCCL(Super CPU Cluster) hardware, and it provides a way to buffer and store

minor nit: alignment.

> +CPU trace messages in a region of shared system memory. SMB is plugged as
> +a coresight sink device and the corresponding trace generators (ETM) are
> +plugged in as source devices.
> +

--8>---

> +Sysfs files and directories
> +---------------------------
> +
> +The SMB devices appear on the existing coresight bus alongside the other
> +coresight devices::
> +
> +	$# ls /sys/bus/coresight/devices/
> +	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
> +
> +The ``ultra_smb<N>`` named SMB associated with SCCL.::
> +
> +	$# ls /sys/bus/coresight/devices/ultra_smb0
> +	enable_sink   mgmt
> +	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
> +	buf_size  buf_status  read_pos  write_pos
> +

These should also be placed in, with the appropriate format.

Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb



> +*Key file items are:-*
> +   * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer register.
> +   * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer register.
> +   * ``buf_status``: Shows the value held by UltraSoc SMB status register.
> +		     BIT(0) is zero means buffer is empty.
> +   * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.
> +
> +Firmware Bindings
> +---------------------------
> +
> +Firmware binding of SMB device describes SMB device indentifier, resource
> +information and graph structure.

Please could you mention that this is only supported with ACPI here ?

> +
> +SMB is platform device and device id is "HISI03A1", resource of device is
> +declared using the _CRS method. Each SMB must present two base address,

Simply say, the device is identified by ACPI HID "HISI03A1".

> +the first one is the configuration base address of SMB device, the second
> +one is the base address of shared system memory.
> +
> +examples::
> +
> +    Device(USMB) {                                               \
> +      Name(_HID, "HISI03A1")                                     \
> +      Name(_CRS, ResourceTemplate() {                            \
> +          MEM_RESRC(0x95100000, 0x951FFFFF, 0x100000)            \
> +          MEM_RESRC(0x50000000, 0x53FFFFFF, 0x4000000)           \
> +      })                                                         \
> +      Name(_DSD, Package() {                                     \
> +        ToUUID("ab02a46b-74c7-45a2-bd68-f7d344ef2153"),          \
> +	/* Use CoreSight Graph ACPI bindings to describe connections topology */
> +        Package() {                                              \
> +          0,                                                     \
> +          1,                                                     \
> +          Package() {                                            \
> +            1,                                                   \
> +            ToUUID("3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd"),      \
> +            8,                                                   \
> +            Package() {0x8, 0, \_SB.S00.SL11.CL28.F008, 0},       \
> +            Package() {0x9, 0, \_SB.S00.SL11.CL29.F009, 0},       \
> +            Package() {0xa, 0, \_SB.S00.SL11.CL2A.F010, 0},       \
> +            Package() {0xb, 0, \_SB.S00.SL11.CL2B.F011, 0},       \
> +            Package() {0xc, 0, \_SB.S00.SL11.CL2C.F012, 0},       \
> +            Package() {0xd, 0, \_SB.S00.SL11.CL2D.F013, 0},       \
> +            Package() {0xe, 0, \_SB.S00.SL11.CL2E.F014, 0},       \
> +            Package() {0xf, 0, \_SB.S00.SL11.CL2F.F015, 0},       \
> +          }                                                      \
> +        }                                                        \
> +      })                                                         \
> +    }

Rest looks fine to me

Suzuki
