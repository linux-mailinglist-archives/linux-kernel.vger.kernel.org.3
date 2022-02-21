Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42484BE04F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358589AbiBUNIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:08:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358551AbiBUNI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:08:28 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210771EC4F;
        Mon, 21 Feb 2022 05:08:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByU3Htn1oNYIcJOjJxB4xiVCBrJmWGHWhHIcs20/ph2Znt8Dvkk2Qo/KR8089oBQLem8jYswti1G+NBAogloOUDDsn69yaAYdKj0kLZbigZKOxChwNm85yHJGfzGAOqE7pz8cYjOjVTfv7M61PZF3BH9AYgLi4TQz6NiA9XIcqDRdtGutANnk5m3ZdujcbHXbY49HKLPOo7DCEWEbzI7WyY3prl6vGBfATRcXsrmttpiH6VMqyqoB87tyrUhjByzQUlOlhKxEQcFmL/fWAqHk/EftpG+fsH+DkoaN9twCW9VDKLYRum3SNEucBIaIGFPi2EoPpF1F/t6MKY3ErYNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOUNC/ti0OOdjdfxbe3dzRn/yo29ytQRuBZEVFuGLqY=;
 b=EwSMjG4WIP3npzz0Ol2YIllPvssTL1x5rpDaYd//9f27jka6RmglO3vZioZXEBOFGSyFTEKhQ+J57k85YeTeMmFSa8c6dGW81fzdgVGtIxt3dEqJvDVMsjnZlun/ugW6jPCQnMT/89ih9q9Ut3rQReTEgu2w/9wDbqHYX0FwkoqaYf4P2H8MfI9gjjrqExDTqi2Wa1vinVfWo8If7GgI+PTBcTX9ywQ41D4ptHgX3s1Ct5NsENIzB/sGD/MWbVhuB3fZFI1vIjL56Y7ox5BGoK1lOnTObZPUtsmE1b0n0ImxbRKDaOsNucMEAcMYnenmrzJ+tp+F2y43sRqoewYRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOUNC/ti0OOdjdfxbe3dzRn/yo29ytQRuBZEVFuGLqY=;
 b=VWaJPOqHCEoEqwwlw+y8bIm9cw5A9swDQzH/aim3txK39yW+uyvmS13l/jMqqfnB4V5ChCxXGNbXg8wJ1BLkZbxTDO2IcrYTSoU53w3vJMkH+LdRR8P/nTh+QXgH9IvzBaKnN4X+y9Vh/TUbVwcoKm47jm63pza/bK9QGqOvDFI=
Received: from SJ0PR02MB7279.namprd02.prod.outlook.com (2603:10b6:a03:2a1::9)
 by SA1PR02MB8461.namprd02.prod.outlook.com (2603:10b6:806:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 13:08:01 +0000
Received: from SJ0PR02MB7279.namprd02.prod.outlook.com
 ([fe80::a159:fdbf:b4d0:c180]) by SJ0PR02MB7279.namprd02.prod.outlook.com
 ([fe80::a159:fdbf:b4d0:c180%8]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 13:08:01 +0000
From:   Harsha Harsha <harshah@xilinx.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Harsh Jain <harshj@xilinx.com>, git <git@xilinx.com>
Subject: RE: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3
 functionality
Thread-Topic: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3
 functionality
Thread-Index: AQHYJDLEV7muFowk2EOLQ1JY4Y7bbqyZD4kAgATePfCAABFkIA==
Date:   Mon, 21 Feb 2022 13:08:01 +0000
Message-ID: <SJ0PR02MB7279D291580A2F1583836F79DE3A9@SJ0PR02MB7279.namprd02.prod.outlook.com>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
 <1645125264-11033-3-git-send-email-harsha.harsha@xilinx.com>
 <Yg9qOrjJuttVSetN@Red>
 <SJ0PR02MB7279894629DCA2758355A9D2DE3A9@SJ0PR02MB7279.namprd02.prod.outlook.com>
In-Reply-To: <SJ0PR02MB7279894629DCA2758355A9D2DE3A9@SJ0PR02MB7279.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 827696e6-4529-4d72-27bb-08d9f53b30a3
x-ms-traffictypediagnostic: SA1PR02MB8461:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SA1PR02MB84613038A1A97F7DB35A1C8ADE3A9@SA1PR02MB8461.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jp8bJd1vQyGqatJVzVmBvzEUsF+HQ5iNC8rCzuGCTh/PhDVUt0akVMI09aPOnP7Z7AwqjY3EbLRR56jJArz+rAmhm+HnZ4gZb6BWxX1IqEXwHJroO1eeDzRF/3J82VA+EzxSEowG7HRfGTQGoA/JvpoScM20ezJtd+sGOxSi/nAtJKKZpTAWw/0SkhF9PW6JRe7rJrYWOq/wrE+PNAVYBB2QFVU7Hk3Q50HQ/Tr55dhrCfDKv63RqbLD69Qpgi4fxUp2KgGFqbn2EDRLLiLYtI7XdZXNSkaHd/9oRv2+pzDQNDZNIcKfYQZduotXfdM/ebbJwAEs+VpoSf2gefIRELuye3sdXdH6fUWnsoC5tEjiDaXAgPg6jz+UYV1fmmBkSFIU92aTN8YYX/bc9fzLBxItD2kRSGKtDnExq6t8vnfOnZinK0UI3X9RDq0LePUyQOJ/fVPFBgWD6lLAKZhJL4dFzf1l90vngNlcriomeRK1zULQPyVPbotTwS6fxxSD3oFS4+51lGe5w2bAHxSFbY5nrEgH5e6tQoOPPjCmn0TzTEjOAl0OanwRTTEvLL2ApIOCn4RtdlKmj/9cH3S8WIqEadufH0hr+zLqQKtRor242WScFhaCLGv2IKOYTgeGyF0Q1nkSRbegPzShRB91WIpwTniwmugrN4LM3KlQRROkpj0xVBx7dENT2JuovkklRv/BiSUroHtiJnoYMpV53GyuKIlGSL2rlojIL85qlCbXiAtrcDdc7IiTh1QCtcyBuHR8Kpq+zJ+b8/t4j5DvgtiONxu68TiThLwopin28c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7279.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(316002)(55016003)(71200400001)(6916009)(54906003)(38070700005)(508600001)(8936002)(52536014)(53546011)(107886003)(6506007)(966005)(7696005)(33656002)(9686003)(2940100002)(8676002)(4326008)(86362001)(66446008)(66574015)(66476007)(66946007)(66556008)(186003)(26005)(64756008)(83380400001)(122000001)(5660300002)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KSBbKsIiRtRXDLaAYgCH3DzrgDKvPhcBRYQBdUWRGAolzV1ptYTW1EJGil?=
 =?iso-8859-1?Q?hRPbnORnfWHcLst+fukXsLERZPTOeBMzuwsLCz1aeu/LUmXUFLo+m0PxE9?=
 =?iso-8859-1?Q?vFWlBU7Z/FasssrZO4o89msZkTVqs+2hDmBmxEQgNCJWQyYGhWRN9HF7Y3?=
 =?iso-8859-1?Q?NTI/aLOwzMJKT6z+WlNuPwc9CILrp2P9dqaH0OQNbdly7TZY0xfkubItUY?=
 =?iso-8859-1?Q?tZ77OIeiWWUbosqx+Joahc7B1hUe49ZPbHh6Jg4vVuxxPYVSqJXD/so1/D?=
 =?iso-8859-1?Q?PA7f5cPuuFBo8/a/ld04dlkl1rpqRKuGhJipFadz756liyHgKcQcz97E00?=
 =?iso-8859-1?Q?1F24i6S5o6tro5ZT6KbZlgkYtZvHy1M+7m7+fTKZZ9lVB+/hkN9iYAhFP0?=
 =?iso-8859-1?Q?lrN4Ky4BCdsaPrzgwGD4LMiq5HUeFPDe9kgGwfrLKz9DgMnSI3AD2pjgM5?=
 =?iso-8859-1?Q?M5EZeNU95VP+QX1HGhM4WERvuANf1ggHhRymjF4f8FjwctLcmIgzbZzHT9?=
 =?iso-8859-1?Q?uKAkwqRklUmHEGUXOZzEz5V1mn/SQRmRfGnTlqetuVDGsgMLAMa7qcJqkI?=
 =?iso-8859-1?Q?wZ8dWhsRSd8PjrUNTpJXetdIexLNq9QQ0aoGLfV5LpvvTe9/ZgWm78ABYd?=
 =?iso-8859-1?Q?JxG3PsrGj5AuQj+BSZ4Ib4qZLowCOPYa2LcxYYmIJhLunAL3Ca913qLQvu?=
 =?iso-8859-1?Q?V24m5V7Kz6kzY5hjyAv6iOJc5gyhVMFF4nuUMF6pq1LqYtEBPBf5uwSbMN?=
 =?iso-8859-1?Q?UyAXK/eDjx/zFtZYNOuT6iAtMoIvjc7uE0fTGbxciWbvdbTE6usMT2d8yF?=
 =?iso-8859-1?Q?LC5pXgH3S1/dBKuMuwKyaW4DaQUOaijj9GA5BWnJnvmZ89m0SYLD5gF0hX?=
 =?iso-8859-1?Q?lKTgbQ85blJttA5w6j/HPEl9C3Km5OwHQORWd8FXVQJW0w5BfWuGPWfTFk?=
 =?iso-8859-1?Q?OClIq+MvzDWJ7xQMSCVl1l4gBQnaBOBVK+m7wbhCQwgA8awvDU4/oqpyVa?=
 =?iso-8859-1?Q?TECnvgIqVK33IvmcoqjKxRrgKwXllD1j0PS6sGn+oFcmITaVNFDIYTOW8e?=
 =?iso-8859-1?Q?3/iBeFbyrwg7g9DGYKKFnuukexk7ziqmf83hfFcrsg4OY+lkqg2E/Hy+8r?=
 =?iso-8859-1?Q?ehr18JyG7wgY7yKI7CebFF+WCGZbLKE2FRx6e8u5qH4SWBCD+KHeaI67Hk?=
 =?iso-8859-1?Q?SJgxuT2jmCHoWAY4nN0eZxi2FVhgrDTr//X3hV3CNQ2hG1ntGsJlKZCojB?=
 =?iso-8859-1?Q?/OLG2/XZuLhC/5KoQkBte9JuJMydW5TNYVN24on4anx8wxI1Wd45UekYMX?=
 =?iso-8859-1?Q?rKFl4ZheuwhPdljC8mGHd6IDIU0FW0a0vedX5sLIkiaoYgvbPrLDQcYFMk?=
 =?iso-8859-1?Q?6XX7DSLRLm2dnJa0CtvCvi5yWvGRQ60LEXmyCCPaeGp667wf1l22eSJgRT?=
 =?iso-8859-1?Q?gH/n1PoObL7mEFNxmHni1NchiI35hyL6ZIaMb4+Tjh7I5V4UkyxTILVZ8w?=
 =?iso-8859-1?Q?N7wTRb0t5U3XT+fZsCfFWlt7a3Qt4u50KTEEUj0LFtf5PjVuUgQHjUEfAt?=
 =?iso-8859-1?Q?+0Xgq8OHTpNo4r80zVjlsOMGBc7b3scRGq2u+NFmsyH4MkNcX/qrBcOuYY?=
 =?iso-8859-1?Q?Bx/P6ecF5qGbXYekTZDc8HTzxc/60NWSXxwldH6a4aGwfSBIxQt1pmeg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7279.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827696e6-4529-4d72-27bb-08d9f53b30a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 13:08:01.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zj/hnycB9ayDukHRyNvyVFIJT3xobvHSLon7zo2WvExY2t+8vreqvHUf1F+1/KZ0d0K+tY3EoUE1fxTqK5vpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Harsha Harsha
> Sent: Monday, February 21, 2022 5:47 PM
> To: Corentin Labbe <clabbe.montjoie@gmail.com>
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-crypto@vger.k=
ernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Michal Simek <michals@xilinx.com>; Sarat Chan=
d Savitala <saratcha@xilinx.com>; Harsh Jain
> <harshj@xilinx.com>; git <git@xilinx.com>
> Subject: RE: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3=
 functionality
>=20
>=20
>=20
> > -----Original Message-----
> > From: Corentin Labbe <clabbe.montjoie@gmail.com>
> > Sent: Friday, February 18, 2022 3:13 PM
> > To: Harsha Harsha <harshah@xilinx.com>
> > Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-crypto@vger=
.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; Michal Simek <michals@xilinx.com>; Sarat Ch=
and Savitala <saratcha@xilinx.com>; Harsh Jain
> > <harshj@xilinx.com>; git <git@xilinx.com>
> > Subject: Re: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SH=
A3 functionality
> >
> > Le Fri, Feb 18, 2022 at 12:44:22AM +0530, Harsha a =E9crit :
> > > This patch adds zynqmp_pm_sha_hash API in the ZynqMP firmware to comp=
ute
> > > SHA3 hash of given data.
> > >
> > > Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > ---
> >
> > Hello
> >
> > Your signed-off should contain your real name.
>=20
> My complete name is Harsha which I have mentioned in the signed-off secti=
on.

I shall update SOB as Signed-off-by: Harsha Harsha <harsha.harsha@xilinx.co=
m> in the next version of patch.

>=20
> > Furthermore why did you drop copyright from previous poster ?
> > See https://patchwork.kernel.org/project/linux-crypto/cover/1556793282-=
17346-1-git-send-email-kalyani.akula@xilinx.com/ for
> > reference.
>=20
> I did not understand the comment. Do you want me to add Kalyani's name al=
so in the Signed of section?

I will retain Kalyani as the author in next version of patch.

>=20
> >
> > Furthermore, the previous poster didnt answered my questions about para=
llel processing and tests.
>=20
> Since SHA3 HW engine in ZynqMPSoC does not support parallel processing of=
 2 hash requests, so we have changed our approach.
> Now  to support parallel processing of 2 hash requests, software fallback=
 is being used for init, update, final, export and import in the
> ZynqMP SHA driver.
> For digest, the calculation of SHA3 hash is done by the hardened SHA3 acc=
elerator in Xilinx ZynqMP SoC.
>=20
> Following tests have been done for the driver:
> - Enabled kernel self tests and extra run-time crypto self tests
> - Tested SHA hash computation for different sizes of data using userspace=
 application
> - Tested SHA hash computation using multiple updates of data using usersp=
ace application
> - Tested parallel hash computation
> - Tested using the tcrypt module
>=20
> >
> > Regards
>=20
> Regards,
> Harsha
