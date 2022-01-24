Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B249A498885
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbiAXSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:43:17 -0500
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48]:36411 "EHLO
        6.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiAXSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:43:16 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.237])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id B2D362073E;
        Mon, 24 Jan 2022 18:34:20 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 19:34:19 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-100R00353a1b078-a404-4540-ae70-b2dabb8d92b1,
                    8B4FF7E59EB7D736B5D3E090BD3F43F29F49559A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b222361a-288a-55b2-fc02-04c0b93b4220@kaod.org>
Date:   Mon, 24 Jan 2022 19:34:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mtd: aspeed-smc: improve probe resilience
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Patrick Williams <patrick@stwcx.xyz>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Potin Lai <potin.lai@quantatw.com>,
        <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com> <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com> <20220103171721.46c8e697@xps13>
 <YdSP6tKyQ2ZRUC+2@heinlein> <20220105063244.lno3xur64uepa7i5@ti.com>
 <d4ba6413-57ce-14c1-ed48-d00db2f74bd3@kaod.org>
 <20220124153644.m3iwlvq5ld5cpbyz@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220124153644.m3iwlvq5ld5cpbyz@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 07b6c703-0c15-4072-babf-e7f8a66e6818
X-Ovh-Tracer-Id: 17378265064938245112
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdvgefguddthffhffehffdtteekhfegheegveelgfdugfeftdevhfekjeefgeejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> spimem needs an extension I think. Sorry I have not been able to
>> push that forward. Lack of time and other tasks to address on the
>> host side of the machine. This is really a software problem, we
>> have the HW procedures ready. If a spimem expert could get involved
>> to make a few proposals, I would be happy to help and do some testing.
>> QEMU models are good enough for the software part. We can do the
>> training validation on real HW when ready.
> 
> What information about the flash do you need for this training? 

Last time I looked, we lacked some post_init handler to setup a slave:
configure the registers defining the AHB windows for each flash
slave and perform the read timing calibration. calibration should
only be done once.

See how the aspeed_spi_flash_init() routine doing the calibration
is hooked up under aspeed_spi_claim_bus() in the u-boot driver :

   https://github.com/openbmc/u-boot/blob/v2019.04-aspeed-openbmc/drivers/spi/aspeed_spi.c

Not good enough for upstream, Linux would be the same :/

> I proposed a patch series [0] some time ago trying to implement training
> for TI SoCs. It did not get merged but I do intend to respin it and get
> it through. Would this API work for your tuning as well?

I will take a look.
  
> Also, I am curious how your training works. What data do you read for
> training delays? Where is it stored? 

The driver reads the first 16K at slow speed (that's why we need a
basic minimal setup of the slave) and checks if the buffer is valid
enough for the calibration :

   https://github.com/openbmc/linux/blob/dev-5.15/drivers/mtd/spi-nor/controllers/aspeed-smc.c#L998

it then performs reads by changing the frequency and delays and
compares results with the initial default buffer.

if not, then the driver stays in a safe mode (slow).

> In our case we need to flash a
> known pattern at some location (which is passed in via DT). Do you need
> to run it for every read transaction or just once after the flash is
> initialized?

Just once because it is a heavy process. See the debug outputs below.
Once we have good read timings and frequency, there is no need to do
it each time.

> [0] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=233504&state=%2A&archive=both
Thanks,

C.



There are 3 controllers, 1e620000/FMC is for the BMC. We keep
safe settings for it and normally u-boot has done the training
already . The other two controllers are for the SPI-NOR of the
host and for these we push the frequency higher.


AST2600 EVB:

[    0.689662] aspeed-smc 1e620000.spi: Using 50 MHz SPI frequency
[    0.696412] aspeed-smc 1e620000.spi: control register: 203b0641
[    0.696426] aspeed-smc 1e620000.spi: control register changed to: 00000600
[    0.696434] aspeed-smc 1e620000.spi: default control register: 00000600
[    0.696616] aspeed-smc 1e620000.spi: w25q512jv (65536 Kbytes)
[    0.703108] aspeed-smc 1e620000.spi: CE0 window [ 0x20000000 - 0x24000000 ] 64MB
[    0.711445] aspeed-smc 1e620000.spi: CE1 window [ 0x24000000 - 0x2c000000 ] 128MB
[    0.719864] aspeed-smc 1e620000.spi: write control register: 00120602
[    0.719873] aspeed-smc 1e620000.spi: read control register: 203c0641
[    0.727026] aspeed-smc 1e620000.spi: AHB frequency: 187 MHz
[    0.739247] aspeed-smc 1e620000.spi: Trying HCLK/5 [203c0d41] ...
[    0.767181] aspeed-smc 1e620000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    0.767196] aspeed-smc 1e620000.spi: Trying HCLK/4 [203c0641] ...
[    0.791559] aspeed-smc 1e620000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    0.791571] aspeed-smc 1e620000.spi: Found good read timings at HCLK/4
[    0.795729] 5 fixed-partitions partitions found on MTD device bmc
[    0.802636] Creating 5 MTD partitions on "bmc":
[    0.807739] 0x000000000000-0x0000000e0000 : "u-boot"
[    0.814367] 0x0000000e0000-0x000000100000 : "u-boot-env"
[    0.821306] 0x000000100000-0x000000a00000 : "kernel"
[    0.827755] 0x000000a00000-0x000002a00000 : "rofs"
[    0.834051] 0x000002a00000-0x000004000000 : "rwfs"
[    0.844040] aspeed-smc 1e630000.spi: Using 100 MHz SPI frequency
[    0.850912] aspeed-smc 1e630000.spi: control register: 00000400
[    0.850927] aspeed-smc 1e630000.spi: default control register: 00000400
[    0.851152] aspeed-smc 1e630000.spi: w25q256 (32768 Kbytes)
[    0.857427] aspeed-smc 1e630000.spi: CE0 window [ 0x30000000 - 0x32000000 ] 32MB
[    0.865792] aspeed-smc 1e630000.spi: CE1 window [ 0x32000000 - 0x32000000 ] 0MB (disabled)
[    0.875129] aspeed-smc 1e630000.spi: write control register: 00120402
[    0.875142] aspeed-smc 1e630000.spi: read control register: 203c0441
[    0.882296] aspeed-smc 1e630000.spi: AHB frequency: 187 MHz
[    0.894509] aspeed-smc 1e630000.spi: Trying HCLK/5 [203c0d41] ...
[    0.922417] aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    0.922432] aspeed-smc 1e630000.spi: Trying HCLK/4 [203c0641] ...
[    0.946791] aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    0.946803] aspeed-smc 1e630000.spi: Trying HCLK/3 [203c0e41] ...
[    0.967644] aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    0.967655] aspeed-smc 1e630000.spi: Trying HCLK/2 [203c0741] ...
[    0.969325] aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, DI delay none : FAIL
[    0.971007] aspeed-smc 1e630000.spi:   * [00000008] 0 HCLK delay, DI delay 0.5ns : FAIL
[    0.972679] aspeed-smc 1e630000.spi:   * [00000018] 0 HCLK delay, DI delay 1.5ns : FAIL
[    0.974350] aspeed-smc 1e630000.spi:   * [00000028] 0 HCLK delay, DI delay 1.5ns : FAIL
[    0.976021] aspeed-smc 1e630000.spi:   * [00000038] 0 HCLK delay, DI delay 2.5ns : FAIL
[    0.977692] aspeed-smc 1e630000.spi:   * [00000048] 0 HCLK delay, DI delay 2.5ns : FAIL
[    0.979363] aspeed-smc 1e630000.spi:   * [00000058] 0 HCLK delay, DI delay 3.5ns : FAIL
[    0.981042] aspeed-smc 1e630000.spi:   * [00000068] 0 HCLK delay, DI delay 3.5ns : FAIL
[    0.982714] aspeed-smc 1e630000.spi:   * [00000078] 0 HCLK delay, DI delay 4.5ns : FAIL
[    0.984385] aspeed-smc 1e630000.spi:   * [00000088] 0 HCLK delay, DI delay 4.5ns : FAIL
[    0.986056] aspeed-smc 1e630000.spi:   * [00000098] 0 HCLK delay, DI delay 5.5ns : FAIL
[    0.987727] aspeed-smc 1e630000.spi:   * [000000a8] 0 HCLK delay, DI delay 5.5ns : FAIL
[    0.989397] aspeed-smc 1e630000.spi:   * [000000b8] 0 HCLK delay, DI delay 6.5ns : FAIL
[    0.991084] aspeed-smc 1e630000.spi:   * [000000c8] 0 HCLK delay, DI delay 6.5ns : FAIL
[    0.992757] aspeed-smc 1e630000.spi:   * [000000d8] 0 HCLK delay, DI delay 7.5ns : FAIL
[    0.994428] aspeed-smc 1e630000.spi:   * [000000e8] 0 HCLK delay, DI delay 7.5ns : FAIL
[    0.996099] aspeed-smc 1e630000.spi:   * [000000f8] 0 HCLK delay, DI delay 8.5ns : FAIL
[    1.013874] aspeed-smc 1e630000.spi:   * [000000f1] 1 HCLK delay, DI delay none : PASS
[    1.013885] aspeed-smc 1e630000.spi: Found good read timings at HCLK/2
[    1.021498] aspeed-smc 1e631000.spi: Using 100 MHz SPI frequency
[    1.028291] aspeed-smc 1e631000.spi: control register: 00000400
[    1.028302] aspeed-smc 1e631000.spi: default control register: 00000400
[    1.028510] aspeed-smc 1e631000.spi: w25q256 (32768 Kbytes)
[    1.034848] aspeed-smc 1e631000.spi: CE0 window [ 0x50000000 - 0x52000000 ] 32MB
[    1.043197] aspeed-smc 1e631000.spi: CE1 window [ 0x52000000 - 0x52000000 ] 0MB (disabled)
[    1.052518] aspeed-smc 1e631000.spi: write control register: 00120402
[    1.052530] aspeed-smc 1e631000.spi: read control register: 203c0441
[    1.059677] aspeed-smc 1e631000.spi: AHB frequency: 187 MHz
[    1.071900] aspeed-smc 1e631000.spi: Trying HCLK/5 [203c0d41] ...
[    1.099805] aspeed-smc 1e631000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    1.099817] aspeed-smc 1e631000.spi: Trying HCLK/4 [203c0641] ...
[    1.124202] aspeed-smc 1e631000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    1.124219] aspeed-smc 1e631000.spi: Trying HCLK/3 [203c0e41] ...
[    1.145070] aspeed-smc 1e631000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    1.145082] aspeed-smc 1e631000.spi: Trying HCLK/2 [203c0741] ...
[    1.146752] aspeed-smc 1e631000.spi:   * [00000000] 0 HCLK delay, DI delay none : FAIL
[    1.148422] aspeed-smc 1e631000.spi:   * [00000008] 0 HCLK delay, DI delay 0.5ns : FAIL
[    1.150093] aspeed-smc 1e631000.spi:   * [00000018] 0 HCLK delay, DI delay 1.5ns : FAIL
[    1.151778] aspeed-smc 1e631000.spi:   * [00000028] 0 HCLK delay, DI delay 1.5ns : FAIL
[    1.153451] aspeed-smc 1e631000.spi:   * [00000038] 0 HCLK delay, DI delay 2.5ns : FAIL
[    1.155122] aspeed-smc 1e631000.spi:   * [00000048] 0 HCLK delay, DI delay 2.5ns : FAIL
[    1.156793] aspeed-smc 1e631000.spi:   * [00000058] 0 HCLK delay, DI delay 3.5ns : FAIL
[    1.158464] aspeed-smc 1e631000.spi:   * [00000068] 0 HCLK delay, DI delay 3.5ns : FAIL
[    1.160135] aspeed-smc 1e631000.spi:   * [00000078] 0 HCLK delay, DI delay 4.5ns : FAIL
[    1.161818] aspeed-smc 1e631000.spi:   * [00000088] 0 HCLK delay, DI delay 4.5ns : FAIL
[    1.163490] aspeed-smc 1e631000.spi:   * [00000098] 0 HCLK delay, DI delay 5.5ns : FAIL
[    1.165161] aspeed-smc 1e631000.spi:   * [000000a8] 0 HCLK delay, DI delay 5.5ns : FAIL
[    1.166833] aspeed-smc 1e631000.spi:   * [000000b8] 0 HCLK delay, DI delay 6.5ns : FAIL
[    1.168504] aspeed-smc 1e631000.spi:   * [000000c8] 0 HCLK delay, DI delay 6.5ns : FAIL
[    1.170175] aspeed-smc 1e631000.spi:   * [000000d8] 0 HCLK delay, DI delay 7.5ns : FAIL
[    1.171863] aspeed-smc 1e631000.spi:   * [000000e8] 0 HCLK delay, DI delay 7.5ns : FAIL
[    1.173536] aspeed-smc 1e631000.spi:   * [000000f8] 0 HCLK delay, DI delay 8.5ns : FAIL
[    1.191318] aspeed-smc 1e631000.spi:   * [000000f1] 1 HCLK delay, DI delay none : PASS
[    1.191330] aspeed-smc 1e631000.spi: Found good read timings at HCLK/2


an ASTS2500 EVB :

[    1.220804] aspeed-smc 1e620000.spi: Using 50 MHz SPI frequency
[    1.226797] aspeed-smc 1e620000.spi: control register: 000b0641
[    1.226836] aspeed-smc 1e620000.spi: control register changed to: 00000600
[    1.226860] aspeed-smc 1e620000.spi: default control register: 00000600
[    1.227092] aspeed-smc 1e620000.spi: w25q256 (32768 Kbytes)
[    1.232806] aspeed-smc 1e620000.spi: CE0 window [ 0x20000000 - 0x22000000 ] 32MB
[    1.240329] aspeed-smc 1e620000.spi: CE1 window [ 0x22000000 - 0x2a000000 ] 128MB
[    1.247852] aspeed-smc 1e620000.spi: write control register: 00020602
[    1.247882] aspeed-smc 1e620000.spi: read control register: 203b0641
[    1.254315] aspeed-smc 1e620000.spi: AHB frequency: 198 MHz
[    1.265406] aspeed-smc 1e620000.spi: Trying HCLK/5 [203b0d41] ...
[    1.287111] aspeed-smc 1e620000.spi:   * [00080000] 0 HCLK delay, 4ns DI delay : PASS
[    1.309048] aspeed-smc 1e620000.spi:   * [00000000] 0 HCLK delay, 0ns DI delay : PASS
[    1.331223] aspeed-smc 1e620000.spi:   * [00090000] 1 HCLK delay, 4ns DI delay : PASS
[    1.331278] aspeed-smc 1e620000.spi:  * -> good is pass 1 [0x00000000]
[    1.331308] aspeed-smc 1e620000.spi: Trying HCLK/4 [203b0641] ...
[    1.349958] aspeed-smc 1e620000.spi:   * [00008000] 0 HCLK delay, 4ns DI delay : PASS
[    1.368473] aspeed-smc 1e620000.spi:   * [00000000] 0 HCLK delay, 0ns DI delay : PASS
[    1.387341] aspeed-smc 1e620000.spi:   * [00009000] 1 HCLK delay, 4ns DI delay : PASS
[    1.387397] aspeed-smc 1e620000.spi:  * -> good is pass 1 [0x00000000]
[    1.387435] aspeed-smc 1e620000.spi: Found good read timings at HCLK/4
[    1.858947] Freeing initrd memory: 1044K
[    1.906913] 5 fixed-partitions partitions found on MTD device bmc
[    1.913143] Creating 5 MTD partitions on "bmc":
[    1.917724] 0x000000000000-0x000000060000 : "u-boot"
[    1.925920] 0x000000060000-0x000000080000 : "u-boot-env"
[    1.937262] 0x000000080000-0x0000004c0000 : "kernel"
[    1.948189] 0x0000004c0000-0x000001c00000 : "rofs"
[    1.959196] 0x000001c00000-0x000002000000 : "rwfs"
[    1.971557] aspeed-smc 1e630000.spi: Using 100 MHz SPI frequency
[    1.977632] aspeed-smc 1e630000.spi: control register: 00000200
[    1.977669] aspeed-smc 1e630000.spi: default control register: 00000200
[    1.977961] aspeed-smc 1e630000.spi: w25q256 (32768 Kbytes)
[    1.983674] aspeed-smc 1e630000.spi: CE0 window [ 0x30000000 - 0x32000000 ] 32MB
[    1.991183] aspeed-smc 1e630000.spi: CE1 window [ 0x32000000 - 0x38000000 ] 96MB
[    1.998621] aspeed-smc 1e630000.spi: write control register: 00020202
[    1.998652] aspeed-smc 1e630000.spi: read control register: 203b0241
[    2.005086] aspeed-smc 1e630000.spi: AHB frequency: 198 MHz
[    2.016174] aspeed-smc 1e630000.spi: Trying HCLK/5 [203b0d41] ...
[    2.038011] aspeed-smc 1e630000.spi:   * [00080000] 0 HCLK delay, 4ns DI delay : PASS
[    2.060035] aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, 0ns DI delay : PASS
[    2.082211] aspeed-smc 1e630000.spi:   * [00090000] 1 HCLK delay, 4ns DI delay : PASS
[    2.082266] aspeed-smc 1e630000.spi:  * -> good is pass 1 [0x00000000]
[    2.082295] aspeed-smc 1e630000.spi: Trying HCLK/4 [203b0641] ...
[    2.100938] aspeed-smc 1e630000.spi:   * [00008000] 0 HCLK delay, 4ns DI delay : PASS
[    2.119623] aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, 0ns DI delay : PASS
[    2.138440] aspeed-smc 1e630000.spi:   * [00009000] 1 HCLK delay, 4ns DI delay : PASS
[    2.138491] aspeed-smc 1e630000.spi:  * -> good is pass 1 [0x00000000]
[    2.138521] aspeed-smc 1e630000.spi: Trying HCLK/3 [203b0e41] ...
[    2.139827] aspeed-smc 1e630000.spi:   * [00000800] 0 HCLK delay, 4ns DI delay : FAIL
[    2.155093] aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, 0ns DI delay : PASS
[    2.170627] aspeed-smc 1e630000.spi:   * [00000900] 1 HCLK delay, 4ns DI delay : PASS
[    2.186111] aspeed-smc 1e630000.spi:   * [00000100] 1 HCLK delay, 0ns DI delay : PASS
[    2.186164] aspeed-smc 1e630000.spi:  * -> good is pass 2 [0x00000900]
[    2.186195] aspeed-smc 1e630000.spi: Trying HCLK/2 [203b0741] ...
[    2.187103] aspeed-smc 1e630000.spi:   * [00000080] 0 HCLK delay, 4ns DI delay : FAIL
[    2.188010] aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, 0ns DI delay : FAIL
[    2.200197] aspeed-smc 1e630000.spi:   * [00000090] 1 HCLK delay, 4ns DI delay : PASS
[    2.212359] aspeed-smc 1e630000.spi:   * [00000010] 1 HCLK delay, 0ns DI delay : PASS
[    2.224725] aspeed-smc 1e630000.spi:   * [000000a0] 2 HCLK delay, 4ns DI delay : PASS
[    2.224777] aspeed-smc 1e630000.spi:  * -> good is pass 3 [0x00000010]
[    2.224810] aspeed-smc 1e630000.spi: Found good read timings at HCLK/2
[    2.244098] aspeed-smc 1e631000.spi: Aspeed SMC probe failed -19
