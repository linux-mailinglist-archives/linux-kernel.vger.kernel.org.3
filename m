Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5654CEED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352677AbiFOQmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348484AbiFOQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:42:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3511B24C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:42:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FDr00V013172;
        Wed, 15 Jun 2022 16:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=scv91k3SaX2aI8bIw2l9OBX86Z5dSw7SLXkJBmcTpoQ=;
 b=YhRKl7brPGcds03jwkn2OTNtIMokTJZsy5Vn6aAp8GSDNJD2Te2+N5jh3K3+HiYcYyyV
 45eTFB2T4PqJCZCt6szFBLE2ubOhnvT8Ot3aHk0OnE1TpETkts4BrWRe9gLm98wb6f2m
 cm0n6brbihIYIC4v0NH2tg3TM6BE/pzUdbDGdM1Z0UB2agQ189aQpOL1OxcmGz1WRjEj
 CYAYRiUFjrYWpTWAY1vgk86zjtuAX22wGD/0DWONhuObGAPe2lrHLaeonZnjQ1DBZ7Yz
 jUvNsCKzTqW0bOQr4z/1euWViU87LyykBE885dZZ62TwaF+Sslyzn228DjVrOkf6SVqn tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkth3r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 16:42:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FGUCsL025825;
        Wed, 15 Jun 2022 16:42:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq1gfua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 16:42:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et+JZSiCeLqnHdm4674jpzM6DIU0OyZRCrFTSvpb/fmFmtlpQFa3S3liCRwac8YpETZCvifNtsShcwrtS3NjymJCVwGx5IX7wToo+5Ge0yQFfqmIRzb9Z/JAALNR/2bP+CsACJrBB2ELkfjbx1Xg4D/j+TlOz4VnI8zTWbDQQpIfAZhBE3wNYa7pGvImEGH+vd0gQB/Rm86l37ROqtgJXoG33NYLXsl/AhMsU+YOdNgkql3VbRNzEF8nDnpxnVLGOAvNMNdeta6JJbfHQJHunrLgRLtubwiU5GVKO7vVZvoCmpmn7VolNK/yBbAZFPL2kxBvvzqMXeNizI/ZSmYmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scv91k3SaX2aI8bIw2l9OBX86Z5dSw7SLXkJBmcTpoQ=;
 b=OiY32x5YaV+j4xUGQ+2dT+qaq976reKO/k7mp9FxMfIVtqWt2ijC8W6F3JBCSYuOZN/xVMek0xIGX+/X0xkbrgFrzBkk6o70OReZ+lBWts7Y0DucPsz9M74Yjo6t8RilIeVq0J1HZrnabvmRLv50cM5t1WpAC2CesHJlzcWxVJCVzu31Biv/23QeijqUruvueAQhDQSsC+UOI8WFWsM9GFN+Mmyf5loyRwENUDNWujVlZrTuQuAi+urfOE4GDCevwQ4VLYKtwfsJQlogLLnJwJsR15inxe2dsDoiUBSR0R1cfegDz0jbneXNxquIID9TWbidA5MHJ9YGIk3RqefpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scv91k3SaX2aI8bIw2l9OBX86Z5dSw7SLXkJBmcTpoQ=;
 b=is/WA8lnSPJRW6FDUYkju+eqUkBHe4rn/iBXOJfVvzkb03hSQdf+9sM+3aoQf43nqKBjlkznxUHIIsMieuVzzfMdQQGiMhvPL/fAfFAcwfmB+LTtK6HbN+M/Xtw67mLO4LgHSidBqAA40tpwFOfPtzDaQ5cyKMkgQp4iTzVEeIc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR1001MB2368.namprd10.prod.outlook.com (2603:10b6:301:2f::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 16:42:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 16:42:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] fs/userfaultfd: Fix vma iteration in mas_for_each() loop
Thread-Topic: [PATCH] fs/userfaultfd: Fix vma iteration in mas_for_each() loop
Thread-Index: AQHYgNbf923syUO0CUa1XHNOjurS0Q==
Date:   Wed, 15 Jun 2022 16:42:17 +0000
Message-ID: <20220615164150.652376-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7fa0909-bb8e-423f-5672-08da4eee024a
x-ms-traffictypediagnostic: MWHPR1001MB2368:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB236892EEB7726072E90FFED9FDAD9@MWHPR1001MB2368.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IChm54+E7Wp1gPyoA3EBxlZ8ZTEYPkX0c0W0ovFC+ZqO9u5aOCuzCZqtV4AB/fqcalpRPtvFxXKW/rOO8sOBTiYmxhrV+NF/iuawi2Rl3jwDzlQ2hEvukiwBNqY2f1mGk443IymSmMjRHI9scGY6/qmnY4IdGv0lRNQSwD5pULZYLjMOj55XaYG4TwRZUIvOTpZ/woeSkef6Ld1VgDMBqscpRyT4511mwj+8qXZGf/22UiPfWBQIIK+BZDEfnLIpC+oHtZWg088hjnhenwlC+r2d1BmeuKOwkLQRZvUb7FrkdAfcCqZCzznpkfxsrFeSOLH9jg9FCkR+35MIAYr53TRRFsPO2x0h/mQFLcrlnidJeBgUg0b7EaGlhldOqM8Y9bNCnBhAZJCW6rLpL2iZWxW2hyKiuiIboDdNVkup/zo//oXZlZhK/hK29WMrvZpRrTUjO4W5hoseqCemyJAnHB5bhd2LdA8/+EII4hXWQatdy78BiJg57yP8+uAV3SS3e33YYE2416nRmuR+yhHncXo90xBfWP4fE7tzG6ZlMEl0Pm0MstsuWGrSG4TBqMjTq/krziJgAJv70ck5AfB0a7YOM1Hum6cC8iBRC/wUlONb3qcmWLMOpVUktv5laWIKLEgokOtkH8MGvEQBG/EzE/lW49fFQkBc+lRroSP5cY3HM6XO/ApNan30PqL+itJ9QzdXMeIh3VrMtAbF8Sivcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(36756003)(110136005)(86362001)(508600001)(2616005)(83380400001)(66556008)(122000001)(186003)(1076003)(316002)(44832011)(91956017)(66946007)(8676002)(64756008)(66446008)(6512007)(8936002)(66476007)(4744005)(5660300002)(2906002)(6506007)(26005)(71200400001)(6486002)(38100700002)(38070700005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bVUE9ul3QXH5Fl27dq5PA/F01dXphVnopXbHNeph+afTvenkr09vtQ/mUa?=
 =?iso-8859-1?Q?RzFGlM2h+DDmGCXnKPEX4jndTi3eC5mgYj753Lx/GAMOoIUOKsiQ+NhY4v?=
 =?iso-8859-1?Q?exBkaSp3/JlhdEVORsu2b0cIX6YGbzey79ToAV9y2uoj6jEA4Q5GhBvvdD?=
 =?iso-8859-1?Q?lbyUF7w+G1YjHZwLis6hcdpL77m4UDawe27/N7G3x518NQhPoXiufMdMT/?=
 =?iso-8859-1?Q?U9mW5uIILHo9WeeoRGkY6VY/1ju4qaNyoQKcsvUTo9kVFYuTjNsZ23zik8?=
 =?iso-8859-1?Q?2Iu543QNa4I+zAAnscKuIV9giZLn/1yqEo4JyBLi3nN9TSmeut2EvjEJdk?=
 =?iso-8859-1?Q?Ti95SvnxolfRgXka8yc9iVF90Pfmslbo98GcjQ+JjIeG/rRIvDgjlzNq5l?=
 =?iso-8859-1?Q?CQ6asL+nFZ1OuZUMCT7rT+PYdux9TPGr229FBbzdBLh2ro8vIEG2ZsYPID?=
 =?iso-8859-1?Q?nazwDhuJEtwHlWMouFEo1TYHDQV5z1HdjU1Z4hlE08MMVSThhmm0ytmdsc?=
 =?iso-8859-1?Q?8P2WM9lq6eKjqBfVl6igasA3P19vxVysqnD8/rYLZZovWUYmmaG+6zl0Ry?=
 =?iso-8859-1?Q?Ytw3dOGdnOwssNHd96yAurtqNIJO9RPbz7a+Sovz1UyTMWKLtDaF1x+XYp?=
 =?iso-8859-1?Q?HAOvyCn14DockPVsrCI8vPxbGEzE2s6H+wPFiEch+/PlReW14548Hun4SY?=
 =?iso-8859-1?Q?HeT07T+UnNAqB3pGUmQ/xsuGeqfTLtorutZolAKBGeDD6X6ArjosjC5Afe?=
 =?iso-8859-1?Q?bDEHonL4zlq4khDtYcqU6teCGCRTsX1Jg238v7+Rnx25GBYtxzneFE2q3z?=
 =?iso-8859-1?Q?gQevG0lkCYxPsdoPgdnFO+hAAa6Ioqcf2I/MgUqCMlGZN1lnthX8PBeg+x?=
 =?iso-8859-1?Q?46vfpKRF8pQQ3JoUsez0FgPSoWi1FDUw1vYmJkt1pGVh6SV9QDJFBNjznz?=
 =?iso-8859-1?Q?ZtutTtuRQhcuJKC5hkzVeqXOjK19e/Si5NkQbnND2iEGBKuFcn0HANV4e4?=
 =?iso-8859-1?Q?ux5SIgaSGhYkW5Uru+wtm2psPSOECoxY9IAYimWfws1bCVCyFMIi0oeEFG?=
 =?iso-8859-1?Q?QP8i66UDQmuVb4pXEpCVDennIAMpf+j5ShiEfWqJanjB6KG2kozbEeIBNE?=
 =?iso-8859-1?Q?q4bE8tF4ASESAPZ533CjdnYme7RvXLF8jvBu3AyyoCwYYr8pxf4iSvjG7o?=
 =?iso-8859-1?Q?+SwYmrQvno+ZKsKGS56X/x1nxle+i65AFa9cn6EbeTxdKXmWbBee07BU2S?=
 =?iso-8859-1?Q?HJCxawtyNqXBnA3wH6gmrrkPdLA7MDATlzdA+PWeuHIsJwfvcL+wWoMdqv?=
 =?iso-8859-1?Q?lXWt8lgnmvZUcwRB/BDcDH61j+nJx5xgh35J7hnyOxOhzu1OmBWHoYV8tx?=
 =?iso-8859-1?Q?e0ZK1y2bSrsbcEJhCSgoJxEDtb11jlBNdtqpEYbYJc++Ep3UAlYNL3g7m+?=
 =?iso-8859-1?Q?Ae9Ujdn//kou5V++Iwt1OdAeIoZGHDZqEafmFp2ZRk/UxEbGeVqbcwFYLk?=
 =?iso-8859-1?Q?AzKQFkRGBerEe6lRervcAX9rXi3h/EGkEUseDQXPTmVvbXFwVelbVLp4Rw?=
 =?iso-8859-1?Q?JcPzRJadODGnBLGBCcQISJLPpam7KKavSYIy5f5iA7CH6T+U3bLpGQUlMu?=
 =?iso-8859-1?Q?Y7Tz53AqFhO4Hg999lkANhl47dCsUUBD/CUd8wD0wGncZdN9wEA4wy2YZn?=
 =?iso-8859-1?Q?vVFH2IutxSZSc3engtIH7FHMNy43Xtrz4fS6ExXMH6yGbtRzFA++pSwUHx?=
 =?iso-8859-1?Q?gATWIY9KbVYl6H+/G/KhA1gRlexNioZAfOcQE9s/GbI/IhDp0vk7Cw/OZc?=
 =?iso-8859-1?Q?Oz20ypp2mOi4e7y1wmvLtyjGJSi3q1g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fa0909-bb8e-423f-5672-08da4eee024a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 16:42:17.3643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEbp3+fViZEsILN2QTJ0P2x5bjrkGJ8O/Zkzg/m3QyzyFlnKj9jL4v7SEd9EbkJggZLvmKnTb+1MkrtEasTyzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2368
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_05:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=964
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150062
X-Proofpoint-GUID: mFqxy3beagm_qTfWsvQCSIhvAstrIgOs
X-Proofpoint-ORIG-GUID: mFqxy3beagm_qTfWsvQCSIhvAstrIgOs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree state becomes stale when the tree is altered and requires
the iteration to be paused with mas_pause().  This forces the next
iteration to start from the top of tree for the next entry.

Reported-by: syzbot+68771c0e74f7bb7804e5@syzkaller.appspotmail.com
Fixes: d3ccd17e7c96 ("mm: start tracking VMAs with maple tree")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index d18500633ebe..d398f6bf6d74 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -886,10 +886,13 @@ static int userfaultfd_release(struct inode *inode, s=
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
--=20
2.35.1
