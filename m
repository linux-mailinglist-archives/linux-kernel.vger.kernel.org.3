Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4050C5D3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiDWAzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiDWAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:55:19 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20082.outbound.protection.outlook.com [40.107.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00D1527B8;
        Fri, 22 Apr 2022 17:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJFjL5xUJjn+6ODWjsK9KJ0fme1lgH+NE1uY21IIykXPDR64bxUfkwHaYdUnGJQvB0GpOTTartzR8q2//qdKh+aw0OQF8EVyEFqBFigzT/Gkf/Couia+Kx2TBLfGTf9u5dzFfH8ekGCX5l3p3rvrjJvpsfL58jQmBrLAaJiE0Ogrjw1AeK1nvEdUTbUfHT2dk31U8ZDEOwMMSOwy952Jp4BsBP7FdNXm4mq55WPqRfoY6amr40p1jm4vqmVsB1lgLUvV6/oi7THfg6JGBQZKTEWDhUb+TIyIai2epLJYeUuessvJpAl1SHrRUxj2R4JDJC6F0LhWKKLUUk3b3Yw8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eooCWOIQxi/Y5sdRiTOG7bnECERJnRSGRUfvnDU7tys=;
 b=W1VACCPcQf8e77l10/UMYTBIBLk+S5WJOrVFBgX69Il1Jq/n8RSVgYHXVwGBB6i9x7bivTra5g/bo0SpXDDWQ7BnVVirMTl7lSLM3VP/y/iOiHc1TrALmQqk73wy7thd3ouvhmchC0mZaLwe9KIBm1+Do2sa6yOdcRCUurMr4SnVB1YmTvU6pMFOcjMgCqrrgvtt0Dyq0g9xJB8NWdZ7GAg9Dum9nbLrLO7UDNUzycQm1kWUU8kCIhjM+aE7xE+FiFGrhQM5KySBHLsd1iYepwG4RAdjxZ7U2gFWVGrhKD4pExI3U3M0Sdl+Ueiukc5h3THVPUJ6dk189dZuSPcy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eooCWOIQxi/Y5sdRiTOG7bnECERJnRSGRUfvnDU7tys=;
 b=Q0ysQt2emclC6cg4QaWYEV1K4F3IgdfIqd1VsLrOexNWoZk8VXpo3ymsgupIvuZM8ZUcGKcKdW0c8qG+swUYQt+Sct+p49RcwoMG2L+bexEoOJ5Lf4+mxl3o9dRvZ9Z3iAvRw7rqQ0BzexXeZwfw9oGEf+153J0q10aDLbWYkwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Sat, 23 Apr
 2022 00:52:20 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::255c:3e75:6c8a:54c5]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::255c:3e75:6c8a:54c5%9]) with mapi id 15.20.5186.014; Sat, 23 Apr 2022
 00:52:20 +0000
Message-ID: <d6ac234f-c21b-b583-f375-1e7cbdd89adf@oss.nxp.com>
Date:   Sat, 23 Apr 2022 03:52:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: imx-jpeg: Add pm-sleep support for imx-jpeg
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220406094703.8229-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220406094703.8229-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0285.eurprd07.prod.outlook.com
 (2603:10a6:800:130::13) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed9a94a3-fb5d-429c-60d3-08da24c38520
X-MS-TrafficTypeDiagnostic: VI1PR04MB6957:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6957AAC0FEF0F75FC451E783CEF69@VI1PR04MB6957.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABoXWxnkhzmIeGzmOVAn/6U700SQlD49EBdZxRplAm7ndJFJ94H1qmJifAQbmUjlBC1owNverfkCsGXdcg/gbFIYZJzssPbP2PKpeMWr21AnoT45hTffNpcOMk+MK0rd/ZN7EfP7kWfLDE3LDFBOl/vA/+sKP5hkW1lUpUIEJBNrIIrAeBUvdrqGAU6CymvQkV28S94dVQg6IyoshKWgz3GA1NIajoJKwYbptK+qXdeLHfjICf8b2d6RCck3HzqYAFXy/4w/SZxKpOoznwnyv4q/sg55jUu8Zt8eJb7V+O1TNCDoLu0IHr2S7m2eZ3UPwxdZ7ZeI5OIHQIU/9a3GLBwJIShUIUUlk81tN3unXKUHyzbHsdROK7AexXknqfnQG83C98veG/+1s10SUGKJFUA34biZzyoM0JsOTQsOSptkxCXahSsJKxB7WUcoUv1EVmbmsQKso7CkrNFHS9w+OjujYhWo+IaJesWY/dubPmeMDNdcUi6bGdbd1CRApWNbW819uxP4G3N7vlm/JG2jmTgWmqn77OeTS9fjZH657qp8Pwpac/jY4HfTsPApUp6BAvfRo6Gxju4mqCK+HyASolmwbg9bbcxL61RwTCX7y8gskSEkf/YMsC4ilvtvKvN41C82yUp6SgXsZBr6wrt2FUoZ5SyGRVvjffsrU8PZ7t7CAGby61pfnaCwYbRiIMr0wJMI7GKhWkI1zUPl+OYjYsIGZL0BeW902FRHjY3V52tXRbY2MoswgkUDJjLbY3VW/opFbZsI0Ib17t6jo+3hrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(66476007)(52116002)(6666004)(53546011)(86362001)(31696002)(4326008)(8676002)(26005)(6512007)(6506007)(6486002)(66946007)(7416002)(66556008)(31686004)(5660300002)(508600001)(186003)(2906002)(316002)(38100700002)(38350700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2pNdDBQcHp1cVE3OGpMbVN6bTdiSXgxaEs1WTBaYmtFTDlmOFNOMkc2OWhR?=
 =?utf-8?B?bHFyQ08vaGVudW5NNjdNNHRzSHJsN254czFqQjlIMWw4bFFSYkk5VlZGQVRG?=
 =?utf-8?B?dzcydmg0a2duTjhWcENwMjBpQmZJMHZVZktjZzJGckd0MlN3b0hLMHpEVnFR?=
 =?utf-8?B?ZzkvdE9EK1A0dE4vVlBqMy9vbGtiWDBqc3VhempGZ0RrcTdHdWJjVmozWHdY?=
 =?utf-8?B?UURqZkYzWDhHM3ptWUJJOVMrZmFCUS9PeTNqNkRJYjA4YUtzOXpEN05BRk9I?=
 =?utf-8?B?Ti9GSkdTQStCVmxObERiK2VhbkVhSElwQVVxbmg4YXdCT1JJR1BBRGNTSE1E?=
 =?utf-8?B?eHphcXpSemY3S3FDMEFQRDZLQk82ZjY3anFVUElRcVBVMXFKU0dldkRPOHMz?=
 =?utf-8?B?ekttT3dJaCtUUUZIcjZOOHU2MTNIdW1jUWZWYWtqZm95VFhKV1lDa1FqczA5?=
 =?utf-8?B?a05kUDZhWEJDUVJRRGRUZmNPWERiWnZmMmhGQVRESHBKcytENm8vSFZidEsv?=
 =?utf-8?B?Mm5keXBOaVc0S1c5MFRCU2F6UjJ0NStGSVVpTlBJZFFlQ2hzVm8vaEROclNi?=
 =?utf-8?B?MEZacStZV2M0K1ozSDRuOSt3NDlRSi8xVE9UbjN4Q1doZy9sRWtWMGtYM0tK?=
 =?utf-8?B?ZUFSOWQ2ZWZ4WEkzbndDdkRXL291NU5kM25hTDlRTENORHQ2Z1BtcDAvQjFB?=
 =?utf-8?B?VE1lbExSODZWbzZsbmgyTXRCcEJrZUVIZG5Jb05UUmlBbXcwcEpPU3U0dDVP?=
 =?utf-8?B?SHd3dGdUV0xpUUZPNzlGSWlzUEdJSnEzRktPR3lBSVppdzRnNDI3TFdEaDFE?=
 =?utf-8?B?Rnl0QmxsdVNtNWs1K0QxUlgySUFpbG8yVXVSUjQxeTlxeTg5S1FuQ2x5bXY2?=
 =?utf-8?B?RTcxeTk3WGdlR3lIdlhlSHd6cXhsQjBUd3g4NTVxZ2xvVmY4M1hSQkRubTc3?=
 =?utf-8?B?MUI1MDQ2M2x2ZElGek9MSHEwWlQ3VGJISXpHdjN0YmVJK3d4SGtVWmlmdGhj?=
 =?utf-8?B?a25XTGFaUEdhWmp5R1NXL1pkVElNZStjbDN6b05pUzZSRmJjbERqdHU5NVFp?=
 =?utf-8?B?Q2R2d2hFMVNvTTVjbEV1NVczRCt6TXZkZmF3NEdwd2hRSjlONm1jUWU2aWZM?=
 =?utf-8?B?VXB3T1puWnloQ2VJQTZVbXJkdzd5d3E5MU5uVWRxcUdRdVhobWxEeGZRTFJm?=
 =?utf-8?B?WGJCUlltOEpiVlRiVURLb3JhTFhUY1ZickdYL0lZS2JLUTdjZTRadFRDNzU1?=
 =?utf-8?B?SFZDa010OG0xZURkKytEb0lFWFFsbWJzY0V3YWlRTkliMWkvSG1wSERBS3BQ?=
 =?utf-8?B?Sm9hcS9wM29hQ3MxaFp3NDhoaVl0aU5weEYwWTlGUWlBSHdBd1NUampoUS9l?=
 =?utf-8?B?c0F4UE5XKzdGNjBSclJSQ1REbytwWXpHNjZENXlxWStmcEExZXZQbEpBMFVm?=
 =?utf-8?B?WnNKUEhqa3dDQjVEbzFNZjRuaXVrd09LaFBkV2NpcnFVQmV5Y0pENU1telV6?=
 =?utf-8?B?N3NZM0FDc29EZUxLc3llVS9OTXVuSjJrSlR5MWQvRUNuSTZwVHgyaGUwN2M0?=
 =?utf-8?B?WmNsMncwS01zd1RSRTdkWkxtVDkvMjR1Q1pPWDJqR0dMbFdxMy9zMkdDcTRY?=
 =?utf-8?B?OTZISlpBSlJLWXNENjRUSUxNOTF3MHFuTWYvd0pGTmlJd0VtMUJvMHdLN3lz?=
 =?utf-8?B?TjRpKzlYUEgrZ2FFeTQvSlJuU29ZOXNQUFFQdzFRMXJvenVYaTFtSGJlTFda?=
 =?utf-8?B?QUZCUGI5R1MyNlRBS1VuUTNHZ1hXTzRrazBlaTNiVHdGMThNWmlaZG9TMGZW?=
 =?utf-8?B?eTZZWWtxRGdCdllqNEFHaVp2cHoxTTJ3SEFmcTZPWnAvTCtmcFNZUnNlWlF3?=
 =?utf-8?B?Zm9qUmRMdGtQeHZ1dVdmRHJoYTFsKzN4em9walhQaU9VSWRnRkdDdmZ5cTIz?=
 =?utf-8?B?VDA3bTFzNzY3OGhqZlcxY0h4Sm5tbVFZYTdIeitKaGdXYkcwRHJVU3FOZTFq?=
 =?utf-8?B?dzNvbGlGTGIya2RlRkhuQlJ2d2JRMVEzNWJ0ZFFwRTJiWUVsalRxcm43M3Bp?=
 =?utf-8?B?VXZtMmtKK0VnUHN4TXRhT2tDc1QvL0hrdkNGMkJqcm1aSmkvQjdybEVxbWtT?=
 =?utf-8?B?ckZnU1VHY0cwYU9pTTBsTExrcGxrN0Z5Sm94ZFVhUitZais0YkpiSU02ek13?=
 =?utf-8?B?OWFqc0tXWUlvTDMwMEVaRk1kbGpuM3kzcDNVbjB3ZWJDalpyUXNyUWcrTWNR?=
 =?utf-8?B?NS9nV0M2cTBJV0Q5RnJPYkFNSE1SVWVORzVqbEZFaklVVk5JSU5Ia1lDWHIy?=
 =?utf-8?B?ZjFkdFVnYmNsOXZMNzJxUVZONytzbmlXektIOHorbDROYjRXWDFWUEk5MFVC?=
 =?utf-8?Q?4ixySPCOANocEsIY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9a94a3-fb5d-429c-60d3-08da24c38520
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 00:52:20.0028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAqrv3PKPF/dRLaOxYuW4WF7M+nkcLP5UbkRxLIVfD55RAesaTu0Uz1tOW4zj74tLNfY4YKTcJXxxMRnijCb+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.04.2022 12:47, Ming Qian wrote:
> Wait finishing jpeg job before system sleep,
> otherwise the encoding/decoding can't be resumed after suspend.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> ---
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 24 +++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index ccc26372e178..3df51d866011 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -2356,9 +2356,33 @@ static int mxc_jpeg_runtime_suspend(struct device *dev)
>   }
>   #endif
>   
> +#ifdef CONFIG_PM_SLEEP
> +static int mxc_jpeg_suspend(struct device *dev)
> +{
> +	struct mxc_jpeg_dev *jpeg = dev_get_drvdata(dev);
> +
> +	v4l2_m2m_suspend(jpeg->m2m_dev);
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int mxc_jpeg_resume(struct device *dev)
> +{
> +	struct mxc_jpeg_dev *jpeg = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	v4l2_m2m_resume(jpeg->m2m_dev);
> +	return ret;
> +}
> +#endif
> +
>   static const struct dev_pm_ops	mxc_jpeg_pm_ops = {
>   	SET_RUNTIME_PM_OPS(mxc_jpeg_runtime_suspend,
>   			   mxc_jpeg_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(mxc_jpeg_suspend, mxc_jpeg_resume)
>   };
>   
>   static int mxc_jpeg_remove(struct platform_device *pdev)
