Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF350A85E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391536AbiDUSu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386752AbiDUSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:50:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B654BFFB;
        Thu, 21 Apr 2022 11:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTXvSkyCW3x1fa0N6sM9v7LPakuPus20AcDsp0OB0FdbG3282XwdqR2HTKJdMAh9ifRo7gBWdWYQwXty/nI7bdEOp+lPlS6TIaeSEWAjc25G09pbrcVdRiZrsY2PfqgXsV07rrA0kOLwCAlpjZstjnUD6NWh4zlA6nubvuvsvTsBdXysR/7NR4KcPJf+Gj0G2feQB/fsXJcZjgIZ/RhpmE2zrH6krqiA+BHXHNa0TAo+q7X2Z/Dem9ZBt6pnAB2prSP+Mx85hpyyzQ5m4vFUNB/k52YPl/ldzjRjTujoH159xNboj70/+lGOyxsMtx2c2bZpwC8y/ttH6ca1sLSKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gAwYzDyAvrQa23DCbtWgWi6G2tnYjH2z6AefSb6txw=;
 b=GbsHf4CMsv2VcuOqJqRVoQkIuxANi3pSFLaEEAYCp47gLWoSoKIvQed45YKoyITPBdKSh8fEJSkSlpDCljL6tkHydyHekxSsRpY92o57JLlgzJarpCmdlNBxYYy6yiG+yQ2dK2eJQcfImN38URCCEDACdVRbU7+4oKFV8E8fWSJbn6EG/W+y9jCScOK1O2cHeR4+enIQR9j457SyHBRiigGd/M16UV/Y1/RKiFA+zg1wKZUee5FyVjig6hkdSLev6RknDhgQOjDpLNrVcnMfPIuZy2ZbGjx/PT69/kEUTedx/Mu4HxrHUobA3tWkKzDCzsivO/3KQiq9mNqaKsgb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gAwYzDyAvrQa23DCbtWgWi6G2tnYjH2z6AefSb6txw=;
 b=JUk9wiT0nRfizC8PJHa6TN71KgWBb3gyMNDt0t4wxVp23RXPHxC8Tq4l8yx3mofJpN+DjGEgm186EdP+Ku1SdTvBPFyv0W2RM3wZc+xTsSuGr5IuujvRtNCvfQSADHAhYyctSHhDpJZrsNDgxmurHIkgLfEBTva16h8wThiOev3m8koAV3pwthzHHqdzgvEbYmEL49tkMC4ZOLNg0r5fr1sb2uyleGjiZg8bYYj3LiMttKa34drl/Vat98VFYqWfJRkPO3yA4ZNjyPpFqPMTAl1s/aiSLLPwErc6qkWXA45anoCaeCMzFdbCHGwcq+MlYAh2oK9pLItLlcvfpTxsYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM0PR03MB5649.eurprd03.prod.outlook.com (2603:10a6:208:170::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 18:48:02 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 18:48:02 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 4/8] dt-bindings: nvmem: sfp: Add compatible binding for
 TA 2.1 SFPs
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-5-sean.anderson@seco.com>
 <816dad4a1fd6869d89fc143030dd4ff9@walle.cc>
Message-ID: <e05b5a9f-2049-73be-e9cc-9640eb014e01@seco.com>
Date:   Thu, 21 Apr 2022 14:47:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <816dad4a1fd6869d89fc143030dd4ff9@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:208:32e::7) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f65d9a66-a550-44a8-b03c-08da23c776da
X-MS-TrafficTypeDiagnostic: AM0PR03MB5649:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB56493A7D1887E47F26BB52DE96F49@AM0PR03MB5649.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JkRlGS6OidFIWFNERm7VM8kwfDm6KWErQpFNPAnBTOG/YJnez1rX/QUiUFOlYYAB5+EFrhIL4pDHjsTwaEkfx09oWsmHTPWjyhDfd2zNRcixvNvBHpYfaTbHrTy4bKSGz/MOgkObBWg1xB9akWZDxJKFVET66o9kj+rXWw5LJPnIIQf8wMIof2MbK65otttst0n4Bwu3/nNDvmcAulqBANJqYUtkCgYHW2v7C8nTSOf4JwPIr9PlH60OPJ/vsjvHilbtoHWcnFNkm+ejBNEW07OEi8h5aMxm4/HCpeEugdCiCz8ru+pVXbl1Dpvx62fl9KMe+Os628hWpz9MJq1HT3OoC0/g88C4oNjbRK/IDo4fwDD/P8Tz70dYOPqVWT1RxgFL/YRpqU4HLd/qJb346qwvoWiSE4cP3Oqla1cuFEezFG2NR11mHjYvqUINDoXq6qi1ahkGa6TZOKuDho9cq5IYgiTuGlPwxEZoHqhlErnUGNjR3jRRiC2F1wgFjQrfqc9ZMdBfIHADr5Me6M67inBhFnLvGD+Zbss6PAMMdFljGeqhAja2tTK7RovRZnUZdG0O2X0qrnpM0vZELTFg4eNC3WynqMu6OIXrbleZUs2SxfCb+rcDy1U7e+5NNIDwOzuo63XrnE0aH4JBDwT6Xx3a419Bn3IM0vErChzNlV8BDYiTtO7SrOwqD9ns2f4BrtKzwAGvdw2ajmOn6pw60U0PrX6jc15io6hHgR+i29xVehYpUQeU8sxTN7qOhP01Dv2FBgnE+rBr957i4EPbQsZri5Zx5OXUAQunamumoCW07s1eaCaDYG6zOz06XLvc8Fn0qrWZyFGA2MKSOAjI2LNhBMmwBSCDixF7LZxUKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(38100700002)(38350700002)(6486002)(508600001)(86362001)(31696002)(6916009)(54906003)(316002)(8676002)(44832011)(186003)(4326008)(53546011)(8936002)(83380400001)(36756003)(66556008)(26005)(31686004)(52116002)(6512007)(66946007)(2906002)(6506007)(5660300002)(66476007)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUhNUmY4b09MR3BaS21nVlFRc3A3RVN2K0tMVC81bng5QmZVNmlZQkJQWEJo?=
 =?utf-8?B?enVzcks1d2VQUDR4dUNJUkZqK0Z2Vkt3bnRwVzNNTFJTcUF4OHhhVnhjL1h5?=
 =?utf-8?B?WjNEL0F3QjB6TDRLOUsydXprM1ZHUTJFWkpLZUNoRkZRYlZNeTM3L2dHYkVY?=
 =?utf-8?B?NVhJL1NDY1hvVHZLTVBGenRHL0djQ2pnWEZkS1V3MlN5VURWVzk4cnc0bTNN?=
 =?utf-8?B?OVJiM3RtVXgzRzZrKzRKbjFEVTJWVzRqMm5aek03VS9yb2hsTUhRdWwxRysy?=
 =?utf-8?B?ODNnaHlyQkNDWXZOMlFxdXo1YzRzOTR2bnJVUk9zaWw5VWxBUnNKVUVLdEtJ?=
 =?utf-8?B?cWdPVkNNSElWbDdmRXV0MVRSOXcxRjIva2xUL001eTdXajNKS1ViRU1VdXVV?=
 =?utf-8?B?azNGbVFCZHZEV1dNNEk3VHBBOWFsSE5PT3VRcjgyR3NNL3M0NFNReDN4dmw2?=
 =?utf-8?B?bnJ4TC9XWWhlbVBkMWZvMmFmUWRrNHBYZjRnYVBLNWRsVmxXYWNEcWsvSjlz?=
 =?utf-8?B?UlR0OWNkb21mUEdobjFZY2RxNm9ucG1acndEQ3F5L3V4SWNsNkVzQUx0SzhG?=
 =?utf-8?B?VTJVZjRHQlk0OTZYYXd3UWJ2U0g2ZDlLQ2EycEVJcDkxcnIrQXlud3RYcjFI?=
 =?utf-8?B?MzhnWFpIb1VTcDVKNWNqUUNqU0c0NGlWWFJvd3FhOG5XVmZ0VUhzaU1qZW9K?=
 =?utf-8?B?T1RKblYrcU5xRXpFdmV4UGVlcEdxQ3EvczM4MEJqZDltcTE1alRKek9IYS9r?=
 =?utf-8?B?eUVBZXQ0cnJXQWxiZUdCaGdidVRLRjFnYTlIa2xNeEJuRFBtTkN5TlNzZ1BE?=
 =?utf-8?B?SFd1TXRMdTY5b1pJWnFURVBqSkdEQlovVHphUE8zdkw4S0trdEtBMUc3Y0J4?=
 =?utf-8?B?KzhYcm5PZE5rY3UxWmtQZ1ZicXR5VU8rdWxoNjhzck5BVmRlUTdwVEJZUFZj?=
 =?utf-8?B?UWdwd0ROMGFiMWk2QUpWZEw3eWNtOTdCQVNUa2NuUGowR0NpSm5SVWNUY1Rl?=
 =?utf-8?B?WDI2RndqWlZTMzVhK3ZaaEFGdmg1QXdjMXVrSENCMklRc2gzVXFqNFBUNy9X?=
 =?utf-8?B?K1dBMlYzbm1jN0gvdy9zZm9mSVhjZEtCVVpuR2hhYTJ1bWNLTTdET0ZqbUtm?=
 =?utf-8?B?ZTI1UzlqVjNqWmJvckNMQVkyeTFaZFNCYjhuM24xdkJGZUdJMTVtU01FZVAx?=
 =?utf-8?B?K1dpcVhtYXBNZllMM0JoM2htUmhqT1dLM2YrOFVEL2NQRTFpWGVGVmxQMDdZ?=
 =?utf-8?B?ekNJcmV3eEk0cno3dXpNRVlDT241cmx5SFQ3TERMZDRWZStrYldVTWhkVUp4?=
 =?utf-8?B?Mis1Z0dEbVYyUnZoYko5dFNNUlNxaEVyY0tYVHE0MTNSbmdOMDQrbXpTeC94?=
 =?utf-8?B?akdTcXd3UXMwYXdZd1NveXhJVmZ3dkRwb3JwaVJkWkNMMkhyc3YraWRFRk5J?=
 =?utf-8?B?anUvbXhEakJod05MTW55S2J4TTB5Wk9ZREhiNGduS2d2cW1RUXVmeVZLWExF?=
 =?utf-8?B?Y3F5ZXgzdlVuMlBDVEtreVplVXZoUVFIRVZJMHZKaTh4T3gvREpqakMxUUV2?=
 =?utf-8?B?UHdtcklGTlhHRE53Y0NwVW41cS80Y1MwcTNuUjlMVkVhd2JvdkpQKzI3TU81?=
 =?utf-8?B?cGxocTdBdS9LL0tJTzVZa3JqMkg5cVJvSFBkdHJGR0JuaGpUdEdJYTZwb0F4?=
 =?utf-8?B?ejcwSllORlhNWEo5VitjVEoycFZxZTQxcHdTcC9pWkJsa3pFWkpyOFZ2T0tz?=
 =?utf-8?B?WUFJN09zZUlHQ2d3enJqd0JLK1FNTzQ1MkNkQUJlVHBUM1RCRFBMVy9kZm13?=
 =?utf-8?B?Z0xta3hvZFJvTElPRHRVWVhCNFZkazZlaUdYbnZXSXh5SjgwZlNrOC9vSzlN?=
 =?utf-8?B?R0IxTXRsOEZvWnBsbmttQ01oZU5oTHV0RHNhcE9BSXhSZzYvdkpNZ1FBNTRm?=
 =?utf-8?B?eG9jNnlwR2RiVENNQS9iUmN1YktuVzRIaVdqT3dCWHk4U0xYWmVTRDJJRFNZ?=
 =?utf-8?B?S01wcXhJa1M0TmVsWG9DQlNlYmIxWnNrZld5WkY3dTJDa2pHZGV0WWpXVTM2?=
 =?utf-8?B?VjNWMFV1NjVrMEJVQU1hSUNjQmE2RmJ5RDJKYVNLMmhFcjFOZ3hvSGtIUmgz?=
 =?utf-8?B?TXNSK29SSWRRblViYUlsazNuSFo2b3R4d0U1emRBdkh1Ym1jZUhueE9VdjRQ?=
 =?utf-8?B?RnI1dk14TGtLNjJFcE5SUWpXQ0VYTTRTRDBPWjYvNy8rTUQvMFBjRUNxZWov?=
 =?utf-8?B?REw1ZW56c2ljSTZ4NjE2ek0yQ3BSRHdGRktUVWdBZCtrbER6a01wbzc4Ung3?=
 =?utf-8?B?WUxzaTJaZHZ3R0tITTl2Vk4xSFRNZzAzS0V2VjFrTU52OUpYL0gwQklqSFo3?=
 =?utf-8?Q?dMFD524tAVB8FxGI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65d9a66-a550-44a8-b03c-08da23c776da
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 18:48:02.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7KBKV403oLFm9BGVfkpMqp4YWu0R4yIHJY+vJCTlZmvrVV388Ik02n8iJPK72PUWJKkRPi8wV2pJGCUvSr2+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5649
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 2:18 PM, Michael Walle wrote:
> Am 2022-04-21 19:56, schrieb Sean Anderson:
>> Trust Architecture (TA) 2.1 devices include the LS1012A, LS1021A,
>> LS1043A, and LS1046A. The SFP device on TA 2.1 devices is very similar
>> to the SFP on TA 3.0 devices. The primary difference is a few fields in
>> the control register. Add a compatible string.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>>
>>  .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml    | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> index e7d1232fcd41..aa277f1eee7e 100644
>> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> @@ -18,8 +18,13 @@ allOf:
>>
>>  properties:
>>    compatible:
>> -    enum:
>> -      - fsl,ls1028a-sfp
>> +    oneOf:
>> +      - description: Trust architecture 2.1 SFP
>> +        items:
>> +          - const: fsl,ls1021a-sfp
>> +      - description: Trust architecture 3.0 SFP
>> +        items:
>> +          - const: fsl,ls1028a-sfp
> 
> I'm unsure about this one. Esp. if you reuse the fsl,ls1028a-sfp
> compatible on other SoCs, there were some endianess issues with
> other IP blocks on the ls1028a. So it might be that on the LS1028A
> the IP has to accessed in little endian order and for other devices
> in big endian. I think we should add one compatible per SoC unless
> we know better.

It looks like I overlooked this. As you pointed out, there is indeed an
endianness difference between TA 2.1 and 3.0 platforms (see e.g. [1]).
Patch 8/8 will need to be updated. I think the easiest way to support
this may be to convert the driver to regmap and set the endiannes in the
config based on the compatible. We could also use the little-endian/
big-endian properties.

--Sean

[1] https://docs.nxp.com/bundle/GUID-487B2E69-BB19-42CB-AC38-7EF18C0FE3AE/page/GUID-EFF8FF41-C8C0-4A3B-AF95-E801D585B7C6.html
