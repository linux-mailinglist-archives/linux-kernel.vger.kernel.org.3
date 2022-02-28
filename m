Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC84C63EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiB1HqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiB1HqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:46:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F52766AFA;
        Sun, 27 Feb 2022 23:45:26 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21S6mH8B030439;
        Mon, 28 Feb 2022 07:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=kPSbvOKVPnYP/0RrCF+R25H3er987SS2wc+GnElXXGA=;
 b=CYfDBtbJH8ddmY4i8AjGOR12T4FibXOaCACUrOFy9KI1wJpoOf7uWmK7rLVoLWosTyp6
 +JKWotMAA3RRjjM++A1bt3Oq854d36sCEKLio16p9tvyfHjrPtnU/3Le7DtUmv8gYobs
 QYAlQrFmo7olfuKjQW3dgJkbhh+5BN1UU+yG+wNhv+Kilg+Z2URSnT37sMPjwjASDepJ
 PfnMgb5qhYQc8BHcTa4vQh8WicUKmAVLzDvtzVGDA4q0IyW/X5L8+BPHuudIQbEc+o06
 RszUNO8CYSK4KSsPNc29DCE3DhnChuZuLBtazm97VSvMx9zlgDcoatIKV7Dk8IrfTODA kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efamcbck1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 07:45:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S7jF9t012897;
        Mon, 28 Feb 2022 07:45:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3efdnjf6mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 07:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+KQ4QPMeyDPk2xS5vVNBp4zvP4GQvPLziIZ6vM39XgPrSa6hEqRRTygoWP9Ht7cNyCZB3zkYLcPc9M/w6v4dwNYktvVdlhYlH7psg5luWmczIUj7UT40IPRtp6d6ksvzQq7iU5yh8HGnAtKWJWvbEfprU4sASYvK/Gh2Amem3xg2fby1Qq5rgwZPg+O6skhW6fHL1ZqMLchRYcoiSpIUeJB8qA1yCtqQ5DUoUDpDkc0E6dg8exmploUzjvpbTSQDxEJzDhp8DDOKYMSEEiLmc16P3XMp5pyd3P8yd8iy/Q6d0R2iRDarE5xDIeuyXr+XenLEv67B95gRkpBwDFTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPSbvOKVPnYP/0RrCF+R25H3er987SS2wc+GnElXXGA=;
 b=cvl6OqblRzvjwI7cDGSALV0bw5jAVIbPWTMCgrPPySq1vOq4tiVcm3Hvgd+ym46q1CWfd72gkULJFhyBPDCelSkKuIXmfVx1V6wZccrnxG97z13k3HGshrOMOq1ginuMfkNH+PGy4HDm8ogcPuo0yomH9/Yh9zbO3t9TcaArbZgd7LdmohUZJ58xrnHvMeGiKTQnVyDmpeceLQQc02Lnt/wHrs8kkJI0EKUh9thXlnSMMiHry68B7PrHPuT+sKJMLz+OfuRndOiXwfkTKywGTP3DGSoPO30oRGQ0YUYuyUCArkW5Dwk/zB7ilHBT7CKl74+yfAAzLLt5pzN7d5dGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPSbvOKVPnYP/0RrCF+R25H3er987SS2wc+GnElXXGA=;
 b=q8jt8ku1W+arLG6VV+oawqEnBaqAL5R+094Uv+2KpWFz6RpUJjBdcK0YBgqgYprfZmqK1P3/ys4vUxWzYWvZmomimJpbDnOWzb82JSw0hwrybQgVcBZrVQFtZRfE9wY/1i7gNQ7FYOQFCvbT/+Foy1tY/PE+IW8Hhp4Oo6Y46cE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5645.namprd10.prod.outlook.com
 (2603:10b6:a03:3e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 07:45:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 07:45:22 +0000
Date:   Mon, 28 Feb 2022 10:45:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] agp: Use kcalloc() as a hardening measure
Message-ID: <20220228074513.GB13685@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb3132f0-93b0-4bbc-4d4f-08d9fa8e464d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5645:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56453D1F0C8741DE1B2C7D7C8E019@SJ0PR10MB5645.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHoskBn0QvaZeOzwc2jVtCkTmxMqGUYF0RPA1+GS0t3yGTBAxUu7nWhe76/vhLaj8BsHMAEj3fFwxNxwX+MuUVXe9QTuWs2ojA9iXs5+7sx71UIu/hv+KVsLu/4AISehsOzqWsiFl2MFmzSQHq+MYCbb3ECRl6RLneyDTaHq+XvWoeHAi5+8oePQhO9gqPO/SVvk1JebbpvxZdF7aUgeNg91jFl0gtBiiyEnbYLnFge+hqX/mF2Z3bpCUdr7TaVAF2xKZ5k8pt9YBz+3hUROhkLH/+AT8KDuIN1rVU4Mfj6dEHZ+I6MZKyXePwd54vQCjDaDYyaLxL2Q03mfM7jRWsbV9daD7n6thTSe43e4rBE/mPLoi8vsvJhozS5J/n+n1tHPuUFjTUsBuw7233mQoL2bKgZ1Xv2UzmcUjNR4zXs2o1peGYWmjo8QS1S+qEKG5ID8JVWJJsxKKz+XqiSIZglqlVn/x0dkTrqd7M4C/R/i0uQ1ljkuRYl/A2YNQ+kw1tn+ydAQNzLAWXwm1mZvn7NZIR60erCBgeoPefgToEZVGKg1rJ1R5WdBZng7Iz5C9TzLTcXTvQqv3atSFIZDJEQJ5C1E7QGnMWDB9ShLZ6Aigq1Z0qexLKN85f9hLGFejNtudQjNPYge6zqhppV31vQzOx+GOcm9TORprvhynuLECgJ0F75axjGkPrRMXudTrGGz4GTIC+6vfZMe/6zRpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(4744005)(52116002)(508600001)(6486002)(1076003)(44832011)(316002)(8936002)(6916009)(86362001)(66946007)(26005)(186003)(4326008)(2906002)(9686003)(33656002)(6512007)(6506007)(5660300002)(66556008)(8676002)(66476007)(6666004)(38350700002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oheVENRuScERLOcBJ9uCPy/BJcPGzzfnc560/o9uR+eSxpIJJbXkSxGtmOhz?=
 =?us-ascii?Q?OSUXvCc9dhtvp+Vh+y287lSYFMQk7Rwfqd6jdrOudY9xxX3BCREQW8fMHi5p?=
 =?us-ascii?Q?gPvP2Bvv0J5Nv+be0J/5eW8X6FIbBQo6sl34gnij23fG0vAtcXzAN5sABw32?=
 =?us-ascii?Q?4P921kQJflwrs7u10R3hGaX0ml3wuaBNDzLPwdgTbsBUPerCFYK8cCVdzURw?=
 =?us-ascii?Q?fnOFGuzJw3yXe2JoecoKMeY3/RZ8SGqAqdj7nM4RpMJtszzsJAIIiERWw536?=
 =?us-ascii?Q?MawUfUkSCNfC/1lOG487LU/Bu/HH8kW+PD3AhrgpMexfqdSj3XEb+EOhr2Mj?=
 =?us-ascii?Q?LN+0XbYAom6UlDR6/8tzzrTzCkfZRyob2JMeP/1V9FZF3MMFnoldsU1ZSSFX?=
 =?us-ascii?Q?L+7LNv7BsyYixqa2Ne4WYFsIziiAzvUs9BkcM0spM4sYiHdyYZCS0glMgD7F?=
 =?us-ascii?Q?8Wse8fQCgtS6dZRfoQZOwyFpmnwyj567ia5uPF9VkABty24vpPNlu0Q9aM0U?=
 =?us-ascii?Q?HT14QUPSnIo5kLXjykAYQtsvvJlWODejdzgq/L5DUCeFBWrlxyGCACbsaWm4?=
 =?us-ascii?Q?cT4VUvNKELCOljtlyjfduaO7TGqoVAx4q7RgXum6FR40QpkUcFJix5Xc04xH?=
 =?us-ascii?Q?+UO22RT3+k/Qe8233loVEIdp+eB/a3uMeBvLwIm/pe5i0JfVbaDEk/mgynNU?=
 =?us-ascii?Q?0/oUFFXCZJv9Lb9S8QHr4KgCWf7wAlVHwv8hIPoLk0t8gxSdBYGASndIgzqE?=
 =?us-ascii?Q?xqIY+EH6mMYNK5Y+NPt5f1otacdgvPPFqE/k7MyFBWfB/esATS7i+EBPhp4Y?=
 =?us-ascii?Q?F6EaCPLf3KCnxk3KNn4i7Cl0mE1kUIeBXIU/nOFqQoqW828FqDlmh//M5Nys?=
 =?us-ascii?Q?K9bGMxoY5/MCG5e7epcqR4wrSt6sYnBn7OoHnSTBPR7R0zBB/3JKY6yyIssm?=
 =?us-ascii?Q?+HCAKhAltHaZlGXynA/GE2njritPJmrObGdvlwvVT2E+v/VARQt+IPjXQCRW?=
 =?us-ascii?Q?CQfBetk2ZmvrvE/S1Pf22/SFdfL5MSsoyJmcQ/qlOeb0/QbR+wzcuoFhKp7O?=
 =?us-ascii?Q?D1ASD3vKGhQPM0ZPughmhemKem7uYnNQadAgGPl+Iut6gu1IKLpsD69RrR/s?=
 =?us-ascii?Q?hQOh7ti/BkRPXh5BClJpWFomenZ/qSFZTZRCPF2vLlQH1aa/tnyHdX+prxXM?=
 =?us-ascii?Q?KWXW4PFyCOgla+ncPj5cnU34GoiqnSY3E4igpnku2bDpEvSA8UPDL5YJW8Fo?=
 =?us-ascii?Q?7aWfq06axfabbKx9ZxX6EYmF0Rl+D3V0mnODxHgVHcgPpRxPdpGhxLMN6kxj?=
 =?us-ascii?Q?LQ4SDSJrGrwogNi8iy2GoUf0dP2UWejiZbALXRGGq3IKIXwbEss57EBJJQiJ?=
 =?us-ascii?Q?QQoEvhbwPu3cj5fU4zk4BA69B0K+kHyKSCLG7SmMSNfkZJe5PAgJZmnAKzI6?=
 =?us-ascii?Q?GsObKpUSXfgyyN5ry88Nxu36Gy1Nxbx8OySUlxLRpVS+Bs6/J0ZUz4KqlZ6E?=
 =?us-ascii?Q?Q/WnEwxD99WC7h/JFjTGJp1bJpz0XadcuVfDjwyufe5CgDj0UGjtP0twV19V?=
 =?us-ascii?Q?77sYAj3rpmdXFg1QQdlSfZ1I0OUsf/HMK4V3a5lKAyipiGCEAX8FGIcmYH/N?=
 =?us-ascii?Q?XZcS5IiOl8xXNZ4PQJZpXn0fDvlkZmhRbdlnCDtCSbe1m9rPR1r6stovXj7c?=
 =?us-ascii?Q?umrbUg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3132f0-93b0-4bbc-4d4f-08d9fa8e464d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 07:45:22.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKPZTkc96Cejthr/e5xDNf9PEJzLIWguQedix5F2p3kS++MRqnPJKC9Ye2jqaG3TFDdpkkHBd7av0e0jbh7L5wISqDfpGLAISNqSshll2Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280044
X-Proofpoint-ORIG-GUID: lBkNkwXnNrW-O2gUbXiAYf4kuCrrnpUC
X-Proofpoint-GUID: lBkNkwXnNrW-O2gUbXiAYf4kuCrrnpUC
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The advantage of the kcalloc() function is that it checks for integer
overflows.  We should use it where ever possible as a safety measure.
Plus it is nicer for style reasons as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/char/agp/frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
index 321118a9cfa5..25b27ca0ab47 100644
--- a/drivers/char/agp/frontend.c
+++ b/drivers/char/agp/frontend.c
@@ -167,7 +167,7 @@ int agp_create_segment(struct agp_client *client, struct agp_region *region)
 	struct agp_segment *user_seg;
 	size_t i;
 
-	seg = kzalloc((sizeof(struct agp_segment_priv) * region->seg_count), GFP_KERNEL);
+	seg = kcalloc(region->seg_count, sizeof(struct agp_segment_priv), GFP_KERNEL);
 	if (seg == NULL) {
 		kfree(region->seg_list);
 		region->seg_list = NULL;
-- 
2.20.1

