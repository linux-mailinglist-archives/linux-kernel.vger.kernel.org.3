Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0D4A6A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbiBBCmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36978 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243898AbiBBCmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:10 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120DgnR008551;
        Wed, 2 Feb 2022 02:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=T28KfXSivPjY4boG4U2aepLQjlhaTv0Qb1gUXWZnQaaUDyHgIoZ/QFKkh3QZw3VgFo5T
 yUKpTnHY1HNWnFkzDgx0nfej6S7O26+/MLnYtXHSfud6uYDucNr3vFMIpYQDsrdCRe2d
 uuKi5rK+gvqhuhCXSxjOX31WmljNKN7VH/YmjiUxkBXI0sMnwQJA4Z+e0rp1JFs0mgG+
 ZldUBRJUExsuNX8ykjDhNpqTic09gOR/vGg/Arxo0uR8u1unnqMkrhUfAGx/DkKZgvTN
 62MbNcvjPBNBzGu4lx9OftSnvLuPBnKaRtUMk99q+67+ZWQuV97rSiUhbMTnwBSaHj3O gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvuet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPEG146731;
        Wed, 2 Feb 2022 02:41:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3dvwd78vk5-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHG7clDUAShIgKwtPZr/zNDQihW6fwyNV3PT9GLC3cgHBM2NWju+lo2IDDSkoF+ik8Fmsk+zyxa5wuehZOK+kkUVikKYivrGyVlCMEUJyinvLyVn9XmM80icWJvMjwsPGlDmnzJAZ6pykVFu7Z0bx8NnKQEIxh6iIW7fAQ6R6a6pNyGz38SM2gVU+C0gF++CU4MHL2rYPreBH/wpcoUOw2h3hImEu8OYDRLXY7rKq6icuUc7lGfON1afIW7ROoYm1QfmR8qwx+/J5XM5X0WY0AUUxMk0mKbzDCbSkx0YZTLC9FT+M6opLsuLdwVOHFbqDgLCsflFvPrDVfAqi00ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=V1X2mLV2CVlnRcBSKaHRrn0KjB+eT6P/xnn6gjEybqtKfUuSXaWl4Mw4GD/Tv4DEEkCVkKL8CJGWREI9gzTpdWLfYiOcslQRMcX4aBy5XbxBsBsS8sY79+AA0B2fULSf8oR9FAZ+GmGOm3lDfuieAU8w73eRsHuVN0Hn5RsnCQDtaQpZPkhdawgm082RNpKMwVNhVcz32x98y7uWmHLhuVkvyFy/osQwRBQc+ABzGlv7M6Cqg6JSAQEy9PyVVbPMPwhFdzNsovBleagAbrYvtJr9WlWfKbOYI3/gcCKuILiBgyWOxCpIVZ6XB1NTmgAq4ylzoKUpASXNbPx0a74efQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=Lhjp06Ugq2nyh0pWbUem7Y9TWttqRF0or1Kd6M27vW6kK7vRpX0GJ8QLSrn+zAcCWyWka9rYCKOiojlBUoORYD1tnFuAUYUMrIYvb8IKWk5hmmA6yzIAVF5OKAZB7dCvg9OcyHOZ1jjQ+PQOm9m+SxkYwPuBMIZ7nr7KK+qe4rk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1325.namprd10.prod.outlook.com (2603:10b6:300:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 02:41:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:41:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 06/70] radix tree test suite: Add lockdep_is_held to header
Thread-Topic: [PATCH v5 06/70] radix tree test suite: Add lockdep_is_held to
 header
Thread-Index: AQHYF95wl5TefD6/V0OJifeSaw9bXg==
Date:   Wed, 2 Feb 2022 02:41:55 +0000
Message-ID: <20220202024137.2516438-7-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7b33299-0bb2-460e-cc04-08d9e5f59414
x-ms-traffictypediagnostic: MWHPR10MB1325:EE_
x-microsoft-antispam-prvs: <MWHPR10MB13258AB39C0F944BBB37430BFD279@MWHPR10MB1325.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HEyUHoO/nLVPCfeBxaKYZ0kvspb3PDeX//mJbsGb4vHJFyPAvpZ/VganhpfmL8a804R6n/BMIwpND4y0AUy/MrNj7W8BS2ZIIZFQNT4NSvLBxQm4SpAKPUAURDzB5nE2HGFg0e+ZZbd3cJy3oliFOL+dNKuQ7VU5SkiZ18MppuvRJ0dHpZUR4ghfY4idWCW+dA+M0DRbUH81WcYrp7h3BDdjHX2wXukJ+OeEe5Eq79yrc4iun3hMBjldlKBm4nT9Q0luE8A6o2IFyOsU1FXB/zj/DdmeWm8q9pTf9/vEzcqq+6wWynjlmRkaduOgFYPBr48QIY6JbNgNSJTei/tM8TKdQrI7eMEKYFc1QzY5GbXWaM+htiBBic4uDqND94QHjcLXyR11KjFyrsklWY1TS6JFr6vpois6OCaK7bgRRgy4U2U2Nltf14Y7BmB0iJeqy17c9DaC+sIKVMz7TDKMxqruXZiDvqj1PU85mEyHHtIC4Zynz4/Iz85IvHOXxs5VMdhLZf0Fr81TeoJNwuFMpidWpvTfgz/OWTUcdLH7RTnSNujiimGAXZqdhoZiPr+FzUFakrpLZ6rCRYuMQy8xzGyZ8QJjzIjRvHnuY/9mRS1IszP6woFaph1xdgCgjNurrkkzPh+8RpfTQFJPXLA+vpIR/Kv2Dk35sI/10XUNsL6LeoTn5H3YWDVq7ws+RGEXp1zX+O8KsVyI4QrUF3PmaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(38100700002)(110136005)(86362001)(4744005)(508600001)(6486002)(6506007)(44832011)(91956017)(66946007)(26005)(38070700005)(2906002)(122000001)(71200400001)(66556008)(186003)(66476007)(66446008)(64756008)(1076003)(8936002)(76116006)(36756003)(316002)(2616005)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b+P33yj8AqSa5SjuUlxIlt2jgvkEhKYGFhzOrvHhGcSdS6AepiNWJUhX63?=
 =?iso-8859-1?Q?T+US2s7FZHWtHw+oLlwuJAqldyIR4Wgsp54C23MYYvFMG9XPan+EbYNpxW?=
 =?iso-8859-1?Q?Uz8DjnAAhUw0oIdn9EOptMlZSciJzbaZemYO3ZJbgAtRUnFNGf/kss0Wvm?=
 =?iso-8859-1?Q?Ubo/mu2mwKs7dDDdxryI0+A5IwSK9Hqb67wD0EuLUQZFZP8cu4ptfLDTrF?=
 =?iso-8859-1?Q?K3LoMEuWPlYsgU1BYAxut7O7PTXCgpiqZY7iJS7TFW8lyzHrdmh4qmLCwc?=
 =?iso-8859-1?Q?xx8P/VTBYN2R6PP3492FVJ9tQKrFO0mm73ZBbHLDsazOe86fCnBIWyF9CI?=
 =?iso-8859-1?Q?npiP77ZwkRT2eNu7CBZ0Il7tIVq+m12br1+13zytnqJ15MlZodRcuFipk0?=
 =?iso-8859-1?Q?n5mO6iEHbPT6n5JxaYlUdktd4VAwL+Fr6kKHm2QQFh2tzAXh5mIQXq0Uxy?=
 =?iso-8859-1?Q?4iAYeSU6G5EhNZ5ttL+kOuEcMUx1AjbuBdhM0HuiEq0DY7XtXWFjgHMuIG?=
 =?iso-8859-1?Q?ziRRaRizBm4+9BCz3yWdvO+AsaHp7Pwq9O9g5LB86zGy41CllcznZEd7Qw?=
 =?iso-8859-1?Q?XIW7ltKg23hkTyMkLEW4qjn8vyCJQIV+aCc9YHOc7sUev5CDDQGMAefsEP?=
 =?iso-8859-1?Q?9cYl20Qo9LLS89H8bbR/rdnkQmE013s+Kncr28W+skbPhk5uJLVH/Qr6aE?=
 =?iso-8859-1?Q?PfVf3lUjUS533W6JKsBgYswWXO/Fi0RyTyuwHN1FGm6b7aBAGPbZVkSs47?=
 =?iso-8859-1?Q?+RLnHeT2ILAF90jncuUuTYZIFa5sZ/c4KigNhjTwgR+1DNqMagbiPbnhm5?=
 =?iso-8859-1?Q?CKuvoXUsLZK8zDN/mAm350XqL5aNGpWFGgNi38AUQ1hUf3UtQtp7k/ULhK?=
 =?iso-8859-1?Q?AIZCiPxHUb9YsbIlkxZ98Mgj/mizKt19+IJcpQBvUiVDfBSU6aYL1f1dMA?=
 =?iso-8859-1?Q?T0uDzBSV6CUHzBloSHjF2L1qAU76jYNrU4y20VZBnXQFsdLQyTjaACyQht?=
 =?iso-8859-1?Q?qxkFX+c4kjNvzicQNoT1tsj5Y+65jE/M+gUYHKYpvrxqDf/rysgTFf1YlQ?=
 =?iso-8859-1?Q?ssIVnTsvlpemrrMbfPqo/NjnFLDnCe2mRkz7GQomezLUNULTd/wJMC+cqX?=
 =?iso-8859-1?Q?Xj9S2yt8WLUHobSqa4z8QMoDDpNs1Uc9dkACc0c+b37S1wU/iThILvcqRk?=
 =?iso-8859-1?Q?X5Jm+8kyLDaU87HsvQloSJbgqVfErAs0VBoM8cOv/Cj47NwiWmdBD4v3x/?=
 =?iso-8859-1?Q?240iqWMmNQ7lNT5Q5sO8QB1SHPIC/GmoGIlVWd8cBgkrTReF0Kl6eE3MET?=
 =?iso-8859-1?Q?xx/TI9D5SOy89pzwMNV92V+jnzMdzC/7CrvfW0lIXC2w+Mb25CEBmnY0ws?=
 =?iso-8859-1?Q?b4NpIaThhnLKWTpoB8HWMbD80EpcniwbkWc0hieyEaU1AiNkzuzdvEkPxW?=
 =?iso-8859-1?Q?jP8Gpp1/MQ8+glYzrXJXVr9do34dyoCBZt8QhP48dHnD4iMm1u4o8DRfeK?=
 =?iso-8859-1?Q?fEe7Baa8GNKAtuFYnGbMcGljIzOvys5BOTQlcwlyMOSAE4na/Kk/yhNs0g?=
 =?iso-8859-1?Q?fc7zHGC5OPGf6m0T5Y/8nLxi0yIGL39gzcjHf9FfKcOBRXrPkYHpuuSC0T?=
 =?iso-8859-1?Q?GPVOq523DK2H+qmGmEirnLYeNmWdUyCyM4/DEAUjrffiprIjlV4g9AwtB2?=
 =?iso-8859-1?Q?aTnPlaHy67CoIqNFq0g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b33299-0bb2-460e-cc04-08d9e5f59414
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:41:55.2681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+lBSizMMwPFoE8vJDtFtgycHwZvq/XzO5ZEB9Sikn7XtieGaFAo6FjT/5PvEsBKZa64riuKPFW9W8MUt2NTmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1325
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: 7yJu7W30QUwYY9C1oaRfAs_ncZOZnytr
X-Proofpoint-ORIG-GUID: 7yJu7W30QUwYY9C1oaRfAs_ncZOZnytr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

maple tree uses lockdep_is_held, so define it as external in the header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/linux/lockdep.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix=
-tree/linux/lockdep.h
index 016cff473cfc..62473ab57f99 100644
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ b/tools/testing/radix-tree/linux/lockdep.h
@@ -11,4 +11,6 @@ static inline void lockdep_set_class(spinlock_t *lock,
 					struct lock_class_key *key)
 {
 }
+
+extern int lockdep_is_held(const void *);
 #endif /* _LINUX_LOCKDEP_H */
--=20
2.34.1
