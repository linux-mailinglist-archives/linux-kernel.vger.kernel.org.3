Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DFF4EE26E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiCaUOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiCaUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:14:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AEC1FE567;
        Thu, 31 Mar 2022 13:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNXVSUgyqOmulKO/SwHyT5XUZdevLjk0L0Hc/PCs1rP+x3itB4H4Ow6JqbAJLFOMVbA6+HFcobLGl7orqd8sCe+fKp2l/x7Ra/2KEQzYKx5XcBycwfPsi8yF3zxNh1LmPdz4FfxESjNZHXvoKmioC2xLN0GYyOYgiTbH1QEJdT7shsmZSE37gyxez2dWUZaK66FJ7wPSRchF8jViEk0vKa/DAjSfPbUuWZ92g4+2vHeArV+tfKlFEK58ddNkQiMs0dVBrQYwDAJ42NwnIgmFgkBK8nvTi7yQFj41zeuJCzSyBHaey2Nrg5ALIY+Z0YIedADZlib4o89xENdX2Im9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkSD+Nn9f6yQhav4+FtjRYMSLeTyNh7xR8rpPNsiyWM=;
 b=bTmNT2K/T5VZOD8cmaEp7s8RSWJx/vORIuOJjO1G1GA6ZjtRH8McQjTU3b95J5ZkH5I/mq909YMsW4gmUPKXG7Phr0/WIqxRBOCtdVcP40RHh12Mk4taP/hU9LtQY2xysFDyCiiXTRX6++gMRgnG55vp6NT8sOJ+AI4ILjC8IJWBDSHJLWms77Fv4Yg+YmCKMnhuFQXRPYrE828Qj/ohYQ8LXE619WH6+CkWQjT4C2iJBPd405WD2kGudpaCKquye4GQN89sMKF7+UyHEXbqHPa5/yulvHM2Uq//VreHA7w9xGghtvvWnJiTbKSW9yOd3UUb+l2Z1A+fLHR64l7rCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkSD+Nn9f6yQhav4+FtjRYMSLeTyNh7xR8rpPNsiyWM=;
 b=ghToTbq195ey0xx3uWjIJSW6D2uZF2U8n55sqGxICalZMS7a/+WXfPBNoEwZLlbqcRdoqVSWEezJiDKesl1LiKuEHeKiOTUcP0awPS5cvrT31rxs7VWQ5zifZXch3kNJFW8fsmdF/PE7UVWDk/or12p55bJTghd1/MQZNZU0jCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL0PR12MB5524.namprd12.prod.outlook.com (2603:10b6:208:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 31 Mar
 2022 20:12:24 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e%9]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 20:12:24 +0000
Message-ID: <f0a1cb5b-091e-a94b-f767-533f75d0296e@amd.com>
Date:   Thu, 31 Mar 2022 15:12:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] crypto: ccp: When TSME and SME both detected
 notify user
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
 <20220329164117.1449-5-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220329164117.1449-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cf42974-b4c3-4f09-2723-08da1352c512
X-MS-TrafficTypeDiagnostic: BL0PR12MB5524:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55247F79B7FD6EDC30C54499ECE19@BL0PR12MB5524.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMLcUqisLies8UwUpHopbNmu3o/m8H78lB5QM0OjZJNpCSWm7qXZ37KLp6W2+emSdX42TvZbGvvCegxbRxYl+9pRies3JOKXdjw3Bfyscmtcn4YJ7kiMyaRxlJF5zLZTndNHzMZFkVd89k6aOOnuPhllvnERkv3KtzlrIlHUHIPXj7eYACOQyOaIFsdv/hBeSgCow9aavmVqA7JWs8LHH9UCJaNdqHwfLYWStsdgA01eg0IXpGpRBcLDMYmh4lyKQWvnO1zPfMonnxfwkIUsORljFnL3mwuAZxTJDsFuLZ8HJfWMCJaaDhSQvB6Aiih2CwzDTRaZl9Er0XjKhHbeoz6GMzoKVpEDeeeQXxXJE64D99Rjc4BiMjJTNhOk+cMy+kL9lcizEnULU7RfvSWjEmEVWRYem50hcylgpc4T5b0GXJPCcUYR0ljJSBpFDxfuDtqqoqj4t0/fJ3bO/ytNsX29rvoxf91F4enCKvvxDStqTzT/7Fa5t2qxeI6P0We/+c2VgegqUR0rSkra2XyKe8m6bvRE8gSHJWPrTjPYaLo0jnv4rqk3o1R/3vwVZLa7y3uM88Ue+KJ42+6hIchnGdKjUjapYPa506GJP1QzuZGF3Djs7DeR2GWWOqh7x8mHkGDPYzmO7HAIaFrcjbXcCyMBUdwkDmBhN3HvqJDMZPNu1mqI9yCoZ+xmmUnm5cjjU/vy3oAeFkfjF15v+mUCNRutdvy2IF2/URdhfQvJVMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(6512007)(2616005)(83380400001)(6486002)(31696002)(53546011)(26005)(110136005)(31686004)(186003)(508600001)(6506007)(36756003)(86362001)(38100700002)(8676002)(2906002)(66556008)(66946007)(4326008)(5660300002)(8936002)(66476007)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUx5eFQySHMxRlBuUFV1MTFFbnVldkFtaS82Rk9QK29aeHVnNDVoTDhVenQv?=
 =?utf-8?B?Z3BHcUZmSlpaMFNwSnJST0FBbC96aGM3aDNUQnU1ZWxIbjhoY093aVRJVlIv?=
 =?utf-8?B?SUtqNVpFdmRGcUJYRyt5TFpTYnExS203NUdVd1doUUNMeEJ4QS9uZllDaG9S?=
 =?utf-8?B?MjM0RDBaT1JZenR1dm00ejFCakpuNUZLbW1EZ1cvZTM2bU15cmZIK280aEY5?=
 =?utf-8?B?U1ZoNU0zQ1NrMWNzNk1mcDBpWjdIZTlHUk9MMDdHdE5yUm9IRkNrUFh6UTU2?=
 =?utf-8?B?STBITE1BK1JvNkFEQXNpMUgvVHM5aTZxaUlvSU82NEQrb3lpMGdMVHhWVFQz?=
 =?utf-8?B?UjNkaFpYbXRqdi9XN3VwcUZPRm44d0QyRzhRSzNHV3FxeTJGWGpoV3EyNklk?=
 =?utf-8?B?S3hiZzVLS1h3amxpV0NKcjlXL2VTWHFtRnNjMlAzQitFVzZDY2hweWxEMzdU?=
 =?utf-8?B?S0RqUnMvcXRhWmp4U1ZNQlJMUG1obXdKN3h4Mzl1ZkkyNnlyb0M4SENTMWZL?=
 =?utf-8?B?eTczeGtNUDNPdGhaZXhFaHlPMDMrcmpGMnFXRXo4dkNaN0ljSVhBOEtRZHow?=
 =?utf-8?B?dGVXUVdzZ3JEZjlYaFNwSHQ4ejhOdzNKbFppVkhnbFBHcDZqQldBL3R4Qmkz?=
 =?utf-8?B?VzBaTFluSTNSQ3hQcithdjZOcmV4MzlyRk8wRVJ5eXRNU1pHQmRHb2F6dnM1?=
 =?utf-8?B?aXJMMFB5Y2FRWFZBSE11cmxMcXF4dTJwQXpNWmVqSzRUZW1IaDNDNFJqMG1Q?=
 =?utf-8?B?bDF4TG5YWUs3QlMzT3RmSnJXdWpNb0UybFJ0RnRnNWN0THYzWDVWT1l4N2t2?=
 =?utf-8?B?U1QvWFdORW96R0J5N1RHZDEzRktqR3hoTFA3cFlwdVNyVFVWYitzbWgxQUhi?=
 =?utf-8?B?TGZRM2UzeWJSb0RnWHM2b0ZwN1E2Q0hqN25nL2lBS095V2VxUmF3a0hJSXcz?=
 =?utf-8?B?ZC9VQk5Zai9PNTlwZ3RYWlpPeWRMYjVscnpTdjB5QTF1QnVoc2h0MXNDNFZk?=
 =?utf-8?B?cFhBSEhOc3ZETGZFSUZFQ3RGUFNwdmZRUk1uM3R2TDhuQ2oyc3poYWV5aW01?=
 =?utf-8?B?ZXlCcTlUYWdZKzdYeENaQzZYNjhYdWtaRlN2amRTcXZqTWNOODlSY3cyTG9o?=
 =?utf-8?B?dkdGUVVjQkhLTkN4Nk1nQmxIODgvb3RGYzB6MHUzMEpTNTBESEE4b2pkOG1Q?=
 =?utf-8?B?amQyczE4SWN1cndweE1aOC9kc1NTcm1OVXJpcWZ6MmZIVUFkODdhVnlPcU1w?=
 =?utf-8?B?K0xiK1VtVCtwdTdYOHFqNlBMb3hrNTBmTEVjQkx0YTFHbnBTNW9PSFJSMVdR?=
 =?utf-8?B?UmFoNGtTc0o1YmpLek53SjE3bGYwQzVaYThPUyttK0tNYTFqaEVIMWVTY0JZ?=
 =?utf-8?B?WTdYZGZWbk82eno5L1dIRHhyOE1CbWpCZ3NOZHlrWEl4OFFZK1h2T2dzdUg1?=
 =?utf-8?B?dWI2MU80WWFlNDJRWUtUZ256OGRJenNEbUFsaWQvU2JNZ1EwNEdQb1ZMazVU?=
 =?utf-8?B?TjloUko0V3RFa3pSdkpvRXdRVDZMY0FhMVcveWFBZkZuNkUzN0JISEZzSEZU?=
 =?utf-8?B?Z1pKeGlPRURuMS9ncWg2NFlsNisxTDIyc3Nva3J1QWx0Yi95UUtXOHVPVU56?=
 =?utf-8?B?d3V3WXN2QWZPa0JOWStJSEp1VGtXRDBSdFpCTEYrR0daOUxQZ1ZNYUNvcVBX?=
 =?utf-8?B?dmlQcmk4YlVtNVBUNEtNdGRuTjFhOGF4RW9DT1dHRzZHbndJREY1b1c2RTRF?=
 =?utf-8?B?Z0QwTXY0ZWl4bW81TzdOVjFPTTdhVStiSTU4b252Q1gyY1dZQURNZDBNWG55?=
 =?utf-8?B?Rm04SVM5eWxTb3hnUFZwNlJBaXlUdVhOVE9MdXh4Mmd6M2RTc0pYWUJZdzJT?=
 =?utf-8?B?R05Jb3hXV002RnpmRzlXRnMyaUppSEhTaFl6Y1JZU2Zld3hJQ0FYUTNJeGp2?=
 =?utf-8?B?VlpzL0pxdXkvNWNRNC9qRGFjenB1SjNNS0QwWDE0L2pXOU5ITTdQQStDY0NU?=
 =?utf-8?B?ZUVOOXFVdFI5MkRVUWExYjFVTzh4U1hzbTRZekgwdEd6SGVzTkkyQUg4OGVW?=
 =?utf-8?B?SDQ3MVN6ekc1RmREaUZxSFg0RmpwT2NnN2JqQVcramt1VVZ5V3hob2lYVk1X?=
 =?utf-8?B?cHFDU3dSY2oyQW9CaFpGUjdjTWY4VzFUNkNtMngyUERKMXFrZ3grNDI0clpQ?=
 =?utf-8?B?OGxTa2NiRmgzbVhMSnhlblhsOUN3T2NoaFIzYmNhODNUWkY2WWNpOEVxeCta?=
 =?utf-8?B?dVEwNDYrZUNRRWZlVitEQXNOeHpzaDkweGgyN09tcU1yUlRoVTYyTEYyL1ow?=
 =?utf-8?B?RzFRQS9QSG5heFRJdW9tQ2Q2WFBKd0dPb0l6aWVXUlZOS1dyS0RyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf42974-b4c3-4f09-2723-08da1352c512
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 20:12:24.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/gX9AqtpRClaSWqGHmOgEfBeVNwLCoXWdUM+szq2KSP4MVmGUqLwJfdKNoVEVbw8nyTHYDe5ZJ+MiuHSfc0dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5524
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
> CC_ATTR_HOST_MEM_ENCRYPT is used to relay that memory encryption has been
> activated by the kernel.
> 
> As it's technically possible to enable both SME and TSME at the same time,
> detect this scenario and notify the user that enabling TSME and SME at the
> same time is unnecessary.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Reword notice about TSME/SME
>   * Use cc_platform_has instead
> ---
>   drivers/crypto/ccp/psp-dev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index 3f47b2d81e3c..38cffc1de4ab 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -74,6 +74,13 @@ static unsigned int psp_get_capability(struct psp_device *psp)
>   	}
>   	psp->capability = val;
>   
> +

Extra blank line.

> +	/* Detect TSME / SME both enabled */

"Detect if TSME and SME are both enabled"

Thanks,
Tom

> +	if (psp->capability & PSP_CAPABILITY_PSP_SECURITY_REPORTING &&
> +	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_SECURITY_OFFSET) &&
> +	    cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> +		dev_notice(psp->dev, "psp: Both TSME and SME are active, SME is unnecessary when TSME is active.\n");
> +
>   	return 0;
>   }
>   
