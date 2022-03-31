Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782DC4EE262
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbiCaUMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiCaUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:12:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97719E382;
        Thu, 31 Mar 2022 13:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgmRX6+Ckmxo4KwbtMdKYCbaAKx0uAcAt3v03lmvKapAJw7w7inZru4paVjWld8lYwaZhE65YUHUD5J3ZD92FARWa1zmsIf1Y4D5XF+k6aBNL0EgJLR3LdaAbXQ/CJkVv0fHSbVsH4FCebVusOyfJWnYQufO5EoS/dvoQIBMO5lqE9eWdMwRxXKvXW4U/J2sm/2hnGGPAb0G/Bj/voToS0T91H+f8mJ4LEZZbB1vmsoHS0JrAy/C1kqPnVPFrMfGwH3VFF01O/UwqOPYiKJCpjNXlv66Cbe2snclK/WafurWCHRDz6DGWX+uOYEl+8AJTYQiQ9ZsUywI2cRMgJAwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/lx9dT9zrX145kwSPP3CwtOkrlJyAdXMDUUjLUYE8U=;
 b=EY7ZKF33nnGQYe4GEwDQ/J+pP+i2kz3pZd1IGJMJGA9/DzPDoccKWmUw3DvnH0JelZP1rf5oOwDjqWeIVlCRDCZd8hC6fYqiQx3nZTj1x/sgKW/MirqDoUGkf6CSRa3BgOxKw2Q/TCa5jCuFkaqc2xTWMis3jHtCJeb+GO+G86UzZur4eCfcEarZNrAzS764nMDPUmcQAuPyg2uwhT7YZtGpwJh0H39u3d01a/WUXwbamC293EqFFRMXcEhZLwAeoVwGuW2l0TnZyCOwQAoXSry+RnjGFKBpIIGmyRAB6g+XBmuJsSHjlOLPUpISbbmVJSbPtt5bF2F/4cJdJljakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/lx9dT9zrX145kwSPP3CwtOkrlJyAdXMDUUjLUYE8U=;
 b=k60VvkeHiZLaMlJA1oGVBxxwVtdwFxC049HmI6oE6MIyEegM7cBkKiT8ekd2F6pvvuDdeneSi5lVWH9QSO+9c3kZqtbFQxwT21EUIGMsMRRCnV99FgC+4fc0hwSJtNLnXP9h+PLeWDHv4Dl+f0JGR/E3Tr182NkzCx1ArciFkPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 20:10:32 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e%9]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 20:10:32 +0000
Message-ID: <d1586b34-1ed3-99fe-ce03-90aa54e88eae@amd.com>
Date:   Thu, 31 Mar 2022 15:10:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] crypto: ccp: Allow PSP driver to load without
 SEV/TEE support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>
References: <20220329164117.1449-1-mario.limonciello@amd.com>
 <20220329164117.1449-4-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220329164117.1449-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:160::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc08775-8888-4146-64e3-08da13528271
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3792BC61836B2880321E5F94ECE19@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HB8x1xBNlIMv6jn+tfqqLG9AbRp0BNr9EXvv7e7cXdjdsonR3ef2LWOGs77jRrz532HEvR4PHAw5LFlnCOAnigWWTkv7xNunQ8fBVQgrpIgc88DcqMepZdyJg0pSH2MUq/f+IY2Atva/+iRzZ1q4V4k5tDlehUL7d749ADBO3J4992bf5Lwyt0Qs0OFMOxgNcAy6F2wBer4ywV4+Ma8mxABtA3TPUUCy0cF8KfGJSH95dA3zoOEyYYyT87Vj5gdiiCsi8X41S2i8WV0dZWEzD7iJwKVmObAryut12R3o86f93kjpP0pqfGgWmHn4Lcf45XdCeE3r3VRFuQD+mQLlGzfyMabYaxTTIJQqVSlC0wMuhO37Y1CHuUt8ghv3QedpPz6g1Z6jU7/KRgrxDJXrAGZINUeVNZhogQbzoXFxuQ2lsFpGjg0T0NO3iDaLegcXk81s4Rc6s7pxPgoxVWnJo5sSr2VEh+5Clzv12MDpfqFqW/BMS7ybP9ddxngeVU6iGPZhJNl6UrcO3T1BtBWElbHHi8vGamTMznoZZLfrkql9AgO1fF4vY92U+zd3M9WHkgyINKdl3mzSnz4dWnNROm1vbm3yFcBHG6dAJF3Cblj5yshIfnFUiFr8lUDe6IgNiMQhe4VpD+4dqwaYnipaWAc6WrPJ9WuC1JYulLGfsjHr9alLjH2ddwc68lecYZ7M047zlsuVHEVdJvmn1cyLXlDBQDf9Ch4OHGZngREe2kA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6506007)(83380400001)(36756003)(6666004)(6512007)(31686004)(2906002)(5660300002)(53546011)(54906003)(110136005)(86362001)(8936002)(6486002)(38100700002)(2616005)(186003)(26005)(66476007)(8676002)(4326008)(66556008)(66946007)(316002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0NGWEVkemxjTHpYaHRKVjBKak9oMS9lblVINE1hT1MyTGpqY1ZSMlc0S2hS?=
 =?utf-8?B?U1lBK1JvTVo3UzZtNGN3ak1XamZ0QXZ0Smp2TmlyM3IxV05GUkc1NEsvNmlU?=
 =?utf-8?B?VDF0c2lXYTFPZTJNRjlSOURMVWVLQWxRbUF3TjhJQTlCMGRJbHhvTk5oT0Za?=
 =?utf-8?B?dW16dE95WFdnUjc5OE9iT3NhK3FSalY3WXR6OXNmTk1yblFtakR0cnNUQ3BL?=
 =?utf-8?B?SzdrVTFMK2liQlJ1SCtkb3FrVHFWMGpBWW5uSFpTRG9CNDdiMmtUREdMQWw5?=
 =?utf-8?B?SDRCN2xSTGdyR0RzY3FqaVBmT1FMcnZmSWlIcnFFQ1JFbW9jdVIrK2VoRklY?=
 =?utf-8?B?OFF5MVM0SEZ6dW5ZREVTa1AxZU8rRjJoRTBUMERZMlJpUHhuVzd5blRXTUth?=
 =?utf-8?B?a0RuVTFiY2lqWUt4Mks5RVNocjF0Qk1YWk5UbDdka0FyTW1Ba2dMQXozT1Bn?=
 =?utf-8?B?MENJZ2kwRzltMGw0NFh1c1RGQWZ0azZmR3UrWllqNk0zVGZ6RWlMelcxUUlo?=
 =?utf-8?B?QUNFZFpGc1dQdE5aTkx4SXlicFZlQlUyL0pvKzJ3elNEU3AvYXNwV2RyL1VN?=
 =?utf-8?B?NmJTaXE2L0JtMllRYzVVaFJvZHBuSkVqQVY1N1kya1JZSlpQNmM2OVNyQXBx?=
 =?utf-8?B?WGNpdFpCU2prT1RmeU1rZjY0TFdoaVpkSHczMEhvQm1INW5tRk5Ld1Jwd052?=
 =?utf-8?B?ZU9mekVSSnBLZm1JZ1BOTXVyYXY3OVNLb05jMVVNc3dzM1pVd3ZQOGFVNlIz?=
 =?utf-8?B?YUNBTkdzSTdnRHBRTmVlZUtDMWtuZ2htTGtKY0Nkd2tHMVdSVWxWWGRSUzdN?=
 =?utf-8?B?ZFphSmJpN1hIcUEwVjJoWmdPQzVObU1HOWpoRTNpN3NSanNRRWlzYXJIVVB2?=
 =?utf-8?B?VEUzNExBNDBoVi9tcnl6SXRQeXpKZDNCTkFxbUUyajJ3RWE4TzAwZEdjSW5o?=
 =?utf-8?B?LzRYdjY2ZUxoLy9YNUhPMVEzMWpjVzlMVlYzVjRCQmNZeHF4dlZVWm5kN0Z0?=
 =?utf-8?B?dksyNllIQzRGd3N3ZGE3a05mMHdDQ29HZGxDeXUvSXJLU2JpL1Bud2pCSnh3?=
 =?utf-8?B?bnBlU2JKamdiWUk4RVdPNit3UWkvdkJrVVhNQTR3eDBzR3BXVHJNVEM4Uk9P?=
 =?utf-8?B?d21BSTZFT2M5YU5rdWpyZVZ0UFBLbXNYQjc4U1VzenpEam1RN1k1QUR2NEZu?=
 =?utf-8?B?MmdXNGlXeUpCRXBvVElQNmoyT0U3WkZ0MWZyUkhtbGszeHAyR1pDa3FWWDZ2?=
 =?utf-8?B?V0dldVI5RUdnUkVHVDUvbVVvTEtKbDFKaG9zRUoxUjF1c2FPcWhHQkdLZVBY?=
 =?utf-8?B?QWlGZmdTVUl3Q0ZaY2ZjV1ZtdWUyYWRHVGN2NDJTOXRkRVhxK1pkcVhLNHZW?=
 =?utf-8?B?akVVZzBIQzhSNitUZVc0ZURxYTVSOFVqSTBDQlBlbUhRYnZERkhPYnh1VnQx?=
 =?utf-8?B?WWlNRDF1am5YbmVnREF4bC9MeEVBRmcyQmpMRVdmZDVrQmQ0VTVFL3ZpY1RL?=
 =?utf-8?B?N1NXZys0Mnl0UlVOcmZnWGNGQlRnUmdsdW9GOTlPc0N3cTlHcEdiQld1UXUz?=
 =?utf-8?B?TkI4VElTamg2RDRkS2FIT1F1Vmo3dUdXWHBoRkFQRFFpTEFQVnBiWWp6QXdU?=
 =?utf-8?B?TTFkNGJwKzNyek5pWVlXcmZ2bDBDckpGUUVaTVpSeXQ5MnRhbXRqeU1YdEVP?=
 =?utf-8?B?VitTWnJuOEZtUzd0dWx3Z3lhSDIrMzMvVE9OTXpmTlZNM1RZNGpKN0tjWGM5?=
 =?utf-8?B?RlNPaEhTdXRhRE44ZkdVSHRBRU5CT0RZMUZSNXlOQmIxL21makZoTjZxSEZC?=
 =?utf-8?B?UEs0RW9VQ3pWYjhvYkRKY1RDa1VhRjh6VEZWeE41YklhdzBvZGs4TlBYbDgv?=
 =?utf-8?B?dW0reWkwcC9oRkp6RTJMcTYvekZIaVpBZ2NLVVNic3pZSFNmb1NVTUU5dTdk?=
 =?utf-8?B?Q0l0dEoycVlwU3BoaFcwdkoxZFRJa0hSWVNtbmJGWnppdFNzNFhhQmpDTHkz?=
 =?utf-8?B?ZFJrS2lCcVM4RjY1bU5kem83VWNUTENhejhUaEJiajhwM0x4SnRiZ3RDbitV?=
 =?utf-8?B?NlFad3BTNFFJbWo2eTNUcTNCWGZIRW5uUWlmcW52NTA4eUtjUnpaUXZPOEVr?=
 =?utf-8?B?VDZ2NytGQWhHV3B1OXpaMC9rUkpRWkVuNGJiZkRmdVRnNm1KbW5HUUU2cnMy?=
 =?utf-8?B?eFVaRUtzSUJxTWliV1pFY0hVaTFQREJjZ2JDR1RUdUpyakIrWXB0ZFBFN1Jr?=
 =?utf-8?B?S0JORVZsaTdBK2FUdDRZeEgxWFQ4V2NZUFF2YStwR3R2Z2thNDVSQlNMTS9H?=
 =?utf-8?B?dGljN2lyaitiamN3VzRvaWduRmFMNERudTJaNllzN0hNRzVIK0FRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc08775-8888-4146-64e3-08da13528271
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 20:10:32.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiNIgTrElJjyKML48dPZI9Tl6uT6anzSJZ6dOmzAWg6zdNMGy93fMLpMDOo3soMMon5PWtiSdPge30MJ6ibCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 11:41, Mario Limonciello wrote:
> Previously the PSP probe routine would fail if both SEV and TEE were
> missing.  This is possibly the case for some client parts.
> 
> As capabilities can now be accessed from userspace, it may still be
> useful to have the PSP driver finish loading so that those capabilities
> can be read.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Whitespace fixes
> ---
>   drivers/crypto/ccp/psp-dev.c | 2 +-
>   drivers/crypto/ccp/sp-dev.c  | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index 8cd404121cd5..3f47b2d81e3c 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -158,7 +158,7 @@ int psp_dev_init(struct sp_device *sp)
>   
>   	ret = psp_check_support(psp);
>   	if (ret)
> -		goto e_disable;
> +		return 0;
>   
>   	/* Disable and clear interrupts until ready */
>   	iowrite32(0, psp->io_regs + psp->vdata->inten_reg);
> diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
> index 7eb3e4668286..3486ab2a8982 100644
> --- a/drivers/crypto/ccp/sp-dev.c
> +++ b/drivers/crypto/ccp/sp-dev.c
> @@ -132,6 +132,9 @@ int sp_request_psp_irq(struct sp_device *sp, irq_handler_t handler,
>   
>   void sp_free_ccp_irq(struct sp_device *sp, void *data)
>   {
> +	if (!sp->irq_registered)
> +		return;
> +

I just noticed that irq_registered is only set when a single interrupt 
ends up being used. When both the CCP and PSP get their own interrupts 
(the common case), this will result in free_irq() not being called.

So this needs to be fixed. I would think just allowing the IRQs to be 
requested and freed whenever the driver is loaded (regardless of whether 
they would be used) might be the best way forward.

Thanks,
Tom

>   	if ((sp->psp_irq == sp->ccp_irq) && sp->dev_vdata->psp_vdata) {
>   		/* Using common routine to manage all interrupts */
>   		if (!sp->psp_irq_handler) {
> @@ -151,6 +154,9 @@ void sp_free_ccp_irq(struct sp_device *sp, void *data)
>   
>   void sp_free_psp_irq(struct sp_device *sp, void *data)
>   {
> +	if (!sp->irq_registered)
> +		return;
> +
>   	if ((sp->psp_irq == sp->ccp_irq) && sp->dev_vdata->ccp_vdata) {
>   		/* Using common routine to manage all interrupts */
>   		if (!sp->ccp_irq_handler) {
