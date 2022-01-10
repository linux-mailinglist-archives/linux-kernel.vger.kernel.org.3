Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A2F489509
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiAJJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:17:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44148 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242762AbiAJJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:17:57 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A8SQ6C007008;
        Mon, 10 Jan 2022 09:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=f6OtsCKmPe86LlNsiniC3xpNZiIT41HptP8/3/1Ds4w=;
 b=MvlUaaSQPkJ2laPZiMGvO48yHJeODUx/TTmTodyNFsmPjAwejn3IWmIHeGHockXfZptF
 5FCDI//1uBiscLin6B3pmSDoAMYMKmHCGWD6rGQm7p2k1Kxp70sk22mY2aKPaTRL5Q2N
 rSBfVmJ7MwEX3Mdf9yJ/b521Fv3F9qNKhmU8x+ClUN3ccnLfeUMaeoCQp8OpfHSCN6qn
 Y7vWo1rxdv4bU5C60taJ0L8QL6XbUETVVT4rBE9qB7ctOHUDbZEpx0cQ3eQ4cFvqzjzT
 Yb56scZ7qox2aE28g/UkHc+VbLgUfNVmyAPGD6sbjYztZ4vvaaBAtvtobOUVkkw/OTIL lQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df1d2tkqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 09:17:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A9C4pF032720;
        Mon, 10 Jan 2022 09:17:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3deyqv1k9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 09:17:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO6omma4+M0pn2EeJIO5tjALN+tTaCmP4HiCWKTEzqHfAxmiC1VOCg2otb2NcL7XpTeviY7XCVtpMRgnroICkBD7INgiiuOZj4sE4v4b8JgjnfFPQ8mEv1dOiW3/ObVPV3ZvsxxBj/pD8QU4gJI8oDKi28y7xtpPJ69ajp59KGTbVAa75DJ35/dKkEK/P5BLh0zeUYgIe6WFdUh2ZT4B+MvEQfBNVyj6zRl/adTJjVBKhjbF+IK7MIkle57P1QS7QUsrjXNuA8zLrcnVc2HSEZgNsOaT00TZAJstARGseqbOy7IzTl0bQIacy3OSzqz/jtFh5pwvk8Jn4DdNX9Ejeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6OtsCKmPe86LlNsiniC3xpNZiIT41HptP8/3/1Ds4w=;
 b=mtZfyVM8WQMyWgexkC0HiiE3wU5jJYrTPpMsOSmv4C7RAir1KQSt5EfCqx2MFnx2CCUrHKoqiLfbepDjL/bgsOPwbeOLWJVzUwatc8vzIG20fcteneNw2C2KmUXM1ZTTugaATzrGOme0GuFlD9Wu1OL24rsTv/dROEeYIbQcskIlGBuDsZLNc3+lfION24EDGBKWAlbi7KA5esCat23fLZ1g4HIwkiqDGuJkrEYOyjJwo5qp6fVtU1yNsOIVr6XM2Gso93d1oG2K8yI6PzLSmJqd/cotkFuc/UVY5C6VT84D0iAVhW71ShU1QnnOIWh/xVY+50MDwYVy2LSDLugmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6OtsCKmPe86LlNsiniC3xpNZiIT41HptP8/3/1Ds4w=;
 b=yHtLXO72rq2+BW977lJDKqdqx0Cu28qOZ4+68/W5HkNrYdtrOzuK4v+nNWEKM96MMhIH9W1djf+b1KksWTon4v9P284PclAfNiBNCJFt12kgeeqrWs7rHWHNKdNBruyXFBopK9ZpbdMHgTKZmnAo8Lh2bNJqwZQ857rd9StKfT8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1422.namprd10.prod.outlook.com
 (2603:10b6:300:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 09:17:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 09:17:43 +0000
Date:   Mon, 10 Jan 2022 12:17:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: enforce tx_cfg to be set before any
 message can be sent
Message-ID: <20220110091723.GB1951@kadam>
References: <20220108222652.GA11883@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108222652.GA11883@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bfa2e81-926b-4bab-2039-08d9d41a0ec1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1422:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1422F91A25DC497374E4733D8E509@MWHPR10MB1422.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z93jC+dGYK/nqbSwTN0Thx+fxI8GX4hkLgheAkozjdujKIsLOrLtNYIpLGWEWJxtNvR6g7J8e0w8KqQIapYQVSZ1o2k9jt8QhIuxrsV0OJTzPFRHbMElfVtBtjtH8z3iHyndmKe7ZHVdef+wPPJs1dMfxRL8WSRTe97xHxttApLADi109H5T8hRHO6eG7g1C+4I82cwLUjo1xT0HgTD/lpB+PPn21NoNCDjVGWNjGpi1RaHzqSdxmZVeTzf5Fs3PxvtrE/U++UGw+cRGcmZTwuez8tvZATDKCvwxkLsUCQHL4qL9UHCxRYQvJ3hFoiICcZghuvvaLy+FJDLDCZW5ud4mChvM+CmIOkUIh1XxTOD23d58vOWZd+oBAWwqp0l86Y4/MADBmMlALgAkitoue04FuOIUjRvM0H0ub4X9dEBEWik23gQtVK70VTAmi4itIjxA3hfBatYjWan46bYALc4VqK76kM6AUMDHannypo5ZJMvSTP4Njlxg82Hn3r6gyIS/3QPt7BEJu1GzDUrxfYZwnpIJ4E5l9nIECSrJd4SPzIZvE4GVKfA99YVplaLTANQCoCCKwXKDISPN67EstK7rFjjxl/Ew2+LGWl5g+O2VIddS2AeZ/JUwNbpl2M9k4afhGWu1/ttlm4vDykIRSQwQXStAV0fWDc0/uuKZ2V8zjGWZWJQFY3DBH72e1uxJdaZerQZ/SY3JU0+cFZfpFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(44832011)(86362001)(508600001)(316002)(38350700002)(26005)(52116002)(1076003)(66946007)(5660300002)(9686003)(6666004)(66556008)(6512007)(66476007)(4326008)(33716001)(38100700002)(8936002)(6916009)(6486002)(83380400001)(186003)(6506007)(2906002)(33656002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4XIQXQ4Dm3rk2TjPIozquDOCoIxNE2T/1zs+yXPOWW7PoLblIO1TH7N/F1PV?=
 =?us-ascii?Q?T3kWdAjArQFlydF+jKbVMPdO0SPzX7/vPYhcux+q04V3R/McqFkHbUbyP0Zh?=
 =?us-ascii?Q?ICb4I/u6+hqvYVfBL5Q1WqPkUqnNRPkukCMQNq5leZWgEoDA+nM6X0QVfT+c?=
 =?us-ascii?Q?fm3FtsDZt3misJEjT7nmHSdLyel/8QwIEr4H9JA0swIuJpbD8xtLN60/VVyZ?=
 =?us-ascii?Q?d/6IIl2eKiq3SieZPsmu9oCIQJgLNiiCfJgMsb72OzOWju+pgVjnoDikSJXJ?=
 =?us-ascii?Q?jxgvBnwWbsifzRpXN4psu0YQH6ezZo9auQpvnQALRC02ZVbpkr8EUM76stWt?=
 =?us-ascii?Q?JYFu3cAQndc0QunYNxQOXHCSmCD1bKeJPBTNhNuBGkHwqwerUybReo0SMbsZ?=
 =?us-ascii?Q?W9Lp1aJon17UHwmDdDFGSonQkrhL2vrek/nv4fa/rGpRnwXBq7kqTuqfE8OL?=
 =?us-ascii?Q?GJdxYR3aZA31bFpsS1RZzydQfkWAZbqzbjxmdQSgcfS8PND6bpxvosuJ0qgf?=
 =?us-ascii?Q?+N19ktz+A91eKnpRJVKydP1tdDOH5aPm+tB8eeHkVF4IOMBhCfSF8ZZmKmve?=
 =?us-ascii?Q?hmh5wK+9vCeci4lt8/qNJty+AMV5KRvjEIM099vENBw+Uh0v48V6u6WqTX5W?=
 =?us-ascii?Q?JCKfIXpIdfa4TFTmGlU6jS91kOrquQcA7BWXzwotVh+ECr4AD73lMm2TQrtG?=
 =?us-ascii?Q?4e/QSfEmGa2yf14BYGCWxh49ct3+JNqLh+eT+uznII/binwbd9Y/uMtbNw3G?=
 =?us-ascii?Q?LjFf6Lpb5T/LHDUtMyWE/gSuMkSCsB3l44XGEa7D9AikpnkQfvVa4bryRXdd?=
 =?us-ascii?Q?1fe8fg7eUXsXV78SepdxJajqCjL7JrzW/Q7tJ1FZqXu6H+cn9Z+TvKOEGSKg?=
 =?us-ascii?Q?HnpDGT4LdTte6UCgzYYIIkYf3Lm6c34yJkaPhue+6DRBocJwDW81CgsBybcO?=
 =?us-ascii?Q?7ng214yX+82DdGK7EXU6mw7ZQFag+pKX0GZ7cptci7bE78UVjQR9awPR/AIV?=
 =?us-ascii?Q?ndCXEtLFIANWCNFSiG3F0P5/bjEqr50UAV1g4ID6c1d6uvrHKqtXjtlzNMMB?=
 =?us-ascii?Q?TyohDUTZsrLsylPGOsRQfSQn8CkRrAy79yxi3uqWLpUfVO84CRHwUVSfHv5p?=
 =?us-ascii?Q?kYCproz7vlBy+X1kinUi7Y8G7+g68uEQ2w26qOYM2B6XsIATXpMtmvlx/KXc?=
 =?us-ascii?Q?BjjrRNGRtpwHvolG1bkZgldJhhG92Hk3emaH5EkwvHGjXp4rm/PsMjyC/txU?=
 =?us-ascii?Q?dXWmBaJ1UucIvcUZTNzcxWnTg2nuedGH17OqF7mV3hPUgCeaiFqJizZ0OtWa?=
 =?us-ascii?Q?cKCcgz10WoVK1PWGjl4KIzOr9bw0Z3Pmz28tmksb1GnMz7FnapxOVGj7Pt82?=
 =?us-ascii?Q?MEfGp79L5VUJrR80Men4K7doA7LTwCMPbTb7a+kyWgomt7UgSaZUsvzQLutR?=
 =?us-ascii?Q?T7Hr5VrykZaV3V0dQGDR/SUw8iBT4DDHqoh0SJuOVOZFDdeJNj/ij8w9ZADH?=
 =?us-ascii?Q?NKnvWAsOBIVAb9X7wq0j8NdIWc4HR0SLJLQ8n4TQhi7ZohD1HqzfMoY9pz4p?=
 =?us-ascii?Q?K/6Uh+Akribu3dK+R4AMx4aQM9YnU0Nr0u2hsWBhuNTfiO64idBbzewBCAoZ?=
 =?us-ascii?Q?j2cNALN+nIIFl476nPCCJLTGaQuRop3HLL2ra3lmKC42jG9DXe69PTDsmAXt?=
 =?us-ascii?Q?TMGlAg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfa2e81-926b-4bab-2039-08d9d41a0ec1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:17:43.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZIAQTh/sSzwgnE/RtveKfzup7UWA2Obta+80ucie+LFR32B20SAK/OXMWO977txUZXk6jwvfuxwABX90GC78lm3qqAs3S+a1bvBtnDI9Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1422
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100065
X-Proofpoint-GUID: 1q3VZ7ghbXfNWyy4q-c1k7aEWoI0Go5y
X-Proofpoint-ORIG-GUID: 1q3VZ7ghbXfNWyy4q-c1k7aEWoI0Go5y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems reasonable.

On Sun, Jan 09, 2022 at 11:26:52AM +1300, Paulo Miguel Almeida wrote:
> meta-comments:
> - I'm not entirely sure if -EPERM is the best error code to return here,
>   I'm taking suggestions

Better to just return -EINVAL.

> ---
>  drivers/staging/pi433/pi433_if.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 051c9052aeeb..3e9913f4bc7d 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -108,6 +108,9 @@ struct pi433_device {
>  struct pi433_instance {
>  	struct pi433_device	*device;
>  	struct pi433_tx_cfg	tx_cfg;
> +
> +	/* control flags */
> +	bool			tx_cfg_initialized;
>  };
>  
>  /*-------------------------------------------------------------------------*/
> @@ -823,6 +826,16 @@ pi433_write(struct file *filp, const char __user *buf,
>  	if (count > MAX_MSG_SIZE)
>  		return -EMSGSIZE;
>  
> +	/*
> +	 * check if tx_cfg has been initialized otherwise we won't be able to
> +	 * config the RF trasmitter correctly due to invalid settings
> +	 */
> +	if (!instance->tx_cfg_initialized) {
> +		dev_dbg(device->dev,
> +			"write: failed due to uninitialized tx_cfg");

Use dev_notice_once() or similar.  Maybe "unconfigured" instead of
uninitialized?

	dev_notice_once(device->dev,
			"write: failed due to unconfigured tx_cfg (see PI433_IOC_WR_TX_CFG)");


> +		return -EPERM;
> +	}
> +
>  	/*
>  	 * write the following sequence into fifo:
>  	 * - tx_cfg
> @@ -897,6 +910,7 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			return -EFAULT;
>  		mutex_lock(&device->tx_fifo_lock);
>  		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
> +		instance->tx_cfg_initialized = true;
>  		mutex_unlock(&device->tx_fifo_lock);
>  		break;
>  	case PI433_IOC_RD_RX_CFG:
> @@ -950,7 +964,7 @@ static int pi433_open(struct inode *inode, struct file *filp)
>  	/* setup instance data*/
>  	instance->device = device;
>  	instance->tx_cfg.bit_rate = 4711;

This is sort of pointless because it can't work until that gets over
written.


> -	// TODO: fill instance->tx_cfg;
> +	instance->tx_cfg_initialized = false;

kzalloc() will already set this to false.

regards,
dan carpenter

