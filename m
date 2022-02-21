Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BCC4BE2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357782AbiBUMTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:19:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357840AbiBUMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:19:35 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2079.outbound.protection.outlook.com [40.107.96.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2831A81D;
        Mon, 21 Feb 2022 04:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QufdramQXl2HKXiM3B7Dyv1V0oQ+4gg2ECMlG3WP0DRW2xYKNsHoZLMwntGLVGqLggo6X1BPqHO0aK7LAbkX1J2GaaB1aChrC3CtsPCQD+Lho7k5qtiB0yxYxI1hNPiOMVJe+PhYsHgs0Ari7C51EimAE6k0xF1IeACUqJMrfxwwH+7uRhq7oQl6tUDekXhbxMqqslVNLERNEPG1B80ST+coHl+hkI+G11sHppEh4cnnGDAJgrkny825uWrZ6xjL8lgAyUP1zr+YqZBf9jHScb23CJrECHU4uO44LkzBu0/yCIGh7l00syo4JDDWRajdB0l7H78CzU92uqBiSqxHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKrvxpORAMdXIEaAw72CafZuv1/+GUIIPR5c85RDcIY=;
 b=Kcc7A6Gn9IowKl4tvlC0Ne3PiddkzYsOf8jZNhqN72sOCB88BYKDwNMMpU4COmvIP0YUURWihhs1v2Z/dXUAvUHqZAhupR0TDvuKOCOdsiMBQ5KUdfdVY0T8lLl9225AarVPvWmEuAnQQo7xc4ilHnJ5Y7yeDHZMfwwYYZQYunbQx8Y1uVUfSEy4SD9X/Nd1ivKo08HBC3OneIHA6H56O8yZsnUZLOge75cNylewEQ93G9oEzqYJiXfN7OSB2EMf78ej0jpJa3o6mohJHE3s2FEMOsAfamDuMgPL6JxVdJXUieuY0W3cg935PfUL0+q+CEEDY3zLVUTk1WOL1NmW8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKrvxpORAMdXIEaAw72CafZuv1/+GUIIPR5c85RDcIY=;
 b=GXvV+nmcRmeY8WUQdRdYeZg+P1KFip6qezPvCGarhS7FQl8y6IuHwXtBIdm0fyh2H7jh0x/lQ+K8dHypwlB0ZH5imV3Cp4SQ9UEWp6jFuWh9BJYwjISDoFsO5AUN4ReW+fR2Mo/0EAxYmCKfGvzGGEJrZNm5XtEjCRUnXzFT2D8=
Received: from SJ0PR02MB7279.namprd02.prod.outlook.com (2603:10b6:a03:2a1::9)
 by SN6PR02MB5342.namprd02.prod.outlook.com (2603:10b6:805:74::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 12:17:03 +0000
Received: from SJ0PR02MB7279.namprd02.prod.outlook.com
 ([fe80::a159:fdbf:b4d0:c180]) by SJ0PR02MB7279.namprd02.prod.outlook.com
 ([fe80::a159:fdbf:b4d0:c180%8]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:17:03 +0000
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
Thread-Index: AQHYJDLEV7muFowk2EOLQ1JY4Y7bbqyZD4kAgATePfA=
Date:   Mon, 21 Feb 2022 12:17:02 +0000
Message-ID: <SJ0PR02MB7279894629DCA2758355A9D2DE3A9@SJ0PR02MB7279.namprd02.prod.outlook.com>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
 <1645125264-11033-3-git-send-email-harsha.harsha@xilinx.com>
 <Yg9qOrjJuttVSetN@Red>
In-Reply-To: <Yg9qOrjJuttVSetN@Red>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d4d9d4-2983-4e42-e116-08d9f5341180
x-ms-traffictypediagnostic: SN6PR02MB5342:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB53428277AB554BCC09D5E8F4DE3A9@SN6PR02MB5342.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qRicbAG2jBHe6MT2SJGFxlv1iGztZjLljxmRbZqBDvH4JGjz/tyNCw92ABbc5idbdkvHwNQGn0e0VM7tgxvBaMt8MSFnWsV1c1mJ/bucFY4TduJXcQ8aChuDOpa3KSQkhrjOeObs1O5uBZWtBreZNS0hi01ASElCfDqvCQMV9kd3HErTn1pKD54lqQI57yYpPHt28F/WyT1w6tHeZ06oiLA2NZkRRSBXwAvFhI9W8XwRtLXz3fySBF4O/tpcm6HMbCOn6utRIwqBXi9ezc1vqR0OIpldTdtOnuDf7MwIh5GMBaTuIG3EdMTFsDzVeLpf0sK/T8L9NEwbM1xKWAT9xD5l8rLbNhK0+IEimyjKGouN09N2aJzLw9A1KpRn0Ju8LVBzscjw5MKY1SnZEzE5b2lD0VYMCcYUAen/X1KEPWMLEJqj1BmWwhTz8R2oavIU5CY9R2ZX+hbeBQQHVF9/iZMqB3BqHO3ww21lwE3YuynrpF9R1TzFHoal9lHXEIiwIMebQITlgcgkkeInFUmOebijErof/cRZ5T7TKrEG16vG+9cB3vNmnsdMP7iqIprHVce18jGUaLEmX6WZhZ9+z+8E8tgMQ5wXFOPN2lRZ4943OR6HqRjEzcJq5loa3+8pQOVR349pN6DMc/uFthZvDdRA0nZFgzWdbrg8VTqYB8C58vjL+hlzCsbPuu2cHIaF5Bdah0MyfIvLMki0JZPZWviLczO4NTOjAx6GQoV+AsjzkPRu4/6mdWGdnqVkVKXbh95bsLBl/n5mjyU5TQE+2RhssmTxoIPlVHvHpkdmgfY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7279.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(508600001)(66556008)(76116006)(5660300002)(4326008)(107886003)(6506007)(66946007)(66476007)(66446008)(64756008)(9686003)(966005)(83380400001)(26005)(186003)(66574015)(71200400001)(33656002)(316002)(52536014)(8676002)(8936002)(55016003)(38100700002)(2906002)(6916009)(122000001)(53546011)(54906003)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HX1XwnYoe/ZIQV0+UDhQbJEs1gUvdlgCIsOvWRNYWYn644S7OaazahBfnV?=
 =?iso-8859-1?Q?o7ipg7wgvDc4DplWLH+eNBwkhk3JgkV2JwamqvBE7A2rDB7Q6rRptYH1dD?=
 =?iso-8859-1?Q?9WSyas0lGkjQ8uguZWHfOLi+o49Z2mp1NjxVMXZ88MqUwOMj2zrVmmTXCB?=
 =?iso-8859-1?Q?TeY+ac9E2GH507yDSUJs4/OzU2wmaGaqWV0vqQH0heDdiQpY5c5cBFnGLf?=
 =?iso-8859-1?Q?JOEgI6JWk7ZJnXAgdFFGL6iucO+MLxY1qmVPMzQVh0HHU7OIR/Wx7Nj4JU?=
 =?iso-8859-1?Q?5wNFJomvIG2CENz8oGHKpFjEry6ITuGq63Pr7Xdzik/WXx1reuuH6+F02Z?=
 =?iso-8859-1?Q?FLjNO89S2XiGWQusYYHAO54Dybliziuyu1XJusairlB9B1XavopuAi0Sao?=
 =?iso-8859-1?Q?kq9sIcT3e72mgVyvJlvKjtTBj5g1JPKZVIaD3JJHpaOvH5QdmsehtkSghT?=
 =?iso-8859-1?Q?nkwP9VvkC2Mt1heaTlNySotzG3+a9xO3m4UqJpcn5Pl7hIxIlOj6LhlSK4?=
 =?iso-8859-1?Q?nVtdRRtquREWnUcGnVaJHBRWOSecJZOHKTwmcgk2aiJiB01YM1gf4Cksv6?=
 =?iso-8859-1?Q?/c8Lf1s13cS0MG9iAAd3j3VmvipX5/x+3lw7y1RXnDVR6rZrKFGyH+ERpS?=
 =?iso-8859-1?Q?KEj4+Bta2kYM4NC33/8XEPlt8IzBnXKGExpLy0/s2FGtYSMDZBEcmOQTzO?=
 =?iso-8859-1?Q?X+SkWjNup9ItnK6DoSiuQlf2GTol4SoaKKnCbYSpwb9sXxvEWEiDXB176Y?=
 =?iso-8859-1?Q?/sySDD+pYdr8jjdPLL3guboeZwBt0V8XLmOLHqzyFGUGd6pehqLmUiraqu?=
 =?iso-8859-1?Q?CYYneAqPN0t3rgbU1J6++fcBSRORah9aTeGdOx0iyI3vUp3Ozv9tS+Fyq2?=
 =?iso-8859-1?Q?iQgXy0aFQfrlGYI1pPn7gcLIBVd1ob/7OWPvmQ+Wgo5rhtyiLvWQZWx7hA?=
 =?iso-8859-1?Q?k743lM8E/sYSs0/boZEm9BWgXII/TQ+M39JhvWfdT2dc4/GjGZsnGyIeZj?=
 =?iso-8859-1?Q?mW6rHHZ1AilrFE37t3zqzfp9yzE8uXWmNB6DtZfa8bfGNpHcp6tewf2DHX?=
 =?iso-8859-1?Q?VDlgVqOQ2Ax/XGow75BIpV5xgHKH1r0K8DIZkifvJP4KO7IKseOkbRQEQZ?=
 =?iso-8859-1?Q?NhmKg9a4ydGJTBzAdpbHNiqNMFF2Upy3TYqi8q3t727TqnINACPeHvuAhD?=
 =?iso-8859-1?Q?bRQKM8i/Ez6QVtG1kfpHtceCWNUYGG9amLwsyrjLe0d5LafTd7Im0RB07Q?=
 =?iso-8859-1?Q?7mVmUDVwcY/DWz+6qA5Pe6icrD0nWFA7fJ6Q4nUVWKDj7dPVdJSjYyjZJt?=
 =?iso-8859-1?Q?J0rDuq16ejQxUavkrwXkTspUh/3YW6wNpdc41G+oFxPr4653U8saVHSBfR?=
 =?iso-8859-1?Q?4o2khr8wXluZmswg/5l54onBjJjcacz6HyYEAjdAFVPzMm6kYyWcEukINX?=
 =?iso-8859-1?Q?hidelrFaje853UoZ3WkueozF92VtC6p+J8sOWfNQ9KLfJulqw2rC/+F8wq?=
 =?iso-8859-1?Q?H9oCaHgNcWXyZyAs10IgGTCg85/C9vSVIMBrk/wBw+W8j3Fo5KA2aC4mZy?=
 =?iso-8859-1?Q?3OhaV+eUhfKLN9caf9PpS8BDXg82hHrdAsaSXBzyuwmxoeWdiTmThXI4RS?=
 =?iso-8859-1?Q?6pXRGddx4sS5/4R1uNRyC62IqnrxetQeWf8nC0apt8pnzjC9st5EJQUg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7279.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d4d9d4-2983-4e42-e116-08d9f5341180
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 12:17:02.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUWKdGwXFSVHxnUQIQCXQIdyHe3wBDMk/F4eEY8XKgJ0nj9ALJPRXUnaN1s9AuhLq7Bp7hY2Rmm7RwMxN1GEwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5342
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> Sent: Friday, February 18, 2022 3:13 PM
> To: Harsha Harsha <harshah@xilinx.com>
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-crypto@vger.k=
ernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Michal Simek <michals@xilinx.com>; Sarat Chan=
d Savitala <saratcha@xilinx.com>; Harsh Jain
> <harshj@xilinx.com>; git <git@xilinx.com>
> Subject: Re: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3=
 functionality
>=20
> Le Fri, Feb 18, 2022 at 12:44:22AM +0530, Harsha a =E9crit :
> > This patch adds zynqmp_pm_sha_hash API in the ZynqMP firmware to comput=
e
> > SHA3 hash of given data.
> >
> > Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > ---
>=20
> Hello
>=20
> Your signed-off should contain your real name.

My complete name is Harsha which I have mentioned in the signed-off section=
.

> Furthermore why did you drop copyright from previous poster ?
> See https://patchwork.kernel.org/project/linux-crypto/cover/1556793282-17=
346-1-git-send-email-kalyani.akula@xilinx.com/ for
> reference.

I did not understand the comment. Do you want me to add Kalyani's name also=
 in the Signed of section?

>=20
> Furthermore, the previous poster didnt answered my questions about parall=
el processing and tests.

Since SHA3 HW engine in ZynqMPSoC does not support parallel processing of 2=
 hash requests, so we have changed our approach.=20
Now  to support parallel processing of 2 hash requests, software fallback i=
s being used for init, update, final, export and import in the ZynqMP SHA d=
river.
For digest, the calculation of SHA3 hash is done by the hardened SHA3 accel=
erator in Xilinx ZynqMP SoC.

Following tests have been done for the driver:
- Enabled kernel self tests and extra run-time crypto self tests
- Tested SHA hash computation for different sizes of data using userspace a=
pplication
- Tested SHA hash computation using multiple updates of data using userspac=
e application
- Tested parallel hash computation
- Tested using the tcrypt module

>=20
> Regards

Regards,
Harsha
