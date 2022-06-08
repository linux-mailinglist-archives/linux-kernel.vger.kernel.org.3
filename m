Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD4543731
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbiFHPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbiFHPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:21:15 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AFA15895A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:19:32 -0700 (PDT)
Received: from 104.47.13.50_.trendmicro.com (unknown [172.21.182.42])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id F0F2510000BA7;
        Wed,  8 Jun 2022 15:19:04 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1654701544.410000
X-TM-MAIL-UUID: fcc6314c-a70e-430a-b8dd-cb5606fcf191
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.50])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 643AC1008F0B3;
        Wed,  8 Jun 2022 15:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdP19oJPR2WDvghIgCPOLSrqp5+RH6qEo+RQbeR8asaKTBFZphxWxqzJpS6IOcMofLWP2qjCNVRGDu3/gZaCCcwvSLsANSKI4DSC+GcgFXXXGtY8PdHuCVZoT54+w4UsUC9uyDLHQGlwi46raqZ7Lz9oeOWovEr8yQKDkXzPzUJB5hULQDMVQkkNTi93Uc5zFbNtpjqaO5wRK4MDNHdyqG6+/8N9PmPMrqASD9dNvKnQGTVH/kthi+2mPZcAbMi0SLkJJz7zGz+ZzWlecGoUrq2Br05nI2bAAHs9tsNijyF7B+UVjGVANaqZR3trOjr1SDKtef0TUDybImqryAT9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfoZOJ3fOzL3XjQgOFp5wnwQN5IbFQDkkf96bvzIfmo=;
 b=nue8mEasBJQHirzE9b3sbQtTqU4CdkO6Boo9bo2kfKxwdo2l70rqRZgLsvylM690USaDcgumTNtZjBcxmkstPit1Lgt5PJq8Kb/4Wv86Cn2z6l9ywZ0DUf0w0jWQFdu4ZP1Cs2um0/6ERk2GqMB4+Lh4AbAgU97gi/HIbekQ5+uRVUToqYfz5zoxu+g0LrH5mhbObffRE4yrh4AbNF+0exBIJTfhK3qVGjLYWvK3XDdScBrZ5yXoCDJ6Wky8M4idD15tQ7I1HTtqtia2048BQGW1Nu2sxE4D2YfONPmlij91YkAjAC4UYz2kap+4KX8Q6TvqoVVeBlz2nPg380eJJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a349b6be-daa8-e523-6e63-4e9105aa75d9@opensynergy.com>
Date:   Wed, 8 Jun 2022 17:19:02 +0200
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Fix SENSOR_AXIS_NAME_GET
 behaviour when unsupported
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Peter Hilber <peter.hilber@opensynergy.com>
References: <20220608095530.497879-1-cristian.marussi@arm.com>
 <20220608095530.497879-2-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
In-Reply-To: <20220608095530.497879-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0189.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::14) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b28d684-c635-4941-cc23-08da49623892
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3877:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB38776403EE6786D38B468C908CA49@AM6PR0402MB3877.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oz99GL4ALS5kRnG6SFJvcup+DAZXOEicI4GP2JDW/OU/QpLRRdRmFspkKk6CT2wOldwS8h0zvvyPbKNTa9RQyqcZZmAXjy8UVd5sNgXQst0duwK2Ai+CX3X38JDb2+q3YXQ40le0lJJ37Ixo6zUOL4rCumel0t/jsErAQdoXqf9smmhfyMSLcsU0pqQIGM31cnY9YtJs7YpbQQCgjlb0WWVpI6829nPRLR7Ar+2ZbKfOTKp7vBvadK+3LramzgAVHSDL5xSBPTiVvw7ZL5tVGXI6Z3huZz6zQi3YBXaSzcdEfWWQLZyXFqPAz2o+0jZeO5nE8wAnUlNRq4/p2zVbh5EXSveE6eqy+q5h0JedGx/TunclWaA+rXboVMCIn+ziQ7uMl3nDEyi7NiXrszcy2sfvY9aXYSC/C9G4O1TBwts0zizcGqIshQThGFKhhEJDxMW1588o227nMLu55zciL+nny617eItimAsr9CkMQlG0H6oTYRaI35sTDDucnZlmCjbY1m/4T8uIr6Nc8Ffp6pTLjmb4GjrakgE/hOC+iA9vQjL42ML/JsyvniCp++skP1Q101TTGqy4uB8jodFAStep5NvsoKsbZHb4N8nMgBtsrgT238ADU5DjaoMcdtYnbPknbPJlu1ecrUkNA7W+/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(66556008)(186003)(316002)(8936002)(83380400001)(42186006)(31686004)(66946007)(8676002)(38100700002)(36756003)(2906002)(44832011)(66476007)(5660300002)(53546011)(31696002)(4326008)(86362001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9WbFJ6dnc4TDU5VElOVGVMRGRxSFRuUS9qNmhXTnNQeCt6WXVtUG0xMkty?=
 =?utf-8?B?c1FiUUNSbjNUSzF1c3hxSXFTK1pwVEVCdzRGODQyYnhVbHZuOTJjeVg2WGFp?=
 =?utf-8?B?dmRFU3llb3g2dlFZYzA4OE45bHhQWnBRVm1Qd09TSHFpUm1hY050RlNxMXlV?=
 =?utf-8?B?eW9VdnFtUFhLMVNGVjh2UjRNeW5kbndxYmhmYndyS29Hczd3ZTgzUVNuZ1Bu?=
 =?utf-8?B?RE95WDFhQTZNWnhLcDdEZWlXYytJMTRsaWdCS25oOVlvS1BzZEtoa1ZadTg4?=
 =?utf-8?B?NVZCbkNWTmJoNEozMm9nYklvbGdxZHdVdkxwb3dnOTBORU5vcldsM1ZzY1J0?=
 =?utf-8?B?eTNDZFBUczNEdzloT2tESGVDRDNxcGZXZGJjYjUyMVFLVkJnN1Z2U3dYSlJJ?=
 =?utf-8?B?dnVZditKMjNtYVlQbVpmTHlCVHVXaWpUOHgyaFZoNkFDcHNySGlRa3Y0OVVk?=
 =?utf-8?B?Z2kvbE5rUjJhWFMva0djTUZRQmltRkN5WUZjbzFMaThpRzFheWp2MUlUWDJl?=
 =?utf-8?B?eVZCOEJZNDdXUWhiaXI4ZXR4V2ZJakRaQU9tcThUM0dmNHFMckFqSmdLNkg2?=
 =?utf-8?B?WmEzR29JRzlVMjBCWXI1M3IyYmI2bmE3Z1JOcUtaWEU4VjRIWFpWQ1dNaWEz?=
 =?utf-8?B?VERLVDBSNjdyM0VjaC9MOUVuamozMlBUM2hMM29nNnN4S1JvWVBYK3hza3FE?=
 =?utf-8?B?TWJWQWwwVWluWWhqaEtOcHU2dkYxcnp0Y3hzK2c2ZEZVS0NZaGJoVFY0NzVx?=
 =?utf-8?B?SjFIWFViWnBxY2szY1BaMGRvQmt5THVnZzhUZ25MM0pGdm5HQTdyWm5tUlJE?=
 =?utf-8?B?TVREM3diRi82Vm5DVEZvV3NjZG9LWWE1Y05pejFJd0tWNS9MVkJsNFgyc2Ru?=
 =?utf-8?B?K0xwRW11TUZYSk9rVHk1T1p0Ri96ZFFSMUJlek54d09aSkpTZllsMzR1bG1o?=
 =?utf-8?B?aitGQzFHRmxFak51amo3M01wZHh5RVRMSDQ2c244djFqSytrd0lNa3l5RVp6?=
 =?utf-8?B?dUhMS1NmVHBua3RKenAyZnJKbUszY1hBVlQzaGhmUC83VVcvUlN3ZzNsSG9K?=
 =?utf-8?B?RmlRVTRjZkI3d1d4WjVId1BtNFVsMjdiMDBUMml0ei9Mc3l1Rk93ald2ZUt1?=
 =?utf-8?B?cUdnVlhOaExWVjlqS1FLL21lb3p6SmRrTVc4QTllZEpjU3ozRkxLRC9YbWcz?=
 =?utf-8?B?OVFLQksxY05Zanp0YllaRjVaZ2NoR29CNEJDUTFYNS9BZFM3QkNwY3daY2dT?=
 =?utf-8?B?MHFIR0hzWFBISTk4ZmRTN3BtNGkrZ2o2aC9Jb2lEWEFTck4vYktDVHpIYnc0?=
 =?utf-8?B?QzA0aVhhMUxGbTkzSUkrWDZwVFc4aEErZTMvdTliY2swVDhvQ3BJc29Vdldk?=
 =?utf-8?B?Q0l3anVZWm5aUlVVNWh4T0VPUlAyUFV6MTlMc3ZEN1A1UWdZbmZNcFBUWmxl?=
 =?utf-8?B?UDlZMjdUdHM2bTNNVEF2dmhhbnFhcS81bmsyRzdONTJDN0ZNbW4xWWNBdWQ2?=
 =?utf-8?B?OXBZYnBIckd5QjFNb2NpSDJ2c1IwVE1Ma2hrYVdXSUgyZXhvV3hONFJiRElV?=
 =?utf-8?B?N0lTbXpuemw4ZmxoU3ozMUdUeWFrNjhoS2V2QXBuRVN5cm9TVC9EOElDSkwz?=
 =?utf-8?B?NU1abWRjQnR1OUJNaENPNEs3N1FkNjliMW8rN2hGajNUV0ZhRTZaT2xUWG9h?=
 =?utf-8?B?VnJENUhmYkNyUmVJeTJSNC9BMURRQ1hMeW5XdS9uOXpuMXlXcGlUR05KRUVs?=
 =?utf-8?B?S05waXIrQ3ZyV3JTTzJmejZxWTJUK0NOVjZVZ3ppaEtENk1PMXV6UDh0T0Fx?=
 =?utf-8?B?NTBYekpleHFreXFHOU9GZEk1ZVluUTVNZWpYY3docDZINWRUSFEzVjdBMFNP?=
 =?utf-8?B?bXk1QUdCWUUvRysySk1rMnRxT0YxTjVXYllVWXg4QkhyVDlSUUM1STFSM0sr?=
 =?utf-8?B?NzRGL05HUXdxVmNxby82bWN1VTJBVDRmNWUvVkh5dXVpaENpL0loKzlPZ2F2?=
 =?utf-8?B?VEFWd2NtcnAxS09ha2JzeWl3UVN0STl6TUk3bzNMZUNSVnBqNjNzRVduWkRi?=
 =?utf-8?B?L1RSdkFkQU8zNDVWK3lPeEVXYjNXU1VWaG94SDBKOEhLRGlvL0VlRGpiRnpN?=
 =?utf-8?B?RE1ZZXl6aTRNRXZBRXVrcXpuRmlML2FkenpmcmF4R0hEMk1JbUtJV1ora3NV?=
 =?utf-8?B?UHl0WXFRNXFqZlVhN20wRERZTmtjcUpqWXVUcU0weUpmRHRZWlo0YWplOVpW?=
 =?utf-8?B?WGQreWlnWlM1cDBQakYrWHpHSXNLQkZNZ2ZEMlN3MDY5eElMbUtxWHdVTkdF?=
 =?utf-8?B?TXF1YW85YzB3R3NDOXY4TEhjb3pzUDBwMjlmQjRhMFRRR1ZPZGc1TkU3MkQ1?=
 =?utf-8?Q?usB2wasPxhoZJly8ZoNv0qKcCg191XoUylwMrxMPOx8lL?=
X-MS-Exchange-AntiSpam-MessageData-1: wn7CqiE//QutfQ==
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b28d684-c635-4941-cc23-08da49623892
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 15:19:03.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrwGl4h3VTEnV2IecN2I3FcnDImhNmD1ZmrUkf8dkwnybOq9qGp7k+8lusmdUchiKjrrQnZ3kAYDEPRId8pwWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3877
X-TM-AS-ERS: 104.47.13.50-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26944.000
X-TMASE-Result: 10--9.245800-4.000000
X-TMASE-MatchedRID: +f/wAVSGjug6yy6RAAEPc9+pUF0HsjxRltF+xW+zhUhWjSWvFszxqyj5
        3aEB5qDL4Utg/grucZYNfkNCH3HkaOo7bV31UxoOVnzlQiaE21oXivwflisSrMC5DTEMxpeQfiq
        1gj2xET8M1uAoS31c814smUGmd3b4zfNRzzMaVCBv+ggm5QAi4bTrV2IG143Xr2Pto2emO2V6nU
        gtlkys528X2hD8HnjIYqRVWzHUBwIhlf8RDoxNxW03YawHJvPCyeUl7aCTy8gUoJOBFYW8JhNKP
        FvhlN8weG7OVGjdOcq3VM/S5c9XTjKEOf80TKXQfOaYwP8dcX5KTvzkVGmdxZsoi2XrUn/JyeMt
        MD9QOgChMIDkR/KfwI2j49Ftap9EsjvNV98mpPMJTslwvtUw+xF2/I3YELRscqeAvYa4F+iDUiS
        Bn4iApFGk0YYJLHZfftwZ3X11IV0=
X-TMASE-XGENCLOUD: e19aad93-74ab-4918-b423-67d030681d6d-0-0-200-0
X-TM-Deliver-Signature: BBCFAC7C91296C6956C00D0C8F88F80E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1654701544;
        bh=vqnUVtKXdjWcG02b5Xfh66JVBmz6yjXoFPM5RN/orkE=; l=5921;
        h=Date:To:From;
        b=WmyADrLQYAsNaQANJFjgzaoyjDXAbA1CWTC5VjV3fDHHJ+rR36csQMujEp663Q4Mn
         NHY8eSWRQpAEy4BJ3kP4IHYDSDi48n3F5Tha+IWz0LCfBbWlm1lX+Vtox5l7rif0Ii
         TvfqrB47+vdpNOHq5T33pOe8hoK9mdG8rKvOMe2u1K3C7DsJ9L+ZsQ/9lYAV5dVBCZ
         SonPTxt8Hfo5/4Y2Jxt3QnqMg4nepyQDuI0q1k4V76UxIWkhtakNGx8icOeMCIZLHB
         82yW/6ruQjzDnnYlWHoh0WDlCfUAB2LaWAXglqKjNOF5zHrYyiUV8bzTkFwFsGowlv
         fodqQXAahj4sQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

I think I found two missing endianness conversions, see below.

Best regards,

Peter

On 08.06.22 11:55, Cristian Marussi wrote:
> Avoid to invoke SENSOR_AXIS_NAME_GET on sensors that have not declared at
> least one of their axes as supporting extended names.
> 
> Since the returned list of axes supporting extended names is not
> necessarily comprising all the existing axes of the specified sensor,
> take care also to properly pick the ax descriptor from the id embedded
> in the reply.
> 
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Fixes: 802b0bed011e ("firmware: arm_scmi: Add SCMI v3.1 SENSOR_AXIS_NAME_GET support")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/sensors.c | 55 +++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 75b9d716508e..58fe4f0175be 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -358,15 +358,20 @@ static int scmi_sensor_update_intervals(const struct scmi_protocol_handle *ph,
>  	return ph->hops->iter_response_run(iter);
>  }
>  
> +struct scmi_apriv {
> +	bool any_axes_support_extended_names;
> +	struct scmi_sensor_info *s;
> +};
> +
>  static void iter_axes_desc_prepare_message(void *message,
>  					   const unsigned int desc_index,
>  					   const void *priv)
>  {
>  	struct scmi_msg_sensor_axis_description_get *msg = message;
> -	const struct scmi_sensor_info *s = priv;
> +	const struct scmi_apriv *apriv = priv;
>  
>  	/* Set the number of sensors to be skipped/already read */
> -	msg->id = cpu_to_le32(s->id);
> +	msg->id = cpu_to_le32(apriv->s->id);
>  	msg->axis_desc_index = cpu_to_le32(desc_index);
>  }
>  
> @@ -393,12 +398,14 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
>  	u32 attrh, attrl;
>  	struct scmi_sensor_axis_info *a;
>  	size_t dsize = SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ;
> -	struct scmi_sensor_info *s = priv;
> +	struct scmi_apriv *apriv = priv;
>  	const struct scmi_axis_descriptor *adesc = st->priv;
>  
>  	attrl = le32_to_cpu(adesc->attributes_low);
> +	if (SUPPORTS_EXTENDED_AXIS_NAMES(attrl))
> +		apriv->any_axes_support_extended_names = true;
>  
> -	a = &s->axis[st->desc_index + st->loop_idx];
> +	a = &apriv->s->axis[st->desc_index + st->loop_idx];
>  	a->id = le32_to_cpu(adesc->id);
>  	a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
>  
> @@ -444,10 +451,18 @@ iter_axes_extended_name_process_response(const struct scmi_protocol_handle *ph,
>  					 void *priv)
>  {
>  	struct scmi_sensor_axis_info *a;
> -	const struct scmi_sensor_info *s = priv;
> +	const struct scmi_apriv *apriv = priv;
>  	struct scmi_sensor_axis_name_descriptor *adesc = st->priv;
>  
> -	a = &s->axis[st->desc_index + st->loop_idx];
> +	if (adesc->axis_id >= st->max_resources)

I think adesc->axis_id uses in this function need to be wrapped with
le32_to_cpu() (here and below as well).

> +		return -EPROTO;
> +
> +	/*
> +	 * Pick the corresponding descriptor based on the axis_id embedded
> +	 * in the reply since the list of axes supporting extended names
> +	 * can be a subset of all the axes.
> +	 */
> +	a = &apriv->s->axis[adesc->axis_id];
>  	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
>  	st->priv = ++adesc;
>  
> @@ -458,21 +473,36 @@ static int
>  scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
>  				    struct scmi_sensor_info *s)
>  {
> +	int ret;
>  	void *iter;
>  	struct scmi_iterator_ops ops = {
>  		.prepare_message = iter_axes_desc_prepare_message,
>  		.update_state = iter_axes_extended_name_update_state,
>  		.process_response = iter_axes_extended_name_process_response,
>  	};
> +	struct scmi_apriv apriv = {
> +		.any_axes_support_extended_names = false,
> +		.s = s,
> +	};
>  
>  	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
>  					    SENSOR_AXIS_NAME_GET,
>  					    sizeof(struct scmi_msg_sensor_axis_description_get),
> -					    s);
> +					    &apriv);
>  	if (IS_ERR(iter))
>  		return PTR_ERR(iter);
>  
> -	return ph->hops->iter_response_run(iter);
> +	/*
> +	 * Do not cause whole protocol initialization failure when failing to
> +	 * get extended names for axes.
> +	 */
> +	ret = ph->hops->iter_response_run(iter);
> +	if (ret)
> +		dev_warn(ph->dev,
> +			 "Failed to get axes extended names for %s (ret:%d).\n",
> +			 s->name, ret);
> +
> +	return 0;
>  }
>  
>  static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
> @@ -486,6 +516,10 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>  		.update_state = iter_axes_desc_update_state,
>  		.process_response = iter_axes_desc_process_response,
>  	};
> +	struct scmi_apriv apriv = {
> +		.any_axes_support_extended_names = false,
> +		.s = s,
> +	};
>  
>  	s->axis = devm_kcalloc(ph->dev, s->num_axis,
>  			       sizeof(*s->axis), GFP_KERNEL);
> @@ -495,7 +529,7 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>  	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
>  					    SENSOR_AXIS_DESCRIPTION_GET,
>  					    sizeof(struct scmi_msg_sensor_axis_description_get),
> -					    s);
> +					    &apriv);
>  	if (IS_ERR(iter))
>  		return PTR_ERR(iter);
>  
> @@ -503,7 +537,8 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>  	if (ret)
>  		return ret;
>  
> -	if (PROTOCOL_REV_MAJOR(version) >= 0x3)
> +	if (PROTOCOL_REV_MAJOR(version) >= 0x3 &&
> +	    apriv.any_axes_support_extended_names)
>  		ret = scmi_sensor_axis_extended_names_get(ph, s);
>  
>  	return ret;
