Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760B6465017
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhLAOmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57770 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350208AbhLAOf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:57 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDQAX010074;
        Wed, 1 Dec 2021 14:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1ugJVGjwwS59jy2k0qKvVMujjd9sNhvUB3u/ll/nJAo=;
 b=FzQFsQe69jBV1/TKGI4FlvbXBQbSFzKjC9jLrScUoaeEXKNmtqb86jeAYcADPc/FqyeQ
 jBg0M2IxCkcv/VGtBD/scxiKUeUvlA18SKNr2A/LtInFD404pc8GWWCoMuISBCK1PH11
 Q4AUBd09DGC3fe4ktSkk5hXF6X8dJIxeVEFIxWl94Kq16OLgVkJkEc5I8UPqQoHkGGrK
 UJAvQ1hPSxPMVmI3JHeNG9o5cXdhpHLLbwREMHmwSfqZrUvgdee9X+V1d8RM17/4Q2eF
 qdI0sMHV/piaqVz+iq3EVrIJ1Oj1voZWRGRODzfcxSsy89eTrW20xggrON/MxON1If1t Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBlwY109866;
        Wed, 1 Dec 2021 14:31:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3cnhveqdaw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhAPTcFUK9X0a5pu3Bfe1Q2UGl/XPwPp3v3Xt08KwIZov0PMDos5pRr0AcbIOwOkxdPJJQz5NU/bownbvDz7Y5E0XHbVaiGSebgm6ZOg8Z5lyj82aoIbBQx7tSO98xBufUFdNskFz26tGMdqyuFFq9mjUlBIdZHCqGadpOuvehpYNMlL3c59qHlaVj7oU7UE6aRc+mRmP7lfD/A+lKDr/i9OvlDEY+KKpWTGbVUFQmWmowpudcpDdPgh7MYAO8PqwXBQ6V+tnZA2ecN8/PweyPTiM721HiVCJTXruv54ngalfrdv9GiL1gH6oLu5U9TN8ZWepzx+fVFtAsm15i6qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ugJVGjwwS59jy2k0qKvVMujjd9sNhvUB3u/ll/nJAo=;
 b=fClRMOkOuNYGF+sKO0a1kpDE+6zOXba0bgitSie4xWUuuZTdy2vIOhHJYMF/hDcY/tGIwysyECWQSnwU4eQrisVFpEzR1K1bsejL2evKXRL0dbWRYnfsctCGgR9tHzU/cQb0u7lYcUu61QVLLBpUG+p7maZCDqf3wf4yGp6HFQsoJRbstrbVj9/D2kFt0onkPe3mB94yVpzhoSSTeJaK4yH6xc+YEsqgnJcJWUAaRTnsTHYh+fUo72ihKi8M3I7732QR8+ZRz1RPbDVS+F11QVeToygl0xs+fybHWzGW1sHA3KG/eYIIeS60y0VjQCcoTXE3p/nE0hFtw1ZklhNUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ugJVGjwwS59jy2k0qKvVMujjd9sNhvUB3u/ll/nJAo=;
 b=TEU6u4ytsP/v5cfQ47fnw1djVEszMP3MebLHaoiOF+v9umUrLrIgfvl7PzQFyX3mQCWTgEIWO59zmAcCJJ/a+Faxlh7TaaR8UNk40XTRTmP6ENjIYKxIutidxIKHY0rgG8ppwZGv1D2slGq+Y/3gSP1ZGTF+rTbRP5S2DTNbaZY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:31:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:31:13 +0000
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
Subject: [PATCH v4 62/66] mm/swapfile: Use maple tree iterator instead of vma
 linked list
Thread-Topic: [PATCH v4 62/66] mm/swapfile: Use maple tree iterator instead of
 vma linked list
Thread-Index: AQHX5r/5Qu921AGvnkWSJx5zNaXLdg==
Date:   Wed, 1 Dec 2021 14:30:24 +0000
Message-ID: <20211201142918.921493-63-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: badd6748-6440-4489-9ad4-08d9b4d739f7
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB2464A3D05E550A640BDCD816FD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WsqOWpvSxXS8+gdB7q08pVnfSjld5KCvIfXMWKgWQScFT8vXdknEmzCQlu6HVUDUh2iu2KWvJNqLp8XyZuWr8YdKOuklzt9P8MQ7hWee3AE5ankszC7ucRfeS3Q/YJht/wS23OJcyIyugZDyT/9iHj2FTSklXwDiBmz4wQ/HcVi0Ld6k17Pw+59ZQ7HeyO/dwaKarypisrNvYfmbMO76q/CJzRPp8IMZOl8K4h6lR6COmLHbdTvDRYBWo+pMH5A3OgWlxMnBvOddFR1ndJEpCQSEzUutZuD+v/C1VOFYCzA4Z0xGDBz+FBsITQdlQE43zsuHbwkSrv7tkLmhwviVu2UGgrT0xlrZYOo87AeR8uOvfRpfrhVSY5fM2PnbofFrgwTypTAuXCxrhzITyD02QfaKQs1R/umGakzvnHljebLw459jvTZWUut9hUHfy6wG7E1NxiSvY/IzRSxGeEkUKZWWzxydMw45TqFBlgo3zizEM4t0MpEHlSensRMbNJ6P0HwUqVOnKBomRx98eb68emk7eToEVtr97M8TmzRyEg6Hh4IR7ZZJVr8J4YxHOP+CI8tUrERStlLyOof9fF0JppP6sIcmLeOIknrQWCzwVSgmmdrOZKsrVy+iIk/kRtlbo/CWJn93K59u2HmqxbxbYnwSdlOtPuzrXNOjAkftl5LB8LsVEY6RWf2Xxiwuf+m7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(4744005)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yGct91w7kPnHfrXMh850GZBgSDxQY4EDF+M9x0zBC1+WQxbA1vtKZFLBDj?=
 =?iso-8859-1?Q?7pT+Pxs8Ek3n1bwC9E1V4QbZVFhrBdYvKHPqyH7gBrR6XnoNuxWtF60aAa?=
 =?iso-8859-1?Q?vOW3T2ivt5w0QPyqxMfKCa0JxhulMx34Rg16UAlbuRkn7kLePQlbWG6IWh?=
 =?iso-8859-1?Q?koGVJQ8kKtR+rKtz9WoW2zG5zpR2h62+Vevqx/QeTnQVE3YYixmRcbn2Dx?=
 =?iso-8859-1?Q?3dBDqLd86CveEX5fgYN3KgXq045rECEyVf8x7IwkK4s3iGHwUVB6q+UTAf?=
 =?iso-8859-1?Q?3udRrrz5nSrZhS3jAL887S/SsGDY6fx7dkTzemJvRAcWMp0SbmEfQV9D1r?=
 =?iso-8859-1?Q?Zih1XrLAiIaR0uiTBVH4WmNqoKajbkGm1/PUY/iA0dV13on1QZnytY+CKn?=
 =?iso-8859-1?Q?MrbnUnDg4Qoo1sn7uaqycz80Qk/SUO7AYCOHRYyTUU1X5Q8b+OIyb9Wdl7?=
 =?iso-8859-1?Q?f/6yj6y3g7LUltlNO3ehZ6+8I/rgUvHscqEkmHmqMEGTb2Gw+bQonBWIV+?=
 =?iso-8859-1?Q?t+yziiklE7R/1k/rzG6Ue724CmjeRWWqI2Oisjc9lwrXrUADP9AFLH/jqd?=
 =?iso-8859-1?Q?BHRNl1+0cZDIxgtJZC9w9ctDUNTmFmMnCxbKH+MDICSTOMDW10I550e9/Q?=
 =?iso-8859-1?Q?6v89TTVSpTmuDWxyYF56yovuSyextlFuPhPaN9KAQTGtHThLqWSIRnmpNk?=
 =?iso-8859-1?Q?crgz1Q4Ulks0jbbj5cISqVVkqW1i8RyQLFci2VG4AnjbpV7BAt+3iJiqp3?=
 =?iso-8859-1?Q?Vt8xB/dC4nB2IKpvT01l8wLHomYFRmqFt8XMnufbWfVF0nzbnMqCt3jume?=
 =?iso-8859-1?Q?yv+4yyyLumN0gcZtBzb+iHuXiH5mPJJXpB4jRk+8yskMgqdHvYxGgrq/Bq?=
 =?iso-8859-1?Q?g+9UsHAnQzkxItHvdKVaTPH2f0kRj2EgqB0lD8gMM3WV+Sjap9+pksbCq/?=
 =?iso-8859-1?Q?0uxEgjwWu+w3++/B4Uu5OSumbk+sKEKBDUyzhsZEgMHqCekh33h0ZU0vyT?=
 =?iso-8859-1?Q?Ipt6GaWzXdZF37fF+oGzOTPRsYNSa9xsmT/pWBoESnKx3SC7LM4UyNlMs9?=
 =?iso-8859-1?Q?9+PSEm+tLXLx3ClIqgKV1T6V8UubkZu9206plHIN/TGSciSTmgI52Ne74a?=
 =?iso-8859-1?Q?aOKR2vo6s80Kgk7nH7trnF7+RNNuTCNR749wR+XqmqoxW4GFA7NebJr2I0?=
 =?iso-8859-1?Q?eCaOF0bkzomMaWXIPgkgnFO5XjYCYXtGQX/9on6LI19qoi1yEkHmhncICw?=
 =?iso-8859-1?Q?sbiNnqstlXd65GWFI1Csam9NJzIyXDGRE/evYxWhxHI+1q6fZHRa4bulGf?=
 =?iso-8859-1?Q?MPjhwVQMnPd7+X3MZ518fET84Szn2PBk3WaZvOgjU6DHw1kLpnh7AOtSWM?=
 =?iso-8859-1?Q?ceh1zPQWbAMLgTCaBO+p4f0Cr2q7Gef3is52S1RiY/yqY45LH6bA2vAUBS?=
 =?iso-8859-1?Q?j4+SUrg8C+0rGdB29Qr2lEwUkQd3L3kPQBxBP4ltJV+nHJLXGvkDNsRhaf?=
 =?iso-8859-1?Q?vkZtQakBjHl/amIoXrsy6lb1hczW8FojCjuGJgsU7MbJVd425DxkNZbSDz?=
 =?iso-8859-1?Q?NSryxlKTcWF7sQsXI31WXtYsg5GNZUZCQJlGrj6IH0Qank73CqdtiRXpwR?=
 =?iso-8859-1?Q?MWPoxDYjzb5ZV3nJpHVplas9iwE+TDFA228g/Og8Q2WyG+k2ihXfsOOqJx?=
 =?iso-8859-1?Q?Fo54c0c+IWfsRigljBM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: badd6748-6440-4489-9ad4-08d9b4d739f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:24.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V44XUZ/eYQPLyTLOtwmRloT6IrjWl1jcQzUWEr2zKPeBvhA8vshX7WutWtUSMsjqf0ffsD7ZYaj0JyNza14fAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: 9UyFR5tI1o-nFj8YNvaaNTzlwztzFtH9
X-Proofpoint-GUID: 9UyFR5tI1o-nFj8YNvaaNTzlwztzFtH9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/swapfile.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e59e08ef46e1..21c88b0944f9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2103,15 +2103,18 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type,
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type, frontswap,
 					fs_pages_to_unuse);
 			if (ret)
 				break;
 		}
+
+		mas_pause(&mas);
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.30.2
