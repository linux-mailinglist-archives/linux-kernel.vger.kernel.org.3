Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4280D5A9FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiIAT3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiIAT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:29:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27220DEC;
        Thu,  1 Sep 2022 12:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1PjO600cUheQF3QC4hG5nBfoPZyRm34eHAQwvTYa36ycRJWoQOpGWyMuF0zfn7Ze192hRRqsu3pkUiOizLwDyUybTkaizFpd4rtqCLIy1eoKtPID2uWnqxnp70Kq/+Lmp+LgZd/VPIXkPCqDAdnUFxtct9hGBUGAZAmGYjew+FidkmRe+wfny/T/ikllf/67HNOHqApgD760LJtb5g7NBNamxYr0MF99BXHpor/pZEvQh5JF6tVu9UCMwiF5iPh2GfmjEL/gBqEJw1vJ8sl+b9lFYNo+xoeQYGo+DaggkpDtod8lDbXnKM0ntTlcnOHMZFPmF3KoxAoto4TQYZj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3mIIOWZO/1WVAzPCJOoTHWtERZC6AAw9efWhDrNJZc=;
 b=Ai2QttdcjbMOI8E70TuJY0aQIaVugxBWNl1yNmTFAtQ6TGfgqdwOKtBj5xcA016oSTIdD33mOF53jarlgWSJUzAjmyLktkayoLVqRY6ebe0GKfTuO9ml80+94KJeHVpnVNzaF2Vr5xWPhs9p+Sv5Wm7IIr3jSUT8WMbRosBBncVdqwpTX7KtvgDM6PjwIS96TsWuvJ2DwkBp2XH0t3ltczZ82dOgLhPezh7C8swKtK19a6G+8kIpixrb0h9d+B/LHTQIUQXFZtx/N12SFLKSUjAWOjN0hb+fpmFu20EkA/+K+LOw0oED8BjVWchnjhRf+/iEdIMt5vZd+Mayh+ZoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3mIIOWZO/1WVAzPCJOoTHWtERZC6AAw9efWhDrNJZc=;
 b=a9nzfSFULTFmUM2vsU9kXjd9/uOsb0JW42I7VNli3WTYNVGq9eBgXmzt/h2Ea/i4n/wZn4KUMpVhkf06leDmlkHT+LZAYH+F7HglZ+6a1Ppbxo/Igw6j3jhF3q241wfpQfusEcqfKlDo1ZIMuJnsgeV3kDfOGxm49xSJdqQXMsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 19:29:41 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988%6]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 19:29:41 +0000
Message-ID: <c2846d44-bc15-f77e-f57f-3ff5b92fd65b@amd.com>
Date:   Thu, 1 Sep 2022 12:29:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v9 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, tanmay.shah@xilinx.com,
        michal.simek@amd.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-2-tanmay.shah@amd.com> <20220901173817.GA626605@p14s>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20220901173817.GA626605@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:a03:167::23) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fedd93a4-f497-4ca7-366b-08da8c5050c6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5H1gthgALCbBxRwqPmSk9bZJ6DEYF5jiy6f8UK1fWMQ069E1c2qYvuhtmoaXiQkrRX7V2FxvHnUn49IgaGb5P6RSn5HT9I70Bzr4HauEnq+e6GVrojGUSEcZENCTFwe6hNS21isW4xnWJtkFb1xu5pu8KrWjJA0YURoMeZZHBrbHnVFygmjYJB1Ab/B3EOuXrjKzbj4OFOzCltWAIYTCB2HB/j07AZQVlrt3jgAptYqla/nCSQ9dOE2RU0VHSQV6TmkHl9fg06jXwVgnPGMAm2sXwIX/nTCqLQq3cC2nPkdmOV+BBM6fa8ahlZDwCfhSHQHWf2B8BUTonuq5HhPZtUKqaOCfQeJVZhSaZxhLyMJZwg3IZ73eCCSPgTVef/R2MW71CSrCEa4AqjX8UBZxJhJdQHFMRDqr7gpwM5GJzqMQ9NdSYa1zH4LbjK42Hk/AT6KlS/AShLPJw4YKQLA4J7+lCvF7sd37yIkzwD9WkWAgzRK7m8QawstAIWxIkbPCeOiFkf9BlUisDdwQjRCwD9iHxlQRcbhEAqlDdaPFMwxPFQ9UZx6tu1vcYVeNj6KrP1GLumd7Gs2avBggZAQadsBOaXzU5bbZ9vqlLyu8WB+GVgghP2tZUofcOhf7leLirZ2iT9FfaSueGt7tjwYm60+rxfKYOmZVZ+Pcq+UbZpsY3COdu7y9G7uJLMcAhR7rqSjd4gWvn7WYzGfYkCNTKG8ARtosWD0c26rSbeFN71zcRmLJOGmh9bmr6E3TGF0nmiWfm35sAE1oJd4sDr7YOnqtNjMiMHUd+gMXULSIu/C2R0eJk9PwrNwLjQ70E08k0O37GR5GhbAzuTLtgLItn7AjP2g/p8S7mZv95CkT3phGfIHQK3uGerkIkM7Zmm8d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(41300700001)(66946007)(8676002)(66476007)(4326008)(66556008)(478600001)(53546011)(26005)(6512007)(2906002)(31696002)(5660300002)(6666004)(6506007)(38100700002)(186003)(2616005)(83380400001)(36756003)(966005)(110136005)(6486002)(316002)(6636002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTQ5VXJVVmRiSHVNV2ptY1UwUW00djZIWHlBK1BleVpBa09jeENiazQ1N3Yw?=
 =?utf-8?B?ZnR5ZE9jbjlETlV6SFRDbGVBZ3lva2pLczJNVHNCOVp6QzkwdXFlMndvZ3Rz?=
 =?utf-8?B?bk95dUVzVkhQVWc1ekZuTHVQdm94ZmNKVHNBSWJENGlXMGdRUWZmeWUzbnBz?=
 =?utf-8?B?NFpLZXhKa1ZmbkExdjNqSGRMQ3JKRS9PNE9meEJlUXVCVkZtR0RzRGthQkdj?=
 =?utf-8?B?eG9IZmNRNlZlQW9Va2U0Sk5IR0xjcWVRQk50aHAzYzVZc0wyaXJqQ1NJT29N?=
 =?utf-8?B?YVRFcU1kbEI1MnVQYlFsR1pYNmZkYnVWMFpjWXV4eFMxSytxUDBzNEg5dERV?=
 =?utf-8?B?N3E3dWFSQ2k3NHczenJ3YytoVVl2dWJIOEdvZGFoN0VpTm1jYjVIVjQ5dFpC?=
 =?utf-8?B?M3EvTE5EaHFpN29sREdLZnJPWWQyVmJGcXBwb2prVWVlT1B2MFNGeVJKZ21F?=
 =?utf-8?B?LyswOU5TS3ZJUVZyNUdSN1IyREZjeHNHZnNFOVBiZW02TGVvcWJ6Q21TbmFr?=
 =?utf-8?B?NElUMzFqdEExTlY5a3ZoYnJMbTJ0VXZ0NU1sQmlUQUlhSE1nMEJpWFg1UjlO?=
 =?utf-8?B?Uml3bmJRamJESUQwT09XZ1plVjFpSGRPNTUySFFkNjBuRWlwaTVKL0dNREZS?=
 =?utf-8?B?OWoyRnZQckovczBiZVpKTHovSEpncUVJb2FackRucm9QSGRIUk1jcUg0UUkw?=
 =?utf-8?B?M0dHN21Na3JvVk4yZlR0N1RscmVyOWROOEdrVFZnZUVCWEEyZXNCTEhhQ1Zs?=
 =?utf-8?B?TzRBRXFSWjkvWUZFSEd6WWZBaFEwaGRobnI3VzNQTi8zandJZnhoM3V6R0Nj?=
 =?utf-8?B?VGFGbTJGNnFCMDM3NkVkOUdKSGFSR0ZjZDNWekFOMFNndFpmTUVIWkdkVnRu?=
 =?utf-8?B?cS90QXVzS2Uva1d6Mk1KdDg3alZURUo2NWxoZnJ0cU1Fd3o4cU1WUkFwejRy?=
 =?utf-8?B?c2JYU2E2Zy9rWkJuZTZsZkwvSnpXbkZNVXpiM2s0MlJkb2RWUlNUdXVkR3Fq?=
 =?utf-8?B?dDNpN01IYTg0UURETjloU1hWcURNVkk2R3ZMRmtGeHVpTVlkcU82NFJ3U284?=
 =?utf-8?B?bmIvZHFtU0x5R2FnT1kyakZ5RXZiV0IybGNoL3JRTjRIczJtV2ZjcFRxRXBQ?=
 =?utf-8?B?NmgzalAwSXJxNjQyNXQ0Y2NvNG9GVWQ0MzZBK3ViajdsRDFIWFpMRXNDVmZR?=
 =?utf-8?B?SFRRbExqdGUrMnVJbkhqcUllQStRQ1IyYTdZZEI5Q2xpd21NUUFsWW84RU1q?=
 =?utf-8?B?dFE1YXE3SVcrbjl4VWN5WHo1MHA3LzN3VEQ2UC9xN2xjQTcycTBQTU9temM0?=
 =?utf-8?B?YkpYN3VTbHY1WDBqbVBWTmJwamJZcHlsNlVPSjBrMzY3VUhWWkVIQm1zYTJQ?=
 =?utf-8?B?SWNwcWJIL3c3bVVTakJRNVNXS1p2ejlTdDlsYnNybGJzU1M1YmIzT0hiMFhT?=
 =?utf-8?B?M0dMSFNUbzdGTWsvV2ljdmgzNTA3N3Z5bmNBNWNKSmN5c0VwQkp0ajl3QmpB?=
 =?utf-8?B?eGhEaldxWEpya3lQR2xnMkU2MG0ybmo5K2hGTkNGNlA0NFZrQUtISWZrbW5C?=
 =?utf-8?B?SlNXVWs3d3VKSFZhbW5zaW1RM2lBcGRiL2FaSW5sbWh0ZDlyb0VZN3Q3MmlH?=
 =?utf-8?B?VUFEQmw4TTJ3MVE1YTc3dFFid20ybHVtUmZGaitvV2k1dGhOZFNDVGxacVFa?=
 =?utf-8?B?OEdscWFxSU1CSS80MG5Ya1hxNUVsdFNUc2F5L2NDSDV0RVN1aGI2NWpyRklw?=
 =?utf-8?B?QlV0a28yaFFpeVpYeENHNDVPbFQweHZ0Y1V0WEtsRzNaT0hCOW9BOGRCK0dD?=
 =?utf-8?B?d21tL21MUFdEYnUvYkxpSGpBNlNteUhVanhnYU9RejJVSi9za083TXZCcnlz?=
 =?utf-8?B?aHlYc0l0SW5NK3ppL3BtM0V4eGNMUHBFWjdSNExKVXZuOTl5SWlPcmo1R25t?=
 =?utf-8?B?Zno1K05FK0JLRjhTRndVVHhUU3p4TUNwYWV5TVNmSysrSGp1ZUd6aHYzNHNs?=
 =?utf-8?B?UkZ5alpZZVczbDlJOGd4MmZIbHBTU3BVVXoyUUhXcHBmV0w4VlQ0T3RTZ3ZM?=
 =?utf-8?B?bmdKWCt2eXUwbDVZNE5rdWJoeER5MzdOMktqd1RtcTJ2NFhmRWFiUlpJY3pu?=
 =?utf-8?Q?jtS0Cd87cO/rNbJdDRwFp2UYM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedd93a4-f497-4ca7-366b-08da8c5050c6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 19:29:40.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yOIO3WqDjgigcc6k40c74fg1s6Iv2QuIfCh4168oDKz7jH2LX0xahs+pE2Dzv/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/22 10:38 AM, Mathieu Poirier wrote:
> Hi Tanmay,
>
> I have started reviewing this set.  As usual I will notify you when I am done.

Sure Mathieu !! Thanks.

>
> On Thu, Jul 07, 2022 at 06:39:50PM -0700, Tanmay Shah wrote:
>> From: Tanmay Shah <tanmay.shah@xilinx.com>
>>
>> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
>> (cluster).
>>
>> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> Any reason for keeping the your Xilinx address in the "From" field?  When
> applying your patch I get:

Originally authored using Xilinx email ID, and switched to AMD email ID 
in between.

I will fix with AMD email ID only in next revision.

>
> Author: Tanmay Shah <tanmay.shah@xilinx.com>
> Date:   Thu Jul 7 18:39:50 2022 -0700
>
>      dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
>
>      Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>      Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
>      (cluster).
>
>      Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>      Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>
> Which is cumbersome.  It would be much easier if it was:
Ack
>
> Author: Tanmay Shah <tanmay.shah@amd.com>
> Date:   Thu Jul 7 18:39:50 2022 -0700
>
>      dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
>
>      Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>      Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
>      (cluster).
>
>      Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>
>> ---
>>
>> Changes in v9:
>>    - remove power-domains property description
>>    - fix nitpicks in description of other properties
>>
>> Changes in v8:
>>    - Add 'items:' for sram property
>>
>> Changes in v7:
>>    - Add minItems in sram property
>>
>> Changes in v6:
>>    - Add maxItems to sram and memory-region property
>>
>> Changes in v5:
>> - Add constraints of the possible values of xlnx,cluster-mode property
>> - fix description of power-domains property for r5 core
>> - Remove reg, address-cells and size-cells properties as it is not required
>> - Fix description of mboxes property
>> - Add description of each memory-region and remove old .txt binding link
>>    reference in the description
>>
>> Changes in v4:
>>    - Add memory-region, mboxes and mbox-names properties in example
>>
>> Changes in v3:
>>    - None
>>
>>   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 135 ++++++++++++++++++
>>   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>>   2 files changed, 141 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>> new file mode 100644
>> index 000000000000..56b4dd1d5088
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>> @@ -0,0 +1,135 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx R5F processor subsystem
>> +
>> +maintainers:
>> +  - Ben Levinsky <ben.levinsky@xilinx.com>
>> +  - Tanmay Shah <tanmay.shah@xilinx.com>
> Here too...  If you are switching to amd.com, please do so everywhere.
>
> More comments to come.
Ack
>
>> +
>> +description: |
>> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
>> +  real-time processing based on the Cortex-R5F processor core from ARM.
>> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
>> +  floating-point unit that implements the Arm VFPv3 instruction set.
>> +
>> +properties:
>> +  compatible:
>> +    const: xlnx,zynqmp-r5fss
>> +
>> +  xlnx,cluster-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2]
>> +    description: |
>> +      The RPU MPCore can operate in split mode (Dual-processor performance), Safety
>> +      lock-step mode(Both RPU cores execute the same code in lock-step,
>> +      clock-for-clock) or Single CPU mode (RPU core 0 is held in reset while
>> +      core 1 runs normally). The processor does not support dynamic configuration.
>> +      Switching between modes is only permitted immediately after a processor reset.
>> +      If set to  1 then lockstep mode and if 0 then split mode.
>> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
>> +      In summary,
>> +      0: split mode
>> +      1: lockstep mode (default)
>> +      2: single cpu mode
>> +
>> +patternProperties:
>> +  "^r5f-[a-f0-9]+$":
>> +    type: object
>> +    description: |
>> +      The RPU is located in the Low Power Domain of the Processor Subsystem.
>> +      Each processor includes separate L1 instruction and data caches and
>> +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
>> +      memory space is non-cacheable.
>> +
>> +      Each RPU contains one 64KB memory and two 32KB memories that
>> +      are accessed via the TCM A and B port interfaces, for a total of 128KB
>> +      per processor. In lock-step mode, the processor has access to 256KB of
>> +      TCM memory.
>> +
>> +    properties:
>> +      compatible:
>> +        const: xlnx,zynqmp-r5f
>> +
>> +      power-domains:
>> +        maxItems: 1
>> +
>> +      mboxes:
>> +        minItems: 1
>> +        items:
>> +          - description: mailbox channel to send data to RPU
>> +          - description: mailbox channel to receive data from RPU
>> +
>> +      mbox-names:
>> +        minItems: 1
>> +        items:
>> +          - const: tx
>> +          - const: rx
>> +
>> +      sram:
>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>> +        minItems: 1
>> +        maxItems: 8
>> +        items:
>> +          maxItems: 1
>> +        description: |
>> +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
>> +          the RPU can execute instructions and access data from the OCM memory,
>> +          the main DDR memory, and other system memories.
>> +
>> +          The regions should be defined as child nodes of the respective SRAM
>> +          node, and should be defined as per the generic bindings in
>> +          Documentation/devicetree/bindings/sram/sram.yaml
>> +
>> +      memory-region:
>> +        description: |
>> +          List of phandles to the reserved memory regions associated with the
>> +          remoteproc device. This is variable and describes the memories shared with
>> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
>> +          vrings, ...). This reserved memory region will be allocated in DDR memory.
>> +        minItems: 1
>> +        maxItems: 8
>> +        items:
>> +          - description: region used for RPU firmware image section
>> +          - description: vdev buffer
>> +          - description: vring0
>> +          - description: vring1
>> +        additionalItems: true
>> +
>> +    required:
>> +      - compatible
>> +      - power-domains
>> +
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    r5fss: r5fss {
>> +        compatible = "xlnx,zynqmp-r5fss";
>> +        xlnx,cluster-mode = <1>;
>> +
>> +        r5f-0 {
>> +            compatible = "xlnx,zynqmp-r5f";
>> +            power-domains = <&zynqmp_firmware 0x7>;
>> +            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
>> +            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
>> +            mbox-names = "tx", "rx";
>> +        };
>> +
>> +        r5f-1 {
>> +            compatible = "xlnx,zynqmp-r5f";
>> +            power-domains = <&zynqmp_firmware 0x8>;
>> +            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
>> +            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
>> +            mbox-names = "tx", "rx";
>> +        };
>> +    };
>> +...
>> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
>> index 0d9a412fd5e0..618024cbb20d 100644
>> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
>> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
>> @@ -6,6 +6,12 @@
>>   #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>>   #define _DT_BINDINGS_ZYNQMP_POWER_H
>>   
>> +#define		PD_RPU_0	7
>> +#define		PD_RPU_1	8
>> +#define		PD_R5_0_ATCM	15
>> +#define		PD_R5_0_BTCM	16
>> +#define		PD_R5_1_ATCM	17
>> +#define		PD_R5_1_BTCM	18
>>   #define		PD_USB_0	22
>>   #define		PD_USB_1	23
>>   #define		PD_TTC_0	24
>> -- 
>> 2.25.1
>>
