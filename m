Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC9519326
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiEDBL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiEDBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF42E9E4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:07:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243N1sI6003197;
        Wed, 4 May 2022 01:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=829pJ5QoRAvyGDztFDW7OwGtGanHQ8F5VGqVrkrQSPk=;
 b=WlrFMqDf7ilS7FAbS3G2emkbhtErzs8kYKHxiDeSycDP8xZktBo+fKBheAeRBb684wxK
 s0qqTy5uVGG+NroVg8/1iMczj+y2hCGH97tJIwpLc2oPUfAnu8FsQkdmwKBhe3iOJzxA
 fRp69mfVoqkKrKjIJyhvrCvGcsvvDCL/fZxPW+ySZR2mKnqy9DazQ+DcHVTxKZOf8rA7
 l5PdnC15HC/7c7/ZnjdyUNh6Sq3UOa/yQ+78rPdaDmDNyzC5L+QE0cDQ+JZcTdEXxJfd
 nw72ylc34E8cDsvdqwTTZjLaY8K7sr3UPOjrA7dcxh5ZKyD0wpM31ilK/xyuYvJWCkK+ PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apxsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24414r5T010220;
        Wed, 4 May 2022 01:07:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj91yvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlLO3La6MUoVXl4rzu/NgXsVpZdh+Uqu8FnaT6KKfrJu24nVHXFkl3KV/vtwasWrDwQOVsfMV8eQp0WzUvjD1SXAF7crxh7V9ft5sFk5h3znFSbclIzAqqLyX9nZVTgsrlsK2qVTL5TrUYb//+Rvh/aK48qLfAM7WVrftgrWKLP8pWNCA3CcD5v7AOFMUtc5UzCqEr4jqwAxNgdAJ3pNU1zs4xmJA8HqMdcbSMrHLQe0bxdQQYOkFG+Qtj1lGtSlH2mzTGorPTk/8uSSqJ0lXccpY059u3Q+X/OzT8N3hAMZvBl+o5F4N8T1i1f6eDJjGh705/owyXflK2b71tMDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=829pJ5QoRAvyGDztFDW7OwGtGanHQ8F5VGqVrkrQSPk=;
 b=W1dJuRFzTrIbn1RNX+7dwVnMUeW4UpHxdfBKcj+xLsESRx9l0vM7qhhzjmvCFg8U+ABsFTeuWA1pM4mdp/APpV8aJvMm4Y3oVY/syq+AJ9OX/qBTz0QqRpBa/FLAbzk4dPoSGMzbvgB5/PTllnWV7Qvk0sSv/DEIz+pf4emlTtgEKgrw5LVmi/NS+xzqPOs4Pr8ywwwHiDBB2Sn3G/VpTSZ0bXzQnxffEZDR/V3B0K0R77XoeYuu6RuR/HiDkyHwBraKj9BLB/D8WjC94uXWAUJPcOQKVvMqekb/mWiiJ1WGbPXmWjNHE1B9rS9X8Tnjnx+ial/9EUa2YTzTEEDbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=829pJ5QoRAvyGDztFDW7OwGtGanHQ8F5VGqVrkrQSPk=;
 b=ELCQmKsQtyJKipqh3wpwSOga/6LvZSkp1/7Ntxe8E+jkmUKLot/WUuQNPJ4txCm6PU5fm8ykza7rYTXeydw5xx6YBU043rhiL5xPlw0HkMWyMoViO6xVonFp8p5zBjerw+91Fb1Blz9aoElaAp1NqnSd1ouRgbpd3AH1wOS/rok=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5445.namprd10.prod.outlook.com (2603:10b6:8:27::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Wed, 4 May 2022 01:07:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 00/69] Maple Tree v9
Thread-Topic: [PATCH v9 00/69] Maple Tree v9
Thread-Index: AQHYX1NY7mnX6OfbA0OUwkg2Tm0KvA==
Date:   Wed, 4 May 2022 01:07:38 +0000
Message-ID: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b99aa77-cdfe-4e6f-3bf0-08da2d6a7b78
x-ms-traffictypediagnostic: DM8PR10MB5445:EE_
x-microsoft-antispam-prvs: <DM8PR10MB54450ACB92FF6B4E8C1412E1FDC39@DM8PR10MB5445.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K60tauUFhQdtgI8voflo30vaTKeUWEf0UxOYiTU8me0CF5C57PhFIHHVFEUmrXvKGdELgL3AVHV2sOyrvQ96ARC7jrB2ciR3D67DlRwsRFE4X1ZPH20git9vX0W5Yi0z+pmMDm5XmxCLkhQcnkPUVgJ1o7tmRSsQVFa5eulhwccIwK7KoJFK0JxHhnzmSn+UvKYrFpMx29vHRd9JUF5g0A10hPgm/Lvx8PzEGfYqA0UTJfK5WmaNwu1onyj+nDLwOKMgb7JR+HxN9Lx6lp59NurXhrOD0TAmYZCBMOCTotcXiTAqF5te3EBWvwY2HzoJuDGQne96Rc4wV565DGi5WKhEX16AhFhvmeQRk+deS/lNhjXSBGGc+JImvWRG0oFtUsALPzuTnBKAT55O01pJthRbkvAQ46+pD5/J6DjhtHLmag5b55M0j4mRDnNMT9TdH+exiPMndGY4iymNqY4AsngLCiKln8WMGlszR3S2MJDIp829HC1onTtiM/Y2FTbvx/hP1chUeU7XfBVZ5d6jbUA69FDH76NfflsCKa419Xzj78oR5qv1Dz3JxFSBUPy5FA1g61kSkDNXgh7whFERjFCfET9YexbC7/cZXM9bMJO1ThrULPDFeNCXDEmZEhbtt9EqTTeG6qfv6UArWMBHZyeZ0U7a4Y5MPpIJlEbcyU4fQGTOEvcW5hV/UE3wK5NGmzUKehbzluOeKKH+PqmOjI3J6PkDY4X0NVshLbSk+Qdo7Brcc/hdQHT8tWmqyglz+LCwhrgw+kHpUcfUcyMnPzqAXK7GAKTHayxaqS/4E7s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(6506007)(26005)(5660300002)(36756003)(6512007)(1076003)(6486002)(508600001)(8936002)(966005)(38100700002)(110136005)(64756008)(66446008)(8676002)(71200400001)(66476007)(38070700005)(186003)(44832011)(122000001)(316002)(2616005)(76116006)(66946007)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lXBaS/VgT3VwlVabl+Z3lBLfXR0SqHnUoCJ+rJJtYJgtkBIgF04DX0nl+8?=
 =?iso-8859-1?Q?y5DkPv5fzS0Ij+tJS1PGRg2wywDMCaElCTHyFlslWMpF4Kv7NVGUW7y9Ww?=
 =?iso-8859-1?Q?odDM+pPrjHj0XL80Oblvs8xsFKURIBvrRcqe/sRWN9Gv574en+sRzn4OAZ?=
 =?iso-8859-1?Q?wYuO6nRCD4d8DcZxCRfq+uOI9U18Sj3GvlblQJdZv+vIuFF2Q4yyyXWRXK?=
 =?iso-8859-1?Q?vDr6PDH65WhTJu4e2l5tyQjDI81f4pzlVIrF++89j3jUO5rQFthNdwRqhm?=
 =?iso-8859-1?Q?RAq97papisawhDS5JRIYV/bPEW+OpHjlqEmYB8JRXq9S3OD7wWgHFogVUv?=
 =?iso-8859-1?Q?SsNNbZ48jKzlNV0QIaz5+pz7HNpKmO/Qsmyb25DzbUsphRXkzgJMuG839c?=
 =?iso-8859-1?Q?wlsh+tdYU+YivzK4L5etC9QdRzUfb7OQbbAy1O0eeHCW4hqkloiXQ+kQa+?=
 =?iso-8859-1?Q?U7TfiGpsUDe3KXPEFZl2/26sjkCJ01vBq5XkML+tt7ojOcfxy1VagDyux3?=
 =?iso-8859-1?Q?oyKhSLLsUk5eMyorN3ZdhufltIt3M2mwYRL4NVP9deE8lFE+uLOJMMWjf0?=
 =?iso-8859-1?Q?rii8y3II5lklbPtoX3nCaSOk6zI2dOB9v4A+hVPnpcocTU9Vki4ELwE0O0?=
 =?iso-8859-1?Q?KHWjXHoEt7u0vkarxhMhe/u4zGtqferJ64wTKglq/CtO88mGYazn//EIwD?=
 =?iso-8859-1?Q?w+3RSYiemlJ2rXb7VVPOR9pHHlUKeflNfZ18u04dEGuDTSDlgLpccD5gMc?=
 =?iso-8859-1?Q?ts4I9797P82Ljql2VGAIvWxHVZ/GG5nSo98X8km/YKzPjrQxK72zm4bFn/?=
 =?iso-8859-1?Q?kMPGFKPyKicC3Iu/DTufvZzS8j3gqI/GXlVTJADpAVylCmTo/kv80bs8cc?=
 =?iso-8859-1?Q?7mAha6uhAPUXRbHE/mLN29Lr8Z7l5MAXoE3H/e4g5DmeYE8QJghx4z+40m?=
 =?iso-8859-1?Q?uUyU7jZYYAC3sqgLh03vsiiSRbKUqgWvviNx+hbgFykXY3ksIQFvWpawhI?=
 =?iso-8859-1?Q?iB1BKWftrwjJb0zhoeRvePAzKyDWoZfUbpsVhmztH13MZhzEdbgRG/i2TP?=
 =?iso-8859-1?Q?+edk0PlbSsR403YiPcIl2SthuLb8YpeJEfD2YwwIkENExkGuIweRy1kb2E?=
 =?iso-8859-1?Q?3nfNPoRiUcebW6I4rQZZ1O+3nT3DP6dvuoJ5TU0bVdtCZL+4+BK5iOtF4S?=
 =?iso-8859-1?Q?8WivhJoB9I4o8cpCNqpvsQmAL+mzD/HiozLvKrUrm0Pi+/yBkl9uIkSPnV?=
 =?iso-8859-1?Q?p9DH3sEkv7wJLMCvSq72aDaJpqK+p8w752SdT2PWDLh33C8D3lm4xOwvB/?=
 =?iso-8859-1?Q?rEWxvgDZspSRr4lttv5syeAtJrBKtXl0wBwytk+Dkkub6ijpltkSES+FDz?=
 =?iso-8859-1?Q?xBAztEaZFuo3pQTnrgEVDoijBozW9Dyr1zZJ5bspVxYtGym7wKNo0emmR3?=
 =?iso-8859-1?Q?mVBN09ZkD38p/bXcmyUSgVKwgsnsSV4GDyxvQKYj/uylO4sSHjxtuebLQS?=
 =?iso-8859-1?Q?d/y2bxzk0wNd7se2/z/ZmYOUlQxaLimR0o/HLeVnWdaWc/4UfiAGuU/gUP?=
 =?iso-8859-1?Q?lvPAHai9Y3alXvBwp7mcwiBUqrwQW98mfmlJKOUAHYO7IxH3jYy6N+vVS9?=
 =?iso-8859-1?Q?tVwmynILQjiMMw926cmPKLFMY+fGFURd01iHu6D0O10nP79twQzsQP9l0T?=
 =?iso-8859-1?Q?DBoo6GVw2rtjGzxvFYJUiMVox1ULvEKUGouybXeEJCTOxn4y+Nzrbt5UeT?=
 =?iso-8859-1?Q?HHCIXc5wqqifTerTQcgB3/y0Xa+3WVv6cpa+GUoQIYbEcIfDch88oK3u+Q?=
 =?iso-8859-1?Q?YVa6ul4BkR7UC6Drv43WSrbRXBpBJKo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b99aa77-cdfe-4e6f-3bf0-08da2d6a7b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:38.7294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrlWm4MiGc/6HqgltIAslo71LtEPzJWUJSPaq0LOAb2Hr0ICl5BPtpaQZWDqAo3j8AG6rqSk8e0piH+bcKeSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=896 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040005
X-Proofpoint-GUID: g6gqBdhBvDIapaJxFmmmqyyTKL3CC9BX
X-Proofpoint-ORIG-GUID: g6gqBdhBvDIapaJxFmmmqyyTKL3CC9BX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please merge this patch set into the mm tree.

Changes:
 - Removed mips rename patch to allow maple tree data structure to be
   the first patch
 - Moved pretty cover letter to the first patch
 - Boot tested m68k and s390 builds
 - Had to disable KASAN for s390 due to qemu bug [1]
 - Added error paths for preallocation failures
 - Added error path for brk failure instead of dropping dead code
 - Added s-o-b SeongJae Park to damon patch

It is based off the mm-stable branch.

1. https://lore.kernel.org/linux-mm/YnGHJ7oroqF+v1u+@osiris/

Liam R. Howlett (44):
  Maple Tree: add new data structure
  radix tree test suite: add pr_err define
  radix tree test suite: add kmem_cache_set_non_kernel()
  radix tree test suite: add allocation counts and size to kmem_cache
  radix tree test suite: add support for slab bulk APIs
  radix tree test suite: add lockdep_is_held to header
  lib/test_maple_tree: add testing for maple tree
  mm: start tracking VMAs with maple tree
  mm/mmap: use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: use maple tree for unmapped_area{_topdown}
  kernel/fork: use maple tree for dup_mmap() during forking
  damon: Convert __damon_va_three_regions to use the VMA iterator
  mm: remove rb tree.
  mmap: change zeroing of maple tree in __vma_adjust()
  xen: use vma_lookup() in privcmd_ioctl_mmap()
  mm: optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: use maple tree operations for find_vma_intersection()
  mm/mmap: use advanced maple tree API for mmap_region()
  mm: remove vmacache
  mm: convert vma_lookup() to use mtree_load()
  mm/mmap: move mmap_region() below do_munmap()
  mm/mmap: reorganize munmap to use maple states
  mm/mmap: change do_brk_munmap() to use do_mas_align_munmap()
  arm64: Change elfcore for_each_mte_vma() to use VMA iterator
  fs/proc/base: use maple tree iterators in place of linked list
  userfaultfd: use maple tree iterator to iterate VMAs
  ipc/shm: use VMA iterator instead of linked list
  bpf: remove VMA linked list
  mm/gup: use maple tree navigation instead of linked list
  mm/madvise: use vma_find() instead of vma linked list
  mm/memcontrol: stop using mm->highest_vm_end
  mm/mempolicy: use vma iterator & maple state instead of vma linked
    list
  mm/mprotect: use maple tree navigation instead of vma linked list
  mm/mremap: use vma_find_intersection() instead of vma linked list
  mm/msync: use vma_find() instead of vma linked list
  mm/oom_kill: use maple tree iterators instead of vma linked list
  mm/swapfile: use vma iterator instead of vma linked list
  riscv: use vma iterator for vdso
  mm: remove the vma linked list
  mm/mmap: drop range_has_overlap() function
  mm/mmap.c: pass in mapping to __vma_link_file()

Matthew Wilcox (Oracle) (25):
  mm: add VMA iterator
  mmap: use the VMA iterator in count_vma_pages_range()
  proc: remove VMA rbtree use from nommu
  arm64: remove mmap linked list from vdso
  parisc: remove mmap linked list from cache handling
  powerpc: remove mmap linked list walks
  s390: remove vma linked list walks
  x86: remove vma linked list walks
  xtensa: remove vma linked list walks
  cxl: remove vma linked list walk
  optee: remove vma linked list walk
  um: remove vma linked list walk
  coredump: remove vma linked list walk
  exec: use VMA iterator instead of linked list
  fs/proc/task_mmu: stop using linked list and highest_vm_end
  acct: use VMA iterator instead of linked list
  perf: use VMA iterator
  sched: use maple tree iterator to walk VMAs
  fork: use VMA iterator
  mm/khugepaged: stop using vma linked list
  mm/ksm: use vma iterators instead of vma linked list
  mm/mlock: use vma iterator and maple state instead of vma linked list
  mm/pagewalk: use vma_find() instead of vma linked list
  i915: use the VMA iterator
  nommu: remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple_tree.rst         |   218 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/elfcore.c                   |    16 +-
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/parisc/kernel/cache.c                    |     7 +-
 arch/powerpc/kernel/vdso.c                    |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/riscv/kernel/vdso.c                      |     3 +-
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     9 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |    18 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |    14 +-
 drivers/misc/cxl/fault.c                      |    45 +-
 drivers/tee/optee/call.c                      |    18 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/coredump.c                                 |    34 +-
 fs/exec.c                                     |    12 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/internal.h                            |     2 +-
 fs/proc/task_mmu.c                            |    74 +-
 fs/proc/task_nommu.c                          |    45 +-
 fs/userfaultfd.c                              |    55 +-
 include/linux/maple_tree.h                    |   685 +
 include/linux/mm.h                            |    74 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |    12 -
 include/linux/sched.h                         |     1 -
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    73 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    57 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    17 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6965 +++
 lib/test_maple_tree.c                         | 37854 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    37 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     7 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |     8 +-
 mm/khugepaged.c                               |    13 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    56 +-
 mm/mlock.c                                    |    35 +-
 mm/mmap.c                                     |  2129 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   135 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/include/linux/slab.h                    |     4 +
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |     9 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/lockdep.h      |     2 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     3 +
 88 files changed, 47857 insertions(+), 1820 deletions(-)
 create mode 100644 Documentation/core-api/maple_tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

--=20
2.35.1
