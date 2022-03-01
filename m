Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F884C85FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiCAIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiCAIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:12:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035183003;
        Tue,  1 Mar 2022 00:11:50 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2217bYkM018798;
        Tue, 1 Mar 2022 08:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=iCU1eLzs9zNyVsuEDWNxYwqWadQi5g8kmLV8bzWGEtc=;
 b=Sxv44gsPy04MoG1ulTPjW8FUMobpvVhMhyJO9evbnd6R5W0KVS8+B1uAQLiCwLRBmjPk
 LPstSgSjJup/+YjDN/KkdQyZYrXmS6wSB4OQ87qPmo9P4QkUOGcqxbBQQZsUCtiBXRLm
 si1vmJuNRfOPXkXNn2z4rbk9ZRZsRfHrIRzTbe1W/V1Sf2qBrjfcP79ddlrpbRBPvbYB
 tuWh541ZZuFoWC1MjSdSMm+Qhii/cXQyLAMTCO9Ofgo2bfgbZFIydFafVc4vpgigmusO
 omuTaF0/fIKlH+4yUTjveSgO1kMDR4jTfISi0xCLj7arRr3NR1yKwaycm7zv1UnLkyPz DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efbttekwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 08:11:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2218BOnE014089;
        Tue, 1 Mar 2022 08:11:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3020.oracle.com with ESMTP id 3efdnm0eub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 08:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W48saRV45C1Cc+kg1sSDI0MMhgRXPQYz2hoWHycwdCN1ZmZxzhe0bnuzFHJOOIFXj5Mk0IPzLFU4D/qmpuVlZOZHGTEbO/67N7Hl+dDlqDmp/umdlV3F44zpgC+x28VogxA38r4mX1nUCkbOXT9bEeGu849/UreoxhudJKu0LAW0j6MX8b2KUyMZrSVqF5GJbKKp7Vn0tSNHUrvn1hr4ABcXCPwOhKRSTVOG+SPyZBLcRyNc0A0/tTQD0kY3cP2Lvrean7VcIKP//ihQGL0PJuNVShamIQot06QL8x8D7az0n+Ixqxx2E0NGz0l1wDHTvFpjT/jtY+fhvOYqGY1YgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCU1eLzs9zNyVsuEDWNxYwqWadQi5g8kmLV8bzWGEtc=;
 b=BQfz4H4xQ3gDCoaOMZLSHZLtab4/RLbpTwd6iMHFwJ1hwk5MwkNHjbpooO0Z1EeNy92RIKHuSXQgZ1rVslGcerkE3KIwxRx3aUHYao4gqP0XIAkCB8HRXD6UClD7LXDkeq+jrIk69KutWdDuFbUcA1er7N2kBs3v1Ktl5EB2tEtektXZpAf+megtNBFTvoSXkEQqz2yr+VQJgnQ5sttk0FbaJNrQ9DVnxyTAkMfEFc1yyHjElRNBzIh2n8vCoVbOrXfP1KnBBaj7a7dPywavX84itFukWCu96EmD0vNKH1IqHVYzUZv8a6Y8JTujisxbUkgfaveoS4I9Je022KJ3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCU1eLzs9zNyVsuEDWNxYwqWadQi5g8kmLV8bzWGEtc=;
 b=yYQanlCBJOQ4dKIBO0rF8jZdYQZwZE3G7HWCOgK2K9zhiMm6tkfomoC3WBL21SWSScAC3wt0MDZovhF6vGplGJRcJfKOnJ7trghLxHhFlTSagralC7W+nv4TqJNAB5B2audRCr7eN968RdIse+GheQUCRLb8og6p8k3OggAc+SI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1760.namprd10.prod.outlook.com
 (2603:10b6:301:a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Tue, 1 Mar
 2022 08:11:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 08:11:39 +0000
Date:   Tue, 1 Mar 2022 11:11:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvmem: check for allocation failure
Message-ID: <20220301081127.GC17375@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c63c4cb6-957c-4a5a-d9ba-08d9fb5b1c90
X-MS-TrafficTypeDiagnostic: MWHPR10MB1760:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1760CD9B953B0B99835834698E029@MWHPR10MB1760.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrE+EEkLwtsSLa5Z8P8X3XSwt/V085NUP9+ostE/mMxGFuS4CVlW/9sQjKCo9ogx9VSDovCllXH33rb+gUnVZrXE5AhmTH3qP4kjm+ATOtrQATcsUy47vOcxI2UpcnZaBfTr+o/VG5Mm4wV003bm39aD0ngclHPteqFS2kR0umMOsYqX03tTEjzozeHNWiU1TooTOzPqoyH/cm5Q9snkzs3lMA/yfEMX8f0GCklxkrjkoMHg+aZxhGHY0bBxQFuGCxyJjN/Eb0aifw3ddWLMsMQpY9zJ1hI9V///wm8cyUkPTZWdL7/iXmNJw/9ZBhg/MUF7ZjXQQoUMqhXK+uBfhcISHAgOEZUSuXshdyU5IRzWTnVC8Ig4c/pOyy8zrgZvg87sD/ZKxHqV5u4XoL0bl19x0r81ksZ9o8Okkt7sWKsUfwZ0LBBBi9tb262wVXj4gCMAaU30XDgbkKH+yFQWZNIaFauwmXyCwuNInh2OpATSISjAtH5ToSONXKqYgNLcgBlHgCk4QcjoiISvbhvGCX/blqol7hECNgdbFDrmMNGgT+4xQU+yPiKXaYh9HhKoBah8verO0opiWxkd7YAYaHmBVutzKQJVZNQymU5rCGXSIZ+shL4KepVb/MFIRBph9GBQkkf2yp4HwAcpo/84/d3Utln9w6d4pqiDNlrKZDK56q7joTmU12KOnsxEpQXNeD6fXTqgoIjrtZZLKl85iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(8936002)(86362001)(6486002)(508600001)(2906002)(4744005)(38100700002)(38350700002)(5660300002)(186003)(44832011)(66946007)(66476007)(66556008)(4326008)(8676002)(26005)(6916009)(316002)(52116002)(9686003)(6512007)(1076003)(6506007)(6666004)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EoLngBjLb6Q3+TysKCjLn/9UIWlPYaemWyOjDXhpu6gTlMROmOFLf0LAoCCs?=
 =?us-ascii?Q?akFeUz2aTFEg0V+HmgMUFSh3MHrh0NAlhQTqIV6EGobIEEJaSJNzKnuSmgj2?=
 =?us-ascii?Q?+6TdRmLEHXEEO3dHFerS3B3IFi+agVK87rsL2WLCK7dNGuLYFNz7aTvPFJwj?=
 =?us-ascii?Q?c+lX37CWtAstGJBEKRfjLjquiuZZAWC1afxl9HVvg4OhxlUWdRD5eoRx2ym3?=
 =?us-ascii?Q?WZtPY4bR+pyPWzfB4zpPkVay+CT567DuhGKuF4COU4oSQmj013u0duhcrIJ7?=
 =?us-ascii?Q?ftJAoBDovy+Wu3aqg84NFmYCKY5NRmxBAAeeU0wZFHKESHxkiIAcOBL/tDyY?=
 =?us-ascii?Q?Bf146/KVTh9faqIf4qQp2uxwQRh+5TtZVQm5kuRMnn7G8zmcsFS++oJrDo/7?=
 =?us-ascii?Q?Qz0kbF5+4yQC5+A7UnQvi7norFRUk3pCyl1KkgWvAu776LxSwNd9tCzxUXOk?=
 =?us-ascii?Q?EA+i4pRsWHRiaBV2bm/Dmjn8tNDST7tdHMU6j1cYrcQo+Wnm/ntg3q4L6ziJ?=
 =?us-ascii?Q?U+QbZpngSmGF6sfUl59upr4u152ljh/4DMQOIqEOrArl/KGUkCyFQ6EG5otL?=
 =?us-ascii?Q?1PiHIx9L4YRyCdv9rhPG5EaHaGyrUfVa9rsooBKVqDj/CLqk9zaJMazjxepN?=
 =?us-ascii?Q?nVow3z+Ce3xGZg4wXEiKWzwjGCQE2ccIbLutJSC1MJg0mVZgkc173EEboC2f?=
 =?us-ascii?Q?5tgqglcQR/XhrHu0gnmL8vHhmtybgbquxirlqEiAvFZ7o9+2vUBSkDZkKMTS?=
 =?us-ascii?Q?2AW9de98LbPkVP2E7/LDUXc7LvbziZruu1/GuzuxXGdk63IYkpzXPLKxT3Ca?=
 =?us-ascii?Q?xR0CZjfSidF5y9nk3OVcVXAoeoQkcYFQj8UvqU6B7LQx0spstq6Ny8o9hK/r?=
 =?us-ascii?Q?RzG6vfFlbh6ilI5QJWsDuOTuJ9C+zQmeZD+LE/LOCkuPMnXjjTJA2E0qx84T?=
 =?us-ascii?Q?H0VOFaY8OZBqDpFoFvgd5frjpWNKvv/OuR5BPLGOpsYMksAmtNxdI1qkBhRy?=
 =?us-ascii?Q?cF3lj8Ue2TMuAE+poIOcLttOcePq7Mbn9UXeGPhE6Cus1YKUcmq0Qr9ie7ld?=
 =?us-ascii?Q?IDoSygQsDq7ISbpHRF4YuuLOklPSY3OUThytTg3+WKLg1PrU+SvrJqts5ypu?=
 =?us-ascii?Q?n3BIWxULNGWjaktjBbqiaB2wp0t3ernBgDFKuKZXDyrkhWTlbdmZxu+iwwUk?=
 =?us-ascii?Q?P7m7lI1gG10ggFsLh6+M829iKxJWExMRQZuPuOxD3NM7AmvVbSqi1Zu3Z9/U?=
 =?us-ascii?Q?xuee2gSHP12FeaT2PVAPp5FBXl/9r1JpTt5CAg7bqj88A3elGq5/4lAhHYkg?=
 =?us-ascii?Q?NL4kLnt4Vhi2xndosNWNcZO1wEv4muRPyw+bu/WvIlQjvZJZ+E4qdnoe9yog?=
 =?us-ascii?Q?qnUTDxkvW5RyYS1Q74Vuqw+PVpteSKyLXcGbhetBQxAvLLjo1E+VTS0QHVgz?=
 =?us-ascii?Q?+qyqFHQo6zZLbTPJnrSHDFuaKXag6u+2jQA9O6TjUNMkPHeUd1uZHBdTdC2b?=
 =?us-ascii?Q?/p475DbmpRGPRy8ez80zekK4yOcnEwdHu65iJXfceYr4PLJRbDbY9B99TWpd?=
 =?us-ascii?Q?KigtxqFIvhxi6nIdt3VSFILika19Hd8tYK7YRihrHth645kxM7+uvwH2bU5s?=
 =?us-ascii?Q?2pIqSoNftOkD1BuxHjtogG07TfkDnI6/mkRswhQpPqKczzmP9iIwABxqHCHS?=
 =?us-ascii?Q?oHMA8g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63c4cb6-957c-4a5a-d9ba-08d9fb5b1c90
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:11:39.0580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxrtpOEpHReSby0NVbatpGRyYQDEEfBv6afv/31ZJBOLGpgd1KCNYtX7425W4qReeBy4wOaG2jb9YmECAfP543WzbYVUE16m6kZnlYoxfsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1760
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010039
X-Proofpoint-GUID: IIE56vAS-D6sREZ5kZhitgjtDMs3uxY6
X-Proofpoint-ORIG-GUID: IIE56vAS-D6sREZ5kZhitgjtDMs3uxY6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for if the kcalloc() fails.

Fixes: 299dc152721f ("nvmem: brcm_nvram: parse NVRAM content into NVMEM cells")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvmem/brcm_nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 439f00b9eef6..c80af8a31eba 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -95,6 +95,8 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
 	len = le32_to_cpu(header.len);
 
 	data = kcalloc(1, len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 	memcpy_fromio(data, priv->base, len);
 	data[len - 1] = '\0';
 
-- 
2.20.1

