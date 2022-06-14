Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B460154A729
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354821AbiFNC43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354829AbiFNC4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:56:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2DD3C480;
        Mon, 13 Jun 2022 19:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHmwkWBsSrOos2e4golH4gRWvxZOCyv5xhrrfL3tk+ZZArEmcWNgGJoFGt6DK3yCp512Mpzvl8n+8A9qWrMfIZkalaLhel7oBn6wItfBnJLMoak+0E8H94zl5BYqapSzHym0LlUb1CENa6LZzCNsr0gtMcEggiy8eIM74mQlRBd3hcu55TbwgvCanY4V7YoxbqZHRxl+c7p1qz7/6FVjDwWKY4s7+aKWYEWgd8h2vguz5WVcrHOgx3QmA3hm3ZDCJLa/xUn7QET1Nq5fE545Ekr0gzHPk7EI9DeSrV2+wqxAme+2hUn/LJ5YBGWImYgwJPmVmCZgVLngyTEZu1yWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc0WUx3PFo7iJr3k4RrFyRrYvvLDpEMJWbs2hNngPiM=;
 b=RIj7/ax1NyfV/ApCvwL3cIcO4GHrokoaI8yW6pg40vrD3DzL3ugzcYJBOtrb0L/GKXVIruev2nK7YwzwnjGNztLZ/g0PTmunA+emnCRCJm4UrE22UEefFqfvkJe0E7DPt7fTJGiDP2ancnFXoj1Cx7jB7xaW7ki/YJeBHYnoL0Hrcsy6c3N9QKlQp3LmnC2Xc+M8+KMtzRGeMM6tOC5AFoEPPVBT9CoRSRVFb6toxficMMK8pr9rccoqA/aqh5udBvZOwvXL8TID8Fouxzrqo3OFOsNsd78+daOaYeOa9GKfQL56PnurTFE0NdbnWpYfKP9T2c0BiwbUhSyvsoJSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc0WUx3PFo7iJr3k4RrFyRrYvvLDpEMJWbs2hNngPiM=;
 b=YDHhzp+OUCEc6JPpb1A9ck2/PNYaD4H+nWgtBJLfBFdENWoxV/Z/KOcfERq6HA9T4Z7HjBVPTD3CR0v96w6waM3AXFBSE/Tct99b0A+zh4dPfGR/D4Ix3XcUrZ/UM8eqokXEjplMGTI4huMy9UThy2Zo6VbzpkWrdoB3PLcV2hE5SQDliaCWemaYVPSGZ6asAkMs5oFe4adtWgzbJb6g0oHTDd7zLtYuqTQ9o/TSgmlfmRUSNYerLw7vNLA4iKMQoFRyRve2AN/c4tULDQqQOVGTuyOOLym6flDu6bnzOdnWYd3T1AyZLe75QQW8ZQoLe2pbRIpqqIieywcv/6Oc+A==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB2313.apcprd06.prod.outlook.com (2603:1096:4:12::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 02:41:42 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 02:41:42 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Joel Stanley <joel@jms.id.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the usb tree
Thread-Topic: linux-next: build failure after merge of the usb tree
Thread-Index: AQHYf5Ot1DkwIX5VjEOvDWkjD02LNq1OMLww
Date:   Tue, 14 Jun 2022 02:41:41 +0000
Message-ID: <HK0PR06MB32025AFD8869F26343CE22AB80AA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220614120833.06cec8e7@canb.auug.org.au>
In-Reply-To: <20220614120833.06cec8e7@canb.auug.org.au>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b920375-fea8-4384-55d8-08da4daf6a08
x-ms-traffictypediagnostic: SG2PR06MB2313:EE_
x-microsoft-antispam-prvs: <SG2PR06MB2313C1A1111138A248C1222280AA9@SG2PR06MB2313.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFHD+yhhWKPYya4YEEgP5ou+F7ObmGrnQ4t1xnjLEit2SrcaULXtXWRATi52jeRxjwjeEMag/NiRj8ip2FdIFcuDuDhjCPZM/zDldjsH7gOWB+TtbkOu+cWSNafqXhsD20NR3l6fRa08rMO8Vjgdt851LNI+tIhasJwjj22PcV1xMxVxFlzw39tmjjbTPrAvt3Zoc0WJCZYLeIVcYYd+lUa0dVrRV/apfpZqhsnE+h8rUjooJX+cbIKu8JJrFsylNdLAdNR9bhoyB9f2hXXg3DwhXit/zkgPrrD4LzSCbachI0H/8ClqtCviQg549PsB0/z3Ukrh190aH+1Afvm1Tv4j4ynG8IzVJF9kmV0sN0oAGLU+y+eZgPcdenFKK/g7Lv1ZpoAEj8HkqiNF1+znVvNjOsoGHtGIDfcuZdWGSjAbwzrDCZkBtq6/IMKVWYxCL9Sr3uOvOLWFrkZMzBPGpj+7zi5TSo2HSFmrhuJZyfla2p8Fxoj4lneR5KMP2vIWN8GQB8ukn4hh+yfFY81ja+VpLEri7N8bTwCY/r8NMZ4/K9gggQ0K/A76xRcgv7OXFYCTCnmML4SN5mk6fb4jJhdhTILeiEXZMGwii4tscGxBQQq3jxE2SRX23FZlp7BO4iYhL5znOKXAMiH9VTfHunNJPdADH2vEC1DfVwopdXg0Hljy70mAMty2eC08iEFGsffaYcLAYGu0NkO5HZ5rWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39850400004)(396003)(366004)(38070700005)(110136005)(316002)(55016003)(2906002)(54906003)(7696005)(6506007)(53546011)(38100700002)(41300700001)(86362001)(4326008)(76116006)(9686003)(8676002)(66476007)(66446008)(66946007)(66556008)(64756008)(186003)(52536014)(26005)(4744005)(8936002)(122000001)(83380400001)(508600001)(33656002)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jk0tpNpBVyXsRgJk4h2jlrA13X03Z71u26APXvtZ1iSZAdxSdSNHGL3hCjze?=
 =?us-ascii?Q?G3FAAw+3cgbHYgy2V40W+NSb+Aza+81r2iq2DEzCoz9juWOsVORiBP9j64Fd?=
 =?us-ascii?Q?myxs3TGTqhC8xDN2h+ocA3O36AHrYaVGzSEc+f1eGw2P9OssO9inLcdEkS+a?=
 =?us-ascii?Q?bG+Pu4zLETJV8FhWT4T58E9WQpc8Ux7GAhNRpVBqWcT1erGgitXNWzYElrTF?=
 =?us-ascii?Q?WzGRJOOmJnC2jvKEhrEPv6anqmRQdVhRY0rGQ3DFN4kHbfIa89bA7m/nQ3cy?=
 =?us-ascii?Q?OVCCU7rsnNGajnPh2VrOiL964CwqxyQjmk6M1H7Q1dDQcrbweI7WrfIsNr/I?=
 =?us-ascii?Q?T6olven3hZ4o52iz+qGEliKoXyFlTBGydoAeJ4nesyXEB6g4/T+aoto4j/oN?=
 =?us-ascii?Q?A5Fc1C0phrm/AmYTBOtSIh8p4VGeT2hOAQebJ6ZRDL9bmYONbijRfcunDWUV?=
 =?us-ascii?Q?W9dF637DoD2jWZ7jmFDa1zk33Z93PQtxBMJaBBNJkSVSi26WlQQNaQhD416d?=
 =?us-ascii?Q?UVBNH9CS3msgdkotu/2zsTqQ3fivCE5YTK8CXr8cWUKJQ/KzDMoMX44uQ4Zx?=
 =?us-ascii?Q?iKIIM1PAgJj8BLtsmBqo+H4GvXWfVKG9HrlgJNcH5dAULE9G8EDFVlTNzocG?=
 =?us-ascii?Q?NQyuNhD+3VTOq7Kwq4DD7tWmejsYZkbHguKdyrAiYhKXga6p9DKQ+mGnzqCB?=
 =?us-ascii?Q?CDUieDsEL3Enlqj0T27fXUjgcQlertkCDh1hXZ/Gdldpi+Om5U5d2dP0WvgV?=
 =?us-ascii?Q?Mm/z4ujd6/MItisIHccmIJ/t5h6hu9CbG7wPJxzBvMYW5FsjzyPzyALr16ep?=
 =?us-ascii?Q?wC1JfAVKKJj8HDS+iDTGFXJxMPror8z+mZNPvPyXscblphp5aHLq4vBLJVTZ?=
 =?us-ascii?Q?0cM7cA/i4DcmdQUdOeDgvTjP3011jtl9GX0In/CUmYUuGIre9YfY0ezPD7F8?=
 =?us-ascii?Q?c/763ol1Ml9a6PfesNshmGFXJBihfmdSN6tW83BLBEcfQfQP/zh9fQ2/4eUp?=
 =?us-ascii?Q?H6IFY3FvaWaGV4yLI9Ktz9mpdxQyISy28fUolr4Uj4oDcoRN7LmQT7Zb7Qa4?=
 =?us-ascii?Q?dbvRFn6rY8gQVcyeM+Sd3TRX77c/Jag8VtLIlqmMzKuK6Jrx/jLxkDidCBUu?=
 =?us-ascii?Q?vV4g1N0mon8zW2cLoMbWo6Iit3GEv6ih9I9fCpJHAJu0sVvLznD5ftJVCXgf?=
 =?us-ascii?Q?iIsAXYvv3AkeJR5uzTWOZTMf/jIcsMjH1dDZ2wlJ9iQvInAv/kYEEywI7bE6?=
 =?us-ascii?Q?0jINE/OKD2MlIXXpCe1ZTdyldpUookilKzqW0MH1LGl66QJfUH3iARziF4go?=
 =?us-ascii?Q?7725WTaw6lQDdlt783Y7utp08nleiaka+Cei+CoyG3kpLO201/oHevgqh0tu?=
 =?us-ascii?Q?SJlUy4UT8gttkOHlqtv2N/ZaAgMuTdsK8pbL8pJWV7KfNbyHR1Emwa48BI65?=
 =?us-ascii?Q?crFVrvo8/V3KpE7pvc51qs3DcL0C6GpnWwNwTBb6Q59myr9IkTVLCwYCK6rG?=
 =?us-ascii?Q?2GG19WHa08vbiOfYOU5S3T+RGygJziQXcFmp8ZCX6nA93/3fZEfcYEK2N9hQ?=
 =?us-ascii?Q?JxiCr6t4OkEDWUynBbV8Z3jecvRLftfD45yAaRoebHZzw6AfdYD82nEOPG9z?=
 =?us-ascii?Q?yr92T1CPr80EOWU7LISzHP0xqfSoIm/dezC26nFtN2M1OKMjMA+Upo93rpiE?=
 =?us-ascii?Q?93VwPFB9CweVmxWbvKHG+O9YT/4xNqHh5Maqmv72BO2Kjp0HQfAWQMBpsoEd?=
 =?us-ascii?Q?ImPlINiHVg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b920375-fea8-4384-55d8-08da4daf6a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 02:41:41.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUPtpCzbnFoM5ZT3d27QomYviOgBkSEnxzdSnyJ14z5LcLOGcVB+4iyxQfIRkrJ28J3ieG/G4oA+0dV36I8IEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Tuesday, June 14, 2022 10:09 AM
> To: Greg KH <greg@kroah.com>
> Cc: Neal Liu <neal_liu@aspeedtech.com>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Linux Next Mailing List
> <linux-next@vger.kernel.org>
> Subject: linux-next: build failure after merge of the usb tree
>=20
> Hi all,
>=20
> After merging the usb tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
>=20
> Caused by commit
>=20
>   2cee50bf4590 ("ARM: dts: aspeed: Add USB2.0 device controller node")
>=20
> I have used the usb tree from next-20220610 for today.
>=20
> --
> Cheers,
> Stephen Rothwell

Looks like the same patch is already merged by Joe, how's that coming from?

commit c9cb67c3a650 ("ARM: dts: aspeed: Add USB2.0 device controller node")

-Neal
