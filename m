Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0648358DB72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbiHIP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiHIP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:57:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E98D15711;
        Tue,  9 Aug 2022 08:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzBVjSBJ8zpCkX68XwqmEpzrnmBPvCO6c+MuGWFu/E0YDOMSpNPvGC9ANtH+a4gM6cd0dBBq3xz6Pqd75N3w24UU9LBkKhEzuH23NF0p4c0pT6VvrmqSbf0jkFVdF7QwTX7R1XaABchFE0wxCAlDRgmu+CfEYT3bLG0wGQV2QSoT5B5bxfVudqHw5HvxJkGMu8F1aAouz7Gcfz9S6rRaI8eWgmwj2LV49GgvYPgSwkexe0Wl6fgx+CcPGpexOtjYmBzYb4qlzHv3dLAfubiFnkoTRI49nztj2DhFw4X6AYoi2+OTuB5M6MJqU7Vg4+tSgKWM8OLpulHy0GedLGW/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O/dJ1UGtzVdbF1zKryGS2+iI6gtBDP0RR0R5t5pOYI=;
 b=WfDZJtD5kOnbiOlX5xVkxoMGmEpNvyq2a/OQAhNqNd8vc5QUm8GMRPSJMgcfk6lihRgo3jrvx4Ow6DIIofSpiG73v34b6SJxivQ6fIPEM47Pjw6VHs9MI6p1YV/HOK8iPC8ZfDjeoGfl3SsVzJINqdPb8QhazU3ZMoVByh6Qoll9FJCuFVC51d97sB+oqJu8svX6k9matBBzejZ51IbSCdcDVfr7RL/34feCu5GizniSJmOctnpWv0FoXdakMfPRwmHKkvqols5kbn9ijgyiqn9eupbDQgALlXj/OlXgm6fq7I5McCQyMkmtGp4suxHwONcWfBQszxYRd184hxoDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O/dJ1UGtzVdbF1zKryGS2+iI6gtBDP0RR0R5t5pOYI=;
 b=whsfeErn95VkFuyJFxCI+3Vef2v9U4ZAjRUaU0zU+Tt/gbZxHJw/Dck8cW1C5ae0uU2KkvbqhBEfAV9nikFZr2vErrUbyXcQAnJoCEa13q5oOEhcvp37/YgLgVmPjihsyaoWbGFTRkl9V2T/tczviHgswxsOVcG+DmVuOsuPxZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Tue, 9 Aug
 2022 15:57:18 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 15:57:18 +0000
Message-ID: <0a3a790d-989f-2f76-f636-62fbd925a776@amd.com>
Date:   Tue, 9 Aug 2022 10:57:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] crypto: ccp: Add a quirk to firmware update
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@profian.com>,
        Harald Hoyer <harald@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220808001537.6479-1-jarkko@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220808001537.6479-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:f2::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e405a6-2616-45da-2324-08da7a1fd659
X-MS-TrafficTypeDiagnostic: PH7PR12MB5686:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eqZ/MOwemkXQcX3vQPm2/zxsR6dM1IMNZUvtUwiGZRTsidvN9uXU7GImR+BTrtl3A5w/7Ec6BQsa8Wh05GtgX8dBH0YJyNS71HIsrRklVGwZppGI3fx7VdVy9MEjxmnVdPwvz9SnCKf0pR853AQmrGBCjXtJmyMWmfHln6nKQ1jYjfJCXdGqUAHHGnxcXYW5mj/2cin46RIXRNuIC3ql0uijq/cMCtHyeUfxSX4v9ImCGlxari9CSyyRThNwr5hcr5zMC/jQvHQcTDRYRsZVLJK90bW4K14SN9xsI2NBN6BnaswiRFeCbMTg399gbSwl2arqL8mhUGQwzLOQuSAyHAdf+c8nMboyPto2qRVrRDeziuhJNyCEUen659KbdDk2WwEtqTPKuY2WAhi4rl20wurVoAykDBwjZfq9mx6Xzv3//YPuO83tVTayI2cnXWKMpVrcjToDxBiG8p2iSGjo5DF1G8gUal0YzCluMMYcux9N874acEDcXy3mDEfpLEluNimlclX85A8y759nodIblaplvGP24BoVyQSEG/l4YqQXC/mTEr+Wjj/StBH5Bzt3CVBNPYRUz40o/0jxuAmkwchD+7PFEEcjBSLtlxfiCICSZfyO9nlZrqFY4pGbu9SBzGpmsYthQwa35/VyOx6hG3jzJqAhefqiRMLyxGJLyJaw1zcKfL/wtnW5bWFLH1WhlhPpTE3MOLCbImO+S3TrTAYcSXCnUo+L+nPUuqhsD6LipIoPXGq2XqFQ3FGjV1VcMD+1NgwqgN0SKl8gJefKd6JlenCvEoDGY/rNCVLkHTZutTDb/MaGn5gMgLzEaLyYv86GWCfslP5eUgf3QGtVhdFXQsv+EoGJNYdzzcNrQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(966005)(6486002)(41300700001)(26005)(36756003)(478600001)(31696002)(6512007)(186003)(53546011)(83380400001)(31686004)(2616005)(54906003)(110136005)(6506007)(66476007)(66556008)(4326008)(8676002)(5660300002)(66946007)(316002)(38100700002)(86362001)(2906002)(8936002)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0tmMmR5S3VtREFZQmJVL3NDUHd1em1zRzdEMGh5TG54eDlCTE90NU1GWXdv?=
 =?utf-8?B?ZXZFMm5lM2p4cDdKZjJaTnQ2ajMxeVV4UndVQTJuUDEvUHIya3lGRUtZN1I1?=
 =?utf-8?B?UmNUOWN0S2dGUzJYSitkRXFxSlJFdG1QT0h3UWplbitiRkNuQ1JwV2tJelBm?=
 =?utf-8?B?eDYzeEZVcnF4LytXYm1VZzRmd1hXMlJ1ODJ5L2FyYXY0T2hrWXZQWERLd3la?=
 =?utf-8?B?Vis1UFhKQzBNU1NlNnZ2ZlpkOEdZRjBDTFIvN0NwaHZMSlF3d1VHZ282b2Vl?=
 =?utf-8?B?Zys4enlBQXh2bGVJSUJhQ2lzcHZQS0xZdlZMeUhOS2RqN3Z1dlJzSi9lT1pJ?=
 =?utf-8?B?WDUrN0h3bE9KMDZzUjFUZmVrRFNkajRwWnZrNFV1ZXVyaENOTkdzUFBBUUpH?=
 =?utf-8?B?NEVpcjZIc0VkZVlqa3JZZ284Yis5RTBvcmhTSzd1OVdDL1hKUks4cnU3YTdK?=
 =?utf-8?B?V0NTZkZTZFNRbE82ZDVoS1dNNjYwSjFkdTdIK1R4TEpFeklPR0RudnhXOEox?=
 =?utf-8?B?YlIrTWFxWkx0YXd4NUVqRTFGT1hIN1hCRTd2akw3L0NrN2tnZDJjOWtEYmxp?=
 =?utf-8?B?a2k1cjNvTEFLSHdXOUU5QUFFV3l6SGVFdmFyamVFRU9zdHU0UEVNOStpYXhB?=
 =?utf-8?B?SE80RGxaVHY2ZEJaQ1I5MGJCeXpJdjZOV2N5RzFRTjJxdFozOVhUR1owRTB5?=
 =?utf-8?B?MFlIa0xyYmF1WEkwSXZQVENJWFc1bk5QdU5ib1l6VnJ1U0RQNnJSRjJYdjQ2?=
 =?utf-8?B?allBWDlvczZnbFJ0YklBa3BaakdLNHhEV1NhTlZUUHYybTZOOHZkdnJMdC84?=
 =?utf-8?B?S05tK2dHanRBQ201cnZHOWc4eW1UYURwSUhQQnNYUXczOTM1RG4ybmJkSDN3?=
 =?utf-8?B?bTl2VHZKbjdJeEpldlJRUExLOXFoRktSS3V6d3RCTlV3MEd4UDZteWlIemxr?=
 =?utf-8?B?cmk5M3FjNU5BMUlmSGk2ZWVQQVcwY0FPL3pSNDJnUzNzOVhiSXRnQW1QaWZy?=
 =?utf-8?B?OTRCV1l4MHZLMUZwM3VUSEo4a3ZwZ2w5WitQNmJCS1M5MkJMdTczaU9zeXdG?=
 =?utf-8?B?L01tMDVrTTV0UktIVm5kU0xpMW91ZzBSNjBndzVJc2t6UzZYcHZvNUpvVitT?=
 =?utf-8?B?NmdIeTlpenlkRzN0QzlhTG5DMFJnN0JidDg3Sm9wcEpTczAzT1lFZ1AxVTF6?=
 =?utf-8?B?WFhFaHg5ZzhQNTFxbHh3dHlqMHdVSzZaSnVKZmJwbW01VWZhbzZUOEpqbDAz?=
 =?utf-8?B?R0ZxemZyOVNMb2Jwc2RkdmpkcldNN2hGR3lhdVlvNkY1aTdCTGZiVSs0L3dY?=
 =?utf-8?B?RnErdUttYVdJZFBXS1h6cndSTko0TGhjKzlNVVJjeFhNeDNYWlFVNDltREpV?=
 =?utf-8?B?eU1KZ0I3c1FvMkV5dEVBY2M1Sm1PRW9mbU5ScVZ2NkJHY2xOR3RraWovZXho?=
 =?utf-8?B?R25Oa1RGUG1xOUI2YzFnNEYwa0FNRGxZTG9oZFB6ZVp5dXhLc1NWU1lIeDVC?=
 =?utf-8?B?ajlVMVNxSzdNMnlhRnlBMVg2TjdzYTVrbGQvcTdBU05KZFNvMmoyYnlRUUVZ?=
 =?utf-8?B?Z3lEQzV5Ym1IdXRFWUdMaUR0aytEd3pxY3FwckNSa2t0K3FycEZlMTRqUU96?=
 =?utf-8?B?K2xXQ3Flc0JpT2Z0Nkpqcm81b1Qya2dpOHh2cUs0dFp6N0l2dllxdUdBM1Fq?=
 =?utf-8?B?VndsUkZRYUt0MWhBYXV1RU5ZTytpVVpETFV1bkJyTi9KcENvNDNGOFptTm1U?=
 =?utf-8?B?R0hqYlM4V1l2d3hZdmpBc0dvaFdNWXl2c21mUUZtNU1QN211MXFPMEZFYnll?=
 =?utf-8?B?VmVyNDBmcU0vKzNSMCtFK2x5Z0U4eW1FeHJzdEIzaW9QQnVjZ0NSS0Y2UzNj?=
 =?utf-8?B?RjVLeGQ4bXRhU2kxeml4Y0pzTEt2NENhU21NbnZmQldIWDlEUkRUZUxlcHBG?=
 =?utf-8?B?R3hNbUozSkNNdW10Um82QktVdkYwbE81dU54emVxV2JCNGVZQUlLR3h6OGZ6?=
 =?utf-8?B?L29qeTgyRzU2TkpNSFVROUJ1VFBqYmZWTXJkSDE5REYxUTBrYlA2KytLNU1s?=
 =?utf-8?B?djB3ZU9XOU1Qa2kzcHBxOW9xeThuNDdvSTVsUlg3d3orU08wcXdJZHFPR3Q1?=
 =?utf-8?Q?u3grwzFc0/joJBjPH8ITzvhtk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e405a6-2616-45da-2324-08da7a1fd659
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:57:18.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Me16fdRlV8QvmYufGxapkdMDm0RI6nOgDtQFoH3KnT4aO2tSWt8gRvWPvRV6cMlzvrTTVyLkBl3FJGz9dJPRzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/22 19:15, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko@profian.com>

Looks good, just some minor commit message and comment changes requested.

> 
> A quirk for fixing the committed TCB version, when upgrading from earlier
> firmware version than 1.33.01. This is a known issue, and the documented

", when upgrading from earlier firmware version than 1.33.01" => "when 
upgrading from a firmware version earlier than 1.50"

> workaround is to load the firmware twice.
> 
> The issue realizes in a machine where the upgrade is done from firmware
> reporting having SEV API version 1.49, and requires the following
> workaround:

Replace the above paragraph with just: "Currently, this issue requires the 
following workaround:"

> 
> sudo modprobe -r kvm_amd
> sudo modprobe -r ccp
> sudo modprobe ccp
> sudo modprobe kvm_amd
> 
> Implement this workaround inside kernel by checking whether the API
> version is less than 1.50, and if so, download the firmware twice.
> This addresses the TCB version issue.
> 
> Link: https://lore.kernel.org/all/de02389f-249d-f565-1136-4af3655fab2a@profian.com/
> Reported-by: Harald Hoyer <harald@profian.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> ---
>   drivers/crypto/ccp/sev-dev.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 799b476fc3e8..8ae26c5c64f6 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -742,6 +742,11 @@ static int sev_update_firmware(struct device *dev)
>   	struct page *p;
>   	u64 data_size;
>   
> +	if (!sev_version_greater_or_equal(0, 15)) {
> +		dev_dbg(dev, "DOWNLOAD_FIRMWARE not supported\n");
> +		return -1;
> +	}
> +
>   	if (sev_get_firmware(dev, &firmware) == -ENOENT) {
>   		dev_dbg(dev, "No SEV firmware file present\n");
>   		return -1;
> @@ -774,6 +779,14 @@ static int sev_update_firmware(struct device *dev)
>   	data->len = firmware->size;
>   
>   	ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
> +
> +	/*
> +	 * A quirk for fixing the committed TCB version, when upgrading from
> +	 * earlier firmware version than 1.33.01.

s/1.33.01/1.50/

Thanks,
Tom

> +	 */
> +	if (!ret && !sev_version_greater_or_equal(1, 50))
> +		ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
> +
>   	if (ret)
>   		dev_dbg(dev, "Failed to update SEV firmware: %#x\n", error);
>   	else
> @@ -1283,8 +1296,7 @@ void sev_pci_init(void)
>   	if (sev_get_api_version())
>   		goto err;
>   
> -	if (sev_version_greater_or_equal(0, 15) &&
> -	    sev_update_firmware(sev->dev) == 0)
> +	if (sev_update_firmware(sev->dev) == 0)
>   		sev_get_api_version();
>   
>   	/* If an init_ex_path is provided rely on INIT_EX for PSP initialization
