Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F6C4649F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348041AbhLAIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:45:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236824AbhLAIpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:45:17 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B18V4RS007290;
        Wed, 1 Dec 2021 08:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=76ONwVtmtpqjWm6g1im1H4SMhVygmV/5y/UEWJeFYDw=;
 b=ad01R5nMeAcKvR1lM7Ef4WpDSe9icnN+F3IBCAz1OM7AzeJpTXOeUcuyGVcL1+xfDhhp
 bpqBuiS58Wov1Amlt3PVPgGk4qktWdRpfFl6Dh2FT8+Che01IhuiaDKWL5YtTjSWOG44
 09LepE+NDUIIBO4GNXyJvXgPMc7Qrz/UNYAQQJPDwPrBayyeH01jEkKAxyuP38g28H7b
 gjXrkPu1Ds3Vipk96UpAc4qwSUDykRDaKmcrsZNq+Qz99BesAUQ3vZM1g2zofvrr4N+c
 zHrHfGBE3T65XXlJ185hT4fogUE4AzMNoDMZH+CSYP0+KgsSdZPyEt70Doq6htLvsXBf Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9yc9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 08:41:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B18Fj0S119101;
        Wed, 1 Dec 2021 08:41:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3cnhve9qkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 08:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqMWYWwqXllt7f1eDjPJy1lj6gRUI3WSdugfHgbnK+kcEJ9y9arrCXPIGEoDXk79DirM7tnNMEMB7SbH8VX4ONvvsperJ/Dncp5T8UTQAGYaNw9M9WeitFbECEFjpM2BHkR+gJfzq9yZfx8Ae+PmhDDr0XgH6NhNED2ITwi1KIrhi+fLlxbW87as8a3Bxgj6n9WbOl5mdtvrXv9XHTE7yt0ljL2RVjJfEn6ovmt4tSI8YhZoLt5URbVZSqU/xA4S4RkHw4C6/wKfeMhNFkV5qYrjFs3dD1Wthq1SonicGuM8tlUA2g+RL1sSCI5/r72KdtQzYUCJCYgqR6DFS8aEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76ONwVtmtpqjWm6g1im1H4SMhVygmV/5y/UEWJeFYDw=;
 b=ChnwB3fM+GjtZ/6R7ZnF1g+yGiZUj1HhQR3aD9NVOwbt/XqF/K3doTf+OH8sYgEhvmJpmmv/p+4RyooEJiTxZipNHxPkNeEkXc8g60EV/Lv16357NJlToJrCbry5JvABSdgXUznjw6NReglN6fVPr990F8mGNATd4h57ZTvapTbq+35IZ2tXVZ/2MOpGYHS+eHtdO3sJ8dhGRWgegdB64pvuA/teN9ydNuHX0gFbl5a14FNky1JhaGtJA0SrZ+GLaIls61T26/hx5SzLe5+I7hwK9FSynvzqrwywe60LKHLqH67RvlFo/4LHRNna6ETiIh4vogXc8w/lnsrXQuG4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76ONwVtmtpqjWm6g1im1H4SMhVygmV/5y/UEWJeFYDw=;
 b=MLveMm6UqQl8xTWY8JWY/aSR6DtD+WwqJHtoFJXzuqoJRDRRJyuzXS3h+WxZaEkCvRq84X98xOLSMXDV+ZttQn6UkHjLx7LN294KOBYsqkaX+dHUd+tprg6H6MO0m9MpzhCUKyJzdaI2NGtOYB5llz4Px/r1W9jBxZjnzNGMOR0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2399.namprd10.prod.outlook.com
 (2603:10b6:301:30::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Wed, 1 Dec
 2021 08:41:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 08:41:32 +0000
Date:   Wed, 1 Dec 2021 11:41:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: meson: vdec: Fix a NULL pointer dereference in
 amvdec_add_ts()
Message-ID: <20211201084108.GE9522@kadam>
References: <20211130161224.181519-1-zhou1615@umn.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130161224.181519-1-zhou1615@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 08:41:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22a5b55b-e973-4c92-81e2-08d9b4a65fb3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2399:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2399749689869285E08241A48E689@MWHPR1001MB2399.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGZyNSqT7CGmpbZ01+M1Kk18ibfcVx6V1j5ldiIp+DGmqYsr3nKntl2eymOYNJU5G0bmhJv276CN49Pox0RB2d9EzPTLJb4dZyBdnDoXeZfjpB9N5k4rm3wOwgINQZX0YHma69e8f+QNDlM9BXTKLm4RnWxSBLOL6499+BwI3eIwKtrvIUW6ISBQQYg+oenDYmP1HXgdgKdMrCn+/ASBO2qC+HGovzE8hdnTMyOm7AC7Rlk7Q58A45u/IEmNzV9oBhAeRZw2H0X509PpUamRXFHYnc3r6X48OqY+dihBOVTbWm0gs7fc1CDr2a5EnbUWS+iJtt7l9y2vNVY0HzylILh8PS1GucE9USL1eXku+tOeJEUZdOlCk2kCIhTCKtwuGupmpWSar4fhrnsAV+jbB7SKOVswM6sUTQ5auuEAwg13HDUMpy5jiXZpOLtuyfoq6nydUq6Zfd3DC+Pf80chR7vJzYng8R+ZypmOluq1xorzW++bGDJLC72VG0ACuno++BFL+1gskfpmmTE9UMp3oPNk1GX+IxAKppD2cfEfx5qw+2udqnZBVMgnpr9qrExpc5figRUQsfimAeFyRaw8dSm65GD0Ak1GHBQa1cQweoMEpGPHJajckcjd1go6+C5sqEQemvsvy9Og94g8Mx63nPwSOPJCCEcQujSh/up5n2ZPUzJDJEZ75wGA8iXCNI7vt/Zt+gVIhyim4iXUWmy9EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(4744005)(83380400001)(1076003)(5660300002)(8676002)(33716001)(6916009)(4326008)(6666004)(6496006)(86362001)(66556008)(52116002)(66476007)(54906003)(38100700002)(508600001)(38350700002)(316002)(2906002)(26005)(66946007)(8936002)(9576002)(186003)(33656002)(44832011)(55016003)(956004)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YMrQWK+09nMmeKc21q7FcaJLS6ACvLQSjeRcRRmtpPOzogpSeYZee8joTfls?=
 =?us-ascii?Q?hHU2WqgpaL5i+c1jfL1rqUbwJZ1wo8JFwlranj/0PU6LBdPXMDJbyyFVX1wN?=
 =?us-ascii?Q?NpwGuojnXjKWfVNTcUU5SXpikmqudjY7taDyNhfMdLEd5X50ZUsl+ungzjrq?=
 =?us-ascii?Q?oNH7Z8i5oFvLBrOmD1WZaRWPzdo2vkcs8RY74LSxdYjF8jemGxeWXdIvkGig?=
 =?us-ascii?Q?9o0ybGa3QNmAemitCHwQgA6OAiQ4HEAakiJAlBQVtJRwBy/0ea9GLx7BAql1?=
 =?us-ascii?Q?RA0zsEa6Svb4lxVC2voAYHr/arLb0pvM3nA5y8Q0yUPjaAC5eOjkw8Bl5rVk?=
 =?us-ascii?Q?DXXwy4siLrUmIUxWzlkOYnJAy7ehtzSBorSRB4vSKpjF5W9kpi0R3KQgg3Tt?=
 =?us-ascii?Q?DOV7ctAeNcic1bxszi2vYZFHpar5ku8nCXIYY6kLxQGw/Tl79+YdtG6fJZQh?=
 =?us-ascii?Q?Jue0ZtKPmroaEPTN3UW2okt95c/Tz+2EyTLWTn4EsGS2notenMKnwlrDc4V2?=
 =?us-ascii?Q?o+xtVXemmC6JdiP6eLwkjGEN7Z2Y/dyhLSBBhU3plHhGBqELWDtEZIedXHTt?=
 =?us-ascii?Q?Z9s9N4BqINYgLb2BOpYUzz6jSwb+XsiaCPw96zFn/Shfp6KCk5+dnBHkDrLn?=
 =?us-ascii?Q?m3D7COukxXvj8ouCAFX7ZE6wU1zH6TGNagvsfpkY3dU1leB3LB4pFt8gAfRH?=
 =?us-ascii?Q?4NtATm6kP4sEm6pmRJgFaaCeZDMpzdDH0h2PLzZfN2ZXGyPSgh1nlCTZYYpL?=
 =?us-ascii?Q?iDGLKtVcpfCMVuXeW5yVUTfPj+4KRdFZbFgbq4abQepCKPKl42Ralg6XG2rN?=
 =?us-ascii?Q?4Vkukm8VPO0vTahPDi5uYqbHg6LeqRvsMiwiMIUn8b6Cr+tSywv6FeCBYVsQ?=
 =?us-ascii?Q?Fv3q+i3nJsgSkX+U+Xaa7p+IMxoECc+oqbj+N4jndb0fTS2pT4AEoitLnmNa?=
 =?us-ascii?Q?Ay90xnik0ovKugCkrV475ceCi+CpI7eJMjYkQJd4jrlKcfiPSqGnRDDCUSFp?=
 =?us-ascii?Q?K6wZYc4MQgteDCt9tbcUuIe2thLbdDc1hCTbWBNF4EsSoOkA2Os55LAMOYNN?=
 =?us-ascii?Q?Y4S92WXuGm31DKxGgBcxbGJqVEY4jOfY3k29BCpm0pXvJ+lPoGbqLxs09RNy?=
 =?us-ascii?Q?PxH2jAaH38PoyvYX4iriaWaaRDRch9kqUI6dFA3h01IG599TWOt+n5XC+wAg?=
 =?us-ascii?Q?ohe/zBN6P/+/RKHw11lUkk0Wk3bsaCiyhY2bxQG32Rkymoo65QPb3ridraUW?=
 =?us-ascii?Q?IIR8uN0TIdURJiXwSredCILfXJfUZnJoCJGJZwtNcIfHwHAiiJTwv5OXGJA5?=
 =?us-ascii?Q?Z7NjfAW2PRRcOWd6cRnQeDL3dN3JqgcQ0wA1JHbujt3glJk8iUGE4vaxcgwx?=
 =?us-ascii?Q?sWf9gEObDEBKNQl32rILIdYYitW2jUc8iCv6/ycnADuLJrESSwsuD1oCUGBy?=
 =?us-ascii?Q?SfSB/qJwLptkvvctgi7+Uox8MGc+GYX/i4h90mpI0URjNxPoStwVxZbK5mK8?=
 =?us-ascii?Q?jp12jVDEKIvkba7i3KZbqbjEpjxwFbBJ4UxfYAGtxs3kWBAKNIzc3KpJhyMe?=
 =?us-ascii?Q?+dQrXRVPE7J9rGe8vBtYk8TRoLykXYQIMw7RgOxf0lZ+wiu5md1JovW/uZex?=
 =?us-ascii?Q?4TqkRsGCJEEo1x1oAlz76O8FchXo8l6L3ZcjGbzqKb0ZhPCjksbujwjFW3Fb?=
 =?us-ascii?Q?nNHAr/EWGeJrtTcOY1m6kwKtuk8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a5b55b-e973-4c92-81e2-08d9b4a65fb3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:41:31.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSWFARdkXbNEE/8T362tI1b4dYD48xCB5YNDGeysh9KZfA8Iwme97u5wzST0oHgnRQZFvYjZ7SnlMUzowIlM8DXWV6ZqGCVGH+gVu8sz0l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2399
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010048
X-Proofpoint-GUID: TzUAeut8QQsDpBcUi0k1owdIAZv06PIS
X-Proofpoint-ORIG-GUID: TzUAeut8QQsDpBcUi0k1owdIAZv06PIS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 12:12:23AM +0800, Zhou Qingyang wrote:
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
> index b9125c295d1d..41297c2f8f9a 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
> @@ -234,6 +234,11 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>  	unsigned long flags;
>  
>  	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
> +	if (!new_ts) {
> +		dev_err(sess->core->dev_dec,
> +			"No enough memory in %s\n", __func__);
> +		return;

Please run checkpatch.pl on your patches.  The dev_err() message should
be deleted because kzalloc() already has a better message built in.

WARNING: Possible unnecessary 'out of memory' message
#50: FILE: drivers/staging/media/meson/vdec/vdec_helpers.c:238:
+       if (!new_ts) {
+               dev_err(sess->core->dev_dec,

regards,
dan carpenter

