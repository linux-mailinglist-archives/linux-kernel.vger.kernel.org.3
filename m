Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15155475879
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbhLOMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:11:24 -0500
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:59943
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237054AbhLOMLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:11:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmKDeb9ddQQKaBukt5Ob+1EowY1MqaiMHNt+NHNn35aRpK+H7kiVJmKI3uUIpZadIdyQRMh2Su90THnE3mXHjyo6wA0+1HYTvFIYGmS1TajlyVEVIuK0C/teAvgnuLtK5LOAeF7AByJwrqRFxSVvpmbGRz4MaFpgrPt3NFp/rPGS8u1gAK7w0EXoKQzlXFC0knVyZZivBep2Nmrd97CbDeaW9yN8WF9WV54IF6x5SvUZDCWBMPYeiacs/Yyx9h+K/DAnxsje8SY4gMw8CCw12PyoRGfDiK6XHTj+l3GoQoWmacL2aj60OATvV82AEvWRpEoNV0DQ/9cwQaosQcb76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9jdXd8QeHkj5gXC/NZApuHE4W89IDl40lPBmfY5mN8=;
 b=jVLOP3eFUo2vNshqWTZSJBzGF10wr/yKDJMK6sPVQXLPsjZQFKRmJh+ZxAhtOHn3CHMYHvPUA8iJXh9aRsSvvJ2h7fcCKEX1/brOW23RyyfIP6n7tHa6fO1Mb4GCp/wmiJLOBxg2g37qbNNV64kri/uupWmjVZ+cBSwvSABmnMuDSPID5BbKo7J2KMP/rw1TdXI9HX8fz6iJlD3dSLO1ulcM1wKCVC6UCGWHUoxrkZVqMD9LE4lfGx916CV7UyMctWo2NcuorAdbshkHw/kzA4uWYp8CSif8B6qCXKS7kA+8cZ98TZieGUkIbcZxcwdDoupqxhLmboRnZA98M5Z87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9jdXd8QeHkj5gXC/NZApuHE4W89IDl40lPBmfY5mN8=;
 b=Y8LXMp2Cwj7PN0JGl+O3WaCPyRj3lrvJ6FHxROdSYf2wwLXufVj4ADW87MP6AlZ0A9FHdYCN9wIHMyftQZ9icuTHBHTZmOG4Hltvc6BeHaA3gSqnCv7gLq1N2CBZOAL1Bw88xNkK6wFhSx+XRRYqXnggXultPxTL34ZmnzR6DrE=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BY5PR02MB6913.namprd02.prod.outlook.com (2603:10b6:a03:230::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 12:11:21 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc%7]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 12:11:21 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        'Anand Dumbre' <ananddumbre8@gmail.com>
Subject: RE: [PATCH v12 0/5] Add Xilinx AMS Driver
Thread-Topic: [PATCH v12 0/5] Add Xilinx AMS Driver
Thread-Index: AQHX6IwflNA+ZWcGRkSBPHlmcIY+IKwzh/sQ
Date:   Wed, 15 Dec 2021 12:11:21 +0000
Message-ID: <BY5PR02MB691657682B94F4D3DBDA007EA9769@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
In-Reply-To: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c06d883-5a90-4a7b-e5fd-08d9bfc40201
x-ms-traffictypediagnostic: BY5PR02MB6913:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB691315F28D32FA9B62774A39A9769@BY5PR02MB6913.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kQBFl+XAvIdyfEaUVpsfjUt7B9VbxvUq8PG7s4uNiADndPAO2a4bYPr/2pRwVFquX7eiXa6hPI8c07/ZTXWoYsinhWRpkUXoBWQo/2aKqOhMvVVQHC/+dXGfm+NR/gWcPBslpcKPpt/34iRKQEzbcZrPT6+lfOugPcnAU73MUB0m/AvrVFs2FVLyARFyZn5/K0JDRn7OH9QbFv9/sUao5Ai9/yhaBVNiuWT8cuadDiAhzNfiKribDARuRNHIuy8mgvj1BBHhxP2+2VCTE0g+t5EYcQhBgS5EX/hXs8WAPdsca0Rg9m9LP8Q+WHFdiTkEk13hugyNdKNDTwpN6RMux7yBhWUkwnvXzcKg2Mil+hodhf4abgsmYAZDElwrd876wjPHujTo6ESIOHvbBKCv9afxGEykAdn2cHQ6pzYuAbYlXnK2wAapz1cmRwFKUgQ+xgra73YTBsmesxj8SUkCL+ivO/KoS6HAXA+4s7agwm8WFIp1Glcyu87ILw1P5Rph1ju1OoGazQW3jNUwknFW7UjPIsFL3f2HIry3W+hOPV6datudEoHAgj18t/MJGfMQ8ZBRuKlc2Lc4HQg5SazAJ0LlzmRn7X6L40vCzCn3YNICfOOGEp/LheSpOXyypRV1fNHmfZht3YJEZfOMQued4p/G0HCKS9EA6aYuay8+LyTQjbLPI8Iw4+bYrWCOtQZI33/36rDrHHQIalejW4PaXuL6oYgyrMz0ir1Np/AMFmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(8936002)(66476007)(2906002)(86362001)(64756008)(9686003)(316002)(8676002)(5660300002)(110136005)(55016003)(71200400001)(52536014)(38070700005)(83380400001)(33656002)(26005)(7696005)(38100700002)(508600001)(122000001)(921005)(186003)(7416002)(76116006)(66556008)(6506007)(53546011)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D59EW8dDhVuEGGaJosTqK9Bihrw2Z4A187yTSonZ/23MqSEQiYtWgPzvOiYo?=
 =?us-ascii?Q?XZ4gysR9CHmVHNobOVGH7FkLmFLkhHQjYFFeCAVzLMsP76hpKZQrFmTnT+cT?=
 =?us-ascii?Q?M4FAYQkjc/peIqQi0r7XnVPX7Y2j2Wb++vfftTTP9OHnJuQioAjYkFprBGqK?=
 =?us-ascii?Q?D2lgqv6cJnk1M8xA/aXqZK7rPMjNaLAy6LHh38+NBVLqHZt9/dEiUJZnRfBN?=
 =?us-ascii?Q?hDO7BxXYnovTYQOyQbv9RnSkuwo9p1vMKfOH5nzUxffPoxEQlk4iFUCUsJW2?=
 =?us-ascii?Q?vXt0TMxwsfH4G6Q5oZ1gyAIt50nD5Kp3Hry2zosOYPH6rI/1m/23vKLlgZLb?=
 =?us-ascii?Q?Wm8RzkGkxGtpH2PIou8iNQrlif4rArXXLx5A/KZcN3Twb93HkcQe8iRYI8F7?=
 =?us-ascii?Q?no4Q4CIghLgH+ab/nKLrI8navdLAjRgGgoLK8zVVy9tMaRgKsVzfTgI0atCl?=
 =?us-ascii?Q?eZRZdTgz9hj806kAgGNil5jcMlTQLe18Az+HN9DYw7NVNtkZJXtIQyE/Y5PH?=
 =?us-ascii?Q?Vq/z/+KGH0D9oycAYtL2zBm8bX7yLAWyLcCpWPc+aElWejXiozshPkd9MOut?=
 =?us-ascii?Q?9oiQCr3vCmcmdz++VGauvIB81Gj6yPLn9Lmh5Zi/MGcG20nKqOY5HMt9FvwN?=
 =?us-ascii?Q?UFJ9GvMc+zpQxoCD4U2nX7B3x0atUScnuQ1mXN6HQ8YYi2YXs63uH7jNQ8tv?=
 =?us-ascii?Q?l0Xxgz27FWfSoZXmC+JGvSWDaxaRwG6U1Ye/ZYWuMBRHZSs/3RsS5sHXTbFU?=
 =?us-ascii?Q?zrHwxjJHzR348+JmVREVT/AWDTRkOTIqzBRVN98cGqfHF1PVlvuqCp5xm0oY?=
 =?us-ascii?Q?Kl0AlURcgkP/DSBeJPrk1RXkcWiOXwxmaeP3COxjKq9dpPxNDyNaATypl1jz?=
 =?us-ascii?Q?fRG01W4bcLhdl2fCfhxWVDBeB9IwVX0npVruAcqvISWY2GlSqg1v5N2N6knN?=
 =?us-ascii?Q?oA1mxgOfm33XZjywixCJR9z0ueUIM0HhdYc62dWaC6B1G/BGl1YIZ1Ay5gE7?=
 =?us-ascii?Q?JkOixbTswihSYh41ROCQxKKhIc/I4PlcnLJ75anUE7+DLIuFjZhdDnifU8d7?=
 =?us-ascii?Q?sgCxpnbFakdf3oW6oEHn5wjNdppFv9M1hFgCGwztqUFKbkkexI9f0XI9kTNM?=
 =?us-ascii?Q?sad/9Xk80QCP3kIdOydvLgtEqhT10hfEMLr95mr1mr2YJNRn5+LF1O5NaeCI?=
 =?us-ascii?Q?fg1ZkdDezEuDJ1uKnh8m2Gm/Iia50ZE2UhaYH9QM3g6rSgC98CD28sEvsuzk?=
 =?us-ascii?Q?+y0vxrVJuR7zlIOBACqVSh4mBecu5S6V8dbDlacZ6o8UBEMw5hU8MJPKQMjA?=
 =?us-ascii?Q?HrKDlMzuo2MpCatGFNMT4oYTc9g82wjuSjv76RxXAqLLDPueXoVPDZcWTWdU?=
 =?us-ascii?Q?BkAJcCIDObr5r7zU75jk5EfPahW5P4R/thAzCxp/FeZwJi+704e9RVRxGj+3?=
 =?us-ascii?Q?2Sbt2LngM5dpq1fkzCL/Rmc/WuU0H/0yLNETIBGIoSKAIBJezRj4PKAgDJYq?=
 =?us-ascii?Q?KGzJnife7xnQj3CRAkZENa926uV2j+0W37UyoUoXYliojH6l8IdHgnM7DYMh?=
 =?us-ascii?Q?IsMDGlpFGFZBJubp52wO10TaPZ0VTneVcUFIvoE4CC7UphrCu++ZJk5pNVMO?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c06d883-5a90-4a7b-e5fd-08d9bfc40201
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 12:11:21.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ydo1tYxKVGruMUjeZrNupiij2k4PuBzfv85NjB1NMxoXkrYbAfOniJa6+7ogdje5tH6VVttMdIILDnkZwxKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6913
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!

> -----Original Message-----
> From: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Sent: Friday 3 December 2021 9:24 PM
> To: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de; linu=
x-
> iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com
> Cc: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Subject: [PATCH v12 0/5] Add Xilinx AMS Driver
>=20
> Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
> This AMS driver is used to report various interface voltages and
> temperatures across the system.
> This driver will be used by iio-hwmon to repport voltages and temperature=
s
> across the system by using various channel interfaces.
> This driver handles AMS module including PS-Sysmon & PL-Sysmon. The
> binding documentation is added for understanding of AMS, PS, PL Sysmon
> Channels.
>=20
> Changes in v2:
> 	- Added documentation for sysfs (Patch-2)
> 	- Addressed code style review comments
> 	- Patch-2 (Now it is Patch-3)
> 		- Arranged the includes in alphabetical order
> 		- Removed the wrapper 'ams_pl_write_reg()' and used writel
> 		  instead
> 		- Removed the unnecessary delay of 1ms and used polling of
> EOC
> 		  instead
> 		- Removed spin_lock and used mutex only.
> 		- Used request_irq() instead of devm_request_irq() and
> handled
> 		  respective error conditions
> 		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
> 	- Patch-1
> 		- Addressed Documentation style comments
>=20
> Changes in v3:
> 	- Updated bindings document with the suggested modification in v2
> review
> 	- Removed documentation for sysfs
> 	- Removed extended names for channels in the Xilinx AMS driver
> 	- Modified dts to use ranges for child nodes
> 	- Reduced address and size cells to 32-bit instead of 64-bit
>=20
> Changes in v4:
> 	- Updated bindings document with the suggested modification in v3
> review
> 	- Changed the Device Tree property 'ranges' for child nodes
> 	- Used Channel Numbers as 'reg' value in DT to avoid confusion
> 	- Removed unused NULL arguments as suggested in v3 patch review
> 	- Addressed comments on Device Tree property naming
>=20
> Changes in v5:
> 	- Updated bindings document to the YAML format
> 	- Updated bindings document with the suggested modification in v4
> review
> 	- Renamed iio_pl_info struct to iio_ams_info in Xilinx AMS driver
> 	- Updated the Xilinx AMS driver to not use iio_priv_to_dev function
> 	- Updated Xilinx AMS node to reflect the changes in bindings
> document
> 	- Update MAINTAINERS file
>=20
> Changes in v6:
> 	- Removed all tabs from bindings document.
> 	- Removed the xlnx,ext-channels node from the device tree since
> 	  it is not neeeded.
> 	- Fixed unit addresses for ps-ams and pl-ams.
> 	- Removed the names property from bindings.
> 	- Fixed warnings from checkpatch.pl in the driver.
> 	- devm_add_action_or_reset() used for exit/error path.
> 	- devm_request_irq() for managed irq request instead of
> 	  request_irq()
>=20
> Changes in v7:
> 	- Added use of FIELD_PREP and FIELD_GET.
> 	- Added the spinlocks back the v1 which were removed in v2 for
> 	  no justifiable reason and replaced with the same mutex. This
> 	  caused deadlocks.
> 	- Removed the buffered mode information from channel config.
> 	- Usage of wrapper functions for devm_add_action_or_reset
> 	  callbacks to avoid typecasting functions.
> 	- Usage of devm_platform_iremap_resource().
> 	- Handled platform_get_irq() return values.
> 	- Removed the remove() callback.
> 	- Fixed the dt-bindings.
>=20
> Changes in v8:
> 	- Replaced *_of_() APIs with fwnode.
> 	- Added missing headers.
> 	- Fixed documentation.
> 	- Added devm_add_action_or_reset() for iounmap.
> 	- Restructured read_raw function.
> 	- Added helper functions.
> 	- Usage of GENMASK for all masks.
> 	- Added defaults for most switch cases. Some can't be added
> 	  since the default will never occur.
>=20
> Changes in v9:
> 	- Added a fwnode_iomap().
> 	- Fixed Kconfig indentation.
> 	- Added the overflow checks before memory allocation.
> 	- Usage of fwnode_iomap() instead of iomap().
> 	- Rename ams_parse_dt() to ams_parse_firmware().
>=20
> Changes in v10:
> 	- Fixed licence in zynqmp.dtsi.
> 	- Changed the macros to use BIT().
> 	- Realign some code to fit within 100 chars.
> 	- Modified readl_poll_timeout usage.
> 	- Usage of array_size() instead of check_mul_overflow().
> 	- Usage of dev_err_probe() instead of dev_err().
> 	- Usage of kcalloc instead of kzalloc()
>=20
> Changes in v11:
> 	- Added missing bitfield.h.
> 	- Fixed AMS_ALARM_THR_MIN macro.
> 	- Added terminators to enums where necessary.
> 	- Added explicit values as suggested to enums.
> 	- Removed redundant macros.
> 	- Added delay value for readl_poll_timeout.
> 	- Corrected shadowed error return.
> 	- Corrected formatting errors.
> 	- Added default cases where missing.
> 	- Made ams_parse_firmware() a single parameter functions.
> 	- Usage of devm_kcalloc() and devm_krealloc().
> 	- Directly returning from dev_err_probe().
> 	- Renamed masked_alarm to current_masked_alarm.
>=20
> Changes in v12:
> 	- GENMASK_ULL usage for 64bit values.
> 	- Added ams_iounmap_ps and amsiomap_pl instead of generic
> 	  function.
> 	- Hex values to use all capital letters.
> 	- Fixed a case of wrong kernel doc.
> 	- Modified macro voltage names to reflect the scale.
> 	- Maximize single line usage wherever possible.
> 	- Handling of fwnode_iomap when CONFIG_OF_ADDRESS is not
> 	  enabled.
> 	- ams_read_raw() - Reduce the size of switch statements by
> 	  using helper functions for IIO_CHAN_INFO_SCALE.
> 	- ams_read_raw() - Mutex unlocking in a single place using goto.
>=20
> Anand Ashok Dumbre (5):
>   device property: Add fwnode_iomap()
>   arm64: zynqmp: DT: Add Xilinx AMS node
>   iio: adc: Add Xilinx AMS driver
>   dt-bindings: iio: adc: Add Xilinx AMS binding documentation
>   MAINTAINERS: Add maintainer for xilinx-ams
>=20
>  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  227 +++
>  MAINTAINERS                                   |    7 +
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   24 +
>  drivers/base/property.c                       |   16 +
>  drivers/iio/adc/Kconfig                       |   15 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/xilinx-ams.c                  | 1450 +++++++++++++++++
>  include/linux/property.h                      |    2 +
>  8 files changed, 1742 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
>  create mode 100644 drivers/iio/adc/xilinx-ams.c
>=20
> --
> 2.17.1

