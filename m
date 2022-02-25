Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0901F4C4BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbiBYRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbiBYRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:08:41 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00067.outbound.protection.outlook.com [40.107.0.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5FB14FFEA;
        Fri, 25 Feb 2022 09:08:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+jX95W9gJFYAZJp/Q/FdlpLymwKbeGeBduq4ykZThgTfVsudC0xz6r62apKsYuA3JXFN9KG5EoVnbj5eqvmrhCCGD1mf6RReKwFJ/rhKl2wf4k7oqP9iq+ZqUdYHWnbXhKjbqcwPLFBXlzySo1sfhQET9KMZZ36nBsQu3wK/pIVpdi3hZJgbiVWfhA5wWqKmf4AAmuj0EXt8pquRV2ZAtDtvfAEdoI/HLUJLM2fhS3cy1P/ExI2uIHu8DjjfeIptQC3xYVmS5tmYT4oh6GMYWVCA30CG+R8oaBMV4zfweQdEHFUG9J65mQSpQk+DyT7TX//WFkeTceFqZOQj6IEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEFW3geBgNeMAA4mgH2NUilDnn5zdsOKVBFpauez78A=;
 b=nIcrTchjdMaaurE3nesi8pi36LqMAw8hEhzHvzT3wDB2BkmFe1n+wd1gmDZsXitI/ZE+mIdh6GPwv9VZt8FFWZEPWqphMQAwAXA3KLxbaBNGfbbS9EkHRxmtIeucohKhWBNnrYfr/8dEopBzLA9rtLxIPuM7MWuRtzpiwYwUA+c/4HxzHExhBx51aziSP6veJEMnNkZrzrGQFjx0jW626+CBske4JWZ4SIofw9pBovQC+NuL759w1b46+n9yCdNVs0soOvWWqCMUHUx5DdTMiVu5pDxUUoF0KHwzcIFWF7QxnTN5UYfzMbquQhF4/d9gwD7XnT5R8TH7hQ68ggTgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEFW3geBgNeMAA4mgH2NUilDnn5zdsOKVBFpauez78A=;
 b=MiXcOfZLO3tlGSdXZckO2soFFcqteYES7dywAJWdsTvslJwvXT+5s9bbSF3PHhg7vLJQB0pQnfmWFRFeAYJZBWYYI6Lzw0RQ+Lz0EzZPSEoC/fvdvipSDI5bl6KyZRVCl9oGiQ5KVrMr+Aqoo1QAcv/mZZLo3Rf5gtnurWEgKqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by VI1PR08MB5376.eurprd08.prod.outlook.com (2603:10a6:803:13e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 17:08:04 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 17:08:03 +0000
Message-ID: <76abe7a9-4e75-b91d-8428-a4df1f6d97b1@wolfvision.net>
Date:   Fri, 25 Feb 2022 18:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 6/8] usb: dwc3: add rk3568 dwc3 support
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220225145432.422130-1-pgwipeout@gmail.com>
 <20220225145432.422130-7-pgwipeout@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220225145432.422130-7-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0138.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::17) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4931e7f-6230-45ce-db0f-08d9f8816280
X-MS-TrafficTypeDiagnostic: VI1PR08MB5376:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB5376DE38ED815C367464192FF23E9@VI1PR08MB5376.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xnWRrOL23S4kXfbG1Opl9YzNCTlEHwz4rwzPmZ/SU/d8FZt+UTPbuzP3tAysi30x7jPvovovk3bNYkRKS9HTwr0qN4d1VIVIH0bJZSeUeQfxp8TPU1tZ8sElSVD5Vr1o0BIGfnRiQ28toUVZRUGQSMzhXziNzOS5UwYGbxw4Q0M15wp5DXirFZ5Ic3fvFm++Ha4T6frvcbFd+0h6TOpubWa7sAi8IcBllBruIuuTHh56NF1G+wLqBC/7DhTgQBot52rq4HFigooSIHPh2e6mHxaO2U4+m9XmXbzMre51sIE0FCcon1VZyyV9xyvAZ756Z2uPiVK1YYc59jgtkbaz4eVaiQx7uxrXIvFUy+/QcFlKBm1MP5/jh8qEVY1ZB/rIPvOpndPAhs19d3RQMQ0q+/qqi4HFwH86psMUXfWho1NjTdUNLCwrPPgzVPRfU62QsA+LBNl7W3CMpsErCKzrP7WvTk2BQRUtFeFaUEz4MvYQrqXk4H7MbtwpmwXY8VCw/lzyZfEMr/EPQrTCgZ7F4b4sf/7pqYoLqYrvsZar4y1UMJY0C68VNr39si7n3EZhU9EEkTzSH1FpKh3i12o2h08kpOKWPbNlkzywIHWPemGSj0aFgTr94QP2GiJvPH1M/Bo+Y7DpXhvXGL1i9IntOO/OHWrLHz8iHG5MC4bLyexbzBPVm1711jxLjiHhOnGVacPr12fJyKikAhqeUUoKWkvjjlsD97u4lKQLKG/oTCnb+5fVybSU4cdCO9ofH9b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(346002)(136003)(396003)(376002)(366004)(66946007)(508600001)(6506007)(44832011)(4326008)(8676002)(2616005)(66556008)(8936002)(110136005)(66476007)(36756003)(316002)(31686004)(6486002)(83380400001)(186003)(6512007)(2906002)(53546011)(5660300002)(86362001)(31696002)(38100700002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dzUGxLaGd0M0owcHZ5THRNa09KblZCMlJMZUtQUGZsRGp4ZnJYeUNiSVlh?=
 =?utf-8?B?bUJheXJCWTFWTUswd3VJWWphU24xeGh0QzAzWEdnRHdsM2pUYWFzbjREZlR5?=
 =?utf-8?B?eXpPUzNEOW90U0JkN0pIemIvQUhUWWUxV0hOVzk0a1RZZWREUnVJUy92d3Fh?=
 =?utf-8?B?WWIzSWJzbERtQkhjbnR2dUhJU1JtS2RpbDUvbmFXdGI5N1FaUnZrY2taK3JI?=
 =?utf-8?B?OWpTL2V5VDAySjE2OG9URDVZaVFzdzhrWWMyZStkVkxzU0hDdjFNS1pIblNp?=
 =?utf-8?B?VFdyR0NHMG80ZUs3U3VLMjFBNlc3ckxVeG1UVFFVZkxUV1V3cEFYZzdpNXho?=
 =?utf-8?B?dTZoNkpsWk44UDZ2TDhmc2VhUVFoUDFBcWo1YytKZlVNTTFSK0plNElCTDc1?=
 =?utf-8?B?SmthdTUzQWNSaHl6WTh4bnlpOElOQllRbzlFMU1DOXNCTGJKN1pEZmx4Yk94?=
 =?utf-8?B?Uzh5cXE3c2pZRHZGa3Y2cUl1Ulp0QW9OVnI0cWs0MEdKdUdEYW9tOGtFa0c0?=
 =?utf-8?B?TmwyRmtTTWg2WVowZFJ1VjdJZm83dERuOHZGNm5uaWwzbjFPSVZqLzRObDlh?=
 =?utf-8?B?U1RETzlNaHRsQUF4R0pjNjFzWWF5a0NMcndtcHU4RkEvZno0K0kwbkdOeFBG?=
 =?utf-8?B?LzlqVDM4azVZYnk4ZzlyeFhCTEdJRnUzcGNycGdKTlk5eHVSUnkwWVoyQ2RW?=
 =?utf-8?B?ZjhiSUU2dFo3QS9saWg4eUV6eHJMeWxQZ2pMaUdsVUdEUFZ3NU43aFRHb3pJ?=
 =?utf-8?B?S0tlUlJzS1duQ2JZMVZFeFFKelV3Z01iOGZ1cWFNVkFpSE9VMFcyeWxVSHdC?=
 =?utf-8?B?SnIwd01ocWduam1ac0NPYlI4dUVUbG9PcDcrZ2o3eVZWUFRqUTBGQkFxSG0w?=
 =?utf-8?B?eTJqeEFLTUc4aENWQ2dGajBQVDllNnhTMDNmeFVhYnlUMXJyM2ZWdjQwMTAx?=
 =?utf-8?B?ZHRIRlRYNUNVaWQ2NHRZV3RPVmZIdzRPZEpZVDI0U215WUhPWjI2a2RvOWRB?=
 =?utf-8?B?aUNSUkYvM0IyR1cyNlNkNVJjRTdmVXZKWFBnVW5nZnpOektiL0wza01oZ3Ur?=
 =?utf-8?B?a3ZFZ1dwS0kzSTNPRXNzdytKeU93QjJsUHgwRGZIZEptZTl5WnJpY0Fmbmdp?=
 =?utf-8?B?WldESzA1cXpwVkVsV0NtUVAyNENDcmZIVHM1RjVLVjNSRnBUelJVUjVNWm1n?=
 =?utf-8?B?NzdTMU53TEJEOTRoVGhtcnZ1Q0tBOXJuaUUzK3VQRFdUYzF6aEd4Vk5xVnU5?=
 =?utf-8?B?ZkduUUIwdCtYS2ZqSmJGZEFGbHpRdHJtZ2NmUGZNeG1GUXF2VlNJaVdsMGZ5?=
 =?utf-8?B?bDRvbnZqSk1sVWJpMFYxSm44R2Jnb2FaT2pQbUlJczdDcTJ5ZVY5TWdUZ3JL?=
 =?utf-8?B?VHRHOFY4UHJwOVUxVE1NUnNsSCtDcGVOazQ1ZEtYSHIvTW1yOFNQRW1sYVBw?=
 =?utf-8?B?UVRnVDlhS2xYdG9RY21nRTlXUlgySDZPZWN0SUR2WEJtc1BoNnJRV01pNFhl?=
 =?utf-8?B?WWJSN282ZzRwSnBGVEZtbndOck04eW5vYU5mcFZTNkZFcUpvc2Uza1AvRGZ5?=
 =?utf-8?B?Njh4Z2kvTUx2S2RRMU81VGVvM3dlZlc1S1RvajVwbm1GR3VkdXpLbW00TCtr?=
 =?utf-8?B?cDdBTDYyNE5MeUt0VHZBRzdYaUVoZUpLNit1dTdFcElFWFNHNlhmVHNLVmpm?=
 =?utf-8?B?Z2hUREpBRlNEaXVjdS9IRXEyUnhaYnN5ZzhWcDdOdWFRVEdHbS9WVzdhZnhh?=
 =?utf-8?B?Y1lTbUJINWtmZ3NLS1ZaS04wZnlma1ZvTFlPNE91dlRsQlp2R20rYzFycy8v?=
 =?utf-8?B?MVZ6OW1iM3FVUTNMZ2t6enFoUmNhbFkyaUxVK0NyS0s5VlR2eDJjZWQ5anh5?=
 =?utf-8?B?Zk0zblN4d0x6bHd6MDE5T1d3emFWUXBpaU5WakxUWmFPVDdhMUxuNVQxbG1R?=
 =?utf-8?B?Nkgyd20yVWZsZWFFK3J1Q0h1UXFtTGhCcVBSR2JmaTZpNUxNTkNFNGVrVS8z?=
 =?utf-8?B?YTlBZHBFc2E1WjdyYTBIcXNFUWNnQ2w5OGlVODB3blhoQVljWWl2WEZxaG82?=
 =?utf-8?B?akpNWld0YnNNK0R2dDJUa0F1MDM3Wmpsek5Qbi9GOG1HZGtxZzJlUkYrREox?=
 =?utf-8?B?T29uMzZ2eTZ2UXh0UmRpSEVqbUM0YTBTRHdraElnWGFBMWxiZDV6VFlaTE9C?=
 =?utf-8?B?RVhLOTR3YS8wQWVVVTcxNmZ2Qks4Y2l3NVRIcEtsWGo1UjNRdllVTUFucEln?=
 =?utf-8?B?SGVRcXk0b0JrMnprSW83bmU4ZVA5WmEzVHEwb2d4azRJRitid21wZlZGR3Rv?=
 =?utf-8?B?LzR0WktFbmFtMEFzTUpPSlNzcU93ZUdUTk1FTUZFSzdVZncwRzNtcmIxNDlv?=
 =?utf-8?Q?EkunpPKOP3Y9JLWM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f4931e7f-6230-45ce-db0f-08d9f8816280
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 17:08:03.8123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N5lIWdQ0PQAYO7+0hlJUJfgN8gTjfczDupBMsTbVPenSwqCj9wdQ3YOiVDybcxJANxcORAYoXBEsXiX3Cxi32CXp7AU2eFKsUl6cGCryIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2/25/22 15:54, Peter Geis wrote:
> The rk3568 dwc3 controller is backwards compatible with the rk3399 dwc3
> controller.
> Add support for it to the dwc3-of-simple driver.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index 9dc6295df6b1..1d52a261af55 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -49,7 +49,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  	 * Some controllers need to toggle the usb3-otg reset before trying to
>  	 * initialize the PHY, otherwise the PHY times out.
>  	 */
> -	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
> +	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") |
> +	    of_device_is_compatible(np, "rockchip,rk3568-dwc3"))
>  		simple->need_reset = true;

Maybe read this value out the match data...

>  	simple->resets = of_reset_control_array_get(np, false, true,
> @@ -176,6 +177,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
>  	{ .compatible = "hisilicon,hi3670-dwc3" },
>  	{ .compatible = "intel,keembay-dwc3" },
>  	{ .compatible = "rockchip,rk3399-dwc3" },
> +	{ .compatible = "rockchip,rk3568-dwc3" },

... so all future variants that are compatible to the rk3399 can share it?

Best regards,
Michael

>  	{ .compatible = "sprd,sc9860-dwc3" },
>  	{ /* Sentinel */ }
>  };
