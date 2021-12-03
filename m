Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8CE46749C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379817AbhLCKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:19:58 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:17636
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379807AbhLCKTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:19:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6OPYwD59+wYh5fn5yrWax6xHmObGtePW4gBEnoZG7faR51HmBd3o+KqJXkMOTwOidetpyN1ExHfQBsHWfUshaFivzQKoSlTcKopf07w0ppFJttIp6XcsuSSvscQqacQD4OSQN0nVfpRDSDtczZtG7XNSe7ZvdFgOcPjvDX9bWhxPo9J07iHWiWhEQzRrDXylU92Buj0zaiRWeW2Ctaq3lNB4L+lkV60kGTUfpnZW8LD2QdL6Z1qGHjjQjWt5CGPGlJuDamZj4G9Ei6vXImb49VRuEL1xdbiiIETtdFF22zKZS584d+SpUNLfTH5mOUjB9NyvY2ttutIma88zUgtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0ydCOtrYzK10kBLg39HObR+el9VUnnLlL3rsbecS58=;
 b=DPn59I/T67HWVnfgBp+C/RQGRiv5nntF7GUUeyGc3TPQdxoq7RH005bW8agg0W38jEcKYA9QVSkyGpocSm8cFwzQobw4laZgmQ7Val72spDFHccUkB//N1P/SSSfSyNn4bROMFcFqWuqbouHyE6x48IRjUWvl9NvJ5Vuk5UWd6AhkNB3+/ueQ4npguguYnVk+rhwjQ9xpTrrS/q6MOyMIqZ4mEIDLw0byiAi4zDLTpTbfZ/mgTv5SUHiAQCgWcQHqZmO6BXEYZr2Ck6NSLpo93+UiHVd3SukV7lkC75CDdy0RyzVClwxnTITQ12lAccvmgZIIt6TsMtw+Fd4PZ1ZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0ydCOtrYzK10kBLg39HObR+el9VUnnLlL3rsbecS58=;
 b=WyIzzHkNfn45aHZYiiBb4FkGeWAPrUmeOJl5c1u45IQ0mxhhJMGxjWu/Ahu8KLXSLmZIb/xbGfzy2F15yTnWGvvwhoCDl81wHaBleouWPWk5aFWuK+X1YqGa4uJcpwK6Y6PZgnFrVjK8QByJasxUBNMIYsUR+yO4mC4ws8InI7w=
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by BYAPR02MB4342.namprd02.prod.outlook.com (2603:10b6:a03:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 10:16:20 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::d4c3:f89e:a2e3:d3ce]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::d4c3:f89e:a2e3:d3ce%5]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 10:16:20 +0000
From:   Ronak Jain <ronakj@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>
Subject: RE: [PATCH v3 3/3] firmware: xilinx: Add sysfs support for feature
 config
Thread-Topic: [PATCH v3 3/3] firmware: xilinx: Add sysfs support for feature
 config
Thread-Index: AQHX6CbCgm7HmaKal0Ccqi11+zvs8qwgfjQAgAALphA=
Date:   Fri, 3 Dec 2021 10:16:20 +0000
Message-ID: <BYAPR02MB4488244E8BC4BC937AF68A61A46A9@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <20211203091814.15582-1-ronak.jain@xilinx.com>
 <20211203091814.15582-4-ronak.jain@xilinx.com> <YanhxIoxkPb+rYN5@kroah.com>
In-Reply-To: <YanhxIoxkPb+rYN5@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eab7f43-31f6-4797-9194-08d9b645f36b
x-ms-traffictypediagnostic: BYAPR02MB4342:
x-microsoft-antispam-prvs: <BYAPR02MB4342595097B01DEE6C639EF6A46A9@BYAPR02MB4342.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XifTURQKDfXztp7j67gRpONzhiuaH/XzzcKrNuy23BDcnm21HBzzy0p8eQ0bIFv99lkwapCdz9gPRUe16MJEvtVINr2Q2WmO3yKlbVWxgF6OWHHkFlD+UVeKFPpmfbXfcoHt30HZ7leiWcpLzu/H8HxIUTZHW/EDms6JShEiHAfCiuw1GI1SvgPAE/7aCW4kwX+j5hiic63maezUc3lMNq+bGSQRyQ2xaTIo6oJYIRa4LiyX9+JXHjmnaG6rXuiBcJ9jjabNDZQMwQKlAhMIDlssnY+FhnDBj5voHJjQuYQYBtly/gryLnIL4hevZFs3tudU/O3hFjQPXBKoHPoBbqmzNVLdICgJ92pFjzFGHlr+Ch/+IQwItXx8o0iDUoN4Z+NkiTp7WpMj+dsIeGE2AE8bbO0bs6bB/a4JDPHdhyyWq2P5+22+Wmama0A7dcvpYvVg5GHQuwGj6CVK7hb+KDI7jP1yy2EkYfnoO38g6QrdCT3x9/sXyufzAq0xIh6ynJYJd0PMB0izu2eWca2lx8bEBUjhzyS2ydTnW3nsXtxkpDwDmB2wrxWt2u9L3CMLZVD98pnv5l50mBXhI6MESYo89egBSU2DZonKWikR5Yf8gNXsGojXGh+A6lpssLgglGPV00omJ8kHmwpHr7Do1/S+NLJht+KacEuaRBjmdmq6f39C2S25DQKP3OmcR3x//c2IYsr/ceC5sWRNi99X6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(71200400001)(86362001)(53546011)(38100700002)(122000001)(6916009)(38070700005)(52536014)(2906002)(7696005)(64756008)(66556008)(66476007)(66446008)(5660300002)(76116006)(186003)(9686003)(55016003)(508600001)(316002)(54906003)(8676002)(33656002)(4326008)(83380400001)(66946007)(26005)(107886003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w6x1T5L56tamAvw7zdQ1heFFoSh+lo9+0BPlnn/miewRHBDFvKVbw5AtQCr6?=
 =?us-ascii?Q?3IUHW5htIQVl774n3UkUdEsP9r38m27o8G4ZYDyspLsm5Wm9Q74jkjWxm13Q?=
 =?us-ascii?Q?MAX8faJP+2/spGy+H9AFBsxsWtJWREUu/oUZLuYNylY5UYLu/sqWVQ0NYgRa?=
 =?us-ascii?Q?ezMDkvJlf62yr2rii0xbpOK/4ypGYBt4BfB4/zJ98GTMltUld8S9DXS/toHg?=
 =?us-ascii?Q?hBHFmQdLNbvZyDDrFmwYTdYYjmfJANd7tQ89OxYeSpJa64d7ouGR50M179Wd?=
 =?us-ascii?Q?y+wbkUJKHi7YgIXZy28xpmvg9QXJNar9b93OdzC58Ax8KR9e/NXa9C+jyRAj?=
 =?us-ascii?Q?r5ugU89vQS2ttM9jxnflQomoudEJcbBs3mnEnK1xQf/CVszVz7K70uJObDPE?=
 =?us-ascii?Q?m7N9Sqy11mh0VvFDPXIG6soT0NmtdQkeHgUqaYO2Qo0X6OPDzn00FSDeMeKG?=
 =?us-ascii?Q?cPpEPqYArWwg6mepZmAkFJ/eQNChaNeSNz91cDBTan8VhVvv6nmExk6j+idl?=
 =?us-ascii?Q?4Cd4m1B2nlcU7b7KtLH/WMjmn0PO52HA2J4Bj45ZCNsjHqoU91c2NrDDMD0o?=
 =?us-ascii?Q?kVA0QcsF958OsPcZaiXSYm6JzoHNmziGa3D8JFCofYHFVR8dR4KBSoYDxJAq?=
 =?us-ascii?Q?0qDYnUxjFWacjR7GXtje5+wsZTqYkBpMNBpoGKXJz0gPlotvq4fz8h8hy00r?=
 =?us-ascii?Q?HK8BUWFEstXdeFx1ZvHrQ44jw+45B+hkk0wzW3RWwtrjN49Z8f+d9uu3iXCH?=
 =?us-ascii?Q?bvPRsBFaZRtuTKcEVYxILrrKOjRhgEIziGlqjiABr7hBaMurdI2Fjb0PI74e?=
 =?us-ascii?Q?zIDD7BVgaXVGuhlI/8TNy/fq+U0pa3Fx9phJfaFF5aIe251scHWP+Gkl0FNF?=
 =?us-ascii?Q?gclrq7y9vvXp7iUSHIBMjLGoaRJQkj69VGCfw6IaOMVmc7VWeNUYMX3zte6Z?=
 =?us-ascii?Q?ExmeFonTDc5JtlgEzwkP4zZxONq5Z1n9tnsj98Ox6HPh24Yhn3K/2LkysLTF?=
 =?us-ascii?Q?zSJ1V96n0q/xV6GbrSgoEdvLneWO8AHlsC1VImM6VQ1JDelyO0mNUkNoneiM?=
 =?us-ascii?Q?K06mIeiSGdilSUyZmDNZo8lAJxOJR0kPtacxEPbXLgOuTM8adqW4ytkSgwCj?=
 =?us-ascii?Q?YyxPWHZb2gk4D4LbNP+JtcDe1MDsVwFXhOk4mv3m5oO0cH9dSjuFR8ErS4uA?=
 =?us-ascii?Q?JFdCMFUaY3h/cSZzDBROGaWVsnB8cvRoWnocKTYX0gDP8fjFWeG+1KlCdwm+?=
 =?us-ascii?Q?4zw5x+E0UPSw2vDqUD0xD/m1wEc1V4Uq3RUg/xdpzeuAoAzPG2ZNsrFTWMEs?=
 =?us-ascii?Q?niE26kGHEuaol1KRq/6bdZgnY0Tv6jWZmhofFpCSMAkHO4dzEjfyRji9yMEw?=
 =?us-ascii?Q?NM6/2m9UEn44GyWbBD4ItXYtDjnul5ZPr6QzgE55NjgzVC3IAWleaUQbbe2/?=
 =?us-ascii?Q?+hFMUME+GZsaoeAiT2PNGql18nQRqrhPxlJHx9gykLxsmPK/pNeMyrdTWc9Z?=
 =?us-ascii?Q?0+CORXI/f3YoTgEEI2MVZyDtG8czqcZr1MLV3fupJcnYiXnTBOaIsPkmN0xL?=
 =?us-ascii?Q?0FPvW0uPo/sY6/ybea1Dw7/rHDk+moBz4fVTSww94RBrZ5wDiejqLAoO9WMl?=
 =?us-ascii?Q?UuR4NQBxlEa5eRP8D0qgfOA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eab7f43-31f6-4797-9194-08d9b645f36b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 10:16:20.0908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezYpm6L8wfSQ0+Qj7ZVCLAK2k7mzOV6LcOphwpJ+GVmW0eWu4BV4us/TLs9RfE5ZwAXRFjpPgRfpDETVn0bw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH,

Thanks for reviewing the patch.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, December 3, 2021 2:52 PM
> To: Ronak Jain <ronakj@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org; Raja=
n
> Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> <lakshmis@xilinx.com>
> Subject: Re: [PATCH v3 3/3] firmware: xilinx: Add sysfs support for featu=
re
> config
>=20
> On Fri, Dec 03, 2021 at 01:18:14AM -0800, Ronak Jain wrote:
> > Add support for sysfs interface for runtime features configuration.
> >  The user can configure the features at runtime. First the user need
> > to select the config id of the supported features and then the user
> > can configure the parameters of the feature based on the config id.
> >  So far the support is added for the over temperature and external
> > watchdog features.
> >
> > Added zynqmp_devinfo structure to handle muliple driver instances
> > when accessed by multiple devices.
> >
> > Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> > ---
> > Changes in v3:
> > - Added zynqmp_devinfo structure to store device instances
> > - Modified feature_conf_id from atomic variable to u32
> > - Update commit message
> > - Resolved merge conflicts
> >
> > Changes in v2:
> > - Update commit message
> > ---
> >  drivers/firmware/xilinx/zynqmp.c | 93
> > ++++++++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > b/drivers/firmware/xilinx/zynqmp.c
> > index 6b05844e67d7..f37a8e805cd7 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -38,6 +38,16 @@
> >  static bool feature_check_enabled;
> >  static DEFINE_HASHTABLE(pm_api_features_map,
> > PM_API_FEATURE_CHECK_MAX_ORDER);
> >
> > +/**
> > + * struct zynqmp_devinfo - Structure for Zynqmp device instance
> > + * @dev:		Device Pointer
> > + * @feature_conf_id:	Feature conf id
> > + */
> > +struct zynqmp_devinfo {
> > +	struct device *dev;
> > +	u32 feature_conf_id;
> > +};
> > +
> >  /**
> >   * struct pm_api_feature_data - PM API Feature data
> >   * @pm_api_id:		PM API Id, used as key to index into hashmap
> > @@ -1424,6 +1434,78 @@ static DEVICE_ATTR_RW(pggs1);  static
> > DEVICE_ATTR_RW(pggs2);  static DEVICE_ATTR_RW(pggs3);
> >
> > +static ssize_t feature_config_id_show(struct device *device,
> > +				      struct device_attribute *attr,
> > +				      char *buf)
> > +{
> > +	struct zynqmp_devinfo *devinfo =3D dev_get_drvdata(device);
> > +
> > +	return sysfs_emit(buf, "%d\n", devinfo->feature_conf_id); }
>=20
> You are adding new sysfs files without any Documentation/ABI/ entries :(
>=20
> Please fix.
As you pointed out the documentation is already there. However, it needs to=
 be updated. I will update it.
=20
Thanks,
Ronak
>=20
> thanks,
>=20
> greg k-h
