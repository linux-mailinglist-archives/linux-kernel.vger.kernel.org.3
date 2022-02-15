Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC814B6F15
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiBOOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:38:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiBOOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:38:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69ED10240A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:37:56 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEGJ0S006825;
        Tue, 15 Feb 2022 14:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=gnrUkMZkJW2WXGb/lGIuYllkUDCKD4DlRLnetVoICgs=;
 b=lkJKotTUVLBRhCnmoSnTC6BZNLJ+cX6Ih/XC9d+py6n7lzXg5kP891kjVOxT7Qo8Ftrd
 2HnnWVS9qKBB+c2qLT7H/kuftuS0GZSF0U1mSzNZHH35ACQ1B1U3L7ZOOJrlGvrIRieH
 Ydbpokv6nk+4Ms1/Rt+2WcUfXbxXTzygU06wGWpGb5jVKzp1ym8vcWbKKBl9bUy6zNAq
 gRnfxTXxlHt5MIIsOii8JcUKJ4hsWqUlvSIRo+UPomD++7UNAHjGwj4RAn/JK0jNekLf
 RexYz/wZlbUeOrLLEZ5MCXQr8ejfsOk5k3VGNHnTIZTWCBb5kaymeMeJ+UUo01m+0cyK Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hfr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:37:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEV98b190172;
        Tue, 15 Feb 2022 14:37:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3e620x7nbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iybo8c+5Qc/6ee811HJstoiJWfwizVUycEp3j/yx6PccsUpc1KkxK26OOWZI1xtz8n82QZJQTmfeiWmF9/L9eyLtmgYdyx/0+DAuk6a8Qm2EvPcN2B2CwlFUuL0V5yPSXUgtClwRmXZPPFbXDGoAQ+0AcFOJ8TFs4tsFCkPX9/H8FKok8G8gBM4iUgCcav4IVQOknLgW1CqIGBDuiapa2bUBmdIgFBR+Yoluxj77EDiqr+Noy3YtyGaDOkNI6G5BZyj+mrP0xagzVKU3FzXe/lF75UyvKSg+H7yjW/hritciDDNmKiwcfK2YXbMZBaXb3OQJjCOy2I52UgYIjO8lFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnrUkMZkJW2WXGb/lGIuYllkUDCKD4DlRLnetVoICgs=;
 b=YCw7HYDtZWHCsuHwE6OQzAWz7o4FZr0WPvIG/ny20K7ITOUb+wD91oS/4PUY+TrmXPfZQRcnbi254e3hTbU+BF0gRrqjudirk7zHr3NcM3iCsf5WKZGY8WAjAaiExMhnLLY/GITEt6xE53P0uWFy1bhipo+EzRsWS4oboCc+iZ/Vgu1qrNWA45gsmJhZpIxTfjKMqgVm4NaHA46mUhf/2Towqh9q6QFHkr0Z20kya7vKgaEzXsGPy90575stt7buv2AlXMP1ZALDJUoQcdg8LJg+vHLPn3buGQYC4JeqdwQqWCAduNGQRnSRW7DHhE52JmWj9cDNVE7lnCsbbRA/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnrUkMZkJW2WXGb/lGIuYllkUDCKD4DlRLnetVoICgs=;
 b=yDMfhY0mqmyNc50Qn3QGNK1e6xke2j6DP93TFFtEnTrW8RzF4SVehor3DYj8CJiZrjCR+jrIeEL5NB9c+NUYtLLV55zqqhqMbGKuwTbzmt8pGUbUuvK6wCsyJdXS9abMKjMztkwhRT95lhu74InmP9SzZeoKSEeJe80UykuTnV0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 14:37:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:37:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Topic: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Index: AQHYInmXxzMTjmF25U+e/3QAVwcn6A==
Date:   Tue, 15 Feb 2022 14:37:44 +0000
Message-ID: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c5985b2-b9a3-412d-4ce6-08d9f090ba68
x-ms-traffictypediagnostic: CH0PR10MB4873:EE_
x-microsoft-antispam-prvs: <CH0PR10MB48736183C7E5F12068B85AAAFD349@CH0PR10MB4873.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tS/Wi2P4apy+2rN8eUcsskCxImRbIjQhpYDGRv0N/gSqan2e1nzFyAifTwlul4Se/iiaw/JCehOuYOQQxjUId/W55wLGQ9KkT26OKYM2LxMYXPzB6ACiwqwRy6y78m4Jajzl2uYfFJWqV1ZRmUNwkDY5AFzcDotCWdpqARQPntQciAWhQuio191Jo+MjXeXm+VnW+QBJJsOGCX0vWi5cEe14sEPEw12IoCpCtA+T+shvt+PHBpqaW6uqIetFpTtJsi5pyYOrEdtlK7PQGi/dC/dKExMPq2Im6uqnge4yVTunFnl/DaF2R1O8OPDRhz+4IfcmQABIQtf481YbleKrkK+HS0GYkQHvBbw/Jy+J7DtTnEHaF5HBJVcCCQscG0uMPKR8CFCQkOhQaHkKkvMwkYMaZoSclObVbZDnZBjVEvuBDUz9JYnj4k90qElYxs0jLPqII7SLxNXO/cT0hL6K5f99IFRVdW5IGx729SDjWJ5EZBXW5FHLxCHpb/92shUz3awa02AkwTnx8Dr4T9SLzfvfuzi09Sqc6/vffGGiIur4PouVSX6QFWP1R/+jCBDp6YRkhvY9oByPYaRDOw6l/lu3SYrG9lkJY5amkkPKDa0SOpYs8QMjGBKsaBO6bmLaryH+Av8YE1DyMeju8N1rjLZp4lhSX1FeQlCNPgmRbZ5yLlXskHAZ4P1piP3myngUJOHg0yhsNgL0lsZZqe7tmPEA9gOKm5vKD5vkgojki8CM4mFmXamRu+km6qSKMVuCUaYyqDcPaNKqWHlxADgj7X0er4QOscIhdKcHkirJil8Q4KhQI2Zlrotf1N5ZqLZF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38070700005)(122000001)(8936002)(76116006)(6486002)(66946007)(110136005)(966005)(91956017)(66446008)(8676002)(36756003)(38100700002)(316002)(5660300002)(66556008)(66476007)(64756008)(71200400001)(2906002)(2616005)(83380400001)(6506007)(44832011)(6512007)(1076003)(508600001)(186003)(26005)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8MYADwzVK1aYaWNIhNWoyf2i/tXHsz4GDmwSdTWu00/Lj7k3NWhQSJ19ks?=
 =?iso-8859-1?Q?c6kwskGvTG0QoGYrIMzJV5MLpBMTKfSXKwHo6qIW3jSdkcWMD0Q9McC3L3?=
 =?iso-8859-1?Q?OKd+7hV/nEKbalvNm5XuiR4O1EQ1mwITsrZvrXPz1li/eJj6lzZBBtQEww?=
 =?iso-8859-1?Q?8sZj8Dn10KusqiiZZyPFqnUBnQhM3pGWR6lOVz8m+Ok2kTF9xCzhF9Rt97?=
 =?iso-8859-1?Q?whuTFkKCdUvbUOhe+IlnZm1Itgl5BsDzAeIqZvayKKV1TuFDUfUR8STqin?=
 =?iso-8859-1?Q?gP3e9p2i6LuXQH9d+Ca9bCCMG21FLUZSRcqGTyuQZmb3BNTfgW7b0fwlqY?=
 =?iso-8859-1?Q?IgRaD+iB8Fw8BgwQijrO/NrXXHV7k1aAiY2Ylg/MYXqVRLPMIcDgTbmVeD?=
 =?iso-8859-1?Q?pEe0Q+6BxN1NiNVA2n0JHXKVHccU3T+zOaTGYgLDJfL5JiyNiRPjniperV?=
 =?iso-8859-1?Q?Nkw9Fl4x5ry5Y3CzfDRGhK3/mfC1O7U+t5v4jA/1j5ZeBckLz03sbTK2SE?=
 =?iso-8859-1?Q?Ucdgzkxh/DgTeiNywIqtDnOdb2E1s3k114eJCh7dEUHEtI7MrWvjg7iUgJ?=
 =?iso-8859-1?Q?Mqm9ANjYuvnOmA+wfp1NYIHUqkzEWEU/hpQYN2MKQI37zA1AH1hKcl6mov?=
 =?iso-8859-1?Q?piYyDiUxD8jYlGg46lDcFjjJ2+mk843wiLPr3JryOBbNZscSu3wwC6zq/J?=
 =?iso-8859-1?Q?lfzrDZFifYt88Lv/n2pzTd6B+sZ6kG33v6qhccs/7tgtRkdShaUa+LeQgC?=
 =?iso-8859-1?Q?A3iZLmJdnEB9zLHQoLctlhFqXvkK4J+Wy6V3ylgCY3u72wLxZ1uKSOviBK?=
 =?iso-8859-1?Q?zF2YbiZ9lLYCbFzO/S/DhEwwNLnluU19McT6TQdCjZI0Lmz/7NvGypu9Ok?=
 =?iso-8859-1?Q?0n87yYM8ZpPamMj5eYBWdplKT/A5U328vat/hiFodf6chRyt98cJKRfKwi?=
 =?iso-8859-1?Q?oAmqvsl+2SpngZmTB6wF+vIv7qNWHZg8+UT5Sd5zmGcdU/HNKX+DVFPdkS?=
 =?iso-8859-1?Q?k0royitu+CHuiamajvUx4diquOengNzXbj0KeBMq25wQuAq9leSCXhyG+Q?=
 =?iso-8859-1?Q?4f1fFycmWUUGAj6nbvHUlAm23Aeh3AQSGh1NaBkQzTK8xUP/Rd9AV8iJd7?=
 =?iso-8859-1?Q?M/YeGSYrJjZ5RcugW+T6+K2hWkVQX2WowUgiNVNPHPT6QXuTYF1WNXRhzY?=
 =?iso-8859-1?Q?M3Ss1BH7bRloLl7VBySIH4+iR1GqWXPm8VEs6mHaxo+i6qQvv4OVhxgX07?=
 =?iso-8859-1?Q?uTxXvM5snXjYzgd4rc17SAGXO03USi984uDJkAvH14/DWLjZruVk7WXfJA?=
 =?iso-8859-1?Q?LJx4L8RlzW/oHEDhaC6HBYW9tSNfpDZuwqTogz3iUwz+29qC9Q3DG6ETza?=
 =?iso-8859-1?Q?nCVQI03+19rcRQwuP5LyUj9/Ty+8GjUBeX+yKUxmphFr8FVqJA29QZtSIV?=
 =?iso-8859-1?Q?QCbZlXh8UPcv72mKQ2/4LCntUcKpjyYeZDxke9GQNX4Kdxe8JBWa+NLqTW?=
 =?iso-8859-1?Q?i6fgcs1ztYJ4bTB2unV4MWP0Opke5QV5x1H57kBYnTMC7m+fduK3I39wu2?=
 =?iso-8859-1?Q?ECGa/eWkHYTnGyrOlACIbMDN1GoA6fpwGFFzCAAoW2H4qJahvLjD4WQ50X?=
 =?iso-8859-1?Q?rolLPKW8sNBY7LLhfku3Bk6NUND9YH8/LI76bVZXcAZkBTfZMQR24NX7gQ?=
 =?iso-8859-1?Q?IDRYymKF6S2wZgdM+V8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5985b2-b9a3-412d-4ce6-08d9f090ba68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:37:44.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cU24vyZMXI9LYNvf0w3s2lv5daxUrawobwYmbybEVIGgwBJJtIEtUxddRS02M8xJLq3vPL99OHG+L1Go4o9ggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150084
X-Proofpoint-ORIG-GUID: TwgMNF9sKfd-UBJvdLhqlvRElPbqr99E
X-Proofpoint-GUID: TwgMNF9sKfd-UBJvdLhqlvRElPbqr99E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel
that a non-overlapping range-based tree would be beneficial, especially
one with a simple interface.  The first user that is covered in this
patch set is the vm_area_struct, where three data structures are
replaced by the maple tree: the augmented rbtree, the vma cache, and the
linked list of VMAs in the mm_struct.  The long term goal is to reduce
or remove the mmap_sem contention.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
nodes.  With the increased branching factor, it is significantly shorter th=
an
the rbtree so it has fewer cache misses.  The removal of the linked list
between subsequent entries also reduces the cache misses and the need to pu=
ll
in the previous and next VMA during many tree alterations.

This patch is based on v5.17-rc4

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220214

v6 changes:
- Added patch for xarray testcode which should be dropped for upstream
  fix. - Thanks Matthew Wilcox
- Fixed issue with maple state index/last setting when the tree is just
  a pointer - Thanks David Howells
- Changed internal RCU handling to not check flags more than once
- Fixed mas_prev() underflow issue - Thanks David Howells
- Fixed returns on mas_prev()/mas_next() when there is only a value at
  0 index - Thanks David Howells
- Fixed mas_find_rev() running past minimum value - Thanks David Howells
- Fixed testing code function rename - Thanks Mark Hemment
- Reworked brk() and vm_brk_flags() as suggested - Thanks Vlastimil
  Babka
- Documentation fixes - Thanks Mike Rapoport
- Separated test code from tree code - Thanks Vlastimil Babka
- Moved maple_tree_init() call into the maple tree patch for other users
  - Thanks David Howells
- Fixed copyright date - Thanks Mike Rapoport
- Whitespace fixes in comments, reduced changes in other locations.
- Added missing kdocs - Thanks Mike Rapoport
- Fixed exit_mmap comment - Thanks Mark Hemment
- Removed RCU tracking as there is an issue with atomic increments of
  mmget() - Thanks Mark Hemment for initial issue report that allowed me
  to discover this.  RCU was not being used, so it is disabled for VMA
  tracking for now.
- Removed unnecessary assignment in mtree_range_walk() - Thanks JaeJoon
  Jung
- Dropped ma_xa_benchmark from testing Makefile - Thanks JaeJoon Jung
- Fixed leaf gap calculation in rare case of underflow
- Fixed mmap_region() bug on merging of prev
- Fixed mmap_region() bug on khugepaged_enter_vma_merge()
- Added test cases for mas_find_rev(), mas_prev(), mas_next, and
  mas_root_expand() to test suite.
- Updated config options and ifdefs to allow other maple tree users to
  debug maple tree without debugging the VM maple tree.

v5: https://lore.kernel.org/linux-mm/20220203172051.i2jnhnkudzssdsxg@revolv=
er/T/
v4: https://lore.kernel.org/linux-mm/20211201142918.921493-30-Liam.Howlett@=
oracle.com/t/
v3: https://lore.kernel.org/linux-mm/20211005012959.1110504-1-Liam.Howlett@=
oracle.com/
v2: https://lore.kernel.org/linux-mm/20210817154651.1570984-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20210428153542.2814175-1-Liam.Howlett@=
Oracle.com/


Performance on a 144 core x86:

It is important to note that the code is still using the mmap_sem, the
performance seems fairly similar on real-world workloads, while there
are variations in micro-benchmarks.

kernbench, increased system time, less user time:
Amean     user-2        885.34 (   0.00%)      886.07 *  -0.08%*
Amean     syst-2        161.95 (   0.00%)      168.19 *  -3.85%*
Amean     elsp-2        530.06 (   0.00%)      532.96 *  -0.55%*
Amean     user-4        908.58 (   0.00%)      908.88 *  -0.03%*
Amean     syst-4        167.56 (   0.00%)      173.72 *  -3.68%*
Amean     elsp-4        277.21 (   0.00%)      277.38 *  -0.06%*
Amean     user-8        961.84 (   0.00%)      962.45 *  -0.06%*
Amean     syst-8        176.40 (   0.00%)      183.43 *  -3.99%*
Amean     elsp-8        150.59 (   0.00%)      151.21 *  -0.41%*
Amean     user-16      1040.15 (   0.00%)     1039.89 *   0.02%*
Amean     syst-16       188.19 (   0.00%)      193.81 *  -2.99%*
Amean     elsp-16        86.85 (   0.00%)       86.32 *   0.61%*
Amean     user-32      1240.46 (   0.00%)     1233.93 *   0.53%*
Amean     syst-32       217.15 (   0.00%)      222.99 *  -2.69%*
Amean     elsp-32        55.16 (   0.00%)       55.09 *   0.12%*
Amean     user-64      1241.17 (   0.00%)     1234.26 *   0.56%*
Amean     syst-64       215.11 (   0.00%)      220.76 *  -2.63%*
Amean     elsp-64        32.88 (   0.00%)       33.72 *  -2.57%*
Amean     user-128     1613.09 (   0.00%)     1609.63 *   0.21%*
Amean     syst-128      267.10 (   0.00%)      276.72 *  -3.60%*
Amean     elsp-128       25.80 (   0.00%)       26.09 *  -1.10%*

Mixed Hmean results:
- freqmine-medium -3.50% to +12.82%
- malloc1-processes: -14.50% to +6.53%
- signal1-processes -1.87% to +14.02%
- page_fault3-threads -6.46% to +26.15%
- pthread_mutex1-threads -16.81% to +28.63%

Decrease in performance in the following micro-benchmarks in Hmean:
- brk1-processes -37.42% to -44.16%
- malloc1-threads -18.27% to -23.08%

Modifications are more expensive so the micro-benchmarks that write but
do not use the data will be negatively affected.

Patch organization:
Patch 1 is to add a missing lock to avoid an assert issue when using a vma =
iterator.

Patch 2 is an xarray fix due to bitmap header changes which will be
dropped for a pending upstream fix.

Patches 3 to 7 are radix tree test suite additions for maple tree
support.

Patch 8 adds the maple tree.
Patch 9 adds the maple tree test code.

Patches 10-19 are the removal of the rbtree from the mm_struct.  This
now includes the introduction of the vma iterator.

Patch 20 optimizes __vma_adjust() for the maple tree.

Patches 21-27 are the removal of the vmacache from the kernel.

Patches 28-31 are internal mm changes for efficiencies.

Patches 32-69 are the removal of the linked list

Patches 70 and 71 are a small cleanup from the removal of the vma linked li=
st.

Liam R. Howlett (61):
  xarray: Fix bitmap breakage
  radix tree test suite: Add pr_err define
  radix tree test suite: Add kmem_cache_set_non_kernel()
  radix tree test suite: Add allocation counts and size to kmem_cache
  radix tree test suite: Add support for slab bulk APIs
  radix tree test suite: Add lockdep_is_held to header
  Maple Tree: Add new data structure
  lib/test_maple_tree: Add testing for maple tree
  mm: Start tracking VMAs with maple tree
  mm/mmap: Use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: Use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: Use maple tree for unmapped_area{_topdown}
  kernel/fork: Use maple tree for dup_mmap() during forking
  mm: Remove rb tree.
  mmap: Change zeroing of maple tree in __vma_adjust()
  xen: Use vma_lookup() in privcmd_ioctl_mmap()
  mm: Optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: Optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: Change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: Use maple tree operations for find_vma_intersection()
  mm/mmap: Use advanced maple tree API for mmap_region()
  mm: Remove vmacache
  mm/mmap: Move mmap_region() below do_munmap()
  mm/mmap: Reorganize munmap to use maple states
  mm/mmap: Change do_brk_munmap() to use do_mas_align_munmap()
  arm64: Remove mmap linked list from vdso
  parisc: Remove mmap linked list from cache handling
  powerpc: Remove mmap linked list walks
  s390: Remove vma linked list walks
  x86: Remove vma linked list walks
  xtensa: Remove vma linked list walks
  cxl: Remove vma linked list walk
  optee: Remove vma linked list walk
  um: Remove vma linked list walk
  binfmt_elf: Remove vma linked list walk
  exec: Use VMA iterator instead of linked list
  fs/proc/base: Use maple tree iterators in place of linked list
  userfaultfd: Use maple tree iterator to iterate VMAs
  ipc/shm: Use VMA iterator instead of linked list
  acct: Use VMA iterator instead of linked list
  perf: Use VMA iterator
  sched: Use maple tree iterator to walk VMAs
  fork: Use VMA iterator
  bpf: Remove VMA linked list
  mm/gup: Use maple tree navigation instead of linked list
  mm/khugepaged: Stop using vma linked list
  mm/ksm: Use vma iterators instead of vma linked list
  mm/madvise: Use vma_find() instead of vma linked list
  mm/memcontrol: Stop using mm->highest_vm_end
  mm/mempolicy: Use vma iterator & maple state instead of vma linked
    list
  mm/mlock: Use vma iterator and instead of vma linked list
  mm/mprotect: Use maple tree navigation instead of vma linked list
  mm/mremap: Use vma_find_intersection() instead of vma linked list
  mm/msync: Use vma_find() instead of vma linked list
  mm/oom_kill: Use maple tree iterators instead of vma linked list
  mm/pagewalk: Use vma_find() instead of vma linked list
  mm/swapfile: Use vma iterator instead of vma linked list
  riscv: Use vma iterator for vdso
  mm: Remove the vma linked list
  mm/mmap: Drop range_has_overlap() function
  mm/mmap.c: Pass in mapping to __vma_link_file()

Matthew Wilcox (Oracle) (10):
  binfmt_elf: Take the mmap lock when walking the VMA list
  mm: Add VMA iterator
  mmap: Use the VMA iterator in count_vma_pages_range()
  damon: Convert __damon_va_three_regions to use the VMA iterator
  proc: Remove VMA rbtree use from nommu
  mm: Convert vma_lookup() to use mtree_load()
  coredump: Remove vma linked list walk
  fs/proc/task_mmu: Stop using linked list and highest_vm_end
  i915: Use the VMA iterator
  nommu: Remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple_tree.rst         |   218 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/parisc/kernel/cache.c                    |     9 +-
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
 fs/binfmt_elf.c                               |     6 +-
 fs/coredump.c                                 |    33 +-
 fs/exec.c                                     |    12 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/internal.h                            |     2 +-
 fs/proc/task_mmu.c                            |    74 +-
 fs/proc/task_nommu.c                          |    45 +-
 fs/userfaultfd.c                              |    49 +-
 include/linux/maple_tree.h                    |   683 +
 include/linux/mm.h                            |    77 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |    12 -
 include/linux/sched.h                         |     1 -
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/linux/xarray.h                        |     1 +
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    71 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    58 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    18 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6967 +++
 lib/test_maple_tree.c                         | 37398 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    37 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     9 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |    78 +-
 mm/khugepaged.c                               |    13 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    58 +-
 mm/mlock.c                                    |    34 +-
 mm/mmap.c                                     |  2086 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   127 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |     9 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/lockdep.h      |     2 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/linux/slab.h         |     4 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     3 +
 89 files changed, 47390 insertions(+), 1842 deletions(-)
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
2.34.1
