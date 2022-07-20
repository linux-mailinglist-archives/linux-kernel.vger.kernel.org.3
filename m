Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83B57B6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiGTM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbiGTM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:58:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88D27FEE;
        Wed, 20 Jul 2022 05:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ1TTQ6KZ0a0tMc/Uj6fNXXrfFM7hjkXzoiOffczI5lEn31YJEFI0k3r6PHKfdp7+Y9x/B/ndn89bnNlXzcP4s+cpjioFE3zDo0zDg3n5KTrHxKVV6gUFvB1LVmoKiju0jXmxp9vLi/6M+Sx3Jxqirim1xaMyJPnNF30eHuhbZXd0GAkczGrTtjJNNBBSpv+FT7iXSnQjJZ9v/XYeUWvGyGvt0aBLLpYe31iUV4LfJxgYWdH1L0yz71ZnKbWWI8XERPUInGP9rN/OGqi3Fv+m6AvHUvf0LV8vGrB9I0N8ciWRCxnPq8wOmBAOsv1BhBxZ3o2taRqCBUO3ojP/wbgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVSR21n8gqmxtBo4KhuLf7NZCD8u+EXdGFvpPY/OYWc=;
 b=Uk312+8gNoZeTwgq0wGb75/wkehJAIpmDZ+LboMTqH9hRGKFu2Y4wHOEgb7xz9z6UUK/O1Jet3UMMwBuABGdtTRepLKiQdRHlG5zBSI60qd362f4AjqiNOzuL3Tzf0iMPqECK+GM5je0f5yt7NDUXpQVsenlilmtagj5/3FJAyLmXB82YGwzr0vMs9BsEy+LgkGAy1110T67P2oLWm0WuCKLIBJgwHGcUevNGq1Q0CRO/jroCatRS9FJvs9rvoIXXb7lodTfegZud0ZoQdvr57JXLTm9sx42Xb/KSWmP6fnp27KNCc8+7F9JqUPV5VDRga90/7S4d2U5zNfygGWk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVSR21n8gqmxtBo4KhuLf7NZCD8u+EXdGFvpPY/OYWc=;
 b=Mq5qQw1lszQwgZGh/B6UAyuJpdDC2GNNtAuJZNTVsLYFfrnzC6TCUr4Zx+NbSDH56PxD443VOVN59BUoij4v/RErITiq5OAI+AI8F0q5Ftj2idhcFBys/WwzcXehgEv4Hq1TTPeyRhDqi6Cv5ZEVngbLSL3y0rN3kkFFUuyzvP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM5PR1201MB2552.namprd12.prod.outlook.com (2603:10b6:3:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 12:58:08 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 12:58:08 +0000
Message-ID: <188ecbc9-8624-2b74-7963-5f1b909ddf2f@amd.com>
Date:   Wed, 20 Jul 2022 07:58:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] crypto: ccp - Add support for new CCP/PSP device ID
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Rijo-john Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220719161328.7907-1-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220719161328.7907-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f0dca42-5baa-4dcf-ae09-08da6a4f7e90
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzVMH69xzUWYBAp8Rpc4JKYuUo9Du4jBpLzc1tf64cxV1g0Jcm9HR/W+xbfc2m6fUmJklFB2g82Cffn+y3ilkWJmOH6PFWwG9Oe0vlWxXkf+sq2sckUrw1DkZ+kGDrJ6x5LNM7S/VFi8JfJGbUX1J7JYuirGZQ5KVnHldeMZlMk3Lsckn8PcgzGfZbIR5R0DjHs7+p8pnU6M4U0UycAXWCOtJF2yocTBP9T2qPl5k7kGWmKOpnWwm4aoki/fA3GOmZmJ1v36M5Jq2RcngtQ3QmINEfqzxHTMQlUzSF/7ypy6r8lYNbN3b/x8yCrOy1Yi7v+wrGECVgfyIz4TOVnrOb09zCeeTi/4z0g7AWdpkVuziuOyPhlh1zWXXdH7CwtLX+QwJ7E6YWxA0Nr5JJ15mCQ1A2OOlvQyzblhEPz7FQVMlSbwMh2IISe0gepk01PQ5wQ7bISKcLShZAZPE2/xkmqDja5HEEt0MNsYmR6X9q8SrE1PEtPtcLkOA9LHNhmgYrJ+osbqayhhGseLUB2+v46y/Jstsw2fMR04ZMy2KMNFzCBIAIHun4rbG++z8FeRcw00W+fnHUGlngFPv7xsXsSneTcO41UP2IPP9TNrCzOcvn+Nwe2k1myOuXgjBMJ5KgUIXZslzexnYT8/q30yeQ5to9jg/ZVQDj6RcY5brHcmLyrSkTAb9MfuvuZ/GQDynxpbK0WcqMsK3vlUNcsjfanwCHhnE/KzI74SV8UBSqRF/ny64AZI+bN3kZiAFNzSK3s2BkGoCQ+Kpm5pCObrev/1oTvjfRmee1yy+8HcPOeLfvrCHkS2pl6CIVRh34IliTM52FwlCKVAwqvsTz3xwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(316002)(6636002)(6506007)(4326008)(66476007)(66556008)(66946007)(8676002)(38100700002)(54906003)(110136005)(31686004)(36756003)(5660300002)(6486002)(6512007)(26005)(8936002)(478600001)(41300700001)(53546011)(86362001)(2906002)(31696002)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE14MDFJOU9IYjYxSHZaZmI2WHFvVWdFUXBCVjVxbCs0eCtFNG9iQW5nZ013?=
 =?utf-8?B?bWJwZjlidVVVQ3QzVUFiR1IxRlJnZ3hLZEdwc2J3ekEyOHJ1Y0pvQlRReGl1?=
 =?utf-8?B?OElWN3FXeThEdW41elY3Ykp2eFRvc3ZJY3lWSWRCUmRsOENKZm5sOHlxNmZx?=
 =?utf-8?B?TWlPa3llZU51SFdVMEptelFVOTlFbU12U1E0K21QTE5CaUF2UzBITE9VM3pJ?=
 =?utf-8?B?TnZmdjRidXdiUTFBOVpGS0pDS3FXaUN1bXdpZ0h3alRrOWJ5cXl0RGRxNU0v?=
 =?utf-8?B?bUp1Ym43MlNjOUxxQityQzVQUG5tcTMzWEZSbURZTmtwNzV6QmFYNTZqdFVy?=
 =?utf-8?B?V3lLdUFGSUhuRzhQcERhc1JHa2lQdGR6VnlSTm9ILzBDYVBnNjJxbWpQOTNa?=
 =?utf-8?B?b2FjNlZCMThqN2pvWUdWV0JrZGY0Nmkzb2Z0UGZDL0h4T0g3RUlEMmVPVkxT?=
 =?utf-8?B?ZWY5TTdCSk5FV1VxakZBYkszZTVrcG93c3ptamliTGRWbVpWUWl6MzBzMzdi?=
 =?utf-8?B?TXJzN1g4THhxWW9DNXhEMVB5UVlqZHQ4UndIVUdJTC9TdERJMy9XZ1hVRS93?=
 =?utf-8?B?eVkwL2RXSlF3b1hPV3A5VzI2OGxLWnd0bVhpSkZWV0dRdUZrU01BTGYrcW9D?=
 =?utf-8?B?MXdqeHhLN0lML0dZYUVKUHRGSExNdVpPeEdXV0Vpd0MrdTdIOVQ0dlNKS05j?=
 =?utf-8?B?bDVOY0NGR2FCT3JpeE14bFhkWVFubHF2MlRjMkNRZEhpWG9ZdmU0NjYreU9W?=
 =?utf-8?B?dktRajZQdm1hZGZxam1yRmlVRytrMm14RUwrZmc5b0kvTXBUVVpWY1NLT0tk?=
 =?utf-8?B?S1J3VHQ3ei95RnpQemVFWEZ4YitqZVJ0ZnFmdkFOTm1tMk9NNzJCL1Vwd2dv?=
 =?utf-8?B?QUFDYW8wUkRwZEsxTUtlZmZUd1pncmdkRGZGRnNsaG1EWkNXaGhNaVpNTzdo?=
 =?utf-8?B?Ym1RU0RySDV0QWwza0hLTnZIU2FmREFuNnRwNml6S2dXMDNYRUxnSnZnUGQ3?=
 =?utf-8?B?WlVoWHFUeXNDdzJtTkRzMGtBR0dCRE9vbXRaT0JwMU91MHg1Y05lZ0Q5cjFZ?=
 =?utf-8?B?blVDNHU5QWJMeHo3ZXFYZ3p1UGhNeWdGVGNXcSt4MXRoaTBMcGRWTmxsWHNr?=
 =?utf-8?B?ZHBia2lGZ3owZTVyelppUTBCUUhKTVZGaG0zL1FpeG40blFodXRRYUY1MzZW?=
 =?utf-8?B?NldFcVRabjUraGhTRlV3ZHo2enFHbUFrRHVxbnhiY2htNTBvcXdtdXpPcldC?=
 =?utf-8?B?aUMrV1ZGSXNIalo4OUVYQjM3NVBob1l6Tmx0QlI1V3NzRlV0ZWJBb1ZDVmpz?=
 =?utf-8?B?d1hXem9tV2dQNTVVNnR0bUN0N2dzVlpXdTR3dm5wVFFyQlRQSXlmQW1ZVzVy?=
 =?utf-8?B?OUdaMTJFVXgrb0grczJxNWJSQWMvV0piZW02QWVsWHFmOC83MW56eVZXQ3cv?=
 =?utf-8?B?YUtld0ZiVG1VL0ZIOEN6dXlrdTRWazRtOHNKemQ2YWEvT0tSN1BVS0x4U1hC?=
 =?utf-8?B?bXkyRkFubWdmT01zWFNHNjA2TkVRR2VVR1lxZHJPUWg3cVhTQjFBWUJqWFNW?=
 =?utf-8?B?cW1JRUt2QzNuYXhQKzQ4L0V1S25ZTWd5TUNTOUJmNW8vVVI4QUlMVDRKdE9z?=
 =?utf-8?B?UVhOQXdWRFA3bzdZU0gyWDk0dUN0b3BmQXN2SmZuSTNPZWFvenExeDcxOXpD?=
 =?utf-8?B?SFRHalVSaUpDQkgra2Nha3JjblNLQms5d2o2WlJmR3k2aVBFZ3ZCOHBhZXcz?=
 =?utf-8?B?Zkh4Q244V1l3TkhoaVg4MGgzZndRWlRPSnNnOU5YVFRWWS9QZ0dzcEZpb3N3?=
 =?utf-8?B?cnNjdm9zcWxtNDZsZXFqQmJkS0I1aHcxS3hxTjR4Qzg3b1M0bTRnSGpRazlP?=
 =?utf-8?B?WEtwYlUrbkVmWC92RWVZUEQ1Q2R6NWdzZ21nRTF2VjUyQkRRRk84K285SVFu?=
 =?utf-8?B?WVEwZWo1Q3E2WXVHRHhHdTEvOWhRRWJWS3N3MWhMUGpURjhrYVF4OGVDZm9v?=
 =?utf-8?B?MUpYM3psTnpVdVhCL2grV1VzbVJFeEVtOVFZaXd3UGk5K0lQMTBpYi9qWkhZ?=
 =?utf-8?B?VDRVdkJFZkxCNnExL2U0S0pJWlZhYkZwRzlnNTdGNy9XQXRyVEVjOU5hZ0h2?=
 =?utf-8?Q?dKlx61ASqMoBt/oqftSsyinbe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0dca42-5baa-4dcf-ae09-08da6a4f7e90
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 12:58:08.6280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G+0b6MpfCVYHP5cuy+d91x6VHdxSlsbDHJdqqM5QL+xWHBIenjKO+ic+6GQQogtct8eE+OgFjzWV+qzbqMa3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 11:13, Mario Limonciello wrote:
> Add a new CCP/PSP PCI device ID.  This uses same register offsets
> as the previously supported structure.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/sp-pci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> index b5970ae54d0e..792d6da7f0c0 100644
> --- a/drivers/crypto/ccp/sp-pci.c
> +++ b/drivers/crypto/ccp/sp-pci.c
> @@ -427,6 +427,12 @@ static const struct sp_dev_vdata dev_vdata[] = {
>   		.bar = 2,
>   #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>   		.psp_vdata = &pspv2,
> +#endif
> +	},
> +	{	/* 6 */
> +		.bar = 2,
> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> +		.psp_vdata = &pspv3,
>   #endif
>   	},
>   };
> @@ -438,6 +444,7 @@ static const struct pci_device_id sp_pci_table[] = {
>   	{ PCI_VDEVICE(AMD, 0x15DF), (kernel_ulong_t)&dev_vdata[4] },
>   	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[4] },
>   	{ PCI_VDEVICE(AMD, 0x14CA), (kernel_ulong_t)&dev_vdata[5] },
> +	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
>   	/* Last entry must be zero */
>   	{ 0, }
>   };
