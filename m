Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419A5475431
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbhLOIWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:22:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34098 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235834AbhLOIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:22:06 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BF50PRE007074;
        Wed, 15 Dec 2021 08:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=R8+A/B01cfAiXFSQmIjoUXWFs6wiv3FIsXPCj5AfvcI=;
 b=cx3bAE0PfA0mMPqf3BfRdYXHwi+frvk4D3+fECFlNlNrFbmJA9nQc6/5xJBpEjb7Xs+8
 7xbiwO0rWciEkyW5vyvmtf9t7Nt08RKRfDM4XFh2tSn9mC3LN7effuiBoPwV+EGBmXu3
 wKQwXoXTMzZdcQWKYUHajXpiUL7QzOs7ptmuleGYkNc+cbuAGP8dczhJLejSwl/qBwo2
 EIKVpxsKFVmxX35AHdjXM4GOr8vvgcBLTlNJmAqXf0UoFpbExrQj+JWqyWZUeUHQcB3P
 bYMeBa4DDzszLrcMFVg9awfqVxuic8J4Xed9vqjhixrSMF55hCL3MzV5DkGmBlsu0qPa Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfe53p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 08:20:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BF8GGtJ095447;
        Wed, 15 Dec 2021 08:20:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3030.oracle.com with ESMTP id 3cvh3yt0qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 08:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/DDtgIEFLDk73yD+YmaE2TGHS7st6pX8RNnEJfKReJmgHiFXX3THGwhLw60DHRMqOobZrl9ftqSfil3sQpzz3i5oYMNW5MIiEeY2/++MQ3XIgdDoL6LAiAn1vbsUHdLvylwdcWvz9BmFrDKW1/cefwhewqgKC2ZIQuNmY9HpMI6iyICFC6r70uusRY0bt7FqsZ9y+SPz/nQ3cBTzFYKkTvnItFpmvMy9P0ZjiUt45mfJmzSVyaRlmOmhvpASczHHz7vo1dijBWBF0gxqIWUQocK2vFTY39fmZ5iAUm8J2HaXbtFnbyI7EwNexS9Jna2c47j6gkVLMLqkTSFYEbeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8+A/B01cfAiXFSQmIjoUXWFs6wiv3FIsXPCj5AfvcI=;
 b=hByK2lsEsciVtMVeU01V2zrFMnwYHa9pdPY1suuSPNhc307XyFBLhRQ0wASlZfa4VFjORU4AlI1LMOx2wlDN4gLwNU/C2xS87sqgz5FrTrtLw45iDyBtilcrHYxjCjKUVCnYDXDz+kEGsUQDa6XmYlF091e0WKxdlKqdft/FKJv5HD1AafID0OkQ+iaDMizOMID7y5nnnysmFi/ynQybyoKN3cwY9fe6K8MryFm2lD58BXS7x98OGv+sEGdWppHkeLuXR0WRrskkCA3+ofXjqS1/Zve5boTbelEz7PxLYzyafyRQTh8HaWxddz0AwEwusSgLUjuESMNUfabgTvLUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8+A/B01cfAiXFSQmIjoUXWFs6wiv3FIsXPCj5AfvcI=;
 b=ZHCJX2HPx8fMOJXIybFT3BYri2K+5D8M3ZUCj4Nw4auYLiPxoS75ciwk6Vbe7Ju5Rb9KS4wCinHK53TlWvONkFuy08tAo9McMpvXYnBnjVuCKlJtpq+15fSIBB7SpJGGlr1p5wNNMsgseeKiGxUJbGHMimVv8LiHFpx3XQxQe/g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 08:19:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 08:19:59 +0000
Date:   Wed, 15 Dec 2021 11:19:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Bill Richardson <wfrichar@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec: fix read overflow in
 cros_ec_lpc_readmem()
Message-ID: <20211215081935.GY1978@kadam>
References: <20211209143501.GA3041@kili>
 <CABXOdTcny657JOxK-iau2Sj06a5hcDOdWFg8wKUNupgAceUU9w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTcny657JOxK-iau2Sj06a5hcDOdWFg8wKUNupgAceUU9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab25df0f-ee50-4ec1-3386-08d9bfa3af1c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2095BAB3A13E48E5D00D7DE38E769@MWHPR1001MB2095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+M84w3tD7BmQ5Q23BWAzmx10AN65peatsQVJAlr8p1699MVZjjf/hGmyo+kqVsH8I0+MZfC8TkAxeFjhLgefWTO6SpJNKXlCmHjGj1BE/BedIGn/4NNpFP8DRFcIr7nQsaemXnOBhNOKtHO+KDCQHgrhBteCaDMUf5DPYIS1sKTbtHfH/H4wHisD9S9GHeajZTQiFc9CujxUcx3RZ2ujU12Wc7UJaX2TGqncQeUNNCdBoLSTrEh5wRh+pHTUYUtBkvqfj0QZVczkggrAiBOdy2z250HfKGV4rfOrgnh/zXyl8MuSHO0uAsJYg4mZ4P/NyCtRqdv2kP2C9er/tSJguwTRkeZs2rq7cBWQHvar2Vv5K//kpOfM4WIwqErVR2DpbX5oZnDaEKy/iYoQjmq1DqzvHOwS6pQECLOUSyJNxpjeU6Z90kkVpcPhrvaXq2wVs18hNXJ8Z/6upRYNAhN3VVg/y1KjqZW2j2On20H3QcRYcE+pDkB+9SVH+7LgoSYk67ShZTcjjFQruyFokwSfyEKsd1NuELmBaxLaUOWCvZw7JtiJQwaHVUqTdU5/t3g+GlMCUoc8Zyg113149rTRdW5wTS9v2I3Zs3zcQ5H6OJBVklJxf2uzDQPnnSkdjZSptL9sQGKo/RlSjp3n6v+AYRmqBtFJHegLaCN1U5+s8B0pQ5UJqq+mIhP5SAyf6fTvHS6IyEICI+HCTySl4Xnkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(316002)(52116002)(6916009)(6486002)(508600001)(44832011)(9686003)(53546011)(6506007)(38350700002)(8676002)(6512007)(5660300002)(2906002)(66556008)(54906003)(38100700002)(186003)(66476007)(33656002)(26005)(6666004)(66946007)(8936002)(86362001)(4326008)(1076003)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vb5zYMVAktnw7rYlzKOr5IXzVLY+BGTOSLEpDyRUpEs1AKgzMRN8conwa38I?=
 =?us-ascii?Q?r6LtMJeyV41ojLw86BHdvtkA+8+70hGntH27m1JCPeU6v7y4dMOJ+3PF7k3i?=
 =?us-ascii?Q?Ps7Wn1MPDGqmD14mYfxw1FG2fxfcQP1cCDLh03hFZ02kR1+tYNCU9S2MHCd0?=
 =?us-ascii?Q?tB2hw1nVS3F5CWplgyiK+oi1v1mVPQmGSd148zKtRu4pxL4FNGAxPGJ7AveF?=
 =?us-ascii?Q?x05WKxd0xo7f+/I+BP/sCnCQUWmyNW9Miuc9Bf7AZYcRDOZ9xn8RnePn5+rA?=
 =?us-ascii?Q?7GO5nqw7OjM02j0iIFwjsDDGmIZnzJIgFbK9+NrfIUj6INilGqgQivoFLqJM?=
 =?us-ascii?Q?4utR9nyZuMWcrp38kC93FcLqhdmz7zWad5jx1J4BDAANAHkRfaqjMq7syWt+?=
 =?us-ascii?Q?itN8C1hQGErsO0EfPAvTA9ktknoImeC4ivgiFbS2cKo+V2j0I3kfUybJiGKX?=
 =?us-ascii?Q?mzsAOTl0iAA0+T/K3+q4CUCUzv/fQf2CufEETGXCYQNXIDQpRLVpusT05a1a?=
 =?us-ascii?Q?2JydvAF5EZ97SbbA4hcQrrrRc2yyhJL0CDjg7QvkBCzdXjoN8QExKkNZj68R?=
 =?us-ascii?Q?KmaN7dIL0b4pQ3Wl4dAJoJP0DnsZv7YZCleGVIthEMExb0TJ36wde9FwwCww?=
 =?us-ascii?Q?XcX7IGZzWM1HiRGIW2i860wshPS0ZI395CYHWFyEkkSWrJ59uDiaYGRyIML5?=
 =?us-ascii?Q?3VZRqXNe5bSLsOiqsP2hL5hUAqKfobVXi+IiGPF5EUNubnh5yKMSWHtULmiJ?=
 =?us-ascii?Q?duoLcrK79DbRZeGJJH/d4Au7n7AY8RyX/QadtZZUXSCA6FffphcjvmT+i2Ou?=
 =?us-ascii?Q?+wTdHZ6jswg0kZae3dFFo5S6rRHB6u+yTjTDNiaTN4+ASSLiW37btqyZsis1?=
 =?us-ascii?Q?h4Ut0ALWHBKHvWd4RD+J9HaxZyd6JYEa5j48jYGGCiHNm71EYQDFgXI9625P?=
 =?us-ascii?Q?bs/KiFyOtBDPrFLm/odGWq2aByoM+Ol+DcTxP3MlKO/mvI99FOiMIPc2Z1ag?=
 =?us-ascii?Q?bRRDlI/OSM7Vnt0aM2U1RvgIbI/mBpKkf7bqH9+yvhsmuha6afLe2Y/Jlr9T?=
 =?us-ascii?Q?sSvTIOqxVHBIWRWiUn4D4LUu5DUoqs7qnbfjte/sPXb9FtMvBSZdZpVIk/EO?=
 =?us-ascii?Q?OeXY6Umgk8KlTA9ngNM34YVzKEKzWd9CeqJUgv7EA+Qo007uqvtTGm1llvfq?=
 =?us-ascii?Q?KWNeIgJGnCYaTusPY5eKt9QVuXB8ZAKpJnRWykhBaXKqYqFWqjh7U8fttQUV?=
 =?us-ascii?Q?XaR+EC7NMgjXlPp3VEl13KFwFvgugKSL15OZ0xj0nP3TC0Kg6OWEBhKIgWX/?=
 =?us-ascii?Q?/YRI9ueQpbrScgV6RE9czahxIpmJFHXQ5ZVC1/7HvBy3x/ZG/vq2fvqGy+7Y?=
 =?us-ascii?Q?UlDrXe9GlzVL6tfJB7QFRmzw08CkIbc2eGOFwhmLxfP3XMvnZSf8C6sOljlK?=
 =?us-ascii?Q?HIeFtOxBjYd7eATlqypuvS2C/y0YbAUAY9ZGRtw2c3W30DF7K9E04DvpjSGy?=
 =?us-ascii?Q?qEDLGMGj81rSYhdEsAzDP9QN0y/6AUGuO0jvp7yKRMaO/NVIeyOeQBlb2CW5?=
 =?us-ascii?Q?gmpP0Q54viLfODo5DoQqLvnKODPypMtsYy3J4zZSM4/iDShVjx2cf6R2LKN2?=
 =?us-ascii?Q?ciGMZSsQuifVXlPxZZmtyOih5bCBCyVlR9bT+nGVd0qJVzUtfv80nzMn7InY?=
 =?us-ascii?Q?UdeW9A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab25df0f-ee50-4ec1-3386-08d9bfa3af1c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 08:19:59.4347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ishfvbymGOKwsodfVfZ+kxOgvfaoBM896PPvbzLp57que5Nvk7pppUiOlJupbk+yLhlsnMA1PnTpU2NT0sQq8LWwpxPeTiKVVd3bePw8iVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2095
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150047
X-Proofpoint-ORIG-GUID: ocR7nEOsWyGaX4ObIGhOxxOjfyOLMbBR
X-Proofpoint-GUID: ocR7nEOsWyGaX4ObIGhOxxOjfyOLMbBR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 03:02:41PM -0800, Guenter Roeck wrote:
>  On Thu, Dec 9, 2021 at 6:35 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > If bytes is larger than EC_MEMMAP_SIZE (255) then "EC_MEMMAP_SIZE -
> > bytes" is a very high unsigned value and basically offset is
> > accepted.  The second problem is that it uses >= instead of > so this
> > means that we are not able to read the very last byte.
> >
> > Fixes: ec2f33ab582b ("platform/chrome: Add cros_ec_lpc driver for x86 devices")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/platform/chrome/cros_ec_lpc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > index d6306d2a096f..7e1d175def9f 100644
> > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > @@ -290,7 +290,8 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
> >         char *s = dest;
> >         int cnt = 0;
> >
> > -       if (offset >= EC_MEMMAP_SIZE - bytes)
> > +       if (offset > EC_MEMMAP_SIZE ||
> > +           bytes > EC_MEMMAP_SIZE - offset)
> 
> I think that means we have the same problem if offset >
> EC_MEMMAP_SIZE, only now that condition isn't detected anymore because
> EC_MEMMAP_SIZE - offset is a very large number.

That's the bug which my patch addresses.  (My patch is option 1).

> I think what we really want is
>         if (offset + bytes > EC_MEMMAP_SIZE)
> only without the overflow. Not sure how we can get there without
> checking each part.
>         if (offset > EC_MEMMAP_SIZE || bytes > EC_MEMMAP_SIZE || bytes
> + offset > EC_MEMMAP_SIZE)

That is another solution which works.

>                 return -EINVAL;
> Maybe that ?
>         if ((u64) offset + bytes > EC_MEMMAP_SIZE)
>                 return -EINVAL;

A third viable solution.

I generally prefer option 2 to option 3.  I generally use that in code
that I'm writing.  There was one time Linus said he liked option 1
which I used here because it works regardless of the types or the valu
of EC_MEMMAP_SIZE.  This code already used the bytes > size - offset
idiom so I kept it as similar as possible.

regards,
dan carpenter

