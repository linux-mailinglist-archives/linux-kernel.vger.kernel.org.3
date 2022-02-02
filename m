Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6654A6A20
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244500AbiBBCn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8448 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244024AbiBBCmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:31 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Gv7T026579;
        Wed, 2 Feb 2022 02:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LoBjNyQQCSfaqMQPcqQD1MBkRdMkS+I+bAbIczSM42s=;
 b=IIsQY/N1OIWvCp4NgKAivf4PgBnABR0usyzqmAKrcF9p4m3zEloAbz7jSKb4i3j8OvQO
 XWzAQNL6AaApXwmdpYugGTt1zxOCTNMByjGaOShY7MoUPjPYp4aTrt4uJ+KPYD0hi1op
 85q8VKRnBcvL+v+r2c3Czn4JyRJjoyYKNv8h2NZEHwIy6W3B3TKy4WdvpG9LemaWF6jq
 W+RMtIeNPVmZMt3cDTA0jWlUaPhNsfENxBrRvt3dvygNxMkjC/W/HG0TcUioeZi1LYI0
 hR2PgGniycoY9115oejnLZJoe36IXNzZgVTDlhh0GZQvXy07onmj5t0TGvuGXHVSVGRN fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSH126532;
        Wed, 2 Feb 2022 02:42:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4JVgm+I5337hmn2Kr3RfVMvixsBShGp5ZCYa2l8EgiMj3DHwTFZhoGxALGB+yx6YP9XgN2J8c80dde5s8XMBI4ussctD+JfR2Afs7bywSorl6DlkuBGFix3yYGjkSVfnEBHVqz0TYf5NOJa4/rJOUD0A6LGgCsJG2JYvOCgxP7hiZl8Tin+99cwK0O5mwyuZ4C/IO0YzHRJyCLAHxo7Rwd8Gm4lGkShSZO2cb7009W/FuJXCfoL+6YkwCVTsRJlkE7+zN7GiJLoiq8aVLJYtfQqc6d/CAQBpZ/AaCunKc/YblFv2IQLEp58dZvuNKe8EhkA9YUvfX15+hm78CQsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoBjNyQQCSfaqMQPcqQD1MBkRdMkS+I+bAbIczSM42s=;
 b=KJP60giJw99ZZa9cN8RBJ5K5WwY2I+VUbvM04fBMkXsCZ68JXFXtYxXOoCrDekj+RguLk7cRC5kvp86V90//Jj3TacEllWKiF6hUSXCovHn39STe4DPsTQwl4ammkNze95dqcDAAoPoDvU/+KgRmWp2tFGR30R4s0RK+jkArYXcRB1KTmsNCpiaWh8p1S/cWgKeDdqcjE0tahbPC2/9L38/W4k8jby4xP+MCyui5EVW5+pGxTSd1gZrcOPFjX7/IhKzrNS09KZnI+uuKaMxE8XfRAgBOFfEHXgvFYFtlfd5dD6iKqmwInuwSmUXu4qw31bwhXC2Av/vl6RT5XEEvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoBjNyQQCSfaqMQPcqQD1MBkRdMkS+I+bAbIczSM42s=;
 b=YrxMGHN0uHhJ/W4fpCSH9DAOKpJMs+P6DqNFz6L1Dbum3FR8CmRajacpj3mtw0lOTPonYCWbd1Upz0jt1q2ksCNR3EmqsmJiw049tksqs9Vj/AKM1b375QPz3UBD/1eD7wmxjD4zySuXmA9SR/uEvFcU56UgrojKLO46dXi7Qhg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 22/70] mm/khugepaged: Optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH v5 22/70] mm/khugepaged: Optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYF953kq1YNrY+6ke1p6yd/nldXw==
Date:   Wed, 2 Feb 2022 02:42:06 +0000
Message-ID: <20220202024137.2516438-23-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 873a2e04-a3e1-4298-7fc3-08d9e5f59c6a
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129E49543EA4166DAF5B8FEFD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNysBAziDAy2L+7do+W8yLTUoTUWDJBtA/hg//kOcot1Uaze8KHPOz0Ga7g9HgRpmweXOBCm3Vq3AqppYYpZcyU76CpmGD3e4OJ8/hArhrxvoP6fOkDhKMPPnD0Z1B+DFQab1nBxhj0Pcz/X14EuSTNbwJh4vAxQ8b/mPzqmRjjJ8fPgRZSVZFu7qtaqshICsU9icZXQTxKuYSjwSEHgsE+yWrfu6Q2DicUN5OjBI4bKbUCzUUSOiGXmwxgFbyTZVc+43kJWX8O7+gX1tFQ7RKsBnHE5K8DhxyD0ESbAON6sDZvb4UnQm5DJuC1roNy//TFYdFZ8YmSghJ7A5rjvGmm6moxLqQGQxGuzlplV6zLKjR2Rg371JkHnIWXINTxrwsqDm6G6iv40r+Yl/MkSeFoy92tHYzfQyP+CvRNv2dquTNLXa/ilCVHf33B6kGXbu68kGloXocHKZXLANi3BZAHUnih8K4OicXdbTf3ONdf7AxpomBuA/BxnCDMGVUPnk7KaGTHLePUlT1vT4FMzqodU/oaCmg0KXDSGgf8aZzTFPo/bzUfbfnKnvo4cjzolhje0TuGAVaxd3jheKNTszD7f0rviYaug/stRUqSl6RLJGXEbrtGSCeQGroo3G1ObzJ+Me6zhuZDvXOB+jW/bMP1HfDsU96KdNdaOwEi4RjpK6wibMd9YVvAn+cigbdrWSQUs5zopNTWDvOHX3XdpTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(4744005)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(6666004)(508600001)(6512007)(71200400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tqjtKl30p+k0e4yqxByfJ7Aj+uNLlC1rIAlwj/SYLHfzlFJLwDM2M4zX4H?=
 =?iso-8859-1?Q?rYQDSAp0zBHBtAeH/t2zan5vykXt/2w7IdsbXiGLv5N9wL7LLZKRowmgnb?=
 =?iso-8859-1?Q?Y2j1L+GzO/yQLFvN2AvKXcgoHNj73n0sf2GQr292ge4DnInIci66837K6n?=
 =?iso-8859-1?Q?LJBRk3v8XBVvG2eMw7fYx3tPhBJ/vYif15WVR+KuGfT0kZ8ja0JvXdN7ux?=
 =?iso-8859-1?Q?LERcEvWnvzAtM/KXfZGw7aoF+hts2tHsb4pI+0CqPQJfRjBLUYzjjkB9ko?=
 =?iso-8859-1?Q?LsE7lYK10wZkxCQfYBU3v+dAUdA1RKLYKxjtVkt2q2EdN+dDXdCsdbJ/sF?=
 =?iso-8859-1?Q?nhHoOysH5fwEVEWXait//GlutjMXBQOnQS25MOlXrtGI9o1SwfYuOTmCuG?=
 =?iso-8859-1?Q?9m8LNMc1i/ta8Qb3s6YmZOsFFpLU/nbBU9hfIl3iyIKsa4Vw9lfYDR4Kc7?=
 =?iso-8859-1?Q?QboMznwvD7gIQCvvVym6ppn2P7ezGjmvTUzzHLmBjrpxR/uljL79Jtw7xu?=
 =?iso-8859-1?Q?bELyoU5H530kZdYGvsGsDxDkg1wxwMcCqPMTtGZxn1GTQ1X6m53kCS91BL?=
 =?iso-8859-1?Q?77AspUXbjG/YHxIjtgYQLQU3Q+9AwmrRUvOppdpUZeqUurwR+VazUCffZu?=
 =?iso-8859-1?Q?r3GDHT2K53mZ9oHr0iPKeXuArFC3t5JjGy7WLF5jOUU2UsZbYqWsrbWquZ?=
 =?iso-8859-1?Q?jUpCj/0Jp/jSiiutey9z7cUYMJ5V6O4sxjjNaqw44DW/VwiHDZAZVGGixj?=
 =?iso-8859-1?Q?g5wXvawC6+JAJFTF30uxYdom/AUkpQzxfCU3mMC4rOI5SwJxUDGO+g39vZ?=
 =?iso-8859-1?Q?SvEoabuUNYQoQ6Eo0pgcd/gkjraI1GroqEWJcRxjIN2cmEgWjxcw7VZwBk?=
 =?iso-8859-1?Q?s1v/L/AydWVlnG9BFSZnPoN2QH8hh+7jvwUqTyqweTV8K0vwLEAmZ8Q0YH?=
 =?iso-8859-1?Q?1JYzt+3UwsPSAosq0uKWIacRQtyz6T+niYYoLOMmWuiQMRr0YZrGNs+1pm?=
 =?iso-8859-1?Q?hINoJ4QymmQCJVbospdGpa2Dmf4OfDpLRX6K80Xhz/4VbXw7hUEkRFrVFT?=
 =?iso-8859-1?Q?o6LD+k/V2QGLy3c+d+GZZPBb/txDP2Ch2fejrAT3yOVFgaoMKoqamO9jUw?=
 =?iso-8859-1?Q?02/cbokGabItXENpun5M2LiObmezb2cA9OerDkaLIAHIHldqFdEPpUOMrI?=
 =?iso-8859-1?Q?fC8/KpSri+Wx2OUWHoyw7lfkTkoyQC/CHU4CDIucyGSAwxpQSeX/1MxCWL?=
 =?iso-8859-1?Q?C33AUjHCRixc3yIepA8TwYHKXBSNg+9pIiy0z5Zz47zLOyM8FrKOHv1KNl?=
 =?iso-8859-1?Q?8Q+hGvC6z9v7Zr+1YAdFN1/WRgj5+RQkzdyMM9W+gMK/nm1mt8QWLCxYym?=
 =?iso-8859-1?Q?4ZWiN2/Z2dpOvNPthXOeIEVOn+ooAyL17/ELjzNADwbiN35/dyVtjQGuO5?=
 =?iso-8859-1?Q?OD+yXCnkXZCXDJ667xLFH1+BpEBOR79Nuv8ZzFPNnsPRtq1AXPfukJ42cN?=
 =?iso-8859-1?Q?LbedR7mYJojtn4RCEz3zg0Fzj0j/4ntw+OZ49Jo3iaPILj7ohaaI8hPlZG?=
 =?iso-8859-1?Q?TtQLBzjAdUmR2NT8m0k21CpSGtrBLJnkVr0NwR7eqspBqfHOOxLrxF3bqa?=
 =?iso-8859-1?Q?lV6LfQ8Sdt+rS3pFG1XS7fsONJ1KF50D32vy1sdAFvjVIzw7srh1nk6lLK?=
 =?iso-8859-1?Q?SOuUvUjVYORJQpy91bw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873a2e04-a3e1-4298-7fc3-08d9e5f59c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:06.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxM/Q2asnLEXpu/Oa6sq8uadRfQfnomOYwb4pnqnYgefvR4dbFThpzxyR2/Z8XRZUg62vQrQBm7sc/yZ0KMfKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=935
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: e4lc4NO6xt0Vur0UjSmtZurcQXD5vbmg
X-Proofpoint-GUID: e4lc4NO6xt0Vur0UjSmtZurcQXD5vbmg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() will walk the vma tree once and not continue to look for
the next vma.  Since the exact vma is checked below, this is a more
optimal way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 35f14d0a00a6..c4c4107bb767 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1430,7 +1430,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_st=
ruct *mm,
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, _pmd;
--=20
2.34.1
