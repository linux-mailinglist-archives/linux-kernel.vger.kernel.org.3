Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93564A6A3F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbiBBCqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56352 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244300AbiBBCnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:15 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120QIZk015788;
        Wed, 2 Feb 2022 02:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=O7BSzySXJnuqhnCjEJRw4aMM0v6CTr9bSGwyW7wflmYuAW8hhMJAhyQWS+iXdzmMq27K
 +YsSb3wruoY40TW3FInTg8paiJNk+Qt/mHubByeTFxLWX4vlKvK2L49WJGpw69lM8ymK
 dcLpvWMDnn5cNCbpwBs1i0qo2FnPIgW22r/Kpl4f9EVsj+Kcc+pCPpElQFyrBuHAc6MF
 LGTX3hwU0KUOmBoXbmjKEobho+oYxSmlHOYzgS+CDxgmC6G35hwvUAzo3awjDSaOIrRn
 9lj9hM2pr5eQ2OXsz1YIOYThL+jNWKS1sqVakdz9fndhXuVEWHNhQi9nxwueVOwuCJLB vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvWi015147;
        Wed, 2 Feb 2022 02:42:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 3dvumgguct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W47BtTdndUGCGQdJUDriq6/zTn/ToiLbXBdlTuH1MoLAbV+zZbxbp+o1Ub5gavREi6IqLdW1C9uwpg+mT0ujHCfG9x+OK3N9+fCwCWEEHTXiuwdFDcnHF4HlD7VQtXkH8iX1//uPbodEsKzithfbB/wCLrWbqd9nVbUoMJna2cjPPK0JHiflKirxgS4WDbTDg35Q9vFLDfDHNuabq9v8tcfVArlu4R+mZJIWrhQwItlf2C9Z+kbsbZOM7z6nFV8fIFzpBlituqCZs9iOkG2+XyA/ARiFj2+XMk0nenCt6fIiu41oCJQKNGlhkehAZN1W2O5hxweggoRmrwDb85l0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=c4xBbtNDUENu6zLUx0f4scKLDA4G3qNMjpuUEhGH1HLN4L5/yCyluiO5aQKhDbQAsl8ETXNW2QBxlkZxV2618RW9+hFahJS9/V3IQSM2eq44xQ4TaejIjJJUonA5gJFeeDMBW3g8TGP2DALseV9AVLklOmgo7Ne8tFN8bWs33M635C/P3hbFmFxagKgYo55gAoJ8Wa1rE6fS8hVXgPu4ymVsJAIYVQcCgaq5FEqnjvR0F6t9o6zWmtgjvDv+KMQleJDsCShjVGZHGDzZnss0ADRnMQvbNDkfL2utTHqROciumK2AvzycqeLU9tntGT/lmgOHq8WO6vDlNJBnr8wipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=b0el3Iu3eIdl91G24g8QdOk9h8efOdyYw5jU0R8FP5Snq/SPVtaRcChCoP7xUph/o1XrOEj8emwmIazTSZj2q4mlt2AgGFG1PkrAklDxhrrYtjqUXP4wRuLeCt5eYSWIj/0LV05PpEgQjRUQvC7R+QaO4X/d6f7vQiqpTrvJH4s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 51/70] bpf: Remove VMA linked list
Thread-Topic: [PATCH v5 51/70] bpf: Remove VMA linked list
Thread-Index: AQHYF95/DJUJEqE/AEW2hGiaJHU6mw==
Date:   Wed, 2 Feb 2022 02:42:19 +0000
Message-ID: <20220202024137.2516438-52-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fea1282-cbae-4cff-927b-08d9e5f5b730
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865A4D0AC2AEDA47D921E9FFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtjATd1cp+krsS3Qsosu0ya4GDn5idAKBYkZUmmWmTS/yRSrOvThfBejYSYP5cIfd6z3NZpjmEIvRxly3Lk1l2HAKTT7FLFG+vsniNnSrOqhzTGCrTo/xLGsqJ1hq3P8J8vntuRvDeAn7DcGk6uiE7rG8qM1xdB/BN+uVQyLhlrQCvEtdlwBWsEOgBQx4jPlReH65+vqIEpZ5lFVy0iNm6iRpl9DExOTF/LujEpUCTl5ShzQ3htFC/t4Gjio3qnnScmdKzmpM2NxXnZLltgwnypCwE/2VV73ua1k0ajIFoDvmuxsQvr4LlT+XSb6frO/0gCDAV7iyYJZWjg3XMi5WLjEZu61UXN60iRWoXjgyRucam6cn+Q9GLdcbQiPqM8ktUT5JQbyZSLvniOgtL46lwq/xsr66fESbo9b0VzfsynETlbki7RCn0XcF2X7AaCI/6vE4dNiNcPgoCea9qSnf/JUvFszD3/BZA+SvMzYxLQJX5BaVXQeovC/auTEZHaYKaVFc9Wk9LfWis2yaE9hswhPAfU0uPKf3uXcbmmYfG1n7zEITEEnLfbLeMPmZ0D59L8ReNL6ApdD3J3jqvBPl2pRwtFHnuSOJwTxUuoP2CMVwSz6QPi7/hLDOB7+5bmiXgawjtqZ8ftwLOQe/D7npSn1cU5eCsA0mRzaPcCKsNk8vFadNdcgb8Cl2t7ELejqdUA3fx8NH9WhCdUp2fvABQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R1eF4yuGd1m+CFBe9Ntq24CUEjQ0nHuAIig4vvTagLTja/+DTp854ixsve?=
 =?iso-8859-1?Q?ZxS28obN8lImenX4ziOA3W3QNuC74JJ9dsyppx6CZ4P6XVb9eSlTTStflY?=
 =?iso-8859-1?Q?daGGZ9EYwN8rN4jMtYosvzPeOYT4K/ReQ/ZCsC6P9TIWQkT2cVstgvrykG?=
 =?iso-8859-1?Q?IzgaH0VTTTVu3/V4+AdUtX/8YztSkJw+2cJWRF1nCsqhFj0mw4go8tBHVd?=
 =?iso-8859-1?Q?7AXseW67TwKIs/rTnlsJgUcnMcRJ9/vSKI8njajp7v4jAxW/umVTpoqcAo?=
 =?iso-8859-1?Q?W9c9u1iEFjyAza1eq1ZNPRj1IITcWUlw7e6p6yIJMGl/X0psRJGMgBZWXe?=
 =?iso-8859-1?Q?ARhQUCd3XFkFsgc3ENt35cBHTss/HYBsfM3zjnDMtBQpnIveAEgQ8w0JhR?=
 =?iso-8859-1?Q?eBh161vTwxtikpSeNBKs0vreAwBw2nYZKtr9wxLxa/b8tA095/MyKBU433?=
 =?iso-8859-1?Q?Upzyqr+mEuzNEYxlw08NDf5xROb1kdSGGVTDS2i2c61n2ulclRwV8YDrrt?=
 =?iso-8859-1?Q?awsZpqQ+gWjRznS6mdXPWiRfhWlSRW/c0zMTCZTth+Irwtbb4aUWl0wzNJ?=
 =?iso-8859-1?Q?OS7IwYw3WvM00cGEQhm3Ow8Q1P74u8DZwn+H7yIfElDa2dPgtz8ju+tl5U?=
 =?iso-8859-1?Q?M/IGB+NFh92nspQgbgDXLbcSPAHtrOdFgHEH1jpr9JWcdLRQ2TI1NjNhq+?=
 =?iso-8859-1?Q?dP3kKaXC4vCOT/JVsDAhKYZtRV2Sr2w7ZMIWFndLHbDxdesbZFDB7TyIGz?=
 =?iso-8859-1?Q?Nb5P3W6EMvHwdOPSTeEU0QD8ayckz0l2mXD9hy13S+m6Kgty6U/GsD+9pp?=
 =?iso-8859-1?Q?jcm7tMqe7YqJ9UO2JyBL3bAsFhSKNUHxFLU2LVI+hi+eWCwWEJByEgc01f?=
 =?iso-8859-1?Q?X68qtNCaODD5fr5+CSp2cmSbD2sh3Uu3yx3MFS34EynIlgezpyENWEFp5w?=
 =?iso-8859-1?Q?p6PzE3lSVlsto83HeH68emfbfIINU6UkNKIRresgG11x4nPSpKUwEmmMTH?=
 =?iso-8859-1?Q?WVRtGPHlWbXx7Q341JkgELK5Uk4qeUnF5ldWrZq7+Eqad7RO5DBykpwC7h?=
 =?iso-8859-1?Q?2fVI2qd9IKKtJmHoCQhzGw77jcV/BuI9hAXlsKqTcCs3OUpEl4A6Who6Mn?=
 =?iso-8859-1?Q?B8AhSIvBW1p3VuAYlxKanP7BbpHL1FfPtBgpyraElE7gUTkb6HxP+4/Hkk?=
 =?iso-8859-1?Q?rTTNWmkm5ohDqKJanocWL0DqLNqWu1+U4pnrVCw01Obp8NupPuFrD2ZkTe?=
 =?iso-8859-1?Q?aqBivLSJ/yLSYy+udP1SIsuOWRjc1o6/NyY6Ez3wPf7dvKmPMinngh1Yw2?=
 =?iso-8859-1?Q?o8C64qFyiOynvBOMzr0mW8RcK+7Aix05BOWFDdlnRUrAgnDsosEfb87kke?=
 =?iso-8859-1?Q?zxuuDdlQQ3W5NoLZKOwxVeC6MEpdj+pVpddIE9wn/Z4QchJy5YBbLukNDl?=
 =?iso-8859-1?Q?8a6bnGXsZXZDxMusx3dz1zUK9QUW1y50WutYM7HpprG5EzfsGrouzG1ZRV?=
 =?iso-8859-1?Q?JmQwGq2NyQu862sOb5eBR9ar6JDMvE6FubEhTAQIx0J+RjWOvibQTlyKzv?=
 =?iso-8859-1?Q?WGjLkZjsLsIcfHKgJga1726p9OH6ddXaUM5GgdDKo1eorhh5JaklzqJPNb?=
 =?iso-8859-1?Q?1Wj3lErzQVsoiH8zyUXGTCT/FSPokwRGns/W1feEeDBWhxS1gaxV9I2Jw3?=
 =?iso-8859-1?Q?g+JgomOyL+W+EwgkDQ8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fea1282-cbae-4cff-927b-08d9e5f5b730
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:19.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBQ62TPYnqI1PF0oTfYF/DdhwSSiTE7dH1W85kmoIheClC633zL3nxWMq2GWcU7JasBDXmi2ZM46eMpXSMgfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: 6quTaUNI553gKOWdnNGekC8SjMYEeuH2
X-Proofpoint-GUID: 6quTaUNI553gKOWdnNGekC8SjMYEeuH2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index d94696198ef8..9a0bbc808433 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -300,8 +300,8 @@ struct bpf_iter_seq_task_vma_info {
 };
=20
 enum bpf_task_vma_iter_find_op {
-	task_vma_iter_first_vma,   /* use mm->mmap */
-	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
+	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
+	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
 	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
 };
=20
@@ -401,10 +401,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -418,7 +418,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.34.1
