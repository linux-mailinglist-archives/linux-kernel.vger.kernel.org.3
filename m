Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C9751932C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244908AbiEDBLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244888AbiEDBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB72E9E4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:07:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KjZ5f013502;
        Wed, 4 May 2022 01:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TNMWphPtjard9k3471GPoeMlaFIEuRlk2JENN8rICVY=;
 b=R9OQBuE0wGvM7x3CfAABKVQuSCc34TbCIcTw07s9cHmjWCXbWvsyIMleD5AhjvLiYxu8
 V1oZ2V69jeUCEwQHxnNqY0SEFcoHCmrSqYeecs6tIcLI5bFQWv/lQtpr2PUzDEdNenuD
 aH3VuoOB24tArL8OeSkEQSpu1RSxUiY9VAe8Ng+GCtMiG1rL5F7icHIwepe5ZQFYD81j
 XO2KbzZe3JX7F5PRqHecnkj27a3TNm3IPyTlSGJr2tMoVVEyanNDShWvXaXzhRne4oRP
 FRg/B75HR8JOm7fsgQYKM7NEy5/PgWivHMgryRA2V2rvxbdb1HGvUtikPxQzE+sln8rh mQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf690-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SuC039134;
        Wed, 4 May 2022 01:07:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKkEJLtJ4OzU442TmdPhonk6a5IQoligOwiUSYqR9SDQM0tSHvz2q4SqvdvkN2d5S4pArXO8sMKKcBNqNMf+00vYBUXUCMthyr7ckKcc1ixZkest6c2XieZR/x8j2StYTgV0N2EnklhKhCSChxyeG20RhJfW4Xru29A8Kl3wocf91lYQ5Lg2/njYpAzs8cMBv5bZI1uTTCYE9E97JRS4QQf12U9Em/UirAZw9oZfbfW/UcYeIWaF1T9HkoLEaIR7uOXlb9ndO0OAwN7RXE2e+yl48Ub2rjtU2ghMz+5z2W+yHbM/UWpKo4oLZbQVTYaFIKcD4kp4Xn0t7f0WNIl2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNMWphPtjard9k3471GPoeMlaFIEuRlk2JENN8rICVY=;
 b=lFxtUFZyHeJKQav/FqktMyj/EHwcETsRk/CJBNucg76vVvkNMXioMSbS/gc0OSqBTF+1Uc7tbXZSvXza1eYIRC3fW3arNYeo0fmH12Ra4tJ1KwLj2ltKXimsINGHPN206tFXZxN/Hnk3a+1+q7PaSenWGloPeBybJOeedKcBkvT1CYzWdHnfKFKiRleY5fbgwgjeuicwsRG3QhzbCRqDMQKLF1MXH4OKB7nG1nfNA1gY/Jn9RekvbuKboB0Somsts5F8fWSiASb/NPbLGAJgxRVyEzTyWybooDxY7gHNZ8knn72cVxOD/F8B11r2QSTo3RO6jhVVmNfdWoor4YmIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNMWphPtjard9k3471GPoeMlaFIEuRlk2JENN8rICVY=;
 b=LK3UsLh/gMuuPVnjMZ0RSvJBdyRjVoHkJeUNWNjVYFO9+OPpzB6bMzGBZomMrCQpoBjODsxC2JbEBO9gpWmFYzzwdtoXCpviDxkwRptqqePcQelmbzHr6V9nvb8W4WP9jvDmtLDSpxDx5r89HZC4mSBjdYjLV7KSLKVhW3gdJN4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5445.namprd10.prod.outlook.com (2603:10b6:8:27::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Wed, 4 May 2022 01:07:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 02/69] radix tree test suite: add pr_err define
Thread-Topic: [PATCH v9 02/69] radix tree test suite: add pr_err define
Thread-Index: AQHYX1Nalwf/Xflca0uoChBRMrCR9g==
Date:   Wed, 4 May 2022 01:07:41 +0000
Message-ID: <20220504010716.661115-4-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 846b8f13-efe8-41b2-bad0-08da2d6a7d65
x-ms-traffictypediagnostic: DM8PR10MB5445:EE_
x-microsoft-antispam-prvs: <DM8PR10MB54454888724B6B87D5AD15CCFDC39@DM8PR10MB5445.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/VL2a96FEW6YphjLipS3mx7lZNgsfeH249OpyPmYexfkPcREz1Hwalr4V2HHZoQazTQm09mprAfZbgdDtvQ7xKMMju7t4W0AQ7vrtAKee3+UEZ+Mr/hPzwp/3hOe1REJrN5TQxobVeR8BnD91p3dQaP1EJK/6P/CpW335H/IFl/zZp23Mzux9SRUxv+rZkrEx9F7jRgNME2StYMA6vkPE9RCXNXc5Hh6ZAz6cnv/3xilIqqCH1T9x55JytkcDXw33WQzPVmMX505GgSnGRAhbo+vrJlX6ne51uLn7m3++X4YKWgdijtUBC2pYV0sILna2rIJsQTbbwWfOZNHwFvosudv67QnQFGjZnDJGC9kM3btkylmZIfjCPums/R4kyzY+SjCH/mIHs8ozXJK3LT8DZsKEe0MU3Erg9JoShmpFrMj0faM0uSQUDux3gYyCxa+IsZrmBc3Qrj0OsYjlVwyeEY52Qc5RhzriJ9xfwYfO6fhYFPZwmzlw4Kv+i82ZVwqRsNs1a+AvdJNxfxmwlgu8beg18Jb4re/IUIQvdC5Qkecb2HNSRxn5J32MZIVW0CFrA49bbmQDtIP/axTXionnomvFqG9kX9ZHtgX1Ritra4mQk62MAJ2dzz6Uao4+52lTonnCzIqRaCPCUBLSt92RVpSmRBw/nICZC95ZWItuZCGje+TwcJaOHY0IyXpoikMiurQlqfbOlJaXUgEyqCqVkch3kzLhZmExgLVTeCgwrmHWjgxtxgXP0lsz9CcnHbOX9DbHV/DnaIUkigjqYMMxwW3CDBP1l9LJMdq7bPge4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(26005)(5660300002)(36756003)(6512007)(4744005)(1076003)(6486002)(508600001)(8936002)(966005)(38100700002)(110136005)(64756008)(66446008)(8676002)(71200400001)(66476007)(38070700005)(186003)(44832011)(122000001)(316002)(2616005)(76116006)(66946007)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6L+3VufdxMCGE8mAv7qfpTBeDCLYr2zheBjz/exrtYQ6d/1E29NGDE0Ewp?=
 =?iso-8859-1?Q?Cj5+dxXmqsued928wx3keCTLseOA1D/5UWgIenN7A+w3ZUJZ+Oo+ZlcK0C?=
 =?iso-8859-1?Q?P+7mHykjItISKNm50Zy04zTftDxJkvzYwBbprGJVJmL0135KunWrReQVtz?=
 =?iso-8859-1?Q?gqawsedhpGzU9aHgB+j7eYa6frb2+IMoUa0i6L5Csp1GrSC9Gy6iiBnHhX?=
 =?iso-8859-1?Q?bktF/HRF47hxySgoSnRv1QUSqCKXw1lQzCa29s9DG5tsPo7nTLPOQ/fG59?=
 =?iso-8859-1?Q?LNM8ZJ4X9dtRPFyYrXEEVq5DNdlVbgJaZItpt9reloH+nrddi7mPiydszl?=
 =?iso-8859-1?Q?kw+rmgYevKjKNNCxjRQV9gzNPTTZUez88ZjxBxCNywKyMOX1vd8Z9k+zEM?=
 =?iso-8859-1?Q?M6NXOuinKecVq5k1PHBKe9dalvE45WKt26vHPKqwaxgKdqIhNCbHP/ltKH?=
 =?iso-8859-1?Q?6Sqz+irLLmqrIV46RZb4HmmUzUpY3JhK0rgeLAGihy1Z/U9xN8g0UBaIOB?=
 =?iso-8859-1?Q?4vobVU+q2GfQqSPmeQlKlXAIIwQ3BX8E/uBuT/nhCnr0PtWXb9bngOeeuC?=
 =?iso-8859-1?Q?5+9KYnN++9pFOJr33xNFN20xd/1MKbz0xsHpsQc2WJr2IvQgw3srC8hoF4?=
 =?iso-8859-1?Q?QW9vMB3aDB+v8M62WgkYRgvqws9grtuF37pl2TJmXivATz7wzAggT/HWLP?=
 =?iso-8859-1?Q?oreqscE99GtVB5XnkzNSQlyfRk4b9RBAfuzmbvH453kqWtsxEjhFGEsXhI?=
 =?iso-8859-1?Q?A2sodAzIw9Wvmtm0sQYxrfTW05LxeKp3+R4jBG32QC2O5xQcL+KscSTEy/?=
 =?iso-8859-1?Q?Rv/hwBPOWuM/pr1+BTHROGGLAe576uTre5ehdakLH8nwtBScp+0t4HTUOG?=
 =?iso-8859-1?Q?SKU65H8mX8vnFKGMDVDXKti7qLaHZBVzV23/b/iQBWbeLfQ1dipSQHNYNq?=
 =?iso-8859-1?Q?2LOoMKf5kFin0fz/StlTZSn6pCQwxnpejjDTCf7xb8JoAJYnad98WPXDcj?=
 =?iso-8859-1?Q?CPWXSQof1wXAqxYQdbjnU6bvECApf6bEezlYd7hShT3dvnfjK8R3Q/mywQ?=
 =?iso-8859-1?Q?KUeO9BYf2VBlD6u5w9ilItY5PBM/FMsaVjh6Gk8W9p2gZL1e1vD3VI9wN0?=
 =?iso-8859-1?Q?216PR5Hc+hrQ/afY/aq7HIwP1NLmxDyz9FF1dkeMqVt08Ae2J7X1Rheeiu?=
 =?iso-8859-1?Q?qg0MtZjmUiyWIxqaMiM/WVJlusPPLLrMRW7HXZigEGO885UhgysXjnwDLE?=
 =?iso-8859-1?Q?lQOAwvxtf5LP2e9Ntw6av2KLTKYGfScVVWL8107FovwFqHQ+fc39y0dr7j?=
 =?iso-8859-1?Q?xOt61BmTE0T/t6jlaR0rqJhLSgPVCLyaeHxiXoFjyvbEnZacpowGHTgMGb?=
 =?iso-8859-1?Q?2Oi+YIgujHn8Yn2rdOhaNzYh38jW5KFtIBipIq6ITzJCKKiBxyoyiWcGC8?=
 =?iso-8859-1?Q?t0g1cuE12gPnjwae1FkC6T012PpEtRdzP1naYDllJiK2tgD7l/HYv7sOya?=
 =?iso-8859-1?Q?ONxbMbIn7i3LQYB0sTcX/vlbVjwp/Vd+iIdHDW87r/6jwxaea3F+Pu0KTR?=
 =?iso-8859-1?Q?qAX6AiDWcSPNFi1rE4ZErK49vskd4V7dcq+kT3ka/7iRRnMqIEDB2NR+FQ?=
 =?iso-8859-1?Q?cFwbCbPCHOqxYrRKXYoa7SKih/VGAzjY/EsrAk4QQpPO14FilB1jk9Wuy9?=
 =?iso-8859-1?Q?kByoi7GmHxnRdLC4lW7TUkrwDR7DC+rbonkMsnOo8OhDa3bw6IWcREWZTB?=
 =?iso-8859-1?Q?yQ6UNVrg4WVaiYDlV3C/xdB+fyEDRTxYSGZhDkkzwN+3bycXDLIEoguzCE?=
 =?iso-8859-1?Q?1vzNfuziOE1ydGPkbixZsqtXb1NjQ8k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846b8f13-efe8-41b2-bad0-08da2d6a7d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:41.8542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abaZYKX+du8fU0Bck7Jt+HHMajDj0FFzLc7M9qpwHRmgGrZjge93Wo+/jx53Q+3phlCRtkPRroAn5+AXyDrDQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-GUID: iTJFeUVgwllXFqJjHdq8Lcz0spK8O31m
X-Proofpoint-ORIG-GUID: iTJFeUVgwllXFqJjHdq8Lcz0spK8O31m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Patch series "Introducing the Maple Tree".


This patch (of 70):

define pr_err to printk

Link: https://lkml.kernel.org/r/20220404143501.2016403-2-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
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
2.35.1
