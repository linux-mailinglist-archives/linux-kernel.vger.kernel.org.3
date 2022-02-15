Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B74B731E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiBOOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:49:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiBOOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D661179BA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi1We014275;
        Tue, 15 Feb 2022 14:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qA8vMoB7l083Q63xAY6AychJP+sRI03WI1rkY8W9gKs=;
 b=FRta4743BiHCHBNG7zBRI+sCmfKXLHR9LkWfPBCpCBHlIh9ljKvT2IZ7yKOHyz9Pyeg3
 Ywb9Jq55ijVYY3NzrOONTcPVESEdiWuUjPu0ZcRPuEaDnlV/qX6CeufbpRZ8cJJrmYLt
 NjVACTQBXfUZ27DOZaHEQrHjAe8zEPSm5UcJW+SfP5RVEG6FV7kJX5zzovM0EDTx8d9m
 lK94Kxsrm4z+v/fejFovC2/4zV03zM3uHpCB0xebUxZ0yO5djWIDPD2u7qga5FyVeuw8
 I7rtjUPhPzMGls0wFM9OSW5bM99ucW/j3QI2vzt8V0fpsWxlzNlSOHtbsVxIhTeeU2EM Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570shtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8lr016243;
        Tue, 15 Feb 2022 14:44:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUCdBKQp/3Acyio6yn66fMh78Y1IoVIpOerUFNgjxO4XQWUUwx+xy0HhYgau/yvhtHficbBanDU5F/M+PyDoIi4y3dyUZhosimHlt1o70Bj/eXg5VvaPjZokjOK11h+L1oOp0sdDfcBbKg9nEkrg9I/qyqMpSSpA+ZMe/b7+dgV1JzyLRn8cnFYq1Oq5k6S4F6PWvrQgMhLpMnWyfjHxBNSYaN+J3snu/4iyOOMI7k3UCQC+bjjhdbVugpHqi/9vxsZrXu/EFORsLZhx9OtHxDKeBHyaNAUmgmYql09Gh3rPQwEgwZZZCswXCrjaJIs3hbTGZurk7eafwgMcLRCYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA8vMoB7l083Q63xAY6AychJP+sRI03WI1rkY8W9gKs=;
 b=QfysnmpwfYbCffwc7JMhOjVQ4hl4FlqBSjWv2dqwpjL5pyGlOhOlAY25X4rySPP+nI+rDaZkrqTnXTr+lpzlaRFkRo53t1tQweOxNOe+7OVtm3CmG4M8fpaIsVk//EHEldwC3wOiXQVTNlpxYRu+OaYjIqkA0oerEca4l/C8ZVPLF1FsIA0JmVSHQ4AqnxjoWPUvMHr2j/yavIe6k1ThhCMuZ496v13P3Jm1WBOj1GgG7E+8YcQ335FVmC/iUv/tiimhI1/NY/x1Uf6oGTrTpeH5OKRUgYHFm+ZoFhwXn3EHD5C3sHJYSfSvsnl6hGrvBDDPcpWUHsKisXAWyOKcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA8vMoB7l083Q63xAY6AychJP+sRI03WI1rkY8W9gKs=;
 b=PWZgzYMvZx325nnngeujcUOInU18qDohrpTTqWHhbbdUO+H13EmmbB6IUS+NR/E85bHajOBYBCGN02h8Gpqj3Rf/ghuzafw5nGNELulHwGNVCsHJnRwbOy9vMwaTHaL0vrjo3fS+k/gWKM8q+Y9rBGi2QtEoQygaco329sZwadE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 58/71] mm/mempolicy: Use vma iterator & maple state instead
 of vma linked list
Thread-Topic: [PATCH v6 58/71] mm/mempolicy: Use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYInpiqYJr9mgpikKVsd4/UnP5IA==
Date:   Tue, 15 Feb 2022 14:43:24 +0000
Message-ID: <20220215144241.3812052-58-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e22a0f8-c426-4d9d-a057-08d9f0919b74
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863002220DC3F339E0117B0FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4cltoj6majUbowLfVOfYzxOM+HAxzoPidsUxq3UuCadU2Gmz0saEDuYVDhl2VF7jSRUOpYoBj5koFSt5JHqO6E+4iA5BZ7NwGRieaw735EwngFcbQEupo94H2o80XNfeHsovsYGmjvFgYi0lEgujq3BUV/0dfGmNh7g9iDgsTSDmEIUdRVFlFT7+SeBE/7iR28ht72XTybcgoD+KQv0lNUXNSXh0y+JAsaiiIDtajSl52ESMusArESKql17zpaMYZtZZ4QZvPHKHAZEkbr71iEoXZdX0Q/pLlMLu9AF44h1IJUnUFySSEM3L14yX0rBkeFZuvCLjoPiopS3/qbt9g/fvFaePatc2q46HxRKo7r7Ac2oz2FFF4W88ztalKTTs5yXUpsZo2ogqq/YWxAvoaDPH2cW802cniH3UZTM2WPXWvnaekQWVeOykMHR7/AAWF3nugiGUwx4Ef5KeTWbPZY9Q9sNjJtb5EG7Tb0Pu2oShWhDhA+9+FiJ5tsbg4pqcc5Y2gnuffpr4QbwdMeKE7DFSgbAJlEGSmmnAemZ+bNXBP54rQpQ5R8LBu0yyagE/PI+3Yx9lgHZm9xDzqAx8VHhU9VIdNd8yx5KhncE2pxUBAREef+1sz+iW/xQRzRf+OyksIlhiJKiLmnlaJPkv6LZnTeT3tYZ5v2arWe47vVkA+qtIg1GQxrP4sPxl5ry+FJ+7RgO0cbfCe6QZn4gFgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xmyUUB9lxKKNaB/f8PQJSLmKWcaC2/3UBgP1q+EDLPgjjDb5w7xbdP5GV0?=
 =?iso-8859-1?Q?Gmv1CzZ0Uif2OHkUwTfcmN/FGeBcSLJ816uFDustrOeXAW/DvQcD5V+WwI?=
 =?iso-8859-1?Q?P54NMiPRXwugQk5ndfZAZogfQ36TqPFhZsctsVYRuZ0oRITgsrmsY1tuaO?=
 =?iso-8859-1?Q?nHTusx4t620du5Kz7VXTB3m7laKmwYbv4ZOAJGApUPRx6HinJMsxetbm+S?=
 =?iso-8859-1?Q?kTtzlKOttOJBTg+/ZVPTc7aeWU2otb9LZbe5SwlrzruHd4ElVCWyAcGTql?=
 =?iso-8859-1?Q?gerRQl8k0/Nx1IwzgMmIwNwSXvbJjsHLzOGddJXFIl0yZmtak0DlzwCT6p?=
 =?iso-8859-1?Q?Ix9XK62gMlYNZMRYJRnIhQpSq9X+tycjpBleMBTMHDSkqpXKlTq0vQpuN0?=
 =?iso-8859-1?Q?JHp6eymfsinGMEBZrOzCStles6OSC5qTM+Eav305LckqTVv1iyiuefuPg4?=
 =?iso-8859-1?Q?FGoXUINeefYyl75TPO0hXB33EawVJdAOBUnzBH5tohJeRM8yOzr6XVtLwd?=
 =?iso-8859-1?Q?RnT2GSop1nToAAXENaoBnUsM2wummjaN9ZdYF5DMD+Hs8Eck3QYUv93iaD?=
 =?iso-8859-1?Q?3zEGQZtzPmGvwBat2QTuQnCb5tDHYk4UI7qCVJmWX9buJ2mpZzO0uctpK0?=
 =?iso-8859-1?Q?Ke63Vf48iZl534wrDDg8DpetDlMvkXY0AzAX5znmoKtXtpNOF5IKS4pgnE?=
 =?iso-8859-1?Q?L84SBAkhrXi+X44Nf/uMjkvh+E+wDz81Itj2yYbiN8zTXpso4CLGjXS9gi?=
 =?iso-8859-1?Q?iinhmG5Pd/8rD0EuLGIGBLvOV5YyYJ8qCUve4mOr+jkPzxKOB7gp3KsAXJ?=
 =?iso-8859-1?Q?govgHj+dgdWorZIlfwCReFgfPA7Irx8c/SL3lCVNIFQCUheYM9k11VU3OX?=
 =?iso-8859-1?Q?m7WATWPh9pkJaZ9Hyu5leqlr8ifNr8Xbi4uCASs7u9j2p1GjDjcTCoUND9?=
 =?iso-8859-1?Q?QDhm+LYDBYI5mht1/jY0TnW9olvM3cwdJhMQ3cyWXvSioxMKBTO7ODpIpJ?=
 =?iso-8859-1?Q?jDvUZYkrpnJCJaNdu8iRlXhdNKBWaE0O9J89L1pdlpDRo3O9uDBSrmJdVf?=
 =?iso-8859-1?Q?Ff475iNFcFCsepNW7ALWvetRumPItYIBJbzuxj9KFkmZzbmX7X3UNzposN?=
 =?iso-8859-1?Q?gd6djDo4jT6/0/lC30BQgIRQjrBERilcSd6dsDIjQtJjJkb1lPvSXtLehK?=
 =?iso-8859-1?Q?KFslUi+iB9jm0F6vEf3D5ECxX7ad0FnDEOwZJ6JOr8q5nMRNZtUc8V2cXy?=
 =?iso-8859-1?Q?s1SfRkUl6AFUpd7TUpIC/bkqJAzA+1TMLlB5OGXe+l5i2FX34kzqeP3rOu?=
 =?iso-8859-1?Q?6ixffcfQgPhPKYQPggkHRmiR8/XtFubDFfUWqkxkq+u7VHPaosYcEHEu9F?=
 =?iso-8859-1?Q?ePpBYgNojDznunDh8NTDaGz1Reyj4JThZ60NQb6sGXTpKf9/pfMHJLd42c?=
 =?iso-8859-1?Q?DAj9zo8qbaPOwx5Zn3LHLCjCws5pXmCoFxb/nNOhMi1+TP2sABmhfCpjt6?=
 =?iso-8859-1?Q?pWl3fCKW0Uyok0xBs/uZVAMxx/J6qky6nOSdW2LsWG0mArYxLmwlPjgaFt?=
 =?iso-8859-1?Q?o753tIXF8PuoCKjLCwstB10pymFtSYmQoEWvsrRv4U6atDXp6U/Fs5yUCt?=
 =?iso-8859-1?Q?VGKOZXQp9aw5lgcNm0EDtIvKUlf+tObpdgWswAXOzHm4/J3C0k2qNuxIE+?=
 =?iso-8859-1?Q?m0llLN4c1AgsSWAPjpI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e22a0f8-c426-4d9d-a057-08d9f0919b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:24.7603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3T8DJhqPpCIAax+RlDSd8OCAtE2D9QGpQuhwuCdeMjkTKkCeEuAHQ/71PMYXJ3hJiQoDcbY+nM1Y5K9woTUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: rceUiHmY8TzCApdo4Xdxo9HMtQFwLxTZ
X-Proofpoint-GUID: rceUiHmY8TzCApdo4Xdxo9HMtQFwLxTZ
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

Reworked the way mbind_range() finds the first VMA to reuse the maple
state and limit the number of tree walks needed.

Note, this drops the VM_BUG_ON(!vma) call, which would catch a start
address higher than the last VMA.  The code was written in a way that
allowed no VMA updates to occur and still return success.  There should
be no functional change to this scenario with the new code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 58 +++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 028e8dd82b44..d058b2be8655 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -380,9 +380,10 @@ void mpol_rebind_task(struct task_struct *tsk, const n=
odemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -655,7 +656,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -670,9 +671,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D find_vma(vma->vm_mm, vma->vm_end);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -786,28 +788,24 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	struct vm_area_struct *next;
+	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
-	unsigned long vmstart;
-	unsigned long vmend;
-
-	vma =3D find_vma(mm, start);
-	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
-	if (start > vma->vm_start)
-		prev =3D vma;
+	prev =3D mas_find_rev(&mas, 0);
+	if (prev && (start < prev->vm_end))
+		vma =3D prev;
+	else
+		vma =3D mas_next(&mas, end - 1);
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
-		next =3D vma->vm_next;
-		vmstart =3D max(start, vma->vm_start);
-		vmend   =3D min(end, vma->vm_end);
+	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+		unsigned long vmstart =3D max(start, vma->vm_start);
+		unsigned long vmend =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -816,8 +814,9 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 vma_anon_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
-			next =3D vma->vm_next;
 			if (mpol_equal(vma_policy(vma), new_pol))
 				continue;
 			/* vma_merge() joined vma && vma->next, case 8 */
@@ -827,19 +826,24 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
 			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
+			/* mas_pause() unnecessary as the loop is ending */
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
 	return err;
 }
=20
@@ -1057,6 +1061,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1072,8 +1077,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1202,13 +1208,12 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 {
 	struct vm_area_struct *vma;
 	unsigned long address;
+	VMA_ITERATOR(vmi, current->mm, start);
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	for_each_vma(vmi, vma) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
=20
 	if (PageHuge(page)) {
@@ -1491,6 +1496,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	unsigned long vmend;
 	unsigned long end;
 	int err =3D -ENOENT;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	start =3D untagged_addr(start);
 	if (start & ~PAGE_MASK)
@@ -1516,9 +1522,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	if (end =3D=3D start)
 		return 0;
 	mmap_write_lock(mm);
-	vma =3D find_vma(mm, start);
-	for (; vma && vma->vm_start < end;  vma =3D vma->vm_next) {
-
+	for_each_vma_range(vmi, vma, end) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
 		new =3D mpol_dup(vma_policy(vma));
--=20
2.34.1
