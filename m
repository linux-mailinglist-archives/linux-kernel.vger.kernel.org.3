Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C287A46FCC3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhLJIeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:34:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10106 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230463AbhLJIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:34:21 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BA7jWtr025248;
        Fri, 10 Dec 2021 08:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=EZ5U6UGjI3p5lKAGIIzHtjh0fSkhuKVCEbP6BaaXjwo=;
 b=LfEIny02ICMnUMwQTi7RSHJrT3FvVhQYCPVppkdbLN0bqa1CJWkiZn973lFwzHqYbBpN
 AEdQeRAQUdz15FTcShXjzjJD649eyNGm/Qu8gcI2ztx5aGBCIRcgmI4aKCQX7OHpkTA+
 7DkrHpfc2cm9cGrAlpzsqcwAF5AcfTMMfTRX8qtq6thLIG5CXoFWJyyWsgnJlebT+tu0
 ENT96LZQDWKw6KecdHDS3BMnlme3/Oj/AAjxW6wRxhccy6f4DEzeHRqUdxm+AOqt8kMd
 /mWOuPsj1KO1OpP7I4W7ZYsLP+Oma5Hnc74nSHUsj13PIOBijb4G+tztgBzT1VP+OIFO 2A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctua7n3y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 08:30:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BA8BXYP105232;
        Fri, 10 Dec 2021 08:30:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3030.oracle.com with ESMTP id 3csc4xdpgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 08:30:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPgoWGnAQ8Icy0/SztaJVClsvA2Ebdl40W8tuWkjCPpIRbyxmVrC28Ii3byDC2PxOLbX0vBTs36xcGT0Qfxgdsb+dt8LtHsXBdLSj1wfV0EFfWsRMk4awqvS+95o3QOsLFo70VpqixKjCyYBQyFOIrk2XL9PYb4J3zsCUfOQ5tgjmITJXJLTT6TC/NqjV4n9oFqlubhJPamQlfuMlTiuXTyBInt/DlMdpecqRnNFhgEDmAQ6VRUaNvSkEW/7f4Cde+SZvVFOyJdiExT13HWzUtOEX1hakc2Dwc7JMmtKo8EqOLwzKtF/ITwIHreueaHnJbH5wxr8MLVauXFNzJrzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ5U6UGjI3p5lKAGIIzHtjh0fSkhuKVCEbP6BaaXjwo=;
 b=jTWJJJz0OPFXA7Vf7g5e+rhpRFreeTUKzYKhodxQWpCZUM6L6idsQvE0tnW3tEQ7gNWgZOvNCUrYFr8fdscTXBebn6u721iy1acsGvtKw8/pvBniHNq8FFybgQGETTVdaAdjdhlTBxqibDuAjeb8jv3N3XR7zMsXB0BuTJ/CwW7fmc0isuwb5dkF1F0b9kvTHdgs4aTfZqmijDje6X4PkMYLjgDcAietZvQrNMIVf6M9FeIZkECpeQ83l42cYuzEU69jpKsJTu75Fv9ERUUJD6W53oYllTjorUPOlkBZ/mEEGXDx0Vm1BP+bcq3VAGNpSGzBizjMjOlGzq8CybnWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ5U6UGjI3p5lKAGIIzHtjh0fSkhuKVCEbP6BaaXjwo=;
 b=U5DceF1IGmUkbnbGEnKm36TUBKVSe3uVbr4HN0Y5UFI+cOcX72adk7+UhyEINmod3G6qgIRuv7YN7GmaxIjzfGVEp3gkeN9/T5XoRbVrXD6kqPjVCsELFKXnRj8tg9MaWR6RFpBIdDXSZEW9zsGch1vjCmplA45F3zYH5dQFo2E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5792.namprd10.prod.outlook.com
 (2603:10b6:303:14d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 10 Dec
 2021 08:30:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 08:30:24 +0000
Date:   Fri, 10 Dec 2021 11:30:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] staging: r8188eu: Use memdup_user instead of
 kmalloc/copy_from_user
Message-ID: <20211210083010.GM1956@kadam>
References: <20211210033832.40428-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210033832.40428-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by MR1P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 10 Dec 2021 08:30:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 248ebf93-aabf-4b7a-9639-08d9bbb74f31
X-MS-TrafficTypeDiagnostic: CO6PR10MB5792:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB57929171495423346A919CA38E719@CO6PR10MB5792.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIvGPJ57lH/VPLvh+NVtQShzN+z6OFiqk/1bSmjJiDx5kzUHbwTRosiTtE/qbj3laOrd1if9RDplqklENUusSUGA5IaqWpS1VvjJveoR1WqYDn9uutTv2D40pNKt44ylz6WfwgIqVTVeWmi+9jE+uHK/fcpn14JGbbbtPz71oVVLDaKxuJOEaL789aqHIV/pnyz2SiKkXNeDAokaoxh0y/Y8Ba7tjZllYJCpj9GnUyMvlp73n7HfwAjIaPDS5YthvaZNpZ6ENQP1G2HeJm5psai05vPNXnB3Ld1dawk8eZcImu3EzAbTqdnnxG2jT+n2DUsPriJqdqrB7Uo+Xy3XT5Cs5VOLw1QZ1o5Sn4rCVOapq2S3B0FyRRsMfhjaWYB4QYO+64uQirWyzYt1QMQsUOgOw38PRV/nlFUPT+zZlKDyf9T+ZQD4AT1M+t7URJlquSgChc/n2rN/SwDxGRkMd88r7eOLKYTrBCDsoY8alVn30heNI/AMcgOqH2W6R1jDheMzl3uq3pjB1IwIc7T8qHrBegjnAq7p6DA9kkTA1QXMWdAnjLLBdtSfGB974SiT/+20BvTHh0FyDTKuMi8NCqTbdzOK/zVzxd3LxU6m0TMGAikXgqsq0W8OKFWGt/NueTUneI9Ia6UvNXdHWF6l6ThPz3UuAD+rFSrHaN1mZDM8UP3h4bD0YWAuXGQwX/Gh5SNSLJeqTm/DnzV3K8+vsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(956004)(9576002)(5660300002)(33716001)(55016003)(316002)(6916009)(66946007)(1076003)(66476007)(66556008)(8676002)(508600001)(44832011)(6666004)(86362001)(9686003)(33656002)(38350700002)(52116002)(8936002)(186003)(6496006)(26005)(38100700002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mnAWUER6W8JGJ2UJLP9xbaB0rIrEi7bi/IsBi4RGRjlcDeMcCvs8Qr8yX9qM?=
 =?us-ascii?Q?ohkrp8davJIEiOKW6ydcmfM9mihy7G6MvYWLUhijj+Ep0Mra6zoOANZWTH/b?=
 =?us-ascii?Q?AtE0NwRUHL3xMc+Q9G9QL3cXAcy1o5cnGZkyxv0fSmd8WISxPMYw1hMFuhjq?=
 =?us-ascii?Q?H3klBlleyDrKdoao7BgeXd8alxDoYjzg6bGro2gGocTYXl0X1w+ppL6OgeSx?=
 =?us-ascii?Q?tSAoBAirEmqa0MInYK+MY/icttA8yNjcQLx6G1n1NXSgYEKjtgWvYTN2PpqL?=
 =?us-ascii?Q?hjHG48/MzjILw3d7ziiWOZuaCe2141NBkYUbzeOOp6lYQ/a93Ek+gCgpKE08?=
 =?us-ascii?Q?7IwYhxv7zWFxgxv9ry2fq37bX/LzdL9WeR7C4PwlnAQjEEcE5l3PYJc8fOKB?=
 =?us-ascii?Q?GodB7FW5iMxM7j2qkWDkwDwjTGrWcWPC7wh12hUecq+ToS52aCc3cRFLHHi6?=
 =?us-ascii?Q?pxnfkEDWrzqORNXm8TYTRN4d5F/pEA2qfysMq/X+t+dGu5rR40YYNxGfDi21?=
 =?us-ascii?Q?BHVVGpIlZHQ369uKT+AllngcuzaF2LFbIGfbQXOdJtnBElofHMI6z2kLoQIj?=
 =?us-ascii?Q?v532T7XT46qulqDunr4txW+u2X7Rcm7oZxtfKlqh17+YMOyBsxKFWVOdL4ge?=
 =?us-ascii?Q?eJk2O4Y2UcViqIX2D0Sk9dY47inBSZa5dDk+LPxHClnn/Y8mHcr8ODAJk/54?=
 =?us-ascii?Q?sJMKuainYoSG/nP4RDPcXTErypOVeQOV4j7rSwf2EvDXZmackXRbt7yOOBvx?=
 =?us-ascii?Q?ey4C69hEyuJNeUkB2PAmKTmB4EEbjA296QVZp6IubLw+i7Uqezc1yWyeaEqR?=
 =?us-ascii?Q?pGLEeND1hEP9X1MRrVK7tOGoZ8bpxKBU2Ux/lEfzsZyhy8WyVOOWFu4elFRf?=
 =?us-ascii?Q?aPG47DO+AEULZ/3pgtJei+B7BGrtkJ9URKgMUBSjHKzcRJlTmtSgsQ/eLCX3?=
 =?us-ascii?Q?l7d5tRgvd1fNQ+nAqIuJLZchbKzi7B37NpwMp75ocv4JV9y273f9oY5OgeQp?=
 =?us-ascii?Q?Dc9v/+qp8Iwqfsu2eKCrKL6eNX4qW/x3s3RGA6jpZVOH4U4TVgUsozTDa/e1?=
 =?us-ascii?Q?VRpv9BlEj2IcHim/3Gs1uRHN193gv43bCAUDyKcQh5A19q4N5rJlYDeas5lW?=
 =?us-ascii?Q?+ahvjbR/CMPrNP5fqRr2Zs4ujk8ldL27ItSQY8y0ooFbRnRVWkzAFb0vHIPt?=
 =?us-ascii?Q?nIqX3CzL347Y+z9/c0Qs/teSBSunkGhVjVKrvNIbuDfPgl1c9dB0x3fUu6OL?=
 =?us-ascii?Q?2+dSak+dDHsIi4iWSPthRTr6B1OdVhNPeEOFxgd1/86fkD4f95ftCl45CQrp?=
 =?us-ascii?Q?b9f4kcDmKIbOVivjhr6vBJwbYMH5v3XP86I0YQvylvpUF9vFx3/MAs5oymF1?=
 =?us-ascii?Q?jtq9eYvQ9n8SJT54JDSMWUPk4F8WQ1IhhgrIa1f07kfETQQb9AgwfX3l3gJX?=
 =?us-ascii?Q?xUUd4A0qtmNufxdz2t49IqvZTj5FaiCGQZ6/vICkAH3WIWMOjC5fDE53Lefz?=
 =?us-ascii?Q?x6cDtbJvF5CyNSCyypS2a3ttBzU+cs4hdqVyXoJwF4PWTr3lzVHOnsZPYxlq?=
 =?us-ascii?Q?7wgI+92aMYNTB5sPtO7z4/xFfKNDmqcWeVY5bKBbuFL4V2dI/CObDxdLzAr/?=
 =?us-ascii?Q?qqCtl02DTxDtLtcldsV767PRR+wI92QDIASzZ7un+ybpJCNST1A0s6vUkShQ?=
 =?us-ascii?Q?s7Vv9VFtjMvJjX/Th4h9A1/x/ac=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248ebf93-aabf-4b7a-9639-08d9bbb74f31
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 08:30:23.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExbOEowaRKbZld4sBRoREuJXBKPNuy3UC6onUf54HlC0/B1ORqS5wHlmkguy0eAlWOzK9gfuo5xoY5hUAdlnQqkKSwbEVKhEmhCUfKhoHrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100046
X-Proofpoint-ORIG-GUID: -yjiSGDbMVvQje9oi3TtMQT_TBtM3-4r
X-Proofpoint-GUID: -yjiSGDbMVvQje9oi3TtMQT_TBtM3-4r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:38:32AM +0800, Jiapeng Chong wrote:
> Fix following coccicheck warning:
> 
> ./drivers/staging/r8188eu/os_dep/ioctl_linux.c:4253:8-15: WARNING
> opportunity for memdup_user.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 56adfe4087a8..c6a2fbfe8f26 100644
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
> +	pbuf = memdup_user(wrqu->data.pointer, len);

This code assumes that the user is going to give us a NUL terminated
string which is not necessarily true.  The original code was buggy too.
Anyway, please fix it.  Use strndup_user() and mention that it is a bug
fix in the commit message:

	pbuf = strndup_user(wrqu->data.pointer, len);

Add a Fixes tag.

regards,
dan carpenter

