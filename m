Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66A4D9773
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbiCOJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbiCOJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:19:02 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EBECD6;
        Tue, 15 Mar 2022 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647335869; x=1647940669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UNVbTUtb5VFLD0YST9Cahi0mzt8hPQQWzwU3WVULCL8=;
  b=xUGAqx70jvTSAppM0l3a9YD8nlJ6GouoAx0C5Ngwf+zTbwKoJsN5bnDB
   7lkKPQUTSJWUETkaGbq4S3+tIKtbjqwbW7JE2OmL+nTu04CpqAa0/smS9
   Nwlz7OuvX2hsQXsqgBa9ojbohxSgpNQHBQ9m6uI46mc2Tj8FgSvb65HWV
   M=;
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afmvwXfqokTypf7LDUSVHwE3wyKJtLLWRG1plOEWQhP34SRXuq9omOEHWEUxVhJME/EFqF/UK3JVqF7JssI1Csklxkz2LeIuCWA7/s+5b8xfC0QoSEs6Tl3tXQuXQdRV7QfZS3+eK3KhUczYyV5uEOFUpEFL6ZisqvpZZ/drguzyx1xrtMlwtPAIvBQn+wZTkqOSz7D5vIHP2cYFqvOHmcNuCELj2Iz60NAhn38NX3zEbpIwsTBIcvL0OTPGOe7DwDkZ9ZmHnUtoayYdpoCHwY6eSyXoNymwGySxBeZ4VU+HNSQh+Y/fEpQNgVrJyyK+QTCZVy1n7zRLHUc2icyYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNVbTUtb5VFLD0YST9Cahi0mzt8hPQQWzwU3WVULCL8=;
 b=d/DKi0xSky02opqIaxv9QxzAYDPHajYqCwpurxmN3kLgDWmaJkTxYzwDZwSfLZbm3INKyFDm336D3cP4zqpTOVZN8sD8CKMzFnkCCVmkGbrDXYRfngyUtYy5GbZk1DbkqHgc6y+6zRhoN2jmiJ/NsuIQd/zef3YsyNZBzWzje6x572ODgwjydolWI3u2bbU02kF3WSLfn4NYMJQZm40Ijha5vok4192LPlANfYf/J7j3xS/GJ2x4kG3/aVagc3Yxlf/ZRrBvLvk5MpAn1Q7VW6rC3njA7j7kplF4Ml4CcaO+UC8tbx6k6J9EIi4boL2cU1oflynkjop0SLNZJePWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by MN2PR02MB5966.namprd02.prod.outlook.com (2603:10b6:208:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 09:17:43 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%7]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 09:17:43 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "chris@printf.net" <chris@printf.net>,
        "gdjakov@mm-sol.com" <gdjakov@mm-sol.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>
Subject: RE: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Thread-Topic: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Thread-Index: AQHYNJVIWeyx/fyaRESKmIwhuGDfK6y5R0AAgAbqnAA=
Date:   Tue, 15 Mar 2022 09:17:42 +0000
Message-ID: <SJ0PR02MB844961406A5030D86AAFC71ACD109@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646926823-5362-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <YiqMZouVVEtVNrlV@ripper>
In-Reply-To: <YiqMZouVVEtVNrlV@ripper>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b15b89a-92cc-4a73-6cb6-08da0664a925
x-ms-traffictypediagnostic: MN2PR02MB5966:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR02MB5966FACF94556DD86094BDD4B1109@MN2PR02MB5966.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INAonC8Vwn/+bFiVKAsRorMpvpH/UFHxxvcWZBK2mTsHALsv8SIdnLe1KzW3xCFfKcy8u3usTmeFFK41KBT3sMuRFiSwpWWn9qSV5yWPSlzcq3q/GWn1nizIia2ruo1zCBlPXtGmmaeha28eVXOSCbfAkg/5M2K8rIkgGKcFW2lV3FSm8atz72QrhyhI+aLKn9lmwnlODTNfz0C0nbauMrVpiImScoTCtO12k5uVqyyYYfWYHdSWDlJuwILphn9dRpW8WKPe+RxKL+Mj/P0SdCe0xTzAFuVtcqkzK0zMK8xUBHsyfSpiXFEviqnAw/lLZOSCNoEEEs4Gs7kh+QuS9LggsnzX5PywGDD4bIvOQL8Zz+vx4Lr2VVsrF+ArPwx3hwBZBTQBtslwXaj7P4k5tywequemyRTtqKIHXOhn58jDByMOpNxfTnp2gT78ibZr+AW92QxY//xiV+laDFlZyjyQSgBJYdn1wFn/wLeT7gxlEonMdsZc8ttDjpzhecc+CpbXnRIF1K8E3OK7AZPzfJVzDLsSYLcuyL0MC1JqIA8q/BuPN9ao1RsGP3iggZLow/8dyl6Ziz2zooOb8gftrr8ecLFFLn1sD/gQ6SmRDCgQbsFv9pcds8mv4Z4XpRUQHJv27xGu1B+zpgg197HO0t5cx+3MlcfR/M9JcM0vS3btMiGhRsQnP6Y0EK9CrtRRSb17RCvslJp0PKG+XBMdvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(86362001)(66946007)(66476007)(76116006)(66446008)(66556008)(64756008)(4326008)(122000001)(316002)(8676002)(54906003)(38100700002)(110136005)(55016003)(38070700005)(52536014)(26005)(2906002)(53546011)(107886003)(7696005)(6506007)(186003)(8936002)(9686003)(33656002)(7416002)(83380400001)(508600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bdo7fC9IpQjBPPXdvTw1sP3glYlFvTbaUZ3oB8BItEbu0KPZDJU9AU4fySEv?=
 =?us-ascii?Q?FJ+jRXRHCY5pM/JJiLAhgfFQNOvlTvmNB+cR2nqQrBN3HehnedRwK7gRcwph?=
 =?us-ascii?Q?L5sJzukplq611RDku11qMQK/7zLTb35QItJf9pWetK2QvX8YI+TLGtIbZVpl?=
 =?us-ascii?Q?CeeQnO2u/weQSHylcbvd79uq7Cj6HplsYLZzpmrIV9TBNMasf2RekAzEogNT?=
 =?us-ascii?Q?tH7PHdio8n3vkeNyr32B/VWIpNaC1/rIQ5sdMFJYG6bcxb9mc82o/HP4NyQz?=
 =?us-ascii?Q?+6sg7Io5l8AqGH8fIuJXgCwHoFwuqayBZNfz0CjGPPXDVpcTMrhuC4BWtf8K?=
 =?us-ascii?Q?L73H2bhkDyl9glbJkuU4E7nbL6rY3WB5dPWAp2tiJ/8zbP5mSrFP3ilXbqo8?=
 =?us-ascii?Q?5uPQvA1QPuFulByzHwPx9FFWFRjETtl//LMiE6CsK27+2ovHfuDpXYmU6tos?=
 =?us-ascii?Q?C03ISJr4uQ8DgqP9g9nCdjEs9DvVnI9tbrHkj8y8ynx5PMGxF4fuOpei1RHm?=
 =?us-ascii?Q?wYoBstrHH4pXGeVIWFxPFFwnFU+gpoREGgEqlNMbLjP6ZZOQCfmWVCYvtAdI?=
 =?us-ascii?Q?IKkoJYdFN+tHAAQpLXkonuno0KAzLV/jwbEDaG/j8je1vTKTeQMynPHR7FTt?=
 =?us-ascii?Q?Hc7pNaJa4e3b2insxOx/gUVQTnUtrZJQ6iLm1/sOOwydwARrpMbjWvhbodt5?=
 =?us-ascii?Q?PMoVhdg38nVEgQy+yZl/ntIq9Kej9TrhASKQt1whWHOD85zqXTTCAnJlhIcg?=
 =?us-ascii?Q?UzifEIt9wVAi+FMXsf99klfPIHwEovmXAsWxxyTbPLzNFp2MmcR+toUpmXgn?=
 =?us-ascii?Q?U8lOv7i2l3UnkAmohsgCii0QXadGMWEVojHDmzms2WZO9DXvaKbIz/ymBJ7V?=
 =?us-ascii?Q?eav6qWg+chWCtDdlZuPax3GnDHbdZJXhZvy37QuM0tpOdiLe3iDMzqvVNF6O?=
 =?us-ascii?Q?Z9dOzqudq/45018e9zmGuxZxANrtgUDtlu6DmcICucagnyNK69fsdZUquJeJ?=
 =?us-ascii?Q?42IIoTd85X807IDiip3oSD3b+r8JRMYXQJs/bUazWlXyQNfMCawYl0kRw7+E?=
 =?us-ascii?Q?2UuqKYNjdorNRr9bK1wBgjqx47qPZ/zrR+lEoQTwO3JIOHVgzjGjjxcs1Wlc?=
 =?us-ascii?Q?DWi8dz5KUWazlbEqGxTbtqFCpjWA8E7TfniWoNkb/4M2cff+ZR9VWLnn3OqK?=
 =?us-ascii?Q?uYxwLgzqTUJhJpUjXEvaYJpHKXvbyksJAtUUqSASXYOY/B63lrjpTDCZbZEe?=
 =?us-ascii?Q?UKnBINoGirhOpbPg9Gl4j2Qr/dupOur3chmmdP5fN1rwGvgetMJzaywhPHlM?=
 =?us-ascii?Q?2oRhDpCH3oGc5BwysVRln2p9xafu+zcSHRj2sM4wDcl0ZEq8IxFa/z1APTEQ?=
 =?us-ascii?Q?OmM/LLNeopl2QEEdj6IKo0/p6zeasAntem2hUN+AmCgqAxVTYABhUxpsqz79?=
 =?us-ascii?Q?7VHTG2y1GovMmOtCffl0TM+47y6lH42F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b15b89a-92cc-4a73-6cb6-08da0664a925
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 09:17:42.9395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7X7zSSZh6+isv/YEF8BHhJtOXtKiaAQs2wC3StQJAu2aLgniIkDD2RSXby038qjfjSwMQLxFj0zCFqAkTDy3KVLpVskBliU7ZIPAIV3zHTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5966
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review.

Please find the inline comments.

Thanks,
Sajida
> -----Original Message-----
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> Sent: Friday, March 11, 2022 5:10 AM
> To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
> Cc: adrian.hunter@intel.com; agross@kernel.org; ulf.hansson@linaro.org;
> p.zabel@pengutronix.de; chris@printf.net; gdjakov@mm-sol.com; linux-
> mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Asutosh Das (QUIC) <quic_asutoshd@quicinc.com>;
> Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep
> Pragallapati (QUIC) <quic_pragalla@quicinc.com>; Sarthak Garg (QUIC)
> <quic_sartgarg@quicinc.com>; Nitin Rawat (QUIC)
> <quic_nitirawa@quicinc.com>; Sayali Lokhande (QUIC)
> <quic_sayalil@quicinc.com>
> Subject: Re: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for
> SDHC
>=20
> On Thu 10 Mar 07:40 PST 2022, Shaik Sajida Bhanu wrote:
>=20
> > Reset GCC_SDCC_BCR register before every fresh initilazation. This
> > will reset whole SDHC-msm controller, clears the previous power
> > control states and avoids, software reset timeout issues as below.
> >
>=20
> Nice, we've gotten reports about this from time to time.
>=20
> > [ 5.458061][ T262] mmc1: Reset 0x1 never completed.
> > [ 5.462454][ T262] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SD=
HCI REGISTER DUMP
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [ 5.469065][ T262] mmc1: sdhci: Sys a=
ddr: 0x00000000 |
> > Version:
> > 0x00007202
> > [ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt:
> > 0x00000000
> > [ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode:
> > 0x00000000
> > [ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl:
> > 0x00000000
> > [ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap:
> > 0x00000000 [ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 |
> > Clock: 0x00000003 [ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 |
> Int stat:
> > 0x00000000
> > [ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab:
> > 0x00000000
> > [ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int:
> > 0x00000000
> > [ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
> > [ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
> > [ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]:
> > 0x00000000
> > [ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]:
> > 0x00000000
> > [ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000 [ 5.559651][
> > T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER
> > DUMP-----------
> > [ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
> > 0x6000642c |
> > DLL cfg2: 0x0020a000
> > [ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
> > 0x00010800 | DDR cfg: 0x80040873
> > [ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 =
:
> > 0xf88218a8 Vndr func3: 0x02626040
>=20
> Please ignore the line length "limit" and leave these unwrapped.
>=20
Sure
> >
> > Fixes: 0eb0d9f4de34 ("mmc: sdhci-msm: Initial support for Qualcomm
> > chipsets")
>=20
> This as well, and please drop the empty line between Fixes: and Signed-of=
f-
> by:.
>=20
Sure
> >
> > Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> > ---
> >
> > Changes since V1:
> > 	- Added fixes tag as suggested by Ulf Hansson.
> > 	- Replaced devm_reset_control_get() with
> > 	  devm_reset_control_get_optional_exclusive() as suggested by
> > 	  Ulf Hansson.
> > ---
> >  drivers/mmc/host/sdhci-msm.c | 48
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-msm.c
> > b/drivers/mmc/host/sdhci-msm.c index 50c71e0..cb33c9a 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/regulator/consumer.h>  #include
> > <linux/interconnect.h>  #include <linux/pinctrl/consumer.h>
> > +#include <linux/reset.h>
> >
> >  #include "sdhci-pltfm.h"
> >  #include "cqhci.h"
> > @@ -284,6 +285,7 @@ struct sdhci_msm_host {
> >  	bool uses_tassadar_dll;
> >  	u32 dll_config;
> >  	u32 ddr_config;
> > +	struct reset_control *core_reset;
>=20
> As you only reset the controller once, during probe, this can be a local
> variable in sdhci_msm_gcc_reset().
Hi,

In future if any requirement to reset gcc , for example if we want to reset=
 gcc as a part of hardware reset then we can use this core_reset right.

Thanks,
Sajida
>=20
> >  	bool vqmmc_enabled;
> >  };
> >
> > @@ -2482,6 +2484,45 @@ static inline void
> sdhci_msm_get_of_property(struct platform_device *pdev,
> >  	of_property_read_u32(node, "qcom,dll-config",
> > &msm_host->dll_config);  }
> >
> > +static int sdhci_msm_gcc_reset(struct platform_device *pdev,
>=20
> You don't need pdev here, take a struct deivce * in and pass &pdev->dev.
Ok
>=20
> > +	       struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_host);
> > +	int ret =3D 0;
> > +
> > +	msm_host->core_reset =3D
> > +devm_reset_control_get_optional_exclusive(&pdev->dev,
> "core_reset");
>=20
> No need to hold onto that, so use the non-devm variant and free the reset=
 at
> the end of the function.
Sorry didn't get this.=20
Can you please point me any reference for this.
>=20
> > +	if (IS_ERR(msm_host->core_reset)) {
> > +		ret =3D PTR_ERR(msm_host->core_reset);
> > +		dev_err(&pdev->dev, "core_reset unavailable (%d)\n", ret);
> > +		msm_host->core_reset =3D NULL;
>=20
> return dev_err_probe(&pdev->dev, PTR_ERR(msm_host->core_reset),
> "unable to acquire core_reset\n");
>=20
> > +	}
> > +	if (msm_host->core_reset) {
>=20
> If you flip this around as:
>=20
> 	if (!msm_host->core_reset)
> 		return 0;
>=20
> You don't need to zero-initialize ret, use goto and indent this block.
Sure
>=20
> > +		ret =3D reset_control_assert(msm_host->core_reset);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "core_reset assert failed
> (%d)\n",
> > +						ret);
> > +			goto out;
>=20
> return dev_err_probe();
>=20
Sure
> > +		}
> > +		/*
> > +		 * The hardware requirement for delay between
> assert/deassert
> > +		 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
> > +		 * ~125us (4/32768). To be on the safe side add 200us delay.
> > +		 */
> > +		usleep_range(200, 210);
> > +
> > +		ret =3D reset_control_deassert(msm_host->core_reset);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "core_reset deassert failed
> (%d)\n",
> > +						ret);
> > +			goto out;
>=20
> return dev_err_probe()
Sure
>=20
> > +		}
> > +		usleep_range(200, 210);
>=20
> The comment above says that we need to hold reset for 125us, is this dela=
y
> in here in error or should the comment above mention that this needs to b=
e
> done after deasserting the reset as well?
Yes we need delay after deasserting the reset as well.
>=20
> > +	}
> > +
> > +out:
> > +	return ret;
>=20
> With above, you can return 0 here.
>=20
> > +}
> >
> >  static int sdhci_msm_probe(struct platform_device *pdev)  { @@
> > -2529,6 +2570,13 @@ static int sdhci_msm_probe(struct platform_device
> > *pdev)
> >
> >  	msm_host->saved_tuning_phase =3D INVALID_TUNING_PHASE;
> >
> > +	ret =3D sdhci_msm_gcc_reset(pdev, host);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "core_reset assert/deassert failed
> (%d)\n",
> > +					ret);
>=20
> You just printed in sdhci_msm_gcc_reset(), no need to print again.
>=20
> Regards,
> Bjorn
>=20
Okay Sure
> > +		goto pltfm_free;
> > +	}
> > +
> >  	/* Setup SDCC bus voter clock. */
> >  	msm_host->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
> >  	if (!IS_ERR(msm_host->bus_clk)) {
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> > member of Code Aurora Forum, hosted by The Linux Foundation
> >
