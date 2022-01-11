Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1869048B41B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiAKRfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:35:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27372 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344135AbiAKRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:35:12 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BFEbv6004636;
        Tue, 11 Jan 2022 17:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hSkarNCfPVmhtIU0NZmds0Ywh+xOdci1sOVyX1QgEsc=;
 b=jdFcbt2zpwL1syZig2LqPDtTmb7JYNOznO4x+X8BRpA/ZRDeb85BNM8sA7S4fV+QmbIx
 ghr2J+sAhJCs3gpA3rNdPfA0yk6P5c26PV3CD8T7ke4BwMtBLPOT68L1wJmv6U18Fe1a
 pH9kKJQ31ceUnnB5tLkBOex0UAa6UvAywT5W0eJ/eBCz5EmJgutWqOYWXhMN0+DVg7et
 O7CkHYlx9b6ThzrMT62l6FqGdEZEuQhps2+Z8gWhPXO3Y2l07FxdicUeiqXlUwe8Xa19
 hALliuhMyKSFkIKuNbVMBaXQRrsocqESjyPucMdPhlYO52yeQi1+JozCx/LAm+P8qwN3 HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbv3td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 17:33:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BHGSGc188538;
        Tue, 11 Jan 2022 17:33:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3030.oracle.com with ESMTP id 3df0neb720-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 17:33:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxKgCc67ehLd3LgAeK0sTDWv/BpExAcRQqSJnEy5dOaWqzTdJgjuvxd5okRzq3RcgzPsEUaYSK+ZWkj9+hx1Jrh7fCbXVoZjg5CNhy7icE6DuL8045T6TS292HRQAa9H5lAeyIG4xjissQotfQN6kAqRKB41cYz8oR2iaLTSwimPrNlTZ2uGboKIWGRhq1IWEPrwuB9u5512IDzTzEhu7QbwWpSCtHiCV8oJ+rKpXYni6o+6gtIXfNAQoMXb2N/G6hY1bp6U/f1G9QEEVSf/gZvpgEMnlc8GdLG/sHZRFtbn789vwe7y09thWSME6XOK7/pNjYHYCGLB+/Cg7vuOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSkarNCfPVmhtIU0NZmds0Ywh+xOdci1sOVyX1QgEsc=;
 b=l6JMeTFIqiELSWHB81sIlTrMq7CrkSLXEP/3SyYoHzCKCpLfGmTHDB8oFaffidoHG3pUckqNUdJ+L9KEwpmnrH2WsQhOIw1CPF+L77suBLPdzujk+177rJ2mC9bt3HAdsxDNCCe1gDBkslHg9iGW7/10FUettqzS9h1TlIOoWOWU6YcC3dZAvuOApLFE3QUCF8yvkG+tOwKt1BW1VydS0Q76JTIXSOYHND45D4rCe7E61r2urdQlU5/QYLUxRZ/xTOm7kikeJPwLAsxFcli+Kjq4Mc4FHbNQQjyRW/sXDwgZP+X/AJNId/Jct6kVYoaG/Wp7VHhjLQ1aSj6R31Oo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSkarNCfPVmhtIU0NZmds0Ywh+xOdci1sOVyX1QgEsc=;
 b=oZgFOl2ogVol/aLQQLaMt7Jf+zW2jm5Db5rqfsgDcaJBi2FwMAPRjNm/AKpz0UCPdLshVempdMIooTPZ0LAp7EiCWwi9DnytmRVpbw0n4N4SbiVipjs/3TOCLSNIYiROJhKlT5YzEMC1FwOFwCsiEoWOXnjNlvU+ZMs/+UiZu/A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4641.namprd10.prod.outlook.com
 (2603:10b6:303:6d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 17:32:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:32:58 +0000
Date:   Tue, 11 Jan 2022 20:32:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] counter: fix an IS_ERR() vs NULL bug
Message-ID: <20220111173243.GA2192@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0157.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf96b445-9af7-4b11-7eb6-08d9d52868f6
X-MS-TrafficTypeDiagnostic: CO1PR10MB4641:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4641E6042ED130053F0D57078E519@CO1PR10MB4641.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hq9AUgCO0juXJ5HluL6XBK77LqW19Kpy4v6N+BLxv0R3TMG9EnKP6JXfniY+ye+fI76SNMSLrlA4JeOREE0Cw3jk4v6X4Q/H4WaltWoIW/bMynTs/9+8x/C329RLUc3F0B8LsbY33FNjnTXcn1hqUaBgy/Ee7TdCDUi5qflrR37Dx+PhK7ie6XkhiGvYgpd20D+ZrVBzSXd5IsLzrbUugnPXCoXicZhT7bHsCP4EsOPDQkNpSBoWhUEPszEden4b1rRaZwpw2WraTId2XfXSxESQIcEzs6sZFGojgt6JOF+exDq0j3ijjw5VEPnkMMvjP0MZSl+qSVlSiJH7QS/Il1ZkYFq+VIikCDy2sLT1bKExegWAAl7b8OFVE9nevN6V/LJSmnGG+t2yl+4cR4OIJH9yFajd48MUMqDbNZXmGNHCmX/BRJ8cBVCfyjMSRRkoVJUuwaWRcn3cz0Kw5914AUzk9bWkGXgmP928zPIHW4PMeav5l4wDp9aDEBObzZgDakVTHCCIrLaeGFc2xOlf9nh/H8c1xwvbQKgfNRHgAU459XwL0tIgfcXKF0a/+eQCYSie5MxwlVZaDR9aMKBdKBxhIDnRm9B8tInDc0DpXJKiU/aGFZVsZwRW1bMkDd9x70KINaju9BPxzJsosxcEG+2o58OwLeB15gEcay03hBvOAnXNyrW/XdUwZBEGYs5KVU5blE+y8I0SKOB3tGn0FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8676002)(26005)(8936002)(38100700002)(38350700002)(6666004)(6506007)(186003)(83380400001)(44832011)(33656002)(66946007)(33716001)(6512007)(9686003)(5660300002)(6916009)(316002)(66556008)(66476007)(2906002)(54906003)(6486002)(508600001)(52116002)(4326008)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SnZctqTkXwIVf/kbg5VWtdwWVj32+EJiA8zlDW90rr0Mx5KyxtkgWgNniyGf?=
 =?us-ascii?Q?ptvfK0FDLDqU5+LZSC3kHfOdsw23lc9XP/x71/ozIH/I0IOAO3r3iNORmykg?=
 =?us-ascii?Q?Z35mdwHe7M8qVvDdrb1oXX+JeLKQK7QrfFzcq/BUm3TI/S7vkejYjh1K9eDM?=
 =?us-ascii?Q?0Ck8HHJwopiTjmzE+CRwU+m1EMdfzPV5LWcWS0dygSPj498YMC71ZDwOUnfK?=
 =?us-ascii?Q?UbzAqXceTw3FFVJZwZ4gDreLDCW8CO0a0YxVcSJldVqc6tUfKiHs2dkHDZld?=
 =?us-ascii?Q?8Bni37pLe6MQm2tShGfJDhSjUjxCvaEqX/XzCqQdI8FdJg8/HacluE1fakfh?=
 =?us-ascii?Q?pJNxHt2cY3AC26YJTZKcKtv6KYOA6CQ6JqpnGaUsKregXLQfxupbdX1i0WEv?=
 =?us-ascii?Q?V6hVBjuJBhdFgy16II8TVeHWzS8XuG8dqJzqXs8Y32CLDCQmiZOJIX1AURW+?=
 =?us-ascii?Q?WZEwTvWkjNh/WqwZOs3y32Yk8jNcOxtv4F6KCa0dMZhCKhODdfeilO44SIL/?=
 =?us-ascii?Q?vJHw3CZGGEhtb5a7+Ueli8VMuf1I8UVUPCKKHQyd7wULc2bQuJcCK4zpWh0M?=
 =?us-ascii?Q?YhmnhtK9oPdCZ8B9WOVeb42EdNa03j1BT2pOEIeJdk8zBYnlmSn/EPfxDFLr?=
 =?us-ascii?Q?zZlojviBMe6gBQytSgmvRla6Vpwhv0LxFuSNxnTQVMgQYfvIU/8Dg7+OrUbM?=
 =?us-ascii?Q?oybD7Hvcojw0LtwZC98a7cewZKqj7adxjQ5chfrBLEb6xPg/+Bgb1PpMXUrx?=
 =?us-ascii?Q?cOfkADeUvy6UxPs4gccPAzquCf9loU+T9JEkN1aucAYhqJsf0lhO/n+x3aqU?=
 =?us-ascii?Q?C29jW+vkyhfo5C39fL/N781Y/6/AzboZIBAowNi8xhFLT5WzB6GqT0+Ahv2X?=
 =?us-ascii?Q?TFku4cDF5tSV9wPxg6IFFJhEQ4QCUJ0kTW+cHoY2eCT2t7OLrolJA7JKuTib?=
 =?us-ascii?Q?MajrGpBfZ6kngJS02U4jA0jhNjrosd8kVH66XU7CWJGGn/Vt8pe9OozWioe4?=
 =?us-ascii?Q?+00qblYK9ZIOLy7emKMsAFmPxeinm2VsozETUiNUlVHXpYjaFVrDj9aEgH7A?=
 =?us-ascii?Q?2M+q2Eeh8iEJ5xyAd1rN/F44cbbFFKk7oWd/y1BpLZoUb/ANps6T2bhwHOc7?=
 =?us-ascii?Q?1EGRi2JuZbmjiEQ7xYuv/I694hOo5lga8TCwo6s3W6WLCRzS4ctN0Xbz0HXB?=
 =?us-ascii?Q?iF9NTEga3ks6uouNYCa+EqD5S4BIsRwfxjToDI2qo9ySgN/CV6Di28kVPMra?=
 =?us-ascii?Q?DsiNXDxIot3UKGZhI8KnM7e+5aBPP7rYAhK9wjYvOsZw+wrUA3evNz7Syq2o?=
 =?us-ascii?Q?FYN0T6UIdcaW6eJ99d4sCXcuJ8hZNPDrdt6HzddDd6FJwJCgz86D21di8gtW?=
 =?us-ascii?Q?kcbmvo3iEMnJtaFotr3UVm3YANRvPm5KvqDJlyaC2u5g0sSFS6wxmXlZ8oOi?=
 =?us-ascii?Q?69xUmzaVcH2D6TpU0WKiML2RLcbAbG4upkVnqi8p7LESGVUzjCsgUNgu1rAy?=
 =?us-ascii?Q?vn5l4mMRkIzthbv0hciDMKxcLyS1oKQYzpHaw/8rAN3BDlfeRHSxk7HX/rUe?=
 =?us-ascii?Q?2Wycmw/fs7HgHJPEoxhfQXNor1P8Dr+EgRlEGgwLETkSUhvzzwW063IvvJy/?=
 =?us-ascii?Q?FNlnXiAZQagOYJRpyA//YJ5H+MsldarEhDRCLqRfyghrfBsa7nI+vBnEcD4O?=
 =?us-ascii?Q?mlhxpsUkZYcTLC9r9MjhZXn5Yyg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf96b445-9af7-4b11-7eb6-08d9d52868f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:32:58.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6V3XG6YiDWFjfU2YhAEN51O12ltrquHW13R4JiNl6kB1gTJBxxF1ptxM2eA3PhRS25pJq2M3by/AQXZkYeiws4+ELOCSGkJw+Tk6KwssHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110095
X-Proofpoint-GUID: B5dOGetowKCLKibcBmkm0pHe_g9njhUS
X-Proofpoint-ORIG-GUID: B5dOGetowKCLKibcBmkm0pHe_g9njhUS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 8 callers for devm_counter_alloc() and they all check for NULL
instead of error pointers.  I think NULL is the better thing to return
for allocation functions so update counter_alloc() and devm_counter_alloc()
to return NULL instead of error pointers.

Fixes: c18e2760308e ("counter: Provide alternative counter registration functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: make additional style changes

 drivers/counter/counter-core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 7e0957eea094..869894b74741 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -90,10 +90,8 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 	int err;
 
 	ch = kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
-	if (!ch) {
-		err = -ENOMEM;
-		goto err_alloc_ch;
-	}
+	if (!ch)
+		return NULL;
 
 	counter = &ch->counter;
 	dev = &counter->dev;
@@ -123,9 +121,8 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 err_ida_alloc:
 
 	kfree(ch);
-err_alloc_ch:
 
-	return ERR_PTR(err);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(counter_alloc);
 
@@ -208,12 +205,12 @@ struct counter_device *devm_counter_alloc(struct device *dev, size_t sizeof_priv
 	int err;
 
 	counter = counter_alloc(sizeof_priv);
-	if (IS_ERR(counter))
-		return counter;
+	if (!counter)
+		return NULL;
 
 	err = devm_add_action_or_reset(dev, devm_counter_put, counter);
 	if (err < 0)
-		return ERR_PTR(err);
+		return NULL;
 
 	return counter;
 }
-- 
2.20.1

