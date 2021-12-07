Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0535546BAEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhLGMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:21:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10604 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhLGMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:21:54 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79KL2B007515;
        Tue, 7 Dec 2021 12:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=fNKV4zFq0mDzNiuvIlPNSvIHS0Ygz3t6Qz84TP6kGiM=;
 b=lbyQQwuZy/hSLfw6oFOhzV38txp9tD5q0HbIG3i9m5bDMFn5ZQLR0hDR6cSdYMJswry3
 xEPYbEEZhcXUbcIYEao7yRUySNlSrHDs5N8uwGXkk0KX2hLdcFgCg9WmXSHLiORvgWyx
 m2NdKnJZ/KyfI4IGN8gOv6xxNj5BzTDJl3kl5mYMgVgLbhCKxTU40DLDfsy3R71XgSGf
 W6FtwES+nsgeLMBywDscDBeC9fpa5PkGFLgVRHxH5B4+J26l8RLPITYqAbKyOZf89dOz
 ux//7XtcRcn4ZsqRE6DWPRNsSgMsQCxjwQihfqz27Gf6FNxBQJbU9+T3oylKhfUVktnf dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2ycyxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 12:18:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7CG63Z078830;
        Tue, 7 Dec 2021 12:18:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by aserp3020.oracle.com with ESMTP id 3cr054trcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 12:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzi3+iQJucCf1FdMwwAs3YgJKSc0T7EsY8nbEjRZqoxQLa3lkh+sSABBCDrq36t6Xvkh3eN3P2N1Wk+gUo8ZyVsRXHNXuSV7naGvw0vNeFhmqcqj6wis492MPMyWaQMvb+TKz9YA81+vyAFMSV7S8ModRl47GCYiQTxnBtD50XurOvjzfs3/suSf0BVkStFBwhl0CsmgupQzXu/IIVytG/bbz9q5GgRtNd3nH5FxmclDQwpdFAhvFS941Tjob/pKWUQ09EpBlN0+Q0VsLn4rzeX3FUn/GcPR3snj9+LgyRST3L4ANI+PxMQc44+PRCk2CAQ7taocAulYhFGS1UPWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNKV4zFq0mDzNiuvIlPNSvIHS0Ygz3t6Qz84TP6kGiM=;
 b=MQA/R0S/qMaGaSCK5Qg9EHdlbKo5y+6biQlXEm9eL5NXo7F6qjgCSmy+Xll0ODyglkGsgm+6HJvxx8iec20GTCOm6sTGdagyp37KnHJhML39GTIiN8rOeMnaUPzVNkf2G7GZ5szpwSr3zCLSkIEdqxXrndjbp+ZPEUyPbFvIUXMgt0tHCpxxQ2Ps5dfLh3CIhxngy0yiSsipYjv91I9eQCzH33UESYUdeuhWP/JXHpZxoroZXbuUVK36EeQIu1lNzIVXdG2gPSd5mfUOYYrNv3VO6LQMF/4eN3aKN3ywRHDZEYcHZMY5cPaH4SNvtYfYpsHN+KW3NPBgML0kQRkl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNKV4zFq0mDzNiuvIlPNSvIHS0Ygz3t6Qz84TP6kGiM=;
 b=hW0Gb0AF9p3sYQMltnd3t1KM21P19PNPJXIS5LKLBudpfyx5WqO9QE9WxksVXgf3lkE+d8FEEKjyg3acWBHhL3jMtzmtHgGCUwS0Ke1AzjjoJHTH6mtHmi9DjPPIuHbVJW0ZinfPm1Wt1Oe9iFc/i4WXUOwfLm0YnDG5uoV4S7k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1903.namprd10.prod.outlook.com
 (2603:10b6:300:10b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 12:18:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.023; Tue, 7 Dec 2021
 12:18:19 +0000
Date:   Tue, 7 Dec 2021 15:18:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] intel_th: remove redundant re-assignment of pointer
 hubdrv
Message-ID: <20211207121801.GD1956@kadam>
References: <20211204233934.80070-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204233934.80070-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Tue, 7 Dec 2021 12:18:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d88ca24-f8c5-4c08-f2e9-08d9b97ba776
X-MS-TrafficTypeDiagnostic: MWHPR10MB1903:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB19030054EFE10DBD2BCF040D8E6E9@MWHPR10MB1903.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3gWPN/7ElvCqQskqwQZdGI6hUcSFCGvv7/4jfDP5cK3DrPCTJO9gfOeib0pMRVhZ5t7U07stSJ1XFaOBBczC1/qi4RoqzlSfUttBpdpyDHvS372pAGIsteAVNjv9L9wxfc8X34Elc4ckMaYV3zkDoJpPgPCSxD2atFoZC8SVXHmDZVdyzdq0YVYelhReNO84GW9cOBvH8f8t5VqA6bWfd0i4EYnAfRYtmg3h7Ml8+B5MHEEQyN+3RXPqOQF8EAuGmYqwBoa64vIGH8hQcOFcUJGVc15beOhkkQNrrvO5GNqNPXPWMlqOOvp8t4A3QCm/qgvpcD4OaUp7qYLYaXvr3XaCZlVlLXndQSP/j8JuvvNS0wCVffkXNRJF+bkRbluispUD34wmbrSHGKFsCdd3bo0kXnChr0qxQnYn0mOovmOoEyJI4Y/UTwGAzhQ6N2NadxVCOK4598zsqqkM0fiibZ/1eZPQTf1TouNsvrqmbYodiClzFBrdQWjUi1mZjBySbOErorp4PoLqnG/qRACSGvER9qIVTDGpP4ZA5wUZJSradPun2QEZ8Dbk78hHdEKk4gxEIV0GgpMitBg11BXRcCo5T9wnrcQGaYc6YtJcf4mu3ZP+DF8XYqzrTjPPHnZEgCEMHKNcWyjYTjI60fOAp+10Iqs5nFdMjnSQCDca8BCIablbOCmZNbTjAuJ97coJRFYboXoRAQ2WjmxeOwlAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(38100700002)(55016003)(38350700002)(33656002)(66946007)(66476007)(66556008)(4326008)(8936002)(8676002)(508600001)(2906002)(33716001)(6916009)(316002)(9576002)(86362001)(9686003)(52116002)(6666004)(1076003)(6496006)(956004)(186003)(5660300002)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pGVTJ4D/x8r+brGVNseUJ+JLWwCD/u1ngvyFGobd1eOKS1bD2lKDpTILKBBI?=
 =?us-ascii?Q?kFvrdgeM+eRQPd1AUtAmiuC9u55vgz0O9Wql3h/Wu8OtckOgPKDhZHgU3w7g?=
 =?us-ascii?Q?HJa1GxoLgg5K4GDcuKO84C8E2L4luF+FVpXkVLkN4T83wTtWkIe4h+MsPkip?=
 =?us-ascii?Q?I/j4WSB9Ro7x8E/4HSti/jA6+X/kJDi+eXCCvBrj0YT99cdA8KG864JnD31p?=
 =?us-ascii?Q?cVhsPBYay6jIe67jBG70e5RnwAaKD8Q2iRnL2X70pXToAgtPoSmKN+XLgKqV?=
 =?us-ascii?Q?3E8PGH9LLlErdwYxm0rri1JSf6KU1Pk/JdmMceBH9YzMDdpvM09vmf0e12iL?=
 =?us-ascii?Q?cfuGc4gJnnbL7v6uDk+P6EcBueyNBXSEEUUbWXboZrILI/sLYSqw9IOXd4Z/?=
 =?us-ascii?Q?n74FoMgAfv/iPgYND79XoSHKBxF/4R+776VxXewpMZo8chkieSQWE/A4vRd8?=
 =?us-ascii?Q?/mzAEtMmL8HKlKcWSAGvMdfp7ngf4KV0m6pCG5Bkzuh701m9iKD8mvBNz+JW?=
 =?us-ascii?Q?lEoas6bj9m+DxoGAACdxOVuItVGFtDBLDAqHyiyL8welsgv2lNwl8AdtUvWd?=
 =?us-ascii?Q?8PXxy5wEC6QrGOBrJPjJq+ldeYURMWuSDVTouGlNVVwzrBEM7CwLmNk3DLkQ?=
 =?us-ascii?Q?Byk4BSz3OOX1pkUqRfxbbKrsU+2XuzeKMWObnE9kv0zk86DiXOYjZNxDRh70?=
 =?us-ascii?Q?kuec3+bNp7kBn4IKd/lZvoU57xkZfXbToodqjEEijXdcNNvAy+FvqvEQ6U/I?=
 =?us-ascii?Q?FWa51o7UjXp3qvbkxx56U/M5ctF6zjl99tfmNk35d6SCu6Dfhr4nkN892C+A?=
 =?us-ascii?Q?qElVBF4BDFU1dwVV9IztiQMUWCjNBlrCCcYi9LrKE0Rr2h8HDsg1U+ACC2nF?=
 =?us-ascii?Q?HFoDAg2nyEhb0qzn0q/PZc8OWwNzsI0Oryv90prIPOpBZFpJAOlUyNSBjbHa?=
 =?us-ascii?Q?ggp/b+7Rdmg9YRQGV7tI/KLs3PCKQngFo7uFfIRKlpIduBokFiQV+pzbpf5+?=
 =?us-ascii?Q?o0UW0Y3uUQz8lQ7FgCZScogz23+W9uZnvyUVuy7XvkOmiVM+MjOeP1a/C2jz?=
 =?us-ascii?Q?BerB+s6OjuakmbvDtmZwU32QNkZ8nNGqnVmFs+uIRl7/bS+emC4/4fU1XOMz?=
 =?us-ascii?Q?ixIE4beqMB02R23b0dfiwdntgft/YXlcHM8ADtFJgt/ROikttk5sHiE6dkfJ?=
 =?us-ascii?Q?gM/a4QiygykoN6RhjdNt0Bx2Z5yDUwGl16vZQrR29o1LLUc/SGMA3ULkFkEf?=
 =?us-ascii?Q?EOXHTIMWSLUg+o7LIke5wi5XA52UsONYun/d3cShQG+4CYTH4eUt6F6uqNwi?=
 =?us-ascii?Q?g2Bq+7b66cU87zBf2hItSoye+SVEK/a8PGieDuS4SbLsdSA+rVBycEuT0lGb?=
 =?us-ascii?Q?8/5M+X6oXATA2Vf9okbUPlMeBsO5VJ/9G2YO1lnoYvA+MTWYL+2oLkqyxIjN?=
 =?us-ascii?Q?9wn+6PV10ZkYlsJsvP0fMqJ+VsWoihh3QycVk3oCuIfCnBCaQdgZZoEbSlKA?=
 =?us-ascii?Q?YDunoXlK2R4u6mkKsodoyW55eW5frjiqU0exQuy8N7R35vgwJWmO7cCeZWMd?=
 =?us-ascii?Q?MYEOtteUiAHgPEwR4lQja3yQ1J9cKvX/oK182hy3NC0KMZXumgDlMnhVJ92H?=
 =?us-ascii?Q?4SfaJ2GfTloReQZlscep1R5qxY9mWaeV4Fw2q03qWdEBT3rm+1b49mZ6cBGU?=
 =?us-ascii?Q?aRw2Mw2wW8o+D3MQ5/mMlgJkK1g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d88ca24-f8c5-4c08-f2e9-08d9b97ba776
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 12:18:19.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKHa1vvj++wZBSCu0x9rMCD9+6NYUOMU77GrmuQDepjPY1H64mqnpg+tUkPMXcyGqLkbtsgU6UqznS5j+1u4YpQKl3dG3AIhHihJNmkcmoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1903
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070072
X-Proofpoint-GUID: b2kbYZX1NpNCG0un6c1brJ9ipAEAEwV7
X-Proofpoint-ORIG-GUID: b2kbYZX1NpNCG0un6c1brJ9ipAEAEwV7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 11:39:34PM +0000, Colin Ian King wrote:
> The pointer hubdrv is being re-assigned the same value as it was 
> initialized with only a few lines earlier. The re-assignment is
> redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/hwtracing/intel_th/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
> index 7e753a75d23b..5de47b89a9e1 100644
> --- a/drivers/hwtracing/intel_th/core.c
> +++ b/drivers/hwtracing/intel_th/core.c
> @@ -1048,7 +1048,6 @@ int intel_th_set_output(struct intel_th_device *thdev,
>  	 * hub is instantiated together with the source device that
>  	 * calls here, so guaranteed to be present.
>  	 */
> -	hubdrv = to_intel_th_driver(hub->dev.driver);
>  	if (!hubdrv || !try_module_get(hubdrv->driver.owner))
            ^^^^^^^
This NULL check doesn't make sense.  "hubdrv" is "hub - some_offset"
where "some_offset" is zero.  We've already dereferenced "hub" so
"hubdrv" can't be NULL.

regards,
dan carpenter

