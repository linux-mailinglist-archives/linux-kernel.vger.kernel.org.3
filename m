Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0F464FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350149AbhLAOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44122 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349950AbhLAOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:52 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Dw8pm002530;
        Wed, 1 Dec 2021 14:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=iFka4e2KM2aO+8UkBfjdqNUv6kElUNblgAoLDrLXpVc=;
 b=PN1bhHaW0/+h0ed1KnpWlvpk0ZlyS500ktPsOgDdmyA738fXrbAJSg6XhGbCDCqYTbiV
 iHqUUT43ES3bPeAEIt+h5ZJeuW4XgbtqgOxCtsV+vw6OjmunluTBcOCm17sHuYQpNF+b
 hhHS4v8L4g07Svss+7jLVcpm5tUkVbxEZ5d+GO0m9g/X8BGyvb3t70PYLoE0ukbswfkA
 Cq13B3UMO9t81/VzvmbCGlhtrw3cniRE7Pg4GFzCe+Q+2lAvneDwPT0F9jqh8ULHrKtQ
 2M5JFihQQfkVsQp1aC9Ej/H54BgjHnlxLtciBEyi+BnQl8QYLNsLw/CVkPTDv94UDyGC XA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EALNb032204;
        Wed, 1 Dec 2021 14:29:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cke4rv3t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXAPr02UFK/d1HYF/sFI1ZjRBAiBoCKVhGMht/Yi/HE9r0/bXuJR2LS0T7BVVFLdgSqJLin0G9LBb5JFtJfg8DkVq/BjJZNZLjSn9bIOw4sF/52T+NTqV2i8JXAyAsnirQMULQWxuTTrlmlaJc9I9pn/LMk0bCy/rjKLH3WdKg4WGknr+Nn8+agb7nTqwQSRohKHqStoJwwMM79i+Y5xnhlxozfqrEBHGxNWO4zcVxpNGOKnmZ0cqBChVTuGwNwOMNVVrYNLX/CnEk6cAqp3d3sHeJUJSoDJq5eTkqH90B0uW0Lx/V9tAs/udgapUD60CuJcmvLGuq+po7xaRqO90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFka4e2KM2aO+8UkBfjdqNUv6kElUNblgAoLDrLXpVc=;
 b=YaS5dPPQxtV9jwyHzKL0dQwtqVCqYmoyj8MwgYRMc8IqAa3Y69oRDpdseT/vWEIze9/ck67CtGrB/VsIBjusU1fzTH3zjJA8gAHwIzL3PZCiExrEShngxfp1RpVAIUL2k9xw7fvbv9M4yzB6RqIvPWjiv7+TdR+hk/6xEMZMMXSDBXDXqMbLndyqd1i+4DTIWgVgKBAt8xwJ+eyg/xG0ncq7P8dzARxHi4w5b8K43S9QAGKnx0J1KDFM1cjKxEMLhl73xQypTudLqzy/LGvJrvchyNspHn0bAAKnkXeUp9yLeqjCRQcgXv8v7r95z3+z0KYKZjd5/VCFDuBsUKMZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFka4e2KM2aO+8UkBfjdqNUv6kElUNblgAoLDrLXpVc=;
 b=r4yMSDVioRr8B5cKvMtXcYgagXIWBsHN5RQUHGKdawF2d/WC3SLci0KsrJ8x90mdQqiY+tCcOXRnwr2hoYjCcx3lTHKL9yxMTP/wcaxuslVXTs6yK7FATwfbg4EYAVQ29U+L3KGF/K62fT45er0jKyID0Xfu9pHQd361QVcN/8I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:44 +0000
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
Subject: [PATCH v4 00/66] Introducing the Maple Tree
Thread-Topic: [PATCH v4 00/66] Introducing the Maple Tree
Thread-Index: AQHX5r/iDALg9FQf50ig2aRcNrLLyw==
Date:   Wed, 1 Dec 2021 14:29:43 +0000
Message-ID: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb130ceb-8d68-4368-aef1-08d9b4d704c2
x-ms-traffictypediagnostic: SA2PR10MB4682:
x-microsoft-antispam-prvs: <SA2PR10MB4682C6A21800CB818A73362DFD689@SA2PR10MB4682.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvh3w5yvBxv2X5OLhR6SH9n7jPaKrefDRQtVfuTGIfc1itbEUL6LIDAUkJK/Ds7GUoQSkKg33oi4kDf87nYlRuGhzSCllP1kfQhI+9qEN14HsS7Ou3VOH3HNtdMp2WuOh/CDoywN90TTOQxGra6zdiMIyNMU0keD/lx1NiV0rDJpOEX0QbM0qW0Ld76PJBXqJS7B44/wlQ+8V/zNF6utVbdufmsT789tXYHHXQZVMX6zYEr9Jn0TSpsxuscbh+nvQVWD3LA6+WlU2sGvMoELlfq0aZCAUgsxzL+S+mYLB00DOG9HSIy32L62B7vu+g2Bhf8NBhuTgMdTBhRcffZbzMQ0cBT2ifkU/+gox2pazT+L3US3FWMB9DUO+HcqAp429stVV+m8IysZfHqmNjmiWV1Tl0IgzdRaKZLA6KhEt9/5VQG/6m47+muGYmDy35J2z6HVNuOO4rK0XSRKnFum6QokbGIJuJde+jntOuqXg3NT/h8lfPimXpd3hwZF9+mJewbY9Z0/KZawMOSlpQYB7DYqUB2m1LevEVBovbTgPM+eza8Igj9chksl3XM1qmUmHVdS60xdqMlqYPKOISva4e8AgzpK4R8LTsB/ixYwFdQGQgvgDt+BZPQFlLEaa0O/bPX3a09pMk1AzHPhwQlGh8gIUPw8JW8w9Rr/JzvGzBXgXNEhWyp8BhXPxofsKXN/pmxZ6IwZwkS6zsprYPNLA2tkd0/3Cmyl8UAUD/7R5HxrGThSR/QzRr0MSxYYy0lPW4IVDFOMpv5sMLZ1M6zh4VvvQF1oqYw8j0OT6Vh//SfxZ36kpTaxzj0Go7ZkD+14
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(107886003)(7416002)(2616005)(8676002)(6486002)(66476007)(36756003)(122000001)(1076003)(71200400001)(38070700005)(30864003)(66946007)(6506007)(86362001)(64756008)(110136005)(966005)(83380400001)(6512007)(4326008)(8936002)(26005)(316002)(38100700002)(2906002)(66446008)(91956017)(508600001)(186003)(66556008)(54906003)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U91Z6Sq2ulZ5U3jInh/MHagzMUT4vekKfc317LNdhcAWXdQwcO3bgKo9f1?=
 =?iso-8859-1?Q?nu6+EPYStBA6p+CzgY6aoo/MtiipyRVj5djwbnuxWTHh89EjtBFtrBbQJ+?=
 =?iso-8859-1?Q?j9MicF9Vb4CrhbrTN3fmKpimkBLfkoQVzthXUVMm8fNZUdve7MJST9OJOF?=
 =?iso-8859-1?Q?6YTwwaUFxyXgIFSg/rXF3C0SCxMimp0jMviRegwAxQqA/e/hTcFq5eYYiM?=
 =?iso-8859-1?Q?ZMs/Wb0IX5IopsAEKJ7Se5+f2aRNKKUU0exjN8ELmqqRJEZ7nQD/Y6dwJG?=
 =?iso-8859-1?Q?1KxSCHb4PcyryOnmj6Sy0W9EAOScdNnD1xbq0RU9AjsZcsk3ihLZWR/FnN?=
 =?iso-8859-1?Q?36xrL+t1/cs45fj9ryyd9BaZlUeRdAS3uAuwO0p+KT7jJexwOnGBNZ0Tq4?=
 =?iso-8859-1?Q?mRqoL8CDgE+NsQDf7IuymmdSvwgwIAsoUw4mriI++aScj6YNyK4iT2aWou?=
 =?iso-8859-1?Q?qKzBnlNc8O3QjMIME6tteTyOISYwmZf+04n6mL0FrfOm4eVI+oMDmrGnB1?=
 =?iso-8859-1?Q?nHGHFMSNPRD4tPB57MmdsIkOrSQ38FfWE1IfAQiygrSy1KgK65iBFqJfrC?=
 =?iso-8859-1?Q?JDFolgs013UZqSbtXYa1g5Qxr2LQcq4hu/lKH/Z6tikdVcVBex/cSF80AL?=
 =?iso-8859-1?Q?DjDZEXFXgNN0+fy250md7YjPsX2xdyP+6pBERDnjAzwuO7vafQPDUON2l2?=
 =?iso-8859-1?Q?NB/uYPHF1UaI2AUqO6qIHsMhmYslECensAVREuboLDVSoIOQ6u656tv/I9?=
 =?iso-8859-1?Q?NdYwsljktwpHqlnP+Y2suB0ow12iq7aooqV0t12w3st1O4XJN6Nt4Bx9r6?=
 =?iso-8859-1?Q?jPhg7WoNDdB8LlomayZ5MC3jEAbNUEk8PmES0wZZtS7zRN+yOucUI5Wqz+?=
 =?iso-8859-1?Q?vbEuDU1L7a39YTeEBBdA4HKvX2axXmauMvY+Lb0/YyWm9zjlwxwaHpetpX?=
 =?iso-8859-1?Q?esK+cnOjC6C8ZfLZzlbb7ZkqSVe6/lwXP3FAf1uFQf1auNolhq9gCmAjUs?=
 =?iso-8859-1?Q?AP5WoOkWO7+onDzb7U9VHetHFexfBDVDac1UUQu0sKk5h9+dA8322EugiO?=
 =?iso-8859-1?Q?9zQE4HKjgEX7pYHaSoDiHP7mJ+sy7baMrOYynypAM2RUViL5icfB7C5wS3?=
 =?iso-8859-1?Q?U21Vnqdp3aTTAMk+qyvYa5Yn5M7qnFejqiQFBCcc1fZ6Ufb+WmvqnHrma0?=
 =?iso-8859-1?Q?TmWDWZ0FAXkkEEU6H3/vr6nyW/QC66zJV29M5Y7twn6fYncZUwBCoK9OTx?=
 =?iso-8859-1?Q?v/gbl0LiRs0PTtEJWLBvhqAnsc4tCQ7HDKolqyvrOTVh5qxAnc/HZtonSQ?=
 =?iso-8859-1?Q?a/r/7ybsja215h54M/4S6fOfy9RLDt14erjuIy27iRCY2nB/s4zbtP2rjB?=
 =?iso-8859-1?Q?QJr2AfhcODX2QUj+KO1T823o1HLRxGG8UW0XA8QhngdQJyhCJIzbWVN6gp?=
 =?iso-8859-1?Q?JzEaKSyVJ8/T07A7Op6CibrgYbKVSw7yIBrEpSQ3dtipVxd9ROZD3ma1kw?=
 =?iso-8859-1?Q?RA52cjVMT76zYV4ArFMQJFcSbGXKYKyLyyvPrrSDZwwd+XViJMjqSZuuCL?=
 =?iso-8859-1?Q?XL7/knGL2BGpprOFy4V3stQhlKqCayXpTtMbRM24O/xPYKSc6/DvUanqu0?=
 =?iso-8859-1?Q?RzJpQ2WSTWkWHYRuetlW7HiGHuDJhNPxGSpXnB5NAfGr6nnbQ4g6gD0kgc?=
 =?iso-8859-1?Q?QVKOly+zSJB20FrzGqw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb130ceb-8d68-4368-aef1-08d9b4d704c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:43.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zesLzUTlQodlRqGE3yHM4tlEejERHrQ8OtriU5Oq8GpaIXQ1xpKETppMEmjPlz6zILkXmHNO9fMSyjHHtbCXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: JKYkn8JXO-3p9pzrjDqs8A89G9UTNkti
X-Proofpoint-GUID: JKYkn8JXO-3p9pzrjDqs8A89G9UTNkti
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

This patch is based on v5.16-rc2

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20211130

v4 changes:
 - Added the option of using an external lock to the maple tree.  This
   is especially useful for the VMA code as the mmap_lock can be used.
 - Added a vma iterator to abstract vma knowledge from subsystems
 - Rewrote mtree_walk() to be about 40% faster on simulated lookups in
   the test code
 - Reduce complexity in write side by reducing passing of flags in favor
   of smaller functions with minimal changes between the calls
 - Added struct ma_wr_state to keep track of a maple write state.  This
   greatly reduces the passing of arguments during a write operation
 - Added new mas_find_rev() interface to find a value at a specific
   index or lower


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
                        5.15-rc2               5-15-rc2 + maple tree
Amean     user-2        883.21 (   0.00%)      880.33 *   0.33%*
Amean     syst-2        164.61 (   0.00%)      167.08 *  -1.50%*
Amean     elsp-2        529.54 (   0.00%)      529.70 *  -0.03%*
Amean     user-4        908.66 (   0.00%)      906.34 *   0.26%*
Amean     syst-4        172.86 (   0.00%)      175.70 *  -1.64%*
Amean     elsp-4        277.10 (   0.00%)      277.41 *  -0.11%*
Amean     user-8        960.68 (   0.00%)      959.70 *   0.10%*
Amean     syst-8        180.93 (   0.00%)      186.16 *  -2.89%*
Amean     elsp-8        151.82 (   0.00%)      151.25 *   0.38%*
Amean     user-16      1043.21 (   0.00%)     1043.24 *  -0.00%*
Amean     syst-16       191.97 (   0.00%)      197.97 *  -3.13%*
Amean     elsp-16        86.55 (   0.00%)       87.12 *  -0.65%*
Amean     user-32      1203.33 (   0.00%)     1201.70 *   0.14%*
Amean     syst-32       214.19 (   0.00%)      222.12 *  -3.70%*
Amean     elsp-32        54.20 (   0.00%)       55.17 *  -1.79%*
Amean     user-64      1232.98 (   0.00%)     1233.44 *  -0.04%*
Amean     syst-64       217.38 (   0.00%)      224.75 *  -3.39%*
Amean     elsp-64        32.96 (   0.00%)       33.17 *  -0.63%*
Amean     user-128     1608.15 (   0.00%)     1609.13 *  -0.06%*
Amean     syst-128      270.77 (   0.00%)      281.21 *  -3.85%*
Amean     elsp-128       25.92 (   0.00%)       26.10 *  -0.71%*


Ops NUMA alloc hit                2198520208.00  2198508092.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local              2198582067.00  2198242905.00
Ops NUMA base-page range updates     3797662.00     3214462.00
Ops NUMA PTE updates                 1600670.00      966782.00
Ops NUMA PMD updates                    4291.00        4390.00
Ops NUMA hint faults                  381225.00      234029.00
Ops NUMA hint local faults %          112696.00      110041.00
Ops NUMA hint local percent               29.56          47.02
Ops NUMA pages migrated               308892.00      139306.00
Ops AutoNUMA cost                       1938.58        1195.29

Increase in performance in the following micro-benchmarks in Hmean:
- wis malloc1-threads: Increase of 1041% to 14%

Decrease in performance in the following micro-benchmarks in Hmean:
- wis brk1-processes: Decrease of -38% to -43%

Mixed:
- wis malloc1-processes: +5% to -18%

ebizzy testing:

ebizzy shows a slowdown of 13% to 32%.  This benchmark seems to be
especially noisy and both rb and maple tree exhibit runs that are
abnormally high in both cache misses and instruction count.  Several
runs were used to remove the outliers.

When perf is used to analyze ebizzy, the rbtree spends less time in
native_queued_spin_lock_slowpath (58.95% rb vs 67.48% maple).  lockdep
showed that the mmap_lock is contended more for the maple tree.
Investigation into the contention showed that increasing the spin time
prior to the rw semaphore going to sleep helps the performance.  The
store operations are slower on the maple tree, so the write lock would
be held longer which could account for the spin time expiring prior to
the lock being released.  The plan of introducing lockless lookups will
remove all delays for the reader in this regard.

Patch organization:

Patches 1 to 4 are radix tree test suite additions for maple tree
support.

Patch 5 adds the maple tree.  The bulk of which is test code.

Patches 6-16 are the removal of the rbtree from the mm_struct.  This now
includes the introduction of the vma iterator.

Patch 17 optimizes __vma_adjust() for the maple tree.

Patches 18-24 are the removal of the vmacache from the kernel.

Patches 25-65 are the removal of the linked list

Patch 66 is a small cleanup from the removal of the vma linked list.

Liam R. Howlett (57):
  radix tree test suite: Add pr_err define
  radix tree test suite: Add kmem_cache_set_non_kernel()
  radix tree test suite: Add allocation counts and size to kmem_cache
  radix tree test suite: Add support for slab bulk APIs
  Maple Tree: Add new data structure
  mm: Start tracking VMAs with maple tree
  mm/mmap: Use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: Use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: Use maple tree for unmapped_area{_topdown}
  kernel/fork: Use maple tree for dup_mmap() during forking
  mm: Remove rb tree.
  mmap: Change zeroing of maple tree in __vma_adjust
  xen: Use vma_lookup() in privcmd_ioctl_mmap()
  mm: Optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: Optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: Change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: Use maple tree operations for find_vma_intersection() and
    find_vma()
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
  fs/proc/task_mmu: Stop using linked list and highest_vm_end
  userfaultfd: Use maple tree iterator to iterate VMAs
  ipc/shm: Use VMA iterator instead of linked list
  acct: Use VMA iterator instead of linked list
  perf: Use VMA iterator
  sched: Use maple tree iterator to walk VMAs
  fork: Use VMA iterator
  bpf: Remove VMA linked list
  mm/gup: Use maple tree navigation instead of linked list
  mm/khugepaged: Use maple tree iterators instead of vma linked list
  mm/ksm: Use maple tree iterators instead of vma linked list
  mm/madvise: Use vma_find() instead of vma linked list
  mm/memcontrol: Stop using mm->highest_vm_end
  mm/mempolicy: Use maple tree iterators instead of vma linked list
  mm/mlock: Use maple tree iterators instead of vma linked list
  mm/mprotect: Use maple tree navigation instead of vma linked list
  mm/mremap: Use vma_find() instead of vma linked list
  mm/msync: Use vma_find() instead of vma linked list
  mm/oom_kill: Use maple tree iterators instead of vma linked list
  mm/pagewalk: Use vma_find() instead of vma linked list
  mm/swapfile: Use maple tree iterator instead of vma linked list
  mm: Remove the vma linked list
  mm/mmap: Drop range_has_overlap() function

Matthew Wilcox (Oracle) (9):
  mm: Add VMA iterator
  mmap: Use the VMA iterator in count_vma_pages_range()
  damon: Convert __damon_va_three_regions to use the VMA iterator
  proc: Remove VMA rbtree use from nommu
  mm: Convert vma_lookup() to use the Maple Tree
  coredump: Remove vma linked list walk
  binfmt_elf: Take the mmap lock when walking the VMA list
  i915: Use the VMA iterator
  nommu: Remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple-tree.rst         |   496 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/parisc/kernel/cache.c                    |     9 +-
 arch/powerpc/kernel/vdso.c                    |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/s390/configs/debug_defconfig             |     1 -
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     9 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |     3 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |    14 +-
 drivers/misc/cxl/fault.c                      |    43 +-
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
 include/linux/maple_tree.h                    |   559 +
 include/linux/mm.h                            |    73 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |     5 -
 include/linux/sched.h                         |     1 -
 include/linux/sched/mm.h                      |    13 +
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    71 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    21 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    69 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    15 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6771 +++
 lib/test_maple_tree.c                         | 37202 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     9 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |    81 +-
 mm/khugepaged.c                               |    11 +-
 mm/ksm.c                                      |    19 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    53 +-
 mm/mlock.c                                    |    19 +-
 mm/mmap.c                                     |  2030 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    31 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   123 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     5 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |    13 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/linux/slab.h         |     4 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     3 +
 87 files changed, 47098 insertions(+), 1794 deletions(-)
 create mode 100644 Documentation/core-api/maple-tree.rst
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
2.30.2
