Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DC64D2E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiCILgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiCILf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:35:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EDB153389;
        Wed,  9 Mar 2022 03:34:58 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2298gZkt010816;
        Wed, 9 Mar 2022 11:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=OxttgzxbyymZURhFfoowvFFQzRIbuMZ7b9uS8WbmDZA=;
 b=ondySYqaeZpyW8WbmbrasktfTaaySx21MHt/bWvYHipgUkD5VOqWWSm99nIYt7i8FFUp
 VQd6OVmd8ezB9U5OGBkrz0osjFDsJLy+hGmVCYnFMCVK8Pjap1IKvCDqTT3DlKpLo6Nv
 Rt+9MC7BUzzL772CmmKu0c3V2VJHt05g3GERhKx2zeTXh39tN8cxa3DctYnz6L0UAs2P
 RvrEXu6Qd2Qan4mLe4L7cqnBZtdiRcOLwCyOnOirYteTHBqr1iBcleStTbSO4/GuRpuY
 NqvgHop/khxvB9s77HRikzE6jkpX/I+LlOvn4JpzchluU6DdcLO6zgICoacU7KiNRoqc mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrasetq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 11:34:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229BFg1f132175;
        Wed, 9 Mar 2022 11:34:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3ekwwcrsw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 11:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzzyEysbpjst5rZGRD2Q7RXIZyUWJZ9SXzvCV8jY2YY7Td+qV6J6sHyUPH1uTTRBJYwSPRbgn8YiHjv39nCedBsGVgoMkwM+eROy6TGc2OLsE24JQSFN9N7MHXsGaRZE5/v+BKKZdRgX24nys2lx37eOY/cS9tXrxc1/fBT1773A0TxyUnprKhGPlo91/MQ4PmljHZ/eMgFPorTOC1QeAiZmZqn7X4XNDoqrNgYu24MjzNM6rT0RwP0k0JUqX3+KPqvqW3l63QczBMblv0nGj0GCmJbhF2tCUDanRVicKfppUz3wmQ555evIfNfyY87VG1K7z4gn+Yu8QISXXfF6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxttgzxbyymZURhFfoowvFFQzRIbuMZ7b9uS8WbmDZA=;
 b=jQ2KqhASilOvnLWdLzqjVbccxDh/+xVXjVLQn2vMLsK48OjBf5KWuLsWbWYrOOc/NqLmxgnTkV++AdxP3OFIhyZsoMWh95+KYD8Uk+rf4Nkz7R1D0amZjsuyUnulVrQF4f+uW4Vjn8IxALAjT/hCD8ZXicl4I8nAWyK+glsZYKPJ0rTizJrHqez15oT0BYyzCUMI2B2gQrnx/zcRaJPAZ+ctUhw3pYxf3Ko87nj+zp03NF+5B6sg5sft8oGleoIJwWhf4nWqurMtycnpsl7UU8a+dLxCQHgA0LFcEYxq6zERPv7FNaP5KX0b+ZYz1t0vCdwtMpdtTe7D+OA4UsEvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxttgzxbyymZURhFfoowvFFQzRIbuMZ7b9uS8WbmDZA=;
 b=gjEwoEi8Ks1kD0n8MNbtgrry3XEt86UODeMuaSoboyoTLze5bzTImtjKOel0FA3axTJKTiEAQiHen6jjrord0/NxD1kq3IQEVjNeU/d3bENhxzFB2j+lEdT4fybZq5ci9ZPpNx536iFF0Rir3v1AYtxdhfGwjmOx+MpnHDY7Y64=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4732.namprd10.prod.outlook.com
 (2603:10b6:806:fa::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 11:34:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 11:34:36 +0000
Date:   Wed, 9 Mar 2022 14:34:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, hverkuil-cisco@xs4all.nl,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 06/15] media: amphion: add vpu v4l2 m2m support
Message-ID: <20220309113420.GA2592@kili>
References: <cover.1645670589.git.ming.qian@nxp.com>
 <8af3c8cb6ab6b02461ad67ce21b8058f5c5caf4d.1645670589.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af3c8cb6ab6b02461ad67ce21b8058f5c5caf4d.1645670589.git.ming.qian@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0102.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10fe7f7-e568-43eb-81b5-08da01c0c9e7
X-MS-TrafficTypeDiagnostic: SA2PR10MB4732:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB47323177FBD54D74BC769B148E0A9@SA2PR10MB4732.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3UG/7+qKoP/L99KAH3v0Dkr64OnLhjgAW/ZQUYpAUaJh/CResDw3hYjtvM9FDBzRe8NopST6zTWeSMmva7JpZgax3Ne/u0TW9x8UejbHC7+W47cyU5K6dnbghjMHfMTIblSKIZ+5Yv6YMNEn7GFwfjAxuZJwhdMzfLCi9O3kRQ3Mp+DY/0rEHIXdM4YJDpBZL59lRwR+nehFG9a3NaF72LO4twEM8lGXS/Y0xTAJHU3puG44mHCASqUlL7RX086OCr6KdH/zZUBJnaCgLLKpf6L0gzOrxHceHNtkjc9P1Nq/GDXlqIO46we06zm2F7T4Ofih14kZv63balP7UnoqkOqR0rGHLTR/40ULNyA14zQd3/g3TqwRxUmx8pf3p0ia9oFLoKdL3q1xSMp37tf1RmRaWBbHbAA5XHk9l28zG+tpXDbsMGbE/HmpwwTgdnP6PDhzRym1s6CMZMuXYMDKgOkuUho+ErdQzERIq6Zm5hBVzRMZvoM3Me04H56PXXQ1OxzbmSMyoPDcRsYiksQVDwjdHfM35luUiV+E79QG6mSNdVDpunUDlMNoGm/6ragTaR2tc5mZsJhBy7T3rKejJsvZ8xYhtFqFDnpaNlonI+TQQrbxRk+WkHcuQUhj56C7bD2JCrMMIj5ov3JXstUE/vT7xsBlRoCXEQAxaayv98yT7f3+TtsCRGsl+bv3Xc6dDdLDI49fC5bNmKNJKJ+mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(6486002)(6512007)(9686003)(7416002)(38100700002)(6916009)(316002)(4326008)(8676002)(66556008)(6506007)(86362001)(52116002)(66946007)(66476007)(6666004)(38350700002)(508600001)(8936002)(26005)(83380400001)(186003)(33716001)(33656002)(1076003)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDi464ZzyAxdgJ666VOAWs355toeMh4V2Td7RZStFOd1Rn7GWw9ueCECrfiW?=
 =?us-ascii?Q?t+hBCqyiodyWEBUrXm6BUjs1+XFJGNCRPyM4YmgiH99re35+33ne/kAiu05Z?=
 =?us-ascii?Q?oy7ex4oXkllgTSuHIeXia1mrPdvaS5yP8yRuoVZikEeoTAsKKTpIhVL/U5vi?=
 =?us-ascii?Q?8HYDWeleT0xQpBFENUN3IS22jsSF7LzNiQaynHjII5/scq1cTWAGEvnQwKod?=
 =?us-ascii?Q?gSmzuyQdVBk5Bg0EOV1QUxeMV2XKXOtmff5CaddipYBem3WXq0kIWJJQ3DYC?=
 =?us-ascii?Q?MLEBzu0EgqjXdQbO3WmEE1lx8aL4yK/R/IgBdb2fMauDA4RE4XTByjRAbqoo?=
 =?us-ascii?Q?DumspFW2xbbXr043GpL5k6e1mVlMmNs50rHCoo6AEWCYAMSnMOW1AGpEYvqB?=
 =?us-ascii?Q?LllIoLA+JDClNctf8PI56nNiz8NN1c+72fcsy5rCoJys+F+OwKhyEqBdw5St?=
 =?us-ascii?Q?GpW5UaKnpKh7rUDiVgEk0bYo8BrViMQREOteMG/yMeLqo6/lEmWFQ6nDL8cW?=
 =?us-ascii?Q?bUB+P8EIfLA3i2EPUpUyQu7ICgz1mZ4HVKYadg9Ib647nom0V67v2qugKW8X?=
 =?us-ascii?Q?uNX9utEL+dK2MW4mLA4FEMdM4ESXaCpM3cGcH+iSzeGur1w/CYbM0t2wsUCg?=
 =?us-ascii?Q?3O5QocATdzxgSN8QLcuGfjdmyjnP2UCVhbe2BB0sngnaqvYH9U9YuXyvTpwS?=
 =?us-ascii?Q?41zWQlbo/PWUFmpNQgq8kMukR15wWR9Rk/mI/GPRfs4SbbwzBBdTh71tUZIM?=
 =?us-ascii?Q?Y7H0yOIamnnHAdgwTsd0Gt4cQz0rsbRCxvb/ZS27RH46ZcKzborjumEXMkhj?=
 =?us-ascii?Q?dIcrNZ5zUFXT3ktHYEUk3e2HP9wPxar15m6GDFKhKwGgXy8w7AvOYKMGPT6U?=
 =?us-ascii?Q?FtClIYPv8XDZvhMxZ7aiQ1md3nAMbnvJVMDLybSbwwVWQodGw+x3s4qxiRVi?=
 =?us-ascii?Q?HJI3kp2sV7QLtLi44ppa69HX7dCriW7WOLK4Rhp9teS+nTwi8a77TKvZbSm8?=
 =?us-ascii?Q?MPPIx9U+2tPC+v3oFva2AUWf4wR218XbvqsZ7gBe1iNscSQCCmKkpmtFfYIm?=
 =?us-ascii?Q?WlbA+GbpAjvnRJHYROqrAV1bGK0ORzz6v6ofh6Gx1Q2bwSkUb0vFSECmddcF?=
 =?us-ascii?Q?lYEkQJfQ+T0GTg3oeuMR4PAU6zH2cWSWV34twYjoovtKwF3Roo8TI8qwFS3Z?=
 =?us-ascii?Q?IbrxcSBFFSkLxK0yivpe1RiBU0ncKPVv4VKGJE5zWMA+TjGR9FR+HsNdzn2f?=
 =?us-ascii?Q?/mAKUJD01N/mgqqtlnD+5a5NLHP5q80voLZj0gk/ZqPkRwWP7Do39FLmjLLU?=
 =?us-ascii?Q?T7kGuEntuSNe7r/VfydYFwHgSUN/gFUcsxyouAbzHk30flTHdL/O4t7vUekB?=
 =?us-ascii?Q?tvqu0xr7MG+smZW+xJ5jZZCgyEBs12Xo+XkixQ4X8ve4ITDb+YzRt7OsSkY2?=
 =?us-ascii?Q?9sFqyjWhuucQgETaOYaCqWAIIyNXj6gTxVbFWy1mmS/7gV8aMFMk2NjmtYVE?=
 =?us-ascii?Q?GeutvZiK4qDrq4IIc4sZ0aMHQOUrBdta/QwCqjnbWtlFgsS6/a8TdBBxFac5?=
 =?us-ascii?Q?KP0wjRc84n/TpIpBjNitT+OSwxa/GFvGiYiGLKZI3jIMJzwQ3N8JM8U3V7T2?=
 =?us-ascii?Q?P6PRtv02zYIiwF0TdRs+lXwiQSMRPAtGiv8apLHVHi8ldkr+6PYGScgd2jQ6?=
 =?us-ascii?Q?WqJF0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10fe7f7-e568-43eb-81b5-08da01c0c9e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 11:34:36.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gg7x0oZz0yufsu3vinkaJQeIZhb/pQBPgzfavvay0HhOSql7H7M/npcwpejxNZMuuYoIe+zAM0pp8C0c3KgMZl2JzC2lA2O7+xDs3Ua9gJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4732
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090062
X-Proofpoint-GUID: oxcdqGbFuvrWZOecJ8Es4yvfZWfgBGJw
X-Proofpoint-ORIG-GUID: oxcdqGbFuvrWZOecJ8Es4yvfZWfgBGJw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This code has a serious case of the u32 pox.  There are times where u32
is specified in the hardware or network spec.  That's when a u32 is
appropriate.  Also for bit masks.  Otherwise "int" is normally the
correct type.  If it's a size value then unsigned long, long, or
unsigned long long is probably correct.

INT_MAX is just over 2 billion.  If you make a number line then most
numbers are going to be near the zero.  You have 10 fingers.  You have
2 phones.  2 cars.  3 monitors connected to your computer.  200 error
codes.  You're never going to even get close to the 2 billion limit.

For situations where the numbers get very large, then the band on the
number line between 2 and 4 billion is very narrow.  I can name people
who have over a billion dollars but I cannot name even one who falls
exactly between 2 and 4 billion.

In other words u32 is almost useless for describing anything.  If
something cannot fit in a int then it's not going to fit into a u32
either and you should use a u64 instead.

Some people think that unsigned values are more safe than signed values.
It is true, in certain limited cases that the invisible side effects of
unsigned math can protect you.  But mostly the invisible side effects
create surprises and bugs.  And again if you have to pick an unsigned
type pick an u64 because it is harder to have an integer overflow on a
64 bit type vs a 32 bit type.

Avoid u32 types where ever you can, they only cause bugs.

> +u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
> +				       u32 *rptr, u32 size, void *dst)
> +{
> +	u32 offset;
> +	u32 start;
> +	u32 end;
> +	void *virt;
> +
> +	if (!stream_buffer || !rptr || !dst)
> +		return -EINVAL;

This function returns negatives.

> +
> +	if (!size)
> +		return 0;
> +
> +	offset = *rptr;
> +	start = stream_buffer->phys;
> +	end = start + stream_buffer->length;
> +	virt = stream_buffer->virt;
> +
> +	if (offset < start || offset > end)
> +		return -EINVAL;
> +
> +	if (offset + size <= end) {

Check for integer overflows?


> +		memcpy(dst, virt + (offset - start), size);
> +	} else {
> +		memcpy(dst, virt + (offset - start), end - offset);
> +		memcpy(dst + end - offset, virt, size + offset - end);
> +	}
> +
> +	*rptr = vpu_helper_step_walk(stream_buffer, offset, size);
> +	return size;

This function always returns size on success.  Just return 0 on success.

> +}
> +
> +u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
> +				     u32 *wptr, u32 size, void *src)
> +{
> +	u32 offset;
> +	u32 start;
> +	u32 end;
> +	void *virt;
> +
> +	if (!stream_buffer || !wptr || !src)
> +		return -EINVAL;

Signedness bug.

> +
> +	if (!size)
> +		return 0;
> +
> +	offset = *wptr;
> +	start = stream_buffer->phys;
> +	end = start + stream_buffer->length;
> +	virt = stream_buffer->virt;
> +	if (offset < start || offset > end)
> +		return -EINVAL;

Signedness.

> +
> +	if (offset + size <= end) {

Check for integer overflow?

> +		memcpy(virt + (offset - start), src, size);
> +	} else {
> +		memcpy(virt + (offset - start), src, end - offset);
> +		memcpy(virt, src + end - offset, size + offset - end);
> +	}
> +
> +	*wptr = vpu_helper_step_walk(stream_buffer, offset, size);
> +
> +	return size;

Just return zero on success.  No need to return a known parameter.

> +}
> +
> +u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
> +				    u32 *wptr, u8 val, u32 size)
> +{
> +	u32 offset;
> +	u32 start;
> +	u32 end;
> +	void *virt;
> +
> +	if (!stream_buffer || !wptr)
> +		return -EINVAL;

Signedness.

> +
> +	if (!size)
> +		return 0;
> +
> +	offset = *wptr;
> +	start = stream_buffer->phys;
> +	end = start + stream_buffer->length;
> +	virt = stream_buffer->virt;
> +	if (offset < start || offset > end)
> +		return -EINVAL;
> +
> +	if (offset + size <= end) {

Check for overflow?

> +		memset(virt + (offset - start), val, size);
> +	} else {
> +		memset(virt + (offset - start), val, end - offset);
> +		memset(virt, val, size + offset - end);
> +	}
> +
> +	offset += size;
> +	if (offset >= end)
> +		offset -= stream_buffer->length;
> +
> +	*wptr = offset;
> +
> +	return size;
> +}

regards,
dan carpenter

