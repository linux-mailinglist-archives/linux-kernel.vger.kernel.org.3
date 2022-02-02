Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5D4A6A3E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbiBBCqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56444 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244301AbiBBCnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:16 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120MghV026641;
        Wed, 2 Feb 2022 02:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gCknud+XMrh4pzBz3sLyknQEGD3wFABOsQM2yQXsGvQ=;
 b=vHHwqaEV+WmCujl7xKJoA8ubUP5veFvh+dBuq+SilZsZ0EHVnGtFngr96uLKjawQGawI
 87EhMmF8Tz5uryxROtKNxS7o3RqXypS96e9JofhU/b50/1Pmm0ow46NLZcz6ApBJjdXm
 8cZaPbqJ4fYn4klA/zKLJqa8a96p6uZEEKpG5Maarr6FuaK1NA1fmoZlJrYb6BZQnAoR
 eOC1qqnI53HPvZcs2MDpRNViPlPNT9KZVHk5tytrJODohz6hFUmV/C6HzxF5hnss7dvs
 CxomNuCKfVfVsYMLOWhKdpG930m1FVqR699z02w0prRHAXqn5I6L5Ra3k3YJC8tlJcqI 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwri015281;
        Wed, 2 Feb 2022 02:42:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3dvumggud1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaZuirO0Toy4z6CIKiUErt4VqDvHgacSB7xCvoW0nOwjIGA/0bEJrVGsTBq2OlHJVbsnwweuo3G+aT1GLdgudCDzl5k3qC1xnMsHzlPvh9tWHndZcSxbdlZBxM5E/CnqSsc9XVjXynWbtx5YssLZDVzUxutpZMFIauOQOIfRG1XOvsqh6Vxp5BiOui34LmNsJooktB9qfvuXII4J3UHUTRzUZ2ltvIkKQhppWMbmGo9SLunLGCASctduXzYDtDEddrHIkVdKumZEPTFwDBwRH412uPuJiASIRl+sogEdL/Wg417gT3FNI0zhJCUR0AXNzBTIH/Gn56vtpoAKNb0Dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCknud+XMrh4pzBz3sLyknQEGD3wFABOsQM2yQXsGvQ=;
 b=iMlafuOjAO0nb8XXgazblpntYHCwXqhUcGSnZjGGdaSvtaXm04z7H1Wnv+Nij55nrQTx1iNrOTtrgkUE4BU6m0bz3V9SMLoLgHSKsbd9mUbKhV+u4qbXAVqMfbqdMPnM4O4F3TcPBn1wgc9kUWNPzatTuykavgisOqkIOdsxQbZPtQv0ig8wd73KV5Mf4Dkt33bEm+4PxvNp4nB+5nAjN+B/T1S4xUYoWxJwEuXC7s+4sRQWWtffdlrc7jn+K4XQRQGh/KsQzwKMJH2W62r3jRM6Z01eDOmc370U+GB19Hvdf7HtJHLjfU9SxwciShGGstNzLXFWZQXDmDllw/wc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCknud+XMrh4pzBz3sLyknQEGD3wFABOsQM2yQXsGvQ=;
 b=il6lUg6a2wkOHRp58hIM+/hZZP/eV/DK68LxTSUBRqtCCNiiFlM29Wg1CmZl3YE3j1R6geVKljueLB0WsJX8NMtcB1art5GM2+/MXlp7Z4lQiKVn8y21PHweEnF7VmNmzC7ZdjApVi7x/74BZ9wSy+9fEw6TeBVV3WfXANg4Lm8=
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
Subject: [PATCH v5 50/70] fork: Use VMA iterator
Thread-Topic: [PATCH v5 50/70] fork: Use VMA iterator
Thread-Index: AQHYF95/jolOwwAdRkKPpTSZb5hzlA==
Date:   Wed, 2 Feb 2022 02:42:19 +0000
Message-ID: <20220202024137.2516438-51-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d879779-6c53-48e2-0b1c-08d9e5f5b708
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865D507C7F3CE0BA7533142FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YP92B1zB3+VBZc2oAKRF9NqLfxNbe3d4O0zPcnzpKVdBTXAC0vr5kG2YDdnpu+2j5beAgJAgcCw8Yu8LBuSMFwkA48IPI9ZZ4hDkOilS3tjP8wmo/Lp5j5x4H7C62JUI0W0KcMnQmrX1zpHyHbBUgwSFSTWFL5mc5WRV08RT89cjlvy5YNNTZSDQOJAJzkTkfY2Mj1Kyq8AQzwMMO3rrGz2wV0mSQrPXDC7wembJLqOg7TfgWh7HvOn0R/HX17+ITBPa59tmjkg2rm0AJnTSmkx0NQVhOHg0RUMhb9afLLMd9lu34exfmRKE8dMgOd1He0KtEesXDMBo8DWhJ10wB+hRbpZEmtB4i034gN46lPbg9JI4ks8e+bxcgC5cCoFdb8q15L5AmLzLkKfy4CtPYr2BR9bobjlcxCpO5FITKKlVfYCGr4iRFJr+pNvrfcgzL8AC4kGnOT8lvLmrd4850+yndpFDO7fzipzCQ6ivRMxgOVLLJmps1doy6HApJdc51UvkecJzKuP15khqKMkljY3rQ4c6gfwcoxbgOXd4y4Xq4uLmDn3A0ugoazub+ZunxXIHqtCkXOEob04yDm3fOH5kcuM5IXSp6EhJ3AtqIw8uWCH3Mn7LfkYxsnQdPylUsg9miBIqwU2AfeYUP1QHx7pxoaP/uAyjmhkL2yn0yvbryTZ3pVitKp2xXiohMB0tWLZCtlP7rXrbfAE5/UjtPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(4744005)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TV5ieWu4Krr4n3OEO4zsQwxl+MMdBylSkKk7z53iaV/pnUKmHVhSn7+Zpz?=
 =?iso-8859-1?Q?mwMo+JokzubdvgSeqWx0jcxDTyycoRm3G+ejZ7QjwoHSKebDk9ir6iNsd3?=
 =?iso-8859-1?Q?VrfFT8J3ofouo9zMJcE6rEzxK2GXDvS+fZ+XMwk+OWCioSIRg3wB0I+doB?=
 =?iso-8859-1?Q?9q5hTrP7yD4kjEVwnncWcoBDVBlxhmTgEGe9jXiO1oD5AH5GAA1Z/a3i5G?=
 =?iso-8859-1?Q?Vz5sYoFz4aN7isCrJFWQj9Xrfa/ef+A6tdd6NSM69rJqksH4YcoMESPPMr?=
 =?iso-8859-1?Q?DoZBYHBbRJydpE/i73HEIqudG7U89qzP+jE9MVW+JH+sf5fX1XCpbCjUd9?=
 =?iso-8859-1?Q?F/t+2Bs/18KIJsNCFYFXu6Xi9T6fRRntKXGf5XqXGHo2//VfBOK2XcIlQw?=
 =?iso-8859-1?Q?LGS6IVnq98Khm2bYMwQ7TwaqgJ/rnw09k3HHb2FyO8Yqc3mXpZuUfN6+zA?=
 =?iso-8859-1?Q?Zsg5Rq3gP4mByldm7babe37WTF5WBO3CsFQ3NdTdTh3uuS8afQ4BbGUYUB?=
 =?iso-8859-1?Q?swN+KJmpRVkKPBBjYJRLL2/DiNAJ7Zok9Z+qrNhYOzLJ7U70RHoBgatV2r?=
 =?iso-8859-1?Q?PppBw3fIaE9HEdGx4GxwLVK7R29obPegx39G8C6QVwLdU/U4ia75PpQrmX?=
 =?iso-8859-1?Q?tSB0pGvPuMAwxah7kdBOKV8coQIdF7EIGtZgfL/Kzkt0y69vtJG4Yt0+hR?=
 =?iso-8859-1?Q?/95Lkhsh08NwYItiX8ENdSHKaOMphq5ytG7W4S8XGBp1JIvYGLJZsl9NvM?=
 =?iso-8859-1?Q?vQn+Mkb5kWZ3w6JI5nOxLFD6LDGPGsMDRh4Q4Ypk2CCaZmsvFp3HulO1xA?=
 =?iso-8859-1?Q?001SQHEVXgDAZHUNBT1DKWuB8ZafvAaEd3X69gY28UbpSbXlqJkFIf0V+M?=
 =?iso-8859-1?Q?9Tj38N1uEAoRkleJ2z5H0uVo5OIZ2ApiPLv/4R0W1knTfDVbSpE+ADHhMY?=
 =?iso-8859-1?Q?wXEihGSENi/4xE3NUC23eHSVyBQeqi7OPlpSwYolIE8AjPAdJgpyU0halH?=
 =?iso-8859-1?Q?DTOoCussPpMWDdngUg60gpZLFj9wm8zpEXOl7VKTLQ4Sxg6epEeBmCAdsI?=
 =?iso-8859-1?Q?/QGw8OgeLSY51dJzoQrEpaMGnQhvkmR5XRgNza3V1t2inQzeV9nxWPxpAn?=
 =?iso-8859-1?Q?mg4twqh9u+QlhJtUECD83DaBl1C0bOOydiM2mlYrLOtmNQymG+5xo+RcWE?=
 =?iso-8859-1?Q?FdjdaLoYMdX1oexMsgjRTtRGfV3nIwn0c9Aw8/9ANaaAbk+iICBOzMCJCN?=
 =?iso-8859-1?Q?wwUAt5QqhHdxEsTCs8FRC1Xc2RgCoC0VzSiDeHho1rBa2QrR3yA4VVTZs7?=
 =?iso-8859-1?Q?5Bocq5AzuPZIQ1pAPB7j2tt1jHfuliJPTrFfquqMs5QgYvniWmcGTH/vQu?=
 =?iso-8859-1?Q?TUzYUgnrNBuIzSypns0uR2Nh1TNdIR+Z3vXMbvzD2/CMMvjU9ipCUg2jwa?=
 =?iso-8859-1?Q?JxBSmBa+AXo10BgpTQsWAFtR4rHgyJ0f32Be8WAWIbMdzXtgH4+OecD9CP?=
 =?iso-8859-1?Q?otJFeXNJlvpoezK0fZzPxrC23NXP/PVw3Uat8rSsY8p9B8sF7Y38EQBjPh?=
 =?iso-8859-1?Q?HnuLeYJNoJcEduI7dDy1JuG7XB9HNlRXXDBmv8i9PbgRGj9WrA9jiNsaeI?=
 =?iso-8859-1?Q?RXsMdo0EK29Dka7kSkHGHonABZhVGLcI6MkIzy4v5Bwit0mlQqlvKu/NI8?=
 =?iso-8859-1?Q?5E1TBkL5aXyejcVMh6w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d879779-6c53-48e2-0b1c-08d9e5f5b708
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:19.0947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiXvrCfmYZt+OcFdFeF8SftAHMGdjG038lJS+SHtjsLkXQrW/aJFNtxO027tQn6nYslD4TWCFkQS/5M2fNdH9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: QLGHytdzbS45Ecn7EaNrn91J4j5rlHMS
X-Proofpoint-GUID: QLGHytdzbS45Ecn7EaNrn91J4j5rlHMS
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
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2a17d348c3a1..c9f3f82e5a3a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1229,13 +1229,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.34.1
