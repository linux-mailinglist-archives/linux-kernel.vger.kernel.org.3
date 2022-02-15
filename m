Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE694B6F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiBOOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiBOOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEF7117CAF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi0eI006569;
        Tue, 15 Feb 2022 14:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3kI23FBF48DXxUl8LULalLWcjDzz3reFoqh9iBbPaXA=;
 b=NMXiCIZJsXYESNScTZjWDGDBvh4HpxR9HRqyq6pHKQo4B9FF5uu4qxRki618eLDofcow
 d1oBGY2CPLVjtcJnF7Iv6GFYjunnJL3gFIBPfXtx8T6v7/0qR9rh5RcJsX2FvGbu972f
 z5lIVT5SNBcqhJfP/Xo9nqLM//SdWw2P6/ZtoyeabZkQAdiYHG73yrLImEJYdgcXSKPD
 zWdqfB11ttG5w+nqwVDNCIEyqSo93ZO6W7ZJMN9B80f/YQdBemDtzByqxx6ljNHYYoSe
 PqZntqFPJw1Hl7/HSJj/9gX2Ne4cw4QXFjw+B4cNjaYo49HfRgMlQAvVF4NEo8oUvQUp Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hgdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8ll016243;
        Tue, 15 Feb 2022 14:44:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4MkL4/IVx0SSXzeK9zvkELqKCYfgc7zEAGLfrBUEjjMX9DWKxvVict4Sw4fKN+nZ/DYIKkX9+4s2KPoB4VqAChZ/2/UZsLxLwURoat7GJR+n00VYSNEJvpDOo9oJV3G/kN3cQqICGpaZC11BeDeWRj55+o0W11A5tFTsiCI9kXOb/thLMX7Dak6iq55uzdAv/80F9zZS1xQbd9V5nuHTlO0fL5NK5F6n2YkMrjhoDe2JFMEaGm/4TdN5bQTpNB/TeULmBc1mtnrYnx5L11oI6n2WszWt646TP79mYz7mAbVI3BttluxqoovVQFrXQhNrtK7tW86ux53MUAS11VJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kI23FBF48DXxUl8LULalLWcjDzz3reFoqh9iBbPaXA=;
 b=mgdWDRT9wW1SEtCqwcQefCpbAp+v/zSR52EHY1sb3L1xqMeu0AHPCqr8YUy+HYAbN2LidQGrkDH69rNpz6kkGbljbcMttpOfmb85bbHm03NsvGMi2x1gYyU9puDlqA1RQ4K3hYSdDpZcaa/CdXQ/SA/s0m1XQnp6UtMF7J922wSDH0LNj5qCIKlHBhyGdF6Ql7WWti32gVjC1hY1iZgerQdZCe2Ssuzpz3aC9LYkyjYwivjkWu+Zh1U830cTpzJEGyskwtPWdV0K0UwCO118UEPT1HgDR37HLThuhyREuAIbRYHHrmh6reAzu3pTgnaGCT6cfjAUfhSqRXznQxgX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kI23FBF48DXxUl8LULalLWcjDzz3reFoqh9iBbPaXA=;
 b=XCveN/WRFKBUZaEIm3Wo99gEeO4ljiw7SJK8c7oIyqJ/7aoyvAzdDS9WVdJWFg7cbQQfcfzhSnJ0fya7hyK2Zoxo/Wck4hFOofUZxrv0tJMFQx24aTKkTdVWPtMlwsBZ78tJNMUdqwI2VsWza+U08zPYu3/YxDdhGpcfOLhmdzA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 53/71] mm/gup: Use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v6 53/71] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Index: AQHYInph03ptyA/MP0K8S2bJKc/d0A==
Date:   Tue, 15 Feb 2022 14:43:22 +0000
Message-ID: <20220215144241.3812052-53-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f13384f8-b337-4d19-c869-08d9f0919a32
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863F8D7D2404CFEA6FD8E10FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9bsQhDxcm+X2GytCAHvSSxYCoRX9bc+QITaeRm1ymS8MQjJtRtoXJJHsnRtXz+pGgGfaA8w6HoiMfzso1dPJg9/WjZLqUr4WUpoHQnoXF6i/7xkdt5X2/pVa20S0Vq6fpyyIh02birmZEB34BtUDXqyWTChR9sFO0L0h8hZM8kXnGZqaJ3dznkvYI1XCPyy7+lLlExJWpPhi0WhXxOwcb67D1TqwWty8ZZUPe7/mZ2Ml0CmpINpN+vA5cBMbIcgYZ1ypiw36fSak7Kk5C3Dwj+2ncPMdwcMddAmAZgAwWLqneMw0mPrBm1wcfzJYmkU2yaPLZkzjlRdGM2JdP7z+ko/GykZKLjGz4acVn7B7/Mycg28hApyNX5G5hhss6/5mQuKVmbU+DGBGAFDyWQLaqGxgUj+3QD+s4OHGcggLgK+h22V1TKNBO9QFtKPO95L9yzBh8qxxYM5CzXdhTcvhtoLq2N97LDsqtHADYyIsdQ5QwLYHUlnhKYyi+DD+DuzYaRrC7SZczacJv7QVtQoj0RXC3dJrGRLAt75cFSIrK76v1H4XVGMao45mF3Ks0APHNjn7YWRgWn1GCNzgEYTs9NXS207pfQ1UHWqB7UKVoRnhj8TwzZKHyunBwQDwJaDcT6xZrQiHPHaQiRebaQ7k/rRhTzPL9s6/EG6HuSHXBV8tQ0tP9pKYPfBPemp0Jipkk9nHt5xKth3EMjubKT3kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?30bFbNSFlgvkt7MQh401QMJlrqCI+AYIYVeSF8/xHNTNMVK/k/KpUFkASl?=
 =?iso-8859-1?Q?Xn0jsvv5MNSsSRla5MOWIXqUUhJ88zyUYzXIss+2fLN00CX1J8xNSj/2w+?=
 =?iso-8859-1?Q?sBsmuKHy0CoHwpXrQAVVpGM8LGCDbha0+VNqyKuE9rE7r/rzuNAoacJ/K9?=
 =?iso-8859-1?Q?U5AozyuW9GjIJDr6ahouVBX5XhVH1LJH0Th6sbbycbpF+xN3yLgatBozSz?=
 =?iso-8859-1?Q?+tY4pxDM7l3nww6loYW+duu2YHne+ED6vs+53VSEhGW01X6awKNl87LLDJ?=
 =?iso-8859-1?Q?Wk88we9m+8HZm1TzqvDfpa1FjA3B0jWtb/E6fh8VYTeY0Mgh8I9G7MsIZP?=
 =?iso-8859-1?Q?oh3Mfzn+zCz0u30NRRaHaPrUxTakxxtDTF8ADa/a+GuTUINRW7aFh/7j3Z?=
 =?iso-8859-1?Q?Fg0CzNUuPofPg5InX9Jp8CVZ7XOsEc+uOUvkMAUnO22t78c9BfCLB3Gxed?=
 =?iso-8859-1?Q?mzhGdWXkRyudiK5bl0WTyLkmOFpPlGjAWR9JcbNB0M2mj+/RuicNfBcbyO?=
 =?iso-8859-1?Q?MkpLqLAmlVKp5rsM7UC6DePjFdkSbuh+xkFomBg/i8Hu7mYV2HtEj5ADAI?=
 =?iso-8859-1?Q?+OmPVnMHikgxdySQ0VTpc9ntErpPgeCa7Urt+AdTkOv/bMxKQj+qhHEeDf?=
 =?iso-8859-1?Q?OAtJCaqKHZZT6VGaMpdZ+5RM6kYtEjbDO7ImyuCa/965PCGPZfMCcdTVCL?=
 =?iso-8859-1?Q?E3cWIcxmtyp0bm4zCTH6dt8mS78NbEfmqI1zgBQcyjDEs8licrzB32lLuf?=
 =?iso-8859-1?Q?SB0X1o9OIsuj8aA77MBaTiHvMKVrmC8l9BKdwP31bB2xGgX97MVIYcEX4/?=
 =?iso-8859-1?Q?gBPEPRQCtb7NEguP+wRZJZlkO6t88DEDQ2Hv7DHiY/ZTL3tpKKEq+F27Qb?=
 =?iso-8859-1?Q?yAivequyf3L5AMwDXonb83O61IbrW3rA8ch6Uxk7rFE/C17FaaMUsdtJVO?=
 =?iso-8859-1?Q?LJFecZz8cWC3ZXYsChJq+HEsPjAEuHCmOuMc1sorwX7nYBovtQ3LT5MlN3?=
 =?iso-8859-1?Q?vJwrykdf0ri9uqMJ9B3hacFXktfl7ldLI8Rz6SZYIr47IuAgk0eFis1iuC?=
 =?iso-8859-1?Q?5MTDkwiXkEuMB8nL9+p7DiVjcK37qdBoUtob1I9urpf8klfAghXPxZRhiK?=
 =?iso-8859-1?Q?Dz323TRAhp1NK1TnTQnhvjgvT+X+qptE3P2UgkoD/TdPW+mkDUESy6JGIh?=
 =?iso-8859-1?Q?2FoI4KNZDHlL3oSV9ITm6/wedcTQijTfHe4aHAYkoBiV4UuRs6vAzU5clm?=
 =?iso-8859-1?Q?+4nQNVbI2l0fnmr4N7pYModp3hi2iwigPK6X6yMIXD9SapmpCgb4LDmVj7?=
 =?iso-8859-1?Q?aLf9sbU5MLKi/gYtQJezbJlGiJMH7oUQDLQuSNQ45SNkmO4LsuLZyedAUJ?=
 =?iso-8859-1?Q?UQnoOXGMF+wfqTHtJl66vtR8MhoLf6r+1KpTF9qM1EvE6id3owP0HtlMm0?=
 =?iso-8859-1?Q?MH3QtxwdFGwbVFOKyLNfb/5euDSwGbDxwyw5dDc918h0xg7Kd3/HZpwl1R?=
 =?iso-8859-1?Q?+k8rFDusgQh8o7HXq298aDaBZQKmxrNtxMe/IqI1+8nbE928R8GId1Cg0x?=
 =?iso-8859-1?Q?fpdAz3unFWB5Y/OPByng49RlXw0LayJ0anVZjHryKG8Y1qVnrhluGKNDhq?=
 =?iso-8859-1?Q?woeqCAd0/6tYFGSuMzoK4sgIkeZEFU7hHZb4ieV+HDcsUJJjTSAdDGenEf?=
 =?iso-8859-1?Q?fV1Ogu2gjgIwsQXEyA8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13384f8-b337-4d19-c869-08d9f0919a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:23.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JRSr730feHKGb6QRjmwfqcDL+tswaD0XLMaxZEP4w6SjNNxiAW/UyeFERYcZjv3x8ENDkaPwXyriYYTFJ8wkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: PEUYsX39xwjYn_ST05YsiIxAWm7EDpeH
X-Proofpoint-GUID: PEUYsX39xwjYn_ST05YsiIxAWm7EDpeH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use find_vma_intersection() to locate the VMAs in __mm_populate()
instead of using find_vma() and the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a9d4d724aef7..2d12b423fea6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1609,10 +1609,11 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, nstart, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma_intersection(mm, vma->vm_end, end);
+
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.34.1
