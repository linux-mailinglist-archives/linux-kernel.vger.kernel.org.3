Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4A4FB732
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiDKJTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbiDKJTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:19:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA62C67F;
        Mon, 11 Apr 2022 02:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa1ENfGaAWN2hNeU9JpnFzgf18vdQMf7RjeupgOXUbeQozUUr7qM9GbAXscYp79tF/rXs7Z+0Fr+Ikpsy8Czb+QL1Wp7dUbsXNHBco2QPY7PqF2FztiDdNrc6CUdgVbgQld0QZ+L8R6TGPAA8sCGvTU9sR109wCz6F2wCqpDQEIO0nkGEI01CybEN3ASzQfnsGMNbH7v+j+/cdD9+Z+JDLO4ao7wasp+ppq/Eld0+5xre/+GyuMYBN68ZOuoE2h8qu7SGJSHeTuBPTT6XaQOK5DMrMnj7dUgOAg/qgoyMNwXntoII7N7Z4wOE07Miw81RRNEEqJLbSvaoduP17i1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sklW7FKVeMLmYApJtdtFSRC5JE0fxKTRFQZtkbfAclk=;
 b=CgtDdV9im/Kwzgzw3xORrnoNjxsuFwuRXf6+3eQrEZ48nEyFXu/AIEOI1SFJfCzu4guKOzoWjefWm9hSq50OD2x9f/RXwww+PVqUDeVK/xRoVzMJ/CFXergHxAAz+Qv03poV3EKoJZ/tHm2KBsMqJujWhVGNbf90TonLpb7iQ32dYO+V9GcZxYeJ2vLFsu4J4EE5GrKAptiyPA/179eU4LuKLd1V3MNq6koQNapxbb2RiCTcXqiNnxdSr5gOtvIMQ95QOlm62FEEYQTu9S4Y+LpnFwzm4dLeJAFAJwBWVxou4j5qSiAP5i6Y9tRHG/aQwy/nSGaH69MbkWZpWXsaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sklW7FKVeMLmYApJtdtFSRC5JE0fxKTRFQZtkbfAclk=;
 b=kFqXqk/jynzpChGJ0ZXDHwFAU9z+nl9B/VFia2ofb51ICrI8f1krZeMFrOQlKiO3CF/+k7Zu61Tiog6sk+KO+Z8xJONlXBuFBxvlKK2pWJzwJFmAQ3UrOex3jC+x49nkXe5sR6pphAh78e2u7VZSl8IsZuLXsd1mN/ymRP+DCZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AM6PR04MB5509.eurprd04.prod.outlook.com (2603:10a6:20b:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 09:17:13 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af%5]) with mapi id 15.20.5144.027; Mon, 11 Apr 2022
 09:17:13 +0000
Message-ID: <506172e8-fe48-5fa5-415c-e8ba9835dff3@oss.nxp.com>
Date:   Mon, 11 Apr 2022 12:17:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: imx-jpeg: Correct the pixel format of rgb
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220406094733.8562-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220406094733.8562-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0111.eurprd09.prod.outlook.com
 (2603:10a6:803:78::34) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f5dcd68-350e-4b0c-c2d8-08da1b9c109b
X-MS-TrafficTypeDiagnostic: AM6PR04MB5509:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB550944B3EF526EDFFBC2B336CEEA9@AM6PR04MB5509.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mE8XIwgMsNmTQWk0nQ+FVhFLPTmU+nPMJVgTGK1Q6C0G9QfC3LXmX1AJjHZhEySJ2Y3ldcr32lBaBMwU3AmDigp0tFLEAhlFRCqV+LJpk6ItTrlYJZ+R3U4DlUwAyhad1BYQEQJ+l3yM84iJiXS/p1jqTEqgWHGgJ9+aA6HB4ppHmr9EhxsRQZwfQeH2CJeSrcFcQY38Bdp2qucgokRAduuyJvQ5hzmfhSpez0XYjdVvSZB6j3YbKACgH7lGkaFzICNHKjaXyin4WOrJNVr0XefgHsGyjI3ESvq0J8WafkLfJFyVSsEPx2H+BEsdXK+hC8lPyw28eUa9KBBknUPke3a+a5Pft6re2BYkVmVeFGtVI8YPVG3ACvcXoMLYzc5izKV9me5gK+toEMzDtw34Mo/YMQXE0UQjdCv1K7NnNjrp1SbiLdiXM7e1YN7LN8enp7qrMo3TdvJowNoYdstzSzVXWfWAQT8Fq9Ggv4SyxyPcs1Uo2aGdWpuUHttLBrHIpuCy633L3TJJ1A/fQILmu/pyJlSuOPyzzx3Tl9vKENxoe2EMxzcqYb0lN13pWFrtmwkFzIffB/oRer2wlgT1duJn3yGABFSytkIp76eC5Aj5EJplgPDtBGOSDIl8VIRC1hEQUb78liScVN4qBRIKQikMIGRH3cbiF4eZ/Uy9w3KWqbz0bMEBqX3H1gHTzIK/gBmY8GQTueHHi/VtZiNedEqUQU9XElEfCxpcGY4rala2MrpY4d2zIa7jJGTNdlO2LuSWUNxhRG3HP8n5nUGrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(38350700002)(5660300002)(2616005)(7416002)(2906002)(6512007)(508600001)(53546011)(52116002)(316002)(31696002)(6506007)(26005)(186003)(66556008)(66946007)(8676002)(66476007)(4326008)(8936002)(83380400001)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW16cXRoQmc2NUpVcGVKT3V6ZThaYVJoKzA2dTc1OWFPd1RLVlBEL1NFS2o0?=
 =?utf-8?B?WUNhU0NtSFV4eFY2a05CeFlhV1ZKZ3dVdUYvTnYyZGxFNkNpME9QRDlQanYw?=
 =?utf-8?B?a3Y5SHpBMVhvWDJsei9lSTJNMXR2TjFqc3BwcEcwd3Q3L2tPQmNIVGVHZUdy?=
 =?utf-8?B?SGxOWGhlVkE3UHA2MnNucG5nMkF5VU9IMHdtNmdxNjhqVE9USFcybEJWYWo2?=
 =?utf-8?B?S0lOTHBwbWVzVVZXbVhmV2p6NDYwVnpOL2NISjg5aGNOUXgrT1NsN0J2b25Y?=
 =?utf-8?B?YVU1YVV2RzhYeVNMVW1vSCs4T2poNUdjeGNGRCt2Zk9FeUR1N1cxQkhLajJI?=
 =?utf-8?B?eVFiZWZSaG1FNjAzWWhoMi9Ram96VUdtZzM0V2F3bmxHazZLUys5R1IwS1dX?=
 =?utf-8?B?b0h5SjByQ2lRLzZWRU9BTnVSK2luV1FKb1gySkw4ZjJHWVdkaWFqM2NGWGNt?=
 =?utf-8?B?MlpsbGx6MmVTeVpNdU9uQmtxYXY0WW50ajZqWml1YnVYR00wVndJcHNXWjJR?=
 =?utf-8?B?enRLdEhpRCtXVDZ6N1Z2VDlyYlhCRElGbWs0Q2JqTkxuNmVoVXZDWVBENzBK?=
 =?utf-8?B?cFRtL01XZ1l6MTNFak1wdGJUenRxYy84bVc3TU1ZRWxGMEgxWUROS0FaR3hw?=
 =?utf-8?B?clpicU8vT3pVVkJpcE8yRFRLaXVmWHRRY1pWdEllQlhOa0cxdnFUOUhacDBI?=
 =?utf-8?B?Z0dkaEpxdTNNTWZyU1o5QVQyQ1pvOFpxSjRkc1RSMUd0QVpKRC9wZDhsSGt6?=
 =?utf-8?B?Z29oNzhpZjAvREtlVkExdmExek9WMXV5RnY2ZlZFdDFBOVQ3NXRMT3BuZ1FP?=
 =?utf-8?B?OHBnOU8ydVp4M1VBc2VUeDdOTkpuL29PVmVDWU1QSDJPbkprNGhWekF3YWQ5?=
 =?utf-8?B?a29ya2tVUjlmWnVXUDQvZ1NRa3p1cHhEMHdwNERPbVpwcUljK0lxeXA2cjJU?=
 =?utf-8?B?N1A4aDZTL05OTFJmN1VRTldNWWFpMU1Pc0U0Z0Z3YkVENks1a3Y0QnFNbm9G?=
 =?utf-8?B?dkZJVG1jaDVlTWVnTWJlVzk2V1hHR1F0aWp4eEhPVWV3a0lYc2YyUFZFM0RH?=
 =?utf-8?B?dnVpMzZiWGJCd0JtZXV5ZkxlWmVRWDRDeE5ibkNYSGM5TmNBckNDNU04R09p?=
 =?utf-8?B?V0hoNkRkakxVNmdlY1NZQVhvWGt4SFlWWFUxTnJ3ajB5ZTUwcHd1eHROb2xH?=
 =?utf-8?B?SXJseHA1UGk3OWZIVUl6Nnh0NWxvYnIxcEFaSFV3TEt3UCtBcFhkWjZhR0RH?=
 =?utf-8?B?QUxlUm1oWDVOSk1SdE1sNVJhUWJ1N0U5NEFzYUxsSndhVkdkVEJyeG1vN29n?=
 =?utf-8?B?ejE2UkRteEdEa09vZjI1ZmoveFgzR3JJSjB6UWgwQk5JUVhRWkdWVGNQbUEw?=
 =?utf-8?B?V3ZVMUtHT1QzTmc4bHd2VDZTRVVIMFg2bDZWaXFPc21LN1JXT3puQXIvdFV5?=
 =?utf-8?B?Smtxb3FhK01SUnZJRDRQbG5teEl5Wi90UjgvdmlUeXdwa012UnNIalF1eUwz?=
 =?utf-8?B?d0VJYjhvRUxsbUFCRUo4by9WeEMyME83Q3lsdHRmVzA3Rk1CRUY4RVhSTTMx?=
 =?utf-8?B?dlAvTytFb015a01sRThoREtPdlNrb3U1TEZHYlVVUmY2Nm5tQnJVeVdwT1Vi?=
 =?utf-8?B?NjhWQWFzVUZnODNyM1BhL1RXd2FkQjduZ1dldjZldloxaWYybEpoeU5UNmtD?=
 =?utf-8?B?dGYxbHlicGo2cGM4UVJhQ21JRzhBNzk4cmliVm8xR2ZSVVFrSXZRSmlpcWpD?=
 =?utf-8?B?NHg3QmRYWmh1R3dqTmhrOUliNVdkR0dzc3Z2Qm4wTExwLys2bE56Z3FQSU90?=
 =?utf-8?B?YTFGTlQvRWNnNUphTmlQT3J5TmJ3MERwKzd5V1pqOFYzNXJaRkJZSlJhclNw?=
 =?utf-8?B?VUlnOGRLUVhVcGU5dWpPM3NrM2F3QVlBa2VyVnNLZzNHZks4WjUyZXpXa1hB?=
 =?utf-8?B?Q09YKzBuVlBRV3QxRDR1MDhodnZNRDQ4NUtBN1JMVU9ENzFYVWFZYnc4bURK?=
 =?utf-8?B?Rjk2ZHE0ZVRZelpwY1JVSXRHeE5XektQSkk4NXgrOVVMS2QrS2w5YkE4QVdj?=
 =?utf-8?B?aXd6QTZ3cXVLT3JralJ4YUp5dDYzYzZIV0d6NlFLNDZFUi9XOE42L1VWRGlK?=
 =?utf-8?B?ZzFBSjFnUmJQb2gvRVp1K0QrTVc4bEQ4MS8ra09YenFjSFZRZlo1VFVSbUsy?=
 =?utf-8?B?aU9MWmZMYmx5cGNCcjdpa3hYZUpMVk84ck5BcytkRS9zSXlUQW5aYzNsTXNI?=
 =?utf-8?B?MUl3SXJUNUphSjgwZzRpM1hKZlVDQ2JJa3FRdWkzdDhxaWtyMk92cW54S1h1?=
 =?utf-8?B?NmlwQm10bDNFK3BoNzNybjRhL08zMUhJRTIzNStRWnVnTXlramNvTWNnaUpB?=
 =?utf-8?Q?ucBO9JbcXOXyOSZQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5dcd68-350e-4b0c-c2d8-08da1b9c109b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 09:17:13.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dC6a272v+J31pfGB7ICLZWtE6OPfcw4vFlGtyVMoyzGV2nGuCrQ0PQbIhwrmjDXTD7aFIkpA94Y55K0BtNpUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5509
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.04.2022 12:47, Ming Qian wrote:
> The hardware is capable of encoding/decoding RGB and ARGB formats
> in whatever order the color components are,
> but the resulting jpegs look good
> if we start with raw data in BGR/ABGR order,
> so we will further only support V4L2_PIX_FMT_BGR24 and V4L2_PIX_FMT_ABGR32.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> ---
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  4 +--
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 34 +++++++++----------
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +-
>   3 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> index 356e40140987..e7e8954754b1 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> @@ -102,11 +102,11 @@ enum mxc_jpeg_image_format {
>   	MXC_JPEG_INVALID = -1,
>   	MXC_JPEG_YUV420 = 0x0, /* 2 Plannar, Y=1st plane UV=2nd plane */
>   	MXC_JPEG_YUV422 = 0x1, /* 1 Plannar, YUYV sequence */
> -	MXC_JPEG_RGB	= 0x2, /* RGBRGB packed format */
> +	MXC_JPEG_BGR	= 0x2, /* BGR packed format */
>   	MXC_JPEG_YUV444	= 0x3, /* 1 Plannar, YUVYUV sequence */
>   	MXC_JPEG_GRAY = 0x4, /* Y8 or Y12 or Single Component */
>   	MXC_JPEG_RESERVED = 0x5,
> -	MXC_JPEG_ARGB	= 0x6,
> +	MXC_JPEG_ABGR	= 0x6,
>   };
>   
>   #include "mxc-jpeg.h"
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 3df51d866011..8bee179c5cec 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -8,7 +8,7 @@
>    * Baseline and extended sequential jpeg decoding is supported.
>    * Progressive jpeg decoding is not supported by the IP.
>    * Supports encode and decode of various formats:
> - *     YUV444, YUV422, YUV420, RGB, ARGB, Gray
> + *     YUV444, YUV422, YUV420, BGR, ABGR, Gray
>    * YUV420 is the only multi-planar format supported.
>    * Minimum resolution is 64 x 64, maximum 8192 x 8192.
>    * To achieve 8192 x 8192, modify in defconfig: CONFIG_CMA_SIZE_MBYTES=320
> @@ -73,8 +73,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.flags		= MXC_JPEG_FMT_TYPE_ENC,
>   	},
>   	{
> -		.name		= "RGB", /*RGBRGB packed format*/
> -		.fourcc		= V4L2_PIX_FMT_RGB24,
> +		.name		= "BGR", /*BGR packed format*/
> +		.fourcc		= V4L2_PIX_FMT_BGR24,
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
>   		.nc		= 3,
>   		.depth		= 24,
> @@ -85,8 +85,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.precision	= 8,
>   	},
>   	{
> -		.name		= "ARGB", /* ARGBARGB packed format */
> -		.fourcc		= V4L2_PIX_FMT_ARGB32,
> +		.name		= "ABGR", /* ABGR packed format */
> +		.fourcc		= V4L2_PIX_FMT_ABGR32,
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
>   		.nc		= 4,
>   		.depth		= 32,
> @@ -420,10 +420,10 @@ static enum mxc_jpeg_image_format mxc_jpeg_fourcc_to_imgfmt(u32 fourcc)
>   		return MXC_JPEG_YUV420;
>   	case V4L2_PIX_FMT_YUV24:
>   		return MXC_JPEG_YUV444;
> -	case V4L2_PIX_FMT_RGB24:
> -		return MXC_JPEG_RGB;
> -	case V4L2_PIX_FMT_ARGB32:
> -		return MXC_JPEG_ARGB;
> +	case V4L2_PIX_FMT_BGR24:
> +		return MXC_JPEG_BGR;
> +	case V4L2_PIX_FMT_ABGR32:
> +		return MXC_JPEG_ABGR;
>   	default:
>   		return MXC_JPEG_INVALID;
>   	}
> @@ -697,11 +697,11 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
>   		sof->comp[0].h = 0x2;
>   		break;
>   	case V4L2_PIX_FMT_YUV24:
> -	case V4L2_PIX_FMT_RGB24:
> +	case V4L2_PIX_FMT_BGR24:
>   	default:
>   		sof->components_no = 3;
>   		break;
> -	case V4L2_PIX_FMT_ARGB32:
> +	case V4L2_PIX_FMT_ABGR32:
>   		sof->components_no = 4;
>   		break;
>   	case V4L2_PIX_FMT_GREY:
> @@ -729,11 +729,11 @@ static int mxc_jpeg_fixup_sos(struct mxc_jpeg_sos *sos,
>   		sos->components_no = 3;
>   		break;
>   	case V4L2_PIX_FMT_YUV24:
> -	case V4L2_PIX_FMT_RGB24:
> +	case V4L2_PIX_FMT_BGR24:
>   	default:
>   		sos->components_no = 3;
>   		break;
> -	case V4L2_PIX_FMT_ARGB32:
> +	case V4L2_PIX_FMT_ABGR32:
>   		sos->components_no = 4;
>   		break;
>   	case V4L2_PIX_FMT_GREY:
> @@ -764,8 +764,8 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
>   	memcpy(cfg + offset, jpeg_soi, ARRAY_SIZE(jpeg_soi));
>   	offset += ARRAY_SIZE(jpeg_soi);
>   
> -	if (fourcc == V4L2_PIX_FMT_RGB24 ||
> -	    fourcc == V4L2_PIX_FMT_ARGB32) {
> +	if (fourcc == V4L2_PIX_FMT_BGR24 ||
> +	    fourcc == V4L2_PIX_FMT_ABGR32) {
>   		memcpy(cfg + offset, jpeg_app14, sizeof(jpeg_app14));
>   		offset += sizeof(jpeg_app14);
>   	} else {
> @@ -1277,9 +1277,9 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
>   	 * encoded with 3 components have RGB colorspace, see Recommendation
>   	 * ITU-T T.872 chapter 6.5.3 APP14 marker segment for colour encoding
>   	 */
> -	if (fourcc == V4L2_PIX_FMT_YUV24 || fourcc == V4L2_PIX_FMT_RGB24) {
> +	if (fourcc == V4L2_PIX_FMT_YUV24 || fourcc == V4L2_PIX_FMT_BGR24) {
>   		if (header->app14_tf == V4L2_JPEG_APP14_TF_CMYK_RGB)
> -			fourcc = V4L2_PIX_FMT_RGB24;
> +			fourcc = V4L2_PIX_FMT_BGR24;
>   		else
>   			fourcc = V4L2_PIX_FMT_YUV24;
>   	}
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index 9c9da32b2125..6e8c5aa7d956 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -17,7 +17,7 @@
>   #define MXC_JPEG_FMT_TYPE_RAW		1
>   #define MXC_JPEG_DEFAULT_WIDTH		1280
>   #define MXC_JPEG_DEFAULT_HEIGHT		720
> -#define MXC_JPEG_DEFAULT_PFMT		V4L2_PIX_FMT_RGB24
> +#define MXC_JPEG_DEFAULT_PFMT		V4L2_PIX_FMT_BGR24
>   #define MXC_JPEG_MIN_WIDTH		64
>   #define MXC_JPEG_MIN_HEIGHT		64
>   #define MXC_JPEG_MAX_WIDTH		0x2000
