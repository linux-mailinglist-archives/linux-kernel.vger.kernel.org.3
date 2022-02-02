Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6424A6B29
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 06:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiBBFDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 00:03:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9844 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbiBBFD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 00:03:27 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212068QZ022144;
        Wed, 2 Feb 2022 05:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=UNo7SUAFlMndj4WDbpN9Nwr6n4dpUMD6FKibNKYvl1c=;
 b=S4NRgz7sEcypYpdr2eED1GEEN16gasPIkv+V1yXaSgX0yHBLT5nkHPtO+Xxgq/s1sQp2
 +NpygRJ762ew269DnzgleeIWR40GgpNLTPN8SJi+Vsb6nfytC0TnlEDhG3MzdqRcAqVM
 EJyzw3L39M5yBdyOw04poYl9gjY2JURYdGyJa8+RBkhoXGt21ycchDYn+w0KK4aJN6nz
 1eB8fMq6FB7troPSlFCkDuRci3kWWWm7EXk7tBZ09M0FY4sMwxRKvXhj+6YzcYvvyaXE
 FTN80woY4VBV2HZBWmyzq0dVQknwJZNL4X971Pg24nLio4+rhT6MiZzipu8u7ZOcExdd 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2mcx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 05:01:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2124tPWu104241;
        Wed, 2 Feb 2022 05:01:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3030.oracle.com with ESMTP id 3dvtq1s7qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 05:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMxaNPWCGjEQnFH8KCzS5KDitO3Ux/9hlEsDfLXFvQdP+LcmrXki3CfU40ElH8oQQ37LPbJHWo7bJls7RK+c267BaGy11/ThZPt6Q7KWC7gQK3PZVtEZbdYTYUXtpy6/E6+j3+cPTAuDXsMHzEQ8dFWx/zVv+Up1JZkgKJQCnPFbWbdsy2G+i+cKb8ifwwdi1YCLS3ad601FkNviKyHItrbFKQABQ4KlbjmleUyg17Yh2h1XzRTwqydK1XgNEwxMXjyBAJsp+Ylroh9FjOag3NavSOdhVsllOxE17jsfWXDtk+CpskVulxjq9y66sCsZRDhixOGZCYvrgDFLBexyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNo7SUAFlMndj4WDbpN9Nwr6n4dpUMD6FKibNKYvl1c=;
 b=IvBaY726A3Wo0YGWZXjln9VokLwlAu112zLrXn3nP/Skutqaj5imG+7GZrTb5HnKOl/Q0gRImfW4XAW3ninM62sGJBmP3TrFSZqu+LIG6iV0ccjdfLBqxTc0vcS2aWKmX9DXMvPOyLGcRiwEaqgf3J8NlQukDsgdlpIZDQp4C+aQE08bgIvyw9NWUvb2kGmEUVH+W2fd6u33YJeh7wizH+4LF6D2He1QSoat8OCbNLavRsmY+HeQE/as6va0gkhS4YxitT0+VCIWDXyPcdoA74iSzD8AiSFSq5gy70fNRkWXDorxbMWqPpcy3z2uUYzBXmyN7KdUdfpZzIBuLJ+tdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNo7SUAFlMndj4WDbpN9Nwr6n4dpUMD6FKibNKYvl1c=;
 b=lO/CLWh7S6dFNRL7TWN3YDNqhzSwwj8TThC83HrlCAQff4vCWrUAVL8yPatNwt8EZ+ZFHy2Mr00Fb4ox2cvcHxJNouh72Cdx+fQIXhWS6PSp/kA+DLGBqmxDh9tO48yDWnnkb85sS9VCIkL3SqoW9H9a0UlW+bbn515v7IgPZfY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5566.namprd10.prod.outlook.com
 (2603:10b6:a03:3d8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 05:01:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 05:01:09 +0000
Date:   Wed, 2 Feb 2022 08:00:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Rick Chang <rick.chang@mediatek.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mtk-jpeg: remove redundant initialization of
 variable plane_fmt
Message-ID: <20220202050046.GR1951@kadam>
References: <20220130231111.8563-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130231111.8563-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f1a4fd7-cb7d-491b-2d06-08d9e609066f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5566:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5566F482A910F778E55ACB158E279@SJ0PR10MB5566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kru+q9jgB/OqRpjn2V56wEs/CyjPQleK6MdZL/folbutith1iX19zil6b3P1CciG5M7yE+9iDRANXa9PZc1/RsbxPZTPi8zzp59lgD4xCRlfPUjIlOnPlwgvCR++q4Cib/UrV3sNVT6QcZVc0eRh8spdcOk6XxXex3pYMD7LUWaC+BqrJXg6aDmckC+OK0KlNER0+Sdax/tgXev5JaRH1ouf2VVimF5VqSSYtrI2wXIw77f1UqRJNmZFA6KvX3+TRJMG626/BDxSVDXKMy0b0bVk7tbXCcDOnmkb+JrXNd7oBdcaV6QhR6425QgIhMRdD07docFmTle3gukDgjefbyYgU4gpTN5tSTZYUkMw+IYAYqrnyzF0i7YpjYLOqEdbUQ8PvyqePEpmcmIE7DhlB/mBcjP803U/ZpBZ3BjrWP1/YR81MzbgwikSNQ6Ua1Dvc+d6zCOsMiDzBpdZOTxuiFxfAKxKCPXIwIC5LEIFsHBprUsR5yKV7//6W0TRUXO+DK0xzFBAh7uNo0ACN0CxkRo1l2oyL36QeYHBzU3EWGUZb6VDXuqS33OijARFIhdnSnP6C/LrVo4Bz6GT75iSceaHnsxBk7pbYSVMkJ+eVo3BFmMBX5LTLRBLPpxckUOaPRWoEv03SAW9bDyuzRS+5zKk/m6M6qlS/do7TPDlBL9i0qLkOYOrjdienthz7v3boGxDJdD4tjN6nCfnCwFIwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(316002)(54906003)(6486002)(5660300002)(8676002)(26005)(6666004)(4326008)(6916009)(66946007)(508600001)(33656002)(1076003)(66476007)(83380400001)(38100700002)(2906002)(66556008)(52116002)(6506007)(6512007)(44832011)(86362001)(38350700002)(186003)(9686003)(33716001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGPgmdsd/mxk81YX754qRczb6J6oCDTuVQCKFrc1Q2FfIOGJ5pg0a01cme2b?=
 =?us-ascii?Q?KVi2wHrkgp6IIbzo7slDHucwc/ookoemYKtUfgzqHncZ8i79XivuFFYjaQVt?=
 =?us-ascii?Q?Y6NEbuaE4mRU18RBuVGlGgp/HwHU/OlT6h/IJxYOnQGztblnUpK4jPtVW04s?=
 =?us-ascii?Q?CKaW43/5FQkT0/qoBsulGc+oj0r3iOrT2KY6RWZ458buePwmyHJ32iUTWaGp?=
 =?us-ascii?Q?CWA3VQy6VT0cI8e6DwEhEVsnFPDzGa99uKwusR5Zzw6mJNCGm8i0aS8fbCco?=
 =?us-ascii?Q?gEXBsF16I+qC6EvOi6uKGxRQ7FaRclnR0Y9W4oL7ZSN+/1tw0tTtm/r4qQ79?=
 =?us-ascii?Q?F+lgD5x6jX9CX6qkMMnj3ebdcMRFGjgeiwy/QThwamXVyHK+iXHT1jvGVCEB?=
 =?us-ascii?Q?5dYXFpgwkmAi8Tb6lCD51h0lMi7s1yoojlI7TvVHCFqTj2RDCezEu1jMwQ2R?=
 =?us-ascii?Q?7pUQAZM6MfxWlEWsdZ5Vh4MacvH2UexqnWNPC0J8jILrjUdAxhybo44BQKag?=
 =?us-ascii?Q?1EFPSVYU1YKkhh7Zodf64+j8SnyB1ti9tREEQES9GrZ48JDx8GVd6CWc5DED?=
 =?us-ascii?Q?VTrcgzKx0EAW8+rI95wmGZK3DRNFKUyQXRHJhUD6YFOOPrx5VIk/l8L2rkMH?=
 =?us-ascii?Q?qPRr8iiwWtfd4b14q0/BfHx9a/BEpS7T/J33SuKDMbvUAtKEhEFbf05jErMi?=
 =?us-ascii?Q?22ahz+G+sdvJv1ovCrc87mltE+8AvTnTi7qkVmariVavh9u6LOdMYNjxuGqT?=
 =?us-ascii?Q?gehKAc1t6hKCq24FNFcbwn4ehWAo2QjOt6lR7YZ8Zun+8KgK0xYCEoputksZ?=
 =?us-ascii?Q?mLnkGZYwCHmirrCpw8htCLNZpFGsO7+usaQOdm6OMAarpWTX/xNxSFLwzfWz?=
 =?us-ascii?Q?VluAb6mPrx2s+ZUVno+vsIJungHKIdGg+Czuz7i3d7ceno4xWN0eQABKPmw6?=
 =?us-ascii?Q?jlirdf/PjQZUs+i18sjX5WI354JNwjUunQkvzoukQi6w44DOM5j2gbCq9Gej?=
 =?us-ascii?Q?edhs5Wd31MSHIE//EXHqXUOwEpaMF3P7S+XZP//EBeHmji3/HW+yWna/Z+8J?=
 =?us-ascii?Q?YQlEv/kSINrxmlDZdrI35iJkvl3n+WOvEMmiP/oxwvj9C/PfcItZ1Y4iieKx?=
 =?us-ascii?Q?bOeadUs8xV1ajC3Dh5ppbohTkFP/h2V+8xgNsTjIh+VDsG2yeJCQmE+ZwGkK?=
 =?us-ascii?Q?jh8+gZJewAdF72qC2oBhpkx6guoGHqcT9AX/6AqodkGe4ctUZVaN7xFdgvN3?=
 =?us-ascii?Q?LARm6W0Evazg8D9hUTkoONTSTGiuNDCkL57wXDkRNb5LYR+ulBWyhfDbdCzb?=
 =?us-ascii?Q?5H5HXhVABGqyCrYH/DxT1vH5c05BKiBIT4x43i/OQgCksutuw/DZIfHbDm8k?=
 =?us-ascii?Q?0Vy2hf9GIgfP4u9DaEMh2xleQ6tB9mX6n06MpIos7hb6d8xd+MW1NVAgNwRE?=
 =?us-ascii?Q?HDi5F1AW39aNsx6qVC45RPeg+shRNPDlfTkUX1hwSUxGebB3gdftYPGw29TP?=
 =?us-ascii?Q?vnA2wfbD7F7fzO0Iwt9DOkPm8B7lwoxcr6F/wAmyHv68b7SvXpAcC4V11ufa?=
 =?us-ascii?Q?+GOqU65Ci8z/oQjm/bhCj7t9Gl2OtSvVrrKrjmYpI15ZT3AbQfVyVABsaX1x?=
 =?us-ascii?Q?xwwzm2ugLN1GJDQeG6+FvTtBMN0IAZ37G2kpcVn4QDI7QfzDfC0013JB8f+u?=
 =?us-ascii?Q?CQyr9e+QvJzbJPGBuFAznnB1Vhg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1a4fd7-cb7d-491b-2d06-08d9e609066f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 05:01:09.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kc9p1NLwX9aM9LEeAgRL8VKMAm6JBSWe1lvuVxbOMO6tAltsn3nZGwABiZNFIM/o2zSJ2jAjGz0HCOmneXVeuDCSufu7vkYdJsVMoJzBTLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020023
X-Proofpoint-GUID: hIukWpFr4lFud71Iu0CDu4m3p3_Q2GD0
X-Proofpoint-ORIG-GUID: hIukWpFr4lFud71Iu0CDu4m3p3_Q2GD0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 11:11:11PM +0000, Colin Ian King wrote:
> The variable plane_fmt is being initialized with a value that is never
> read, it is being re-assigned a new value on each iteration of a for
> loop. The initialization is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index f332beb06d51..b334bbb2e682 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -681,7 +681,7 @@ static int mtk_jpeg_buf_prepare(struct vb2_buffer *vb)
>  {
>  	struct mtk_jpeg_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
>  	struct mtk_jpeg_q_data *q_data = NULL;
> -	struct v4l2_plane_pix_format plane_fmt = {};
> +	struct v4l2_plane_pix_format plane_fmt;

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

This one is fine, but keep in mind that the other reason people do = {}
assignments is to zero out struct holes.  The assignment inside the loop
will not do that.

regards,
dan carpenter

