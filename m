Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98574D4897
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiCJOJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242674AbiCJOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:09:36 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9A483A0;
        Thu, 10 Mar 2022 06:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646921315; x=1678457315;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZlfLsYmHFoXvZJjxmzvnW/gnvrq665EAuqt/A6c1G+Q=;
  b=J+7qU4hRd954R9lofyYFjL+HD8451PuztlpnppzwL9yqNkGXe7Ouf39O
   t4cYVaARqet0u+U2WWnbN8KlD8HEhyGjfP3/pZGqyTW6XOybAEMGwwZzH
   feU9/jIPYYgAvskke91n1Gpmj0bxunfKAHjcrmupuvdBfI0oG822cN+jZ
   La5OyskEYKgIx+N3BBsjngq/zvz53HjbR0SAwrxtaCEyzpanLh8W589N3
   MBGS0WkSPmOOF9WtKkZU8Y/t0OHAgwL5PprdFDnN0axD7+1mfG0jaPs7L
   MbS/Uv52z+lanXOu/IF1vGVqJ7wLcWNmN6Y2pftn5wM3uGaOGFT8qHHc+
   A==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643644800"; 
   d="scan'208";a="194973029"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 22:08:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw8lD14Ehtqo6VNmZyfa9zbdY0q1fTHOVPspgexH68a/vrhya4sKcW5MIZTjo+4n2QHgjcQkkF3skzG/pSgtbytvj8JxdNASRsy3dpqzdbKRwL3bzZBUqovc84ukbrGXQcJL0r+3jY7Bh5mae0Zrprokilo2b2/F2SG0WlsKZQY0Up37ak82QuJ3exgYX7Vm6EvlSI5Ngn5N/ysMNWiJwrVc+nMEgpNjrcIk3NOiyZn7nwbK+efoib46gOotwkPnJ3qgYFvfvRfY1FrIlVmBTBaXabVjkoVo31UG+iPzZPz3W4QMlnuITkmC/9u+uVbFt6yzAS/dQ7O6kuqBuWHB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZiZVvfoLvE0Mj24DA0K3vA/uaIP5w/+eN1yUESfDVg=;
 b=Vj/xgBAu4LYDwcYV+xA1b++8Zj1RpFtkV0ShvhetR+yosPark145gMr0KcB/hzM1XyCEPy5BZpYOhJhj5BESYUAS6+Zr6wvHKtELI5WzDaXpScMxo+R0m7DsjkQ9oKKKxVAet3ZoYrknW340nWx8cB4sQs06I4+zsDt0xYisnVINKAbNL05BGmNVMXzppkEBnu7GRU7AJZAeImWy+lGWBJLaqmPOzw4A/AP4IMRscY2yZCz8OeFmwi6vR+L4aciDHeoLvH++dYwo30h40iPVpU3cJuSRpgj2/S4Fmf30NAekApjhKbi1aMQ755eoWF00O8xUPl5xgNg6Bnm9LIPlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZiZVvfoLvE0Mj24DA0K3vA/uaIP5w/+eN1yUESfDVg=;
 b=fA8TLQUTJWxE57sAajLJWFEVehYOHqQGk0w8L0SsoclkRFp2zNKdTz8cdvh221eIX58yTkxIgRo/zRJ+5VN78KVQVsF7XBYhq8XX1HZxmpcml9xPSMHGpaiy7xhx4td0JTZQxyDVeZeumiZDaiVIOAxZxWZLsK4XuA+SQ0cvggc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7762.namprd04.prod.outlook.com (2603:10b6:5:355::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.21; Thu, 10 Mar 2022 14:08:34 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 14:08:33 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marc Mattmueller <marc.mattmueller@netmodule.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: core: add reliable write setting to sysfs and
 update on read
Thread-Topic: [PATCH 2/2] mmc: core: add reliable write setting to sysfs and
 update on read
Thread-Index: AQHYM6Iq238/wKtYGUOfp7PikKmAbqy4qSIg
Date:   Thu, 10 Mar 2022 14:08:33 +0000
Message-ID: <DM6PR04MB65751B0413F8A2FDC72F05B9FC0B9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1646820083.git.marc.mattmueller@netmodule.com>
 <d68d8c8edda35a050a6e92b0ff1d57dd3e7c61d6.1646820083.git.marc.mattmueller@netmodule.com>
In-Reply-To: <d68d8c8edda35a050a6e92b0ff1d57dd3e7c61d6.1646820083.git.marc.mattmueller@netmodule.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ed6b34-f5dc-4278-4d01-08da029f76a0
x-ms-traffictypediagnostic: CO6PR04MB7762:EE_
x-microsoft-antispam-prvs: <CO6PR04MB7762B411A682AD82AEF19E47FC0B9@CO6PR04MB7762.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dL+8dKW7VVk8JYFO+P/Ah6JCEhN63NPniVeOC7Z7ws6A/p/1h/m5XsD/1DgP4k+zrIoRFOP22MOt3JoWZxQNM8CdhOFR1JSUC0Nmo3qnyegJK0aistn6nRiroHFV15e920dVGMF/9ygQoWjdl673DAsyRmAwQZd5qlCZc2RXWCsACtmBkaMziFzFksR/sxddo5AqrZodp5Bt2ifAhDuaUs4itor2AEi4sJOgQi9eXsI7nuLT33qJojgKldG4T3jB6ahyhD6dTqvoENuQiZ3vf+RfRdhSvUNCXujzMuGKsVg/N29VTMcD+U4Ep5ZovihOW/5GzAOnP7niOlzA4LU93ipMtR6/qPaewQ7dARWkz/GpatvMPkmPw6KU5gA9ZDPl5dAf0io/UNZRkbpnZeQkKc7J+3lD7SY1KfvAZmM1gGyFIrF3vP34VTjRWG4StPWfOqZcycR5meZjPPHtEVI8AfEsZxctH1gDaEL+aK+0ZiV5f14pGTYb4I3ITkbqPZQ2aI9f9PuV65P6Q6B9P4ewrjzl2+fm/ffhKpnp2k6mfwrIPn0uJD2P0F5nNjfQdh8nTWSyCzj0dMhqISBnsR5aM8bGqFgAJjKersOG8iL2OMPvcU4JxoJUkIlLGXb5CmF1PmQojfxw0FlFQs5UqLuaJ6wE+Le2raaiZNs2z5J/nFHLrlfWyh7YhbPLhbJs0lPUbBEtG2I6tH72tyGvVWTIfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(2906002)(6506007)(508600001)(66946007)(8676002)(66446008)(66476007)(66556008)(5660300002)(76116006)(122000001)(86362001)(55016003)(38100700002)(82960400001)(7696005)(33656002)(38070700005)(9686003)(64756008)(83380400001)(71200400001)(110136005)(15650500001)(8936002)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b9o9aUsayJ+RI9xiVkdvPdoU8Kfoe+g8B8f1Lxv3Jjat4q+2J3fwEY3yqa8c?=
 =?us-ascii?Q?XzUY/dlgvOmz1uAl0iwPQdX12EUCaR4vjdp31I2CDmf+n3DHQgUAlVslk+Ig?=
 =?us-ascii?Q?wyj0Fax8d/BDoQf0PwIBQVnjfmxXyRANfpJ6BUNh5hoybUQndKRbWkI4iSSX?=
 =?us-ascii?Q?uL5anyMKQKMp0Tl70gyYiety8ZuYgPqpY5vYJ7Zd9pPCUUTKlRTaWrb1OZsK?=
 =?us-ascii?Q?31S9lD8T7cm+da7Im/uhv/yoOWWZhRAOrvbTU13QmrN4dxuQZ4haVbOq4+cp?=
 =?us-ascii?Q?Yi+6vS2RE+QfTf6/tHZ+x+9mwH/tQNGJIt/n2vYG6E9UpV07NZgTqZ4pa2cV?=
 =?us-ascii?Q?PFZd10DJ2spnOb7gbe+yPdILqaOUYSqqaYl7K41qsIu3QEp3/swq50AErvuq?=
 =?us-ascii?Q?sRaHfAqILTEbmenfIycQat0jSDMuh0Nq9v10PmuX0MsLC72oLT9bSlt9PD1d?=
 =?us-ascii?Q?kEnbmjAK1eM8ZEWEzAQ8BygA1UDFMiTqJJdR/+u5WgIQienThx0qhccvK0Pg?=
 =?us-ascii?Q?+REYgUdRGcxDpAPGJXPuOZ9DkbNzaUkyC3/SO6bTki5rPxsUT6hBCR/3szXS?=
 =?us-ascii?Q?nIyskxG6+Mzus90KSYLB2ag50/VXIQizDJdLjl1YjHWFoCmI+97N2siOtC00?=
 =?us-ascii?Q?mfM5vIRxg/CQFaKVHBLOX3ow1R0Hgz3SMlDZWaVJTCssEdqE3J4s0JT6uV65?=
 =?us-ascii?Q?F8733BTxerSzIIJciDNlGOXN8XMKLn14aNBh3iEzG628vNwqUV4g4jJ+S5Qe?=
 =?us-ascii?Q?tveopBJMojCsUGdEfMMXpoPyv9uTG5QNESLrInaW9DNWryoqdLPozrJMaO1K?=
 =?us-ascii?Q?rwsGplMi/9npKFnbnmsqepYyCDqC9BuB+/seRicl0DB9mske+eG8P7BrmEjN?=
 =?us-ascii?Q?GTcjLWg/QLTc+dvNskxSeqYpI+y9OwamJHvTNVZz0W9fOSOLJEaP8Qm71LmD?=
 =?us-ascii?Q?G7X9DcXv7BW+Q+B3b6jGmsulJwuRuzBYgtT+F3kKALid9p8Dwsg5zV93SGGX?=
 =?us-ascii?Q?pnckgf3yCCdPRLo7ZnGNFycOSIiDPjb1nGgUMxHsTNOo1wNrmLOUNXNAADtJ?=
 =?us-ascii?Q?Bharlm1D6X0j49QS/39X2amFqUql9dAyFlsYHmlTEYdcKzpKN1TTZUxZBWHS?=
 =?us-ascii?Q?zMGbssy+ytv57ZqMfCVp+othBGoVgx3sewbbWYCsk+SzgJ9hHCqgxNhi0XIu?=
 =?us-ascii?Q?p8Jlj9WP5IERiSBlBKvYj2LHOcNn450UDB49rQsK1m83I6uS3EdgOOWw7fgC?=
 =?us-ascii?Q?cgtZ9cPnW47UajBhimGTWV7WTZH+EAnYovgHvezn980tLEJInMjLprxvkZsR?=
 =?us-ascii?Q?9xfoMUt0nnxVKDFxI7BAcBuXSoj+r/5B9plHDbMQfgqVbh+tPyv48sRqZ4He?=
 =?us-ascii?Q?tLU68tRUTxD1Z9MxPHWMw+/BjmCQLwPtm4zohYPP/X3EJ7N5Cx8NhphlkBEJ?=
 =?us-ascii?Q?XriunXa4lWo+tVjxf1VqSn4zvwjdb1Vf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed6b34-f5dc-4278-4d01-08da029f76a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 14:08:33.9306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2G3KQ2Go2hBAMcaEPekrBZsnja2CWEYJVDifb6DmmY1ZRXE2F6gKaiuHEDLVi88GYIrJejsV8ruiNMMtVp1wKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7762
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> The mmc reliable write setting (from ext_csd) was not available on the sy=
sfs.
> Thus, added rel_param and rel_write_set to sysfs and added the update of
> rel_write_set on sysfs read.
Here also - why adding ABI when its already available via mmc-utils?

Thanks,
Avri

>=20
> Signed-off-by: Marc Mattmueller <marc.mattmueller@netmodule.com>
> ---
>  drivers/mmc/core/mmc.c   | 29 +++++++++++++++++++++++++++++
>  include/linux/mmc/card.h |  1 +
>  include/linux/mmc/mmc.h  |  1 +
>  3 files changed, 31 insertions(+)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> d9537c894e33..a64d1ecb0de9 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -364,6 +364,10 @@ static int
> mmc_update_ext_csd_runtime_params(struct mmc_card *card, u8
> *ext_csd)  {
>         int err =3D 0;
>=20
> +       /* eMMC v4.41 or later */
> +       if (card->ext_csd.rev >=3D 5)
> +               card->ext_csd.rel_wr_set =3D ext_csd[EXT_CSD_WR_REL_SET];
> +
>         /* eMMC v5 or later */
>         if (card->ext_csd.rev >=3D 7) {
>                 card->ext_csd.pre_eol_info =3D ext_csd[EXT_CSD_PRE_EOL_IN=
FO];
> @@ -587,6 +591,7 @@ static int mmc_decode_ext_csd(struct mmc_card
> *card, u8 *ext_csd)
>                 }
>=20
>                 card->ext_csd.rel_param =3D ext_csd[EXT_CSD_WR_REL_PARAM]=
;
> +               card->ext_csd.rel_wr_set =3D ext_csd[EXT_CSD_WR_REL_SET];
>                 card->ext_csd.rst_n_function =3D
> ext_csd[EXT_CSD_RST_N_FUNCTION];
>=20
>                 /*
> @@ -820,6 +825,7 @@ MMC_DEV_ATTR(name, "%s\n", card-
> >cid.prod_name);  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
> MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);  MMC_DEV_ATTR(rev,
> "0x%x\n", card->ext_csd.rev);
> +MMC_DEV_ATTR(rel_param, "0x%02x\n", card->ext_csd.rel_param);
>  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
> MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
>                 card->ext_csd.enhanced_area_offset);
> @@ -886,6 +892,27 @@ static ssize_t pre_eol_info_show(struct device
> *dev,
>=20
>  static DEVICE_ATTR_RO(pre_eol_info);
>=20
> +static ssize_t rel_write_set_show(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 char *buf) {
> +       int err =3D 0;
> +       struct mmc_card *card =3D mmc_dev_to_card(dev);
> +
> +       /* before eMMC v4.41 */
> +       if (card->ext_csd.rev < 5)
> +               return sprintf(buf, "%s\n", "-");
> +
> +       /* eMMC v4.41 or later */
> +       err =3D mmc_update_csd(card);
> +       if (err)
> +               return (ssize_t)err;
> +
> +       return sprintf(buf, "0x%02x\n", card->ext_csd.rel_wr_set); }
> +
> +static DEVICE_ATTR_RO(rel_write_set);
> +
>  static ssize_t mmc_fwrev_show(struct device *dev,
>                               struct device_attribute *attr,
>                               char *buf) @@ -931,6 +958,8 @@ static struc=
t attribute
> *mmc_std_attrs[] =3D {
>         &dev_attr_oemid.attr,
>         &dev_attr_prv.attr,
>         &dev_attr_rev.attr,
> +       &dev_attr_rel_param.attr,
> +       &dev_attr_rel_write_set.attr,
>         &dev_attr_pre_eol_info.attr,
>         &dev_attr_life_time.attr,
>         &dev_attr_serial.attr,
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> 37f975875102..21c47893fcb4 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -48,6 +48,7 @@ struct mmc_ext_csd {
>         u8                      sec_feature_support;
>         u8                      rel_sectors;
>         u8                      rel_param;
> +       u8                      rel_wr_set;
>         bool                    enhanced_rpmb_supported;
>         u8                      part_config;
>         u8                      cache_ctrl;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index
> d9a65c6a8816..42afd442a70a 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -266,6 +266,7 @@ static inline bool mmc_ready_for_data(u32 status)
>  #define EXT_CSD_BKOPS_START            164     /* W */
>  #define EXT_CSD_SANITIZE_START         165     /* W */
>  #define EXT_CSD_WR_REL_PARAM           166     /* RO */
> +#define EXT_CSD_WR_REL_SET             167     /* R/W */
>  #define EXT_CSD_RPMB_MULT              168     /* RO */
>  #define EXT_CSD_FW_CONFIG              169     /* R/W */
>  #define EXT_CSD_BOOT_WP                        173     /* R/W */
> --
> 2.20.1

