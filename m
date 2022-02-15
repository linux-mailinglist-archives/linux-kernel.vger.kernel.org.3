Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD914B72D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiBOOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiBOOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCEF1160E8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:10 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi2WF027354;
        Tue, 15 Feb 2022 14:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SthAPZS17QjSh+rLlVTAf2+RTTcsmO7b6Q5HNJjoDPs=;
 b=eNOivt+nWu8yXwYHMYZ6AvAZXd5vhH+VV9/ySZJIjewCOEqiVIerbQUY8fy2SYbP+Sbl
 Meo0jWKgOy/GB7a2p87vefoV3bxKMqv9E32qfCjlBL6W5N+koF0ZD+ElEoXNH1fqQukE
 gc39Gon8SVsvBiG+GZ6ENua4xddUgVYCpJSQyY/RAgdDgyjMqdAxZZptuo84YmFRfy7A
 BuGf4FMiy4fSf1x/sRw0weendZRS2N/BOLmwstrrzlNtrOhVZJdrv8R9mcjqpmM9QRfF
 WVX5e2KGbMTwez2OdUR1Hbw9NAeXYSicZ5UXwWZxdJGd0BNTpN2Cu5h5YM65Hguw4Y/E ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e820nhxy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf96s016330;
        Tue, 15 Feb 2022 14:43:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3e620x7vhd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lvu4t9WvPrNMYg9CNd5ZK0V0UlMzchlP9peMbzOBkm6tDCnj48ibXZo98H63ki4RUtRvYnUtsmIM+MjHsPrEVJaDcj00B+Tsa8v4kisHzpm2pJB208aHpNKe1o5jbxXI9taavUeKLuChXSEPC2NnLFfWPYTd4bgDkPy9dwiMfPegwb7+pYZ8Yf2L0sF31TVG3fAWoiECZjOwlYh0rQk1RXlOMPHchJ6W3kQFf0AeDA8vZAV7ivxG5UfpdPg9WEdCAdvjeaFclEg7ku4K8xl80SQ4BTyIF0Gkn/uEYrjPZBvgRWFMfTwh1Y2B2GTShnbKnHGxveL+miNsDL/REcG0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SthAPZS17QjSh+rLlVTAf2+RTTcsmO7b6Q5HNJjoDPs=;
 b=AJoScC6egGL07N3n/qG3r835a9oSbMT6IeNhypKC/5qmWrCoJp2w/oqhQ9/GM/Ow/NVzdq1TkuWBdlUkIYoKGjI/GRWrY8R75iZ1iuXKjL6iT5Jlyg7Bw/+8Yy3V9EmX1yiTGPlUmPNTpOoEVMO/YQl6+VZLnv4Bdt11UoeNcDqgc85ZzyUnf0wBzD3kNBXkaW9w1p0aBcCkTU1glfQWfDZfUaL4S226mwOMtE2PMdckken/3WoGeJPNP9IpTJgT50eq8ckWBWfwbTEwEQiUl4rzM+rAt4V7bBluuoczL/cqK2Dt3hsLCSB99en2lQJD+0OTUyVGzHNTHN//bPeMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SthAPZS17QjSh+rLlVTAf2+RTTcsmO7b6Q5HNJjoDPs=;
 b=pXEiVqihDtTdmTDD3Alj2I6oDfWbUt5VyLTFDXYfLWk/7rirKjrGkW2yNwHEUibnsPb9oQEBJQ857+G4A9cpOpYxOYu7zelSfZIBwVEfyTPzxRVYPupKNdPc/9txvluQ+7KprCci7BtG8BylomKv18WZYHEnjs5mtI+aAJh63+E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 45/71] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v6 45/71] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Index: AQHYInpfpFmrbR+n/UK3yplk6ZChNw==
Date:   Tue, 15 Feb 2022 14:43:19 +0000
Message-ID: <20220215144241.3812052-45-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 309229bf-c8c9-4895-fe4d-08d9f0919817
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689EA2910FE3162A8B9EED4FD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2WwKbkP/bHVG5W6PEqDl1LUlBYwjWAONwps3D/FRPsOw3HG9cBx23z9B//8noZyea7LZQIw25VU/9C/lPMtSaMXzN25Szet91A1swM7vI5a1X+h6I8MOo084QqrhvcqK7mth5rdoXMnyxx+jiz6GG6dshTkpgxiMLaZ3GDH4VJqdi20MvGa/MmPQRivWh/BRYiQ9+9pbsCHZGp7kfQsasI22DM045hVA9CPZhFP9HqTTceJ/SgCtbwSHwCQEItylAYhQS5nvX49CZzYGHeC5bcGMYpDtd/u5R4fRccS6eo6PnuX1WpcycezJUSMlzXaPWFOUA4KmjMv/wN7QDC9/PJHwFVod9sSuDZoWApXNyKqOtyqLeSXgaxOGeZbp4EiEJpG8g2W+Mh/9gCFYq4lLjsK6gFIAw4yVMURLGvRNQuBJoYvBzHiG0mt0kJKJmn+OxaPwf7tYAS/aSxsoaS1F5orftTnGUpT4dYix7XDaXTn5D6nOO8oOmvWoJY0Lv6COS8Fc/L8SKJG0GkSPbszpyBpXCuz+3nHvQfVmG8VIOS883u/doJ6rc0hoHHIKzRZpYjiZceFz1/aRarNlkHrT7kTrt5iA+KKHwHM2dTQ4loDDnqisfQb/0VUrHNb6aWhUG6l/UAytssqLl+yGuKDkmYKlGUgcJyba9LGbaDi/uMNcIY7SvQ/pPi815rpFkkUldiZ21RnwCQYq5zPFfgyP1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EghPM+cpOFlew+mE403vJvFlmdB1wN44r4zesVo8siiPa8B37NE3C+sf1u?=
 =?iso-8859-1?Q?QGJd3zMFRdu7vne8/SBJfTrGxvox2q5gIR0OrRz4LTiuA6u0bALlWM8KH4?=
 =?iso-8859-1?Q?P5oQHgeUYGkL9AeD6D+79ntwT850WqEe1cDepH7JalsZC8VnrDVI2z1X8Q?=
 =?iso-8859-1?Q?t3ywzU4Iaa3Nzyyp02z3GNyDkvSRHiQQZ3J1bLg+weQsDGwAoWt8FKYhht?=
 =?iso-8859-1?Q?Nudu4saY2SWWJHoEFRuu3JglYlcsaQlqDMAfX1+6Q9VGSdiMfTzFu4efpI?=
 =?iso-8859-1?Q?mLCHj1vdFHo/veAsSOhDsF5a1ulPaX7YxFwd50JbNXZyJHAlK6vrV/VMo2?=
 =?iso-8859-1?Q?54mILCyKUuEK55NLsu6NBmVFGGZXjOwRcg61zBF3EdNiBs/qbj7pPBepEn?=
 =?iso-8859-1?Q?dAsOjqJeBYxxlmk5Xcp722xREzPoei4Lgdk5dZolwg8E7ZlOaagmqdFOVL?=
 =?iso-8859-1?Q?FeXXuWy/xKel5GNhTkBSD5acqEUOxy1LozI5oM2g9Xu2Lpz+xLTkwh3wfc?=
 =?iso-8859-1?Q?jfIwD4SHMHIrPV7oY9W0zk7YpSxeduJX/ZoS+LGPGYdG90NG7OqNVSg9mi?=
 =?iso-8859-1?Q?tOR0fYIVPixzez9TOz507ehqozDo79andMoKYijPPpuRseVh5HVJxQZVfb?=
 =?iso-8859-1?Q?UBtxjrrCtNSKD9puWyNePUt8mThXgzurx+R+QVyFwzJt+g2XoFlx2m1OaL?=
 =?iso-8859-1?Q?bx2akoxWowdiTO4iDTl6LVvz7KzA3/22r2A5eUd0xr0X13BM5H9WFff/b9?=
 =?iso-8859-1?Q?cNCjfTBl8dDRys0skZ/cSYbV7bujFLS88jpM0jHCDPqFRQXiv3VluPLn7l?=
 =?iso-8859-1?Q?+2WUhb0CE0y+a+DYHsVpZFwcKC3l1xrhM0CCuFs2RMWdHp+gEUEW7z6HA2?=
 =?iso-8859-1?Q?Fed5gvQG0z3KB2wJlupxMF8q5CaPettBjXFm8JAp0N6G0AuWM0WsXHQFxY?=
 =?iso-8859-1?Q?LNiF6Vr/Ptxm+I6JY8U6Zw0Dws8aSSG2n1Y8+03VYvtJ1xcR1mr4wS6MjN?=
 =?iso-8859-1?Q?RjspgD3VQeuWnBCY16MfugnSsDTDbxwYiv3a/fyDElptaPu26PEeCf68MW?=
 =?iso-8859-1?Q?Jp89xE9rwHZpYOE0m8gS+amnYbBj24QwNfFAhBDdPRHB4NS+d+kXkL+y/V?=
 =?iso-8859-1?Q?lKDBMAHm620MJbbV+hYKG8lZdMpxf8ZQRhFSsw2xTo+j3ONJRPoQ1o+5Xo?=
 =?iso-8859-1?Q?qnyQTr50isbphWBuDZTitmIb6pMRbUi5OREXpCeUzP4RzursdXzgF8mNXV?=
 =?iso-8859-1?Q?7DfDQEDxS1roeMmNFxEtFw5VYwz03HW7JlZU/f9itSy3dkr5tBPpKI3ixr?=
 =?iso-8859-1?Q?MC9zLz65tEqSdWn925weFjys16AMq1GlkS6TRuD8Gb66N+ArdfJC7xydlr?=
 =?iso-8859-1?Q?tNX+Ix8amh1BQMbHLdHjQdnKCW2s6GdKVjSArYv6b4Fq+rftVdLrtcJzsu?=
 =?iso-8859-1?Q?tnkTeOpAFst/1vO98IPoxJzIXUwrfzby5qoGDwK0mCgJISzHrK7Gb8QbJ9?=
 =?iso-8859-1?Q?m0tlu3tqMrSlhyPaDVS5FJSt6jDh3sfQ5y7ZL97sjH9phq9jppQCfgO1q4?=
 =?iso-8859-1?Q?TakWVm5MJfIgvBhROTCd2FwmAFquYCjIfGmh9k+oNdUVqsgjtGZqvYZGNA?=
 =?iso-8859-1?Q?UbZEEYpN7kYJqGYjEH1uEVAtNwngVjFTOZq1NbvQFK7P5dDueCyR6/j9La?=
 =?iso-8859-1?Q?5hdjPGJnExMbjkkXCNc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309229bf-c8c9-4895-fe4d-08d9f0919817
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:19.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTIFS/wCEf/lTUzKwklJ2Ea8GOxgyWIOQjdWqK6tavA+SvOjoF7TYpEXU+GxZIePzKBE7A2QVQF61ovQcBTN8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: 9BsgxByYfRGb-z6-gjR1G7I_JLgP3TY0
X-Proofpoint-GUID: 9BsgxByYfRGb-z6-gjR1G7I_JLgP3TY0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove references to mm_struct linked list and highest_vm_end for when
they are removed

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/internal.h |  2 +-
 fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..f03000764ce5 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -285,7 +285,7 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 #ifdef CONFIG_MMU
-	struct vm_area_struct *tail_vma;
+	struct vma_iterator iter;
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 68e65280938e..f42f8501cb55 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,12 +123,26 @@ static void release_task_mempolicy(struct proc_maps_p=
rivate *priv)
 }
 #endif
=20
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma =3D vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos =3D vma->vm_start;
+	} else {
+		*ppos =3D -2UL;
+		vma =3D get_gate_vma(priv->mm);
+	}
+
+	return vma;
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	unsigned long last_addr =3D *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
=20
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr =3D=3D -1UL)
@@ -152,31 +166,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 		return ERR_PTR(-EINTR);
 	}
=20
+	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
-	priv->tail_vma =3D get_gate_vma(mm);
-
-	vma =3D find_vma(mm, last_addr);
-	if (vma)
-		return vma;
+	if (last_addr =3D=3D -2UL)
+		return get_gate_vma(mm);
=20
-	return priv->tail_vma;
+	return proc_get_vma(priv, ppos);
 }
=20
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
-
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
-
-	*ppos =3D next ? next->vm_start : -1UL;
-
-	return next;
+	if (*ppos =3D=3D -2UL) {
+		*ppos =3D -1UL;
+		return NULL;
+	}
+	return proc_get_vma(m->private, ppos);
 }
=20
 static void m_stop(struct seq_file *m, void *v)
@@ -872,16 +876,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -894,8 +898,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -904,6 +913,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -947,7 +957,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -961,11 +971,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
@@ -1258,6 +1267,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1277,7 +1287,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1289,8 +1299,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
-				&cp);
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
--=20
2.34.1
