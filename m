Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3154D60AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiCKLeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348283AbiCKLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:34:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1171BFDDC;
        Fri, 11 Mar 2022 03:33:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTVC2a+uAGzc7Ia3+Ha88nkdfooICKq7BFxERkEH6aQQq5I7ruu61zd2xF5EKiBNVktRUqd8iezAIQ9o8u4thbyChkAoTWWCr7EZMeKFpodeZNlD7Me93gLG23zmvSR6FNRsVJfyHYjpogVKP8WIe6+TQBttu2rpV1wl8r7fdbAKCNmELNP+XqjGWmZ2P4/oWhfMSPoCn1NjcmshAiHA18UMqsmaBQGsdAZVebBgds8X9kMLQ6mzsg4br+lxFRpUsBuYxHYjvR2lEmz3peeC/IkImnIgbL9JjuLByQpICRuAGE+SMM8jZDWEyryUaJNfJ/dhsqCxT+GusZbvg75DOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C2Tss/6wZume397eZQhFejgiFSZm6pSlGtu+9VINOs=;
 b=QjCDo6RKo52xuPMHhtc/L7hVtJ9vbq0ZWfkNy8Hbm0iTuz4bbndzgwEooT0lyRnxDytwO+FeMRFeYZ/R2y/CVz2zWbtlAakc/qD/WppVILjGSZIt/bXIPu0ylhLemAjbqfMX549u0SfEKYI+L3275uoV0yfFK2ROu0hV2U7HcD/6BwZrmYKqVdSc7qxarojkFRBibhzoLDRrINvqiXBDonnduMIxWdxm1Jl8RaPJZpJ4vj1+3z6ZjfeBTttlnaN5AbM7reRVGXCOsYyftFqhQm45K2nnly7Qx7MGq6vV726iuf9e4pTSdqIiG5kg7EwqMZeU+NJ8aTVh+ET28D8inA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C2Tss/6wZume397eZQhFejgiFSZm6pSlGtu+9VINOs=;
 b=A/cXQCIg5omj1VFTo8VLPCNlIgndxowwJBpxAQoVV6tq4uvvBZWM7kz4nenSARQLujBiww+ArsMTwnsDlCfzU6PevIpyG+zyt4xh589JwqHbferzspGYHaS1QvWE2vIBbgrR4pC+EtoWiwCS0HXwHrYNg+xnAx7LVeHpj2ga8CQ=
Received: from BN0PR02MB7933.namprd02.prod.outlook.com (2603:10b6:408:161::20)
 by PH0PR02MB8796.namprd02.prod.outlook.com (2603:10b6:510:f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Fri, 11 Mar
 2022 11:32:57 +0000
Received: from BN0PR02MB7933.namprd02.prod.outlook.com
 ([fe80::344c:1ba0:2b3f:d4e1]) by BN0PR02MB7933.namprd02.prod.outlook.com
 ([fe80::344c:1ba0:2b3f:d4e1%7]) with mapi id 15.20.5038.029; Fri, 11 Mar 2022
 11:32:57 +0000
From:   Amit Kumar Kumar Mahapatra <akumarma@xilinx.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH 2/2] spi: spi-cadence: Fix kernel-doc format for
 resume/suspend
Thread-Topic: [PATCH 2/2] spi: spi-cadence: Fix kernel-doc format for
 resume/suspend
Thread-Index: AQHYNJ3hCfH2XLgqfU2OFBNnQ254pKy49R0AgADId4A=
Date:   Fri, 11 Mar 2022 11:32:57 +0000
Message-ID: <BN0PR02MB7933108D2F4C657D850CE131BA0C9@BN0PR02MB7933.namprd02.prod.outlook.com>
References: <20220310164235.32230-1-amit.kumar-mahapatra@xilinx.com>
 <20220310164235.32230-3-amit.kumar-mahapatra@xilinx.com>
 <YipHjjg/sLRqQVX6@sirena.org.uk>
In-Reply-To: <YipHjjg/sLRqQVX6@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98f021b3-2bdb-40ff-8449-08da0352e448
x-ms-traffictypediagnostic: PH0PR02MB8796:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <PH0PR02MB87964BB5B4F2D1250FDF651CBA0C9@PH0PR02MB8796.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPB+/kQYYgpE9vxZshZPhF3Y287uueQXAeI3sGr635Zejwm2Co1I646ZCczcYjWPlr93OMyeGigMuXr7kV539PxJl83PyUnFc64i3KGuWQqiFtTL9pCW5yYIeqO8kDyVuk0StLjJxK/v1l0BE9qM0YuuEDrLs6lbcg/JHNR9Q4VyPL+1B8q3vfc8WXg/uYb7J9qohWdSBKAC0UBMNrAdVASYtkMxZC5NhyxkJEryxhb5USk+pIbZ8z5keFteDf1JK8uH6tcy3VT+uNrpWVHZ2hxf3NubyZPkd0o7em66ZG+ehHJWXUOK4cNGSs8aPirdsEO9BjRuxGiZcmthZ2xl5KzcYX4RJDd1NRWK4HLFdQCdpH9OowvUvPPzLU3Ojalfc6fbYJLQJ6KpDBMOzVlZEpspegEApUCsW/zXcYN7GTEKGK14tKg4KsoXq2lss8GO8TrxKrZvrNca7Z4gH+7KZuLBC7K8xtBle05rceK8VJrmdGOD4/xfzgpTNn0am732cI9AAbZw5ve4lIkp0by8k7X5OD3Tt7uXj1Pg/3DXMycsRe9yJT5Oh/pqZ2gkrokAU/YgW/WzTnFXxvduNIHjro3PDcDHF7EMZLmKC3cmUzXyRjkIKTJIPVS2Kw2igFTx+SOKCLNj6bJRyQqhyZvSy7T/HTgkdDoeF4SD0XKKjusNjD/HeXEEP+m0XxZkD63AyID6rx/nJ7beuUux9Y8Kv7HCg7T0uY/nkzRZae6YNBE21Jl1SVM6uEPblWAqAyXyDmMbyPgMFbbvU9k09CVN0b7PEX2aKRzIWoJUmw4CQYw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR02MB7933.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(15650500001)(6506007)(71200400001)(122000001)(38100700002)(66446008)(52536014)(33656002)(26005)(8936002)(2906002)(86362001)(53546011)(7696005)(54906003)(66946007)(64756008)(966005)(76116006)(66476007)(9686003)(66556008)(508600001)(5660300002)(8676002)(38070700005)(4326008)(107886003)(83380400001)(55016003)(6916009)(316002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E8xSVIV2E7qph8eaeXjBq0YQ/XwNOux0XPCdcwCwlVVGjcreavvSrZ4VIBqt?=
 =?us-ascii?Q?yBRAWUwSPu52a+eoasvt66lMc3XMX6cJVsvDHi0v/OljWZJQaZRZo+lIvUzs?=
 =?us-ascii?Q?nZjwTups7eCWXB1u2VzUApeSbR/+oSx5tGU0pE4NCq+hNzaULBQE67JdaUV6?=
 =?us-ascii?Q?0soXdh82dDQ0c8KBTVkYVr+VL5orqobIG+H3YOrU4PXA8G7mCS0A90k9beCM?=
 =?us-ascii?Q?FaJe0iOQ883L9oltRAfRJdZwImTVktPNYgqeKVQ8ujlDHPKrrjMgYknMgXcF?=
 =?us-ascii?Q?kNKU9OuHlW8FFevJ3G7KaxWap2esCKYQ190XgjZkABPo3o/RomOoaD9VVAN3?=
 =?us-ascii?Q?W9NUVS9CUEJFUPVCxZxHfZAzgKE59gZ6RE75tehScZeYhmxR1p2bBR1ZH5Z4?=
 =?us-ascii?Q?cA5HUWIyUjNoQao5z4SkEJNIMODRAnEPN+FMUf64goRBlr+Q6YVAuQ9D978M?=
 =?us-ascii?Q?cnZCnm33pIr0syIWQLJtUD2NI4VQAbJf9kLs+CxWtJrMQxgdBLNRMEC4SBVT?=
 =?us-ascii?Q?dn/KZsIkbV6EYA050G5GWbXh/DHk5cwfu2zeniTe/dvjXwKsP3bB1h65ou2r?=
 =?us-ascii?Q?8vgvucG02eDZo6E21EHiPFgeVG+ArqnuR1k/MEBUrjOczFpSVwA3my7uAfHk?=
 =?us-ascii?Q?Gk54cN1N23qr0TcO8NAaLHjl71o0O6LF6mvbTt/blHx3rYL6KH3fBagwYjYv?=
 =?us-ascii?Q?JGdvDIDPCabFBAXC8fcVoVh73okbYh+lJTI5RvnXYGMe1ojSJjz2TjU/fPXr?=
 =?us-ascii?Q?rCVR5pVBpGI4g75BI5M7Gt8lENH7eP4DG5DTU83192kDFHzzWqkYoawfJcVD?=
 =?us-ascii?Q?ig5XAk1w+KS8E9DG1Myfh/URQLDDxsMimEZJlqqZRcGMzIPa40+LKWuoT9yR?=
 =?us-ascii?Q?/9Do30bwkt7F2OQ1jTKlUoqqoNG2rpNWhILdkcWn85/98KhXvED9Q3PoAIg/?=
 =?us-ascii?Q?hc9/c79RRMGoHQFVJFyl5SM8Z6RZAQ67bzh5AzfaME/6v6Yj9ji3CQD3MqRc?=
 =?us-ascii?Q?7lgSGrv0QgwSO3xtnzbIadzMvsYVPcLmj2OwWTqwI5coWoZ7dFsyfY+jLRN6?=
 =?us-ascii?Q?MrTRCqkWCSmvliT2SCwAxjBtHBOEOEET0CJn1L+1z/5Nss3eBCSpAGWJwIlB?=
 =?us-ascii?Q?ZrYnJNhlBhUMkOQD8EypBA5DVL9AxnwP21a1wKIStG5PM2M95TZZMZh9SqWh?=
 =?us-ascii?Q?KpKObyaVyHsAjC+bLvryw8yROGznz4KwUvFPCo12IX3Auu1Y2ejsKQ5mB82g?=
 =?us-ascii?Q?aaL9mIn0ya6KJyWY7msibi/BIf1/HBLs3asPtxqxtrNp3APlEO0q1h75zdWJ?=
 =?us-ascii?Q?AvakLiWF5cHweDuusygjpIfdmlyZ5ndrFG6EVsWCMClXja9Ry8h4WpOMuvPO?=
 =?us-ascii?Q?9uZ7GeKhcx9I3HbI2ZWZZpfPG2w1VcDIiQlDAlHxfGZn8Th7eO/2sdm1YUwT?=
 =?us-ascii?Q?ALrB5S3fqhA7WPe9YeUmWWVA/eu2YivFsQlms9nG+MW1K277JcTMQsbfh90b?=
 =?us-ascii?Q?D+OiksY/M7qewH8aURSMfkz2KB9ozfQEElRcGxj1Y8bZ9qgsJPk6TEo3nruI?=
 =?us-ascii?Q?SLa0yvjDGSCm5WeJ1jXMcOuwBwJUx8hIcyBZTUOJHEWkQREdAwfbKFWq/gzq?=
 =?us-ascii?Q?a4NW31oWAXflXUChM6esCiU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR02MB7933.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f021b3-2bdb-40ff-8449-08da0352e448
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 11:32:57.8037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjV55zOPzQUiZJyBp2hUgMKDGfjfh1SlA2ff4bV0P5Ewp5Q4MAHmq7xMKpJaFM6zEDo3W9rsMoyMrmYwcYxSdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8796
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, March 11, 2022 12:17 AM
> To: Amit Kumar Kumar Mahapatra <akumarma@xilinx.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; Amit Kumar Kumar Mahapatra <akumarma@xilinx.com>;
> Michal Simek <michals@xilinx.com>
> Subject: Re: [PATCH 2/2] spi: spi-cadence: Fix kernel-doc format for
> resume/suspend
>=20
> On Thu, Mar 10, 2022 at 10:12:35PM +0530, Amit Kumar Mahapatra wrote:
> > From: Michal Simek <michal.simek@xilinx.com>
> >
> > Kernel function name don't match with function name.
> >
> > Error log:
> > drivers/spi/spi-cadence.c:662: warning: expecting prototype for
> > cdns_spi_runtime_resume(). Prototype was for cnds_runtime_resume()
> > instead
> > drivers/spi/spi-cadence.c:691: warning: expecting prototype for
> > cdns_spi_runtime_suspend(). Prototype was for cnds_runtime_suspend()
> > instead
>=20
> These errors are introduced by the prior patch in the series, that patch
> should be fixed to just not introduce these errors in the first place.

https://github.com/torvalds/linux/commit/d36ccd9f7ea41f343391a15677b8a85837=
6e1107
The above patch introduced two issues. as mentioned below
1) Runtime suspend/resume API had "cnds" prefix, unlike all other driver AP=
Is=20
that has "cdns" prefix
2) kernel-doc warnings in runtime suspend/resume APIs.=20

So, the runtime suspend/resume kernel-doc warnings  were present prior to t=
his=20
patch series and were not introduced in the 1/2 patch of this series.

1/2 patch of this series aligns the runtime suspend/resume API prefix with =
the=20
rest of the functions by changing it from "cnds" to "cdns".
2/2 patch of this series fixes the kernel-doc warning in runtime suspend/re=
sume=20
APIs.=20

Regards,
Amit
