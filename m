Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7E44B6F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiBOOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiBOOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018F10335F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:07 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCO3ER024982;
        Tue, 15 Feb 2022 14:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=XjRcUSKAU5q3rOwaWpilhbUDPaYCDTywDLeLvTQ51YBtOj1zAr/6BAnaWX/OxbDCxmi1
 MDcj10pQyMp9WBCJSU6jLGu7TTfVWvN/YyJkjEeuAI/8PG/m9BlcsG08UxcOLRQ0kOEO
 P0qBI3qh3bu69na2vjrCJLXKdr8Hq3W39LnpKO19Yz/P+ZjWrAlIHNB4xmQZdswKHQCt
 LkLgf6+wfu7yoRmOVFjUIC6E+x0p+avwx37+naFIlWWMYtj4v034RiMgOF6eqd/9dMQk
 nADWiXq/jm/DnN5M7OX8fucFiE1DYrXzPcv0EfAMaakpzV2QINESjBtPo7shJv1VEDiP 0Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psaq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVcY085745;
        Tue, 15 Feb 2022 14:42:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3e66bnpj23-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLxnsQqQhtTXTssQl9owb1+afU4/Q3QybU8h9wJsMk0xxiVSLYUMmELZaA5mrrjzl+yZ5B5Almt/IcIQhdCQTwaTfDpUfOYLppPQEKERRf3kvJ5gqm+MS3PhqAyDTprwnj71YqKwdf+u5j7TEjHdhDFKIo+8BnN5zwBJj/Ihh5mflVxHpPpXACPXeNPGCGQgV3vKkhDYko3prydUEXEOlzCrLUFj531V2ceMB26bWXyZSnn3JKWzhYepEClIb47GAmtOhPDx7hAxVwQcMOnLUt0iZdj+axpr79jN34QLy+PyRH+X47HcpE3/dm1QdC4aH6mzwHYzo7IefwAfyXF5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=UZIAqGJPUF3VetVtmH54s+V8oqIyrGTolIOsixPBzMeeUlYvmJlczttKZtgiKUcBxqBDU3Q35qyT9lYr9e3/Hl+jjuM3QP/+753ul1XyIvjjJyM8GzAJkipZoBhBOHbLxriIW97mgG9DXB6RFzPr9P1GtHb3MrOJcLSkAnaQHS7AnMR9Eoo5XiYileXSdCCSzbRNaE7PJY0frxGD5UvlhLNJzk3wFbi5DbzGZMpzhKtQCYrttpuv3BS6p7s4VyfrDEZHmH2J3dBidFSJjJTigCy4643lwNJK4NmO/L6sivXKxGv3ysCXvzINqABNmc4lPWwAwj+XLVwQK3VqWFxwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=tx3rpjoVN7KZbeDzbfIYWwhJRXPHfdw2oPNJEa9kktupiwQu5BvQHWPLDHxLXKX0H72E5Hm0ltyCwh8dH64oT1lMJLs1jIJl2n+JxK9HOM6ALVuIidxHHFtoKqpWF9cBYApVTw5SS6eMluj463kQjs1QKjTrK96Jzx4xP70x/ZQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:42:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:42:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 03/71] radix tree test suite: Add pr_err define
Thread-Topic: [PATCH v6 03/71] radix tree test suite: Add pr_err define
Thread-Index: AQHYInpRCDShTzUoOEm3UAymgt3UaQ==
Date:   Tue, 15 Feb 2022 14:42:56 +0000
Message-ID: <20220215144241.3812052-3-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00c5da0c-8e9f-4961-be4d-08d9f0917543
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB219742D48E044690ED0E0ED1FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T4q8vC8eR6fODyc++RcCGiTTmihyRvKEO0Vv7nFd8vrZUx+YOTMA4Zdhfc5O4yvuqqw4d+JZNETwDiNV60WDROpLc2Np/WzxFXNBiwtaKjlWcDhJPH5nbeKYxrIcxOqUbl16mWS0mVBC3lZ0YZJub3rlqSvGZHWRlMRieO6KeprAaCAmQsykrAAeU5HWeSBX8gPfB1eOXyqaehQGfqCRCgMfWRlJFUW8ZejkeNW/4mp40Mj96NesZFOQZb2c0c/oA2JBz/WoGxF0+Q1SQdaQyKaDx9vN4LhMsFFryxkvcf3lsCPknxs2LObzv+IVGxu4KbDsLxWYsd951e9gd5YApbVgYgzMY/sD/rzt4yRoj5+oe0Z4Q+9Fmp1d55YDJE2J9Edpgar/amN6GPxLNEoIkdUC4lpDLJLlgNWZKLQMwYMMbLYvImfjXwyLyv/uuuwfvEIMtSlR4xWs0wAeiyLUXzvBsxl5TzaEUGTu+kQm2+F3MLeuWIamR1HN4qd6877BZD0LPZgWeVLI4gy2+2dUTCyNAD7Pi8aXVkozwSLuzNCLRImEf6DAshrgHp8gN2BAAb5dPWaOpIyjLKinvBdFVa3FMsHIdkzzhgOAp1oiETnT2kzFdkCSc1TStkZuubqbQ8psokUdeUgKnlwVWsJhZVUPDH0/UwlIMSTqbrlsdippLzef2kMcLk1CmMl1u00t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(4744005)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BwKPTu2UG7HW88m4EkWYoX/n4c4Y/Vn//MR7GU9VFSpAZQXiN3M2Ss+2oc?=
 =?iso-8859-1?Q?lMLxJh0O6BNxGI9vu6E0pxOYe8bL0XGdJCYKSha23c9zRP8tpttRcgKAyX?=
 =?iso-8859-1?Q?y5EP2WrPEYXYzLrLwIsBT0dBCn1hJcYwuxNXO1yR+nA5IoQnJtGGyUyRKp?=
 =?iso-8859-1?Q?Kxfg+TpreOXXnzgxCf7m2oFmRHk3E0CWGY7gH3wAF3mmjUmTyszNOIEHph?=
 =?iso-8859-1?Q?YWDFk0b13S3DD4s9XrGaGuNpmDC5V6zFHhEDZcgrSbn4ZM7ltRPMYEoIJA?=
 =?iso-8859-1?Q?jUQhQZPHVEVd50noz5sZIU4ldENjrk8JAfwBBp4Vbd81mrZS0J0XMz39aH?=
 =?iso-8859-1?Q?u/bkpv9GBcu8unOGY0guknfqlkN6ZVrQgZzWQf391lDewbgsjTuROAVTe2?=
 =?iso-8859-1?Q?dpvZnG2M213bdlypxCM9tBs1OhTJqxBGmdbNYOuom6jpkYegsIdtQOLSvM?=
 =?iso-8859-1?Q?mfLmr9w3CZ90vPIVnGiKI5FDPVcZRZQF2fLISgqUcg+yF199irnnUjEJlj?=
 =?iso-8859-1?Q?zPHusk1CZDk6LjBDDgiyNaePjitpgVfqah0C5v4+iYS23cngTTcZ2pxE6w?=
 =?iso-8859-1?Q?4Msof/N4S2RHZVLMGCTZU5w4ILvmjUsfxFTza0g2XKHUMV19Est7GiZott?=
 =?iso-8859-1?Q?FaGPunAg6Hjmj96nUHDVdkAhA0jWtMuhQsUBnG/NGdHBCb6OgZaXnxzCZf?=
 =?iso-8859-1?Q?BtUl/pimamDppqW07J40rri5/Ecc7sMv9gxIOrqBSg+ZcMSLalMNyzAfxz?=
 =?iso-8859-1?Q?epx4CaeRbmdA+jK4jgwcV/eH85ROmFpa9aOZTUUvZQwhGwM5VSfFZ4dcKT?=
 =?iso-8859-1?Q?pZIrJLyrUKPjCkFM2MfgWpZFdCcvQ2HJd+qmhAFF7O7J26+wxkGz2mQJQM?=
 =?iso-8859-1?Q?xPcvRlZxObPaHcUJlaGSYD7MCM+TtaPLHaKyOX/H8lPRH3BbfQmEYaM5et?=
 =?iso-8859-1?Q?r/8Zzy2J5jYB3ZEwbLmKPcL/2gwVygSlnTyYNssEOLIvrkh0zG+HDjdgPp?=
 =?iso-8859-1?Q?gBoF4KKU8WMxd7a4b/01YRQpdazEVJOaTWACHrosynSnL+TMzpLbYei1fr?=
 =?iso-8859-1?Q?iXTBNCKcFir10Vl820vNqNZQ1ldcu+sJtPJI0uspHJuZJ8L++rxz7ETjA3?=
 =?iso-8859-1?Q?nha0WHVG4IjAm/ZQKc+804mgfDIeHfsRlwcfxngCUs+48LzEtX+dsvASda?=
 =?iso-8859-1?Q?oPrdGA0Va8yIH8VAb3n53/vjjgGMI1qvtr0Ce2wXMSB4+/uX1eHpdHGJ3d?=
 =?iso-8859-1?Q?XbvNSDZFSXd1zfYbxNjXtwgQDOcjajXH0e1g5hHAw1y5MH2lFt9pEZOtts?=
 =?iso-8859-1?Q?HKAzDmiSlaC7oFpjzALJvj3iTNnrElsrmCQXwHDUwH7/X/F9mQe+VAWP78?=
 =?iso-8859-1?Q?LjFQe2iOGWX+tiSAAcnUNvLh5SikAcx+XGiD8PJ3iXqdxG3X3CTakW6IX+?=
 =?iso-8859-1?Q?TvPvb0kaCPMkAOCMXpN0qfW6Bb6MXB7uXOUkBxC/lg0tFuaxaXAQduQdq0?=
 =?iso-8859-1?Q?pCLDZHLKYzrppw/IetCM41ylRfC0mYlI+fJEZEBefyZzOuPGFiDtfZGhbM?=
 =?iso-8859-1?Q?TvPyG7QKirof5Eje7DxNFEnk5OVMTaDfRyLKPh78aAwtnGFpC8fv/bx0nB?=
 =?iso-8859-1?Q?6SY7/GtBSvNwDUWdVToc7sx/divd1dotEVx14zyEttmxHn5rKlGCJKFpal?=
 =?iso-8859-1?Q?j6rRMeWq6AIQyrcBUOs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c5da0c-8e9f-4961-be4d-08d9f0917543
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:42:56.5122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ctx9xf8Rx59rdgSEjL7LkaiA2DE439iDSLwi/zDMJ6btNjQaci2zm9XVaR/qVM2Qv5A6Vc0+ekEQX6ESJmkA6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: YOJcuqVdEguHtyW-29GvHHJXcAoOw4EC
X-Proofpoint-ORIG-GUID: YOJcuqVdEguHtyW-29GvHHJXcAoOw4EC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
