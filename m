Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1998646FE63
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbhLJKJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:09:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48874 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239744AbhLJKI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:08:59 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BA7jWRm025248;
        Fri, 10 Dec 2021 10:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XLNjuMSOIha5npr56ljrGgTlJ1LfSzaWEc+oIVnLLzs=;
 b=mtFOBdlW4n16ieLblqPjYMnIaRx31yaAO5rI6zK+Ml0o4IVaIayszlMk6enhtwa67sIb
 7s2aOTV1hp8j999+TVS90eD+EnMBczKkSVR+Dvkzr5wScoFTUZvd4VKLtvLyQsBdFAnM
 qwPSnPVHNy/dMruRP6zJIYXHD831ZfP5TAwgdv/0WSV+RXTwL3Bjq5xm0PAc/QoVXMN2
 oIwxzIrwjkEV9W5ghTwlTpPk0AWeb8ipgVpr6shM9BeuHhkl0vKhEn3Dy2iyyEdQXKJZ
 JC3WuBiicgVbcTQ7M4GX8njgPIJ90xkv7Q+rrgmlfuKFAhOcNAUHyYCTDQHmDHZSariV Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctua7nbnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 10:05:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAA0q3h174043;
        Fri, 10 Dec 2021 10:05:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 3cr1su1eeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 10:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNu1b4/B/0ghNi8E97jr/Gi5P5Uwhq3BTqcWij17bX5lnsiOznOw/piofSdy9/ZJA26MpV8w699q59TIunDJEqhP0zrdgI7VKsOlkOrAOBoXD63x+ih7cfoJPvV7QGhpt/GS24kETmsusHOlde/X8A2mLZjkG8cIWhpLB20zYS7OlFdExfR2tiyB/KDRjT8TUvM6QZv/DMiJ8CeSeskGBrYIv1b4zGhA4e42CUTUDzymrTdtT6+kyWtrakquQ6vnaH1w/qareZVp3V7ziyP9Bw7nxOUlLeV3i+1TDRp98eFnoYUom6E1MGS0f5Pfwcdhdc3nYsmSDtmTSq6UmJOU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLNjuMSOIha5npr56ljrGgTlJ1LfSzaWEc+oIVnLLzs=;
 b=aGPtGl/2gdhm2AJvM58P1PP0TOjDE+Useao+ule9swU7IAA55xE2Bfuyg+cPFS+mz2CE4javIOC8gv3eTdjdG91CaJPT6m1aLSoOOllpG4WUfpSlLDTKNa6nLADvBRGKS0hRWdCS/HtEFAitp9pMwBlWTHk2yEsZGPVUzEowHmN1awQmx3wmuACVpHG+Gd/FmQTqjWhdFF0IGShihejfoNzwTMm1/zUTFWMWXa3tSy7hVa5sIIA37N5/dSZl5VQITP5s4oy+jJJwz9t5ITHew7s8L/xjBWANOTxhik0hB1R+YAQRCFG3VYdyujOorojvDkV/1iNa86aZOllx5+pC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLNjuMSOIha5npr56ljrGgTlJ1LfSzaWEc+oIVnLLzs=;
 b=z9O8BJgfz19R+LEUa+YJ/vzfMzZqeud+XkNRXH/Rl5WxLbR0X2HDDtj1MyX4Papey8HDPmBLiKWUQ+Ws7ZMXBvGzW71/7UXeJ4KX5lZhg0vIctZPcKgUB/bV8trmk9ua5MI50m1XGnFOLM9+c02Ho3N+Bf3pWlyZO37l6HT1wps=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1293.namprd10.prod.outlook.com
 (2603:10b6:300:21::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 10:05:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 10:05:12 +0000
Date:   Fri, 10 Dec 2021 13:04:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] staging: r8188eu: Use strndup_user instead of
 kmalloc/copy_from_user
Message-ID: <20211210100450.GN1956@kadam>
References: <20211210093701.55559-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210093701.55559-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 10:05:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b956862-2327-4036-305f-08d9bbc48e1a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1293:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1293FAB5D800B102385CDB408E719@MWHPR10MB1293.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0D/Eb4DPh278jcxAa4W4eyMR3osDN7UNeal3F79s6Xrey382LwVvvwUVjJ6FkSjPZj2x0D9h0lwednrVM5tlFCYXEtHyf4VT+NG1QFqbfczTIrpH7FDaOvZo7MVa18/HXKbqcxidDXmFsthPFqce7FIz+kexDReP781nQuUMBYEkXe7cjkYWowRk/CoaPI+j7pFEy/8T1nNvdfmHpjGhSRpE76ulXJQsTPdfIB3MEuuwuhfcgFMj0oZ1m1VKPiXMiJLGS3OOEiX7h7A4ao2D+EQTaSwYsu23Lc1y+nzNWniu9rc7HCZXug4lFpmhFBSYh2LEeLG7sEur51SfB+4eKVw8M6P2vI46icp/U8oonq60Q6xi5Uejo0E0MruokRGAg61lnuyAEJYsWFx3NPkEAhuTqqyybB5iWvYOkKXd1FptT5Y/ItHri8XCz4nEJs5OxnvHEaN1kcH3avF20K2BZOo827Bb3UpBqTaTKYqZuABADXlV8KZB5fuIhDXpOtUkdPTdWuMBHwN0sHdVpTZADlf35410trKUaCVd5ZL1lGjIOn3iG29yxFXtGRvGhEBCyqnCB0ygtB2ozvtyx3Fq2oOiuBP8+2meUzRrtgPFi9pE3jL9PuHw9W4cHC86w2hil+dmkuhShmNBKPo9H+gdzuGJ61kvIHU7b4jgcNeZbWewCzmJ5LADJBWy4EnJ4IQkm21T0U3mOnt9XY6jrr4KGZQkl82ILr4NE85dPhfqc4Zx86M4SWnjZi1F++XWURwe+aLs1VqCQW987wtQTqJ39eRcPu5HsTvOOjejmboArsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(33656002)(508600001)(86362001)(6916009)(1076003)(9686003)(6666004)(2906002)(316002)(83380400001)(55016003)(44832011)(956004)(186003)(66476007)(66556008)(6496006)(66946007)(33716001)(26005)(52116002)(5660300002)(38100700002)(4326008)(38350700002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdoOnqJ0RUlWDHWxvnrY/3zHVCbQPGrqDSsrwF36lDxZpiUmEwrEUCxLuDgT?=
 =?us-ascii?Q?j1dLbT6hFQ0S5AMacoLWZUqBz+wKj3SqCBFAvK5Bw+QjAq7lsHCEdyKMXui3?=
 =?us-ascii?Q?OYpYyh98B5guSMTN8WPJsiRzljqMbE82Nx8Dw9OUiYO1eWmmmW2La/1OUdoD?=
 =?us-ascii?Q?AhfwDiaGwR+7Uxnb+LtPUsXPYkMr72oBAodaHSe4V2FbIR4VnTOsyEj7F9aE?=
 =?us-ascii?Q?UZKkehTuHFRpxbyFrEQr2OtgTP1Y3Qc0MFyiqb4MrM5RTfmJ299kPLzJcbWD?=
 =?us-ascii?Q?z1S+1azknoM0JHUYNqhXbsFFY2GtnwDG0MNvhduS66+rGNinmZ7uquAFUo6V?=
 =?us-ascii?Q?HJdLhU15C5GpFg33HpFMsH0oizhnCAuTK4Xsn728Xx/o7ygeC/x5DpxJ/7bE?=
 =?us-ascii?Q?k71oHbqzaypbwn3EDBZ1lO26u/5WWN1gQe943kjUlCchKgkGk9qG9zaY2/iw?=
 =?us-ascii?Q?rFUyoQtvDrYSP5ZxG4BVSXUkDjGObT5kTLUZyZ3vWIE4PimYBSCL7ZF5X4Cm?=
 =?us-ascii?Q?tfMn4D8Fwcddue1k06+IWG1dFO/GOgNWSVBppblbOlWyd/z/HF/M/TdRfQY0?=
 =?us-ascii?Q?4paXmtVFlff5nlWGyUben7o0ehHRTET/mEu+SfVk18YiGdaaq3gTbVH26MlR?=
 =?us-ascii?Q?89AjQ1wg0CnervsEA8iCh+m6T7yfgQXRhB1eNCSebxDgbJyKfXpV7rDq1JJv?=
 =?us-ascii?Q?fzbiSeO8/UPE8a7VkIw70nxXXEFR2e7IXHyIfLg/GI71fun/1vGsF+nvQ+yC?=
 =?us-ascii?Q?f047abP3my5Tuv2w5d1yDff9/NE3IoEM3nBwu/HIFUkbPx1jflesFwjRPRBq?=
 =?us-ascii?Q?xVubNFlcdNhz33Hla3HxIf82zLsTisisc51DMScgidCRGRM75GI4mBebw141?=
 =?us-ascii?Q?hG/rag/d5WQeQX27FQFLQb4WLDgMkFUoe2J64Cn3OMspvvkggmwW2sWXZemn?=
 =?us-ascii?Q?+f039D4WumUPiY29BW+CyEdWgUKOkr4/qlLa4wClaSBcR+algSbxjR0H6786?=
 =?us-ascii?Q?MeOgZS8IaCYTzPdqKa8ece6xxvCrh9u3w+Sqpak7SLfOnyCHykfpofEdizK5?=
 =?us-ascii?Q?LMUuQk+huV+ekasqnJdYk/1K2ZmXGID8UOqo9nLCd/6EBkiMfuyFjze+I8In?=
 =?us-ascii?Q?G6VXyoNgkDTTt6Fi+0K0RLumSrTugZn8rrETeKQve5t8qVksyVUeJoq8cHLa?=
 =?us-ascii?Q?vLA4AsCvpggeYikGlwxEvNPrTIfIIWKCnjxXc3cr1A3p5xBIIcs1X3uj+3vE?=
 =?us-ascii?Q?h9C6BsVfsuepfvSJMDjJoMASOid185vt1glRfscPccJDwdI9CbPS7P0R2Peq?=
 =?us-ascii?Q?wG+X9Ds83rUM8FcJg7y5zkCKiM7VfQOOZ/ycr7YqVLgGLIkr9CNajy6Y0XDg?=
 =?us-ascii?Q?ZLdhqlTbN7QHDhzCjwlQmrZBRtHa7RVbV6TsbM8GICzs5VQdeGT0XXlBPbWL?=
 =?us-ascii?Q?7DUdNnmpQZX5j76HtNFPl4RAwsKxYx4jsoJ4lYkRKiomdQ2sDLvoFAEildNI?=
 =?us-ascii?Q?sB3dofJ3n0tgrTHq1sgkQeghNtmIzLmQsnu32SfHzTJh/Z1CpMQvHOtMyCIV?=
 =?us-ascii?Q?XgJj+X4GLqXVNa5wdDetAWqTfZfTuXZUhCu/FGFwt3wltXmGIQ9kNiWW2YzG?=
 =?us-ascii?Q?BK4xNV2O5QJcyeuH728EJKsSDuny1D1CFBNBLltROUQq4vMujWWx9+P/er9K?=
 =?us-ascii?Q?LOTdxIpanNCAg7VehVEXxe1FObU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b956862-2327-4036-305f-08d9bbc48e1a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 10:05:12.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIwHNDg8ldzYBiHJrGQJKKsiyzM2C6ChhIA2F3oBpZ0qONw1XvH/gsAk0miKmK9avwI4XAJw20aF9AUj4/F5tsnSy26OuYfMAFDh7qXy6Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1293
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100055
X-Proofpoint-ORIG-GUID: Q4NaNED73RimwaGWEOGOThaMbbfO8If_
X-Proofpoint-GUID: Q4NaNED73RimwaGWEOGOThaMbbfO8If_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:37:01PM +0800, Jiapeng Chong wrote:
> This code assumes that the user is going to give us a NULL terminated

I wouldn't comment on this except that the Fixes tag is wrong so it
needs to be resent anyway.  NULL is a pointer.  When it's a character
'\0'; then it's just one L "NUL terminated".

> string which is not necessarily true.  The original code was buggy too.
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Leave this out.

> 
> Fix following coccicheck warning:
> 
> ./drivers/staging/r8188eu/os_dep/ioctl_linux.c:4253:8-15: WARNING
> opportunity for memdup_user.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 7bdedfef085b ("staging: r8188eu: Remove mp, a.k.a. manufacturing process, code")

The fixes tag should be:

Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")


> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -For the follow advice:https://lore.kernel.org/lkml/20211210083010.GM1956@kadam/

Don't put a link in the email.  Just say what the difference is.  No
one wants to have to click on a link.

> 
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 56adfe4087a8..5d26dffe5c0d 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -4250,17 +4250,12 @@ static int rtw_test(
>  	DBG_88E("+%s\n", __func__);
>  	len = wrqu->data.length;
>  
> -	pbuf = kzalloc(len, GFP_KERNEL);
> -	if (!pbuf) {
> -		DBG_88E("%s: no memory!\n", __func__);
> -		return -ENOMEM;
> -	}
> -
> -	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
> -		kfree(pbuf);
> +	pbuf = strndup_user(wrqu->data.pointer, len);
> +	if (IS_ERR(pbuf)) {
>  		DBG_88E("%s: copy from user fail!\n", __func__);

This printk is out of date now that we're not using the copy_from_user()
function.  It doesn't add useful information.  Just delete it.

regards,
dan carpenter

