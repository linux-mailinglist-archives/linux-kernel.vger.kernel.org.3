Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7344BE457
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358022AbiBUMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:34:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiBUMeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:34:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E819290
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:34:14 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L9YxEv008930;
        Mon, 21 Feb 2022 12:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Ke7k2JwNgtVj7ET+rmI1trdqx5uT4gcp/1D63C1BHPs=;
 b=R8fbzQ9jubsJcH2uKWCsp2wrXN0HeosHorc6xc/+XwNxJbAvRkYxaFYqZCA6u2VpN8MD
 XmlI3wGjUbQSyhfC8ihpMJS1UqRXkI6k28Gn1Ugj2wyPGcZJ3wrdX7oMnu3NIWyVo4UD
 A/8P59MKDBt7WbVqrRAR2v+kn+qRynRqOycrSp8tKvH71DENphv1broYfE53poqvN/Q+
 I5HHk9jNEHd+yuflW101o9ws3QmhgAGOu0a75l18RVj1joaDXv7yTg4NM3IsbGzl2zoL
 k3iAQkeyvK9mRNMIjfnBPZ8Y6qTWvaMXIoxYlOsaIJqMAgMqYTcFzSRix6Y2bD8NrVEm 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eaq52c2qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:34:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LCGmx8031964;
        Mon, 21 Feb 2022 12:34:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3030.oracle.com with ESMTP id 3eapkendp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL+qafH60mWlRmcEYK1+tpT+P/ZGZm1c5Rlel5ecN5quxtSlD2vNCtQM/q7yYboFxpxLp4JfXtCDN/g5uyd0Z3lRY2Xq94mIPv3fkFPeAyPEGVsoL89Sj+edD8hT/Sbv80jtPT/UMFlPQak4oeBlGwFXFS29WCg4BclJr4lm9WFkAurMPPD7M2J0y30SzKfekPzx0KtxKzTTv65L0B5dXIFlYhD8zdxrU9XwhvlzmLzXGKNF1qPMBB1EMR9f/dgaY7twDzDZKK6133yj4ivAvVzjgCLTuZF39U1qbJcgtfroVNq4bUS3xPPgG5DDq6Bna7OCuEdZlpVM2DobZ06V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke7k2JwNgtVj7ET+rmI1trdqx5uT4gcp/1D63C1BHPs=;
 b=YHWJkhY/SrOlCIPWkhJhDU1RZ38jdvn5PRYhnYA2JXEs+47650+jdWRijAjHrPBKwy8HduSGA0jjZclCW34KzFwhdCKC1VIFGgDman1ommwqYvH0s9QeV5g4ZGOVCxmbVsdztHA6JTERRUuPIResBipwR2vj4JL2gop3MmR3/JegQFPDDGVcPHd3ieA+m74CMqk3CNot8qai+r9yJMV7yE2XPLntpxcS+fmKSNul3EsVGiZnVkAaiY/c3iBD30aSyLAj3fFNOi6R2jzSzMbJMRj7a83sloDQpGuIuR+7gPruNgEbqVeYcpNdQ6N2AUwLh1syP8UG+s6oIlabY8TMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke7k2JwNgtVj7ET+rmI1trdqx5uT4gcp/1D63C1BHPs=;
 b=l54Jr1vZDnpfLNAW30HZo/3HPLeK7W6fBD+h0bYjBL9NSdO2dA8tn0nmqx74JBDaEYX67S82SXqhuZhZIFefKmJbY13g0SY5ftUu1ggiqlx4bPr76E5sqbmqhL0BAeus/rHwfrwLYp+dX6rM7lDvXlmzG+w9lnhiEOFNwE0KKB4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4961.namprd10.prod.outlook.com
 (2603:10b6:208:332::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 12:34:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:34:01 +0000
Date:   Mon, 21 Feb 2022 15:33:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: vt6656: Add comment and change macro to
 function
Message-ID: <20220221123346.GH3965@kadam>
References: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
 <3eb14cfaa3f97695bd4db0dd75ac78408c557821.1645386791.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb14cfaa3f97695bd4db0dd75ac78408c557821.1645386791.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07e8838f-be43-4f00-a152-08d9f536702d
X-MS-TrafficTypeDiagnostic: BLAPR10MB4961:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB49614441B16ACAA8461938EA8E3A9@BLAPR10MB4961.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vo0Pipd+2n0NaNIOU1XzIQlJ9nWg8S3x2tl/ITtMZqro9MUERmUlAKmEUw8zA7VmXwxBA3T8vcCrbWAfBvj/66YhGlXwF54z06iW5YRJTqsCZOTmF6D5MEwVgqKEC7B9+pE81ujz+5Kon85qf9rn2WFLGkXAGKK3cC/d009Pj850jOlQ94K6OZ2+G9F9r+utVrOAP7j7gEXRqJtriVrIGtggmyrYs/w20nHff0V5peKuYHz3UGV4RTnCTmpqOHq1MMTvlvJMIEk2hUWp5qPxBYTokCcMY9Vbf8aBiYCOKzPMOj7gi+t6YcHYkmUcjpxsgz80rYTwZB+If4R+tK+EMCIP2iAQU4WALxbQGwZFxwmFEjRjxmCT7Xv+re+1CUKna9T3mIYHCubReqvzmGN1HfazOPkHu2fCoqbGIMhjPe50eetlL/FOuYm1L66WkpD2QXhw5P5E64tTZYKRFlnbWrndPIppFI3DDiY4PXmVcRdQ6lGH7tYxwBVE9ywAd38ahXkG3to+wAjifHYASsmYchNB9PsG4GCL7R+dLnepMUPhvXio7ZtUGnoXh0UvY5SbIcTWxBN8YUXuIYYsYCTTOnw1uZsb+tqEb8ceN6juJT3ECf6grh/0oJG4I5WNwIyGYoiVzd5hf5PbIp2kWKIIuMW0u2TJB8YB7cYWsF7zyQYYy+LwlJ0Ku6qJgkRzPJrpeYi6ap4KLBJFyq4YnHYd3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(6666004)(33656002)(1076003)(6506007)(4326008)(5660300002)(316002)(6512007)(508600001)(66946007)(66556008)(66476007)(6486002)(83380400001)(6916009)(26005)(186003)(44832011)(8676002)(8936002)(33716001)(38100700002)(38350700002)(2906002)(52116002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+uPtS+nwdlVLI9jH+4mFFVzWsT8CpM9cstzPASqiKMgroD+Q7Gwh7xauy3ps?=
 =?us-ascii?Q?bj7xdZCQuP5xywZBdhe3BmWSuUApNMrx3xLfMEXGM+5GHquYqKAuMszmLkDK?=
 =?us-ascii?Q?aSypL4Z0lklZZuUZ9nOiFsIHFq+GTmXAKB1nZ9M1DuilolM4rWYrALS4juLe?=
 =?us-ascii?Q?LUaLRIBpRgrKqeSxOEDKS/IyR3oK9JW4l6IIalJnmSspWLrbXtzD8UKbk8nB?=
 =?us-ascii?Q?cozIWfEFH0RWKu70zRariJvEhhDqbFviqg87FM/e8mrtHvUeClbSsZ2AzMnR?=
 =?us-ascii?Q?mBuqBvvsHdXRWP6kBTPaitrSSLSUeQ4DQUpY8jY3e4yBjXfIGGlwh1t9vmre?=
 =?us-ascii?Q?6KnTWTuz5zQTRjFJscbzv5sv9OTT1BNyLJEVf3VOkMIDNdMWXoqZFyq62CQn?=
 =?us-ascii?Q?LeRBrsXUhvyDcKeZse7pbOvP3U0adyc5YqsLhIVWV8Lm7VW6vpB/wWL2FvML?=
 =?us-ascii?Q?K1+vPMpWaNkFIM0ZUhA0EQH5TzHZ1gn7cxtBOUhIerONXn7Ga4ketUoqbUKL?=
 =?us-ascii?Q?5vkjuR9Cs4QFPU0ZaShy14DTYWdtJwhiuCD3oXXRi/rWIqFlXbusosBZYA7M?=
 =?us-ascii?Q?D2DmGZZkPDIYBmvotdc/OpLXLKG+IrB2mNX1kCvwkAnu4rAwxOGOej3oAUmr?=
 =?us-ascii?Q?V/Phr26UpcERQisQuKP4VA6k+sg8S9ibNKVUxrdDq2blXVZWOyZpawcNViOv?=
 =?us-ascii?Q?PB/NyWkT52/CRP/1NExzs6nI5FfrZHNOEYPx8mKmwSGx5Atzh9s4U5cAceCV?=
 =?us-ascii?Q?fOQF+//LHZ8Q/s9YxvjKJHTrAMh4c6UQ6kXYbfsgOa1yc/FbJRWPNoo5UNhR?=
 =?us-ascii?Q?+sY6YTo20MN6rufakusrATvFQu6FcUNnuw5NkjyQc1BQZEjKXIO/GbYvoqDd?=
 =?us-ascii?Q?QpFH1frD1Ejbegrc/5aNhgGeX5p//VqEH0Bspk9QnxRYYHwiyaRXJmcKxWZz?=
 =?us-ascii?Q?Lpq/gAVOa/IxqQ74d/uxfoGiY33g3tY7HHfL2l8weVe4C1bYCaeR74NwsqFX?=
 =?us-ascii?Q?FggiG/ORKSQBXtw0RbH4SUwfR1xitDwYhVf2Kns98eAmeicDM9A4CbD6FYec?=
 =?us-ascii?Q?cLFMzmCwAmalIxOZHa/MvpB1GfFjHj1rYv6DnCxquKcyGrFPrbke9ihp+Umo?=
 =?us-ascii?Q?gGVPjwOhPG8zpR4DTOrgXjyUI4sige2Jw1dOIAIB4brdK388w8+a4LYmejw8?=
 =?us-ascii?Q?JbD9hThkRq1R112GGgtraXtctsU6iazFNIkWpuiGpdbUvSnKwvylByDLmTDQ?=
 =?us-ascii?Q?KeDvR7+OF6A/3SllCrfRQBRQ2j4gjCF6MbOxd974b2XxMWRIpczZUL2B9Di/?=
 =?us-ascii?Q?2kw1T2wkiXJD36VeE0ZHa+695+uRFqkt7sp6hp8egu39DVFIJttzOd+7Amvo?=
 =?us-ascii?Q?Ck8m4vFNvaoPSReN+rqF4vaQzbwXqWCxT24wESWM9n5/OKh7Sv4EnEEQ/F0R?=
 =?us-ascii?Q?gUk5fxR0W4+t80nsZB/unVaxmwHyMCmIHqWYhy50bUaekf/KUHSCUekhAXzD?=
 =?us-ascii?Q?QXofhAaoPmAEPqBmx8FFSwk/I0UYMFyyRzCcMx2Y7gUmERlvgy60H+wN/rIW?=
 =?us-ascii?Q?7J2F1xG4q2BExEjQvSPGBFP6qjmte78EVuOPWC+PTR4Q7TLaUuLFLbxYe1sl?=
 =?us-ascii?Q?mBG19MTQgRMtHtoNkLnEQCdv+0+LsgZyPgZQdpnDrJPrjVDHjDcL31uM1/KH?=
 =?us-ascii?Q?OiMKqQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e8838f-be43-4f00-a152-08d9f536702d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:34:01.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubDXXgMAbLcsFHo0odrn7oZw0Fd471oi7ATzkWSbgKxi8IuHQZz4bPd4o8w4X8v43Dg3nnPXXozJaoQvB3+ia93/wieDOs9JvvvGw2XTvMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210074
X-Proofpoint-GUID: eV_UJQS7y3PXW6fpda0x1Tv3wSyfmYLI
X-Proofpoint-ORIG-GUID: eV_UJQS7y3PXW6fpda0x1Tv3wSyfmYLI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 09:30:36PM +0100, Philipp Hortmann wrote:
> This patch fixes the checkpatch.pl warnings like:
> - CHECK: spinlock_t definition without comment
> - CHECK: Avoid CamelCase: <uVar>
> - CHECK: Macro argument reuse 'uVar' - possible side-effects?
> and moved the only twice used macro to a function in the file
> where the function is used.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/staging/vt6656/device.h | 11 ++---------
>  drivers/staging/vt6656/wcmd.c   | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
> index 8b6623a751f0..eb84590d5eeb 100644
> --- a/drivers/staging/vt6656/device.h
> +++ b/drivers/staging/vt6656/device.h
> @@ -268,8 +268,8 @@ struct vnt_private {
>  	u32 rx_buf_sz;
>  	int mc_list_count;
>  
> -	spinlock_t lock;
> -	struct mutex usb_lock;
> +	spinlock_t lock;		/*prepare tx USB URB*/
> +	struct mutex usb_lock;		/*USB control messages*/

This needs to be sent as a separate path.  Add a space at the start and
end of the comments.  /* prepare tx USB URB */
/* USB control messages */

I'm not 100% sure I understand these comments but I haven't looked
at them in context.

>  
>  	unsigned long flags;
>  
> @@ -381,13 +381,6 @@ struct vnt_private {
>  	struct ieee80211_low_level_stats low_stats;
>  };
>  
> -#define ADD_ONE_WITH_WRAP_AROUND(uVar, uModulo) {	\
> -	if ((uVar) >= ((uModulo) - 1))			\
> -		(uVar) = 0;				\
> -	else						\
> -		(uVar)++;				\
> -}
> -
>  int vnt_init(struct vnt_private *priv);
>  
>  #endif
> diff --git a/drivers/staging/vt6656/wcmd.c b/drivers/staging/vt6656/wcmd.c
> index e8ee2fbee76c..77c6d898f660 100644
> --- a/drivers/staging/vt6656/wcmd.c
> +++ b/drivers/staging/vt6656/wcmd.c
> @@ -31,6 +31,15 @@ static void vnt_cmd_timer_wait(struct vnt_private *priv, unsigned long msecs)
>  	schedule_delayed_work(&priv->run_command_work, msecs_to_jiffies(msecs));
>  }
>  
> +static u32 add_one_with_wrap_around(u32 u_var, u8 u_modulo)

Please don't name variables with Hungarian notation.  Remove the "u_".

regards,
dan carpenter

