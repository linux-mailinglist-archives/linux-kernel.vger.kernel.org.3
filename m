Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA56553C17
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354822AbiFUUvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354656AbiFUUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D12603
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJDHrn011633;
        Tue, 21 Jun 2022 20:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FrnZSVwGT62KSWXaX3hkRfab4L+7GzViByQzsjpctpk=;
 b=b6AVfXLwKE/HdEJwss0BNskbVXHEyQm1f9rWl8gSiKQFRQBDKbAt4mWavI0HVnCTW2Fq
 enGXVeiyjjkd9xiZ2XhGJdqG1W0zPsLo9VoqzzE+qIZGQoez9MBLIEZL15/hx59LdiCK
 2ZgXyrKDyIVzHN0JEZtOmjT1sDelDQM6OQoH5gUR1K+SzytoNM3RK28Ce1z6emknhIAj
 GGAHEtO+fcFKFwCujz0ov1Ude2Bi45ZPRa8yQJnF48p58uSCTGuh/vGmiwFMkGtJ6pob
 k9QHPhpw3WoJdtJWawpUJTHbozuQivYvLkqCmVCBc/ZjO2K3agDtu9/5ooUs+LTX5y3s bA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYG001682;
        Tue, 21 Jun 2022 20:47:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed7R/adptxAhmAh7szJ6zP0/WkTNfdop1Jprk3QxVG3EwNW5VTG6TayY67PkWhzzzmW/EIm8h/WI0HzYVNa7zOKU0kAb9GqmBv87gNrVnK5evTDs6msyLThq4/n6oApO4jDRbk924a42AyceuMqLGEF/YoyKKh0bx01TKWt6oPq06mHiKwkePuICQozeJ2DgTfHMyD3NhgZGmaT4RngEVvpkIZ9fYfjBHQfeFm5Fd3WCl7y7f+0J3M76/nY4I//KgyJxfJDKOsnsA0urieoaqfC+gwVeNvBmuPvQ7kVMzyEhzQX+6GPVqICeiAp3qD0ibkju73gD8X81637nYOqePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrnZSVwGT62KSWXaX3hkRfab4L+7GzViByQzsjpctpk=;
 b=hkME5v0PQigip/YchUHSHdfr1FcmlEi4O/zFFKc/krvIOdS/EjHZaNdQzmW9qu42gSIP2lZfxbp/s0sQoQX4kVgKgLTgZzLeS6tGhm73bcH1k2Drf4Ghie3f5qexXSPEOUQgM3JbSlRSz1tMjX+5vUPcwxnnnPYkLQ2C0za4XJ4sqzqQw8SIQz5p19ML4GyzgqsAM9cBvQKzH8y4X9xx3cN4TuxaZ5+BdHQGn95uYCzukU0BAeF5WrmFFV5fzTDOvX90NRTpXMo399H5I5oGztRhyGsKKr5si6kXDQReRI+tDqmpou/0iw1ix9c+H1kgJIWuzX9whezRSk3p3zt34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrnZSVwGT62KSWXaX3hkRfab4L+7GzViByQzsjpctpk=;
 b=E06a78aLg/Gv9sugLi04IJpr5EUtkJK626gab7UAJXIlSNW1/zM8oOTI+11LnfhgSfmtOKIFgJipEYoLJxQPFMpdi3cwHXhlPQZJtOD5zu1suFeHbva0k9WJOGCK8Y/3qp7OQnb32PLuiWJtFoHLSO9TYQRCF5GdbMLOmyo6drE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 44/69] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Topic: [PATCH v10 44/69] userfaultfd: use maple tree iterator to
 iterate VMAs
Thread-Index: AQHYhbASx6A3IdF5q0yG48RBz2+sxg==
Date:   Tue, 21 Jun 2022 20:47:07 +0000
Message-ID: <20220621204632.3370049-45-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f76b8343-d48b-4e01-1c4d-08da53c74e5b
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392E5FCBE60CCF0606330E5FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bped1nUc4nSee9eiX5GY4dofhX9lSwuQwkESxVg+i67vR2q8JG2DerbtPDYS/3pOGP/ltNtX9/yozDlhY3NqozIvMBYQbOeQoFVBBnTRzyIKFh9VHYijXOr3AgHOlZIekgABuaC0PwYP/1I0einzEVcd+6XKUMqDt+VMZzvrRoNSEiUMLxkheaqcWViDJDqrk8U5UP+xlyD/DSaCvlYmgECLKiHDXrh8iuwmJqOhV5R0RTYkxlveYF/YBXuQcLjbC+J9YAuU2UlwxO2cY3B8jbc0NUs0FZ+0xJXyZY2Rl/BQfyqV1c8GgFL6Q5mWYNwu2ETUjTxoDsBJHZfTvFUCknRF4ZHaAhSQHvyTMKIvZRBwbDHD5+cKqyuniPHt72e27PjlmZTNJfsEL5WpckOEpsFAlLZmdRak/QE41kSti3Sof6dXkhB/WC/iIdhxldZrW6/wo6LVm5xvoi1mLhKijP0TmS1znQIxi1+cl83Yj+an2pNMoRj1FC0nVQu/oRVJzWZs4o87vqz+iHSOhlOEGV/WK/4L+3GBjWvq214ObJs/WzbJO6ct4thCujfLKTSHAqL1xWH8fI6npDg/pbFKoN01YUY+pjeoywoPJ4i6wmE4kYzIpYcRxUqcMppVR7lCiSwY+MUruBwH1iNNmEJGVmfziooDegX+syOeMqgGIit5SQYKWLZkywVgUxunoYF8u97y+PQ4vLD6lD7PGJt45NW5mgR6UaDb9AI0Ey+jsyShMy4035/fB4jsl7IDCvMDMQO32pqmh0Bupz7KjZhgl/HRZVbxOqFUit8948+imXln3DBMIRKQaMoqPHSgFlzD4rCGqHh6unm9IsRRe5yL+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4WOIXTlHmBajl45FqLTH1WfRLPTq68W/LXjYb1B6e3lVbFOPXaBBaNs7gu?=
 =?iso-8859-1?Q?89gNuXNQX7MCVu9eYDy5AueMpPuleHzkze18DEprE/b2roC9aQJmaC/BaQ?=
 =?iso-8859-1?Q?15PEvCCBS7HEWALiY/YhcTkvfZnIkVjuvjQogpTW+1HAyeELuaoS5LFrjm?=
 =?iso-8859-1?Q?dMR4gg67hC8v910CSZHaoBscnuR2ueesfCPynch9UPGYzpr/y1U/eVnF96?=
 =?iso-8859-1?Q?b3nGc8n/Rpa3UBMEdpTRFCTzH37z71BZC1iAN+3nZ6rN9BQz85KpJNlNOl?=
 =?iso-8859-1?Q?8mWxCvRVK1bXiC9f1HvutZLWsXo6yC5YX6KCxskZBzbmG6F5EISPUuIATT?=
 =?iso-8859-1?Q?9oPGrvtDhrA0ynUpbWxAXMzr+ZZXKkeY94f0erKhAfDXnF/iQOXs0KZ9i9?=
 =?iso-8859-1?Q?ORgEIgucZZ5g9u5UQ1aABrOd/vMZMgS+CxKwWy760yYq6DLpyiRi0R2/vO?=
 =?iso-8859-1?Q?FO1DhRrmD1Uomvt2+AS+blzbouvPdb0Phj3uRSJ4k76yGQz6eJd7S/6/Lk?=
 =?iso-8859-1?Q?tG1WPJZdjZa55UymCLhG7mW9+7qiZQRcCrxmn7UTmtMYTJmpm/YWLMoIv7?=
 =?iso-8859-1?Q?j19nHJZr2qPs7Q9AZr9uenGBgW8/4Kzyi+d7J17s89iz7MIvAtF821ISPl?=
 =?iso-8859-1?Q?oJp0x+dFztzyV5lguyZdXcj3zmBIWTrGU1zqwCS2CTfUB6/q85F3RlrJ1x?=
 =?iso-8859-1?Q?R2T8PPEreAWWw8Ripo/Cv7LjKAV1DEE21tykZZ9r5B8kan+qGkwpe5WE5o?=
 =?iso-8859-1?Q?yZFU0SyBI0Ky0X71RXlCHqi3py8R92H2+cYhrgwKlKlcqSPmOJzS7U4YvK?=
 =?iso-8859-1?Q?RkHtkkoq/NPMbkuns7PoOCgcbyfemVrOEGnaq2ruDkgbyv+YRJxBAIXtZR?=
 =?iso-8859-1?Q?GJF1Ki2Lk8z8rlN6LBTsXdK1SFA7qov7yNQXq2u2gApyE1VdOhS6TGOvKz?=
 =?iso-8859-1?Q?5cleFzpnIUcrE7fRT4ia5uPY5yP8M8P3yfrbBj4XDOYevB4FTH5FvNyBQb?=
 =?iso-8859-1?Q?vJHIoB7J2TPmEC4mMl8m2BoIWhT1OnWA9UVdZUx0tZqTD0iw99CzltMrm9?=
 =?iso-8859-1?Q?Tr61xL59gdTyTBYMyTUik1PkDw5AnE08ikEZhnPTKczcAFWCMxpZRWfe6J?=
 =?iso-8859-1?Q?Xb+TUq/kA+pyh0p+G+6/j4iMZp2iLcvqbMgl1Kq1rA247TFwiJ0T26WG+n?=
 =?iso-8859-1?Q?rbYjpCelx835dga+RswCx623mxOAfxMKIvtEahOg2WFKm2cwvCTFTE51+V?=
 =?iso-8859-1?Q?dVxCEGprdkitNF9fhzbh+B52gGji52hFPWeVpf7r5Pe6/am9UJhAvsuJRE?=
 =?iso-8859-1?Q?r+iIW2lDKK8tAqYOJGcCjgALxvzVkR0KTcriGZWafwAHCn4LYUD/GwoJex?=
 =?iso-8859-1?Q?NjoEKJE50rxBeRG+Vdxl2YshGnRMpopbwoe8VKTttybHtdzF/FKtJCHhan?=
 =?iso-8859-1?Q?WbP2fPFBZ6Xb08nUUubk6YXYbTPHcMo79E3XE450RTm13m6uw7t3DoPUOv?=
 =?iso-8859-1?Q?j2vS4ZaBzcBG4pe8wBAoMVeKvNFN+DwwJsYuYXwiy/QSo/Pkcbe37R54GX?=
 =?iso-8859-1?Q?WCYVeICxSl6qM7guclKBlnj8ibaHvj6j3EBDjMGMOefAWSEpOyYdICibYc?=
 =?iso-8859-1?Q?GqXMWqJN72oOi1AzO/c2vlHz0X7mlZWC2mtG11isBw1JLMlFaRVbaVCvPe?=
 =?iso-8859-1?Q?HbNYXweaN6jUB7EENifvnxGwkl2jZ0F1wxoi5vU3/ThFSpTupXaQcpBxZz?=
 =?iso-8859-1?Q?OZgwWA6c7ZUEhbUw3YHgVkpV8bLi5OpiERwcwkYtxEO6cL86jBNDvpWo0z?=
 =?iso-8859-1?Q?gWiFzFGpHcHqs3L3dpXs/UMlXESmf8U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76b8343-d48b-4e01-1c4d-08da53c74e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:07.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3f6N+EvYFSgFPnF/MPX6yU4gjc5QnExFo7NOqiTCRdIM2WBl3uxhdpZfi48VgzUvfpAEYsQzypYw3oWj1ck4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: jJyvGZjti1LEcjmFMhf6jmcPTR_-W14s
X-Proofpoint-GUID: jJyvGZjti1LEcjmFMhf6jmcPTR_-W14s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Don't use the mm_struct linked list or the vma->vm_next in prep for
removal.

Link: https://lkml.kernel.org/r/20220504011345.662299-29-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220615164150.652376-1-Liam.Howlett@oracle=
.com
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
 fs/userfaultfd.c              | 62 ++++++++++++++++++++++++-----------
 include/linux/userfaultfd_k.h |  7 ++--
 mm/mmap.c                     |  7 ++--
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e943370107d0..fe6f283d26d5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -613,14 +613,16 @@ static void userfaultfd_event_wait_completion(struct =
userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm =3D release_new_ctx->mm;
+		VMA_ITERATOR(vmi, mm, 0);
=20
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma) {
 			if (vma->vm_userfaultfd_ctx.ctx =3D=3D release_new_ctx) {
 				vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 				vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
 			}
+		}
 		mmap_write_unlock(mm);
=20
 		userfaultfd_ctx_put(release_new_ctx);
@@ -801,11 +803,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx=
, struct list_head *unmaps,
 	return false;
 }
=20
-int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-			   unsigned long start, unsigned long end,
-			   struct list_head *unmaps)
+int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
+			   unsigned long end, struct list_head *unmaps)
 {
-	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
+	VMA_ITERATOR(vmi, mm, start);
+	struct vm_area_struct *vma;
+
+	for_each_vma_range(vmi, vma, end) {
 		struct userfaultfd_unmap_ctx *unmap_ctx;
 		struct userfaultfd_ctx *ctx =3D vma->vm_userfaultfd_ctx.ctx;
=20
@@ -855,6 +859,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -871,7 +876,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -885,10 +890,13 @@ static int userfaultfd_release(struct inode *inode, s=
truct file *file)
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
-		if (prev)
+		if (prev) {
+			mas_pause(&mas);
 			vma =3D prev;
-		else
+		} else {
 			prev =3D vma;
+		}
+
 		vma->vm_flags =3D new_flags;
 		vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 	}
@@ -1270,6 +1278,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1312,7 +1321,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1337,7 +1347,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1397,8 +1407,10 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1428,6 +1440,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto next;
 		}
@@ -1435,11 +1449,15 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			ret =3D split_vma(mm, vma, start, 1);
 			if (ret)
 				break;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
 			ret =3D split_vma(mm, vma, end, 0);
 			if (ret)
 				break;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1456,8 +1474,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1501,6 +1519,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1519,7 +1538,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1544,7 +1564,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1564,8 +1584,10 @@ static int userfaultfd_unregister(struct userfaultfd=
_ctx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1630,8 +1652,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 732b522bacb7..eee374c29c85 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -173,9 +173,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *v=
ma,
 			       unsigned long start,
 			       unsigned long end);
=20
-extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  struct list_head *uf);
+extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long star=
t,
+				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
=20
@@ -256,7 +255,7 @@ static inline bool userfaultfd_remove(struct vm_area_st=
ruct *vma,
 	return true;
 }
=20
-static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
 					 unsigned long start, unsigned long end,
 					 struct list_head *uf)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 6ae0a8cf9956..f5c2d46d17ec 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2575,7 +2575,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			goto userfaultfd_error;
@@ -3083,10 +3083,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 		goto munmap_full_vma;
 	}
=20
-	vma_init(&unmap, mm);
-	unmap.vm_start =3D newbrk;
-	unmap.vm_end =3D oldbrk;
-	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
 	ret =3D 1;
--=20
2.35.1
