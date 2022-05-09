Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD1252082C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiEIXOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiEIXOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:14:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5804117706D;
        Mon,  9 May 2022 16:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTljb06stiv3WdMUKKOsCYCPtMfb1qnZbTDVYq78uhFpwId0EOXr1ss/fGNLpvjouqpwV6yrmPnN09mWsZkAPf6lPg4Z+LZk86erJZxPpB2YZhVfoIxh6z1xm6rcS809vrjJVP04S541LBKjaKxmomG0UlpsHOqj0bECAS2h7bpEQTUbkrAmFtaebCxwWPiSpOUC7PS8s+HdFOm89LsV/8cAlGQIvBjsX84QieCAXvUxM3Z0s51aSUpOmn+BhT2zVldQIZV45Fej3I0mWjZ9zLgq5vuZbQqhgmbvWrJ1WyebKujw2gsMqr+WEHXSM4PNMV1yCEgAQNB74cdSH6hBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQ4JDV4VBhcEuWTgzLU3qtKvfyP7sOkpVhNpAcKWpwY=;
 b=hj2bt00jPUxNAVNdZW/4g60NaByFxwSH26qAPa2jeYPxTmVKJv9PN66qbDEni1xKF1PTWbm5/rg3ifETzgbPFgQBrsUNVp0Q2blF4l88Mt7x6829deNCKHvvOdPOJIQ1jOG8Rw/3oe25r+JrEsBixeHupfPVMVOEXrimvZEHgukohJ9kXhA3hWczUmBTvfeJKwnugS88WOoRxtE5RcRsNJHefNVQgUThrYwbpnDDIFmOn4xtJT/nqEzMJ8EV0Lm9sR2RM1yVZVkQTmr9b06cVRs5hcPvCUFsDyb5RE851GhB8XfT/ttzK76DNa3SJvQW3ssHNNxJkidVnC5VJluGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQ4JDV4VBhcEuWTgzLU3qtKvfyP7sOkpVhNpAcKWpwY=;
 b=IVpIpQ8zKeMDkeVCYqIMxaI8/F+bZzi5Ld0FHetRB3AnajAfXI+JKWRhUYK2iBMNMeMoN3F++pwMnUFAjiLcc5EtthMdPJvSk/t084DF/i809Jm2r1hltCsC3tH1Rz2xO10MsG5edZRRj/8yJj2Ne54YbBQ6A0Z3hm/MsPRvUZg=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 23:10:40 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 23:10:40 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Subject: RE: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
 watchdog hardware
Thread-Topic: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
 watchdog hardware
Thread-Index: AQHYY8J2WR7+ZZgJMUuf+cuKSPrW3q0XKFoAgAADfLA=
Date:   Mon, 9 May 2022 23:10:39 +0000
Message-ID: <BL1PR12MB51578AC7D4CCBFBCD1DF19E4E2C69@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220509163304.86-1-mario.limonciello@amd.com>
 <b394bfcf-9f0d-b27c-5bc0-3d628de98755@roeck-us.net>
In-Reply-To: <b394bfcf-9f0d-b27c-5bc0-3d628de98755@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-09T23:08:25Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=16ed6444-d6f3-4e13-9e01-6cc458fc05b6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-09T23:10:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e0f62354-793c-44db-8a96-b8aa5d3ada1d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 953bab03-3efe-4c11-b74d-08da32112260
x-ms-traffictypediagnostic: BL0PR12MB4946:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4946E5CAC0CF61FF2405E8DDE2C69@BL0PR12MB4946.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A9IHvT0mjrtzWflfIjssVM7JudfewcP4o4ZpPZZjUrRcI8xhUALMaIMxvkecTqsraj4AKyfH75XdaDUx0if43Yf5RPDpPK2TR6GehyPV0fFk6Uep0M0tq6fIxfOpw6izaGYAdzspXoTqL21bVcFwSqT048EXdbh3uhOBUYK/mRjkLFT+r15CkVLBLfmflGzAPhkiaF2irXMdmp498ld1lpvT7Fh/TUhhEnQ0nEsgFR/MKRWjoZgvXvk6yiNclL1Hml02deIn3i4rzBcjQPnnxgFF9RDx/k8EC9tQfMML4SCCYLnE9apqFxu7IBdz8Fdx4uuR8znFc82FUHP1f9bHP5PD+g2O1c0/9kEuEfrT1L23+MDLqFFe6h9xtFG6lr5v+U8Qoxfnjm4S8tvJMF0m0nhyB3vjaBAXLch5rmH3dlb9zKVJeDgdCdPKAS1lucR0u/O5hPi2gO4v7r4FNdOb3Gyn3UX3Vpuh6Q0h6jiHospPjDU6qKq0lkUQLhaDVp59phPkWhYdQmHcNZjSLs2g1z3LIA1p5uVQUoIw7DpNzcaF7iYHXvyeXm9tla40KMy1r/fRRISLJRvRlALT2XszcsSn4EblOeWyGBvYaxY3Gnc6OX6zChj9vFAwsRN6yETakzMtIoRRFMQOg42kI8KsM7gU+/bJI5AFcUj4y09BnID4/5lL5avtA1K00ub0lJ8SI9EPij+JROM4eO0le6KsMO8yYNuTdp7Bw97EaYBq3ewfgejiz/VdZ9PAsGLNN+yqAvGZCGfSJvOpdww/738SmT4LDVc0puUSX26ddB7AY5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8936002)(86362001)(66476007)(52536014)(64756008)(316002)(110136005)(66446008)(4326008)(45080400002)(9686003)(122000001)(8676002)(6506007)(53546011)(26005)(7696005)(71200400001)(76116006)(66556008)(38100700002)(508600001)(2906002)(83380400001)(55016003)(5660300002)(186003)(33656002)(966005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mdtl6hUvJIXlv1QbA3Buac1oUW8C8QJdGt04Cdx/UYT8Dkeha23s5c48szjj?=
 =?us-ascii?Q?KXPnuBjkPG7PuJuGimtoXY16IS6768QJ7wY+yMgM0pbn95X6SaHVQ4dfr0Me?=
 =?us-ascii?Q?04GYGO2HvJLyxmcLJ9qgyAn1b664PMW9mRgvNcUA4Gy+3ax6Dyd3yyBNPqsF?=
 =?us-ascii?Q?kcYzztR3HCYZ66K5HWrURgaFPiZdZzMUKaiKUAIHCF2ym1+1uUTYWANl6ibX?=
 =?us-ascii?Q?HVcJfUdeMnlUhBnS7y68Sqb86ioZrGykknCGWuecswuXpSCr9PoCyXuti9ZC?=
 =?us-ascii?Q?aZwrx53IBImJ0/2NHDyUajqVjU6dRYIgwSBNHu42UiBIyt/9vfpyYPBfCCE4?=
 =?us-ascii?Q?HyAfkJvVGy9iAGvns01PAr7+p8ACecWn9mJRihAO1VrTfUpxhs/pvtW2cnf+?=
 =?us-ascii?Q?ew/zfq5MaTVFBeTiuO4FuMIfussdgnz0H8U6CHBAHiA26Mf4gp7iqj6fofJy?=
 =?us-ascii?Q?GdzWAKfKHgBsJU4wuC2lVx14r2oa2ycCxiXjIv9RXH7eETKuraIE9q85PTuj?=
 =?us-ascii?Q?CjwBIvtJ1bI2GrNkGrlfDzCHONJjqepXVDtiREzzHBYOw3HjQ0Xa0W4FI/H+?=
 =?us-ascii?Q?mQuNKqDxzFGafs1WorYGNWPZVAdymyw9LEqzcsusIOpc02DSh45tlDz9elmm?=
 =?us-ascii?Q?OFCVpVISZGQZj0Ywa2gcD8fbHo+Tf0Uxu34foffRCu7HuMAtu2xaupSehYlN?=
 =?us-ascii?Q?ZYTn96E/SunpNYaY0mFkdtY7DuOCWsMy5GRYhnTK4ZfGd6BcDTVY9zjabAdC?=
 =?us-ascii?Q?s8X2ZMYK85TzBrE0WZToFNpHl/Cl1zTJmicx5mbuCBwIVbSCU2A1G+ReLJ4e?=
 =?us-ascii?Q?zBdELnpqRlAkJUPk19QltOJQojm526LyKGTzEFmx222DrM7OJq3wmsl6mtCv?=
 =?us-ascii?Q?ElhvQFk1TNxygqpPiM7aRDcSZPKOK3DQXSzqRX+evWUAIQcQfGjNu38YAWhx?=
 =?us-ascii?Q?tflFw7otb26o2e3pRMe9qmWJHkFhXTBq4iHq/Zp64Pt2EiUQEjuM1FrBy1nf?=
 =?us-ascii?Q?oeg26cntjc0w6any5aHcZC8Pf8Anr6RijMPVTI6+Gz+cCygnfP8NWs9onr4B?=
 =?us-ascii?Q?km4B3a9BnWvVEQWf4mKMxLYufOy267nani5P19sfrmkKsFqUTlMMjKuyVfn5?=
 =?us-ascii?Q?Kui0ujhXT5H04J5iZkAyE0g80wcH0iJnOTohaIB08iThUBWjBccUkuKBVvL9?=
 =?us-ascii?Q?9UGzf8Bam7tTaDq0n/+oZUZKOx0CHwVWFMR01N4CVPBY3Ulf0oh7p6fVYDMS?=
 =?us-ascii?Q?TNQwrJNftV741KX18cuoIJ7h67FqVHACu9fDVttlm3iwZ9GPLx9ihNR2BoHB?=
 =?us-ascii?Q?jwKSWWioEroXC6Ms5CVQ08ymfat+0kWWisinHO1gbDHCYDRgqw5f9VHSz5Xj?=
 =?us-ascii?Q?9DuyoCmXaIsnyo2hevEYbi2dXvc4HAqzmUpLzprArQ1xrI713MVXQrgkA4xL?=
 =?us-ascii?Q?pCyC6ocddZbsamTsKGNuwBV06DRqOuB3ecEW1RtlySjn2gw39BIXnWmtXwr3?=
 =?us-ascii?Q?VVr5jMQwClGmpYazt8FYI60B/XpVyBcCv18T+ciBh/dGp9T3Fq/hBY6NuejC?=
 =?us-ascii?Q?UA+Qxnfy0NxEVNYRA+aQt/fD8iL/Iaqe5XcSnRYcyIzQ2sAYrbDFxiFqADeh?=
 =?us-ascii?Q?OzyXbHGYE9Hab5CzKWCkZbgMuPE3zNBkHgazNDon/G/9njm9fV1UVBo5t2Xz?=
 =?us-ascii?Q?+lKJ4DZRoWO7Fu9RllOJTQUCIOdBKhP2ceKP28djJUT96/YpaqYyiqHynN3r?=
 =?us-ascii?Q?guildc2aqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953bab03-3efe-4c11-b74d-08da32112260
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 23:10:39.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 650SS8DfQDm+1lCp5xKUCNzsT8bwJ3tDUBLLltFEGN3V2g8rAgJB7clMRjVFYg7l2u2jrgRed8RB27Zjx6XCnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Monday, May 9, 2022 17:56
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Wim Van Sebroeck
> <wim@linux-watchdog.org>; open list:WATCHDOG DEVICE DRIVERS <linux-
> watchdog@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Cc: ionut_n2001@yahoo.com
> Subject: Re: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
> watchdog hardware
>=20
> On 5/9/22 09:33, Mario Limonciello wrote:
> > If watchdog hardware has been disabled, currently the kernel driver
> > will show at err level during probe:
> >
> > "Watchdog hardware is disabled"
> >
> > This is unnecessarily verbose as there is already a -ENODEV returned.
> > Lower the level to debug.
>=20
> Is it ? Without this message, a user may try to load the driver,
> get an error message, and have no idea why the driver was not
> enabled even though the hardware exists. If anything , -ENODEV
> is less than perfect. Unfortunately there does not seem to be
> a better error code, or at least I don't see one.

If it didn't have modaliases and users only manually loaded it; I would agr=
ee
with you.  However it has MODULE_DEVICE_TABLE, so if that PCI device is aro=
und
then the driver will load either way.  That would translate into an "error =
message"
on every boot if you have this module compiled and didn't manually try to l=
oad it.

If debug is too quiet; how about info level instead?

>=20
> Guenter
>=20
> >
> > Reported-by: ionut_n2001@yahoo.com
> > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D215762&amp;data=3D05%7C01%7Cm
> ario.limonciello%40amd.com%7Ccb7bc29e837747aeca4a08da320f1569%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637877337609997805%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Di%2FrEQEXw
> n19%2Fi3oJ0aqomniBaQe9WKGGiDQ97YeCfss%3D&amp;reserved=3D0
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/watchdog/sp5100_tco.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/watchdog/sp5100_tco.c
> b/drivers/watchdog/sp5100_tco.c
> > index 86ffb58fbc85..e51ecbd5c8b7 100644
> > --- a/drivers/watchdog/sp5100_tco.c
> > +++ b/drivers/watchdog/sp5100_tco.c
> > @@ -286,7 +286,7 @@ static int sp5100_tco_timer_init(struct sp5100_tco
> *tco)
> >
> >   	val =3D readl(SP5100_WDT_CONTROL(tco->tcobase));
> >   	if (val & SP5100_WDT_DISABLED) {
> > -		dev_err(dev, "Watchdog hardware is disabled\n");
> > +		dev_dbg(dev, "Watchdog hardware is disabled\n");
> >   		return -ENODEV;
> >   	}
> >
