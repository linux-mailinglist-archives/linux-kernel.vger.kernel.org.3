Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF9464FC7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350280AbhLAOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:36:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49752 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349955AbhLAOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:56 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1ECcRl002533;
        Wed, 1 Dec 2021 14:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s83VkowRGHmM05SuDklRJVofZ6HsBD48LcVRlB08nTg=;
 b=uJ/r8t7k9EvYcbGZhCMN896Mj5EgONaHWdhl8rAZ9iYy5Ot9pp7wUjk43OSKXg5TheQW
 IxOJtBw0kApVbqPH0Fk1vfniRJWncFYYlYeFB9AmFhDFQKlWH6tkrEz/rz87ONzhdqTk
 Hmyy9bvzFZWSmcHC99n2hIEOCFUW+akJJfrYqlUCfGzQvesEhRixt+d4hPrcCqrBIhKp
 golRvI2ErJChKLy5iUoLRknk5tQqiGSdEi5gLmrvrrfPRx0WI4q6EPgQtCIQrOpqVbVF
 Kum/lxUuWQAOVw/a4BPKVr3w2oblJMkNJXYXC61krVoGHliPWTN5jP7bxFqG5U6fieD5 bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx222e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBl7c109791;
        Wed, 1 Dec 2021 14:30:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3cnhveqcc9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6STYoUkosXJUo7xOCdnlbpTyqOPU0SD4yShyCvbOnUet4pR5n8wDjzsa41aPkpprkcOmuGAxJwl0LaFH+Y7UCUqoYagdxfS5jyFpPwxt9QpVniPqMeGFinuBuYBk37fFUIxd5QY1Bqhx7ejJ9PIc+LHWH2R3xjLHVu9pwkwE0vjpVrcwN/3ytDNXLg9lfaseUpuGThlqG9Gq8Nu5eQGgxx/o5vZ+yMjo2Mv4n/gJ6IG1V4uwf9mS4OYUQgV/086nYBE8lMEIojSmOzUhjHBhVxkotWlCjfcjLHNolHIMd2r4I+NvcLVR1blWfXL5eSnB5udgDs8CI1DyCE4ii7f1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s83VkowRGHmM05SuDklRJVofZ6HsBD48LcVRlB08nTg=;
 b=O9OCIUzKo8VIKUblo0ARQuTCvouD56MwIty4eZnOKHTNd2DH7m0ZIX7/JlZxR9acEFp6sGBHzYSEIAMY80XIVJ/6Ukfk4+i2VcXMDZhCzQUafSbWkV+7BI3CR/bLi2iZI+JKTXNUluPTAX7G5XJIMWpJkwk2f63JSvQUJFDM4yoBlbkY0zZqGT5mUCKTeZuPBuM4Fbzof65iq3MdOKU58+TC/ZFvESJTpfjeVbhVmgW4bcs/AHOKZFIro3ONQWPBLKpO8M6Cu9IPNIJyJHCqvXLKxv0bJcjmjXOfyqglCjG1D/pgKP3nfjxY0RfWQJwkmRpJ54SDUefUuRFQ0127xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s83VkowRGHmM05SuDklRJVofZ6HsBD48LcVRlB08nTg=;
 b=yu1zbZ2eLuBS+2JhOvZL6TLgtlvhYtEsnHY9QQgiS4BhaRIaEInjfp964DkVUasssWKpNe3VyHvH7uEX80j0HgcxpXtC0KwQT8tvKIjW1vEJCWQsOGVeB7oZVV0ewaGrqdBqxXE1kO/+ipiSonygvEXtI5rzircXHK/LtU6bBcE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 44/66] ipc/shm: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v4 44/66] ipc/shm: Use VMA iterator instead of linked
 list
Thread-Index: AQHX5r/y/5/uIeddpE6IuVIz7n6Hew==
Date:   Wed, 1 Dec 2021 14:30:10 +0000
Message-ID: <20211201142918.921493-45-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17935539-46e1-407d-0de7-08d9b4d72566
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508881C3406690844D6A220FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lMmh9OSlnQGXZfDEoFBeQ3Q3ZJMBmgWXySJHJM0U4KVitR9ehHj5KAWWFcrfdWiiwmto1+3q4IbXbpBnkwnP38ONSVGREyr9vcW/k8ihy8Mu7CybOr45zl1kRFYJJYPYAhKgHtPg9/c+i0m3rI/185X8dz/S/iKEywXx3guqnG08E2+NJR9U1a8Lp45nVB6c3DofYTbcrVvIrll40Mk+R9RzXGXZd1YabYe6h4utny6SNWmenhVNtT5qQk1nCUBf0KaHCBfa+Fs8PBQ2rkAHb0XoOfO16lldazOAmcEynI5YDRrZbGuCL98xe6mfm7/1gRObTT32ei6QMcCp2qY2wMi+vkD3G7dmgNzErWDUQqMf/29F1ucqibS9NtI/iCMSeCCV5Y6f2Ds9PoQ0pdnjxaIuuwDRGHGTUTVpe+Z8GrIIKzpeN6cQJQ+HcR45RK5yEh87jRr5BbkfKV2A0cv2522sjrb2LkjdlwRq6dSIhqsA+AcN8FIXvQDuKYmN8qsezZq4twIFPOc2CZJgf5FjNk6/vjyeyWvhVOzmhjLCgD+INSXpsyw14402QUuBdyETljEB5BGfRUFKdhtk1J+WrRclgOFu6moYrsIN4rDcteBV0tyGizRTxlJ0h3rnx35VBCACfU/DN1460+2PCaAORteGoO+XXsh5auCeQ76v1MxHMsRb8wm9JHQfMRWyWjYQkYvwIVYhhIZilBHjRyBAyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5maYcwXemzjUiwttPEOlHkNSdKzdxA1TUTtkU/wvTSWrJ062KKaVYl6iZb?=
 =?iso-8859-1?Q?b9ZRKVfmtBb2EDO68UiayfUdcO54WL7HA/auem36FOrRsxsu9jJoxfnzjg?=
 =?iso-8859-1?Q?7/efv33PDk9rmbQMaz2XRL1pJEvUZvoyvxp6bWaqTDaXGFOuxu81qE0k9R?=
 =?iso-8859-1?Q?MoCaIKYBdTvbH4xQBlwgH3mFHFollXLXE4Q21kiaCClpBIFFVmM3/cebwg?=
 =?iso-8859-1?Q?eIKJw1FGUYcORyZ1bqHKw5Hj1d/7bBxADOp8fMrPp264g5y8Qj3mqO1nu2?=
 =?iso-8859-1?Q?ciTTFRN7f+LgNL5JlNTPIPxtX2bMg48nOhxjRt6e9eKosXT4rkunOsuDWO?=
 =?iso-8859-1?Q?oOUbMvSlKk7a0AeVoeD4MNXHXyVmbaTViGWXEHFmGzaGNaMuhPnaFQ4TQq?=
 =?iso-8859-1?Q?5OLYP/kDMezb5vl4qgzpviG+UR5Ehhd1yvhjkgGPJCEoe9RJadN6Jx5d4v?=
 =?iso-8859-1?Q?lYuUIUfmlMWQFTs786WsleTWhnPimFCxf5pnR9+HGMELisCPDdes8aaKp7?=
 =?iso-8859-1?Q?2iAEJQVlzKIgYJGa1217xBZmussvBzyr2UIj0d7vvrEZDwvh4iRt+fBdBR?=
 =?iso-8859-1?Q?6Yd2e9dWm3iaSHgeLxNhNA4uI+HeKZXSQxRYIEvsJgt01ZNOATX4Rq05RL?=
 =?iso-8859-1?Q?dEkRxQg5hHF9fim+A7nm5AqCPqDg/eqfFosSlv0oI8mbkG3B/7nBKgS46e?=
 =?iso-8859-1?Q?3PgrrkGli/pqHqC+gjeB+vX54qwU5t2mGb/aTjC4RHywNCpFRFb9B7vXr/?=
 =?iso-8859-1?Q?/RQzsNcLr7/uDi8DdOOOjurD1rwKuvzaN8KohoiqLK7GwQWHv6RiVG9OV8?=
 =?iso-8859-1?Q?qG/FkUoJduIzmwEvS8D/egLbWBKhuLsSWhLc1kt4H3u3tvEL4psKbYT2Tc?=
 =?iso-8859-1?Q?4L191J1XE9QWk5cGminsIpQ8td/fDvPRGITCJ6eceqBDAANJNG4ekhLmzT?=
 =?iso-8859-1?Q?gZQwVkD7bIqsNLSYVufU/72iaASueI14+psELWHThPoqq5tdStmLiW/S5C?=
 =?iso-8859-1?Q?U4XNwiHjowwcKbPRKQyMd+crbhr2w6VhPma0DL5eyczUWv1iXAZHaeVoII?=
 =?iso-8859-1?Q?fQ4zw0FSIhpw4QnipVMQps+4DfGyijB+ivvSOCpDfJGFv8qt0NRg++RWY9?=
 =?iso-8859-1?Q?thEMmteHOTFHIwmzz3RgQSXl/Jw+GjG+G7p/IoUWAhWxchqff9PiO/2Tf5?=
 =?iso-8859-1?Q?zLrxlKgMAy2Cde+GHtEh+gM1aGzjzkKkpSXsCKPzZLJ0ZD3GiDuq+w/SHG?=
 =?iso-8859-1?Q?Jdbkqq5vyDlWb833T6kU8y3fF3N2sufsxn+1fdYTWXZgUplNazd4k00Da4?=
 =?iso-8859-1?Q?YZDRxJth+DRvwi6yyHTQPKsE628OSW/Ml0eUQRSw9UcVJjy3MZIaTp71Ov?=
 =?iso-8859-1?Q?/oASjd+ZQBXkcJJMbFfoNFG9WIHbvZZJHjjuAUnDy9aRXvbpsL9bPOuYpl?=
 =?iso-8859-1?Q?I0MgNTfgVpk+cr8lACji3f7CvMr6L9xuogsHPh5qJnEtW9wPxeYLngdyqp?=
 =?iso-8859-1?Q?/erz09x7XOT+AtKOMZa7EVjwF/aFFMDcT38UoxBtk8hHs2Ezn7ndOp+7V7?=
 =?iso-8859-1?Q?Fru4UwEg1GNNENVaHzAJn8w/pva++pnTRT8d1a0Y8AnDnoMJjI9F8R7qKX?=
 =?iso-8859-1?Q?EIhybyrBBBQFb6Cu+YYaSiBKQlVfOlK1UAGPc0tVzo1OGvhZvFmuNkkpDr?=
 =?iso-8859-1?Q?i/LZqztg3d1GFX0uXnM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17935539-46e1-407d-0de7-08d9b4d72566
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:10.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHO0KC0PlWHXHtIjDgP80fU/8zuAcuVdnIGvQGS7tiuwqZQhHiSg9TyfKg4TXyGgfS+d5MNglzNwt4POKxddPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: OMytN7aHT-f1xiWP2Pjh4iFqkHAwrZmr
X-Proofpoint-GUID: OMytN7aHT-f1xiWP2Pjh4iFqkHAwrZmr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.30.2
