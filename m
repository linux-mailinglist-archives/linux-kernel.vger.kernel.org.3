Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6405B1437
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIHF5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHF5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:57:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F6A2A92;
        Wed,  7 Sep 2022 22:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662616633; x=1694152633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=851xsu1d6GGLtG1KKlj5dAPJcmcZ0Mm6fycIA1b1JA8=;
  b=ztsjn+64e36uQr63uXO6CpxMjv/j9mFMkWxZHbwYdLMrgjrKkIj+PJ3F
   wCtiTsv3PiOHgIcdB5orh2Du0YogvBfF8oVWSuFV0av49K1rH6FAQDFGW
   gQzFJREuN+IxgqotlgWyHwCWnjGp7eVdckZ592HvrUdG+7FkTNrm0F4c6
   rhXJCrpyt+N3l5Ivyv7MKnts+myHTB0D9CMp0AZFsXyv0hlmDjhERO6bL
   b1oE0KUXeXOZ3cnbA1KIsmVlP7uXscXTB6GSsjANS5EMKSeVWCOBwIkVH
   lNVAHV2EmQVIjP325agFALdsufZU4eQaJ75NFX24nEVwxIopTLrDdDP1+
   A==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="172894332"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 22:57:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 22:57:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 22:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CodG9oH30aixpsszwA4reAJ2WPhNuq9I5eMWOodA/NepW7asnfOrQQc8R6qQfEXxm0dxdxKKtyzdjIvJvB5RnRVWb+/2NAnyDyZx73BxFoiAcJKeE47P4RZaAGGN9KzQU90frOu+/tvIoAmZCK4Ekv/MPxIeY0vcdUFNDA5rtQvqdjSpmRU3tD7hvCMdMMMw+aJ3ZEnutggSj9JG6LnAG46WqCh+CHIgqhd4tU1Zh0NsZ/i4VUEqVAM3ZXjM6wI82PPsj+iT9lC2UI9Jb/GdtB7yTiUipCs9hpJL3LDfK7E0xUO1EKEIlANuxfDqnCmsSpBUQVA0gis66TecSSrk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaCr4Oj7n4rrAPNI+01fyU1NqYds0X/0tfi8XQIilX0=;
 b=DUGmGj0+MTAt7WJCyY3cJjjMSECghDgyVo2SXD55nBjSlOl3LzxAfMns1HQ4gpwTvlBJavV/TYMcl6ZfP7k0edF6QAZNZQFfXXbIwlri7HDF7hfT4z5iVp59BUBadUTzH+pRJKLfw0kVl9HTAWQ4ozgb6tsNcsnLlUhbaXX8B6RtNS46N/IZqEf4v27cgRdUTuEMUNrf/1DkmxvNQ8/asU4E3OluCpJ+4q3XYJG/TUdJgtiowo6USzLkT5nGcK0gBacTBqMghQUjBmWLhmONa6o/DWg4AWXwElgelnpdvNDqwjmhrukebJ6aLkoS/lQR/sP9Zz55wuW65rhNj78SIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaCr4Oj7n4rrAPNI+01fyU1NqYds0X/0tfi8XQIilX0=;
 b=HlNAq7nU6hsmCbt7bOM5aI9zitMV4Dq2/85mx/OTGDs/3rVMCDLiDfo0G2BAYWjd4HB4lUH5VDcTT8gz0InGqXjOqoUtts5kONe9ck6ytdJdcDuMN893gNJWZBMFOE3+AMXYQvdVbIeColMx0HcjnZDlRZfMYKBi7qpVdxTTJDo=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BY5PR11MB4119.namprd11.prod.outlook.com (2603:10b6:a03:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 8 Sep
 2022 05:56:59 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 05:56:58 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <weiyongjun@huaweicloud.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <weiyongjun1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next v2 1/5] misc: microchip: pci1xxxx: fix error
 handling in gp_aux_bus_probe()
Thread-Topic: [PATCH -next v2 1/5] misc: microchip: pci1xxxx: fix error
 handling in gp_aux_bus_probe()
Thread-Index: AQHYwsfi2OCdGO+Jl0GHAVIhlnqa6q3VBr6Q
Date:   Thu, 8 Sep 2022 05:56:58 +0000
Message-ID: <BN8PR11MB3668709A318C10F19261FB6CE9409@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220907145808.1789249-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20220907145808.1789249-1-weiyongjun@huaweicloud.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|BY5PR11MB4119:EE_
x-ms-office365-filtering-correlation-id: 71bb0210-506a-4b43-b7ee-08da915ef15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ARpKgAzi8fiiKPkrdYww3OlwvIYOEb49LFvdfm/S7ol4gUJeAp2pKXU5cnrgCeefWNC48gfJeNmM9zKswPeAiIfLD/I51SxlWpQBQNQLlyKX6snGKSlTmT3yhiNkLd/MVJt9jdkoHCDXmuRgcoKBSk71n7bCnbp8dI5leyp2/DWg17hgm/3+YE4Ub9IR8fSWCmL68Q67oen0hKar7TDb69nYpzDS9vGMSjXV8AE8Rr8eI6Qn/mwvXoUl0fM/cCqgT347u0mD3wUl8omzQgiYJY2dXJP9XiTz3aypMiFeB5XUhUzwocHWEuxg2CQN4bXiIc0C6FhavVBHz2FzNGMNFQaTaYQeQMGaNhZCLsLedcgRSgr+VnkZ18R8LmGTH2H+7lE1RE+zaRKG5RrY1AcL8WMvN+UwMiBN0WsxbPwP29G/eHSJ5+8Gs0d1Elh+WvXOQ8sVWB5Px1IEGPrPjfzXzeLKK5Pw/SaiYnmNRTb7L0nT0iplSiTmtdFyXcm0hZ0dKrHL11t8aK+7r+zMhnzszEFN3R408hT7uMIPhgVouskHe9MFWxjA2zN90JJs8P4vdH7h8czfrKQ5o0eMwKX74DHUwPCOjPGP7Wpmi9Zeuz75BCOyG7GQ2juzuIpytjNm2ITFimWD5YaRZ/aoPU2ir79cxYcyrqKMQjbXaDCr6gRcFAFfEX7KAe6AxZERYPL3aZIanreMGlMDeJy0Be9OkwsWTjB0uWdgOavbaSYpYjICmTOsg8H11ySzKnCDIAv59OkWhqEQJs2LNbpA7SxPYYBu5li6xJRc4NDcP9g6IV4Z4y+I6m2sVVeJIySzwpLxBgyunuiqe/SDEcYfG3yPICgRmi04ocnJH69GiqRsO2Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(366004)(376002)(478600001)(41300700001)(71200400001)(38100700002)(54906003)(316002)(110136005)(186003)(122000001)(83380400001)(38070700005)(6506007)(9686003)(53546011)(26005)(7696005)(2906002)(33656002)(55016003)(64756008)(8936002)(5660300002)(52536014)(66556008)(8676002)(86362001)(4326008)(66946007)(66446008)(76116006)(66476007)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HQnJEI1zaFscss1A+kjWjgAg38MHW72YChsoNaton8SgFSFucAG/Syen7sYJ?=
 =?us-ascii?Q?8ozfdSz8KBqGERKfWycYAqn2BW94pGKnd//sJsY2TZ0NARF2VGzp/2VKc1kc?=
 =?us-ascii?Q?G1EooRymvouWn5U5+cgJbOVS4QTZjup8RNSgWI+pX7h00KLpK9uYcwE0bDMg?=
 =?us-ascii?Q?lYxZaf775W0Wq0rWbBSymxY5pqpRWEwue6kdl2ESkpBLz6WLBgcJIJUWUAzE?=
 =?us-ascii?Q?UkJLsizV5jctCcEWWOWqXqsDCQmAcDhRRuZSPmXXXplomepyDJbTW6oOIbAv?=
 =?us-ascii?Q?59sZEFPa1Y38l1pCpfw0eGsCvG06twfeQDxJ8Rjm6793P3L1R2ogjBEFxvrB?=
 =?us-ascii?Q?vmjPiE866fK/r+1m8dowHAnHM7Zb7KKKnjAAos6/L+pyg+Tk8vGS70DHLrFh?=
 =?us-ascii?Q?Pq44HNlrDVkxpgqbB+X0sZ2mXfLkK5ehKxxAxlGPBKpN/1oNsPMye9xxUU29?=
 =?us-ascii?Q?bVYahNF+iNFW+al1R/mrkYMyM5c1HNZmwY5HYP+M++O8qf0ljcT3k/NruaZq?=
 =?us-ascii?Q?A33EJL+ARZ0XGsNPfVryhL0GAYn71hhIEDgWplgMCkWN77UFwoQMi4inabo+?=
 =?us-ascii?Q?6flGtwhOoCSK7TG2HSfbkY6Tyq4dlExdz8gK3Cg8hpM8KAWKQQhWXgjuflQT?=
 =?us-ascii?Q?kdjBj3lT40HU3ODvgOd0wFtY7NmLjfbJme/zfEh7+R59YGUn+2VpHrwF56OK?=
 =?us-ascii?Q?SUhwXLjWqlp0bK5pEfCx7BfayM19XAZ2y5esHTN6bST6EShpWvvVH7UZGG77?=
 =?us-ascii?Q?57tVzE+3POovTyknaxt8wzZrAmLJAc1wltiUuAMVvomzDItNOvUod+JqRqWb?=
 =?us-ascii?Q?qUp1DRQaayAWa5OQliWrC8/wLuokZSCNm+bnItOrZ0YDFBVOBJMraanicfGG?=
 =?us-ascii?Q?iyUS+cXGd+wN5prKkT05YOxULsix/Xqvi/cLtHufoO/by6axHgd5SzkWCjzj?=
 =?us-ascii?Q?kseG3ZG4ygmqjiIpQkWeHi/jU2lbbhryuL8dMEG518I+poEjadPelB2aSDnv?=
 =?us-ascii?Q?RPUWTVDumbyhZp5roeweTKcGsatW1EU2w61XJPj/Bhs+jUVzmbJKRKvU+ZON?=
 =?us-ascii?Q?YIVHk9tX+7YhF8stHWKSXF8ig+M48EHHnZabnuoASg/mX958En0UVYncR3Ru?=
 =?us-ascii?Q?e/82DZMQ3VYasbnuCdYikEJHMxt/G4RpmczmBpa+FNnTMTiK/Qr0AqIzboJA?=
 =?us-ascii?Q?0FBONgBPTPhDtLDIJfHue6TAeHSqPnt+hWYvNyN7OVxSMYA1B5Rqs0jibZzY?=
 =?us-ascii?Q?Ic/8Kk/sxXh0OP5SY1GAeKDUxUH+SwWMrqveMUP3sgpvx+5Ga7BLL4H4DdA+?=
 =?us-ascii?Q?t1Trpk8L5Vkrh0P+3vFIMNjJh1yC6MCqyRNQl805RNjU/gByQ2uq0rqzyAoU?=
 =?us-ascii?Q?dLDWYf+7iYbuMy2Utl1cAUpT6UUIjq0rcFnDQIs4fChCPm1KHCFK26jtbHjR?=
 =?us-ascii?Q?eoOJhNN+tYpUW/N1JwpE9SnuQUWznAvbF8sFeWgLMOyT01bA2IcSrNzDiPr0?=
 =?us-ascii?Q?WebUqJ5k8A8WIOejb+L3zZIVibuJ09xO/gsv/cUOUn5ZWivHXdaD0MwHkIdi?=
 =?us-ascii?Q?6BoLo+6jyl5TvJvwnb0CwC0mTvNTm0z+5myTgIAMVGgttc29dPHPBLWshLsY?=
 =?us-ascii?Q?9Wt59ciVpCKwd+1Tw5vTD80=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bb0210-506a-4b43-b7ee-08da915ef15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 05:56:58.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKk8PJK8BcWOMkIFswR5E0RCIkn8FYV1/l9Qdbg916xggYhj9HW3akgoUZLawSLvYSVLwxgFIBM1P6dKd73+O9IeurprZEvzc+Qw3gLI8aFHMPVVgzlmwd9vPcLMGQJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4119
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Wei Yongjun <weiyongjun@huaweicloud.com>
> Sent: Wednesday, September 7, 2022 8:28 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-gpio@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH -next v2 1/5] misc: microchip: pci1xxxx: fix error handli=
ng in
> gp_aux_bus_probe()
>=20
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> In some error handling path, resoures alloced may not released.
> This patch fix them.
Greg, I have identified some more improvements necessary for the gp_aux_bus=
_probe function.
I am working on it.
But this patch can still be applied.

>=20
> Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus drive=
r for the PIO function in the multi-function endpoint of pci1xxxx device.")

Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 - > v2: add fixes tag, fix pci_alloc_irq_vectors handing
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> index bfc03028b34d..11f79f239006 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> @@ -87,12 +87,13 @@ static int gp_aux_bus_probe(struct pci_dev *pdev,
> const struct pci_device_id *id
>         retval =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>=20
>         if (retval < 0)
> -               return retval;
> +               goto err_aux_dev_init_1;
>=20
> -       pdev->irq =3D pci_irq_vector(pdev, 0);
> -       if (pdev->irq < 0)
> -               return retval;
> +       retval =3D pci_irq_vector(pdev, 0);
> +       if (retval < 0)
> +               goto err_aux_dev_init_1;
>=20
> +       pdev->irq =3D retval;
>         aux_bus->aux_device_wrapper[1]->gp_aux_data.irq_num =3D pdev->irq=
;
>=20
>         retval =3D auxiliary_device_init(&aux_bus->aux_device_wrapper[1]-
> >aux_dev);
> --
> 2.34.1

