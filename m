Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAFA552CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbiFUI0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348264AbiFUIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:25:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E2226545;
        Tue, 21 Jun 2022 01:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn2asQwJx9O5kYCTwFsmeEP1N3LvxARWn5mHlajYgOEy4jb8GJz9L8MjHCrO0LtUh4pbe4DCfVG5fGiHTc/8SbhCL0L5jYwfoby/M1MsC7XDbIGBRhoGfRpkL5QLkrc87m216kh3Au2WZ/BWoN9BzkBUY31cYJ2+Gtc70TbHmCWIPRTnvXDRUC+u2ToBtT2gLkBvyNlo9jryGu/P23oIdVT0uRusjCW4AUZ4R5vx33whd79pE97fTRa5Hk+mZbW5CwyKN5CbmOz5qWg4qwbZf+nBovRDeoA/PLIMSFbGQSVJLfuzty00DJra0QHzdXo+ZgtxT/+Cghb1lxJH7ji77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89pAOjdeCFs8OP9j/Xm92IcuhgALATNGasIST0tOQxI=;
 b=jpk9I8KYSM3qDTKbHJadXRlwNhSEzA+t5UuR9yqTvCNvR/4bcuANXWDx46PM6w7OuecHOdYixMAe75GGLNXBLD5ZgtvGzGnbtt6WJ4GgiwZoQwEl0Oh8cplh1IxIRTv7/IgAD2H2I+pThkVVjdOVOcqaaKGZjx5XxjNcJJedgYdau9ddURiJpDL54X1WP4h/u30KJVBb+bNRPwDG7xmxEvsonwerVhm/HcTTCe89jaz/ZNj7AXU77v65MyrcolWGnuOYTQ2zuT8noyW40JjvinO/jhy1yIt3hgLx0f6FtNkv+pyjkzmMTso/SOvtJU4tZEGpOadgcoM+++9ByEWJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89pAOjdeCFs8OP9j/Xm92IcuhgALATNGasIST0tOQxI=;
 b=NgV9Q0ODwmwvZoIgpt4Tiz9By1jVjTKycuXqHV042yT4k9GH4WTL9/6vW+if0sYpYMmEjCddiDAq3aGSpebchH7ad4+3SJuTGIRhjqvvGdXaX7Yiy5XdU47qeURz4ZMblm5YProqT2KPh7wS8vFoklHW1orQ88PGFQb9Ly4Hq1g=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by DM5PR1201MB2522.namprd12.prod.outlook.com (2603:10b6:3:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 08:24:08 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::25a2:99e6:be6a:4f61]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::25a2:99e6:be6a:4f61%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 08:24:08 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Thread-Topic: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Thread-Index: AQHYSNyT5AQVGFEfc0CeWm5NB0lZxazhsf2AgFc3IxCAIRU1gA==
Date:   Tue, 21 Jun 2022 08:24:08 +0000
Message-ID: <BY5PR12MB4258E0190D27B3558CD4B33EDBB39@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <20220405191757.3rzc6q477reusywp@ti.com>
 <PH0PR02MB7189C07E60A93426764C688EBDDC9@PH0PR02MB7189.namprd02.prod.outlook.com>
In-Reply-To: <PH0PR02MB7189C07E60A93426764C688EBDDC9@PH0PR02MB7189.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 270a34c8-77ef-4cbb-6e44-08da535f6979
x-ms-traffictypediagnostic: DM5PR1201MB2522:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB25228CE7AC87D968D91E4D8CDBB39@DM5PR1201MB2522.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QnUTO4URHQf6+LsVjAwl6K9PxpcVUoRNjZzi3uStiStRcAq7CZoBDaDv6UxU9RTNAskDaVZZ+W6M4LtVbumT4kCOD6bk7R4CvWThNBeLtDbt76hyxnmcd1vhWVWLZVxDy5hJjZg7WSy4gbxfTL531C1aMSQL5H6cIkll+RN93crVfBZj5RY7U2oIXRjNhenhCkil64jQ2//OElngOH6RwRcBiU0p5Pm4APt0FhODdEkkeR7b3bFI8QXkzwID1yqBUPj9rTnhZQ/847V0RSn1fZhhCFaYv3quOkMRYhKjbMwA1QUZthmmXdklQNpW40X/Vryy3HfFvscHcbZlyccZ7alKpVNCH67fshOs3Ti7q2ABLikKcy/Sbj/tj7vkHVyn9E4Mv7buTDMF6pavBPYIsYtNA5Kry2r5d+2ipbTW91QDP7eeQztDxwlam6VSrJDe4H/H+XhYrNSqpygzBrwlNN7BnHateCjogTSIQyhipTefBfONw2BL2GrbOZWT++lf8e/WpyyLm2+xUf5WLY55PSyaBHtiUeYs1G9VliGLvF7tHU7RpKa63lQxXqxctkq2BirCdrMCTVr0XuRQK0n+xmzsmTP+KEt3C2ibPbBj0blCsE+jdMr4XAXTpEJpGmjgGDWTLAbCpZWJYd4Lg3lH63dEwQNXznpIvXxbsYFRICrlgPOuPeYWRtC2KEv5GwOzbktC7r5dWxRB0x8eTBCb8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(86362001)(9686003)(53546011)(26005)(7696005)(8936002)(54906003)(5660300002)(6916009)(478600001)(52536014)(6506007)(2906002)(71200400001)(316002)(38100700002)(66446008)(33656002)(66946007)(38070700005)(66556008)(122000001)(4326008)(66476007)(55016003)(83380400001)(64756008)(186003)(8676002)(41300700001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wb9MWmKIjVbtSaArnN790edOhI1YtLkV1jom/8Z5qlhfMItW5pvok8d81Xfm?=
 =?us-ascii?Q?2vFUc6bdXONuUp6rkszIVL9pEaHootnYLRE4JFaYwjN7OOCVF3K2E7/6BNG1?=
 =?us-ascii?Q?wBrqF6Nn8HV7/Rp/bv6KPtQhac/GOBvD4WaiIENQL2BQ9uZKMIYGquONYYo9?=
 =?us-ascii?Q?nI4gOZMZSChvb2QWUz6EC9y9Q9ED3M0i1bHE45FnRSYBp+91jMtFZ4JOVILZ?=
 =?us-ascii?Q?oCN1vvGq9YQH8I0AvW7HmKPElkfndFkadEAPCGmvXhJLMCKczMrBtX6gbOZJ?=
 =?us-ascii?Q?9t1Z1/Lc/9KWGZ/urVX5fwCCiTSZG/vwRBjvTMPw3feFHJb+owjG8kpsK8u5?=
 =?us-ascii?Q?KUMngUxJK6chn0CQxGGCIV+E5AIZnn4znSJWLnfcl4dsw2voIIlwTRy3uTyz?=
 =?us-ascii?Q?tV1Rna62YRFKFx+ziRG/1evcTfJuCFm8KPsMUAzLypLJfDJ52UfTXz+ipkF+?=
 =?us-ascii?Q?ao1Nr3croujMUZXcsZCU/RGDg6s1SyWx0FC3uVO18c1/JCB6JbqHmdcZN6l9?=
 =?us-ascii?Q?NAWf3ThAKCoUXUr43NsKEYWS92xiMfLd2R174QZvgVvZ+95adqxiRadSvBiV?=
 =?us-ascii?Q?SzSq/+wKaid4zK8oeAcRXLDrqBbORN+I0Zthec05yRHjuPygFaRv9J1/avEW?=
 =?us-ascii?Q?alpepsGovnn9d3KCJemp8fEO7L3ifa9NLnuWuLnjF2W5hSWeKtgrfao3Wl01?=
 =?us-ascii?Q?ZnyQjJjsRmco0fpBdDgtLkUZa6WbBn+NCaFiNvuaIhSbYDV7qQNvq6WL1EX2?=
 =?us-ascii?Q?1dQ4mDZMpNwbGD0zXqc6BPi1UnzLydw2GBEs7uLqRZ+G3Lpaw2OMipC7a5OP?=
 =?us-ascii?Q?i5JF8toAK6EkKIKgVIvnTLBVzHbjURD/6KAhPOsPcW655L2+LCIo9yYK4uQr?=
 =?us-ascii?Q?jygvELwlHtt7e/A/6oAgvmk79l68/Sn8iPCnwTz1bLdRNA6FIKB7VmlgUf8f?=
 =?us-ascii?Q?XUGP0h/FpDosIaXcDeKT0N2W21f8YoC8wtdqVk1193DbJ8UQFbdcB587WiZ6?=
 =?us-ascii?Q?zzDdK2B9hAuaGM02FWanro7fTbtGDXQGbd/bobtSKzVDbZx8KtuYuvDt5Irt?=
 =?us-ascii?Q?ck2Y+l22m6RuPtMfF7lnNa/GPjZGjZXyV5WCBplppeIL/mhTR9uhoRPAuJpK?=
 =?us-ascii?Q?rlOV3mVN6VwF5gK8axgTlVDT+gY5+zrRvZMW6uZFuNTkDZewbRqmp8TpvBeR?=
 =?us-ascii?Q?PKC/FQ97lgNVHYXUd+gSgUfZnVnDIRMSP2yxg2Wd7YkSpaoH3nhMs0ybbwAb?=
 =?us-ascii?Q?rPnfw48c2qKKyHnj7WFI3dTBIWABHxpnvJPda9KcmWkhxW+hW+TnhfEOhdGL?=
 =?us-ascii?Q?hYmxYe1rdB0vtZttxBgbsbrC3k0xFtwmnxdymapgRDIyWP4KBl2OVhmVqKr0?=
 =?us-ascii?Q?iNvS6GBe8ZplpBZyJmcFp7xGw8kG81OetSJhZYKN9p8zZ2oWkmvAJ01CArRS?=
 =?us-ascii?Q?LpuVmOvY8iDGipn6gsTOMYxJiARpwTvq2pC7TpvrI2gz1ke4cU7jVNyaffH6?=
 =?us-ascii?Q?6nIjITlp+5PN2MM5728wpKM2jvhj04mnGQGvehJPT1FqvlmArS4/en1C+Duq?=
 =?us-ascii?Q?LLUZVx8jmVn72VfWl1Atr84hYBuVdKvaEgjqZ0QXYQnsPoXaWHawaJwyQW8/?=
 =?us-ascii?Q?QUOb99T0iwwK5fJ1ELx1K8OcjmrN02051PMu2Tp6yHLCjYKMBsy5Ip455C82?=
 =?us-ascii?Q?sPujJ92gAopYkAHZQjXjFEuLWBrA3qKzqg96/3rS0wAatzy3mJSsis8kvMBF?=
 =?us-ascii?Q?gYeJ+Xi42g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270a34c8-77ef-4cbb-6e44-08da535f6979
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 08:24:08.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBaF7WNypWjEHQiT0HjOB61MRX84q4n2+RCLp5Aqvq0Eax81fJEHL0eno2fGzDQTw7mpjebUzMSfgEvsw7XsNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Sai Krishna Potthuri
> Sent: Tuesday, May 31, 2022 1:43 PM
> To: Pratyush Yadav <p.yadav@ti.com>
> Cc: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> spi@vger.kernel.org; saikrishna12468@gmail.com; Srinivas Goud
> <sgoud@xilinx.com>; Michal Simek <michals@xilinx.com>; Radhey Shyam
> Pandey <radheys@xilinx.com>
> Subject: RE: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI devic=
e
> reset
>=20
> Hi Pratyush,
>=20
> > -----Original Message-----
> > From: Pratyush Yadav <p.yadav@ti.com>
> > Sent: Wednesday, April 6, 2022 12:48 AM
> > To: Sai Krishna Potthuri <lakshmis@xilinx.com>
> > Cc: Mark Brown <broonie@kernel.org>; Rob Herring
> <robh+dt@kernel.org>;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > spi@vger.kernel.org; Michal Simek <michals@xilinx.com>; git
> > <git@xilinx.com>; saikrishna12468@gmail.com; Srinivas Goud
> > <sgoud@xilinx.com>
> > Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI
> > device reset
> >
> > On 05/04/22 04:30PM, Sai Krishna Potthuri wrote:
> > > Cadence OSPI controller always start in SDR mode and it doesn't know
> > > the current mode of the flash device (SDR or DDR). This creates
> > > issue during Cadence OSPI driver probe if OSPI flash device is in DDR
> mode.
> > > This patch add OSPI flash device reset using HW reset pin for Xilinx
> > > Versal platform, this will make sure both Controller and Flash
> > > device are in same mode (SDR).
> >
> > Is this supposed to reset the OSPI flash or the controller? If you are
> > resetting it in the flash then you should handle this from the flash
> > driver, not from here.
> I am handling OSPI flash reset here. Agree, controlling or issuing the fl=
ash
> reset should be from the flash driver and not from the controller driver =
but
> handling the reset might depends on the platform and should be in the
> controller driver.
> One platform might be handling the reset through GPIO and others might
> handle it differently via some system level control registers or even con=
troller
> registers.
> To support this platform specific implementation i am thinking to provide=
 a
> "hw_reset" hook in the spi_controller_mem_ops structure and this will be
> accessed or called from spi-nor if  "broken-flash-reset" property is not =
set.
> Whichever controller driver registers for hw_reset hook, they can have th=
eir
> own implementation to reset the flash device based on the platform.
> Do you think this approach works? Please suggest.
>=20
> Code snippet like below.
>=20
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h in=
dex
> 2ba044d0d5e5..b8240dfb246d 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -285,6 +285,7 @@ struct spi_controller_mem_ops {
>                            unsigned long initial_delay_us,
>                            unsigned long polling_rate_us,
>                            unsigned long timeout_ms);
> +       int (*hw_reset)(struct spi_mem *mem);
>=20
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c index
> e8de4f5017cd..9ac2c2c30443 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -598,6 +598,27 @@ static void devm_spi_mem_dirmap_release(struct
> device *dev, void *res)
>         spi_mem_dirmap_destroy(desc);
>  }
> +int spi_mem_hw_reset(struct spi_mem *mem) {
> +       struct spi_controller *ctlr =3D mem->spi->controller;
> +
> +       if (ctlr->mem_ops && ctlr->mem_ops->hw_reset)
> +               return ctlr->mem_ops->hw_reset(mem);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_hw_reset);
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c inde=
x
> b4f141ad9c9c..2c09c733bb8b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2966,6 +2962,7 @@ static void spi_nor_set_mtd_info(struct spi_nor
> *nor)  int spi_nor_scan(struct spi_nor *nor, const char *name,
>                  const struct spi_nor_hwcaps *hwcaps)  {
> +       struct device_node *np =3D spi_nor_get_flash_node(nor);
>         const struct flash_info *info;
>         struct device *dev =3D nor->dev;
>         struct mtd_info *mtd =3D &nor->mtd; @@ -2995,6 +2992,14 @@ int
> spi_nor_scan(struct spi_nor *nor, const char *name,
>         if (!nor->bouncebuf)
>                 return -ENOMEM;
>=20
> +       if (of_property_read_bool(np, "broken-flash-reset")) {
> +               nor->flags |=3D SNOR_F_BROKEN_RESET;
> +       } else {
> +               ret =3D spi_mem_hw_reset(nor->spimem);
> +               if (ret)
> +                       return ret;
> +       }
Any suggestions on this approach?

Regards
Sai Krishna
>=20
> Regards
> Sai Krishna
> >
> > Also, as of now at least, SPI NOR only works when the flash is in SDR m=
ode.
> > For TI platforms, we reset the flash in the bootloader (U-Boot),
> > before handing control off to the kernel. If you do want to properly
> > handle flashes that are handed to the kernel in DDR mode, I would
> > suggest you update SPI NOR instead to detect the flash mode and work
> > from there. This would also allow us to support flashes that boot in
> > DDR mode, so would still be in DDR mode even after a reset.
> >
> > > Xilinx Versal platform has a dedicated pin used for OSPI device reset=
.
> > > As part of the reset sequence, configure the pin to enable
> > > hysteresis and set the direction of the pin to output before toggling=
 the
> pin.
> > > Provided the required delay ranges while toggling the pin to meet
> > > the most of the OSPI flash devices reset pulse width, reset recovery
> > > and CS high to reset high timings.
> > >
> > > Signed-off-by: Sai Krishna Potthuri
> > > <lakshmi.sai.krishna.potthuri@xilinx.com>
> > [...]
> >
> > --
> > Regards,
> > Pratyush Yadav
> > Texas Instruments Inc.
