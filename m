Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF446300B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhK3Jv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:51:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61726 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235693AbhK3Jv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:51:57 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU9jGiZ025317;
        Tue, 30 Nov 2021 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=VNx7esab5lm+04k++NkK4xPqDLP6FwQwFSLIzqTFxXc=;
 b=d4/KaXKYHjTgaJ7o7kdEKcva5HyZjJ3xnIW4dOTTbUh+SGMZTaGF1HeTBXHv+o+mmL86
 QbY69QmEHcqC7Tf2BUZCKc4ahW4vg83iIa1M4FQfhvEov7uZPlxKMN8I3nYtBMWgrh26
 aAbRLWis8zDGdmQLEf3lDQhpgQZDx2bGokOC6xvzA7GsmR5I5/sUdoKhOdavWHThcjmj
 Stqjp5+LyBoV4AIZmVHRoVBUPOnKIqWYOt8efM/3PHFXN2UqQaIAdI29chNwhw1N9R78
 4+e4vf/8x6l+ZI95P6Gx9n4WGe65DVykq/XYZ1XtLHer7KkbUjVZhSzLrSD+gaBONMEU ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmueefvmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 09:48:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU9fksN011209;
        Tue, 30 Nov 2021 09:47:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3030.oracle.com with ESMTP id 3ck9sy6srd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 09:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgShwM1T44PweJPxiDU1pqOTXxV9fvXB89ft5UlyEr7cW4hUiYUYYVX+iYH4FhW2oyCNOOFBJntiO/BrIhOkXiYVAg8pZieP0UWVhhLE59zqYEV+Klm5sWFf9+7lrOEA44hnFF5E85FipCSs7JrHnf9SffFjkFGeFc/snjQ09McY/c/15UjknCDiW4OuijXEmCi+kVDh1ShhSW7FcHCy2PaznQ1io2yAT9yNMBCn5rueYufslmm5bJyZI0mYWPUQ8D165ZmzkRxegkAY0aCM6X6ntS3MH3lJimPuRaiT50pYj7yPoPhc9uwXt73+m0JtjfYaU6krjiyf+T26YnsRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNx7esab5lm+04k++NkK4xPqDLP6FwQwFSLIzqTFxXc=;
 b=PFSwqpfLncuhZU2zJJVcRuUOu0Eptr/hjnonHbC3q4DfFakDepmGA+zSXKkd6zB0YJTkUOtnQTrE+zjVtJkUImAL4zbcOwVom3YDixDxOh7QS2V/1bAiQ/W2VNBA1pz9NeggT7xe1wq4zGPO73vLmPndZ6j2sp4glnI96MWECmecuaCOWiAPQwrgmtJXde+cM40ke3FIVAzdXwKzxD2a63eHp5764hDPkf4rliCsgDC8GLrAAMaSQL5UKjt/K3DB/I0nNCns8TU9t6okrSpW5pfTvwIsvoS1Gbe37O25IlERi45owgmcv1fVviTx1DnevX2/hM7RBteXw509aJimmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNx7esab5lm+04k++NkK4xPqDLP6FwQwFSLIzqTFxXc=;
 b=f2SX0NuXEB26sxtIb/r+YWTp2CXAfSI+2GDh29BS1pzEvUP8NNxEwm3rvpqXUIylt3vkK0Xtuazy1bYog0U1u/45LE+o9tGvAU30pDQILweE6MRa9UCqMhHCI+NGsvaVSw03UIkWXleWQdP5secH6y64b7Set4FHfHTgLs9sdqo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2127.namprd10.prod.outlook.com
 (2603:10b6:301:33::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:47:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:47:49 +0000
Date:   Tue, 30 Nov 2021 12:47:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: use ARRAY_SIZE() macro and fix
 camelcase issues
Message-ID: <20211130094727.GT6514@kadam>
References: <20211129221346.365883-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129221346.365883-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 09:47:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67cd0ddf-1b52-4019-3b59-08d9b3e67843
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2127:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2127AD69971936F1F02CA8C98E679@MWHPR1001MB2127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkK8YcfhOcVSB1jbEKSKcWq9+Dr2BUFpUtv04nJjC04f96SJb0wV9LJ3KciHUdw+ZxCm7nPFsuyCaUTL2ZwY6h6I/aVrKGNWRgGP3gpH9dwu0BkO56q3X3RVjp6KrFrcFlYxmzVMiFWz11GP2qWB7L+TKio0lH7J3Labe5aYb4cuZ4+g9H7AjH/+a3Ev6ywP/3+6JBrNoCkVi0u/rPQpvedwtkRC6lM57O03PivNfprgklpqV4WUZht569Y3uUmBbm0WQoNq5cUYel6g1P1OYbBN3s43GY3JVPGsZd/CEqCu1FLqsgW1hNk3/TTnd1y5JguOr4zaSLpP+K517u0h45RoowIcCzVwIUj9EvrBbUCIDgxNGteskJKnpz71GylvdCVCVRd1pfcE5SWBrKhOZo/paCCCnD5udnUuac2Z9lCb8nRWOArZp+BBOqr1OxVMLVmmIQZn2bBBE396HspurdmQFUYqXkhr+2j92NizOmh5y5GgD3hNnbeZemlRduOH8udvxCXcEJwPSUjf1cAWqDHiwV5IVvFm2WOMtXwjSOndyAVYf0hDjp1oTV/ccfiIeZWRUFoSayt6I3f5IgklxVN262nKsCinTdIgXpNQ5N5fKPk6MKps7tr8p/56eo5IoFNqPlP5t+KRNqmeHh/9pwiMPdvqVXtNyjaaJIdOYP1x3fSlmCDcdj94KzBmjFIVyTodUb95f1kQZQbxIR9y8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66946007)(66476007)(186003)(86362001)(508600001)(44832011)(9576002)(316002)(83380400001)(33656002)(38100700002)(19627235002)(38350700002)(26005)(9686003)(6496006)(1076003)(52116002)(6666004)(2906002)(5660300002)(8936002)(4326008)(55016003)(956004)(6916009)(33716001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FArSddYD3bDuPV5ApKOEfUU2NBE6xffdPpGYGPOZSvqiWwzj45jxkEjNvM4n?=
 =?us-ascii?Q?w4HyXpzpDYCXilMoEenP0sQzJHESQN2qrwSqiUIakXk+or4T8sokM8AGtn8i?=
 =?us-ascii?Q?SBvQ9j8SvYGujOehCzVtA7REadv5jDYT3BEZFl/kjdYp0eMRoy8bC7jXLdob?=
 =?us-ascii?Q?xgObYYgIU9p7r4an0kieYRhxKRxOpPl8WzXZeoOPfclnGhJLmHgsDlHPjwBZ?=
 =?us-ascii?Q?wK32jGKC5zTOB5+xp0dyzPT7MXw9dwyj6iBqrSv3vlt1xhoBHxnbisvEiJQM?=
 =?us-ascii?Q?m/7MdzCqv4x85kIcTL08kw/YbiZJUW6qwGKtDX/1Ls5wi/PGEtCm84qhazfj?=
 =?us-ascii?Q?xnlKk5HNG8z5nMXf4cs41yYRgc1dan9IWyzqcgsN73HJVtf7C2ASUrUm+CyY?=
 =?us-ascii?Q?VCbkdkvvN829DS8bs9sJ7F5VwUwi/R4D7HteThFRJFJkcus+eXIIhKqHGg7T?=
 =?us-ascii?Q?MHprqdnGTqUG6w6FiQf1y0hUY2uOXFc/KG7YEIYqEsIFL+SnN+eXBf/4jjY1?=
 =?us-ascii?Q?7cuCC9frxWgzPtNDMJtGEuY83aXgf3gWBC11qv4w/n1REOObmwz5c7aA/Mx7?=
 =?us-ascii?Q?sjJCuIu/CqbWFAwMOzpS9Zu8inZvZqoONedHnut9kECo9tE4naGUQ3VCuLSM?=
 =?us-ascii?Q?vLF11uJTif0VBDi+pANuy5J2XKJNHv+BIaIYtvyou/6HoqM0MuxSaCfvVQwW?=
 =?us-ascii?Q?d+07Je8bYjXzTn0iYWMln+Uzx1AHmiIhVPGMSIh9x6PXCLhvT3TNYbcGdAMB?=
 =?us-ascii?Q?dhc7/DtD/vfjXYXsUfyZ+13ghfUwClGU1SlB3VpDRc5ZG27jMJ/KzGNidY2s?=
 =?us-ascii?Q?fpMbcWo9Uxf9rAleE7yiovVVdNBXZKXlIbcncxpUEN8PxLILxYykS6EdoUdl?=
 =?us-ascii?Q?GSYbadZM60XsfkoD/VBnUJNpnU6QPyQBAuNAZcZBvu+c5uq00HOhEdIrV01L?=
 =?us-ascii?Q?pTCtlqxg15aVcth2loVwQbQT9moFmXe7Dqtp5r3Tc6iBfIq83+ecWqIZJ1ra?=
 =?us-ascii?Q?IFaUZhZUR+slA1l79b23975pKEfQGwDChfHZszFL+ord1iFiCWQnNlc7oK+I?=
 =?us-ascii?Q?NyTvVGNh+BzpYPCb25wG07Z/iHnLYDkHm3qZPuALiMnUN/59dB9Z+M5pThqk?=
 =?us-ascii?Q?x5sepXAu3cVZC8bd7V/+deuQPw7WflYZH2UuHrhLYxSSl7iDT45v3PpMPEdm?=
 =?us-ascii?Q?aM3FiySEnEgErku5ztGOXoJqr5Aa+T8HgMXwZ0RZGQN+dpm5gHxug3ci+Cd1?=
 =?us-ascii?Q?UaC2iE2gG81PQbuciWie1Os50HftbVW4PKWaivYGajO95yZj963EmLI9qB8v?=
 =?us-ascii?Q?R2xyFObVDTtNTeJD5Xt921BeCWgR9HVAZKYLhSGzxFyK+f3CkDjDU3PrztiX?=
 =?us-ascii?Q?VjDvaewxWhodp9j0pQTBkMsd1qivK0YvjulPhPF59EAvZsDMowrb3DAuUedi?=
 =?us-ascii?Q?oj3zTNesVnsXYrGMiGfFU+0oxbMXup01nPckdkztLVZkSx00AFM3kz8mQgqK?=
 =?us-ascii?Q?RKZb+5EmA/4eFPSMzpZLEITWgQUE8Ywzpcx3GuBf1Mmyigq88KlpfXgYM/PB?=
 =?us-ascii?Q?AyalPhTIE1ZG2RU/ylTK+YGnQCXnkAcyLaqjG+osLMoiMXOtOjVuhhKOJzeO?=
 =?us-ascii?Q?OpMo0b4NJvANou+f3KYFn+haV6dpD5+Vj5qj7BlJAccootjB+HQHKapq76E6?=
 =?us-ascii?Q?OUfe+HOG8O1SthXDkeUnOfEslgI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cd0ddf-1b52-4019-3b59-08d9b3e67843
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:47:49.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8//lhFM00F5APS1JaC2jyyWVjrfSfg3KNabxPufhfrqSoo1RbY957IlrPZuiH3fq4Xsr799PbEoN9loEPrvKZwMcyUBYD1TdhdhxvWiqBEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2127
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300055
X-Proofpoint-ORIG-GUID: uAcPoyL5BxahClxrq7HrNIqI89yzjm8-
X-Proofpoint-GUID: uAcPoyL5BxahClxrq7HrNIqI89yzjm8-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 03:43:47AM +0530, Vihas Mak wrote:
> Fix camelcase warnings from checkpatch.pl and use ARRAY_SIZE()
> to make the code cleaner and avoid following cocci warnings:
> 
> 	drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c:142:51-52: WARNING: Use ARRAY_SIZE
> 	drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:174:52-53: WARNING: Use ARRAY_SIZE
> 	drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:450:52-53: WARNING: Use ARRAY_SIZE
> 	drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:655:49-50: WARNING: Use ARRAY_SIZE
> 	drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c:136:50-51: WARNING: Use ARRAY_SIZE
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>
> ---
>  .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  6 ++---
>  .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  2 +-
>  .../staging/r8188eu/hal/HalHWImg8188E_RF.c    | 24 +++++++++----------
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> index f6e4243e0..ce46b3651 100644
> --- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> +++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> @@ -171,7 +171,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
>  {
>  	u32     hex         = 0;
>  	u32     i           = 0;
> -	u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
> +	u32     arraylen    = ARRAY_SIZE(array_agc_tab_1t_8188e);
>  	u32    *array       = array_agc_tab_1t_8188e;

Get rid of both the "arraylen" and "array" variables.  They only obscure
what the code is doing.  You may need to do additional clean up to make
it work without making the lines too long...

Same for the rest.

If that is too complicated then it's fine too, just leave it as-is for
now.  I know that sometimes people just want to silence the checkpatch
warnings but I prefer to keep the warning as a marker for bad code so
let's leave it until someone can fix this in the correct way.

regards,
dan carpenter

