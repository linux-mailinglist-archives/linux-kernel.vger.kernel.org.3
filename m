Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403D24B2CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352694AbiBKSX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:23:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352941AbiBKSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:23:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4EBD42
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:23:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BHuvX6023170;
        Fri, 11 Feb 2022 18:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TrwK0RLJkOmWZUo4bNe8oG5yqxl/hEGtK3nn9n6X5Bs=;
 b=Xv/cIz+YMX6ydg9/yr+Nm9TW3VnuAPdBDad6XyvJ1UP9sDfcDVhDq4QWx7ypaFiAbG4U
 f8BCyvE4sizxprgQBSv2Lx/BCQzTSiIdoSxY2FJw3tEf3FULGXcGv0HwoVUS76p0Luwz
 YZH5wteO+9zj7xEmc3s/6+GMjHbkyFFQWrKgqlLMQxo0OCvMw+idGpNwZOB7meyQNq+f
 ZWCJ3VO7XlhRfD7aVIsKmrf/KI+47nsMtCWwWzimtvgjkIKJngO+gI2IAQhg2DVeiV8O
 E7RYS9DHC6hyRrseFsFy01lmgL9rJGspKKWEbYB0/q9SDYde1f9yZPuPu+ZuJPbE5vY8 rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5pmv9032-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 18:23:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BIG0EA114623;
        Fri, 11 Feb 2022 18:23:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3030.oracle.com with ESMTP id 3e1ec7ur8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 18:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTIiEbG7TtTz8aWx7kNE46698MvWGBZsgLp665VhtORRFXryyjVO5IF4uLYxcqnZ0xar5ApdgGJutBZ+bPYcte32JlS4FOr2aMsWKzDCeQuOtRtnTkM/hTy6P95uoohEn9q8qDIAFZT1jC1asjfcBfb4Rc5782jvyEdg/n+sPYe2xeGuoYYa5PhwlFVqj6qdCsM5N9TD8hxdmlhuri5ZT9UPrWVPhE6vpI/qU3aafrTgiop+gkSj5xbfqGqZHnpyROfSx5JR+xMirYTbE6raFNcMnBvXPYh29WE/6Rm5OpRcHDPCq70yUQqneqSxolSyIOAc7fXH0eJSvFTIa2oZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrwK0RLJkOmWZUo4bNe8oG5yqxl/hEGtK3nn9n6X5Bs=;
 b=fumekbN3baS4anQ+1xc+7ryYbCRWwwBuH/JJVh4lVBpHzZ32FxDPj9cj9A6eHWQDfJGG7UdBqS/Mb1+bPLvY5blbTwu1NsjTw6wlA2uuWa6vuJMorhDw0ETpMztaOv2fAfWWJxFZhM41kbHLnafp9VWJ9qQy3p3WlFEwxfWwZNQqwTBPaWVwIX95kMGNGsjItBKPMBNm/DM87j/wa6qlA/WZA1mWeOLzl8OeM28zuc/3yKLJLkOs3xwGTV9DJArqU0AAXp1bxhptZk6cAbX0mA6T7v9jAqp0IP6GU87/0LNoVQCCW2LlSO0YSfMSpC9nu5cNdSVnROmi8rdPDagBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrwK0RLJkOmWZUo4bNe8oG5yqxl/hEGtK3nn9n6X5Bs=;
 b=DjKytz2GcFaMP0G+GRk/dYlu0Fdew1GH8c0a+eCJkKPOpE0w1JE57MvrhfY9hRzDxWGtN43L/Cdtyxm6fP7YoKfBu9g4CuRWZjXNBNw2n+dOIZyFEs1pZKtvToWXJc9MG4Ih5alH4bDDBpSrYevKiVJ0EPlFDsw5wxTlsUMwMiw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3493.namprd10.prod.outlook.com (2603:10b6:a03:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 18:23:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 18:23:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Howells <dhowells@redhat.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 09/70] mm: Start tracking VMAs with maple tree
Thread-Topic: [PATCH v5 09/70] mm: Start tracking VMAs with maple tree
Thread-Index: AQHYF950aNi3XF9OH0OB3LeoeuDha6yDRM6AgAt0UYA=
Date:   Fri, 11 Feb 2022 18:23:21 +0000
Message-ID: <20220211182313.iq3onkxodmaqoa5w@revolver>
References: <20220202024137.2516438-10-Liam.Howlett@oracle.com>
 <20220202024137.2516438-1-Liam.Howlett@oracle.com>
 <1191621.1643974083@warthog.procyon.org.uk>
In-Reply-To: <1191621.1643974083@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27ed71cc-f19d-43df-d9e7-08d9ed8b956b
x-ms-traffictypediagnostic: BYAPR10MB3493:EE_
x-microsoft-antispam-prvs: <BYAPR10MB34934DBDD1F0276F58BD10EBFD309@BYAPR10MB3493.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5PwfonLhxQIcH+2pmJTRs3WOLdckvznqr+2fEU22ks7zmaj/lJsvVjpF8XhQ7pHllh0K6WtIWJsJ8gd9PZyJwO42t9ccWwsfOmAx48HzeVc2Q6ffg+lFCGzkAnYltvZtjYCi5XfLGS63SFqmNvx2I8Qe8pTWR5hPyIZFxa+8TRL5HM7vwCk63qD1rbJaIZQXlEqnHrBPFJ5CsrnMIehvVGb4UiiNjqL1DiwUluMqKKqxgIy6GzakaIdK6KTsMQfa3Eu39c+yd/eG4Ev0jjmwmPET+OipcUKfhVjJZfBa9LkhlNvmv3yJuKulV0uxFNpnHbXxclTL2TniJzYzDMFnqVrRXKguxjXydm2rflF62tkNmO//NIcW/pOQnjiF6jIPiwwQp2Y97pHUBq8wbSg+zX/35ap6KqgwneU/vTtXo8UsHaMaPfgYj9szbyuk9XMI6T8/uBW6EQRgX09a3gRrjKgrK6mBXm1htsaQfA0Z3fNfTKTcfFvRta0MBBZhaCBpxUkOAv4Ah5QGDFydUdxUkXaPl68vOwG3YdCyjqulDC4T9EPX9GIUQmNr/CfGGE9NVssjMQRwiuwH/1ij65sn8CRzR7KfLpJv72C6lFpYHhG+5Cw1lo3VbvhGulK/IM/RJMgi5Ckw+Ai+CnugZ/LDjjvtku/bMrH16OIPfrbfJRenoIJlRQaRadeohP/SvDau+8KMMZo0GjeQ/wHD12ngA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38070700005)(316002)(86362001)(6512007)(8676002)(26005)(76116006)(8936002)(66446008)(66556008)(6916009)(54906003)(44832011)(66476007)(4744005)(64756008)(1076003)(186003)(6506007)(91956017)(66946007)(71200400001)(9686003)(4326008)(5660300002)(33716001)(38100700002)(6486002)(2906002)(122000001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uKp9/o29gMeUpDKhb5ioxsCJXDheX5N3fswekctoXbAwe8fJvBPe3cpzYEQv?=
 =?us-ascii?Q?oep1mszTMR9o3hJcQGnilxfinqYXRzJs5ZydCbw5mvCIYVG/tO5CVhtpkHMD?=
 =?us-ascii?Q?T+EWcMv9Nwzq34rNm1bMBekjgmSU44nc6jHNlkkAI1w2g+H60Tu+SGVz9yDD?=
 =?us-ascii?Q?grf9YEcmnuWFfxmnVfvafATmvu1A8o5JWg2pDKimSnOxS99kNGxvIlU9cMXJ?=
 =?us-ascii?Q?McSO9yBAqvwibCV0LWYsZFEFxXCQMywazRxgrJBb/QAg9xUAQC+WIo6hdUWF?=
 =?us-ascii?Q?XlCqSxt4Q5spF8nvq6KLkPGsOp0pgqGHC3vJETLkUhR2EMaHMjOkTaG3xnlm?=
 =?us-ascii?Q?IDDDphXTO4QRn4rQKszCtGFoeMHznM6/0vXliT8uVsPBELbqYfybtz6nALv5?=
 =?us-ascii?Q?wF0slb0E1fNmm5pIUWkWt6JyTyYx2Z2geRwjMNJPKUbT+oUNPyi+7bbmoP9w?=
 =?us-ascii?Q?th3fDExUVAPZLCAAi1QKUtVsEKZB6VtemOoD8DfvSB1gSMyBzMri+OGrOhUC?=
 =?us-ascii?Q?A2patYm8my8TzeHa8WlaUkIi2O1Av2HhXAskU1kDrCiyPrsKKyjzjE7Hi8kw?=
 =?us-ascii?Q?oeiykOHobeQm0xjsHT8ct3xM5mCCnP0nbCY/uLhFfArlv2+8A546GeXp9iiT?=
 =?us-ascii?Q?fiU2FOT8sZT4GofNr5xCcbXZ9l77NrKW7+2zHlJRd/3fXMUScbaXlBze3BfN?=
 =?us-ascii?Q?70F3JKhYuFbD3p04lyzjLVgaWm2w5M/DMyjWSjSN8sjnLpIF6xkLiff72wPu?=
 =?us-ascii?Q?2vEbb0A7sWlc0ugCCQwYao0lGqKwRGylxfF4FatD8FP9GPXw/zrGePzY1ifR?=
 =?us-ascii?Q?hjTysloU7Q+YC9euiV37RYSqv3w2gwbNa8diNYTzmp2z57zmZD1Bze5c7exX?=
 =?us-ascii?Q?k9pxSls1e0glBMo8uE3EY9//hQD4tc69FaXDwNk0cftrDtKwGZpdkqPA7x0h?=
 =?us-ascii?Q?mQTee83rL61kCSkvOoAt3Nmbdgns6vC83Gn2jpb6dQf6MPd+cV0wXKzlyZkA?=
 =?us-ascii?Q?arCYyFCnxBz+MhY7BtiFzLCY9S0bIeUDVRsRDJF2Npv/3qMq2G5G493ux78r?=
 =?us-ascii?Q?bKWmRwPwrPwcQSnwjWTcatGJOYi7T2GYED8qLGBwRFQdDXmQcGxGjdqpIFda?=
 =?us-ascii?Q?rYIrQ/g5IU4X3J3bpOvHa1gReG64QmT3l4MJyGVq/XV6A5HxkgnJuALJuFZP?=
 =?us-ascii?Q?0UhSoZtY2QET/GVST5JTuMWaofm6blWVtfed51sV4BcfbVKGhY/gO5a6Jz8H?=
 =?us-ascii?Q?m2qI/+DP/2Uhox/0/kSbia2O7bwyFzjcFIXCsLZPr9XrdXB/xdHRqmb+IW0E?=
 =?us-ascii?Q?STkABhMKLEOFgpllfESY8KUM4YE1PmpwYOFgzzlZMzXthVGuKO9YaAeFj2I2?=
 =?us-ascii?Q?Fz/d4cVTwPTDhbd/9lXb1o/UWzUht02tpcoG208PLFld2RKrTIXCyg/et0dq?=
 =?us-ascii?Q?wKp2QXhBjk5gAqtpTqgkrR42A86QUgoSZeX5NLB1o0NhQsp6rbwSRx1qFLNc?=
 =?us-ascii?Q?Wc0p8khFZw3zZW1utlsksdvyrlmQbd5bO8uFQX64CjrHih0qt3EJt1/ldTWU?=
 =?us-ascii?Q?h7EHkpshj0snIejzUA/ThjDSTAszdhI6iIgy6OB8E9Kt1n35emmYW1gn5vlu?=
 =?us-ascii?Q?dVSiwAaty2IEWKRfyEjs6Pw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FE2AF2CE23A5E4D9EA22551CD8F206D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ed71cc-f19d-43df-d9e7-08d9ed8b956b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 18:23:21.1496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ce7K8XAa0B59AghDE0unpWgV3PRYP5f38RPm74i9ersiVKokAzG1M5eZhwWxlarWox7jAmIC/k5v5L0mzTlYeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3493
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110099
X-Proofpoint-GUID: HVOAGEii8YjCTjU--B2nWvmOln75-NRv
X-Proofpoint-ORIG-GUID: HVOAGEii8YjCTjU--B2nWvmOln75-NRv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells <dhowells@redhat.com> [220204 06:28]:
> Liam Howlett <liam.howlett@oracle.com> wrote:
>=20
> > +	maple_tree_init();
>=20
> Can you move this into patch 7 please?  I would like to base my branch on
> maple trees alone (ie. patches 1-8) without picking up any of the VMA cha=
nges,
> but this bit is missing and the maple trees don't work without it.

Yes, I can do this.=
