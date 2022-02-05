Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE44AA7E8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 10:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356197AbiBEJ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 04:27:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1044 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238571AbiBEJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 04:27:42 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2158dfaM032440;
        Sat, 5 Feb 2022 09:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lyOywd0D/DUM3oV2xv5PohkwGvXxvrVvn/ZjFs0LPb4=;
 b=FY794mRudc1V1thN1WMuPpxfJ2AxqfRQA+1X2VZjXLHZjEV5QEM+tsq8Imf9obBP9++d
 8FM/CkKFV28peHVOsyB8NXgZxr1rXr+SwUJC8zz+t3eIOgOkW79cwjZZX5qtceKHGDy7
 5zCh/+Zk+rO2jL2sXQ78cetU8759yc8ARypFCQewYDJc788u89YYezcVsxwTnQYqdH4I
 2ujXQaDnS9ao+DQQppfUM54LqawTW//Cp1fQ0wk/kiq6B9TvIsH3ZRVDodYGwzxbYJWo
 vHsWRMtkYELqh/E6z+p9Pop1it6m1kX2Phs3maaGjaEqc+SQZCtKUBxqE1BjsIvNz2O8 tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1h4b0j5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Feb 2022 09:27:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2159PbDH016945;
        Sat, 5 Feb 2022 09:27:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3e1ebtmtgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Feb 2022 09:27:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR+Ylw0it5zMihWDFOktRPOZ0SjuvtaNNWZZBhs4372bkfC1RbglYpNjbvLbnnieIkISmgh+/WyVd0tY1DjFXj6VZF/n96FiUMrumoAPAOjgoXxt+NBlmCKkVYM6KjPvB3cof06c2LN29VNSlAuk3Mw2Vz3GsMneBuLQGlZFErYlxVphQXJxBODIEtVwIcc7l8u8wJclWG0WSLKNchKnI/5Gtvo8M49pgSi6LhpZV2Yb1xGGMoYcCBP7dtJ2fwjfbvZy8DQ0GwSXFO43aT9Vb4mLEQC5xn8sSBHEmunATu6K1WEAJiXRDTD4GzddrkbNTJDHZRHOBDpnSlqoqUW8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyOywd0D/DUM3oV2xv5PohkwGvXxvrVvn/ZjFs0LPb4=;
 b=meiVQI21B9tbmf7qDhF7cWyzhFWOynPlDanDlJ6bRUv1cFRgzIDJhc52fHyoIF/+Ye20GqlhHFA4FctAMg0uU31dI0LlU709mu5P7leCbd46/nD7gapGjaryVE5wIILKE69zgqCM++/vOBGl+Tk2LbKutsgU77dd7LoWR1kbsxKv6VbIWgzfhU7i2SvnpuCTWaJH83CaKrnSFcMHoZ1o94SyHdipqnHutDTYBhjDhcsZbE2UK6U6sLw+3b9DJw9zHu6bRfCHR0pvJu0W8uKoqob4uT+lIMJlPgd0YdcYVWEfL2GD9dNxZo9F2xADUj0SMp60dxI5osefOdUVsqUeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyOywd0D/DUM3oV2xv5PohkwGvXxvrVvn/ZjFs0LPb4=;
 b=l452vjq5fhMa12R1oH5mDrDXTJ6vgMDFqXbpo47uMBzsXAnjAYNIGaW8pRst5g+h3LJ0X7usZ5ij9Ztsr/mdDRFSJLLHumgTLw4tRstYmnXE577mMQ8vyIJFaReGHxqu5SZDIPjiK61aLST1d387pgCoXXkajzfISRz4NzxPX5w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2953.namprd10.prod.outlook.com
 (2603:10b6:5:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 09:27:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.017; Sat, 5 Feb 2022
 09:27:36 +0000
Date:   Sat, 5 Feb 2022 12:27:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Kashyap <skashyap@marvell.com>,
        "Dupuis, Chad" <chad.dupuis@cavium.com>
Cc:     Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <nilesh.javali@cavium.com>,
        Arun Easi <arun.easi@cavium.com>,
        Manish Rangankar <manish.rangankar@cavium.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: qedf: fix race in qedf_alloc_cmd()
Message-ID: <20220205092722.GA15425@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9099728c-b2fd-4aeb-f32b-08d9e889beac
X-MS-TrafficTypeDiagnostic: DM6PR10MB2953:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2953BD1C9B0F0411F15AA71C8E2A9@DM6PR10MB2953.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq/ePXQnkTG8rsY31POS8y0fujvCCS90aWeMWV2+gzg8W6/fX+SH3hzHZM/zL07HKfEUMd5TnlK986JHlmLX7MCJCNU53mnYa6rI/TaNh7dmSEfrfmSaot5pkS//tjtwJk6C/xX/1a39GWpAATmBCfwbMlgwN2nA2Jkh7hySo3W0VOK1PFKMC0fhyPLIz0atz86qRrZ5OAy28lKcczNJ0Rifj4o3QVS7RfzrLBUeWcRV791Ub44MCD9UtVmwcJ1OY6v7LhytBCxqMFXxuuOkW1hnl2tLyGiihXI3MtxiFmFf7tF2shi1h8zHdQfgtEiocfIr/+SQlHpAoxHnZ2tekNeqBPXRYK9z+pO9juE5LeJGKxEfh+4A04m8INg3AdXJhmAeO7keqHzRNVQNusgve4wPghcpLplicSqwqgQ7AOr+9y9TQzqUifdaHdZAniNNWSBhSgmLYTI71Qytjj9l+EMORuCIDN8Ooo79S4qnL/Qp9Pxfb3AHkgiP9vvUrBL3LXpdXQSE4u+xPqL0dBbPz9VbY4wf52Rf3k17hDdb9uwtGh4i+MxAEsmlyyOdef9mRDeZBnkSWCv/FYJ7VB70AkysndQTOuPmkgMatiZ4wVD4/ZLjLHvqiRvIgtnlfrqdv/cMiw2Xa+lDYF8uXtrLNVyT0960+1XapoCUA8iClS6tKhq51HA5Q4GorMD87yVXZrjN2qbtngDMpB6BVXS5tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(83380400001)(52116002)(44832011)(6666004)(7416002)(186003)(33716001)(6506007)(26005)(66556008)(4326008)(66476007)(38100700002)(9686003)(5660300002)(54906003)(66946007)(8676002)(33656002)(86362001)(508600001)(6486002)(110136005)(316002)(38350700002)(8936002)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvRFtQaq2R4+23/nyVkE3ZA/1XbRqz+s/Spps4+6NKz4LbPzhNFWxowAuJOS?=
 =?us-ascii?Q?JxVVYAd1K+6afW+duMzvN0JDPs5T8GAXo0txsTRxiPwfccuuxNo5yrMF/omN?=
 =?us-ascii?Q?5RcfL2r2L7RHmDZHAVxAKsw6dk0pmv+uFjruBjE3ooaySTtLxK4viF1Fg//f?=
 =?us-ascii?Q?nBtHMDyjmCU6AwdikBRB8tLfiRNzQlG7LijPL5g4ykrSti13wqFVEBzJAI5T?=
 =?us-ascii?Q?sF1M5qFLJd8sjIEZZBrzYJSJHGiXSnyVzWeBdCQre4l9KLNPNqeFaMjaxYHZ?=
 =?us-ascii?Q?N11sFx4T4+suQ8t/Ge5ckgPjNwWj2sdX/k8aZKIN07qVG0jHEvrOB1OTGghO?=
 =?us-ascii?Q?8tPZ04tU763dIfXhBNkLgTVupoQD6dMNGjnUDBZs4Lln50v6AJTpiuO1xfxU?=
 =?us-ascii?Q?QkIvYaS+ZCaU8oU7pUYkT3wiXO4NTfgZvMV9ajRTbYMtgLRd8gcH13RtUht1?=
 =?us-ascii?Q?WHxeo/3dRhcJ07mlYppswVt6gCwHfiV5mkSDAbpGJ7kGEnxuXY49p2o81IVK?=
 =?us-ascii?Q?sTJCqZ5XG7ylSBDjyZyFY7SlNYdVKE3LKB/Gnh6/2gNkuD81BEoNShpQW3PP?=
 =?us-ascii?Q?EfVICRZ7tE6sDxj9BdtR9O7A5r14hxARIbHZDISMq8XJUo/miJPu7oZnZgbd?=
 =?us-ascii?Q?Ao6CeEp/wp1cDBajb4YuCm0jRECdtCHTCOk6NmdWnvlOQxcO1sqNzQV0j66f?=
 =?us-ascii?Q?mP82cfpGs/QAMSahicLvjYFGKf8gv3jVCEUQCZb9g9sxV/Z0CmQVgea/1V3m?=
 =?us-ascii?Q?HKSHQLp/P967P8bMf3QF4RGnOUoqyjUnMEgH+04v5RJ6zP2eDekUtFoLBCvA?=
 =?us-ascii?Q?KsHgWDygCQlGavzlsUByNxcBp691Y6Y3KPVd4lHyaQiI/x38Xw3cOtVWjXVf?=
 =?us-ascii?Q?BtL110pCEDm8H/hw0BLeR0EjXMRLvwmTG/jW/rjb0uzb0cPKOkT8pdm/9uN8?=
 =?us-ascii?Q?BtpWLi5APxXhrXAjYMmHupLTcVoV/8eQm+91prDZlrFIODrX/i1GRS/kgBPJ?=
 =?us-ascii?Q?4jLY45aEe4y/xO+Xc8DCuGYzcbPa/L8vjctko0sMKn4uJRMPSQD2v+BiFxT7?=
 =?us-ascii?Q?asGHfmdbudqepNdhcxarEvVadqbeFh8Tp6Uue/nF8HFZp3KqySP1FZBunMQm?=
 =?us-ascii?Q?B3TYNWRxPxKTJXcB51E9c9Vwostson4Izv9y51bbBVVIlf92HdaPTXVfM8Ur?=
 =?us-ascii?Q?YX2GG4zAsw8F+GGlZk2dZzfKluCUnYxxaKg0+OytthQHCKEqmR4uEOOF6J4k?=
 =?us-ascii?Q?eE/Hum0hozCi0RouSyOinAQhRGaVVW0hPDmFtPqBurra4yu2ayekSZ58scUy?=
 =?us-ascii?Q?2n6pJj6GxNIDc46wolL71UQgQRDJo0hQ0k3z4W91dA5ueZ1GjSW8UF5Tze+w?=
 =?us-ascii?Q?iRHnwZer8JbMU1bZNPglXnoFBIFIRYhNikE50Z8tBY8Jv3qCM5MImzkAr9mT?=
 =?us-ascii?Q?w1ngidRGeCJWiPYGK9bCB0PSzbnzN1+JNOl1wWln2YEDNubdcvQZXQjOToCZ?=
 =?us-ascii?Q?j8bYcU4WRj9FqOTdOmeQ6PYWH4/cARozIpB5IgTCm9WIh0RsMzRtdhbBk3Ou?=
 =?us-ascii?Q?P/Bp/cpZi+j+WNB7smvJdHJywuL/kSvpxlaKVT5ia4Oi6m2nxn6x5djTireH?=
 =?us-ascii?Q?m5Nc2R6TOS9+wL0NcRVaDrjePuwcUla00gp2uzhY0SzvYbtOnmRcH+aLGF5A?=
 =?us-ascii?Q?5Lx8qQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9099728c-b2fd-4aeb-f32b-08d9e889beac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 09:27:35.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmlYx5kry08AkMnj5mM46MNV2ewgBeDCJ9jyFmXZVQDN4W9JqG3k4B86NQtfIFFW0grLEMxu/ZPP9bLN0YWJRbvCkIretT8oQCWAUQS0caU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2953
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050063
X-Proofpoint-GUID: C4zY_pZ6rpH2l5pOgze_aDHp_uOq4Q0N
X-Proofpoint-ORIG-GUID: C4zY_pZ6rpH2l5pOgze_aDHp_uOq4Q0N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code tests whether there are any free_sqes at the start of the
function but does not update the accounting until later.  This
leaves a window where there is only one sqe available and two threads
could call qedf_alloc_cmd() at the same time and both succeeed.  Even
worse, now if more callers call qedf_alloc_cmd() instead of saying there
is -1 sqes available it will say there is a non-zero number available
and allow it.

The second problem with code is at the end of the function, if "bd_tbl"
is NULL, then the qedf_release_cmd() function will handle some of the
other accounting like "fcport->num_active_ios" and
"cmd_mgr->free_list_cnt" but it does not reset free_sqes back to what
it was.  So that is a resource leak.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This patch is based on review and I am not able to test it.  My main
concern with this patch is I may be wrong with paragraph 2 which means
that my patch would just exchange one bug for a different bug.

This really requires someone who understands the code deeply to review
it.

And alternative would be to deliberately leave the potential resource
leak and only fix the race condition.  In other words, if bd_tbl is NULL
then goto out_failed instead of out_inc.

 drivers/scsi/qedf/qedf_io.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index fab43dabe5b3..83b68583230a 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -302,16 +302,12 @@ struct qedf_ioreq *qedf_alloc_cmd(struct qedf_rport *fcport, u8 cmd_type)
 	struct qedf_ioreq *io_req = NULL;
 	struct io_bdt *bd_tbl;
 	u16 xid;
-	uint32_t free_sqes;
 	int i;
 	unsigned long flags;
 
-	free_sqes = atomic_read(&fcport->free_sqes);
-
-	if (!free_sqes) {
+	if (atomic_dec_if_positive(&fcport->free_sqes) < 0) {
 		QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_IO,
-		    "Returning NULL, free_sqes=%d.\n ",
-		    free_sqes);
+		    "Returning NULL, no free_sqes.\n ");
 		goto out_failed;
 	}
 
@@ -321,7 +317,7 @@ struct qedf_ioreq *qedf_alloc_cmd(struct qedf_rport *fcport, u8 cmd_type)
 		QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_IO,
 		    "Returning NULL, num_active_ios=%d.\n",
 		    atomic_read(&fcport->num_active_ios));
-		goto out_failed;
+		goto out_inc;
 	}
 
 	/* Limit global TIDs certain tasks */
@@ -329,7 +325,7 @@ struct qedf_ioreq *qedf_alloc_cmd(struct qedf_rport *fcport, u8 cmd_type)
 		QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_IO,
 		    "Returning NULL, free_list_cnt=%d.\n",
 		    atomic_read(&cmd_mgr->free_list_cnt));
-		goto out_failed;
+		goto out_inc;
 	}
 
 	spin_lock_irqsave(&cmd_mgr->lock, flags);
@@ -346,7 +342,7 @@ struct qedf_ioreq *qedf_alloc_cmd(struct qedf_rport *fcport, u8 cmd_type)
 
 	if (i == FCOE_PARAMS_NUM_TASKS) {
 		spin_unlock_irqrestore(&cmd_mgr->lock, flags);
-		goto out_failed;
+		goto out_inc;
 	}
 
 	if (test_bit(QEDF_CMD_DIRTY, &io_req->flags))
@@ -360,7 +356,6 @@ struct qedf_ioreq *qedf_alloc_cmd(struct qedf_rport *fcport, u8 cmd_type)
 	spin_unlock_irqrestore(&cmd_mgr->lock, flags);
 
 	atomic_inc(&fcport->num_active_ios);
-	atomic_dec(&fcport->free_sqes);
 	xid = io_req->xid;
 	atomic_dec(&cmd_mgr->free_list_cnt);
 
@@ -381,7 +376,7 @@ struct qedf_ioreq *qedf_alloc_cmd(struct qedf_rport *fcport, u8 cmd_type)
 	if (bd_tbl == NULL) {
 		QEDF_ERR(&(qedf->dbg_ctx), "bd_tbl is NULL, xid=%x.\n", xid);
 		kref_put(&io_req->refcount, qedf_release_cmd);
-		goto out_failed;
+		goto out_inc;
 	}
 	bd_tbl->io_req = io_req;
 	io_req->cmd_type = cmd_type;
@@ -394,6 +389,8 @@ struct qedf_ioreq *qedf_alloc_cmd(struct qedf_rport *fcport, u8 cmd_type)
 
 	return io_req;
 
+out_inc:
+	atomic_inc(&fcport->free_sqes);
 out_failed:
 	/* Record failure for stats and return NULL to caller */
 	qedf->alloc_failures++;
-- 
2.20.1

