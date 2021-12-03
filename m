Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6054C4674A0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351357AbhLCKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:21:13 -0500
Received: from mail-bn8nam08on2071.outbound.protection.outlook.com ([40.107.100.71]:28896
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243594AbhLCKVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:21:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdOBgYyCf1xRsDL+j8WWKKJgUHJsbnrQq9DxJsfxiZFF7MMyiRvdbbJ1XWdvL7xTU40EhDHCUsT+6iQIe550Knu3V3DmrmK6KSogvmmHMdlCRMuv0eZ9lCGMe6A9HGAq9hR/ndXXfjIomyjNCsV8VDp2OeluIigA2E+OfYeXNuttNvgIYsk3y1zapefqCJ7ZjSsIHsvuZkQc0nWyRi+iFEXON1XiSI1+May3XAcRQUKk3bBGBxyXHEJv5sONc4dYcZtp2rMbfs3488r6BKH7bvlV+wodeN5CWhxIyAGSl+Xo4Vlwox+/KZldKPuy1w8RESLGsOLyDCHNJntHQOypvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3jakdpWh9WRh87bgBIHJECqqXIkOR0mwBPDKb1GA1A=;
 b=Eb6G+FFUHBn53y1VKwL7T/PCkCizt3Ze+aeeKfTNnBklPVeaqnSMK+amC+9bFDGhqUhY/vu+cyiaTwQiGSSq8nQWokl6KDdJAtX/gM88pK5RRXAdoue7G6pzwOL3IEqV0hsaGbHxzYjU42GnfxfnwzQiDxZ0SjgSFxGojWM5EmJsYog3Oq4hUYVAV7lovb4hQRxCE2k87Pir7GGcxZ3365ae4MwaK1+nnOoCrAAZl9rSYXJWNGsAZy+hq5xLO4QLe2v0XC1TzKRdJOAwflie437cNlO1n09nAUaqzvEA8NfrSuf9RItSkYGO5cepSkh52g2Zn2WbKv3/vm3oSB/gEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3jakdpWh9WRh87bgBIHJECqqXIkOR0mwBPDKb1GA1A=;
 b=Q02AjoW7tt3b3OhtEeA9QnpGyFHMmuDo+OhRwKrhrq6bQIQBn43jg9qmjEmYr8m+wlMCwzS4OSnUuo5+bf/MyYKxbgQcVduQ6lIy8b3e4FPW5j10limgdjyprtam/k2g0FxaKC40FiwaVzTnhFE2bcFEciVdFP+pH2k04yx2Xxk=
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by BYAPR02MB4342.namprd02.prod.outlook.com (2603:10b6:a03:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 10:17:42 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::d4c3:f89e:a2e3:d3ce]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::d4c3:f89e:a2e3:d3ce%5]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 10:17:42 +0000
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
Subject: RE: [PATCH v3 2/3] firmware: zynqmp: Add sysfs entry for runtime
 features
Thread-Topic: [PATCH v3 2/3] firmware: zynqmp: Add sysfs entry for runtime
 features
Thread-Index: AQHX6Ca7gAQ8jBtJtU2F9h4sMwR3MqwgfxWAgAALW0A=
Date:   Fri, 3 Dec 2021 10:17:42 +0000
Message-ID: <BYAPR02MB44884D1746D719EB47A96BD2A46A9@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <20211203091814.15582-1-ronak.jain@xilinx.com>
 <20211203091814.15582-3-ronak.jain@xilinx.com> <YanigXDtuo7MpVg8@kroah.com>
In-Reply-To: <YanigXDtuo7MpVg8@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0eaf917-d414-4bfc-2c4e-08d9b6462443
x-ms-traffictypediagnostic: BYAPR02MB4342:
x-microsoft-antispam-prvs: <BYAPR02MB43427951FF8FB90C35307286A46A9@BYAPR02MB4342.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:348;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHo/22rDH1r2tdee5CREkyFE9E0x12E2duhqt8p+YGEy9s7NNfC/0rNA86EcdUBUk+Qj+BTW3PdXPMs86RIScMYEAbg5yXLxJIwljlSpAJi76XZR+no3KcS5tyS6dO+QAnmgjGcxtUjV/wHKZmFNrpE1eAeIMoC/b3JREkBy1f0r30N+eJTZnWcah8aYnVdh9o+Xtbnkyx2W3NRtxo1PvY3T/Doy51+ZiUhx9qw2wjQ8918PLravzcOu316D0u2jjnM5EGTg183PTYiZ8NuSRzqQs0QS2SUnp9AIKpxYY53o4XIHz7R1w4FIr76i9myNnx1o9bQXgzmuyrNOGK9VIpAwAX2ASSwD8zXNbViPA4W2mWfWm1DzpbzyFq4gzVU6Vj4jEPAFH/fITKepirP7OgDa4urGCBb0aGzUxsjMnRbHn1/ssfQIj+cut2H98rG2iv7vVVbCP170Z5YVZu5J0ejXr2H/Q/7gCPkXwigm9Apo4kvkkIQn0rIwwzmTSryQ1P3RkjrWdlEfJIFnA/7aNCV0qL/Ozt1eqbFXfmR7hifwerQ1UaOkVphycvkirlfaFaiHE9MqHslicZ6JeluwZD/omRW6V93eNgdw8Jhaged2MasaQixbUjRWEC7kCiZChLGsI0JdOCEhIB/TTwa9mHXtr+GdWc07nL/XfmrFEcpo/clWh92HSFvOcXEeinUy616iFf9wX7a+iANRVCqqkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(71200400001)(86362001)(53546011)(38100700002)(122000001)(6916009)(38070700005)(52536014)(2906002)(7696005)(64756008)(66556008)(66476007)(66446008)(5660300002)(76116006)(186003)(9686003)(55016003)(508600001)(316002)(54906003)(8676002)(33656002)(4326008)(83380400001)(66946007)(26005)(107886003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?28DPIp+dUzTh+oMEdwih5USGZ59lQHI/iV7LvyByOGY8wg1CNqD1jv6Xy1A/?=
 =?us-ascii?Q?MC0+bYXm7DdARjLITEsqYP+W0c6uSVGsU/Su3CaB0voLRo1JyNR8c+c1IuuX?=
 =?us-ascii?Q?lpeYYr27G7RFYZNrPKkL0YyKtynSemZOt+VkNo8biC/FQzmmIfXToh0H3oak?=
 =?us-ascii?Q?1hJWLQb38TEn4vZvsbdZqHfJoQG8Dgft4k39TgG7G2GizR/C/xprnN4zDbVt?=
 =?us-ascii?Q?LA0ePXwKlqPCj3OApDEZ1NG210CnxCEw/uNIQXxVfVv+KacAtzfEWSC6hl7j?=
 =?us-ascii?Q?lV6984IC2zUSFJjrYSa5wzmb+WtKNBrywUTtwhI1nIpZsagO2DE7vKEi8oi3?=
 =?us-ascii?Q?j2qLsqO/INOdcmBfWleNOhulJlx9oLPJWT/EGNmeXKlZJWhiiEDsiIZ3pwiU?=
 =?us-ascii?Q?vGjybXwCLTzfLfCf2jJNTtwuuMDOLjkm9IGYF/AGlDmLKZLI0rrDNAOJgl6o?=
 =?us-ascii?Q?6cLhmXcpNWmP8PaWR+Su8GT02N0KJi+OuXItpZKZvs6wIevWaTHAM7eoJZmx?=
 =?us-ascii?Q?afldzeRQQ0iI4bSa9qKptdQo2LG67FkvxVrvZJPN0stIkXEYX1xx9fsrjIfx?=
 =?us-ascii?Q?WOPD1KFvzBGeUC0fBY7/WQbNadXGBim02JbsLc+4qDxztB59m4UfVihh9b11?=
 =?us-ascii?Q?6QuLnTOEGKtPDSEbVCXW+wVnappZnFQV8UUwUPdW7LWW8iCO659wn8cpxdoM?=
 =?us-ascii?Q?cqyZZE+7ulbUHDiiI1411YBRttfrjgtgPZFRL4QqEEo3W8ILy0b3FVhM16ve?=
 =?us-ascii?Q?OLKi/VOAxFIrcCsTmr1uHjTj3fOjlr10FSnj6y3k/O1PF2wuUNrnDvtDfrEY?=
 =?us-ascii?Q?/Whfoxy2IDBh/qlGksAtv8T+GvI8wGz0QyIvGbvlUJk77tzEaXcxan3jxhrp?=
 =?us-ascii?Q?unTKwE3TU9PNx3IbUIdhe7c6s00CyqE29s6TjuWiR2bdPxAqVvBikd/Gl5cW?=
 =?us-ascii?Q?mHS0bwdbBBvALhegGRrD8We0AqNvXypN6zxrLh5hBI+9Jtb2R+pUTDkkWBdE?=
 =?us-ascii?Q?cv0uoobO0B3dOszAeESnI7pY102MSO7jQaCGQA0WqWTubw16l7XsSv05tbCX?=
 =?us-ascii?Q?5r0mgtFVmL0z1pwlEH+hHlnTT7SGVM6lHD8BpR1FHdYqlCJrLnIkxTkx68ay?=
 =?us-ascii?Q?BSA3W+MhxiW20FtRy1vhPkItf83xQGqYSZPsRuYDXeJ9nvfschvQ7SseWNSR?=
 =?us-ascii?Q?4/Qih1i63sMfU3xk7cxNpjj5Lkvz4S4e6KQZLCDVhdVg2pKzsEO9E30mqL+n?=
 =?us-ascii?Q?/l+EOQw/KH9H2A86m7fYnAy0YDJkoLyrNcu6SpMz0aiMb1wh5Zui2BR32KdL?=
 =?us-ascii?Q?yBKgIe2ON2kr0y+F7ssikgtlRlXZNs4/uhsfiyMdFG2zIYnc03EcgMOHTaWq?=
 =?us-ascii?Q?/VYU+NPFDpWVImPBj1ILoelMQIIC7SLPUkRvSw1vnmHsyddw7HrG+uyZ01C5?=
 =?us-ascii?Q?gJwuAl3Xr1Xdz/uUcOgOegzb3tsM/DU1wDlotrPS5y76MIIJkYgLK0njMJ+f?=
 =?us-ascii?Q?s+6p/GPDXZCXeK6LL3ryWkEWDc/T0GRLx0MzL9AlwY4uTnnh4xJCn3mm9A3b?=
 =?us-ascii?Q?QPA+aSnL+tJgN2FNLNxSgo2Ggx1pA/9LvpeOeLxACSCtrO6yH0OPcV33ilpC?=
 =?us-ascii?Q?WQBI8CCVFlMGHxDBKSLnE6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eaf917-d414-4bfc-2c4e-08d9b6462443
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 10:17:42.0674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHzAyZyEqoTBkPOhDfqPrxvqLMWKRCen6JnrtLNiLb6HLv2vDVjWXi1O3WOtBhCGVh4oZvASiAKgawDzjPT6Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for reviewing the patch.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, December 3, 2021 2:55 PM
> To: Ronak Jain <ronakj@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org; Raja=
n
> Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> <lakshmis@xilinx.com>
> Subject: Re: [PATCH v3 2/3] firmware: zynqmp: Add sysfs entry for runtime
> features
>=20
> On Fri, Dec 03, 2021 at 01:18:13AM -0800, Ronak Jain wrote:
> > Create sysfs entry for runtime feature configuration. The support  is
> > added for an over temperature and external watchdog feature.
> >
> > The below listed files are used for runtime features configuration:
> > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> >
> > In order to configure an over temperature or external watchdog
> > features, first the user need to select the valid config id and then
> > the user can configure the value for selected feature config id.
> >
> > Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
>=20
> Ah, here's the documentation.
>=20
> You should say so in the Subject line, and the changelog text is not corr=
ect, this
> is a documentation update.
I will fix the suggested changes.

>=20
>=20
> > ---
> > Changes in v3:
> > - None
> >
> > Changes in v2:
> > - Update commit message
> > ---
> >  .../ABI/stable/sysfs-driver-firmware-zynqmp   | 84 +++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> > b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> > index f5724bb5b462..2fde354715a5 100644
> > --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> > +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> > @@ -113,3 +113,87 @@ Description:
> >  		    # echo 0 >
> > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
> >
> >  Users:		Xilinx
> > +
> > +What:		/sys/devices/platform/firmware\:zynqmp-
> firmware/feature_config_*
> > +Date:		Aug 2021
> > +KernelVersion:	5.14
>=20
> 5.14?
Will fix it.
>=20
> Are these sysfs files already in the kernel tree?
No
>=20
> And can you break this up into one entry per sysfs file?
>=20
> One for the feature_config_id file and one for feature_config_value?
Yes, I will make a separate documentation for the sysfs files.

Thanks,
Ronak
>=20
> thanks,
>=20
> greg k-h
