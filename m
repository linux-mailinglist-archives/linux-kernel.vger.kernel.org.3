Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A04A6A25
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbiBBCoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33780 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244158AbiBBCmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:55 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Mewx011396;
        Wed, 2 Feb 2022 02:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ne1dUbtZfFzazfV0T/O9ZHr9kCDUdKfuGI7eBnANGzc=;
 b=LTir557mXCyZjVhAeC9G6sHTYURi5+iTN4hs8jxbaNVeSgQrYRUf01ZvKhfFHUw/XGJ2
 U2a+lJM38DY01uTSZ9IraAXmEOQeOFW2UEXJedG1MsbN6v2DqyN0uOqr6AJ0y1dwsPbX
 8GakE6eXLOKefBmB0FnUoLEbpzZ0DzCLPKPwyH1ObfeTTdD/tFws4Pq5KW2FNBifn4VR
 HukFp/aLlHDSqv2V7b9AoGp4uxDY3V9Gn7eXDztgQ1zWotz5aGgWPJSy+C0qicLRK8gg
 OZOiVe9mLSgJ1s0qZ66VWQaJxfHJxgbDs4c7KPsNUT7jvVxFIkBV3MRrwF87wfIOaL1k Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvse9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZweX015318;
        Wed, 2 Feb 2022 02:42:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqW6AOROZueAOaPPcZTRwqg8wYA7bNuqrG1KfniueuvbP1OfKm0xFj5hqdZmMEFZ6ZLy0nfyj4IM+qApP19EI/7d/kLn/KBiu7+AhcqN5Mcj74YOukpGBJUt+hzBmwTWI/u0cDpbkZZoeJCXMPEREXtxbFN+mCNHGiWB0uil/y7NPq3hEABLRw+LFNN4RT5vBUlsPOYYfBRToOM4uIYTbMFw6upc711Nd3M3jlsO4Pp3qvQUzyPN8bQfuvVV10XwdMmdT5M9K8yVr5xYtcOd161OgSJDspxJ1Q2aFK7OZOK68BjKbu78JOaKsSYSQjJ/azvHcdNIZzim5N0sc4vBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne1dUbtZfFzazfV0T/O9ZHr9kCDUdKfuGI7eBnANGzc=;
 b=gkhYkdRKLvZj/SeziyMEDaikuVLJ+vzZMDxNmYo+BQgHBLFqZFFzkhI5VrFEoiinzuI6HWhMI2+17HXRNqQHtBera2I+nfftU4o79D3LHhZfegPsCzai0pMprfWL6I4ySpfgl2V34tSSWFxYyt85Uml28GUQLznXyLGXFFTXgK8Kiar+If1cNpmUwJ8mBdgoQgiamKMqvLFI0Mg165WcVxwhjBDx2e64Edyz3EQV7WGLxmvgrCNDcBX4axzj1VTIUq0+cQuuLApYxF0wJUawU4tmahR7Z7rtNAdhS0QX3BXcB2UT/OGgb6dd8y7BjXIVd1plw0Q1m89IPOKsrWnuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne1dUbtZfFzazfV0T/O9ZHr9kCDUdKfuGI7eBnANGzc=;
 b=EgAtwk1tshjxgrpA5Ti8ElLbtQXfjf1u9flc4CRmSnOUZ8q89pNt7IcMed8L5qhMJwNqYXVu23QMZ376ocmH6oIXPtP0j7v2DLso2nsmbezNDiIxW+RLDZT48OApqY/7Tn/46ZNhz5FAuzDNF2aczDuTw605yJUflpcD/jl+rqg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 30/70] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v5 30/70] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYF956z7eE6RrVNEuJq9/KP2cnJw==
Date:   Wed, 2 Feb 2022 02:42:11 +0000
Message-ID: <20220202024137.2516438-31-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7910f4af-169a-4b8a-ebf3-08d9e5f5b074
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB412942E274A70E544EC1B7A1FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3WLAag+0zaYAG2pN5gYd0vXGBQS2DW+IbzISBmEFD7YPIfU0nnEGTLyy34Ui0/wqTp4gI6TTf9nfIILLA6dVlNpVW6HBADh6PEhktAMGjUxgCYjFD3/0bgP71YZg43Qv68/bG/YN+Nzuez+ANTyGvzPVyLAEZwSsWZTc2CU7BnPb/3XAnSORaDuLG41cFAW7JHyIjoEqiPwh0FmYD2WxfA1INcfjqJ4nC50VvmYR9DMa1iU+d5OALNYlptl6QM8AsXC9lUXtFggaNTJfGLuPumSIAEYl04xGzNX+eJHXDKyLxmMFCN+4QhtpLwRAQp2icSW9qxn2Rz9sTUsJim1lNbPZK8bsAveNBN75JG4utEFY1naPwds4WUJBkV+Cwxn7P9aR7rPxseSv7nS/utK97oQA2Uu0HPaWNIQwZbhGuYZ+ZXhmFb04wiIIVaf16fU1qZyWj/3QmUg2zefLlC7WbYs064CECPFoq0sHlQZsG3zcQWTwzh31+FpIhtCjAMFxtUE9P+sftVn/6pUce+4Vb95Wl6EfbEWzbzaxS7vSWlwHewDyX80Y+LM3AvZDUe6W/0MRQK72pj5eJ/qceV4ArVmHBBUOVSoo1kZJD4Q+el7nTVsAs4fweuAq5dCrlD8+auECyex19/eBBOlSPLAo0+X7oB9wUogM2HazB/2eQx/xxCCng0ynRpshndpYuj0uAclowrljEXlQJjF+ytQ+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(4744005)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sgB6bVUqu7QylrPpoJbK5mEl8g9Qj1Tb8gVOtVf3FzcrqCMafD803RvUl6?=
 =?iso-8859-1?Q?P7COebSHIcDqyNh3QF7xir3kd1vCGgQyklrVi6U8HAJhUdgBPdAYkf46Gq?=
 =?iso-8859-1?Q?/PNN5gfvkhYoBxwI9engMafze6cTEPvI66QcJyTLhc0TRaxkPTgsZB+de4?=
 =?iso-8859-1?Q?3kcDsKRZ9P3iLRiH6jWV1eN+H8rN+5H2oOPXVagaGkEFrgDMdLc1uwrTK/?=
 =?iso-8859-1?Q?V8EPY3dzCGU16Ts6V67uZs9+SCbX6Wqi0x37gOAV+ks++DRpibn45fVFJC?=
 =?iso-8859-1?Q?2Ia9gHk2ddrokEWR6hsN8kO27cV9UuIAvp6Qdm+/AFb6VOZkKublaHbEQ4?=
 =?iso-8859-1?Q?99iTGf3lJt3tDXrQ/Ko5L27fLG/YipEMpWt9R2wvfcH7YDboeP/rCaovub?=
 =?iso-8859-1?Q?+TluJJ3/qBDTvTP8arriewpfDouXp+TbtOVaJMNx91AvQ9FISeJvDVdKXp?=
 =?iso-8859-1?Q?rG8Q/gtfDgKtjcN+LRYM/FkRE1J1unFbjsUITZJ9naqRk4Z/OkU+jnt6DX?=
 =?iso-8859-1?Q?5A6p5t5B03tWTxRToWNlHGFohLcfGO2F1EImlz6An1xTJBpDfkFOLdzCmC?=
 =?iso-8859-1?Q?jIAkHcoYdkfeS2i+TTQldFOv+DGuU00Rz3ZQ79HDmzddrkWE8ptunB5H6Q?=
 =?iso-8859-1?Q?efhZIx/9tSyf5MRyRscBg1Ur22pqtpmgzwy30fmPwqFkxl0byDCxxLaphI?=
 =?iso-8859-1?Q?stvm9xPW7SN9PeIzX+z4/VYln5V0BKmd+SQAs9Z6EWJoNMykh0xs4jFklt?=
 =?iso-8859-1?Q?PZDIWDKidFEjIJTRy87iBKoqsjE6Vq1/CP/EfCoTiP74+A4oKaqoQWOqvY?=
 =?iso-8859-1?Q?UnXzknKnZzmrGldWbREWs0Q2puz0PXhZW3K5PwnzVFWMfoDPagZ0hM3Btv?=
 =?iso-8859-1?Q?lpKQn2HE9kT8aBDREyGTrqy1rTdv45jF+t/U0eCmQoGgb632o79aGyZY5y?=
 =?iso-8859-1?Q?ynbRCXQpKnCP63zqabGyUMIV6lTHCYWiEyyhegruqjcdn4hPTMTY16oGIT?=
 =?iso-8859-1?Q?EuZmnSZsUT5bW4QuLdxUEl/vNbx3z5nlwIS+qUWm0FV01eh5PB8XP1rBA2?=
 =?iso-8859-1?Q?XNjRsiBog2fShwT5OXXfQ56ahVo8xGNo8oYMVE+M4Qzq/WP6k1DB49ER3u?=
 =?iso-8859-1?Q?jjQNvOrW6A5iBvGkCY3mD8s7ETMHf2ik0i5jwlCHe56yDhkohmIAAvtxOx?=
 =?iso-8859-1?Q?fDB21I6Ra8R4DD/0Y7hiihfTfmbvc+PW67RBJ+edoVkK6PfwytGmtyx1gi?=
 =?iso-8859-1?Q?ckbZECk/hlyo/pdLujxF8zhAgTQsLRUSIrab6dcdUVNnKWyhhoZaq+BujS?=
 =?iso-8859-1?Q?EjtjIeTnWCn7ntmfTIgf+wtwTxz9sRmOPIVRqID29FRrb+eTN24CiRro5W?=
 =?iso-8859-1?Q?Gt9HiOiHNixl5f4Fp+axo4K6GODSEnY/AEAGdMAlvfaQhRUvCaA7PxdP8O?=
 =?iso-8859-1?Q?Dt+8p1n7rmn6Dm79W5X24hs6/wpy5a9GEL6N1Xq+2iNDojj7ymxzF3EnFu?=
 =?iso-8859-1?Q?Yj5Lrig8JHjcVTqiYj/3l90HtSPEZIMSEIjbxoQzHF36w/mmNFUUijEnum?=
 =?iso-8859-1?Q?3wq8w1z8AbyDjqNcL+YQgODc59Rh0oShlSmbyiVapDxg/7gvShfVj1M7t3?=
 =?iso-8859-1?Q?VMjXQR9kO4021I+nWDbnG2A9BzfLdpqZ/ZCzPvcbL+YdBSduzyFjKXaMcG?=
 =?iso-8859-1?Q?+cC3aXvq7qGb7lyf1xk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7910f4af-169a-4b8a-ebf3-08d9e5f5b074
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:11.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNTqc2BB1jxife2egbZGqMIGEtXiFNX3zBZ1Ah99LNzJshrQPrZs7cZzQV8ZE5+4WBr3SCCv7oncL9dbtQbrsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: n-3H86PHwdAONCvwxudMWt3XPDNsElpt
X-Proofpoint-ORIG-GUID: n-3H86PHwdAONCvwxudMWt3XPDNsElpt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

do_brk_munmap() has already aligned the address and has a maple tree
state to be used.  Use the new do_mas_align_munmap() to avoid
unnecessary alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d54d3f92fd46..7ecb2d4abead 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2978,14 +2978,15 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.34.1
