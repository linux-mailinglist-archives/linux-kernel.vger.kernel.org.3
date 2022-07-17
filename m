Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448C0577343
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiGQCs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiGQCrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2911A049
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rqu005737;
        Sun, 17 Jul 2022 02:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8Adx7FcdJFJj4jh/Vt0QfMYL5SlB+0u1Qf0GHNkFe04=;
 b=UV8JXGBvkeIWfdEUkR8YJsW6kT1uaxiVMkrglH6EyPALt20xszF9QKQrFW9Swh6xglCK
 P01jeP4aozhlbitG3tMzhb52dzQOTauN+ahrKV04CvgST7a9abF9fEj2zZvz4MIFCTQc
 J/kj5+fU62Fqc+u9TEbvSr4jYWpjhyD3bsCtnWoj6G0HMvYjopDgztm6eP5PzJWYiNFd
 T7PlTS7aG1ACKwug7Gbo9uUKwycRSTdME+0TBDEBo4k1P9vh+b6DXS39HHx0AY224iYt
 E0q8WpH4LLhQQaoMflbKeJJhNznd7WHOxZ2NoEysJnWI6ojk4Uw1PykbdpDM4BPD7qfT tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY38g005941;
        Sun, 17 Jul 2022 02:46:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d80v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ruxgl5ysjvghGaZ3LaX1TRDdLJNcUydbkrXBI/2KE9MDzzFUeyd2xLWlk6Bi9fN7vvfKVzFNobrf0JEYgqExlCJp6EniOIDQvc6VNXk83ctDn4wgdUsnMdyyunMgX/V4Wkt+tbuZP5I2kQA6ct9pxFRTnq+rxzK6Cp0QJgm1pbwG1OfYmu+BHWVNkfsQatjRpXiHFulSwLWskyCUerndzZihaAy99Z71qfp701dTFhwTuxzmORxvbo7+TxY3BFDmGHBv9B4Xx3Nrx/gr9YEGlCDyHIIn611O2fUJmDkwIapXhlUnI9XSsRHNRYYC727OAlY1wWy6ZHJGwI/s9GyVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Adx7FcdJFJj4jh/Vt0QfMYL5SlB+0u1Qf0GHNkFe04=;
 b=koDvNYtWToSzCN5EDgua1LKFqaP65TUlfES/o9mLGdzP0RjgEKmBSNg9NhrmTCbizUwf0CNnOXbFJR/dDgspoDUq81QY5OidATuBrGDwTNKzMz+CnhoxZ7xoXFfCZw5v907vW/2Qn+eJDUvY0S0f1keLe8TB9ZUXC1drBgfjovXaG4juZ+mnmGKl6YTlAhyqjIPoUSfeyJg645+/Vrp0b0NjvWqKa0IinMpg+GX/5Twk2UkeAMwZQoX3fU2jXZsa57KXbgBYONyZPS18PE+YM5tVtRbdATliW//rHJWXgXyawK8Qu2W4HoDwzvpgbs/y+ipkkbW68usGUkbdo1Nrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Adx7FcdJFJj4jh/Vt0QfMYL5SlB+0u1Qf0GHNkFe04=;
 b=K+T8VH2mRfkI8ycXQQjLc0Vb+5CiSH1ZwFpbX815JxshXOd1mHjqJJ5muuaQw8v1ToThAkNy9u0y00f1kqFEgHIGGmbgPExuHW2FXEw+gq+KL1MqhIF4oRrj6cj5Qr1iQ/1JzeolAd3EzurEF3pUa+Npn6KVwhnrINvzTh+li5U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 27/69] mm/mmap: move mmap_region() below do_munmap()
Thread-Topic: [PATCH v11 27/69] mm/mmap: move mmap_region() below do_munmap()
Thread-Index: AQHYmYd04zKvFN5uZUeEA41ui/XmYg==
Date:   Sun, 17 Jul 2022 02:46:45 +0000
Message-ID: <20220717024615.2106835-28-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 946ee7d8-98d5-44c4-afed-08da679e9a0e
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 19LHYb0yHV4KBw610V3FX6ZHYrgSg7Z5JN2S6y7bA+BQ7BKfDfggO0gQ65ZXZk0MH++Zk01VN8+vvJw3BKaBWlQSCtPsrncRVe2r/IAe0/6zHeTWY9nvBJpp6NJ2RNp+by/qtrbot35gMrxd/ufYtdbPRu5U0dyvuCTfYizF1Ay5nKV8CbWIpX396wG16EokS6JNhwAlCD7x0y9V0VJ6D+UY7pvNmsvnIROumkAgOGCBGHrAvHaLPsPd1hodTxD4PZIjSW2626ycWIgmQA4fmfStksJsctU300RINqWxRLkmd4Dbi8j0pz779L50h0F11nthgs3yFKGRKBZouzffxktALchFZYdEq893nWXuP0VxZIDl96aUqAjXPQJjZRZ/xnzR2Slt2FrWkr/03KWcHikNFpYWTGlkBpv2xpgGAQcAESzfl3LTRHu/rrHYDr5Uob8oXs8DoKinPN96VvOY9y7Kqe5JhYDFr5SQXlbYAOZFtQyIL52vKiBGS2V/lj+n7crpdsy5ytL0q1NXz6tXSulFgAvJn0AkSTBoFx6fjVntoOQCkt4rFWIINczrRmZbi8MqkJGGgPsi6IuNVBH3+kX/7XdE0lD0uWZLPoQbaij0BZT+eC+zjcnydpFcbfgbKur4ejlGDOQnbscti7vJF8V6CREy7x2pFThUWLdhC4+PZmFj/qBAgUgkoJGbSDbtUFKk4ytnn6RS/OeRrnmBzrwKAyLPg8iwi4WkFxTSDP2mrot+p2RRpnCoeRX/YbRhZGQsTwCv24BnB6v3e0FGRLuoVUg6FX9AqV9nzY7R3vxFYREgXHnpY18WeUByAzrs5cV07jY1vEX9wwM21WuAxYZw4nXBbKF7e9i2UusmQ1XJ+vSQwi+afCPuiMA2mUi+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(30864003)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iSavOf/9ckXR9ejDNghGDGBSKv/Fw8ZGyV4TTfcwkHm+ZpPwynR0TNbtXD?=
 =?iso-8859-1?Q?u3cervtnkkwL8LCt83emV/FTAMq/QGahwLPRK0ZIph9/Faj6h/oHWCyBfH?=
 =?iso-8859-1?Q?evP5AMHXTKRm2esBGHSwFO4o3ndqUpBEpo9LmC7qnrtzm4XDTc1H5zAsQA?=
 =?iso-8859-1?Q?itFdW6UVBXIKASgxnwcnvdUkPriOCggUJ00HCErMVuGPDtp1G9+RcjRjgE?=
 =?iso-8859-1?Q?XWl+09a0ngfNwV5SfSMPXZop2pjuMXnLd1qy4LnzGiIZUW9noJlT5C9ui1?=
 =?iso-8859-1?Q?FHcr1PL9DqpSozxDYVr8SlhkaSQCBw1WF8WVeNEKUc7L0vegusGQYOoRV/?=
 =?iso-8859-1?Q?+Z3D3TWOddfugPS1T/CYHGPMu4InCuMeZNp8ZcL9+hDbt+gF3BJ23HSqE1?=
 =?iso-8859-1?Q?1RQQI7WXDQYXMJCawTsVQJ9op+7SN2I/idH57QiqPiRpHXGh9VwG0LjZML?=
 =?iso-8859-1?Q?8KfXFtoNxNVoY8wa0M5dNif3I2uYbiKk3a8v0Nc8JPeFkDks+r1aru76lM?=
 =?iso-8859-1?Q?Xi3vqOEYagYtED23UyK1ME0nXOoa2z0OzghAo6di2rU+q4XXwGEf3dBxy2?=
 =?iso-8859-1?Q?m3Jjz83bDRRGxSmQlYjjQ/NUH61R6vZNpqJIXH3xvSw6IFYQSN01lI3vXS?=
 =?iso-8859-1?Q?JPdDLqFbiRI9zjOnYz6DaHk8g+XekuIu8WvUmRMvYpINy4lTK/xiCbjs7b?=
 =?iso-8859-1?Q?p5QzW9N3WKvJ50S0qORUJOj8hAzwZOAPO9NwIKH14+zvCafs7g+BzxQRqK?=
 =?iso-8859-1?Q?QzQyIHTg9YTZusVet+n6rOSRo3knxjfr/nDWMKizrc3uaWoCOdH+5qlXqC?=
 =?iso-8859-1?Q?RqLMT8DaaRf/sIO5o8Dtw4LneVf7eV8WxoMe6ZW7EaQSuNB3i2CxnvnACJ?=
 =?iso-8859-1?Q?x6RI3bjKCqn10gSrcRT+FOQTFvOuwsRLGCBO0vfEmHZ2NWvK1Wj9PTp635?=
 =?iso-8859-1?Q?oXYE6TcQJOg4cjdFJtn//XBCWku4cjJi+lxrkqhLZoSZ9cNXveHuIXQA+Y?=
 =?iso-8859-1?Q?CbzYy6W5VEArUELzpdJBoMxSZ6wHrXOYi1xQYiC+yU8HrH1GIEoLrry4Ad?=
 =?iso-8859-1?Q?aOX5eJsziiZ2ZGodnbc5BwqbQKM2fzvHHrwFfDELFPvIHIcvjENIewoOkJ?=
 =?iso-8859-1?Q?8SzSH5IhgOhHYMPBcF8p8US7jq9lkFo9ITLBwocsCct+82CNnkdxwurJVO?=
 =?iso-8859-1?Q?zp45Oc0/yvRGBGgb4Gq2hqcewB6nomAGrjuOiSx+93pYoCCmttUj/Keq1Z?=
 =?iso-8859-1?Q?1HPICWuR/VTzv/I4wIj5c+pVeyfrESo5B+HBC/V4iUryTW7hvGbrSZq0Cp?=
 =?iso-8859-1?Q?EvjljA9YUPnVz9ND9qp4FqaVfiN9f3l3zF93salewZDqdCVAsOjJwYulGH?=
 =?iso-8859-1?Q?uQFA7eDz+5zUJ+0+zACWU+6Teb/7OpbfbiDpr4eZCsIa1udkasHniog9WE?=
 =?iso-8859-1?Q?/tbts/5yNWyTIyNdX9aLJ2Y3VMJVY2aEMCT7XRP3PGS9a5YCFj0leKnJDk?=
 =?iso-8859-1?Q?osySOPS12vNTRGO97pvhmbQslhr87ZeJKF4od25vS7YNzAOc6wIsfFEPSL?=
 =?iso-8859-1?Q?O+NixHpfShtAAXuP/rTWawg1C8hwQepGg/maMTBL58kKiZM9eUGHdMVnDU?=
 =?iso-8859-1?Q?gMi6nQz0QaZUzIQ3CMD/Rrd8XevQurOjtYdWzN+cvgJPCA+EBSqpTFxw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946ee7d8-98d5-44c4-afed-08da679e9a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:45.7404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2mJPuAY4fR8iPlClmVEpoVG1UztHCeqRXEnmaf5tyYcoKgVDgS0OivXS39zyUJHYoZQ5otuvriGZcGzXFjhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=909 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: Tz9RFAmmpOHlWF6gMPGI05_mtA5zBPku
X-Proofpoint-GUID: Tz9RFAmmpOHlWF6gMPGI05_mtA5zBPku
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Relocation of code for the next commit.  There should be no changes here.

Link: https://lkml.kernel.org/r/20220504011345.662299-12-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-28-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 492 +++++++++++++++++++++++++++---------------------------
 1 file changed, 246 insertions(+), 246 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c70905ebeec7..582597391899 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1771,252 +1771,6 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE=
;
 }
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
-	unsigned long charged =3D 0;
-	unsigned long end =3D addr + len;
-	unsigned long merge_start =3D addr, merge_end =3D end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |=3D VM_ACCOUNT;
-	}
-
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX, NULL))) {
-		merge_start =3D prev->vm_start;
-		vma =3D prev;
-		vm_pgoff =3D prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
-	}
-
-	mas.index =3D addr;
-	mas.last =3D end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start =3D addr;
-	vma->vm_end =3D end;
-	vma->vm_flags =3D vm_flags;
-	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
-	vma->vm_pgoff =3D pgoff;
-
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
-		vma->vm_file =3D get_file(file);
-		error =3D call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
-		mas_reset(&mas);
-
-		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
-				addr =3D vma->vm_start;
-				vm_flags =3D vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		vm_flags =3D vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error =3D shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		error =3D -ENOMEM;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-
-	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(vma->vm_file->f_mapping);
-
-		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
-		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	}
-
-	/*
-	 * vma_merge() calls khugepaged_enter_vma() either, the below
-	 * call covers the non-merge case.
-	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-	file =3D vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
-			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |=3D VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	validate_mm(mm);
-	return addr;
-
-unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	charged =3D 0;
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
-}
-
 /**
  * unmapped_area() - Find an area between the low_limit and the high_limit=
 with
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
@@ -2891,6 +2645,252 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
=20
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *next, *prev, *merge;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
+
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX, NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma(vma, vm_flags);
+		goto expanded;
+	}
+
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma =3D vm_area_alloc(mm);
+	if (!vma) {
+		error =3D -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start =3D addr;
+	vma->vm_end =3D end;
+	vma->vm_flags =3D vm_flags;
+	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
+	vma->vm_pgoff =3D pgoff;
+
+	if (file) {
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto free_vma;
+		}
+
+		vma->vm_file =3D get_file(file);
+		error =3D call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 */
+		WARN_ON_ONCE(addr !=3D vma->vm_start);
+
+		addr =3D vma->vm_start;
+		mas_reset(&mas);
+
+		/*
+		 * If vm_flags changed after call_mmap(), we should try merge
+		 * vma again as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
+			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			if (merge) {
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D merge;
+				/* Update vm_flags to pick up the change. */
+				addr =3D vma->vm_start;
+				vm_flags =3D vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		vm_flags =3D vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error =3D shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error =3D -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
+	/*
+	 * vma_merge() calls khugepaged_enter_vma() either, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
+
+	/* Once vma denies write, undo our temporary denial count */
+unmap_writable:
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+	file =3D vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma =3D=3D get_gate_vma(current->mm))
+			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |=3D VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	validate_mm(mm);
+	return addr;
+
+unmap_and_free_vma:
+	fput(vma->vm_file);
+	vma->vm_file =3D NULL;
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged =3D 0;
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	validate_mm(mm);
+	return error;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--=20
2.35.1
