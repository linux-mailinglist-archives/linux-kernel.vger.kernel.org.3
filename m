Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E094D1866
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbiCHM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbiCHM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:56:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F78B473B5;
        Tue,  8 Mar 2022 04:55:10 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228Ci7FO002358;
        Tue, 8 Mar 2022 12:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=GWcdKpSxxrB1CRwivlJ5ol5C2EVnq7faRQzQtx0qh/o=;
 b=Cnfbo9+dSzktERdNyc5zfv9e9VVUWlkCc++kcxKNXjZZcJanQASwkRFCf7P6EX+hv+gX
 Bpl80S9oZrXGN5oS195mWA8AoxFPVHYEIpv4gHs2aw7kUVFcYVGo2yyNi3TAlamFO4RV
 28GCcyqojCbjfu7R0Qv6rsT0ZU40axaSxkmDWSBf8dWPFpFuJLmZxQX9HVtreq2mIi3x
 822bN8a8vuXSEhWrpjOuoeTczmmktXCAXEKgkbU0++xXyAMBkHBg7E+eR1d87C6ZJaz+
 LVebJtv2b1kW26lLAE/k0HavRLB5thgDZeEI3xr+SSKvOJYPHCOxiqECPyp7/wWIjQBz 4w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2extm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 12:55:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 228CjnmX047245;
        Tue, 8 Mar 2022 12:55:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3020.oracle.com with ESMTP id 3envvkdyj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 12:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNA0utoB59n0Q+8f4eeojLfwsKHnU494qgepE9xm7Th2IEinQssP6yy0Tog9CI2jlEibGkZs/4murKw8qN6ZyNrmOJR6xfI1tEqwI+ve9vv4dssTNUbVVdiJAtrcBPYjrK65I5sU9gCdcQik7catXDn2jEBfzEgNigQuGVvch7bTnvzomo1tK4Le/xKOsGt0YNGkqkGWfuOLTTUaZ98MAQFyDocCiRCCT2xlRbp5wRafbJmuf6qY6D2UHb5tragjvrkQsEE4KYCiYJR2NZiwT+nzfqYR8Ncc3DqsbzIGeth4J3E2thiCIMJ2bFgQAVDi2MmHW2Im4SZadERAhn4ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWcdKpSxxrB1CRwivlJ5ol5C2EVnq7faRQzQtx0qh/o=;
 b=kABZ1W/acxCkaGv43pE4cHVAn/fPEks+HtvPxd2fTFaTSmmjRLStTe5qKbWLNc2bAu19OXZ2edgyT7VAksJK5kQ9TF/58eJDntlj+vZ4eEuh907CbbXs1QThmk1R4E5pKbN0GlKnoBh7A9hw5JMEn5rBDrvQ2lcFh7GF8iyQf/jvbfFRkLah0IKAZsMFo0jCVbZdyDoY8SDH+qUdVFdg3qh5Bu4OhBXOyDM0CUf6Zljyni+8Dot9BLCIDmlhH8dBXQThEBTjSwOTnEa2BdxNRmMUl3+bJq31HlKjbdcOPfxywYD+TVwXeov7ZAw9NoD1HigYSpxixZaubnehIZXJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWcdKpSxxrB1CRwivlJ5ol5C2EVnq7faRQzQtx0qh/o=;
 b=jmjPFu8dg5TYu3FjKh7JXPR0/SRG3yiT07XLZgr1bXmY8+ddM5yRReu8DVULtrPsB01co0k03P/uzVaAfvItnoId1j2Cdz6NoToeSofA/mQZtX3x6YCXQYSYzQm0Myq9JZlIBbgdIs1B8kZbqKfeqWr05nbRnJEwUGpdl70J2M4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3359.namprd10.prod.outlook.com
 (2603:10b6:208:122::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 12:55:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Tue, 8 Mar 2022
 12:55:00 +0000
Date:   Tue, 8 Mar 2022 15:54:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ulf.hansson@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mmc: wmt-sdmmc: Fix an error handling path in
 wmt_mci_probe()
Message-ID: <20220308125445.GE3293@kadam>
References: <bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CTXP275CA0040.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:1::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea9aaf8-4103-41dc-31ae-08da0102db1b
X-MS-TrafficTypeDiagnostic: MN2PR10MB3359:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3359E31907EF3796D3DBC28D8E099@MN2PR10MB3359.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e27ZK+xs29B3r+P9ac3XECCTMCzP2Ny5ASYn4vnpQXPhbtbgT9JI61UpsOTSh9RZbKmF8U8bnDA9/QJqYeV+LFf6KspuhfdvvSHXCm1FfqOC9CKqs+bztestdTbdayDVGKNmO2sfJWWpW/JifkWvhe2TbayoHd1FtTc2/t0JXoWmT0fBxXWgTvtI9lSja4fLumv47l8UbKVPzO7rBTQzaO+RQKy7+sYQP8+KFbEGSfWkuKFh2Wveq+437queTBkTyivJzyaNuRMA+Bmze+YDQiAnHjvtaVg1S2jKtoq1L55hF8HK83u2V85PcfzTk/ORQnest10Rn04mO4EuQVe6LDtpKDRZ4GU47HxTuh6SP4dpfZp/5w4v7zBfLrjVNues4m9mrS8ZtjdjZieJM/cLyrCmHA59rpKMnqqrK8h+tK4qoxGni546YdDJ967vAspMB0nurcveY8stbSf7JSwX+/L2lb5H2kCByQ2L/07kIh25U07/Fm6CVJftsvi0e7yVgGWl1MNkvi4r+XnYJ5pABGKFkMfsf5nCILinXao/eIJvKg44F7HVb6709uw9jAFdSsam7Bqpxx8CrHXPWwHHYPqJIBeqzY8lLDz3NkXsReaiPlS4gw6y6kUkHM++IZGobaPbLk/QyWKS9w8iJrOZJMAvkFWR98QH9wgQrp6UzXorqfj3hRv2HGPhyhC/zDhdOS/KLgI/P/exoRWfGUsJ3Zi1MVWW2708/dsSmaTBWBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(6916009)(9686003)(6512007)(6486002)(316002)(4326008)(8676002)(66556008)(6506007)(52116002)(86362001)(66946007)(66476007)(6666004)(38350700002)(8936002)(508600001)(38100700002)(26005)(186003)(33716001)(33656002)(1076003)(2906002)(44832011)(504134003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?53ACh44ZsNI1iat0f4JZhm+M2DjaRp3X7sN5aO03oL7rRpHY7zXALBaLTs8C?=
 =?us-ascii?Q?P5fz1eFvhc5MbEVTropUz1hQYMfPOmPQnK1uKS3CQB7yXiU4a6xVsriCActI?=
 =?us-ascii?Q?GjNbB+j2mDhYsc3ORt0Z2fP6AxYBPcflJTuuc+4WIwA1FCYVe5Gfhv75WcOb?=
 =?us-ascii?Q?LQU41W2tQin1e14eZvEidK9bDGcHXYWRUD4FZmUYzB5MTkOBgf3/SV7C2lUZ?=
 =?us-ascii?Q?VZlTR4BMhCzqM3bvH7DuN5CWTQvIRXScgvd7Ru8iKspMmFOAFD+3sbMwAKOB?=
 =?us-ascii?Q?4/yT4Y9yQnYG0nPlGLCKVm+aH5hYcSGMAbtC/7JN31M+zJLh8K2vn69NHohI?=
 =?us-ascii?Q?FWiEbx8UOqfZJRr+lec+hbvwqyqdavnzkwr+C3ugtZBDWNr3JHYXclW8bolu?=
 =?us-ascii?Q?E6+5GWIw0RJeiRDFQc7fOoWG32mGb3QoHdD6un8ywFOkkZdyOjsjIM13FpZl?=
 =?us-ascii?Q?hmQd6fBWT1PObqGkLi3E3KNn0UHiLiBP55vNGas/CqFFnRLbIrTX/E29eLIn?=
 =?us-ascii?Q?ZDRP6yC9J1KKyzdlXZ42XzRxQAvMEOqHYfKFgAoafPW+kN5mJvT+9m8ANmpt?=
 =?us-ascii?Q?ngimk8rlBlbKo7ThHNBvNxjUnTi2LxNPchqcwLXAwZUPWeoosMnoxXEcqY/W?=
 =?us-ascii?Q?2CjyK4e2aKD6jg/HrH0vgAagrrGGM41T4QEKDfZUu2sn555YJgvra8omH9Z+?=
 =?us-ascii?Q?weXvjtKk4xRp7ZYD/nkPNc/x3FfN9JfOP4CQFlCNvTFkEHDGBh9gduz5Py2g?=
 =?us-ascii?Q?B6hBt9IZt1xz0Qvj3Q5Mwc+2AETIaqDQc93nejUTVokZ8cSVrM23pJp7OqO8?=
 =?us-ascii?Q?oToS4m8iiZqV/wNMvasdCpqssLrt6FibrUOq7BCB1QamH5hW1vyXqg/F1rJ5?=
 =?us-ascii?Q?gKbAb3R2qASIvaeO1Pbx2wgWoymlnq0VJM1eTUArpUvm3OTkWXejiWxjP6Fa?=
 =?us-ascii?Q?VwQaM4mIPRFKQKZiVNrXniLWF+0A2EzBqZ+lJV/gFQicQj/wDpVHWt3G4jZq?=
 =?us-ascii?Q?eqSWIcR9fISdJkW7gqcFAOBp4iI6GtpzhZpZ9CSbS+5ErFQuBzR478J5kKpT?=
 =?us-ascii?Q?kqykDhW6xFnJmdSiQleENBoQM86n6ci5HU/ZelPfWfTa8vqwtFgioLfUg633?=
 =?us-ascii?Q?cs7NQ3FltoPQSJvfdBJQsAmyidniVzANWPy6hvAy6tl9Dnr1o1LIw0IYQry5?=
 =?us-ascii?Q?zP50hJ1whmZNg8SyY+bbqeFNLZ8yXi4jkGSMro6lPeWvpPo3H6vxaKFVk9b5?=
 =?us-ascii?Q?xdfDbscqQ8jEuBnFTdV5H4APswuEC9ElBgMYW7we/SbRxNumjvWupBHLRlWK?=
 =?us-ascii?Q?cJgHgtERQ+yBMtddtswF1AY25mz5yl05/Yq2qJOKksF4g7i3HIMxeRsN7M7k?=
 =?us-ascii?Q?wUpS/LrV88LZ2rmMMevEpfp7w5w1NB+EOnkSeoUQ8YtI2jF1C/ZCuLlUBuSC?=
 =?us-ascii?Q?XB0UZrTluI6XeoW27ebNShN57aOYnnU7ru5hGQMSTirVkDuuUkKDAMHJfFaN?=
 =?us-ascii?Q?lcIJIf7CGRffP3ychKxY+TLV313Dn5Gpb9eUkWR4MntyNTWobA69IDVQSzqF?=
 =?us-ascii?Q?Z0zp6DssAFKH2NK/11O8ict9YEK7r97X9/Tq3YFvVvUoWmbFuUXCZSMEM9h7?=
 =?us-ascii?Q?OrD4DL1y65Q4qkscRs+ZqJOYOgrwCJD14hI5igOFyaw49LDSm5c2efM3ZJIt?=
 =?us-ascii?Q?cu3bmA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea9aaf8-4103-41dc-31ae-08da0102db1b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 12:55:00.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA8+mFuTDLIzSZqWQvZwo9vRjEzMc4fcLrJfR1GCU+WBNvCgu0VNaUnguhKOFq91IF6FdMg6ARPVMSdBrRE2nKQHRPgnr2wvd5waT+IGCIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3359
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080067
X-Proofpoint-ORIG-GUID: 2U-Z_O3q5raUHw6SjD-li9yrDSmGInqh
X-Proofpoint-GUID: 2U-Z_O3q5raUHw6SjD-li9yrDSmGInqh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 06:44:56PM +0100, Christophe JAILLET wrote:
> A dma_free_coherent() call is missing in the error handling path of the
> probe, as already done in the remove function.
> 
> Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I've not been able to find a Fixes tag because of the renaming of
> function and files.
> However, it looks old (before 2008)

You did add a fixes tag and it's from 2012.  :P

> ---
>  drivers/mmc/host/wmt-sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 163ac9df8cca..8e18f01c0938 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -863,6 +863,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
>  	return 0;
>  fail6:
>  	clk_put(priv->clk_sdmmc);
> +	dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> +			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
>  fail5:
>  	free_irq(dma_irq, priv);

This isn't quite right.  If of_clk_get() fails it should call
dma_free_coherent() but it does not.  You need to add:

 fail6:
 	clk_put(priv->clk_sdmmc);
+fail5_and_a_half:
+	dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
+			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
 fail5:
 	free_irq(dma_irq, priv);

regards,
dan carpenter

