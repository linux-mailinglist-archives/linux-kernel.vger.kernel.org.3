Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6881646BB94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhLGMsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:48:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15662 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236579AbhLGMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:48:49 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79KL8E007515;
        Tue, 7 Dec 2021 12:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8/NomOkL7blLC2pw2wbCALPNOUC+8UdMGza9EAjooyI=;
 b=iAILs7QCP31zs+YvO318wuD7+4rznZrsbO8b52YTm/AcCDc187XUa/0IvSepyv+PZa4s
 4DKiuTbQwktUcDd6TiLiZm+R4Hrzq/g33Tl26QbDhTkudzhPW4bef91SmM32g9mwqUxC
 e7UeJm/P01/G3O8Ar+6NakM9KHPbfCCtynb/Y4i5NgBe3dTW0lZ5O8gkwyHcKMaiiYrl
 StpQkY/AtN5zjhJqhEqJdDpa4Dg9jPFWI8m8jkFUa9Ru6J2av5Ep7DKqhyoAZqh4BbF8
 XmTIY/ny6gGYI5VSEEzR9hqxawzWzKiP53xdMt2CGL+edCKgIBkzXi+L43Fimo4MM0Li 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2yd1gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 12:45:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Ce6ad153460;
        Tue, 7 Dec 2021 12:45:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3cr054ufqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 12:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIX9WeCok96t29ImltnEDZBSPQzslS/ac2KakuNM3Ekbbtg9AQTnLOs8bP4xgi9S9NDBkAXA67SnsLx0JW+9LFyaycDN2sydSdDTrfzGp+7Dv2K4fIkcbpTj7kNX6KmFWaMXt+sIpmPznmefOYeV2gurQEzwXggvtB0NtjPVqlNP0ZbMctW5zxe9ddb8jXtybTUnm3BdSPSKaB0nLWkf6GcTJznsKc8/R0A7Dh6pJIG3x+eug3SXJ081jLgtRJxPz5q94xrMObUNT/XLPhI0RrQ2GhQTXE4LAbPK84KquVhkGw9q1JzORY9yKuFfCMldXe7SAMu/nNs6tlT0RuGEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/NomOkL7blLC2pw2wbCALPNOUC+8UdMGza9EAjooyI=;
 b=Rjz2vM7x9x/D/9ItB13qckfBgfSyTLA6n0n92WCk2eu2KKXHBsO/WOWQHt3rgkWAeZzcuqYt1eMWz8DJzoVNosCrPdDnd+SWVwBUrc8Dhv4tA1HoaHx5MBN9biwSkxZqqKpIKM48Dwsk44orFPK0cenq+P0GhijbMC8DU9x9x/ReH53E4RQc65y6BvcZxZA7FV9wILJmQlGF4BVVKUpyElC/fgJ7q0BdQTeIzu0cHAT5VG5urbeOCtNm1eEK284DnGlm70ybxQ39DBJ4GZE/2Ah+hi4118aGcLruzmBoieYz4rgfrGxbvxORDw8kSn66QA8Nz7X7piQKszPLIUZg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/NomOkL7blLC2pw2wbCALPNOUC+8UdMGza9EAjooyI=;
 b=TYcr+xjWJbT0cOcV55T5wY1O2atH6CsbB1Rodx/aireael1ekXc7MYb2eW5ryyzaPp+Dn6MhWMaCVUlK1cg7IzZMyd5VUBjPA62l3Y+q7FGTztbbSqAMhsBQTypi14p5G/JJk+7GikaEEfZ3CjWHjzyr3PuQ2HhtQCTQIj0jBBI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2094.namprd10.prod.outlook.com
 (2603:10b6:301:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 12:45:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.023; Tue, 7 Dec 2021
 12:45:03 +0000
Date:   Tue, 7 Dec 2021 15:44:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: c8sectpfe: remove redundant assignment to pointer
 tsin
Message-ID: <20211207124432.GE1956@kadam>
References: <20211205003745.227491-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205003745.227491-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 12:44:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6afa7e-f49a-4e41-9cb6-08d9b97f6344
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2094:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB209450248B47BF2905E3CB0C8E6E9@MWHPR1001MB2094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjMPWuYMpkxY96jj9vICodfj0Cr5qFt8taLILZXtyRKI/TXxlyBNOd/vAOu7B8GWMK1I6RLLPgWHBTvFYcYh8KxkfUgvZt7T0kri4iePSNw/xBs0fjsFNh4zuc5SWYfRLgeiU4vS/ThmYuOUhByvKaaAw9JjqooLvYDRI+oUU8uvBZIOkvLuZSDG0NjtnQd1gRyWvlw20kmXJylgEJoX3rioOJWkMZyt/4Z+5f9649DBoBTF0HrBRLr44sPfmWDtOKjESfpH/7i8rES18ZJaYibDBSx6pFizJtmOsTIYOWGjqCHSYRc9kqZ5H2dcR6cVNSfs3aqOnYaanGi7mDUV1LMD3CA89pSpftlt6DNNz26mKImv6GV/vTDpuxGV+dolmBGJZKTIlQbKFSdSK2IHSL3koHxbq35QvpwRwmDAHHyaat/BjePokM5rUJnhcvUOPPMRd8/jrSirV41+iUyizxO30hWDz07lNJTqtwL+Z0l+DeNg1bhqyNYyA7v08iUvdFaoRsyyXiFzvHwsXtfPp6aCevObz6syF5XmgTpK7fijTwlBHshAPrOyVhqIweHV/KLh7yg7e9/4eelYmfYJWHYWrfj7ntws22YwIcD2RPVf0bp8ICt+U3flxzi7jyDSRqBS37vvXULtVZL9d52G36G5ClV4duzF/FrQ7oHnZdJdCWuemdWWm/YzmdhO68qBR3GR1H9RNUGBplm//4kWqP22/VieZQq6XwTbk+56T1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(38100700002)(54906003)(4326008)(86362001)(9686003)(508600001)(6916009)(5660300002)(6666004)(2906002)(9576002)(8676002)(8936002)(55016003)(33716001)(33656002)(956004)(186003)(44832011)(1076003)(66946007)(83380400001)(66476007)(66556008)(6496006)(316002)(52116002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dZuSJ6tzqcFbSOkVXZySOw82hhh33tT1yqJhrgvCmbNABefQa9+3cluJzz9G?=
 =?us-ascii?Q?XXaMLcLvYZxZ2C67OZu8OCW0JUY7wY3nIvu6Jzd/fnzKLjyFZBWC3B2yMbte?=
 =?us-ascii?Q?2EaXF3nUJyXJX1tAPKCyE0YntZqb8EOXXfZc5PA5kN7lqXpXgwo+5BzRtX22?=
 =?us-ascii?Q?sTT62BJ77g0dQI2Hr0wUXpLHcGjr5PrLvvst1MTFvFvX5UXXEnXsYGziEWhZ?=
 =?us-ascii?Q?UhL3VLftwvJrzOWswshHUpHaY62NLGxNhOT7OmR3uSyFMCmdfKTA2vtvOUco?=
 =?us-ascii?Q?5E8XVnwZzO50BKjtZesCZthwP6IVXOs5hKDW4GjaavkMLTRCrX3s+7KO+Tyl?=
 =?us-ascii?Q?3j62m4nVD7+5heFsY8WFSo03z89lGgcPzZD45aRIAA4rYXfIq9V3OG2+0ZCy?=
 =?us-ascii?Q?ur09n5RELsdQot3MOP4Jisxs0KkBmKGmgBId1R58JdbXUgU7Xsn1QEt7mILQ?=
 =?us-ascii?Q?XbX1Bio1kqdg0FrC2eCgBIu5qgNFHRhzgbFZXLRjrUeptRqY7QRqao+LMgIV?=
 =?us-ascii?Q?nfRVZ4+6+/uoRsHO7Uh5CvhDQHrN7+SW9f5LPr+/HC08HFjmv8sISGhPTyqo?=
 =?us-ascii?Q?aEVFerHwCI1OEyPBuKZvKH1kX5YtVssZUL2TfhSv2uODEnoMJEQFB6DQOCut?=
 =?us-ascii?Q?KcK0GmImLTimv4Qle7eaqhM3rDqY6I+wQlsaBEXK30oD8ljdXOOJOFsptn9/?=
 =?us-ascii?Q?hFGBIdsXCwnZlvqgsz5sseT+yhxRIWJwPuAfIERZDCubIMK1tzb9COLepylI?=
 =?us-ascii?Q?hMrfy/EfW3pJ6gW3r+aTgvmlnM3zzKLhtmxNq2dErtCj5zxuTUH+6zrVilUa?=
 =?us-ascii?Q?SBobC8+x3WIQhR8rkmOZDww0X7jR5joUwoChB/uot1xJRAKZ4cxt0yGQwjPW?=
 =?us-ascii?Q?iiY+oy24PsPX/YaSqP4MZsdd58o4LfC5lTBoSZM3OXKqoybw3DCsMtBZ4AQw?=
 =?us-ascii?Q?ZTz8C0qPrJhgK9WhqC/jcQsxyJH60tgioDUBgsOtNszmVyqqXq7ulsQuZoDq?=
 =?us-ascii?Q?8OvyiEBK4vKp2B+GRuzA3LldudU/eLJp9pm3j1PFXkxkvPjdTa89sui4YQCm?=
 =?us-ascii?Q?TCCenIuysmn39gQ75c6Bb2gbDtzxAjzU96aY3UPeTtO6/cIdMh8B3F22i1IO?=
 =?us-ascii?Q?zdMJmSKlLs4waicshmWrGv/QczhUqPqxDMvyXmWLuU2+84+RugG7Rtuxa5XW?=
 =?us-ascii?Q?MLG6zCW8cX+YcfPx4xMFIjYT4XcJqGwRUWqzSlVBMCzFIJbtH74xPZFHvAzG?=
 =?us-ascii?Q?qLNo3SFM8fkScU8ex980G8R/vcg1ViRLehugIjyDI9yGMs9rDJwztI0DdcLl?=
 =?us-ascii?Q?d2k3eIK6ML3+pPcqM/oZ/YRAI9B8iFQA5UYOIXmQeGkLeNkHhsO7AiN1r9i7?=
 =?us-ascii?Q?DzB2SbhEcO76Scv9glWx0JHxu5/H8FUmXulWUySrudLvpDP1/GmE57kGUC8w?=
 =?us-ascii?Q?W8OU0jKZktgcqKvU9DeBNxUlWEMn/WEXY8NHZd0Y4t8VAJXCnl0OHwh0lYU3?=
 =?us-ascii?Q?NzeudPvSy3ZjB80fWdUl5xbBhJabvulBSvXxkzv5isruvRbzypw3f3876cMm?=
 =?us-ascii?Q?XumxBSRAxF3twibxM3kQd91mL8Va4Gbfzt74x6nENGjitrKzQd8Km56JQHzt?=
 =?us-ascii?Q?qvCBYkKasa12G1xoDRFGHfQBpGb3dcaIpN98zi4EwRP6MbrOKmKrETSyaTm+?=
 =?us-ascii?Q?9CHQlUpPnAu+9dwLioAW5poScb4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6afa7e-f49a-4e41-9cb6-08d9b97f6344
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 12:45:02.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvFZ8lEcrcztaYWhdkdNXf4GCmZ/V3Di0M07OW4PQT1kX46BqIxY37KQrmh7Dbo6BVrHunuCRsAmMrC5E5wQv02ZBj6XehSp0yA/X+RS7dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070075
X-Proofpoint-GUID: W8AePV6sgdX1UT0FIy5Ik2x5tEIIY2oz
X-Proofpoint-ORIG-GUID: W8AePV6sgdX1UT0FIy5Ik2x5tEIIY2oz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 12:37:45AM +0000, Colin Ian King wrote:
> Pointer tsin is being assigned a value that is never read. The assignment
> is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> index 02dc78bd7fab..e1f520903248 100644
> --- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> +++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> @@ -930,12 +930,8 @@ static int configure_channels(struct c8sectpfei *fei)
>  
>  	/* iterate round each tsin and configure memdma descriptor and IB hw */
>  	for_each_child_of_node(np, child) {
> -
> -		tsin = fei->channel_data[index];
> -
>  		ret = configure_memdma_and_inputblock(fei,
>  						fei->channel_data[index]);
> -
>  		if (ret) {
>  			dev_err(fei->dev,
>  				"configure_memdma_and_inputblock failed\n");

This function is weird.  So far as I can see instead of looping
for_each_child_of_node() it could just do:

	for (i = 0; i < fei->tsin_count; i++) {

It's equivalent and simpler.

The error handling has a double free as well because
configure_memdma_and_inputblock() calls free_input_block() and the
goto err_unmap does too.  It should be:

	while (--i >= 0)
		free_input_block(fei, fei->channel_data[i]);

I'll send a patch for this tomorrow.

regards,
dan carpenter
