Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9448D1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiAMElp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 23:41:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18790 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232608AbiAMEln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 23:41:43 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D1GjZd009503;
        Thu, 13 Jan 2022 04:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+RpZV7gxkOO7NzYJiaYTO/CBf2Hudf6MXSk/0VEgVoU=;
 b=WboAGTv21mvIiSxXcTMbpZHFwFT+3qmpALlKs0XrxCI9oTN4PjE5fLgyam0X3lCS1CGA
 6tUkzVxMoSTJGSPX8EpLsUBcTfvEUMj1+pxeFlPaZ9RFe6IrnAHZhQOskZwn83IT+yFy
 2YLEuv3klZbji65l9P/HbPipKeckWk/EmoCCOtUryHnvyonZiDrRJrWV+cwmBIA1r68E
 DQk94Pw6pU/UhC4OsshXcv8bXYv+bdAJ4lfuXCAZQTlRd+3TtRFarf9uIY2ke9YqgYn7
 isyf+BUyI4oEWi/gIr95gFJqb3cdz/7Lm1d1GjlLpguLM9MaIAHaN5vS+jVzPmWQpPBp bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx83cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 04:41:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D4ZhpU140702;
        Thu, 13 Jan 2022 04:41:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3020.oracle.com with ESMTP id 3df42quha6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 04:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULfJC7FPnjZqqjUMLAkARiWD20hRS6h8gYjpRCIrZkdjYJcnU9vDEjVKzkUnNGrJw2bLK9bKvIKan4Jzvsk9x7gQhhuUom/t1oTkR08ccfXsVX/JMyCpCVWt278zFxRJDEYOcx6Ol4K4Kx0Fj/ZfAVYMbbp7DC/Dd1EubVBgNzRdLECQjZV9rxQd3+tPifyoukYLxfWxiF+b3MwNgiwPwe577wPO0/r8qL0o4GjdtwF0gjNrx3PYhi5ITUvEvqOSgqAvnYmtTFk6LCGpWBBUEfKD/GbNc1/fusQ87QHNQiFmPd3PTnFXMDK28p7RgsbZvd0UchMvb1WuOw//zf54Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RpZV7gxkOO7NzYJiaYTO/CBf2Hudf6MXSk/0VEgVoU=;
 b=MNqUgr0/Ykwq21IGploFHY2yYCB/tl+y8ok8bRVcQbdRBTSrtnQkUZSrfc+yIEnib5XeUQAlxcmVAUyzM8SFdnU/kiUgZVr2aYiXq8tOKN9zCcgnABM4+HhwPuO4sW0nkRAaiw6l6sSzd3viH8+kFSPHZ52sMNIzsQgtG544z87IWBg7g84PuOj0wf/YIqSPXxnuO5tHHQM+HEKVnKW90oQtP3WCUf5x5SkJFfhXcLOxqGv4RycZhkLgdp6Y4wacH2VbsYW6Fvdq+w4PsTcvVmPCLBFczJTPz3B7dE3nsDpXV/DXhawTJeKkVQzXUG6GD2jdZwAs52zR006GKs1Hzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RpZV7gxkOO7NzYJiaYTO/CBf2Hudf6MXSk/0VEgVoU=;
 b=Poy7F+3LhvnI27H8fQwaiVYcwctch8wb2CBULVJxoQ1dNsB/Mw6S7d1I6ouAYlPW+UuRimUPPAtnsCBm/ivFywahNsMqKQjBmBCvS7vHrL1oo9jvByaA4VOCF1NZ9evh0+sCjdpOD8rRXGWGoPRp3tezSxoRrrbrZNvm5XOTkNU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2366.namprd10.prod.outlook.com
 (2603:10b6:301:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 04:41:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 04:41:26 +0000
Date:   Thu, 13 Jan 2022 07:41:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Check for NULL header value
Message-ID: <20220113044103.GN1978@kadam>
References: <20220113002001.3498383-1-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113002001.3498383-1-keescook@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 217ea796-f479-489e-ae68-08d9d64ef535
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2366:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2366C9DA530FD732320916A28E539@MWHPR1001MB2366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z479WQq1905k/ejraWV2Z/RaDFikCc0eujJUUjecBISUYRPy3P4umJs9hnpmEphOhWS3v0g8phDxpBRl2HNxTNxM4CqIt2yY86VoXTSQvw6DwKdu4DrxKl2ESmasYcdO1NpsKA5kru36emba7f7XJ6/68Lr2PEVf1n9/C8g5LlO4kAAWaKS+xEH+S/lNUnlamx0rcANM3owagH9a1E9eBgz3acmGfAt6oFZCSvMV4Zdx1Z4geSxARG1x+2zPYcCv8tzW59J6Tsn20sLOBFnXHss9+Flmr0HWWxCJt0XJtVu48lWSIdcfloG/lBhMFokSVeHFpv9XXYlG1Nt736zNYIquMUvRi0XxAGJWZWHzwbcbZous+tlU0sBdiqFGd5RNxaMzDQbbcOi9TRPP0smhPs6PYJNWzdjJ4CeJ/BUKPxixvuM4Xb4oZF2RFdGKkqIQAsGI8702QTpRo8jNstrn6zn/KYYWYChhWp80/b+SL5nnYV1zso3VvMv6uqXL7eI4M7iDkBH1ZRE3pv+BhCPDcEbO4VNnYczopnWC5hfpS5TBzDnP7h0oioiIWoXHhMOFVxQ4E9AjLG/Z76847Ee3rBHdTmDAob4eTlbHZRw9KDLKnby0AAPVDI/6u48AUUZVIAC579AJwEMsfTnA7qQy41/05+HME6BFiiPb350/5AlAseBNhKLgIAgmY5tCEggFof7PPiRrDaBA/wUA1QzSYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33656002)(66556008)(26005)(316002)(86362001)(7416002)(1076003)(4326008)(66946007)(186003)(54906003)(52116002)(6506007)(66476007)(83380400001)(38350700002)(5660300002)(6486002)(6666004)(9686003)(508600001)(6512007)(8936002)(44832011)(6916009)(33716001)(8676002)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMxEqjY0fLjfM7OZFJ9/7gAYVc6ZYDLWUaqcV8EClcUnQ9MY4NtIjPHu2cTV?=
 =?us-ascii?Q?F0Dzsm58EQb6XfGI18VcFBMkaZhA4hj/GB3SH2vqO1wWJG7jq9TOlN3D7TiB?=
 =?us-ascii?Q?R3XSfVO+teG7ivIld2SMI+/huwCIz7dvmDwhe9eqF2qYe3274qmEzDdJOH0u?=
 =?us-ascii?Q?ThNKsNwlP9uUCBK7jSAWpEbZGh3fE1C9xCzNVthnSfOa8U5i+3Zc2FaSzDwE?=
 =?us-ascii?Q?WrsTUG294uMEZoVfw6aSq3qN+e/M8Sr9x/X+ttMn/I3nVNkbtpUKQeUiGVAp?=
 =?us-ascii?Q?7uzrPAduyiFnlReQxF5JFx9RwML3Jz+F27ho6wIZgu6rGCXLEbHAADfDoNTq?=
 =?us-ascii?Q?tGywD/+/TCdtbwF+x1f2DHVxAz4IcG5ZLysAX4S2jtaa1dTMKyLBHs8//EPv?=
 =?us-ascii?Q?5M8pW79b2cIGCkuEesd03dBWaGccaeRleCfeydlF3QiF115QuaUBLvFEkHQF?=
 =?us-ascii?Q?RBHX3akIW6XOKUq42N0ZN4HOg6VRW6xolNQ2rQUV9bYWyJztWpJwS1koMW5a?=
 =?us-ascii?Q?A/6qMHwPR+NPyzeFOgICb2aWqv1Y/oQcqU6Lk18ndxlzeyWpJCnqDXKb0m3r?=
 =?us-ascii?Q?C81n2pj9mpOh/1kDjjCelHeAvVIbFYmHtavonkvozd5KiYgcTOQdVW4dJsYr?=
 =?us-ascii?Q?EhTcfT5pOEZ96Tz/OPywjrW02Z+4bDKW9LZ0RPnvsvFuI3xvO6nHq5/bLL0u?=
 =?us-ascii?Q?uR9Czp0RtcwIOlCLzScbuha4yHlNk1HNBZ3avsPRXzvHUJ8VjxwTpAwqHOOA?=
 =?us-ascii?Q?b5eV9sEx+0lfPkDoGUxs3WGo+Y/eDdFKXq8vtn92g/ltPz9WOeTqxbn+mNUI?=
 =?us-ascii?Q?2vAi9Oa8jZs3gLS9sxIILspHhBJIZfRA7Xh8HqtMhQn/ul/V+Q04EkEGHaKl?=
 =?us-ascii?Q?eYHqeEEB1MB3U3VPmtDzaTexHP8B2CIDHpPU/R8lUNLC98vhlnQ5K3TuVP42?=
 =?us-ascii?Q?N/CjwVE8ePou7ui12VcTJKnSMoe6ie3GYSqc5xm46m6o6S55r2t0WTiWFL0M?=
 =?us-ascii?Q?E0dkZ03J1HWGAeiBMmzFm6GmGJPPGqsBiAV2dGhHGGDsUJYHe+xiqlqZ2V+a?=
 =?us-ascii?Q?4MHKJT7yy84R1ZqgXzdUvzyvnsx0dVnWBCFcV64B0sALW0idwvzKliIuVVVw?=
 =?us-ascii?Q?yhrELllDyCNhMxE9zJkJaq+icKtLgYDYJNjFSMTQKa8PddxPIlqxJQ8uv88a?=
 =?us-ascii?Q?L/aZ5ZIB62qNDJowsxQpNoEHR4+0Oyy+mPbK4z/hpLhILQP1tRN20IJQjHPV?=
 =?us-ascii?Q?vuYVIJOO4cstRhbTp2YrrlfsQRbleEQbgH4vWCGSDK8cm3eTOja50YfCyZZ7?=
 =?us-ascii?Q?9pCD+CleVYccp9egeU0x44UmRjK0D2FCmpoQDr7Pjn/ZFZsUBNCf6Ol79KwO?=
 =?us-ascii?Q?Y84Ex0cVlGRRS1IbYBKCupALqqvUqodUXSStQWoWA22P1nfLIZkl+vjQinYv?=
 =?us-ascii?Q?rHj1BFEA+BQ4kh/3EGtVfyJxbgqoVn9StI3SgnREUwXKk8ZCNq8lW3PhcFTz?=
 =?us-ascii?Q?v+8q75aNWR+vHR0MiPFYoufNmNgtj49ZTzkUddjm2Hype+J7/GtPB6DVBss0?=
 =?us-ascii?Q?a6dDCHtUSUKQv64GFsW7bMJvsYDl2234YiDAml9EEZrskBl9j1MJq7L4WBzy?=
 =?us-ascii?Q?Cw8KAhSpEFDyrhQ0MUV4/cQ2dG9gpUKE0wiXKfAvyfwHpwiYAI5oESVU9AxQ?=
 =?us-ascii?Q?2aHMQg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217ea796-f479-489e-ae68-08d9d64ef535
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 04:41:26.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77sf3z15xm05/vDpOfmuCe7MB00JeUKM3vFO0oPO3IFg5R7Iz/mGqQuvq30mzc7ve4VuqKDtwWA0A9qqvNzCCJZ2uu38V7akCi+PqnmHMO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2366
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130021
X-Proofpoint-GUID: V_Vc5jC9yCeYXHUGR0blzuItVuc7jHyM
X-Proofpoint-ORIG-GUID: V_Vc5jC9yCeYXHUGR0blzuItVuc7jHyM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 04:20:01PM -0800, Kees Cook wrote:
> When building with -Warray-bounds, the following warning is emitted:
> 
> In file included from ./include/linux/string.h:253,
>                  from ./arch/x86/include/asm/page_32.h:22,
>                  from ./arch/x86/include/asm/page.h:14,
>                  from ./arch/x86/include/asm/thread_info.h:12,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/rcupdate.h:27,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/sched/signal.h:5,
>                  from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
>                  from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
> In function 'memcpy',
>     inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
> ./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
>    41 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> 
> This is because the compiler sees it is possible for "ptr" to be a NULL
> value,

It's not really possible though.  I bet it's just saying that because of
the NULL check in get_recvframe_data().  Meanwhile we already have
dereferenced "precvframe" so GCC should know that the NULL check can
never be true.

> and concludes that it has zero size and attempts to copy to it
> would overflow. Instead, detect the NULL return and error out early.
> 
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michael Straube <straube.linux@gmail.com>
> Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 41bfca549c64..61135c49322b 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -1513,6 +1513,9 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
>  	u8 *ptr = get_recvframe_data(precvframe) ; /*  point to frame_ctrl field */
>  	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
>  
> +	if (!ptr)
> +		return _FAIL;
> +

Can we put a comment to say /* Silence GCC false positive with -Warray-bounds */

We should have a standard comment so that we can grep for this ten years
from now an remove any outdated work arounds.

regards,
dan carpenter

