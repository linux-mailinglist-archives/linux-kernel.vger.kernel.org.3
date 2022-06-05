Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8035A53DD25
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351285AbiFEQnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245118AbiFEQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:42:56 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E94B41D;
        Sun,  5 Jun 2022 09:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb60Os5neLJHOkHEVohnc9pyCUQBNRhMZLBSbB5QW/hA51mSqj1Ba1b7CIWis6VtyOdNhriENNGxeOxo0ongRUKIgn+Z9wC3SNBXPoorntewAFBwWqIm5TmNjB4P2ASS8fxshEU2oRGM1qzktUwUaxSkxZwEciXRRnLFNrdkgpu9fT3NntljemjJr/JI17B7GbQaUip4Gg5n9ndQt892MxJSN2k10nlT+k0tSWTcpg5Xne/r45NtYWgDxacbHP8w8zuAO3pvIIPJawKVFIYTonkaV+ecf2C58/WeJWiOtu8pfOg/zaQ1zg24Jjs5mRRpovicd6mQETYU6Mhw7zrWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2Fai1R7IfylYcHSkUlyueWN6kQYkJo1H0DDRSYK/Ig=;
 b=nDuRyLwEfJBZWnou30YHqgAHW2wZ+Ho0ahaDDNdpUYAshCYJJrH0hyN8kdLgrgx9Ju14TTm8gCWWvHkRh/gSSMYoiaTjZ08/8n+jKSM00HHvY4KyIfqydYJOtAzSYe0P8+wLoWErjjxro5vQvg5QBi6nj4h5JEIX0bW9cKgIP6GamBXcbgLhwK7n4mtkP/+JBODCjjLoh2VnMP9zLXSb3wS2e6rdoQ0Ukg9Hi8YRwILcW8tV8esdiVXVtVW1esMUOmk0Y9ejlfABfvABPC8FW6y8IqAhDG422Ej8AWQY+XVsLV8HNK4THDpd+KPClnGVmp53h7DWDcAeKjrBS9OUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2Fai1R7IfylYcHSkUlyueWN6kQYkJo1H0DDRSYK/Ig=;
 b=VWcyhBI3u0qHQmLfJV/PO4WIAAAVLkYxehCzQ/Ewl9zoFKvOjkCffOJYKckn41neQYXdpZN0lJlVGE+Yfhn9EcAP9LYflJ1qsGKn5uzBQaG8r7I/qBvCArOX037jS8VoSnqaDmXVhSfeit8NnWG3IeN2yHr65rMXFd7al5hWQAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AM0PR04MB5860.eurprd04.prod.outlook.com (2603:10a6:208:133::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 16:42:51 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f%8]) with mapi id 15.20.5314.015; Sun, 5 Jun 2022
 16:42:51 +0000
Message-ID: <69817804-a618-32ba-06ca-3ec38ff1f124@oss.nxp.com>
Date:   Sun, 5 Jun 2022 19:42:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] media: imx-jpeg: Disable some unused interrupt
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220530074756.14585-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220530074756.14585-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::6) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 346fe31d-1e19-4430-cd6a-08da47126e7d
X-MS-TrafficTypeDiagnostic: AM0PR04MB5860:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5860D85C69EAD9FD1E088528CEA39@AM0PR04MB5860.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAPQ0BhICjbRQfqbTgHEYqu3+7MiKZGx5exiHDFxxZRHhWVyMbGnMMoZoDSl8GJmaM1BHbU8L3BLaZaQ0Kbxe4R2g+d+YjFu9xk9G1apg9L03htyOAd1TBYrI8UYlxoiIeYLwWoVS4I2YxvihUmfNXL6Bz28eOQ0a56C2RSBSDSmvCOT6NhtCdBqn1dYjKvkyBgG/DP4ZQWVdkMyPNQNDXR0iSDJ582rTrv8KjtgxpdixLqvEA3CgYHtg7g8imuJ4QQ1RljP2KlVS25/QDHn6TNuUiFhWx/8XiElH3QnKbgIHvLe8/LOMVO2EZKPNssUIlOESUW+xnM1cKNIDuC73+TIDO3ZqRltrIs/ovaGEbn7JpB6J813NWkbVYGCjUauk/gHywfBpZATRKhgsG6jPCLpkrG9DIR4wnCw98mYysyEUug3jU2UHRaAdUtDeu/3L0LQCFMjhv41/D8Pk1eKfpA/gr8hYnBOUSbupjQ8qs1d3Hd8keaOn2qSbJ4hF2rwLaEfnJrwN8Nz82OyLcosMKRqc3AIslXB1akZfPcqfF4DvWz5PakShqNGtJv9otn8k8CVtUZ7pMFYV+tAHdLhPTABi8ujzSSwL3fLX6rZCSdHSkgzTRuboNXgOx2EInFbGqhiqToQ2WPrfjRUWL4XAOzfRsv2oMGojMPqJreCo1EjyFMeLFIaB8wV9Jq4QGleo+8mPfAotahwoNjhpA0xMYy0WnmIntcpeD7nfMa4+lbb32Y/VyFVseIBYnRjzQ6gaBA6rtzWyQHnydrBcs/vNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(5660300002)(6666004)(2906002)(53546011)(52116002)(8936002)(6506007)(7416002)(4326008)(2616005)(8676002)(31696002)(186003)(66946007)(66476007)(66556008)(38350700002)(83380400001)(38100700002)(26005)(6512007)(31686004)(86362001)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5nL0VqNStmOUIyZTJrU1Y0aU5pdFRlYm0wemllVWdzaWN3NS9SSnZ3TnhY?=
 =?utf-8?B?WEJwYjZyRWM0ZXBkdXA4MElLZGw1NndqU3JIQ1BsWlVlYVc0cFRmVGlHNVd0?=
 =?utf-8?B?Yi9ZREQ4cm1rQ1hITGFzNWFOMUFWM0hXOHV5Qll3NlM4blA2Vk4wUERLOWha?=
 =?utf-8?B?NEE1bU9WM0sxQ0FRUWo5OTY2MmxaWDB4bXJOY3ZlMVZ3dWhLVSs5YWVMa0JB?=
 =?utf-8?B?MUtqMFM1OWNIcVpvSUNEcjBUS1hUWk9JZ1d0QzFneGJRLzVjNnZJcHhYbFJS?=
 =?utf-8?B?dForcnFqZHhNTlFPd2lWdEhJcnhTWkZxM2JqSUFQeExRVitEY0ZUQmtwSG1V?=
 =?utf-8?B?K09uZkdRbmlyZFhzOHMzNFdNdE1CL0dkcGVHc2ZxMTV4d1FTZGNyNlVCNklR?=
 =?utf-8?B?YzJzZ0NhaE9VUUdHT1pUZXBkemk0NUN5aDNta01zUXZTbUhZZ09uWmJ5a0kv?=
 =?utf-8?B?clZUNlljNVJEeWRxK09TUXFySEcrRXpjZGg5NCsxdjBORUdWVFBSUUV2SjRE?=
 =?utf-8?B?ckJtazAxcFF4ZmhNendhVzJGcnMraXg3dUpyL2FSUlVvUlBTc3dFaURiS2NK?=
 =?utf-8?B?bnlqak4wTk5UZXdLV0FWZ01WMmE4bTRhNW5pang3c2VGeGtzTkcyalZNYlFt?=
 =?utf-8?B?YVhBK3BVdFlFM1hCN2g1OXdvZHhUSmRpTVVDWlh5Y0ZFUDIwZUpQazJnWnZS?=
 =?utf-8?B?cDR6QnJrekdaVXJBZE1lMWNEVWRkbDUwNTg4VDd0QTJNMk1xYjAremNOV0N5?=
 =?utf-8?B?VEcrUGIrSjRxWjdQajBsY0krN3NTZGxNTk9kaVg2dVFBK1RNZk1xQy9CbFlz?=
 =?utf-8?B?L3NleTlWVUlYOEMrUjhScUp6YWtBaG50eEI0OGlYYVFISW5nRjNxZUNsV2Z5?=
 =?utf-8?B?ZmpFSm9aUzBLVWZMbGY1WnB0Ym5Edmo3cWY5VURxMTUwT1dqdEdKWFlPaHpw?=
 =?utf-8?B?K3orOEpiUDRxTEk5VEIzdTJTeCtJSkMrRmduVGRSZkt4OEY0OFB2UmRDR2JH?=
 =?utf-8?B?YkhhWnV3dVVncUdwY0F6b0F4M0lXcytWZWpxOVRoZWlnOGZ2bklzclNncTha?=
 =?utf-8?B?am9ta09VY0pWQUhhUEpJSjl3VnowaHR0cXJVaG5laFVaOWdqVk1yS0c1V0tR?=
 =?utf-8?B?RGdzWE1CdVBUbjU0MEFrRm5zV1ZZcmRLeG9hbFNNRkdhb0VWMnBSV2VPNVBh?=
 =?utf-8?B?U05pS3hKRE01SEtINkE1cG9paEtESXY5VkxTN2ZmNk1BdEVYUFFseStnN2NP?=
 =?utf-8?B?TTU4M3NYcVQrNVd6YUJPdXRiOTgzUVRYSVVZSkZUcFB5aWhmR3RvMzIvTUNl?=
 =?utf-8?B?aWZnK1NWUzNVNHp5aXRGWkxobGx6YXlqYVFvbit3RW1mSDg3OU93S01ocDRU?=
 =?utf-8?B?VC84Uy9TcFR6amovak5mK24xamF3MWZyYm93U3V3VXRvVS9DelJuTm1idU15?=
 =?utf-8?B?c0VMNHFCVU5UWElraXgrMk1ZSmgveUZHUFFaSlNGUUpCWm5CTmRiY0l3aWs0?=
 =?utf-8?B?T1JsOXpKUFdsTzN4MGljZWJYVEQ4UFh2VFFZWGdaOGxKQ3Y5czI5Nzc5TFlD?=
 =?utf-8?B?UGQ4Z1BWSHNjYlF2MFZ3ZmFjZDdxbEswNTVPU0FpUEtERFhERUtRVWVTbkxo?=
 =?utf-8?B?SC83Y1hUNEVIVnd2TGVSdGVWbWcrNmYybDdpUi9HY2VuNG9lVnhxL2VpOTNv?=
 =?utf-8?B?ZEpIVkRtSzRuOU9CR3VieDR6VFB1bG0reFJLY0x5ZExOUGI4TFRMdkwxNzhV?=
 =?utf-8?B?dC9uRm9LQXdvUzhjaGFRTTdDMHdTYU5STGRMMmRsTSsvR2FLTWd2YXcrdGRo?=
 =?utf-8?B?NkMrOGlockVURVpNUko2M1JORkUyMENnVzFVZWdKR0FRcGNZU0F0Tkl0T2hZ?=
 =?utf-8?B?b0o0cmQ1VHpGaHYxL2RoMUdNRTdxTExCVWcwNXFXd3dxTWo3OUZ0NXlwL2xT?=
 =?utf-8?B?MFV5YWVvZDZMTEIrUW8zZ2JHZSswTXg4TUoyd2g4SDJtV1ovM0k2aUhaejAv?=
 =?utf-8?B?bG0xUFY5YSticzNuNEhDS1g3Sjk5V0JKQnRFSnh0cDQ2cW9sRTVVSXRYb2JZ?=
 =?utf-8?B?SDd4T0dWUHBvUCtXbm54ZEJ1K2xMSnl5VkpVakcrbUh6U3RmVnN0c2VNNFlV?=
 =?utf-8?B?T1BnSSt3TXAxajZsVGlrcVdKTFB2THhTZWFmeXZzdXFQUFBjc0pTa2YwL0hr?=
 =?utf-8?B?RmZXU2pUZ29xTGxvb2U5Z1d4MEwrZlI0U1dIQmdHa0tEZVAvcHp2amg1YTNv?=
 =?utf-8?B?eTduK1QxTFAwWFJ0TzlndmdQaFY1OW04QjMvZlo1NU1qdXB2djU5aFZ3T1Bs?=
 =?utf-8?B?VEdLWE1sZzd0aFlnNGhDK1hSUGlZV3FsZTBkWm01TFRYaExpbmZ2a2V5MHRF?=
 =?utf-8?Q?J3fzaL/+vitp9mJo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346fe31d-1e19-4430-cd6a-08da47126e7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 16:42:51.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiukZXcRSwbfhn48bdok2wYXhV+toPACNh7RYnQCYTPqVRl70rZkeMkMR1g+W93XGPD0VKtwO8UarLGwp6JAeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5860
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 30.05.2022 10:47, Ming Qian wrote:
> The interrupt STMBUF_HALF may be triggered after frame done.
> It may led to system hang if driver try to access the register after
> power off.
> And interrupt STMBUF_HALF and STMBUF_RTND have no other effect.
> So disable them and the unused interrupts.
> 
> Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
> v2
> - add Fixes tag
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> index c482228262a3..258fbee7ab66 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> @@ -76,7 +76,7 @@ void print_wrapper_info(struct device *dev, void __iomem *reg)
>   
>   void mxc_jpeg_enable_irq(void __iomem *reg, int slot)
>   {
> -	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
> +	writel(0xF0C, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));

There is another way, less aggressive, to go around this, disable all 
the interrupts once FRMDONE is received (or some other error condition), 
interrupts will get re-enabled at the next device_run. I checked this 
works, in mxc_jpeg_dec_irq:
buffers_done:
	writel(0x0, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));

Either way, I would also replace this:
	if (!ctx) {
		dev_err(dev,
			"Instance released before the end of transaction.\n");
		/* soft reset only resets internal state, not registers */
		mxc_jpeg_sw_reset(reg);
		/* clear all interrupts */
		writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
		goto job_unlock;
	}

With something like:
BUG_ON(!ctx)

The initial intent of this code was to cope with the same problem, 
STMBUF_HALF interrupt received after FRMDONE, which could not be 
cleared, but it was not done right, I can see the hang in some rare 
cases. We should not run into it anymore, with interrupts disabled, 
either the way you proposed, or mine.

Regards,
Mirela

>   }
>   
>   void mxc_jpeg_sw_reset(void __iomem *reg)
