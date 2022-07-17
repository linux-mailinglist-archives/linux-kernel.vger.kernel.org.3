Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77A9577378
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiGQCul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiGQCtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25951BEAB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8OWr003733;
        Sun, 17 Jul 2022 02:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W82FwCey0iJFZy48lbMe5cV6YYVucFJV8d2O3Ka2qBM=;
 b=1ZmrhnuvWEQgJELbpzGVTokQ5wHRELsJOXb/GImUg6iAcAeJA3YqgYHd9HRs46Gs0AbO
 3/ZXWIca7fDv6IYOcRLvf94MK0XyjpJVviLUpDKohOrc+mtsXnvCfveYWG/kvRvo5210
 hSJP1NsuV8AD6ZcBPNrSBoUqmDd7ZWzfdYMyEDc8SANusyVW4HOwT8pMstOWKdEs3m/D
 ziNfIilPvRcKeTSiWxjAAijsU0SwQRIgjSPz/oUkPasa9mEsnibTUAu1y+uyX8ek0uEl
 F3YitR6nfVNnSsdYYN0LWp7glFiSX5V4P2XW7Hg4FCZj0DQGSWV1YSEDdP6j1FCdodo6 NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISR036113;
        Sun, 17 Jul 2022 02:47:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In1QYCO0xLnTJKIrImQgiVj50kJoAL77fAVHoWKDy/Ku6nHCS5AIm41Es4CPNl2tHOIPhn43LzEPMT0DU9xoe6QigUuvxGqbOurpR4qfuvKVmGocKvOKt/Y20rjvO+emBjYadB7xejdMi1zNKQH0QEDYGwJ7XhdjVEsiebPXnRoY6blcN8r14fBkKwTRJPDt6+fhfOAMJtjf3CayAKYVwvBHxApDDHB6xTe9cXWXKNGGarn+VUJKCfyoWNPPQpDLWVogspB6GwheRqSd3wINLp1QpHqvoEdb740r7OFnYkMLXjWr/KpG3QBbZ9i1zMTfSkT1sWT/yS6bpsFJ4Y98dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W82FwCey0iJFZy48lbMe5cV6YYVucFJV8d2O3Ka2qBM=;
 b=Lz3Ff+PR7qd/eu17GnyTLFI/wnCgV5I/0u1LGZ03cPh4Jmylwixod4oUWHyMczJH1UAdIImE5OMVLuhWZSRvk01FdeRqcoGeFVEVn1+EFtSI79ZH3t+n/sIwaNs3Dni/OmBYCX/cMz9mDje8nTMQDz+fLO17vTGHVw0w6YQl7DqTIDA9W7nCVa3sm34Oj8/HM568CBp4X3eVP3nTqmIAlt6a+5/Sz9V1tjhS2D8rj9KXFswy1ziuVRrfX77jiwHVaXeCP8n3uqRbOqCDmBwWDZcbDCdd5LrTnK8nrf/yH4rreSlWkB906kM1gPDsvJwiy2PN7xT0KCSpap1hXh8OSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W82FwCey0iJFZy48lbMe5cV6YYVucFJV8d2O3Ka2qBM=;
 b=bQRCYa7SS9qxAWbNQwpwfw7SldHcv/wqQw6Eo20MoWndb5VHOz6hE4rTVN8tekNNbnPaWBOgu/HHO0tx+K9nYyTlpyJT3GJ+JDXSakigmuAvRTYMRGt9gbq3ALIXHv6QD/fmXkMQtNYEosj8Wbll/txpaz2GAlTV3qxjJRrZit0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 44/69] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Topic: [PATCH v11 44/69] userfaultfd: use maple tree iterator to
 iterate VMAs
Thread-Index: AQHYmYd3SHeUsO7Ue0+S3dJ0csJMnw==
Date:   Sun, 17 Jul 2022 02:46:51 +0000
Message-ID: <20220717024615.2106835-45-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9805e47d-e213-4e4f-f8bb-08da679eb046
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lP1iTL682AQfrEi1KCweIBOZM7MEbZhANOlZAuXCCeHq7Gu821/1bMbGMIgILY6++23ItSkcHBXji9HKdq+IO9UqrYurem+LW1OcoyPNVuKjJypyLITsU3qThBJppw9sz3JrsGlYkezyxOZ0psiPB+a2/q14yzRskCy7F+w1JU5U3hpro6zIwmqDYeR31y+dRTBoTbU68kc/Oa7QJqkO8y3+d7kQ+b3ZMn0b/d9goGx2dmE0Ds7FrWjAb2gs3SGSAF9ORpNLTOgbEhKERnvPQBpz121J/72FwMo4C6JQcMOIvBD+D+Dwa+JFYZ8ZiLbrUWIDwA3fN2WKvECmfHZgrdIT74xzm8/qVAP3Edb6oI0LwOr4x3UkN2QDe/EmRUTH7KjjzxBPQOjWCRBWPLl3hjnCNN040o9+wbiV51id5TdK4QXltNLfRpB3T3A702p786iMTlo4+O/9uRHv99AvQnT7isOBgWvXM2h56u7dVwpGHRBFAdZ6oivRVBKzEUd0T5HBWfmMnmlnZwxHX5R4SHDIQSaLgVE/4RxZq6p8pJM4oPDtMMCSaxRhqMjtu98RE5m7g5mRdHX6g+rhi8YyV/WILUil41AG7U/hA2t5ntebWFD9ddnDnPcMl89eF+aA74NJ4aU12j/7BeAFSWJVDJ1eV7sKPSBdkdv7L8hehAr0ehmmMrr0gRxYiZGc4b+Cc9IL1KYBPo7i7oiJVux1DoTO2aI9rgFLw7XmA0HaHu4Qelg+M5iS81UcP8C3AqpAojhrPF8OMb2mDeQ3mGHPPY2sJZgZCF2AgyPI9pH6qDEEPQC1HmcSKZQHogjFtoK/7MPt3eNI7I62t0qGwcqxSMNjV3y2vZ+HY7u83Xh18Kq4bzjlmxh+6C52ZV3Ns0I9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LjwWT+YAV7vYGuvvcmUqSeN9z1lMMDjmaxMrslZlvXLAnAJ6S+8SDLJcaM?=
 =?iso-8859-1?Q?w63G6/iCv7xvdDOz6ouFJlST+988e3ErUkBmFNuZt+60pEEtp05Mpp0boz?=
 =?iso-8859-1?Q?oNhOFq9zKbWmqwArrtW0avTWiyF59kDAwmCA9/diZcQvpOSGSoEIwahhRv?=
 =?iso-8859-1?Q?SaqC46j7dsAjtRBKLt1hIxfgW/Dl+dKcpRqLC20iCUScCCN5ftWB0QwU8r?=
 =?iso-8859-1?Q?9ohae/QXxzTwtSpQkIXFGvNmd4RJj8PPuD1C1wf3a3807YTGLtBerPSJiW?=
 =?iso-8859-1?Q?Tkol5TCKoQKWRgXDLD5DGr1ZRo7xk8cQb1cDyvKUduLH8b3WUE+zbCou1w?=
 =?iso-8859-1?Q?j6wm5FmacYbRzE7aAi+5HjqRjwoMNHncrFbxpR5qbcLFnDZYvOde97Z+qR?=
 =?iso-8859-1?Q?VCDIGi8NnoXDdhGgVg7swBYz2/uC5HThXXq5oh9FQqiJFQNUcnhWdivA0h?=
 =?iso-8859-1?Q?N2ZWyjS4r99psj5EB1utBWz/CWyv9Eo7EAT1idzy8mDGM0vye8s+TwZYD5?=
 =?iso-8859-1?Q?n0MabeILtRFdb0c4HmXny23y9j7CGaPOD6ABr8xLnZJZcSglo7vZYLk+fm?=
 =?iso-8859-1?Q?KIX4v/7cz/rC64WCIPsuCr8Ic6gXNYyKK06qMUjzPXtq7BZBYu7ww3M5v1?=
 =?iso-8859-1?Q?ldRBlhUKyp+pw75FievPcvzdxSQokU7wohPk5X6FaGpOEGmKP+LbA76PWT?=
 =?iso-8859-1?Q?qnZF87yjtizF8qIEzu1hRMin7mElaL6n1cudpfqjBEeCgJ2/80i7b4VLi1?=
 =?iso-8859-1?Q?jpOwWGoRFfDo9beqZungvqsOPJeVOrLmbl41p8zwlNzAVa+naeEd83Z67z?=
 =?iso-8859-1?Q?eXwpgDfY86vw+NJAqHW/jr9K24wxVwPmfn2iaKZb2fXvVjKtxadJK6wWcm?=
 =?iso-8859-1?Q?1RUWtNIe/URz+9q2vqLSNDxm+1KijAiyET2BiUAVjSPWEQw/AXnXDbQW7Z?=
 =?iso-8859-1?Q?avAwKqsluVM0JX5MMAaUdEtSZQIvmYWBF726d7tD07HTnB8A5US8OoimTr?=
 =?iso-8859-1?Q?8nrxH8ZG8I526in/K1Mqnwvy2JWyklvKC9EqB980o0tJsEXuf2x+3c6fQ+?=
 =?iso-8859-1?Q?7YtlKZqb6bX+T4+LxGaN0/0Gp/aVQFfheAa7o7zQIpwkVVx1SF6QIhOxF7?=
 =?iso-8859-1?Q?dEjC8jUWiYBADLGM+x94xAoLRmHooHdIm3cF1KgCmgMQEtDvgn2xQ0bBiE?=
 =?iso-8859-1?Q?0ZdEdLw3Xs5icBgLpHqaKDWKhE6rn1lkq7vGZCXonQmYNfoKW6uW0WiQB5?=
 =?iso-8859-1?Q?lxoL2I9a1e2C5Zgt3JFFXUcaPpWWL8qluxx5/MKo0FZ92Nfqd5XDapxwN1?=
 =?iso-8859-1?Q?52rnNWb5QtSgyynZP6okRMHhD23k/Ll2NJO5ecIEXhozkhxlIDxnDYJTBk?=
 =?iso-8859-1?Q?Qo+ZCJIPc315qn4GG8zQu/8iSXbNZD/ItPGD+7svyi0U40cjsuLfgrNysM?=
 =?iso-8859-1?Q?+L+h1xXNlAR7zofLJCLfTX53KDGARemz5gWLYkAfy3/no7iBQsYSupAWo4?=
 =?iso-8859-1?Q?fMsw63bAeT9om9fclPhHUTMmch6e2jrxAqS1tMyDPzViz3qwFTw52sVdft?=
 =?iso-8859-1?Q?wOOJeAdjECRYMzZ3FnEOQ/NhKmh2coO0JBl35ZvfXEmEwbkTEy7pokolt2?=
 =?iso-8859-1?Q?TUK5SHSoOKTciQMaI36lq2js7IulFFMT/9bP99vaWqiCHAsFDK9iZ4eg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9805e47d-e213-4e4f-f8bb-08da679eb046
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:51.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjvABpQ8v99oPWIde8hny84yHNxR7sQiYPCJGbXAPwvjWBu/BrkHe8mUFtRqJCoWvI1f79+8hgO4BwIzzTZMtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: CUSVWukDPRhy7pjQR071aYY2RdK0-wsz
X-Proofpoint-ORIG-GUID: CUSVWukDPRhy7pjQR071aYY2RdK0-wsz
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

Don't use the mm_struct linked list or the vma->vm_next in prep for
removal.

Link: https://lkml.kernel.org/r/20220504011345.662299-29-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220615164150.652376-1-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-45-Liam.Howlett@orac=
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
index e4bfee3d2ae2..60c0c45ab186 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2595,7 +2595,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			goto userfaultfd_error;
@@ -3103,10 +3103,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
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
