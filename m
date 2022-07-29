Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD45584A84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiG2ELo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiG2ELl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:11:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519DA6D9D5;
        Thu, 28 Jul 2022 21:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJyDZn/AjD4XQ1kZIoRBUHAfPFeHQ2N2Qw1qYgwpv0y6tW9qUyYzjp1x4my7dfKxNklnE3nKq17/qhPLdg2DtjcB4nyLIMYSc4L+XQFpd0/6qo1o2XEyFOKSpVWcdKUYVMHLBNoKYbHYY+DG0Zl2540FyYNT+98ZQ0xuogMshqQpSVRwh5pAXjeI9ItegZ2QrqDIpGFLgHdVmB8QpGO4wuyKPN3USaMB7LneT9aO0k+R7oNkBS+FxroReSNO6YqnFGERvQTm4k7rdzS8f/sp21jqh0XkfKCCW0JQJSvXwDC7GDfbhc9w31mD02WUCuhSfsOITrxWsuGNpIF7FfxhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdPJwwGO2OARN/iw6a9OwdWhquDhALcEUn94ouAHCEs=;
 b=c6FZV8alhBsTU0TmY6v9qTS3AHf+sLppaed07q1O+2P02n2NoDEgx7sGs1NNhdiHH8RxY4Jczv2D2LLvQfCyi9sZ2TrKw94UXGEt8vsmrolfe2dKMeuKHXRXgygU3jrvBdQ2oLHGcUgEL+9CtfVCplulOi4Kag/mTwdYt4TF67toPTNY+5zqTtrjueLvZU5Htraz6ryQvfAxmNQqcykWNul2jDsxOYnU1yKiOpV+HsIHXxW8KO9XKBaciTjqU19rCHiUaOzLSJ1/kkwIyzV31Skzc/0SyD/Wx+rna582XHJIwLZ/SLuEZ2/3OZcGihDS7/nL5WCl7EgmzWk7k6IYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdPJwwGO2OARN/iw6a9OwdWhquDhALcEUn94ouAHCEs=;
 b=rvAuhyhgmSZhjkcQg72u7ouXmu1unw6s7Tswil0vGtbm4F+1TrbRdvIXZVOaacnflufV+e3QCKn4qoAmI5qbwATZZD4fI8Xt6hXjMO5qk65pL9hVSgxHlwvqaxCaUA9SeM3UAgJDYIKlo2NOgENCmZwmrvl1ziCR4VzdD0yZPaO6r82rrGYmZCAYVlVGn3Xycd1ZEUkZ/VCy8iZWAm5jub3v39XVAcB8mXdBadOUtarz9JBf7lNZZWwX+3IPGBrk16ecGhKdSipgrhCxgNNI1l2CA05Rft4OgjrI8hlxITfashJl1rbi7C+CHDmkPNQsBrRlMBEu03lGAyYMBH00sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by MW2PR12MB4665.namprd12.prod.outlook.com (2603:10b6:302:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Fri, 29 Jul
 2022 04:11:37 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::8c7e:4e8e:3225:34c2]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::8c7e:4e8e:3225:34c2%12]) with mapi id 15.20.5458.025; Fri, 29 Jul
 2022 04:11:37 +0000
Message-ID: <fbe773df-7a92-df52-740e-41bb2f47c1f7@nvidia.com>
Date:   Fri, 29 Jul 2022 09:41:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add sample format conversion
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1658931983-31647-1-git-send-email-spujar@nvidia.com>
 <1658931983-31647-2-git-send-email-spujar@nvidia.com>
 <c801afa4-a40d-9363-1ebd-9e8e30c21df5@linaro.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <c801afa4-a40d-9363-1ebd-9e8e30c21df5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7afa29e5-b993-4acb-ae87-08da71186e6c
X-MS-TrafficTypeDiagnostic: MW2PR12MB4665:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYqZBdDvizb/rARVmunfQnQZQ+H6KWHqW83ZYk3mzJ0ASUMLQiE+j1cuh4yBIph6P6lcPAn007w+49ASuBJe/uxHXePWOC3ND93C8fJIR3QUAZgvyh0/vmYRfHi9LxYqiPfyIF/kQIRmJYFRWxw6aE9gB+P1xpwIKhVV1bHUOgSE+z7khTIJ0ju9wuqe+2bGuKhjshfSfxLlDKD8ULr6OGVgyCJpWrTTp1Q4+lsWjorNJ4cZq3foMI1w5+0zjmgLTbeJrXdHjFobUUNl1895AlzcAxfxbidfxFIC9hdWGo7eSiTUQjz2Rksoykx6PqzvOCuL5+MwE7u0mUv1jR2ks1e7O43NifZWu+Gy/9hWdRRzFh1/TmxwZumgdcT26SvpLI/fPs2gbDmRnmygbxbzi3lAP0mLRPhSAJhaeE/Eef6MGLkcr9XD5X0mAGOHyIGO80qVA6Off+YUT2LdZd3qHuW5GI4oUEdkqvmREBjwJTVVaNIpp51KZkKooXq1zl0Gupx3+XM37TqFBkId8MDgqEb+vwDhOxFONmmzE90Q8RlaHYZIktdo01Hs/mc9ldTTJizdm0gM2vmb+WYH/ljyWalScb5JPb0UnEa/a3KQQc/rNNLpUnYZVasVOta6sIoL7nNMWdsQz+w3TMOj+Fji+cf0EnO82jjIt5vxwnPbVs/Phh07zC9NfaXfkadFTaKs3LAyVaDJa52G+xj0pZe6k6i78lvo+W8kM4AQYVxwvBaWUIMcE6fVTGTamZt1+LuwRfl5aqZKXiSwW1kogAHmFW3Pq+k7TtN4+0o6WomIHs+WLAwsi3EMxywip17I9sbu9ES59xqXmvJOiWHfQRz2dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(186003)(31686004)(66946007)(26005)(86362001)(2906002)(6666004)(6512007)(66556008)(53546011)(8676002)(41300700001)(4326008)(66476007)(31696002)(316002)(6506007)(36756003)(38100700002)(8936002)(2616005)(478600001)(6486002)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXAwMUltQ2N4dUgrbXc2SWNNa3RqQ2RocHNCOE1WWGZpZ3JJMURBM201NlpH?=
 =?utf-8?B?ZWhoL1lNUmMweTNLSzNXT1VlQmRxNUtBL1g5T2pEeWVxQ2Uwa3lsSW9EYnVE?=
 =?utf-8?B?ZHJUdVVjTTZHM0dpY2Fka1pPUmcxTHBDRWh0OThjRmxPaGZDa0dUWjQ0SUFS?=
 =?utf-8?B?YjB6ZVUxMzBwSUE4Z0ZUcWIxN3U2cUt2eGMrVFduNE1VYzMyYVl4cUJGUldn?=
 =?utf-8?B?L0l5V2g5SjRwSnlNMUFjL2ZWYTZuTGp6OFlxTW83WE0rLzZRWElYWFYzMnZG?=
 =?utf-8?B?eHJ5SUlvMGxwZEh6RFcya0hnRXBYSTF3MTVGOS80bStEMHYrS3o1eUJyMHhK?=
 =?utf-8?B?alN3aGQ5ZzlBeG5UWENYMDVKMk1ZNTAvdmhhdEVXTkRscGZpOVhTR1YwWFVz?=
 =?utf-8?B?TzFBWlZoZ0h2VTl1eHdwbVFIcXVKcVRIQWNLamFYK2hmejgyRWExRWFQSU5a?=
 =?utf-8?B?MVZVeUNpcHQ4SElTRm5RTVAvQXJBNXU2OUxxSjl6Y0poSTd2VklYYzV4Ykk3?=
 =?utf-8?B?RUtsTitpWWw3WmlNTHowR29LeHg0NzNna2FON29DeCtyYXlyOVY5Q2NlZXVx?=
 =?utf-8?B?RXd3aXdZNkVTekttNENBS3JrTzhJeXZRL3hhT01MMTlVZHhUcEJ2QitHUUVW?=
 =?utf-8?B?eStWU1J4K0pxNEhSeVkzSDBRNExDTTkxMVI5WjIzOVVyVXZrMTRCRVowdXFt?=
 =?utf-8?B?Y3JJWHhCTDBYU24za2kwSktWVS9vSDZmYjFRZVBSd0lmdi9pQXVVVk0zOGVq?=
 =?utf-8?B?RFQrQ0M0SW5IbzlydEhpYVpMQk00dGxYTDF5aGIyNEVYNVRCUUh2TXUrbjJu?=
 =?utf-8?B?T0tSbDcyWXRjMERUWFhwUmFRYW4wL3lXVlJnTVpQczZxZHZGaHc4R1dMenhM?=
 =?utf-8?B?TUtnTXNsU2NMaTJOa2JHSjhySzdPLzNzd0hkSCsyTXBvNzNCZG1YeVdSNHQ4?=
 =?utf-8?B?MVl3bUF3UURvanM1RE1kZnZleWw5R1crcWZMaGU5ZDE5Zkc3bmpBaG5qSmJw?=
 =?utf-8?B?c0dMV0Yrd2VMaFdueU10QVMwczkyclZoaGhuQnZBejVhTnFtMXNvSkk4Unhu?=
 =?utf-8?B?MHEvdHlscjVSYzVtYU5wRmUyQldGc1dydGZvRUJUcDZCaHA4UGhzcGlqTnlW?=
 =?utf-8?B?bGE5TnNXVGVZN3k0T3ZOSWhjeTBwQUczbG80UTBLQTJGSCtBNjZCSTd2WHlt?=
 =?utf-8?B?a1dxaEFkUkFRSDNNbUlhQ2I3WEdjQVpZZVpsVkFrNnczdjFZcGdseXFJZ2NY?=
 =?utf-8?B?dmRpS3haVkp2dDl2b2dGQ3poYkJVMlBTL1B5M1NEYWZDbTFlNERSSENmRDRG?=
 =?utf-8?B?L0lYc0d6RkpTT3FSUjB1aUViN1VNVEtsWTBxNlRWZm9JTDhXMXlmQ1F1VlZK?=
 =?utf-8?B?NU9sQ3ZOd1NESE0zYWNLK1VkZ3ZKbitCdXltYlZyci9pSEpLR3E1aTR6UnpU?=
 =?utf-8?B?ZlZndkdYZTJrMXZtR2ZUTmR1OXloSnJVNG5vYzlsbEdoOVFsMGhkaVFQTW9w?=
 =?utf-8?B?K0ZSYUpPTVJMWHpZdENMd1o2Y0tMbkNQbVJSUW1ScUsrYnVXbFdKSFF3TlB5?=
 =?utf-8?B?dERiQ0hDcnRKVzV2V2RkYmJwMXZpcnBJQXFyL2cybjhGYUIyejNRRDBabVpE?=
 =?utf-8?B?bWY4Mm52aWhWUjg4TkdmMC9Hd1QxTmp3dk9rOUJRVVpIY1lHRkRvSDVoZlVn?=
 =?utf-8?B?ajI1RHFMT0xiUG5tWjdtV25KdWtkKzFnVzQ3dVZNalRUSzk0WE9KTmVNSUFr?=
 =?utf-8?B?UmdZT3Zia096d0RwNXJnWjg5YjZucnJKdEhwbE92dUtYSktGdEY2K1YxWURp?=
 =?utf-8?B?UzIyYUNrblcxb25HSWp4bkt2TjlYSy9hbjF4SjBWRTU3TFZ6V2pKdTZkK3c1?=
 =?utf-8?B?SnZKYU1VTFJlWVRtekhTYy92ZmRIV3poS1hvdEdFdmFvTFB2MTVwS2EvdW5X?=
 =?utf-8?B?c3lmaDNHTnZCMytVTndrQVBZa2Zlc3Y1cmYvaHlWTHdTWHpYeFhmSjRZQkJV?=
 =?utf-8?B?c0xMTkQ5QW9mVXhHNmVMS0xjcXU1amI1S2xyL1JKYk9TUWZCZDF2TVRIWXQ0?=
 =?utf-8?B?NHE5YlBsQVljSTdGVldhbitobnpXcmlFQnNvVFVBNmRiZmZvOTkyMTBlNVFw?=
 =?utf-8?Q?B8EEKRBRwnJa13yFD0Q9/odhD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afa29e5-b993-4acb-ae87-08da71186e6c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 04:11:37.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8RU93CptN6kDZ60/V/PkBx8MejnObJ/jCwIbi7MNdxOtqOZ5lG/Vg6rvo+KfMk3NvvT1nPzu58O4n3m97ar5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-07-2022 17:52, Krzysztof Kozlowski wrote:
> On 27/07/2022 16:26, Sameer Pujar wrote:
>> Presently "convert-channels" and "convert-rate" DT bindings are available
>> for channel and rate fixups respectively.
>>
>> Similarly add "convert-sample-format" binding to fixup DAI sample format
>> as well. This is added to simple-card and audio-graph based sound cards.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>   .../devicetree/bindings/sound/audio-graph-port.yaml | 21 +++++++++++++++++++++
>>   .../devicetree/bindings/sound/audio-graph.yaml      | 11 +++++++++++
>>   .../devicetree/bindings/sound/simple-card.yaml      | 15 +++++++++++++++
>>   3 files changed, 47 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
>> index 5c36867..d7491038 100644
>> --- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
>> +++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
>> @@ -24,6 +24,17 @@ properties:
>>     convert-channels:
>>       description: CPU to Codec rate channels.
>>       $ref: /schemas/types.yaml#/definitions/uint32
> Missing blank line.

will fix.

>
>> +  convert-sample-format:
>> +    description: CPU to Codec sample format.
>> +      Value    Format
>> +        0        S8
>> +        2        S16_LE
>> +        6        S24_LE
>> +        10       S32_LE
>> +        32       S24_3LE
> Why some random set of integers? Just use string, must more descriptive
> and you do not embed programming model to DT... unless there is some
> reason for this approach?

I referenced it from similar usage in fsl,easrc.yaml for binding 
"fsl,asrc-format" and driver can directly use it. However agree with 
above and let me use strings here.


[...]


> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index b261d49..6decd73 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -77,6 +77,17 @@ definitions:
>       description: CPU to Codec rate channels.
>       $ref: /schemas/types.yaml#/definitions/uint32
>
> +  convert-sample-format:
> +    description: CPU to Codec sample format.
> +      Value    Format
> +        0        S8
> +        2        S16_LE
> +        6        S24_LE
> +        10       S32_LE
> +        32       S24_3LE
> +    $ref: /schemas/types.yaml#/definitions/uint32
> Wait, you now put the same property in four different places. Don't you
> have something which could be shared?
>
There is no shared schema between simple-card.yaml and others. I will 
have to create a new doc to share these definitions.

