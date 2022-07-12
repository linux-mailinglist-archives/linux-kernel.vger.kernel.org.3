Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9476570FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiGLBus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiGLBur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:50:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E62AC5D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:50:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BMYYW3027941;
        Tue, 12 Jul 2022 01:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=8H0/kd1t7uxU1BReLUdM5T7UvMH2bY/aG0hDK1juWjE=;
 b=rYqtyWghq22DmovIs052WgsfbKxONvFKdWVmJFABsmMog2O8dmpdxK2wVL+yApq28kaD
 kOaROvlv1XclqrYjcbsY+1j1nVJ5otVal6i09/Zru+5/FTE0D4XXvUCdzpFGbyqH/kIv
 we+wCWTrW/BsVcHph831DYX9KhEZNgWtSW5HR/ZL6lQCc26rWtHzCSjju8HW10oUdq1d
 SWqDLfYDlx+jUfCpjpkSbU8hI8YBekBWmmlPOjnbAmqptYncG91tmac9mG+PUz7QBCMO
 UxSRUpuKhinyZxAqaRGiK9pWw59+9qypDwH5VhkSiwq5dasbUxz0ffs0jbwNHVMFUlWO XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfw3ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 01:50:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26C1oBbY008966;
        Tue, 12 Jul 2022 01:50:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70433nmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 01:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXAX5i76WmDtG3zTP2Mu0wLWSI4GyCTeQ99/1+xLKz6gg9aNfnMIH59F0ZIM3+8Eya7MWljJaohqTtpwvgXvUqEFkJjLh/DdOjMxYt8UCwMzIeltiQqVbAmIQBPZaKBgjBma7lXyQr1+6RyrvVCaBqulAGFdLS8Nz6zZ6TSwdXIgFIlP3nbDMSvklL/1vvKpoKkBhB2P1WroXKbEsrsINAf2Ss2gmzYP+wCO6W3E7WeMGcCqSrazOO/aQLii8+y8QUpPWzjaVSBjkkNKXh1dArgVrXjqeGnw/10mroLGDbPx9GDFPrAxqFNOKTFPsoy/i4uNi8a8dG0esLfHzGeoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H0/kd1t7uxU1BReLUdM5T7UvMH2bY/aG0hDK1juWjE=;
 b=gvazKFk5VvieFzUHtj1OVhP8NTqK6gsS33Yky2w4c4ZcWsU8BkIiCO83oZdjvVN+feXrIa0Kg0xikOP4rlKCbNm/3xtPc6ab3109yjxgyt1khL55MvbfF52WFPVai7RazRIbrIxBVGxledcA5818vPjswNtMX/wjFCw3nKNBoVkMBAMfYMwACn3qSNpE0gOjULWpZ7vrKQAjgWZw5YLE7qz8dUR4dk1seahf/jSxRhBOEMMF1HSh1x0kOcyQzEZ5TGz/cAx5aSMX4/2TkCxaOWqeOg4YbCevnECWhgw/gMF3avtbcue2pj2MjT1aX7Uz+lb6L0+dlq3cRVFy8t2vZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H0/kd1t7uxU1BReLUdM5T7UvMH2bY/aG0hDK1juWjE=;
 b=mCzRY+c33XcT8etzX1nCX6vA7F4OU4lDlC6p5ZSM9aejRlQVfveHX+Q6pzYtTbUQ0JPvmKRe9mRW5zdYRHWh0ZM4KlJs629WJUrtWlI5DpUb7uOxGFGnvXFqP2uWk016Vj0WSJ0oBVF7UASyyigSLp47W+TDMToV0OtwfcpyWCU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 01:50:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 01:50:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH] maple_tree: Fix mas_empty_area_rev() search exhaustion at
 root node
Thread-Topic: [PATCH] maple_tree: Fix mas_empty_area_rev() search exhaustion
 at root node
Thread-Index: AQHYlZHHZk0mGqDhCkmeguxOWUt84w==
Date:   Tue, 12 Jul 2022 01:50:36 +0000
Message-ID: <20220712014957.4064879-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99f9ebe0-f462-47e9-729e-08da63a8ea84
x-ms-traffictypediagnostic: IA1PR10MB6267:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kd4oV1zTlqbFpbo5LlN0S6hJPaLwXqfLXmDjkmAGTKDce/3biDM5IENc+dvGjCLogj2JOpchOfGxO6kEUMErzJJI8S/BlmVICZqt4KuEMnoWCgNKx/9MQ9DCrdIGH7VxlGJ+bod2hWoaVnrNhvHiftJOfNCR6pW4WiYtia9ARLfgt5pcnmRUHE47gpPM1H2c3uvdD9ElC6Nrk2nGd8xb2ppIO9lBVuZX+94X2I/dl7+z8CLZkVhUx8J+CBSDP4jRFII9Xi4fOK1ny7MLVFpR3KYSjet+uEeFgPJgcYFcIJpj+qmEolWHDd+MoojcPXFP6Xl8OJie/sMVziemfQ2RlVomzXog5ZuQQUh/lD635CHiuKpTN2VmZhaQTTLtH9vzxkkmxXWXoWc6BAvWWKIbSAGa4esup0rz+x7+5cb55D15x4kZJutNmjtPGad7Qq4vnAMVkqJRn1VCsXueizQIWqJ9RGDMj1Rc3aNZfpFqiLzluq46XKc4mLo5WtTkz09PzBWhb40UtuJJ8XKbBKL2u9eGwCea8Uw2iHWB3DYvWaoqFchBdw8dg62r58G8K03v1J1P+DyRELTG5j5jp1IenKftJluBNsMTeIucRtuSyMdKW4KEULlPOve+lwt3kNedBsgej48wE9wUlt9Z+yrJbohnBizcQ36NX+Ax1lQ/HEdVGA+LO+suRuSQOW+4BNyXStozDCdrJ5sKvmaDuYZ76aS2wS7HO5afUeIbccrR06xZ3gk7bZX/RvYhj3KTdZuZVwFfC/Sb8B9W7QgouiTrTayK+A6jdnk1u4wWsJrr++T8C9HLd55V/XexMMjKvmZS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(366004)(376002)(38070700005)(86362001)(6506007)(76116006)(2906002)(122000001)(66446008)(38100700002)(91956017)(64756008)(110136005)(316002)(66476007)(8676002)(66946007)(66556008)(1076003)(41300700001)(2616005)(4744005)(44832011)(71200400001)(478600001)(6512007)(6486002)(186003)(26005)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+CHfyr7eqoa5svK0jnRoyQvz8SZrA5Qrmiwxma3SqE1d7NaFd1+MkmignW?=
 =?iso-8859-1?Q?Wr0cZY1F7MYdHXK/sG/t8N1gn2x/amL5o9BQlHZqbkbsMYsEqEvX2KRME1?=
 =?iso-8859-1?Q?BVT6NQG6BWwcz6AKLNkCe9dGJDMVw/3QjQ1ywQj17Qi2XzP9Uf6FRGoxDY?=
 =?iso-8859-1?Q?5bGYPsuAnny+tNElcnGiBjjbsVrGKdlwNLHHjtbj6v29cdnjI/XkLZsNwM?=
 =?iso-8859-1?Q?06q0Bl/3RhfP1N8RpAe02ql9OpFGhhE+xncwZ9n7On4AgrfuC6jNooF+xh?=
 =?iso-8859-1?Q?HessIwA9M+7C8qBSC1FJmsLchiFELSuc+DmIyU+NdnVNLILeWdKycbiNwc?=
 =?iso-8859-1?Q?f93ZzumlnMGq0wVXw9ifB6ctSRoh9sE5gzwxUrwFIU7Be7qO5UhI2OfiTA?=
 =?iso-8859-1?Q?tjeqwKFuZZ4GwwbnJkmsJgFZFe2jsFKaiC4naw/Z90nJUNkGzR/qfuApND?=
 =?iso-8859-1?Q?uaRoEKV8K5+Tn56JkRSlZI1DUbAER0tqmwrxGXodNDgnxTnA9q4YLsd1OK?=
 =?iso-8859-1?Q?Q6lMHGe/z0F3utJkTXt+rE2WNcfDyCeoeRXzOkUPn3J63YKYqxbvbvZLPz?=
 =?iso-8859-1?Q?OPMHtmIxEfDfzPnMTSyI1XzeppTsgMQh5vsXV3qhXmRctQMN9fXAmoQlz8?=
 =?iso-8859-1?Q?7CpAQaVvMZwM3PAGhrqeVFP9HR0KnyeGAlspQTC9idUek6SKOHsMv3y4BO?=
 =?iso-8859-1?Q?/fPNiEDTZ+lCKQYM5nXwb/Ze0iUX++cksvNknzizMub8r2c9JQjI73rALQ?=
 =?iso-8859-1?Q?SACl+G2nFx7ZSmQdCrgJlwzEvxENt5J4ePZgSzTojsSB8cE6xRfsbr4MOS?=
 =?iso-8859-1?Q?cSIg0OTM6tZfQZBqWK5MRPHrWi0ETDVBwDDGi2/BJQWtfPfEOWSItemMwn?=
 =?iso-8859-1?Q?e2cY4vJKHOwjBd/DstFO06xh1RYVsMxZpQgW1uk6XXudW23+ssuOH3XS/M?=
 =?iso-8859-1?Q?Qw5zSgsdg52BkbjXRCAUtX3g3D7ssJ3cOOG6+hlphhVa8zwaHH+Mr4Cp4T?=
 =?iso-8859-1?Q?XRNVLLpQPFdQh/ql+nQVJ1/Xd3ZvR0aumGKE19DAyyo9+XQQtPN+EQH027?=
 =?iso-8859-1?Q?2i1i+oleeY1iluSLYHXol8zGPyKocmRTVGYeYi0MRqGIDq3k3cmiLCaofi?=
 =?iso-8859-1?Q?jRHS6gaLOacieAT14G67Qxdjd9lr+LOEiAhx4nWJ7A2pmfVjPYap4CQnf2?=
 =?iso-8859-1?Q?tu7Ihbc3PbEK+MWHgLvcBGYBG5mPq285xRgBPDY1OCep6S1fMInGiPp5KB?=
 =?iso-8859-1?Q?yLDaaLs5Skvw45QKQzX7b/jKlGz8F2lA5Fk+KEp0yEWhbmqWdRV5Hva9iR?=
 =?iso-8859-1?Q?75yIDbV6QyfcusRzu8Lw6bHoVlyZldmw2lWJCQJJ4mZ6WJWQw+5EZyg6ey?=
 =?iso-8859-1?Q?8ICgT2s9WeVKSWD0ELV8RtWYI0B2P5msYDv5uBFsWXUwMrZsk1+cw/+Sxl?=
 =?iso-8859-1?Q?xCngyp/cSM3/nq8wcrm8FgaRqrjNuYqLVPaEAVpHYdqIjVLHkIQ3hXBhqO?=
 =?iso-8859-1?Q?xnEsNCkiNShHxlYttIOUDsJhmvAjdB+uSUpyy3vgL3IZLZKkomMK2Khjek?=
 =?iso-8859-1?Q?lE4dUFQXVtJF/qdb2T3Xj4EdiVkd5dfYA+2k82mOvozsGwIZKFbVCyXaJm?=
 =?iso-8859-1?Q?60lCDtsSFVFILbgCSYCXAX1I8yYMb2lUsyNlCGNm0RWPbHGT+Bn48TVA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f9ebe0-f462-47e9-729e-08da63a8ea84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 01:50:36.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlQbe55q9czlkkuxJi9fT6IjSNHkj2aKlphcd6rigNURWDb7nOk8muTfDOWIJjWzy7edr66ltuSBSdG+rQCA0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_01:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120006
X-Proofpoint-GUID: j2zh3dGQQwaCP6MSyrZ-Sm_xCcyuMf98
X-Proofpoint-ORIG-GUID: j2zh3dGQQwaCP6MSyrZ-Sm_xCcyuMf98
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the possibilities of finding a gap are exhausted at the root node,
the error code was not returned which results in returning a range that
is currently occupied.  Add the necessary check for the error code and
return to the caller.

Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Fixes: d0aac5e48048 (Maple Tree: add new data structure)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9dc4ffff18d0..14e9ab14c1da 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5287,6 +5287,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned=
 long min,
 		}
 	}
=20
+	if (mas_is_err(mas))
+		return xa_err(mas->node);
+
 	if (unlikely(mas->offset =3D=3D MAPLE_NODE_SLOTS))
 		return -EBUSY;
=20
--=20
2.35.1
