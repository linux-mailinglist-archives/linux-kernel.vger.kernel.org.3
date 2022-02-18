Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27394BB91E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiBRM1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:27:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiBRM1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:27:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B330220F6F;
        Fri, 18 Feb 2022 04:26:58 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IAHhvi009210;
        Fri, 18 Feb 2022 12:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZQoLSGRcl3CdiH6Oq/9zlDrwoM66f1ImRi8z4uxe/Iw=;
 b=xMag2PJD979vPrQo9suuIW4zzQFLbXf+dzzQFRFhzG1oL+1Lb0l9lP6K5hhe75vvZkoB
 9n1IkjiwYV3DrUUeCsNILVsuULGXsO0z1mVFrxzY6FsJaciRixqX8D2ErDIRy02HNQvW
 uFqT7LldFTul1NPSP/tIOGiXnezIH85arRlg7LsG3h3ZC6Ez9d37oAxB//a+5s2dg7+e
 b2cZXlsrZepIThABxKUBwW9KbdW/8d4hk5NlQN7udezXVC1kXDNqukVn+7PqRNYwDHEv
 vzRu37pXNxFAl+8+YrIrDJZi+C0p1RYLXoWiZie9cR8Wbnx4qFHlu+S0/tja8CWJy+jM jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3e1byb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 12:26:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ICGdK4163948;
        Fri, 18 Feb 2022 12:26:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 3e9brdqq15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 12:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP/xS7ZOEXywaDnFrZY7kBWy+GjqElx3MS/IwQoWooY46slUY8m4KzMB17GhZ0172jtO0fX3u+Ox8+0A5dYLQjThRh1agTHLzwxFR7qzhLhgKRvl8FF+CTaSjjVDB8qdDmiasKLIfCEMZUvxBlB1Z6fPgdlRJnf5cCA1bo2XiHi0zE5lNlnzgDzr0fGNj4Be/8HOA+rtmiJLZ58w9enVKZAN1Q5Kx2fYA+lmlsfb2DUvNgaEROk7q/dAzFRATa+i5HB9kMabXNx0Evfqty9VBLuLATGfkAhOvW/HhxT71odxIYV7k60wB1SfP2/CciKw8HWBMlEqcpOZHSobE/NYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQoLSGRcl3CdiH6Oq/9zlDrwoM66f1ImRi8z4uxe/Iw=;
 b=Nzjrx07sPTrXDUtE5vEbUnWt9unV9Use1/5GHs+q1tiwjcLMg0RDjNri3nSTaNYhhA9HGPW86WRDHV9RDspzT1YAlBgUhKGu/t2x9z/Kerz2lKYsMeD+E27aM/RltdSDuPLatPU3Yt47zFYpQd9glLtuPZMecLLMY4kn+fRw3mJwks1O9ZYWtYWGdEcLbMZCAdpsfbGp0duE7xwgFaCxSkOFkdaQqNqVSxW3kStFN8eak7zWAdI1edzZ8BSZMvBAVZXfwSuG2izwYLFO3CZixpQLllZDHI+VfhAJDWGEq5G1Vg7liSymWxuKqWSmCkIDsG+z9/mnueXi3i5e+lajfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQoLSGRcl3CdiH6Oq/9zlDrwoM66f1ImRi8z4uxe/Iw=;
 b=zYgUtWMnfomsrsF/2e2kKp45t7IhKfOSgg2NQm73aLBo6eCJiE4V6Al1XSihHKBbsMT7J+3I1Brc2rCUocNp5vQhtaDxsWpHm2ee3SkKSY7VK33i+8Fgn2qyNqEjqyJ74Z/vkda72pnJnrXG42cpBMyJs22bsWh4XUkQKOcYrMU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3955.namprd10.prod.outlook.com
 (2603:10b6:a03:1f7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 12:26:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 12:26:38 +0000
Date:   Fri, 18 Feb 2022 15:26:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] media: cx18: use GFP_KERNEL
Message-ID: <20220218122620.GI2407@kadam>
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
 <20220210204223.104181-3-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210204223.104181-3-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8370562-d51c-43bc-c8be-08d9f2d9e8fe
X-MS-TrafficTypeDiagnostic: BY5PR10MB3955:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3955887FE64A35457C890B638E379@BY5PR10MB3955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GsYq/pccMCsEC+sksSxtfQPgP/WLoNKUrvzEZjRBG+ZjQWYD08KcJZ6jSm8mVl9KJvPsi9rvNy9/qFm5pfwioxPG1CHo9AEMT1sMc62ZlR0jGxNWbNSkxR4FedQ2EPLKqXQUohDsH+MugyHmx3YsMq7/cVuqn1aVUAKx3POCDrrT0VtCXO4+Pl9cnmzyy8tEzIVfvOpvsxBbPlKmSST/CD4dFOKLK6ij9ttSzg1OpL+Bd6gUCwkRYTEGfp2VCgwWo8flUiJkBIhstSOwkgoxssBqrol4ehWLH4abYORFyL9sR3JJfCx9NSNx7Z4gQTmfrYkKTvN79FiwM4JcWKSnw5GrjpYLJG9QpQZjoL5zxuvg6i4yswhBIj8cxNTgmKustoVsNFdxgy5GsURAcVQrYMNVzrGQ/yr91Ns61FtwO9CJrexBAJTiLq1gxt4pZe536Cfjl+6ryCLZB8fNPC8MpsC9MBY9i+FVDKirtEZ4J7gXUdbzL/3YlvM1dFddNOvUqlKk1uhymzbZHGxjGqBJIRBxi8mkLjxgyp3dKwJwYJFifbY1W9S4ngfgS2zi6AaEbAiuRgeokt5aXvmEXv0Ky6Hsc/0+HRgLDCSLWg8hJE1e0Rfgdqh/IWQvirGuFXB70ifW0nlZODfEZ+8fj5+sDHO2pDV5fvO3s7kg/+BFLebz6ZCB7C0d3N699qi6dY6q6widPy46C6ZzodZbl3iBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(44832011)(33716001)(4744005)(52116002)(6506007)(9686003)(6512007)(86362001)(4326008)(5660300002)(6666004)(66946007)(66476007)(8676002)(186003)(26005)(66556008)(2906002)(6486002)(8936002)(38350700002)(38100700002)(83380400001)(316002)(33656002)(54906003)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RP/1v4TBzgibNtxP891pAJTujPUFo5Qarcm1LQI8bn099g6iwDQ0mbnMRf50?=
 =?us-ascii?Q?FR10hnX9FFU4YV6b98zj/hlPHisXpaDdGwgaPhCuV8g7CxORXbcEmE1WkbF4?=
 =?us-ascii?Q?9MLRsiylg7kNC8bEydUHE7ihaZLBLp2SNbapsDTIAswjlmL9kKmor06fFgaa?=
 =?us-ascii?Q?BQrLbA602i3KbFvU9aC8NA43ZYRHhX8Pq3ZZDBd2OCL0VIilTpz9CwoTmf2w?=
 =?us-ascii?Q?8rEiQtU3mUW8YEKfakzvDrH9axvczxTe/+5HXaaV34eVrOWI/4Ll/+ZYP3fm?=
 =?us-ascii?Q?QP/FiA+CUk1IpMbRnr5WsGhhHI7RDIh1sHUAEyY6Ky1zGbGk3HlnQOlTUE4V?=
 =?us-ascii?Q?HI9d9GxFqe/4Gwf+HH+UTTnSrOZimlE57gibcCDYy/pJPJsRUk9TN99FOqLS?=
 =?us-ascii?Q?0Wrdfji62Bca4lUNg0zO7p4M6AymKLholfzwZ/rsaL9NKY4fH49qyLCrMosM?=
 =?us-ascii?Q?soj1zkV8PCzNNC6NNfYJvs01ziXegNLtEQjeX0E1B+vwOLcAgfOYaY/mstKj?=
 =?us-ascii?Q?nh6gLyQh0rqc6dMVMDyMcnqWTiZ9MLEAVmAC7rRAUGWjzf59chkOtx4Zk4pO?=
 =?us-ascii?Q?rpZtciaE8Fo8GBTdP506iE0L3iSOg+IF212K/wLJ14dkqJfqeYeiwbxb8oZ3?=
 =?us-ascii?Q?T+AhftFuhvvvc901a79T7hPuOmDrSmGroLd7jvkPF8Fc4oUQtw2ICZE6jPmR?=
 =?us-ascii?Q?h3hhKSWTu62i5CGcTDxukbUUKvsOfQmbwrg45x6rb3ft2zXWB3y0v7IruxWK?=
 =?us-ascii?Q?4xJapapT2owlrbRsLKqE7mixI3Ii9/KwmKw/LkfwcDvRxay28NK51hqhRoyO?=
 =?us-ascii?Q?imePZK3aIGWRZOHbUvuSUErkz5jkKWw4klLGa5V1vqxkJ/nPgT7O4xo0UgLj?=
 =?us-ascii?Q?lLLQlh0fB2SUIfBSTxNh1mCstbRT/DI1CgmWDM46IfYGkpZCoKvJSfkzXBt7?=
 =?us-ascii?Q?QIolz4SvN3ty44t/lNO6lZrVx2YQW/iVpBHIVFPaqYUBMYcutEIeDj+VMU8U?=
 =?us-ascii?Q?3tlm6g7XHmknrhCHC6EqJIqIcCSe28DVWrsIA3ISg873/paHh4CfbtuYNF9j?=
 =?us-ascii?Q?XugTaXHA7euAGy+w3RwE52zdeUZQ/8nNDo8QuXrQSabZFRPi9uV2BoUNhMif?=
 =?us-ascii?Q?sg5Ozla57wrgMlHRxVnR6vTEURGmhqe0q+nawSQIaOKr5cfi/2g27rDLeeXI?=
 =?us-ascii?Q?PfBe1p34/F9vloHTpCt+cZiZcp1ISNPp9TbfUbKdHPMScqr9vvPgTcUxwX2a?=
 =?us-ascii?Q?InuPaZVOronvkdWreFwf83OsA7dpKCXJC+PVQhmfJqHZUICNO3L4vQTRUKKk?=
 =?us-ascii?Q?4ButHO/4KcfEQ3J99WueRhqNW5NgEM7nA32Embtwcys+WUq6H2Ac2FeT3kg/?=
 =?us-ascii?Q?vW1tZ/nK6OdYshxWAKbcXxs1Gsgxr5hP/7JbRIoAQxlW7gR5sp0WR73E+VqB?=
 =?us-ascii?Q?iQadG9SIpQb0G7F93cmMYbcBFnlCi5AgpIBzvLnTEXtmFZFo6Aa1DVBVESfq?=
 =?us-ascii?Q?jTVHWnph4maDqxNB82Nj7bvUx8oMjSSunEoe87MvBQ8sM892tBVRTtj2UUxl?=
 =?us-ascii?Q?/qCX+QnkREl0b2uUjmWLvWMfLHflBAWTshMTEkRPQ2n4TyDvsqH8x0PUldrT?=
 =?us-ascii?Q?uvIRsOKacxYcnwGaIkxPD/U8vCpUY0PHfzQQtE6HPk3ilgQ9evF4Chn9Vedj?=
 =?us-ascii?Q?Dt4C2w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8370562-d51c-43bc-c8be-08d9f2d9e8fe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 12:26:38.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If4Gs/g+cdaEdoVkuGJWAGObyL+dsnx+WrTf0mRJF1PgZrOaZ315/xoEVDN2aI+G8LpcgX7bjhJQkZIfeAdFz7LyFmkychi8+QB4Qvg0lG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180080
X-Proofpoint-ORIG-GUID: zxVd4KgjDj3ry9JwRbxPi4ozAmLRnJua
X-Proofpoint-GUID: zxVd4KgjDj3ry9JwRbxPi4ozAmLRnJua
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 09:42:16PM +0100, Julia Lawall wrote:
> Pci_driver probe functions aren't called with locks held
> and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.
> 
> Problem found with Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/media/pci/cx18/cx18-driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
> index 59497ba6bf1f..1be9672ae9d4 100644
> --- a/drivers/media/pci/cx18/cx18-driver.c
> +++ b/drivers/media/pci/cx18/cx18-driver.c
> @@ -899,7 +899,7 @@ static int cx18_probe(struct pci_dev *pci_dev,
>  		return -ENOMEM;

Unrelated to your patch but every error path in this function ought to
call atomic_dec(&cx18_instance);

regards,
dan carpenter

