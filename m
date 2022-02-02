Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451E04A69FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbiBBCmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31372 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231372AbiBBCmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120LxWp008539;
        Wed, 2 Feb 2022 02:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=M3BVQKM5iCMwBItiNLFk1Q//S/SK2sJGkH7wQJrEJbOzd+mCDaPBzac2B7oE9g2f3atp
 mldq3zGXMZq+RoJjyVc3cGakHJh+FnQ7AcFACINjnUl3e9W2bEt+NifpVOBgLWB9gxRJ
 uDEhGEW7gtQIYVozLq+oihCEKCqXrwdsOyG3IBuWKV7VGpffGf8m/fKJTuwcdbnfIDaV
 K8fWVU1LJJwsSQMR9ThmBef3RJEtDpLMPoWW2proh2obMqPRyMDkk8ejoU8PlxhRF3O4
 DeiAgRS6ZethHitE/WOP1rx7uHgMmnJUN7MbV+u7yOfFilSh4swyeBDNhYou7aL49wET Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvuep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPEC146731;
        Wed, 2 Feb 2022 02:41:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3dvwd78vk5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQQkBJ4P+8uNeudtGAtQYXdeLAnRHc++KhB74vaWrvWJjEhwMAijj686C6fqI2WY6XN104+ZYFGk3ylnsXLUazLlWY3/1s5C81HwD2yy0HGC5Vtpo4/KuxrZN+9hX2g3ntwJ/5G19y0hxOiMLEDZIMYR67kMdD5sp+UBZxF1jozBp4WuDaGweuaVZGByfFIfbij7EUpt8CqnFzvtejXsuPV9Nj34SiBxL3LOtF975FVjvEJ6B4lVykCFmTbGYGwVa1F1xUZt2iPFswTrB3TCaxSrbrw+0gajF0khSuzQrfuVRt73YlH1rpp/8+3CxKw637Jo9kPQmifSZ35jt2qBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=P0+H36D2gbDEBNZBv4DgV2zGSUDdpjIZR6nT+mJWIW/hEN0RJwKc23PgTxqXp+bOpsRIFccwaCh+iJWwuYQfYRbSf0JdjGO67iZ3w+OHwzoyBO/a4il0kcehjIqmXAbMmuGwKYEohklI6FynsNN3Q1hiAi+7S8uohbgvkRZhMIRVIDsFWpKhJ2bgUrpbsLjVRjGYtCRkwOiXfOV+bEXO0fi3+M48FtcmaTq//dQK/R1VIMjGu7aFqKXGgiyeowKK0Ik1UPncHxLVd8m2mT8Vt5LAfiTLNDM3bcRsxYBZhC5yi8TeCF07EzAXFurXEn+V/KIVkTCSG03IQ/IP13domw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=DbvExNTwunT+yXCUloNl3HlWKne+A5DISG9wc4pQ2Xlcr1OVYFoAhjbaGuFJoOsfB2B97XGCuHIoxRf19ZZN2gXDS62aHJCkPdMIJcFP3TCj5YaS4NxlvytvmReF710GpL7mS97BG4cWwkLTQqIthbuyi0LuvKG+ZmzjABuEff0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1325.namprd10.prod.outlook.com (2603:10b6:300:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 02:41:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:41:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 02/70] radix tree test suite: Add pr_err define
Thread-Topic: [PATCH v5 02/70] radix tree test suite: Add pr_err define
Thread-Index: AQHYF95vWhR0hRU0q06QH6843A0frA==
Date:   Wed, 2 Feb 2022 02:41:53 +0000
Message-ID: <20220202024137.2516438-3-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d400ddb3-dea3-4909-2f67-08d9e5f592ce
x-ms-traffictypediagnostic: MWHPR10MB1325:EE_
x-microsoft-antispam-prvs: <MWHPR10MB13252AC9DCEC26A6B2C55B32FD279@MWHPR10MB1325.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0gZ7kYuef7ZqkI/k7mtx9S+yu6PeWwuS+CdKn49+uXay0iqNQhzECA11GevZ7Fb/ART7Bltw651OPm9Bigk4Eha/XiJmluj86aINrf/178GF5sSYau3+Qb/i9jaOR0TwqAb+sd3iMX8mmhJUz9TllfP3j7pXgeHdDDE936ieZZwefQxbZurSq37BwocfLAxr4mIJ3zd74Hcu4/HyfHcH/VZYqCMdAeSvUqe/wAOQc2I4uugDEQQsEfm5OMkIi59QKQhaXmC/P0CXFTK+EDDR75/QQR2Q+FhoaB2x87NE4dG3/91f0yfP74lIdi/bg5xtrm4RLzWGNqo0/s7yPZfnL0wXOj0xeJV/twIZ6X+MbMNEmoHYQ/ydXf6ecCuOLjQWbc6XIJlc4jOaex0panMvPntrp69TSquCwe+MhrHNLHd4uTzOFbuWYD53GlTIeWLEtDMiQz3iaTvz1Wc8SThb5aoxFqDUwkkVBk4AECrh8POOdRHVZtWSX+G1u14OihvbK8BXbG/dFIkzOZsK4fSFqgC5meCF1ExkxDxhEaiNWj1/n/wG8poroSk2EdEB7ZniZA60QyGBgtVIsQ8HX/dt4J5YWWeH/GauKmBlcOqyF919s+ce4IXPAKYkXy77NEDigMunghmSxo4mJF7eNA7252/JwRf5Ed8if/g6nCQiim9AOSNesw4onSBE22o7SUZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38100700002)(110136005)(86362001)(4744005)(508600001)(6486002)(6506007)(44832011)(91956017)(66946007)(26005)(38070700005)(2906002)(122000001)(71200400001)(66556008)(186003)(66476007)(66446008)(64756008)(1076003)(8936002)(76116006)(36756003)(316002)(2616005)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yShgxtB5uoxLb6ZcCsHUrX1G3V8JnnOflG3hTrPVabQ7TsAeqv6V9ZCGue?=
 =?iso-8859-1?Q?UIsu08WzcPMLmQJaXk1nctYd8wOp/RKLocvalmzOUsRCm8Ov43VCg6tKHU?=
 =?iso-8859-1?Q?cFz8ALcFifC43KYo57c5OaE0zyuLBfvtyiJRBA2mOPBtwuZf3YfcaEbHZo?=
 =?iso-8859-1?Q?bjfEePs6XrPR0R6Zd9W40tCxmuy0OA31HPPAl7vF+q/1idf3SwSCNlnCxM?=
 =?iso-8859-1?Q?S6uCRT/0w4t6vpRfKjenaUec31Jqp5jkxZMga5HRvkXrCAUFsWESl2li5e?=
 =?iso-8859-1?Q?+OtBi7aYrdLiEQo84etzxHDOzkzJQHWUa+r+Yutsh6LsGc4P4k9T0Vbfk6?=
 =?iso-8859-1?Q?gajPREGToL30TsvFB5EI3DmihY7bDqlD1vqhJZ3ThLpUk/h4bN3DodFjkR?=
 =?iso-8859-1?Q?yIhIpURTjuyAVvIy3URpgqHQCnDuH9gfyRXLqx+CKPw/wuVgbZQYiDn6ES?=
 =?iso-8859-1?Q?1mLpZg3fybRJoW6RSXdIion/ACvj416Dt8HU3F+vQuZP0jw/PaXP0VPgSC?=
 =?iso-8859-1?Q?94l3/M27h7Jc6SFH8Hx+jGDJR/3UZIMhr8AuCkfc4zHjbBo4eFVl36DeNM?=
 =?iso-8859-1?Q?6l/V2kPJu8ps7IRLkX9jhmauzwGW5EvVqCLY/3XmdnQhO4HJbUNyeWjUQ+?=
 =?iso-8859-1?Q?9QAHX5qlvX+EVgKX4O06AGYqzhCt5g/bUkYJB5sy0fzxHiLqoFAOOQh+aN?=
 =?iso-8859-1?Q?0V/+VepKoyWrbVeh6R9W3X/tZNYhacsLsMRCElAfU1658OAxbbFLMQWiBR?=
 =?iso-8859-1?Q?fUZowhevjdeUva0yyX9cDfsz1HMFy+/IVUdZncMTRnfu0JbyyQD3LFcuyn?=
 =?iso-8859-1?Q?7GLPaTAJR+zLNIzF45/7uQMD7J90aCZW0J6RyPjaQVnNjP8xrKn3a9ri5j?=
 =?iso-8859-1?Q?Z0JlXJlwvZHA+tKqIZbsVshdSnObCwBN16JDU2yKZ+N5dPMvQXwtT1l4Kx?=
 =?iso-8859-1?Q?ihoCPTKpTQqESyXzXBbJB6BfIeR/I5UwatM92tz1/OFnMv24qblLepzg8v?=
 =?iso-8859-1?Q?snxFntNsVUQkc4Vmjpp5J7q/5IS1ZYuadBxzZJMw4ZTBdQan3ZRC6hOvQK?=
 =?iso-8859-1?Q?K84rQkDOEngHcXz3Cr2Lny+jEY6PmKIvb/mkfoSoa0TPu26M38a6VT7p1z?=
 =?iso-8859-1?Q?ZVgG407yOsERVCv2SJZpl/RADANcsy2oUEtgFg4VPmFkgkQJQnYPDhoWGt?=
 =?iso-8859-1?Q?qUVR1vd8/8Ia4j6Koj6/WGsg2xuJQpUIxpRtN8dsqQfqg6QGYcympYvV4w?=
 =?iso-8859-1?Q?tJLAKsRIidRxQIwsRG1kgKS5Vppl/qEyzGWHoG+kBqJ7I5mGAxxeNYepx0?=
 =?iso-8859-1?Q?c5Y93H83Iri8CjQTdmfG//2dw7WCLCms2T2boNoVagVaITUQxp550b/OmH?=
 =?iso-8859-1?Q?QQROsnB9g8l89XQolV/CVrLH7SLCnFFU6UZtBno4sDc3HHIhToA3kO/DdK?=
 =?iso-8859-1?Q?EaQNvF5iuG8JUGn1w35pLOZ1NiYoxjEoyE9TSfZQM8UM/lYQ4rwW1qZJ/M?=
 =?iso-8859-1?Q?WXmED6FZBGwfsVbOl+W7bHWRT7NF/j/5R8WqyzML7lH1ad6vULBU20ipgB?=
 =?iso-8859-1?Q?pGoeMh3nIH4sC9mtu8AS1K3nDU6VUHytRmGuDggKDpKSaWHr4zniaPNLFD?=
 =?iso-8859-1?Q?+5qcRMEBDdDm+b78rZZ7VZ6zC6njbISel9xyrgmwa4ToLtXv1/e9IOoV9K?=
 =?iso-8859-1?Q?R9hu8jTiK8zmMrmboBo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d400ddb3-dea3-4909-2f67-08d9e5f592ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:41:53.6745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2oegOnk1sF1ATldGOkK8P9Cp+292mV9fWb8mUHbKTCu0XgSFu+Jh7KTEAtZhbQirFT70QzcOrDSvQlpwzLgdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1325
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: FZjrzs3K3TVOnGTtWrpM2FQoJXeORuaV
X-Proofpoint-ORIG-GUID: FZjrzs3K3TVOnGTtWrpM2FQoJXeORuaV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

define pr_err to printk

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.34.1
