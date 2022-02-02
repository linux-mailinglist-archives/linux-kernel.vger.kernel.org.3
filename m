Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1880C4A6A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbiBBCpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53204 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244286AbiBBCnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:12 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Gv7b026579;
        Wed, 2 Feb 2022 02:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8BLGJ+Tp1J+V1NbouB9v/NqM6O9FhagKFkk1bKDFvdg=;
 b=QXGuq7+AoGbkDXDStnwMdpSReGqsAsTuiQr2ZHcx9bMbsKigecRfYbNJbTP3aUj/Sef4
 GoxVDpWUbdnhlExXEhNgyDNilXRR7FjW7HClNv2b3B9TM2mE6BLGwrqLQpqo4ngf8uwr
 o+1konIq/Zn2CTFJ5NMrdiLdglZbDk0q501njPZi6op7nWbAp/G1sD7K2+YzjH0HSbnJ
 LNPpdPuFH0kDu3jX2rgQASTgVwvgWv9tAWH4kaY+AkEi0drspeVpS05cun5gvoFa63gZ
 rc2nl5/uGTZr1Xs+6tGgvBQIyj3i/3AyRqL47Hf0GfBS8Bymw0lDnk1oLevv3Zp1ypu7 Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvWm015147;
        Wed, 2 Feb 2022 02:42:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 3dvumgguct-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9wfTzlieEby/XgxC52w+82J9AOH0ygWlrygugaXTGyYJ7z7nhLgZPkzWT1hwS30GwFoea0e+WD7i1V48+kpeS77pejKnhNDHilmEmdwCS/JImege7YmE5W5T8v7QE2DXIJ6cZO1HQ0gLK22E/pJsJIAFthNSpD3SJcAojd5SdKyNLZ+WbG/E/DHS1Z9HW8PCVke/S6mxNp+o8fuqAArqQgWD8mr1TD7MxTMHrW4c/qKloHrYZWwNe8TraTLw9oZCFE9Kqi2+ejv39zMo4Ca0c6pFgr7+ElZ8lR0pEObspfmbkhzoDTyL7W+7j+S7ntEesCcu0g7hCswo2pTfLRwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BLGJ+Tp1J+V1NbouB9v/NqM6O9FhagKFkk1bKDFvdg=;
 b=NLguKXPNKjJSoQMyOkK1BfBWB3HZF41HZ5soKPS559aIFDl21veR7972dco+/txzMJbDCzdQgc6HRCRdAYCrVotdtiRNpw8XXravePNcrc4YB1Pey1OURt+YKfCkOTuUviIJedML+VKy4dP3b9eVLs6dh1y5y7PTnsIJgJqnEl5HI+O8WTKHjGAS970VzG49yuSaS2wcC945WXxwoEG0ajtt8PtmvSD7uaKwch+CUcwkZLUSKl6eQuLZeN00o/m4jPGFu7+QYQnHyt4HiEDpYDXgf73rvm22QkPyvcixhdpiipn+o65eOOQI33zav+SQwZAx5OBQda953CSGmmHxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BLGJ+Tp1J+V1NbouB9v/NqM6O9FhagKFkk1bKDFvdg=;
 b=eIXFK8nddbfyVDDyji+LnkCuIgUv531VZ882Q3wfRp+mBiLrJuLGNobd4fTCjnDzTrFabnOKZ/lABD/ynx+5W5WCL6eMYf3ybfyGdhfdy2ZzSsLIvlJHHnc6mFDy6XvBsEgi+gfZLjKB4voFOKCuKnn7SN3LY+Uqq3jQIYjQUdk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 56/70] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Topic: [PATCH v5 56/70] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Index: AQHYF96A667H8niQLkORBWpRBEqUjg==
Date:   Wed, 2 Feb 2022 02:42:21 +0000
Message-ID: <20220202024137.2516438-57-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14601098-fab1-4010-5999-08d9e5f5b840
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB58651A4BEE78EE2115E6F427FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFz3UD8iQZQ3zHpY0vGsNO196LrGN3AV9OrRMVjNqLqHcyZTVDAf6u1Hq60wJBOHpNjPfSgZCyvW5OgoAeLElbigvHhTomA6kND/1kpm3zcB7ZllxiqDogCIpE0OU3mNlh0FxsBrOZY30hmU98UyW923HmHrgoaSJnyWjeC5pTR3VTQQoXN/znG4UbTOh1m+mz35owrmB9MGDV6KQOoePZv7WAQIYmktYWbzKcRd8DZgSNn7K+G7RGyXbyfFqDrgyG9ES2CFSKPBk5v/dxSGJGF0i6n/pMMsNOhXkPice7aa/l3lmJFBtPJeP6k44mjjiWLfqWBbj0oF30ug1q6N6+o8JgK3hfUqqMMzeHm2TP19mfJQgSDFLWJfDeJaIIXDPYbA/if3HGXg9oREMEqpaS49XW2zP1gyKy2n3wxZ6bTF+6SNsC0nmen1z85qrHr+32Pca84pKC5lqZX7w9gza+s8chzvu4q6bNMGqob0xJJP4bRvZ1wpFGX5143wgSrS297HT3TT5AfDHGBRneqPsEezl8kTl+SGdfVe8o78dKS6oDo91i3tF8fXHRn0aLyOORjaBOTVYP2HRSwdxE+BfWqrSYmmbsY7GOPuoMicCHPN7Va3PHSH/Htf4gwoYxd61Q1i/eVyL90PoIAGqPVdT08lTmUrPLS3DERJVL5JkXPJGFewTs+4JtS2Z3sFCfLFoFJFPGRVy7cURVwLKjDKMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HyTx8qSjIYOHM9Hvp2W3dVT7F/AsJJSUGweS+hxhntsVCmKc+ZEVne56FG?=
 =?iso-8859-1?Q?CUudgcfWrLEbjhGGMfnGo+t/eCP+fL70KGNhS5kNu7YEuFvTr3aqcTe9rq?=
 =?iso-8859-1?Q?UPhfdPy6W+h+z+Yvhi/8PfyKAIVC8rYDLKMkYcx+MrlVoJbBrf5CTPQgnp?=
 =?iso-8859-1?Q?pSvYB+kLvntUr+Obyq9/KlWVTgNg6V74CCQKpB6HkhH8yw21+P62FQlOps?=
 =?iso-8859-1?Q?li5zmkynNyFSBL0XiU9WwAz3ehFken8a8yCUanHRwIbcgq6/q9bQDrZNRJ?=
 =?iso-8859-1?Q?dy9B0v0WwwA2rEKJrpZAldZpNQeSCbZ2I+M3EcUgKkusa1eyhyIvNuBCBR?=
 =?iso-8859-1?Q?bSK58SqCABKL+heJTY8jZCpAlA7UGdyPNvbRzbrnr+FLVRieJf1omyNazd?=
 =?iso-8859-1?Q?j5YsWJOgl0nv/8CcwhnWmcbMSPgr833dGdv3RJcYHosubGx9vo4ik4UEIl?=
 =?iso-8859-1?Q?8qCF4DL153t8mGaV27ctnfkgOtGpIxcJiGtqKNfgFZPYyn92g85w9ZdEUh?=
 =?iso-8859-1?Q?XMKryOFs0c/MyCXwKv5f/pGJyuFllJkGbyKwSZ9JbTRz9qlb7FkpCGphNa?=
 =?iso-8859-1?Q?wNj9uCCbKGCgpcz+MTBzUGo9K6JrGiFWkhpbZnPBY0wsNjLdf9FCIjFaCH?=
 =?iso-8859-1?Q?GrbKxcxq6idwSm29E91rmpXbyi9LPV5CjMeEhBTzW8LS4GGNf8E5erEv7d?=
 =?iso-8859-1?Q?pylfbSAeQIeltwgtaVeYMy2i/5we6ErWM3uPeqKFXdGSrU+GfSOzXAlNi7?=
 =?iso-8859-1?Q?418wYyCbsO9Vk+WBq206PiNKGFLxElbIB1sfoLfSETCWqNuYGxq+v2cPF6?=
 =?iso-8859-1?Q?bDRrpO7YwIqOpeVoREHQeYy+/MCgusV0y4CxswPJ3jOt+YnmRN2tnbRb/H?=
 =?iso-8859-1?Q?82dk5CikOrlTUM5ftMYIOvzPFoy4HpTQCxOYUdsG7vfPlwHls4CSE2IQ2t?=
 =?iso-8859-1?Q?sGFgwnM7T+Nq20vTFBd4zQM+WdbL0yDB3MqBwN7Xn24fqFXn6C46bV3Io8?=
 =?iso-8859-1?Q?cutxtQbWM2ohnEUN9fQTpDb8kOiam0J8mw2+hEcJcefd+QLT9bNsW7czfL?=
 =?iso-8859-1?Q?DvZRoxxsawzF+i+47nbB5DhH5z2kHpw+cIvTJcwFjJTrP5jRrGXX/iR8Z4?=
 =?iso-8859-1?Q?lX0YmVU3iGaQTzoEZb4kxztkV17VF6Veumh4BFBMJvqY5OQoGUpsHrH6M6?=
 =?iso-8859-1?Q?xrqwzwm69SpoVVytUQguNzK3OnP6l1eMXyzQNSNuyf2wwInd5QaYvITJif?=
 =?iso-8859-1?Q?4Tyh6aEH9uKacqavqutT8SZifHUlnZ5OdR+p4gKbDNsRM+UGiSEituxRnS?=
 =?iso-8859-1?Q?fyYkq7F//xIf7NZS7T08NTlzropFJTfJv223b5GmicJy/g+T8XuyWyJMtM?=
 =?iso-8859-1?Q?w6d6RFznJis4ug7rrcSso0lFKx58h7iNW3RXsfuIDvXZxCxhrvy2JF2pvD?=
 =?iso-8859-1?Q?qt6l05ypZO+pQH5IzEPGrVRT4qrmvGXfVUsteGQWAFQIDCtNPFh1O8NpX1?=
 =?iso-8859-1?Q?muxCc0yQON9kPrSyuE6uSoavxng1sjJNaC0+l7xWSgpGJCFMUkPc9XBkUT?=
 =?iso-8859-1?Q?FZoBFu/e8Bj9Fpq91nBg9foS0dQLobt1haLI1cIPWKUleSPhbt3pIy/qci?=
 =?iso-8859-1?Q?6wk1swlkgGqDQCRcbcuRkHzva6CMHNuIrWU3HvmH6WQ6t281XG/LVgyFc/?=
 =?iso-8859-1?Q?H8st53+2HO0XP+C2Mfs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14601098-fab1-4010-5999-08d9e5f5b840
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:21.4226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsqfC5efS2lI1ShFm+KqCAGPeaZZKQIMZQbkr4R7BA0U0yhEckRQpbwJoq63cNkI2Kkn4B0onuSL4ag4sU2fXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: p1igcOn8we-YQzhS6egrf6sf-hBpDvUs
X-Proofpoint-GUID: p1igcOn8we-YQzhS6egrf6sf-hBpDvUs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Pass through ULONG_MAX instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..f882621ad940 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5827,7 +5827,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6125,9 +6125,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.34.1
