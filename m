Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B04E5E51
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbiCXFyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiCXFx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:53:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654D91ADE;
        Wed, 23 Mar 2022 22:52:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22O53EqU001940;
        Thu, 24 Mar 2022 05:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zjRaQoymWAqn6wUtVC/zmQ0DwYQuTGfZMXxUeCw6qMs=;
 b=I3P2yxc3XcFwUF9EC+Wy5q9jpKXl81dcwF7AWZLe+a0FjHUUcwp6C0P/rdp1lt839O+s
 1H0ax/A/R24qDilyE5H6sXfhsW9S2Y/wkL2VX/Yamv3pFOK8lZ3k28ZMyZLk3GJXJEpC
 TdmYcPKfGFC1ZhL2uVH4nHUKb1NKeP9V6bpnzHWDAHfUyV6Lf3syyLBR2IGhnBq6ZW4u
 lAJRD19Tvx5+84uFY/fyX0RALCLW23qxGENS6JrKmvl5QiDyNqMFmOx0fK97v+D0JhbR
 c7HgPju3ZnZwso5yESYqJFaXtP5cEv8gu3YyTmXjxaVKEY5LsZ+NWdEiFwJu2A6mPu/j Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcu5f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 05:52:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22O5p2Kw031649;
        Thu, 24 Mar 2022 05:52:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 3exawjbst5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 05:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl/A8mhoNVPNqr8OQTu9iALI9vXp1jlP38k05D2BOJzeit56npM+mbp7pPcbAwkr+koK6SJxq/9B4GnVz+1TSGNraJsA8y71Sd3u00HYs07ulH3rzNO1jehvu3dffgVxs3yM9S3pXb1pxH8QdkG0YUN/uFfYgR9bPZRSyEoxxHZAR5TqXwMk118LT97Ev4VO6+VkoOKPFzM2TdFbw4ABnmY5vs0HVH3XE41Y8iQkmUjbLTVZOgHKUszKE1F/F3Fq4rztzpAKzcfP7AhpkL6hEaaxNLgolZh1rw9dmnRCXwzoH0nD8uZ6vJFfQPlcN4xpCbPAQEr+MYAdg+uQDcH85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjRaQoymWAqn6wUtVC/zmQ0DwYQuTGfZMXxUeCw6qMs=;
 b=Fu7Gge4V7fS0Vaxz0ctmbsWTsULrqW+weCzznhO2Vw3vyBhTxim9CW8QWcCctNpOK004ZJpB363f3mdJzywKBiiaWkknVufIv1+rzXHmQF0QRB2caHFhDR3+6Go4MzAG1YNtFJu5OWiIv0NVVYtNChYWyQbs36E6ypgblMuzl0sJxDB7Vd9ovnP4tZygRUprHo7pm7ab6p6JaJQr7qKWSa4VzxheTKHago0EqSDWSU1qxofa3fVXr74y0uA1tk25pL0aidX5qlMymamNvPTU8UHQMI/sjcytCuIDaam2QwQMphuY83dr5xsbWIGUfInphnQsFgFZkNvsCRUHgsQVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjRaQoymWAqn6wUtVC/zmQ0DwYQuTGfZMXxUeCw6qMs=;
 b=q+7h1OWkEmG0SUfm3QjxDQOOB1IJLYyf3/g7iD0PAwPetABRIuV+hTFncGJk6c7tppu3o2lEkkmK+5QR8N/a2uS9UF4/WaLFKAK+j2RZp713AT6EkV4Tvyx9ZbMxAKWHkonMBeWX52aksXrLaZB4JGFu01BnqncScV+y1eowHNg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1317.namprd10.prod.outlook.com
 (2603:10b6:903:28::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 05:52:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 05:52:19 +0000
Date:   Thu, 24 Mar 2022 08:52:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] lib/test: use after free in register_test_dev_kmod()
Message-ID: <20220324055207.GA21683@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9d4f6cd-5b97-4af2-53b7-08da0d5a7532
X-MS-TrafficTypeDiagnostic: CY4PR10MB1317:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1317A9E6EC975F9973DCAC998E199@CY4PR10MB1317.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UJTtRdUJO1nhKble22dq7wqRHkkwqiOcQnr6kELp0Rhg/39VFZ6nFJWqhVDU/AKpBKrQhNzVTb9CVhO8RK2XzGyn5n/3vW68v1BcFqTYcWuSCWbdhyRvQDU3xbwRIgdVkJXyFTXOLV8Z2tEsetyIQwd2ejSFaNEgM6XItC9xw+FC2zSikTdqjmCW4JHW8N+45+LzFADjKGGI42UHGPHZz6U9Rd4YEBv66DxBj7zJ25IOUWEY1Ijks0IEeM99bUIr4Xer8k2WHsrS1nCo7qzn0tRwdomw8IOJ9WI/Sha9tvlFWK4BH8kJ3v+PScS+gBpuBEOm43P2lE469+BcTpq1seg6nW2SRVv+uJsaGjdbpywd36IC0anzV3/hAarPcxMTjtvMO1pN1i6I35DfJqL+WingA7XpS1LylOKK7WAAGtgKdtdUtgN9i6c8e8Ix2k6yPED4cfGvU/jvmdDXPd0H05J+4Rqon5cKdxuMUGFuR3EPxqSW8lQJ3MKBP8AdYtiRRrjJctR19SPHj28mMr2XgVsKvqFG0weaqFLftHxSkVsscyC679QvNOCnzcI79JvHNcKQEi4naf3MLY3xIO1A211laby1xzYvOBwHkzOaoCDI0N9E3LVc0/cJWvbPd9H3xxSj/zAkXlhlZph6wy8blNV7AdheytZHGq8YqoTcRo+jtkgBxMF46j3ylWAT7jQ1L9TPHCF8mQPmqEBkxuYNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(1076003)(66946007)(66556008)(66476007)(316002)(8676002)(86362001)(6666004)(9686003)(5660300002)(508600001)(52116002)(6506007)(6512007)(6486002)(6916009)(186003)(44832011)(4744005)(2906002)(8936002)(38100700002)(26005)(33656002)(33716001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Knic34vQTVpnL9Z6STcw+XAvh9eVkGrdVwcGRqvL0csdBzuycv4dn1gIjXq2?=
 =?us-ascii?Q?sn3VPKnSZug5WSqffOrDxlGbqyikL8ptj2WoaHSit86SEaCNpwEaxSqMbrOR?=
 =?us-ascii?Q?yYhA1o8NprRRWAhlBBaJLlvMtRz5iadqdBzCEhJ8M29kZxhGKpUJxeYbjuZN?=
 =?us-ascii?Q?DM3FlkBWDPQEkM0tTHtH7yGpA7vTh3TTX7TRDLK2yKg3nVJQEIfVjUgT4AqW?=
 =?us-ascii?Q?Wesm/HKgfKwsAqIae288H7WdsPkzgDe6XqhcOu9iSTySfkoh+uFsJrM+KyF2?=
 =?us-ascii?Q?wvHnLrbaTBpArweo6/x4mXC9pQlWaJarjEUK6j+phhipoTIClWwFG9uSK6Va?=
 =?us-ascii?Q?AV8doSVPYnufiW0zk9ShAW1Et3TfD5155JpizsUMeiD0awxv9C//2iiWVCDc?=
 =?us-ascii?Q?a+qBQ7WDIOaO+xgv6mUKfMhgTTOIa18dTlgepfM0mJ2tqzkU/t2bj+eD89m/?=
 =?us-ascii?Q?fjPnni+uAb4JG1qOE16lcknyHju2ea+3l4m4bI/Mvs9AxFV3Nxa3kRSGBZmG?=
 =?us-ascii?Q?NfZarcx5QJC920SghV+Zw6PDi9WHNrSlY2FkpxYOF3JUWvvjpmoWOqp6RQx6?=
 =?us-ascii?Q?7tML4RtD/hZrK12jtDFNt4o07YVv66CSR+qoh48lJFmY3NXQfCfN/SDRx6HA?=
 =?us-ascii?Q?TnSpyvdAR/YFTxxDqjavqR1/say+gQZLYXM/DcUygzTkNSx86kIecarWKv1I?=
 =?us-ascii?Q?69iv9Zseng3+Y0xlNqEk/sL8IqcfsI1BbFlAwTxhSlH0ufUztkwldBrQlM1e?=
 =?us-ascii?Q?jN4xc4hL6nBluh/40/vuyp4ls3bYnW/MJOUzG2Uny9VvY50IBQWHEAygJlfx?=
 =?us-ascii?Q?bzLW5JsViSz6OujJPkl0PE9/RmpwFeAFAtO8Nj7VvgHIU5kuubYoi2VNo/FY?=
 =?us-ascii?Q?b4QJ+8J7kpEWekkzsjehxsTHk5QNPL1mY+fZzesQb/jQIdyMsjXsexDnh5q9?=
 =?us-ascii?Q?sohQO0t7Ojctjc92fXX0LW+eya/BxsXHbohEl9A0Tb1emauJz80wu1oWWawY?=
 =?us-ascii?Q?H6raPA77uQq8m1TjuHI7bMjeWxKzIrYNP4PExv4gH3Y51cWfA88GcN7xwCri?=
 =?us-ascii?Q?OE9j+ox2npRI2E0yCb67kRMKOp+RIa87GpedThxuyscV9NDjQ3/lr5crWMm2?=
 =?us-ascii?Q?QrNEvHlb/Z4RDsIz7MaVKNlzoajOtgFjonl/1LBWMH0NXjqWui0Fx6EFT7/r?=
 =?us-ascii?Q?ZLeSXz4LEEKLgjMtPJDqedNpl4QFmf95vGvKbBCrsVDbcEajOuNsQtL1KwOi?=
 =?us-ascii?Q?LVKOXzt24a62409oQy31/tcRsQOs5XVVFIMSjVXw7a2KIs7d9/9BuqOyf2s6?=
 =?us-ascii?Q?DcbGXwzgwy7m5C3TuA8L9TRoEfim4obk6lyiFGDQz2dCpT9df9NLLekUaEoa?=
 =?us-ascii?Q?iWu1Bj30Asp9k2OB/rJkpKzUOOj7n+gfXDmFpKMPesM+dd0bU/QDNNgrWI6y?=
 =?us-ascii?Q?kTmWcbVUqKVGcgHV6hn1pC5jxX3p4bBsQMFL7PwS1qVuApAplB5BKA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d4f6cd-5b97-4af2-53b7-08da0d5a7532
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 05:52:19.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wChoP0oJDz656QSZuEN2D0n5L8hcYgNblqPaz1LP04umSx40mDu28bfRntrpHxv3pjpBnStTW8qOfAX/vbbXnuhuTt1ttwefAbz3gp9fX0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1317
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240035
X-Proofpoint-GUID: V9i41Sy_J5xwKqCMpolmKHJSlEJXGyOk
X-Proofpoint-ORIG-GUID: V9i41Sy_J5xwKqCMpolmKHJSlEJXGyOk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "test_dev" pointer is freed but then returned to the caller.

Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_kmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index ce1589391413..cb800b1d0d99 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1149,6 +1149,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
 	if (ret) {
 		pr_err("could not register misc device: %d\n", ret);
 		free_test_dev_kmod(test_dev);
+		test_dev = NULL;
 		goto out;
 	}
 
-- 
2.20.1

