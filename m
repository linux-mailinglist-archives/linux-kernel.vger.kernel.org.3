Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084C05399D9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348589AbiEaWxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347194AbiEaWxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:53:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BC986EB;
        Tue, 31 May 2022 15:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1nWtFnHW9KIMDKO8o9wLpcgowTKaRr9l5LXNMdjEGXQdJ9V8DSnsXizb7W9QNheZH9W/6vqovee2MIZeA9FSA7FeF1kB+NMzGqzlMEcJUyv/hyC8zYO2QghRZpWqF1iFD70j3L//KPyS7/Dp0RQkJJ5rf20r2jDSmUBLDuYNoZbSE75QJvQDWPYn8EdCm+N0cDy+oHZvUkfFlQSp6IU/h5x9tYL6CR1CFTIyinH1wDyS1R2suQpEvj8JoT1/JN6SSSPNGZfw8tQyAxjuMgem1WMb4OIgIcZdDhs3mEk0AEu8gRhb4eEeeSrJolrNiNqbxFP99iMo1FS03SGxETgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnF6BQezhMXlRtsC9XF8WXr4RWi4a9mRLTORWgnbjh4=;
 b=TTQXdf0jNszeCUAsyLLN36Q4nz2B6n5H58WYqLLllrUIEGYfCle7woF1llK2yZ094kjYXasYPqbv4SELZUDT5gZYVlkk6PumG8YowGpycIRoWJSsfUM9l+iAJ3dCsC0pW/bHwqeGhWUL5WpSe4SSn+SqtiyKqD4Frp+wvdrt9QiI/tyBM/CGhefemxykbUBd2HF4ORrgcpiHYy56YX+9IIswTvNm1CqZ/y3c+fcRNBGw9ozLX6XuxROlI/iEn7eZANnHHbR4t0yePRYoTBCfslFtXJbcGV162m/K3BwXpTOW7HoCcfZybkNR2cJZ4qlAIAW0mHVtZF/KQFPdpFpeBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnF6BQezhMXlRtsC9XF8WXr4RWi4a9mRLTORWgnbjh4=;
 b=sKNBId0iQ7o+npSg7CXjpwkraLwvBXCAxJIRJLFF39rTY4TIS/X5NwPKg6eOfSn/x5Id5oR4ZMUr0dGlPtIjzy1qaUugOgjeSSjcp3zqKOfM749Y0K3pARXy/se04OI7qF+H1NC7fmaps/DySlieNSLDE1cIQ1AkaStmaaakmfCCagv0KMcuKj5/11QRIenPSMtw8ikGsBO6JAxUmk4VeNjOPgel1RWhQdjiOvSgNVMpgYwILjmEKnBy3It5LRcPlpbJqJd0+y6d+E1kJic6zMvrI4Uzt65Bx4intD4MNsJDmvWTPHX7512/JpQ4ax1p3rGbCHSL5L0Fro3AtP5tHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 22:53:30 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::6c51:327:2e1f:a04c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::6c51:327:2e1f:a04c%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 22:53:30 +0000
Message-ID: <b7c688b5-9b27-23de-43c6-c151dfb1a1c8@nvidia.com>
Date:   Tue, 31 May 2022 15:53:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: timestamp: Correct id path
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, sfr@canb.auug.org.au
References: <20220523172515.5941-1-dipenp@nvidia.com>
 <CAL_JsqJSF=7FOW4oNydRtDYY8L9Y43E4FsBkUzM+U5ZRjYdt7A@mail.gmail.com>
 <86b11457-2f1a-6b17-fab0-a13d932af993@nvidia.com>
 <20220531214209.GA2350029-robh@kernel.org>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220531214209.GA2350029-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c8f5ef2-d47c-4915-ddc8-08da4358614b
X-MS-TrafficTypeDiagnostic: CY5PR12MB6647:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6647721E294917C2B11EB3F2AEDC9@CY5PR12MB6647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fg0zX7Z4sAVdEtAxpTGCYxhYUFHJdH5Ui1awvDHswlHC/yuDhyFyirXRfvghgv/chd56WjDUlrAH4L6Ug9G6qouASEeykD0yEM5d5a3s4WKq3+CJ5Jnx5cPJNbqRlkddJZMntK7+vSxc2r3T2KU2FZjYvdmoU8w/qX450ppldd5/vk4pPh51Ya+XC7U01yXx2PP5vNVMrW5tBYvJHbKKXImuDgvQgfSG2hPvqbMya92yOTfsK1oe+TMVC3nT5/rB1+oMQ7V2lpOQSYgs/x0XPQoAsE5B/+3tPfDWKtj4iTRz+YQJkbmibDKU35ibwO3U6mmWfCpqX5yKoaSzK8mi7dKbPmKAbYf0hiADBYlv+zi+At4qiikHQnUmfaAb1lFVDJX8g7hwnmZQgjiXHJTAsGJzteQPEchxKAJaylzEvo5AliXLB7XXIaNFmzZiRJq3Tc8emfifh+lo74k/aBt/BX9wBEQIqeXiqNHI5zs0xAyGKgpiWjNlh5NRXl+eSCYqkqiJ0vBpGLMtGN7sLxoIikbFs3GrgJZzunnvMfjYDb9Pk2jAsElXAIiDtIuTnpW8OcPgnsFgN+6qoJb/M/VGz8ea6ev9g2La6O4xCDw/Le78zVrSvfB17SNeT1sRP34IUh4HZxiXbiG8HMbzpComSrHBOMNsecRxsZkjUJqzHZXywaP6XqcBNrRsZIwwVC3VxGFZD+RPYmanIw64OO219UZJxKKmlbyrFcTiBbTWCV7yDdWektvOsG2yLShnfmfNAWEDuzyeVqt5QgfGv2/m8Rha1QLzQlpcGZlsr/6ZnlpuZgVa5eNxSLa775Nln4fZ8g9fIpYMxqNefBXREyebjKb5qmkArZN+v3FLz4Qda3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(86362001)(31696002)(6512007)(186003)(2616005)(54906003)(6486002)(508600001)(53546011)(26005)(6506007)(966005)(6666004)(316002)(2906002)(36756003)(66946007)(5660300002)(8676002)(66556008)(31686004)(66476007)(4326008)(38100700002)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0pHL0RsUGZMRVNjVWFGK1Z5SXBOWVBJQitQYTdHNE5YQk10bVJjdTczN0lW?=
 =?utf-8?B?Q2lYVTMxNVJHM25OU0dxekptTkd5Sm5La2QrcmowWlpuRFVrcmUvbWJuM2dZ?=
 =?utf-8?B?UTFTSGhiRWVJM2kxM1V5SmtPUFZKVnhWMGJHVDQyalZrTjBJdUFjNUNWellE?=
 =?utf-8?B?a2dwNGg3eHJYM09FM2lvdFZOdTlyYm04R1F4dndKUHZOVUQ0bTZPTkxzQm1F?=
 =?utf-8?B?c1B1QlhpT1pUd1RMWVVNNXNMemFTRTRhNkk0UXNDUnFHa3ZydUJKbjZZZU9t?=
 =?utf-8?B?V210YSsyaVE5UEpGa2lSbllPY29zcjVkSk9sTmlNb2dlUnphSnRqS1JVV0Fj?=
 =?utf-8?B?a0xLTG5URnBRKzhqQmpRczZtOUQ3NjR2OVBSTEVGeG5Eak9pWmo3MEdBcnA0?=
 =?utf-8?B?YlB4ajdIbTVtVXZXZXllcXAwQkViVmJrSjRnZlBtZ25xZFFLY0JDbFN6OU5E?=
 =?utf-8?B?djNocm9pS0dsRnkyN3ZTaWc2ZTlZQ2pRcHZwSVVkR2V6bm8vUWdhbjR3elNx?=
 =?utf-8?B?Ri8vT05UNWhobjRxUkdLVGU3OWJ4czNqZ1ZlbjQ1UXorSDNIY2lEMmVsZTdZ?=
 =?utf-8?B?dGJoOUh5SU9iU1ViWXlCWElkZWxjWWpzK1ZvSnFzQURpbHhPYnFONWxaa01G?=
 =?utf-8?B?UVNFbDFDelpVbllrTjlIa1g3MEw1T2NlaDFYbnVHZm94YUx6QlFoUzV6WTNH?=
 =?utf-8?B?SDFtQjBKY1kwQjMzRE5YM0E1aTJPc3VCd2w5dm9kVUFXQkw3cURIbUVvb3Ny?=
 =?utf-8?B?dERRbHR6Mk8rSE0wazJmbzZGM1JTalZkMDhKdkRqeXAwcm1KcVozMmNnVUpj?=
 =?utf-8?B?NFRsRGRuK1RPbVVJNUlNV2dqdDZtZUE0aUlUdDhDKzZYaXh2RlliWXA5VWk5?=
 =?utf-8?B?aUdEazd4dFdvaGxFQjI3NEFiRHJuTmU4aGh2NzZIcnB4VUY4QVhNZ05mWU9z?=
 =?utf-8?B?TmxBR0Y1NVZsS0FSMUZtekdNc1RzUTkyS2QwWm5BMXZoMmdiN2xXeWY4SDdD?=
 =?utf-8?B?UGRQQ285Q3lVSVhhNWc0bVhnaVpSTnNjUVBWd240bmlKd3lEQkNhYWV5elVo?=
 =?utf-8?B?b0FLLzhRU00ycDdERlhid0dEWFExSnMxT2J5ZWxhVnZhR0YwTlFLMmZBUFJJ?=
 =?utf-8?B?ZFg0ckgrVlErdUMxb1lMbVNNTjBES2ZxREFrRy9oeHpFTGY2R0phVHlaUEd6?=
 =?utf-8?B?aUlUUVl1Z3p4MzFBdVRseTFvT2NWTGhMZFFzRFVreSs2aHhUNmlZMFA0N2hU?=
 =?utf-8?B?Z0x3Z2t3bzNrMHI2M0pZbXpkai9ISzJ5aE5Ec1JLa2JvSHZLKzRhaGh1ZkZC?=
 =?utf-8?B?ZHEvOXNyZiswTlBOV1l3aTJpV2ZJVzVMdFlRQ3Y0a3RFaHFRYzJHZmJHenI4?=
 =?utf-8?B?TGEvL1ZTUldKRDJSYU0vYjYwbjN3akQ1Z08yWXJpcjZiSXM0bm1RejNxbDJl?=
 =?utf-8?B?QXFnS2psSU5CcXViNjZxdTZyb2V4OUp1ZDEyZ1EvNU5FcFRYL1M4b0haQkVG?=
 =?utf-8?B?YWlKZitVc3E4cWs0elNMZ25GMjJEN05zT0hSUE5sRkVxdTc2eXJ4a2NNN1pj?=
 =?utf-8?B?TVNmeFNFUFVyakFxNUkzWCtCYm1rODF0VEhCYVllS3FXL2R1bTZqWFVvN0NH?=
 =?utf-8?B?VVRkTHBMcFlmTE8ybTRkdEdhb3dYdGRiTUJHL25tcC92aTZNS29lSDZza0NJ?=
 =?utf-8?B?aE95SThaOVBzcXZSY3NIaDdYUytoTFNES2VERUhFak41dWNVYjVPSmd1M3RV?=
 =?utf-8?B?SGl3Tyt6YjVoZ1VuZmhGYTRUUnMzZFN5d2N4MGlhdGZHMlU1bHVPTWVTbERY?=
 =?utf-8?B?UlNUNW83MGQ2VGtHdytDUkVxaHI0MmwvT1F0TFo1NXZISCs1Q3lJUWFiOVFJ?=
 =?utf-8?B?aU5LZHNGV0tYaWFHVGJNOGxFVis1M0tDZWI3TEg5d3BtQTg2bmZ3cDB2ZnZy?=
 =?utf-8?B?SkxSZUllUm1kdmlxK1NMeVFOeWFzc1JqcDU4aG1aTG1aZGplSmEwK0d2cHRX?=
 =?utf-8?B?clRoWGIxMzZpTHdyWVFCekdDVitvTjhWNU5QMkR3TDZqKzhDRUR5OHVMRWQ4?=
 =?utf-8?B?SnNvQUtUREwyWVJZSm1yZjFUZlZPV3FjYnJHLzNnbnVBRGFEbEV1VklQSHVo?=
 =?utf-8?B?UEVPYXM1dTF1VUtucHNYanhrb1pTRnpOcUFJdlVlYm5KMm9Rd200ajJlZGtI?=
 =?utf-8?B?aHhIYldmZDNnNm1BdkRiMmZVVmQyZC9XdGNVUDlxSU1NcHpvSWZpY0hYeEZY?=
 =?utf-8?B?NENPSWIrOEFXMXZROW5QOEhvbGlGR291MFhFQm5UQzZoVXliU0QwcUdKdkRI?=
 =?utf-8?B?YW1WREJhODJjRGRnRkpZWElEdEVJZ2RPNGZGVHA1dC8yUEw3UWl2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f5ef2-d47c-4915-ddc8-08da4358614b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 22:53:29.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iE0nZSIG+fDV+ir+Zo7HTMlev6wIvvZSCgl8+GsbqvYU8nmDF1LpiVWEZlg2W2dFF5LM/EcSG4av4kGPIZGRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

The fix is not yet merged in linux-next, I assumed you applied fix on top of linux-next and still it failed.

In below snippets, I synced linux-next and applied the fix before running dt_binding_check and it did

not report any errors.


Best Regards,

Dipen Patel

On 5/31/22 2:42 PM, Rob Herring wrote:
> On Tue, May 31, 2022 at 10:35:55AM -0700, Dipen Patel wrote:
>> Hi Rob,
>>
>> What is the failing signature and command? I tried below commands on 31st May
> Well, you fixed it in your patch. I'd hope you'd know.
>
>> linux-next and I can not see any failure.
> You confirm your fix is there?
>
>> make O=./output/ DT_CHECKER_FLAGS=-m dt_binding_check
>>   DTC     Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
>>   DTC     Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
>>   DTC     Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb
>>   CHECK   Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
>>   CHECK   Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb
>>   CHECK   Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
> Had you already run dt_binding_check?
>
>> make O=./output/ dt_binding_check
>>   LINT    Documentation/devicetree/bindings
>>   DTEX    Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dts
>>   DTEX    Documentation/devicetree/bindings/timestamp/hte-consumer.example.dts
>>   DTEX    Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dts
>>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>>   DTC     Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
>>   DTC     Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
>>   CHECK   Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
>>   CHECK   Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
>>   DTC     Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb
> I don't see 'SCHEMA' target here. It should have run since LINT and 
> CHKDT did.
>
> Do a 'rm output/Documentation/devicetree/bindings/processed-schema.json' 
> first.
>
> Rob
>
>>
>> make O=./output dtbs_check
>>
>>
>> Best Regards,
>>
>> Dipen Patel
>>
>> On 5/31/22 6:33 AM, Rob Herring wrote:
>>> On Mon, May 23, 2022 at 12:25 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>>> During the repository renaming from hte to timestamp, $id path was not
>>>> updated accordingly. This patch corrects $id path.
>>>>
>>>> Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
>>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>>>> ---
>>>>  .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
>>>>  Documentation/devicetree/bindings/timestamp/hte-consumer.yaml   | 2 +-
>>>>  .../devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml      | 2 +-
>>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>> Ping. Still failing in linux-next.
>>>
>>>> diff --git a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
>>>> index 4c25ba248a72..fd6a7b51f571 100644
>>>> --- a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
>>>> +++ b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
>>>> @@ -1,7 +1,7 @@
>>>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>  %YAML 1.2
>>>>  ---
>>>> -$id: http://devicetree.org/schemas/hte/hardware-timestamps-common.yaml#
>>>> +$id: http://devicetree.org/schemas/timestamp/hardware-timestamps-common.yaml#
>>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>
>>>>  title: Hardware timestamp providers
>>>> diff --git a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
>>>> index 68d764ac040a..6456515c3d26 100644
>>>> --- a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
>>>> +++ b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
>>>> @@ -1,7 +1,7 @@
>>>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>  %YAML 1.2
>>>>  ---
>>>> -$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
>>>> +$id: http://devicetree.org/schemas/timestamp/hte-consumer.yaml#
>>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>
>>>>  title: HTE Consumer Device Tree Bindings
>>>> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>>>> index 69e8402d95e5..c31e207d1652 100644
>>>> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>>>> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>>>> @@ -1,7 +1,7 @@
>>>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>  %YAML 1.2
>>>>  ---
>>>> -$id: http://devicetree.org/schemas/hte/nvidia,tegra194-hte.yaml#
>>>> +$id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
>>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>
>>>>  title: Tegra194 on chip generic hardware timestamping engine (HTE)
>>>>
>>>> base-commit: cc63e8e92cb872081f249ea16e6c460642f3e4fb
>>>> --
>>>> 2.17.1
>>>>
