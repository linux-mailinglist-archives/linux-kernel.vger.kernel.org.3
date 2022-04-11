Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A514FB680
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiDKI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbiDKI5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:57:03 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC95DF09;
        Mon, 11 Apr 2022 01:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W59iYw2MMTj+eB69ivLu4WvWuLnXVVnyQR7BVe7Nhdocd59fjSUDGMHSGp8piu/3M9tWlxeVyADzCMoNK6KVwtVWtihAI41nDt6m4STlmCl8CuTpJ4hHjOPCRwZHWolXJfgXKkpCIrY3pKnghQIZTKzJq+6YQElAtnZjMgIQwAEIAizXCvUIQbGpRxsBd4vzgNYXdRC9MEh/8Q6hXqXl4T+gFbaupu7R6Hfv3KhKXyIz1tnS/UczK17jxHCO0HeJ4tuKYkub+edbhQKOwcTjqT8fvo2gpVGfJnjog2CyyyIzUkLvoZMT9DrohB2SdpToMhXKt2S4NH9SFZZEPrKcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+ZpSnZcEQezavDuUUmyvQmDQ+teb/OWpL14pRo2W+s=;
 b=F/rMKsJW+Vi3gEKF0HM+Bv3DDB4LeZNOWxs3332BlXXncb522zd94NYeU83qXN5Vj3XuylVX9iJoCJDvcmUVAUpPBAH99eSzTZTX9yen1+rUqfjtc+RY/uKfOH5PMLrhtLGcXRNaZq4jRb4m5F7ImoHFqb4t6h/zCS6e9bnAziRSc6R9TojhwGvBT5r90AOGZC+mvGa1FpxetDOxU2IIGQHbfiutM91jpsnwI4fV4jALme7X+EWl+c7jD9eFba4EkKGzWlE0o9HNjeHDnvce4BRL35X+ojT+Nju0spRZXq4p49IWR9TXLbc4BFZL66LCF96mtQAVOqIpvA/8Pnim2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+ZpSnZcEQezavDuUUmyvQmDQ+teb/OWpL14pRo2W+s=;
 b=IlmIVHOjgrr9UftEuWOpgHGiUy69V5oxpdQ8dz//BuuunFWmrunXnjg/gDEPMnS9i+mj/QsVzJXtoLdGUDWK4zXl+3GBUHzEhr3Wp+Vr4jBmDk0m5dnQOixN3AzjSTylt/SZ5VTacxFyGHIABf6Y909C+5ffH5HGcTPNnqOYI3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by DBAPR04MB7384.eurprd04.prod.outlook.com (2603:10a6:10:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:54:46 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af%5]) with mapi id 15.20.5144.027; Mon, 11 Apr 2022
 08:54:46 +0000
Message-ID: <7417ea3c-e9c1-84a6-19bd-58787b5572ab@oss.nxp.com>
Date:   Mon, 11 Apr 2022 11:54:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: imx-jpeg: don't change byteused of queued buffer
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220411081953.9021-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220411081953.9021-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:803:14::31) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c80210bf-c270-498b-6e5e-08da1b98ed5f
X-MS-TrafficTypeDiagnostic: DBAPR04MB7384:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB738466ECB57D5829E98EC5F4CEEA9@DBAPR04MB7384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SLA/sry6PaGtzc/epqI/Ok6P1WapDA1ozz853QD6Mg7+toj70CQo8Q1uEljsnnQnJIYj63EqqEbNVRH/zU4xYlsvSlT655DcRhVo6DkRIm/JcU+Y4c5KeltXULHZux4rI/ggbIzdN1ZSmsLoLJFYZc5ERiDpnrTUwvk6sQG+K5ilovbL4lS4meudqN3Fg8Zxo6jbr1BwG/P7aWy3a8KdYgGlXy0O3kmXM+otD4ertIXWYI93wQ/pO2qfbM3Yh6Z6IPvHNUWhxHXn5YxF0Ta2VyOXqtoqhwBESfxUCqLUmctIDuRYfHJ40+Ckt1Y36vGN7LzgFnjOOSF1oPuDNW4pIMtWMymr1g4h6AeVlbkp7Jqf9IzFah2sxZxD50TecPUlBD5l2lG/MyLIF+xX9JJIxd/9di8+g4Xz2/CePtNZZj06QVxyy1BGtSZwqMW+jxEoFAdv2XNKZyWvE3ATTO76EXpHx8Lj7zvi4oXld6842YLweik6n+eBXWV7dY2UvOqMUn7RQKfa5se1aplvdHbNzCRCznVoF7Z1HeeFfn6Um71pBkyvUGeUsMjaJkmtpcAOrMX0Xam2EuGmx1L/+MSpvdG6ZSWbQNcnE+e76Eq1bP2cwHn3B+Z6fTZHoSXWsHhgehlgUzykuDYwYaPbqc90NZvzUBmQxgRwhYvgoCwDzVbqRa/T7helXeFTXMmNHrX3KunfhUUNwq+LnhFxQshDVWNnKN95PZp5b5Hm0FdVJn6QfJHg8HDkUbP5VwmueqoX4sUnnUicgxx5u7wgDYABg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(4326008)(66556008)(66476007)(8676002)(66946007)(7416002)(38100700002)(31696002)(8936002)(5660300002)(2906002)(86362001)(83380400001)(6512007)(6666004)(6506007)(26005)(53546011)(52116002)(2616005)(316002)(6486002)(31686004)(508600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS9RejFzQlJRTWpIcGtRYmdxcTlJenhEeXg4TW5zSDhDdWFxNVNlejE3L0FD?=
 =?utf-8?B?ZzlYZjQ1ZGtzZmU0dDlmSHJ3Z0tWNFpIeTByVkU1V2lXK1FtUHF0aUZPL3py?=
 =?utf-8?B?cG10Y0FaVWVDWTBZQmQ0WHlDbUk4SUJuR0dwOHk1T3BYYUl6aDJoTXVIMXVz?=
 =?utf-8?B?eU0xT2RpQ1pXeGVUWkFHRld0cFRoTGNtSjBhSnRVMjZRanZyNlAxU05uV0VS?=
 =?utf-8?B?WGs1UFZmT2J5cGxYS25keTZhVlg2OGVqWkZaUGRWTThPTWpZK3d1NHAyZUVR?=
 =?utf-8?B?OExzd3ozOUVuRklCVGwyR29ra00xc3I3YWw3Y2NqOWNvWDRHdm5IUUlsVmFu?=
 =?utf-8?B?NGlUUlk1UkpJdXppYlphdytrZEtHNnd5ZHRaZTRldnVUOEpQVFBxUkYvUlB0?=
 =?utf-8?B?Y2swZXRlajlURCtxZnIybkFtZllhd2RuSTVmQ2pjVzNLRk8vcERMVWoyaXVr?=
 =?utf-8?B?SHBPaW0weE9NUTBxVWRYOTRIKzQ1TlBwbEk3NmR1SXJiQVZSdEpNb2J3b05E?=
 =?utf-8?B?T2tWZUpVL2RDR2o0TmZpWnBta0NTeU85VmFXMWkyeXJQTG5xS2k2RGJBNUNy?=
 =?utf-8?B?U1krY09sb29TSnlSeVVUSC9FQktXQzMrV1NyZFIxK3VneVVGcTJScGZ3NTR6?=
 =?utf-8?B?U3lCQy9PMmxQZXBtV1B6TGlGdnkyUm5uODVXeTB2TytmYWdKb2kzVEhKTWRH?=
 =?utf-8?B?cHYwKzJjL1VFVzlMZ1JFN2I1ZUJ4RHc2bThaMXZyZUFiWHhvdSt4Ung3eHdw?=
 =?utf-8?B?T1c4dmRYenIxdWhSeGs2L0pGbXR1NW1tWStBMkNWRmpyU0hlUEZMNHFXV1N0?=
 =?utf-8?B?NHZpVWlBUXpVU1phWWlTVWg0c1VsbmV6N0ttQ0llQkZxRXFreXptdDJMU241?=
 =?utf-8?B?YjlrMDJUNENySXJscWhuYk9lY0VIT0lEclhqSEJ5dlVuOXBiOEI3VnhRc3o3?=
 =?utf-8?B?TUJZWXBKbkxhZFV0WGFNN21nOFlDZllvTGhybHZLQnU2clFDTG4xZDBIUXZs?=
 =?utf-8?B?VVU2eUp1QVlNQmMwcnZSd2xVWFU3enVpMU9jOUkwaFJSR0VYWVVSbHVBbUlH?=
 =?utf-8?B?UG1aT2UxVG1yT3JyNHA5VDcweEJWQVlneGRoelIwY3R1NFdXbzc2UTB0SWVL?=
 =?utf-8?B?MnhNUno4Z2hydndPalRCcTNyektBVEx4Rjd5dGpQNTVqS0p6aFVRWkc5dHpL?=
 =?utf-8?B?NC84VWpEempSU2xSYlNSZGZxd29xZm9DN2hRYzFyZXAwb0lzL2tqck9ZVE1P?=
 =?utf-8?B?emRFMThvUE1EeWU2d3Jkb1RjT2pqVjZQMkhlY3gvdlNRZUJPZHFkWXY1WXdI?=
 =?utf-8?B?Rmt1NXlKcXdwZFpibVB6WmFsL1liNnNFWFYrSHRxNCt2ZVlDYTBwbS9qYnQy?=
 =?utf-8?B?TFh4Zkl0SEQ0NU9Sa3NiOW1XVFdNZXNudHlYOXNiQ1FmM2Q5enk3dXUrenVS?=
 =?utf-8?B?bDQ2ZUxMUG5LbG5zZ01rREdubi9ONlFJQzlVcDY2NFZyY0tiNEJiU3NCckxK?=
 =?utf-8?B?ZndFd29hcmdicjlWSXdHdGUvS0ZteGh3ZHNzYWhCdlpFbmQ1L3lDVDUwM2VX?=
 =?utf-8?B?NFd5T2dpaC9XcVBIdXVQRVFVZG16RTJZd3hxTnY1WnFTM1k0WHczc0VuMnVk?=
 =?utf-8?B?bkNmU2tIbndCMmZXaEtKZ0hnNjc0T2VxVUhOU3plL3I3MjZCdVMzbXRKMk5D?=
 =?utf-8?B?WDc3UHgyMDJLdnQyYTA1bkt1Z2lPenNYRjE0V1NQa05UbmI2RDdOMW9NNDRt?=
 =?utf-8?B?MjRwUjEvdkZaQm0weDBNRlpiOTJlTzcvWkFWUC9aaG1oRStQMGRza3htT2xS?=
 =?utf-8?B?dWlKc2VZMVpRcGxOOFUxbDcwMnJmSWFqaE5hRFhzbVVpTTNRQXhOQVlnK2lm?=
 =?utf-8?B?cUUwdW5OTWVmU0ZnS3p1MFB3Y2xnRXMxZ1ZScXFLMDkwWG5BWXZsZjVlNlM2?=
 =?utf-8?B?eE1OdDhpQWc5emxEVFBWVkxlSVZLNkRWeEd3c25pUldnY3p4L0lwVGphMTFW?=
 =?utf-8?B?VTFDVjRKcDJMQzgwb0h5bEx3bVpmZmhaNHpkWWlDbXNtWGZVeURVOWcxQmc5?=
 =?utf-8?B?NlVuOFE4bGt3ZUFkNElmeGZFbzZnSE1rY2NNQWlCMUc0NjlGODZhTjhvZGh3?=
 =?utf-8?B?czI2T3dIUmIwL04yL2hITkNIaWZubW11cllTbEZ6R09wUUV1clpxUTM3V2RY?=
 =?utf-8?B?UWRsKzAwU0FYZXlhY0VhWS9ialB3MjdRV3UrOGVtNldHYnFiZi90RkJZQUlF?=
 =?utf-8?B?VGJHWFNDR2pHVGtuUXVsWWlpODVDTGlTdGRtQmdrcE1lWmIzK2NCckcrQ29R?=
 =?utf-8?B?amQ1WU5zdnN3Mmoyd0lRbVFvdVZqMi9SQzBHbFJqbU5KalF4ME9RWndsWTRY?=
 =?utf-8?Q?jMtqbqaVGB1sRVB8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80210bf-c270-498b-6e5e-08da1b98ed5f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 08:54:46.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qP4B4Xl/PU9ZW+wpSLfPPludvWAuTCGVOddlUkPJMOBWVSCssPKvOTivskWd2aTexuERi3p4rlK0XgyXeWrQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7384
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2022 11:19, Ming Qian wrote:
> Don't change the output buffer's bytesused set by user.
> Drop allow_zero_bytesused, since it's deprecated.
> This should also guarantee it's the application's responsibility
> to set bytesused for the output buffer.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> ---
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 8bee179c5cec..930cea05c40a 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -1470,7 +1470,6 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
>   				i, vb2_plane_size(vb, i), sizeimage);
>   			return -EINVAL;
>   		}
> -		vb2_set_plane_payload(vb, i, sizeimage);
>   	}
>   	return 0;
>   }
> @@ -1519,7 +1518,6 @@ static int mxc_jpeg_queue_init(void *priv, struct vb2_queue *src_vq,
>   	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>   	src_vq->lock = &ctx->mxc_jpeg->lock;
>   	src_vq->dev = ctx->mxc_jpeg->dev;
> -	src_vq->allow_zero_bytesused = 1; /* keep old userspace apps working */
>   
>   	ret = vb2_queue_init(src_vq);
>   	if (ret)
