Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792534A6A39
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbiBBCpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43774 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244269AbiBBCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:11 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HxZS026594;
        Wed, 2 Feb 2022 02:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u1uTD7m2ho3+PhwzpXorIpcL8L9LrCQz0IUQi/81Vy4=;
 b=PUsWIceGISEsPeCdBfRD0J+RUAP9eZG6LOd/ROxmv0ZwmHZAKZnj9RRYfY0WTxLEQg27
 UwvVtUjxIJ+NcHF2/mEQLThQ6EVqWUE2PM2RHoCysHSsXOnJ43Jy7tfTL+qw67UlUVh4
 2iD5cL55QArcUh7/nK7+gityAw759bRFyLvlIpiAA7uPlb1o9L1AvxvcijCRR4UYM6AI
 ZZAepx5VtjvHmbWppduJBNNPhFzQlCgcjeWaCG+uk8f6/+O1bIN2YkzK2qXPkF7ZiIWi
 FFX7EfPqieFByUwIwzl+yeswAfVdzqwZolUzxdoyQ/8b+dKNmyIKDGDcCh0QbpjnmMX4 EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZsuC007633;
        Wed, 2 Feb 2022 02:42:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3dvy1r8aet-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQKZUC4qWnyqLMurimu/5M8XrVMZKp2aNipCklH/VD5I4GkyEd+doaR5huOHret806xP1kDmMJ3pWov6xIWrI90EEqUFlzkq/wrubeqfq/90gqEIXIf4q47DoZlRS7EzabxyDaWyM2IBqULVbSvxV8b2pt6E+j2gVFRMbapblbW2435apPpT+QKY3EI89z1dgv/fAB/P6KYpG1PsdzfKCtZqNEy4qOFqmQg5XrvaaF3i5Qqf8AFTZC5KiRuuTLIVwanmu1xWj7Y/52UdJMa3G0jdL8biIxQBzelOObJ33pc90YxN1BUeR7seBwAotJLGNa99xJKrm2ePCXd9LJnszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1uTD7m2ho3+PhwzpXorIpcL8L9LrCQz0IUQi/81Vy4=;
 b=LdDMkCK+lAQg9bgqJeeUSf5XGJ2ICyewrK0qPpRMDxmdHhF8obSBFblUy4eRJTj/zrQhsII+qEn6fA0Ebq6pqpq3PxIuodItlt05Uqxv/bVb7yzBnC9f1zqfZuxSfjtSah7yehlsW+PBz/dubLUBvGYpomBtVMPZ0hnNWmqN69k6xDXDvqSeWiYiMgXxaR2LqtXz1ExL4mXy5ieSUq/4oiaG+PqVsxEGmsfSTDnstzkcLCY9tC11TgibitYaiIgbqiHYDeF2FwKXdmMYx/ZlBdyyUY057WJOHfLteussjlrbCieJkGFgYuDUMIJmpVlaTM6oXYpMDGVmWcZxeaxZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1uTD7m2ho3+PhwzpXorIpcL8L9LrCQz0IUQi/81Vy4=;
 b=IYKTaZ1BAvdmdNeBSMJy7E/LxxsgXKhtCnQzKqsYYi17jH6dCJvBxDpDA3AV46r0tjg6odDhl355reHas2pSOYpPwWerF5qkFejEiriG8VGgHV/80EDqtVlhmk910Pxc9iMUDB+mftxPeT3QkJFVgFU9LY7SCn251uvvpCSIGGc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:42:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 48/70] perf: Use VMA iterator
Thread-Topic: [PATCH v5 48/70] perf: Use VMA iterator
Thread-Index: AQHYF95+HQo6BRYZ5Eq8WGQ7CvOYog==
Date:   Wed, 2 Feb 2022 02:42:18 +0000
Message-ID: <20220202024137.2516438-49-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 180220e3-e696-4c1a-b292-08d9e5f5b66a
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB480151E477DFE86BAE2AA008FD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y38zVoTsgtmgns6d4WD5Dv1lveff7vWpq8jbcrDHFA77i4MzeFxICBeU7bdjY5AUzxMf6QbiwHdLKuea/ebsyIIjhYKGJDOUvwSftDTcwiuAYWp2MpG6iQY9Z71cG5X4sTQLqtdJcdzFmnJetOYux4Ay9VdtRQkBO/d3TjA30+zPtDcUk0rBbpyZXdyUFMXUNX2HF6jkNwdpqqhm9n1k4sAAEVYQXo7U77syA3QmGT3A+JUj5dUUnBuPdKhsrnTae+qIqsEQb/xAerY9G0oWbDdPQcvHLFxpAsycgLT3PKHYzsQRelxOaR+dgEk62NaZdrQPIp/+Bk2qSfbhTwhIqJ/zFBtIWx4EzghEW++Ixp+MJB2cgtudX4nniDjWlWQmduGGkEnu0vpdoFr7GcwblP7CrzwwsxH2oM5yAr72jClE8pDaAt7fx61iXYT9iB0I4zNjjFjSjBiezXlwTJoCce/4iT01zuCc1IrtRsiWS0QaPryzsuudwCejtoLKmUDzz8WLusnJkYU1gm6+JsWuwa5CE7cEkAvU8aChQ+Q46Mg0GBk7kpndjwxhTY4w8jtmqnJN7P+gP/81fKhEBIdh5a3hz0MZodEqQNoplVLdqipMO+X4e/KlA/dZ8UyxOYsaZS/gsZmRU7840tocKnh5W7B/4JhrVHBssNyGy8ZwaDMILDQrO/t1tcbb9L2p7Qk2CmidCRfupFaPvqTdYrGx8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pi8S/xJkmS2e4vcJs5ibkemesGYQBHs67UIwn6hIZYvQNNRoYNaB0TVj8c?=
 =?iso-8859-1?Q?bnrwGsDDbMeu5l8rM5RESpNzSgZnQPzhbGL/+Tdd931WBr6PerEZG0lW6/?=
 =?iso-8859-1?Q?HKNLeNZNwm9l8CSgQIMBxZ487SaEa6UKY6ivqUASh1JMOGBrdy13PrOhRZ?=
 =?iso-8859-1?Q?cBNzKNLcUY9Wid3WJpID/Jqh9JBvg1VMm+GKROqdgRcPg1zZmtg2JBefMs?=
 =?iso-8859-1?Q?j+G3BOQxYo35CbTWa6KlDa4aogV/jcrvFms8AzCHlwk6d8xC2Iga+Mn4VH?=
 =?iso-8859-1?Q?EjZawq3S1X/nagcRyfmkIXzfpeotQryeel5yXjeTrDVO+pNVAaAHN70naG?=
 =?iso-8859-1?Q?IjOyT6eMrFWsuJCBfUGO8P2NECXrBDMOJCtji2GDmSjXhlZrIKOjS/1wI8?=
 =?iso-8859-1?Q?EGsbxJe2wqIZopELRI0jM4vTtkcdivYtdmWYe8RrxcB6DoHo2NDwSsU43i?=
 =?iso-8859-1?Q?yyoT4ZN7TQgURJii0oA3PzkpXr0S+/78+vpYy4eFugQNU4A7hKgmkqK67A?=
 =?iso-8859-1?Q?0BxpqrblZk08ctdnE6cBntm3/GYnxkZ8QZNofkY4VPy4sVj19ojmg09Mht?=
 =?iso-8859-1?Q?c4qcS7EWtiTvyNR9v+XLQLKttBCIHRBBoy5zgXEaiR8hKtsgnBm4aXx98i?=
 =?iso-8859-1?Q?5N7/3WlFGjo3I4TSdCLJH4ZX/UFlnHISbiJLkmRDePzuCLDNXE2VRM+ASa?=
 =?iso-8859-1?Q?36gXRggIXh0CaejfKDwBXiokjTUVBfbKgt3kl0ABXyZTN/+hCO64/SoKq4?=
 =?iso-8859-1?Q?qsZwX68NI2IGS3m6po1eI8f+iFhlL/BzgbLy2RdD9ZkUczq7arebnnoiTq?=
 =?iso-8859-1?Q?6y3TH/3pVr8THsXpGEBEN+BZW4/KbYPXFwaM32SBgcNchk75pdHWK98Eq7?=
 =?iso-8859-1?Q?BKJG1+0tfqiO580dZZOf3GS0IOhiZSZVXQ2Tk8p/+O6kkik17Z2JTtRF2y?=
 =?iso-8859-1?Q?r6msGTSlD0Thw/mNRka8urIMsEpL07zLcfmHlXDJTX2eBSq5KYTd37zVSM?=
 =?iso-8859-1?Q?TGht7/8Jk+5FDUN+vDZno0Y3hox1hAmkOKzLJ/Pi4xomW5mDBx7ChuOhkw?=
 =?iso-8859-1?Q?QJQxke9YOZXVq776usz7NYcudP0TG/y9x88qlwEp2+1nTB+Q6cbZCcpJsE?=
 =?iso-8859-1?Q?hwHsiq/gsdP6Ytoql3P/LgkS/Vm4AbftSqadqeSqghGaFVE5Rmp13VhOg7?=
 =?iso-8859-1?Q?ZEsoJVL5gVMa5CRlMzYVCpEKwux8e8bIvABcXHaQ7cuYjio8s7apEIPCXl?=
 =?iso-8859-1?Q?a+1gVA4SS6i69ppyG+39VFCPx7XF5AxgjpyxrXAnYuQQ76Plb00eBgnu8O?=
 =?iso-8859-1?Q?l5XoFAeTdu/pfH+6V/FzljcOpbPcNeb1ZA7KPliuiJ8+8LanvAadAftpn/?=
 =?iso-8859-1?Q?9JxW8DnjCD/tnTUu7T3FHxh8aE3Ht+6JEjrlJtzTq2hw0UYTvmrlbpA8bW?=
 =?iso-8859-1?Q?6nT3aKKeNzAgmUq9Ue+uqcZ+5C7e5JRNg/h1Szwj81LgAEHpq0v+91eB2W?=
 =?iso-8859-1?Q?Mw7hKrJJZvU6EEHINMBP8/dakCmFRI0dLLzw6QMPyF78qspSe+Km3nskHr?=
 =?iso-8859-1?Q?d95PNYJRLIMbNAMZiFShEYPCLAne5DbpniZKZQg4g9i/MyZAx8YXzInn0v?=
 =?iso-8859-1?Q?zXCXDVFHXU5ZYVCoKN/UUxQpHBWs8S4kAGnmZksJyyEUBpLGhidP6FYaO0?=
 =?iso-8859-1?Q?ZsUmvCtRrra1aGFHd3g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180220e3-e696-4c1a-b292-08d9e5f5b66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:18.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svfRVXBtsa9pHuO3jyZsZnqxd0XkO17pdZLAExNRsxflwrDdSO5F60xM+ZQpQT3TG7KZFOpITZ9uWJEuZPFQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: TSoRXCfjwSjmkCORUncE8M5SeY0YR4IJ
X-Proofpoint-GUID: TSoRXCfjwSjmkCORUncE8M5SeY0YR4IJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 76c754e45d01..e4fca262afa3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10303,8 +10303,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..5dee6c41f36d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -356,9 +356,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1237,11 +1238,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1989,9 +1991,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.34.1
