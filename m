Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480AD4FC5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349840AbiDKU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349835AbiDKU0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:26:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7905EDF78;
        Mon, 11 Apr 2022 13:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bsm5xjGm3m7XwtRDC792ZQ0FpmL7mwdrceem58b7Bjf9cM4Id+qjNW3cTVI6Abhi8265S2IFg370icEbEm/2wVjmAUZ6jFE9/+0NiGWdQWQnbtObXsdYlAc49F1H0u1Tvv04TN2anJK6OVv1YWASj++zCFqpPKQDlJpCBrp9OsGdjrdfIrOvInNnbXSzZntGmwgr88aY1OEU2rb2zxDy329/GcHJ/fGvApzEgRe30EqQJd8Iq8S6kD04leGm/Cop8J330/yaMDtHfkLiwrYO0dNjy2zb5eYPvdhDAx/TU4Z2tCJzF8A791+HbKCvK7uH2uq1DVbK4PhEW8LGYGmv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHOeZaCv63l7smB1jrSDoFamgunFf4NJXvFEV3U9fvk=;
 b=VE61uKqkLYcOKq9B3VU5HyXvIQ+aaVpkNGYmG9Eui5Q0nYQn5l6cwtcO6bkumBEzAnZjTiAMo+fFS7cZwzlb0eIkTtr0gRjE4RCVYdl/KhrWpYbt2rs1+V7o9c2GXt1UiwmWFgtAePvNlTU39njYrhv5BjsH1Hrpyv3Tq0aQcl9ZTSsB7/4itVMrbMz6O3xc1rrTE3xrDFXprTJF2whqei62dnDXvvSpga6/7Tcobx0B3k+ZnUKa2IYixFq+JFuO71eiX3CQKD2epSMUFG/+JnMabBpL8qxwU+1yZ3LrL5+E2UG7KtfQdSBIuwe2HeWoogAVuytODK1CJBsSoruGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHOeZaCv63l7smB1jrSDoFamgunFf4NJXvFEV3U9fvk=;
 b=dsSDMc5HUF+LhMivlydauTIypmyQbVDt+MRmo8gAHqdFDinMmVFGs8CEuw2DJsPa9krj2kMICGYGIOun35OicKUDKpn/StZE27OCQ5JfbTKsg4HsHUpQIVw1zB27U3KQP+G3qX5auYyPC3pnDNmNiOaUYpuR+eZEL8eSjAPKONw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MWHPR12MB1774.namprd12.prod.outlook.com (2603:10b6:300:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 20:24:18 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f%8]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 20:24:17 +0000
Message-ID: <f048b506-edae-1372-53d1-4b080fee8b9a@amd.com>
Date:   Mon, 11 Apr 2022 15:24:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] amd_hsmp: Add HSMP protocol version 5 messages
Content-Language: en-US
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org, siva.sathappan@amd.com,
        Suma Hegde <suma.hegde@amd.com>
References: <20220411174723.547221-1-nchatrad@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20220411174723.547221-1-nchatrad@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:208:15e::14) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccc711d4-fd89-4a7e-7bf9-08da1bf940b7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1774:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB177467F25D164532ABAD48EBF8EA9@MWHPR12MB1774.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FV9pcM9Zrl2Nw9eNAG01taK77hegify0CJZvJgEP7ZYl6RjbWg81MMRRX2fhxt4sIAaWf7HNfjzsgkoFZU2MoLApBVivAeRUcKe1Z8SNfMfornDTcr273woWg1baPuZ1hMGXdZc6v4A39UPvQ2JsrH20Z8mRckneQ0o9cuuW4dcajw2x9LzKU9nShGH9VIbsKXYvJTOGTNAM4lUGa31wWnWDTd+NFoH4cq9f60sWgJJAzgOgbxytL87ciPzmEtZ1hTAdD88to1YTfIzNBWYw06r0s8vRZxb5RH60sGc3spGd8vIZbS4e+mE0D2WfhNqnJr9hff5LoJ9Izajt3MHPNf9cIMgkNYl1g/FbyLkEfP8RWQg1KUcpLvfrnkxcbSN8q+6BZGKJyqUifo8t5m1Q14hQRzMxk5C55m5CHJ6PXhVF7cNdHQTT9x8ZteQsdSbU94T740hgCkV4YuxEBxR+Ghr4aatCABy1catzNosT+1S0BysF/acJTf6jMcucJUMIPAoEjI/zYVCLisPDzy55YtJjtGyyrSodOxckx5fBctEYLt5tpFWpu5c0/ALGS5ngEXscsGDoYJxhcpTEtVcRckhPl9SQwk6RIGLj9jqxrvB4iU+1sJlE0l+F5x+6wrF3XWndZRgWdtp1Ir9h51MVXkE+FE66L+eyZ/lk4calRQZ4ND2yGipHTGzMQaEYfIHu72U/mw5SxcPxfcy4wIN1lt0XhEPpOn76GRaKb8glimEoYwDW/J8eUt9wxBxIJt4Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(66476007)(4326008)(186003)(44832011)(8676002)(6512007)(8936002)(508600001)(31696002)(83380400001)(5660300002)(6486002)(2906002)(66946007)(66556008)(26005)(31686004)(316002)(38100700002)(53546011)(2616005)(36756003)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0M3VHVjY3JldVlqN2h2R053bWd6Z0g5OEVvcXFLY2JHU243ellUU2JUOTNW?=
 =?utf-8?B?WXNkdjRubSsyTzBoT2ZrbDJ4dkN6TnJmWTBBak93L2luQTFWZ1VOKzdEZnhU?=
 =?utf-8?B?ZmdyeS9abCtYcU9DS3lHbHRVUERwUTE0Nk43WDduM2FWWnQ5TDNZSms0dC8r?=
 =?utf-8?B?T3ZvcWR4cjVBTDlZUW9EcXl3bWNLbCs0MjdQbjNEVGZCdEk3ckJnVEQ2RGZW?=
 =?utf-8?B?d3lNRXdqU296dm5wTWJXR1JkVmVwY3gzVElUMlYrZ3JUSE1lVXR1R3R4WFh5?=
 =?utf-8?B?TVBZMG4vNHlVWTU2S3lTRUFaYjlaV3QyZkZMSm9ha3piZ2ExYjAyMHpidnJU?=
 =?utf-8?B?MFVxV0tZR1BtWWwyVnpxK3dOcnNoK1p1TDVCU1RVd3V2SzQrU2dlWlQzWkFS?=
 =?utf-8?B?UDhGbEV3eGlTWHlZdTRHck1rMWN2ZXNvNmVsUUlKcFlVa3I0VDdCSk1HUUtm?=
 =?utf-8?B?WEZuM2JVZW85YVVUMUJyeUN0S3lHeVVkRWR1Q3lSRlB2VWs3WjZFV2VTdUFJ?=
 =?utf-8?B?Y3dBV0JpMTdUQXdUa1J2K3liem9uSW0wWVdRM0RyMFFDOG45L3ZwK3BzeU8w?=
 =?utf-8?B?RVBqMit0ZlAxamtuSi9Tc3VSbjA4UEhNZ01iZWlGREh6VS96OTJxczhxWVF0?=
 =?utf-8?B?bFRIZ2VaKzM1N1FQN0NPVW9zN24wVjhPQ1RRMnZ3MEhiTy9kMCtVSlZ3VjVW?=
 =?utf-8?B?ODFuc2VNWlZEREs5cXp3bFh0ZWJoZ2FtWTlCL2N1MDllZW5SSWpkTDdmS0w4?=
 =?utf-8?B?aTdDTGFQNkFPcklCbXBRWTU3Z0EweXJXb1VjZlhKWUl4MUpPZEdVOGdWaWpl?=
 =?utf-8?B?dTJWNjlRcjFjQ21QZlFxanlYbFEvWU9DZ0lGckhKUjNtdE0reitrVHp5cWVx?=
 =?utf-8?B?OFMyTFZvSnBFQVBWUk1jUzhkY3dITUpPVG9KRjVKYTFDMWNnSE9PV2V2SGs4?=
 =?utf-8?B?eTNOMzM5eTZGSUhaMzJhWk5pSkNJbGhyUHRrYW9BU1JZK1BiVDJlTnNWMndv?=
 =?utf-8?B?TStaeHZrMitsYnNSWnRWSDZVSjhOeE5weDloVnh5VmlldVdWaEdIOWpBYTV3?=
 =?utf-8?B?TFVINEhYZGxuQmVjMjJMOTBCeGZnbDlLVmJLT2YxOWtwTjNnNzBvVGtiRlk0?=
 =?utf-8?B?cUMvb0NNb0Y2V2c5MUNlRU5Uejk5bmVia0xVR2loQ2JWTDB5bXEzb0VxZ0k2?=
 =?utf-8?B?WEo2a2h2MCt6YW1sN21ERVNGUGE2QlRsQWxIUEtCWnZ6eEtnMW9NbHNQbmhU?=
 =?utf-8?B?bjZTaXNTeEJ5YmRXV01ZZnoxZG9qQlBzSUl2TlVyNzNRSDNxU1FVN2xzcTJD?=
 =?utf-8?B?MFVpcXA1WXM5QVJKRE5xUXJ6U2RCTitIdUJXNjhGdEF6RmlYOVg2ays0V3ZE?=
 =?utf-8?B?NVJBVzgzb2E1MTdZYVNQMVZjK1FWK05CZVA0Z25NY3RGRko3ekhDSUhqM01C?=
 =?utf-8?B?dkRIMWpNbUtXKy93bkxKV1BmaWRWN2txZENOd2lUZjBQa2JLaUk4SnU4cyti?=
 =?utf-8?B?V1hvYWtIc0VyQnF6eVJtUFRvcmFMeUpLNmt0M2ovVTB2aDBLZlFDcGJzVDBn?=
 =?utf-8?B?dlRTRFYxMFlJYkV4STdXOEdpKzYyUU1hNng0QmdhQnlHcGJwZkZJd0Y2bmtm?=
 =?utf-8?B?NTRaUkVrcHZQR212Z2I4aGlKd2hGNENHM2dwNE9NaWo2SDgvTG02TnhJWlJm?=
 =?utf-8?B?Q3NOOERDTEJUWmoxSklMd00vaDNaczZpUjB0K3FiclQ3aGxtOGoydWtuYUZB?=
 =?utf-8?B?N09XTVNEbGdNcDJGMkJvQXJ5ajdIRWNHcCswYno1S1VKMVdCVnI2dGt4YWZx?=
 =?utf-8?B?Nk1sS0FsQzVUNEpFK3FqU2pPVW1oeVUzbWRiaUNtNGUrKzY3RW1sUFNFQStC?=
 =?utf-8?B?UHJxNW0rYXhrMU5POHJFeFRzdEd0MXZaQVRtUFNZUGZURkU2c2gvOHNScjRn?=
 =?utf-8?B?ekZHaE9qeHVEaEd5Zk5jbWZSWUlmWFdjcjhlbFNrcHUybXdnOUNwdFBVSEd5?=
 =?utf-8?B?bEpHekFhUWVyc0JhNWxXaXN0dEg3U0p1UG94YUtjK1BUT1VueGJNNzZFMXNK?=
 =?utf-8?B?QWJBU0t6c3FUbERJK1Z1enJ0d2VkVCtoZm1KVVpMWXBId1FDWVN5a2FsUmVt?=
 =?utf-8?B?d3orYXMwZXVBQytZUGNnNWwxVlZkYWlZK21xa1p6QWZMQStsTGM2SFVvQU80?=
 =?utf-8?B?MmI4VHdvM0tQSi9aUHdHczl2N0J3d05Xa1prOXNwaE5SNCtzVm13TGJZR3U2?=
 =?utf-8?B?NUFlNk5ydzZVSHA2UTA5QjFLSEdEaklCNVpGbUthR056SkdIa2ZwYmFPZUxn?=
 =?utf-8?B?M3dVOURqVmhsaHJvY2pFQTg0TElYb3ZMMlcrUGRpTExiWXp0YXB1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc711d4-fd89-4a7e-7bf9-08da1bf940b7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 20:24:17.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4RZQrGRUB23cQgFpuYhMvlaPlj2lMUqnDuEJsITtXb+yZtqBXo8s8ML1AOG7Ra3uir6+8t7jJJFlN6wR43lkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1774
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2022 12:47 PM, Naveen Krishna Chatradhi wrote:
> From: Suma Hegde <suma.hegde@amd.com>
> 
> HSMP protocol version 5 is supported on AMD family 19h model 10h
> EPYC processors. This version brings new features such as
> -- DIMM statistics
> -- Bandiwdth for IO and xGMI links

s/Bandiwdth/Bandwidth  

> -- Monitor socket and core frequency limits
> -- Configure power efficiency modes, df pstate range etc
> 
> Briefly, describe the new messages.

I think this line should go.

> 
> Signed-off-by: Suma Hegde <suma.hegde@amd.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  arch/x86/include/uapi/asm/amd_hsmp.h | 114 +++++++++++++++++++++++++--
>  1 file changed, 109 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi/asm/amd_hsmp.h
> index 7ee7ba0d63a3..769b939444ae 100644
> --- a/arch/x86/include/uapi/asm/amd_hsmp.h
> +++ b/arch/x86/include/uapi/asm/amd_hsmp.h
> @@ -31,9 +31,22 @@ enum hsmp_message_ids {
>  	HSMP_GET_CCLK_THROTTLE_LIMIT,	/* 10h Get CCLK frequency limit in socket */
>  	HSMP_GET_C0_PERCENT,		/* 11h Get average C0 residency in socket */
>  	HSMP_SET_NBIO_DPM_LEVEL,	/* 12h Set max/min LCLK DPM Level for a given NBIO */
> -					/* 13h Reserved */
> -	HSMP_GET_DDR_BANDWIDTH = 0x14,	/* 14h Get theoretical maximum and current DDR Bandwidth */
> -	HSMP_GET_TEMP_MONITOR,		/* 15h Get per-DIMM temperature and refresh rates */
> +	HSMP_GET_NBIO_DPM_LEVEL,	/* 13h Get LCLK DPM level min and max for a given NBIO */
> +	HSMP_GET_DDR_BANDWIDTH,		/* 14h Get theoretical maximum and current DDR Bandwidth */
> +	HSMP_GET_TEMP_MONITOR,		/* 15h Get socket temperature */
> +	HSMP_GET_DIMM_TEMP_RANGE,	/* 16h Get per-DIMM temperature range and refresh rate */
> +	HSMP_GET_DIMM_POWER,		/* 17h Get per-DIMM power consumption */
> +	HSMP_GET_DIMM_THERMAL,		/* 18h Get per-DIMM thermal sensors */
> +	HSMP_GET_SOCKET_FREQ_LIMIT,	/* 19h Get current active frequency per socket */
> +	HSMP_GET_CCLK_CORE_LIMIT,	/* 1Ah Get CCLK frequency limit per core */
> +	HSMP_GET_RAILS_SVI,		/* 1Bh Get SVI-based Telemetry for all rails */
> +	HSMP_GET_SOCKET_FMAX_FMIN,	/* 1Ch Get Fmax and Fmin per socket */
> +	HSMP_GET_IOLINK_BANDWITH,	/* 1Dh Get current bandwidth on IO Link */
> +	HSMP_GET_XGMI_BANDWITH,		/* 1Eh Get current bandwidth on xGMI Link */
> +	HSMP_SET_GMI3_WIDTH,		/* 1Fh Set max and min GMI3 Link width */
> +	HSMP_SET_PCI_RATE,		/* 20h Control link rate on PCIe devices */
> +	HSMP_SET_POWER_MODE,		/* 21h Select power efficiency profile policy */
> +	HSMP_SET_PSTATE_MAX_MIN,	/* 22h Set the max and min DF P-State  */
>  	HSMP_MSG_ID_MAX,
>  };
>  
> @@ -175,8 +188,12 @@ static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
>  	 */
>  	{1, 0, HSMP_SET},
>  
> -	/* RESERVED message */
> -	{0, 0, HSMP_RSVD},
> +	/*
> +	 * HSMP_GET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 1
> +	 * input: args[0] = nbioid[23:16]
> +	 * output: args[0] = max dpm level[15:8] + min dpm level[7:0]
> +	 */
> +	{1, 1, HSMP_GET},
>  
>  	/*
>  	 * HSMP_GET_DDR_BANDWIDTH, num_args = 0, response_sz = 1
> @@ -191,6 +208,93 @@ static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
>  	 * [7:5] fractional part
>  	 */
>  	{0, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_DIMM_TEMP_RANGE, num_args = 1, response_sz = 1
> +	 * input: args[0] = DIMM address[7:0]
> +	 * output: args[0] = refresh rate[3] + temperature range[2:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_DIMM_POWER, num_args = 1, response_sz = 1
> +	 * input: args[0] = DIMM address[7:0]
> +	 * output: args[0] = DIMM power in mW[31:17] + update rate in ms[16:8] +
> +	 * DIMM address[7:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_DIMM_THERMAL, num_args = 1, response_sz = 1
> +	 * input: args[0] = DIMM address[7:0]
> +	 * output: args[0] = temperature in degree celcius[31:21] + update rate in ms[16:8] +
> +	 * DIMM address[7:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_SOCKET_FREQ_LIMIT, num_args = 0, response_sz = 1
> +	 * output: args[0] = frequency in MHz[31:16] + frequency source[15:0]
> +	 */
> +	{0, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_CCLK_CORE_LIMIT, num_args = 1, response_sz = 1
> +	 * input: args[0] = apic id [31:0]
> +	 * output: args[0] = frequency in MHz[31:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_RAILS_SVI, num_args = 0, response_sz = 1
> +	 * output: args[0] = power in mW[31:0]
> +	 */
> +	{0, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_SOCKET_FMAX_FMIN, num_args = 0, response_sz = 1
> +	 * output: args[0] = fmax in MHz[31:16] + fmin in MHz[15:0]
> +	 */
> +	{0, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_IOLINK_BANDWITH, num_args = 1, response_sz = 1
> +	 * input: args[0] = link id[15:8] + bw type[2:0]
> +	 * output: args[0] = io bandwidth in Mbps[31:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_XGMI_BANDWITH, num_args = 1, response_sz = 1
> +	 * input: args[0] = link id[15:8] + bw type[2:0]
> +	 * output: args[0] = xgmi bandwidth in Mbps[31:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_SET_GMI3_WIDTH, num_args = 1, response_sz = 0
> +	 * input: args[0] = min link width[15:8] + max link width[7:0]
> +	 */
> +	{1, 0, HSMP_SET},
> +
> +	/*
> +	 * HSMP_SET_PCI_RATE, num_args = 1, response_sz = 1
> +	 * input: args[0] = link rate control value
> +	 * output: args[0] = previous link rate control value
> +	 */
> +	{1, 1, HSMP_SET},
> +
> +	/*
> +	 * HSMP_SET_POWER_MODE, num_args = 1, response_sz = 0
> +	 * input: args[0] = power efficiency mode[2:0]
> +	 */
> +	{1, 0, HSMP_SET},
> +
> +	/*
> +	 * HSMP_SET_PSTATE_MAX_MIN, num_args = 1, response_sz = 0
> +	 * input: args[0] = min df pstate[15:8] + max df pstate[7:0]
> +	 */
> +	{1, 0, HSMP_SET},
>  };
>  
>  /* Reset to default packing */

Other than that I stand by my Reviewed-by!

Thanks,
Carlos
