Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45CB465003
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350159AbhLAOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7864 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350120AbhLAOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:33 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAZeq017206;
        Wed, 1 Dec 2021 14:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zHp13GAdLIg6NII8GzYxYVLaHJFP1+qrrCimtokMQik=;
 b=UDFVwPJjH6rrCTPW/JBO84B1FQxAFNf5eti/e9k4UMoH08WVyEOYVuuojAFERiQ77CAr
 8Q340grkhCE1nxnt6SdDFJqDdiUWFC9GMiCIUhQZzuPNeLofaIFTE2+vkY3S8CkDY7qg
 1tR6hHzcz/SHp0xSPinWta7RIghXwrdUJleYL+PM56V39s91757ZfS8Me/in8QLZe/rR
 8McDJhvMU62Pdv0N7YR1tHeInsGAzRATqsxv0sBkl757yL6WwkayVc54X6VMuLbFee9l
 bzXQ9d2QyBSDmv5ePLKEvyHQYlPbKkTr1PYxlqViRFqXy8d3cUiloAtx3XY1PEwhVOFM VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBov3037539;
        Wed, 1 Dec 2021 14:30:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ck9t1v6xx-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYb11TZMWwH4qC3tbYmOkovrapPoFRgO2WFxfosaS7VnfQtXEA+4BzLE4jTv3Iis0YWa5ULLYboJRWzVayx8btYeM3jDt38zHl9GAnNdC2sM3aXe/3fKKy395GDShop/glM4gR/HXkgic1nzSg+CeB9UXZCmIrd8hWV6XGnZ61fsNbCF5r3srlhjFJOTrGvSI3nc8TOBQDjMEKosNuZCeGCBqJQ61dMRNk6TK81HAckNAYVpO9yCXlJq9d5bq586HcwQP1DEMIxX3Qw4Ux/HAu2MGkoHr8UYk67i3DQKu2iIQ/0XEcbPl/lDR/feCTs1eHi0hh0tcBezPKPVJx916A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHp13GAdLIg6NII8GzYxYVLaHJFP1+qrrCimtokMQik=;
 b=Qx0XUbrpDzQSU5tsfxBdJ4kKAX8OAd+zVfYv4efiqQvM3zBKkM+Q2LmdBCdwsE0wkQ4HihljMG49vwp1Zo5E/zZ/x8YT1MgaF6nEp2h7l88aC7BfEoN2+MSgV1E+4CPYii/otGDUQxyiXdGUlXaWmoY/NMWGbooW59ZoUNMCSxjzx8hxehG/V6l/5O9cJJgi/qPbthibcMmXfwjlxPCMhRweoj1DlIFAPXhuNSykse9Fjk7x5KCSqqgAS6b3uy3Mupa21Q0WHD2Y7cA4eonCIsJbPIkf6mernqhvqZGgHDJ1KUYFeuKUb1/I7aTqLuzc4NnxXseAWyo5y3nLyr8E4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHp13GAdLIg6NII8GzYxYVLaHJFP1+qrrCimtokMQik=;
 b=o9COx2D8nB560o2fKBr+gyLVxeeQTUWDjhbfv3eKF2uXgGL9Or68LXWH932LHmVD8aWKwWi0hLWexBsqqURuP7/qwCmmocX5qBp7ZFo42n6a3ey8TAJ4DfjMjehdxULaHszHkBWAYPz0sqtyiXedTXB/4FT5inVwHBkWmfKC0J4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:40 +0000
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
Subject: [PATCH v4 53/66] mm/madvise: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v4 53/66] mm/madvise: Use vma_find() instead of vma
 linked list
Thread-Index: AQHX5r/0qPGeFGLrRky44W3b8b2jaA==
Date:   Wed, 1 Dec 2021 14:30:14 +0000
Message-ID: <20211201142918.921493-54-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc74e85a-620b-4119-80dd-08d9b4d7267e
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB302144602D1BABD9499E7D89FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kzP8b8b+sRzPM1MM5VlxneEtLSo9nEhK07RQbFal7o22OT0h38rtK11gXALnUM3R2iMfK3lM3IiGhZbo06Jiwvx96LSgRWWruW45mcfHrkrXMqUzKd5A3XSU/zVdz8ArZ8vYtnqCowW/bUIZUMQN+84D4e6qX3ekycCgGFZ6wW2zVY8mzhqQYY25SPAPlLSbJF8GscsBJo/eL/Bf3oJYOR8PiGNyEX9unEAMXbrwcVW01Ki9yDkVpB0q1TyyDwoIeOBy5Kzyz3OuPoejfjXzeoVRohcE7n+xZeMb6ulNXJ8l1Vdbw2yrfLaBva0GjqUa4Q8GazLJ0L0KjB0TcO+LvGZXIXngbDWcTNJTVN+UfRq0kvmwvy1H5gl9ROCM3oYnYG6WEQoYdVnx/N6HkXcss2dqM89HNiErWVhC8nm6qSuFLnYJHfPOEClTOTOEEIcvw7xK0o3X/LICbo/b9Qsu4tYAvpKvv0RPGooC4QnrmcfUPlfjW1FFqME9mmjYsKQktJYyB11Bgm9QT/fWIRvxC1aFqGeE/P3yRrgpt0RtzBcJ9oFFOySseB0LY7zjfXvrEC90U7lau6n446H6fNA398gIIKTccC8wgFZVmK1cH934mlkSmNUesgeu1+OabxyzbpcwL5km57PRZDc7SvrhebRPGGCAdT+9ukmtlbOrKyNi2cObg4RvpTuPCba9YZyDjvWMWqNqEUprJiU7Lw4sdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(6666004)(36756003)(8676002)(110136005)(4744005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9yA1+9wgVY321QEuKx8LWJE0N1XjvP64tcakrf0uM2gAR3cDgO0VLmAd8E?=
 =?iso-8859-1?Q?pchn2uv3OxuchzWOqi+ZAbiwIszG4l7sYTHs5BvGdNwB6T3+dsYewMfC1t?=
 =?iso-8859-1?Q?7IFyTAaCHpgH1bRkMExTgnCPYrocSXVBH0eBNdP/ToF5cuxGU5LfkZ7FbS?=
 =?iso-8859-1?Q?RoYZKFE0ZQMY5kNBWXp1OA1mA00Mn4XcOBrM6u4O9smQMPaIXbpuVdstYQ?=
 =?iso-8859-1?Q?qbiNv/thjsvyKBxj9iZSeKJYE4mzA9oEHZRtz9bEpe4nSK7w6XAPBJvdkY?=
 =?iso-8859-1?Q?ilBzXIV1HyalQp1HlkGO5ATdY8+cN6EGMWw7Sre/tKdWNEP59ZZ53T8JX0?=
 =?iso-8859-1?Q?S8IW/Am5OuGsWu/u8oPRlSxNw9cYnqpsZg001xbQI3gl0wyKLkwDnwG8mX?=
 =?iso-8859-1?Q?1N9P6YuZZv3IYgBYgW2S+GaSRWRFf1sFlpxHIcdpDhmAAo0KYEx0DwINMR?=
 =?iso-8859-1?Q?B4Mq3hoHXgT5QCEPqoH5KlFrAeipalZF1e3aL0PhWyjE4tYssrbmJKf9B+?=
 =?iso-8859-1?Q?VVkzzKnjBavGJBid4LNWi21HMzkyzQ6/T3uX9xsfJVEtFy8v54qE4LWXf0?=
 =?iso-8859-1?Q?jk0B9kpyaCIE+4qgyN+xvX/DBrCzAFixsOv3VmqArzwTVV98yoqw/wq8OI?=
 =?iso-8859-1?Q?ZJSr19rUuHMtEnfAwEZ9LUN/zRLKJ937nqz/AcdNtNTX8J4AbX65ncfpDZ?=
 =?iso-8859-1?Q?NHoBMiF6Kn2XUs83/ttwuFSUu7lmzo1Rw7NQqj3bKZxk5sshYvYLlGwVwl?=
 =?iso-8859-1?Q?83Hz9iISuvEWvK0rj/vZzvIFEQyQmJ669y3bIkMuyfgtzxqgWcm2ArN88E?=
 =?iso-8859-1?Q?+hDkvKaqXFRNpoyGq2TZH421DossUxc5fCbdOROXbMabT0yuiBb0N8NBHc?=
 =?iso-8859-1?Q?Nx11iOs52pVfVIz3pUWPyMXFGUBmRfjE81QCvUBEhsZUhg/HimVNCcKAuc?=
 =?iso-8859-1?Q?TkFgGkL87nLhAgSOp/WJZONLV4EnLe9ksQoK0uGVLyiyekBYTP9T5ZmE9q?=
 =?iso-8859-1?Q?koeX4gMSlnKTllpU5L5omr2Twi9ADUwyCxogekIdQtkJehRHJW5IN8bxc+?=
 =?iso-8859-1?Q?RFAlMx6s8gNHFkd9A/xmqCrOsmLBqcwwwR5iY/I9DD9Tm7Xx5Gg/R6Drfs?=
 =?iso-8859-1?Q?R7ZYP1n000W/6lVIB5g9i9BqZCqhMF4W/73AClJCjunT3RZI5M82uICIU+?=
 =?iso-8859-1?Q?JhAvM3qWNk0WsQrJ/weW7QZJFsm+CmVyjNO4wEbnYE7nvv7ClFFT9n7JYy?=
 =?iso-8859-1?Q?fUw2FhKpa1IURLj3Wh24BN4gSJ7Jae0ue0ZhENbNgRvd7Wmd0CKApx/Q7C?=
 =?iso-8859-1?Q?L4WDO4N1BYxXuk3PRxGh+KgSwwnhcgz+GDQDoZBzFb6LF4LdO6DAmAG+OP?=
 =?iso-8859-1?Q?xQYKJmwEOl0R9AIV7vcMFHHoPBehgtAA+bAkzMnra7dpdBqQc+OAb9pqTl?=
 =?iso-8859-1?Q?wvzPbCkyQwMMkSdwzQ9SuRGXBzIkLbjUhlzJczCA+l5buqqDBbZ1n75Qe1?=
 =?iso-8859-1?Q?qJb0fVwnAS2czCIZ29+l6M7CenhXayNrgzhoivyguxDPkNRQw/jHiQcHap?=
 =?iso-8859-1?Q?oHN/Lo6SFqL6ngggOod42i5YlptNfJvGYjDadsGEytKC/WA7apo9s1AtJH?=
 =?iso-8859-1?Q?xmXr/TFoSeQdvOE3q2cWH+UTcDMf+6Mnqv6r7FQ+VKtC0TnbVpkUkp45EO?=
 =?iso-8859-1?Q?2cDXewwlFFkQMcXITB8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc74e85a-620b-4119-80dd-08d9b4d7267e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:14.1709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsMtIt0sYJMIyoIIu85IPz2To2AVLjJYt1o5AqMYR8A0w/DwiPrvY1Jg+50QOt2GZOSgyX0Rss38Hb7B/2iMoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: tY6XSLte00Ky_JtktO9i-SehHw-AZLUC
X-Proofpoint-GUID: tY6XSLte00Ky_JtktO9i-SehHw-AZLUC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8c927202bbe6..cb6daa98e5b1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1209,7 +1209,7 @@ int do_madvise(struct mm_struct *mm, unsigned long st=
art, size_t len_in, int beh
 		if (start >=3D end)
 			goto out;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D find_vma(mm, prev->vm_end);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.30.2
