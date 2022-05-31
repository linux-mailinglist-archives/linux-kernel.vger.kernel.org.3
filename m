Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC310539585
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbiEaRgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbiEaRgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:36:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F14972B8;
        Tue, 31 May 2022 10:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUutpN7OmVlVpV/teipiMIygDa/OQ5GZTDVDDRyvzgV415JSRqL19re9+D8Nt+XiwNtmT6F7MPyy/feZ+CTOEpaU3cVJ/hnl6NhDz6XMT6lkP8pCTnLsGY/KL7buewUN7SHcnYR99+nYhB91AHHnfkIKQJezm1XDEAOMTXwxV/mszVF8o7do4APdC9BujAb6nMotUwJ46bvQPuXlE3wZhZCPAVr4BDWuNvZoWbe9bK80X9iFUqZMCOaLeABDAMeQuaqMkr6PZiMXh57JaAD69j06eGCJ/Kh4qcPcVF3PicSUsVZl8fNdedeW8I3QqWhNo4o2eqxniutoeQe7kx2onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6WAVPxmN8c+5cas+I03LKpxZKQab1VIETAQRyI6I8A=;
 b=DC4BvkMRzQ8czFc79ubnkOixy/jeqqfxr6dp/ka8fBkN0rkkzZJvqe5Q0GR4wyFsLidNZAIDPuwGPe6KtzxA9R/3CU3249sxJ/7jezWDPTiq/2Ef5CrHunpO21U5Heskqsqh5/QPN0++HbDhovLiA8dbZdqw5WnSQRZsHBTN8GvSimxscvPayj5peQtr04Mc9rUV9oVs+nS7tzqSPgKhrdV7bTYDib79LZDQ3yn7L+lKv6sc1YtKw0kshxNlozuHIkNYxheyTr24GennYGqvcJFVMLlrP7w8mMw1zhBobQowadmYxAm3Q2PPtvtF4Oije6F6sdv5FSqK+n9EBHnnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6WAVPxmN8c+5cas+I03LKpxZKQab1VIETAQRyI6I8A=;
 b=WdqYV1F8zO2L6eDbuBYfeDl0pwVU5aPaZvm2Aq0+L15SgvJpPMTPfxA7xR05dl1LVxaZnP/CH/12wIvLTOsrA0tR1mR+c9hVoq9OEe40byOD/m5EPC2uBWYYmbEjj40HM+/sxGAJk+Rx7oOdFM4rBbWpHyRbxpOV6nVnmvlQEmP58Ne0zfd91i4+IXqkFQvoT8CtCa7/SIwwIb4GH3Y40docekou+Q9Z1OvhVLeHvEfy7HG+/5HT/KJ34pggCYWx9vdty8J/9Gf9LKLai9BwsGl9IsXavRBrT93aBYgaNNpNDYqpEg0IXqNFBV2HAvADEHmMu6PGdxSyizwGWjq6tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN8PR12MB3346.namprd12.prod.outlook.com (2603:10b6:408:45::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 17:36:03 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::6c51:327:2e1f:a04c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::6c51:327:2e1f:a04c%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 17:36:03 +0000
Message-ID: <86b11457-2f1a-6b17-fab0-a13d932af993@nvidia.com>
Date:   Tue, 31 May 2022 10:35:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: timestamp: Correct id path
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, sfr@canb.auug.org.au
References: <20220523172515.5941-1-dipenp@nvidia.com>
 <CAL_JsqJSF=7FOW4oNydRtDYY8L9Y43E4FsBkUzM+U5ZRjYdt7A@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAL_JsqJSF=7FOW4oNydRtDYY8L9Y43E4FsBkUzM+U5ZRjYdt7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:a03:40::44) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a612af84-f9ee-45a9-7e6f-08da432c08b8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3346:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33460E4BB285699865A92A61AEDC9@BN8PR12MB3346.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPRAwZmzdJ8YnGslEq8cfp2J0CMfQyewFzgIb2qHJYso3rHYncnZKVdAaqPyKVMnq+8HPhKXKis8eOgAyUE6xTe+3VzBGV/Wq5My8kJ0n9KtzIY39FQPWq4qxKpufsSn2OcpwYsXTC0eemSdUAyLX7tVSaVSqJAWTABEE9mtOB7dCIl5asoBigIt95Ww/4/XOlvfM35sR93pCx6MDQd0tHexPl8n7/FI2EZyuwCxDyB8ZjtcXME1qRTcSa5IdQF3MyQqvtwlh0ZXIiJtCMNHbM4e2Z8iIcx8GBZFfxW80Q74hs/uSg//dYSCn2aP2dj1WDsT4p1jz5kF+4iiuuE+U1T01qPdvXw8Rdu3qGe6eNyefxGVWtcIWo4wQQvNMma3+bF0E/Q2iGNVugqqQdRn9etqN96pQ1QHquf4wfvzocQcj8d5LVGxT+t9Ult+gCKynp9h28H7Tp+W52I7ftjmMCooU0dvsd3Y/ZQ2nK25Zyy4UheKXLJnSHxpKdNueJkaxh12gLA9350fSr0/kWCq0l1z/Qm3W87juxDEHmmmO2vdQtMcg3WKqe6MB/YPoIoHT2CXS3iyJwU9gG50k6/t+Rr3EaNWf/3q8i9QAs3DWRiNQ/CZPuGRVpIT/cG5+qa1eZ2R1vOxCNX96mFep7kZq0uUqEiM2kff88dm7c6hOMp4pUKo5JTj3l3Pc4m9S6DPxgcoL4KgqNGJYPNbDbOEfMNHxwU4Q39xsHgUrqkuS5teyO+YTKGTToZLNNjLuZQCR3ooXHJXWu8zZbnOCVEqaJYGPC49LJ77e1xp8gFs7rvsxeGTXIXbtiEBQrkzzjF6YG4J6+cFzzEUtijzWLD6pcfA8YQitLCUzuAEtMYCCLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(66476007)(508600001)(66946007)(66556008)(6486002)(31696002)(83380400001)(6666004)(6506007)(6512007)(31686004)(26005)(966005)(53546011)(36756003)(8936002)(54906003)(110136005)(5660300002)(38100700002)(186003)(86362001)(2616005)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tlbkZGS3Ivbm92SndVeUE1NjFlUjlBRU5JdmpTb2JqVW1JSlFuaUx1M2w5?=
 =?utf-8?B?NktqZFprNHZmaXIrRTBMRkdiaW5NQWNNcmlqRlpVeU5wa2tqY1dnZlV2SWE0?=
 =?utf-8?B?QTNPQ29IMVJhSlIyQUwwOWJFQm9wRnNhK2lhem5ZVW1NaTlLRzJUbElGcmpx?=
 =?utf-8?B?U1FURk9HZ3BFM1hyMkJVZ2JiOTJLb05GSGlVUWRvaUJ4YWM1OXowQXhhdGtq?=
 =?utf-8?B?Z25PNEd2Zi9uMHpZM3Z0SDhNdTdPMW9FT0hKMGVsSm1PV3E3TG5QWXl6NUs5?=
 =?utf-8?B?K0tHQi95L0UxSDZUNmluc3FBN0p5eDNCQ2pmSjJzaFcxRVFGYUxGZ0JqUm9k?=
 =?utf-8?B?cDliK2hhNmdlZTJxS3RqY21WRERYanlpQUd2RnJoblI5bUpoaDBGM2grbzRE?=
 =?utf-8?B?TnJHbEhMTlJYbENkQ25IQnkzYVJkdUJCemM1V1gxR1pTZjhMY0FzVlRDekFZ?=
 =?utf-8?B?cmh2K0w1YnVIazhvQjR4YXdlMnZ3OEYwSjlEOFRrUGxGWmJ0NTNvY3c1cEFF?=
 =?utf-8?B?bXlBb0dwNXl4UCs0R2Z5Zm9WT09NSFRkcFZ4cjBVVXE5bk15a24wZlhvK1V0?=
 =?utf-8?B?WlFNd3BpbXhobHYrQzRGU3ZZYlJoQ2g1bmVEZkxnSUhpajE3SG9JYThxK3R4?=
 =?utf-8?B?ZDBwTyttcXBWNWx4K09odkxYYWYrZjJDMWlTcjhMdFpiakRqK29xUjcyRW5U?=
 =?utf-8?B?UmRWWlVVMnd0ZU1KeGV0Zmo5dHNRMEVTalNvenVaOU1IZWhRdHA0Q0h3UGdn?=
 =?utf-8?B?QWVsS1JHdERHUXNNNG9ySVE2Z3BIei9yWGs5MlhjMUZ6U1ErN2dra29jS2NX?=
 =?utf-8?B?RzNLRXVSZHFYK00xTjRwRFpmTC8veEFKcnhIcVAwenB3QVZoSWV4R3FGeVEv?=
 =?utf-8?B?ZEJtM0JyNXNmM0hqT09HTEtoOUdlOW04RDdlMXEwZnY2a3FjZHpTNXdMaklX?=
 =?utf-8?B?NWJNN2ZzV1d2cHVtbjhNb3ZGN2lRdVRTbjNVc1VDMlpMVlRnWG1VSVN1M2U5?=
 =?utf-8?B?UjdOMFJJeFYxdW9kdExmR0VxU1M4ajhXc3IzcVlxTExlWEQxcGtpblBJWkla?=
 =?utf-8?B?K3hpNWd4QVp1OGg4WnZ2Z2RFVjkvRHhIUzhieWk4VHRrbXJEUEQ4MUt0OUpI?=
 =?utf-8?B?RTVxb0ZrVkYyaGlDOXM3ZGE2ZkhqbnFwVS9BVmUwYXRFQ0QwbGdYeFNhQ1M1?=
 =?utf-8?B?V016ZXFpNTdrN0lvYWJ2V3F0S2VqUVJsQllDb05WWWxSM09Jc3M4Z1hWbnRw?=
 =?utf-8?B?c2ZhQm1BY0NPRmcvbUFpL1czbnFFMzNBYVl0V1VTemg4aEkrWUxiVUlKSEVV?=
 =?utf-8?B?UTZMcVVzZHZBY3lzaFoxOGNCWTdTT1dOOHNDZGhscGxOeDVnTlN4dkl1YUNB?=
 =?utf-8?B?WGw0RmFWalFLVXNwYkxlbm85SitnbGllQk11T1ZzQ2hzU1ZvRFZSR3RBS01E?=
 =?utf-8?B?WXU1cjZoclBYVHFNem5YNDRFWXNXS2tiMnpGUXRWZ1lMSHNMVE5BVU8xaWQz?=
 =?utf-8?B?UEhvSzdoRk9pa2lzTHRXRUx3VWhaR3dBaFZvVHdDekFzQWNUTFRqUlpXYzli?=
 =?utf-8?B?WXhNZ3RXU2hkSXBjNWlTTnl0Vm8vM3RjQjdHZU9HYW15M21ZZWtLZWtxSTk5?=
 =?utf-8?B?VFhha0JIOEhmSWtUV1I5TEpoWVdQZ2VKRC82MmdTblhBMHg0RS9ERVU4NG1G?=
 =?utf-8?B?bG05VUgvWVVhSi91bnhzWEU3K2UzNzZTb1FkVUNRMUZucExXbnUvbkphTHAx?=
 =?utf-8?B?WTFZQ1F3MnQzaEk0azA0N01TMkUvUVQvMXhDZmRXZjcvQlZ0VHpRQ2llb0h4?=
 =?utf-8?B?TFBWdWpRTTg3ekR0by9nMUhISTRvL3pDWVJHdTJoaytqTDQ2MFlNRVJ5ajMy?=
 =?utf-8?B?NTRmcjlkNHpnVHdVbW9oTFZnRmd6eDdURmZvYk0rR3dWUWwzWURpQVc3Nk5F?=
 =?utf-8?B?TTBpSGsrNmRyVGt5dGFuVmEwRlNMV002QllTdDlRa0Y0UmdiRTk0MEhJY2l2?=
 =?utf-8?B?OFFMcUxLQlI0UHpPWTRPWXJJOVRrU3B1RnRKSEhoOG1pTmdyMjBhRlRJUUFN?=
 =?utf-8?B?c0gvcWVKQkk0b2wva3doQm01eXZVTWl0cFE1RlRpVDJuZEhRMUxhYTBQV094?=
 =?utf-8?B?eDBqYnhOaW5xdlRuWVhGVzltenliWHpaaXFuSHNnT0pMVkozQW1KUWxnSSth?=
 =?utf-8?B?Y3RBWEx4QTE1Y3F1RzB4eFhPRDZoYStPc2k5OGFmelRQd3o1L21scGdOUFc2?=
 =?utf-8?B?SUg4dE9YSmE1OEZLdDhLZ01kZ1JyaFZLOWhzL1dQK0F3Mm9kSmMwZTNGSjhY?=
 =?utf-8?B?bm5uZ1krRkhoMnlreU1rV1NkQ0NkcjBtRnpxUDJ0enNFYkRjcWFVZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a612af84-f9ee-45a9-7e6f-08da432c08b8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 17:36:03.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz8c4/SaRWAJe3T3K17gaavlRFuxec9xVrOHiYC7KnbqFEcFVOyBlVaOkfLpvKfTA/mMO4nU34mbAK7Hkj2rpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3346
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

What is the failing signature and command? I tried below commands on 31st May

linux-next and I can not see any failure.

make O=./output/ DT_CHECKER_FLAGS=-m dt_binding_check
  DTC     Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
  DTC     Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
  DTC     Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb
  CHECK   Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
  CHECK   Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb
  CHECK   Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb


make O=./output/ dt_binding_check
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dts
  DTEX    Documentation/devicetree/bindings/timestamp/hte-consumer.example.dts
  DTEX    Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  DTC     Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
  DTC     Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
  CHECK   Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
  CHECK   Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
  DTC     Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb


make O=./output dtbs_check


Best Regards,

Dipen Patel

On 5/31/22 6:33 AM, Rob Herring wrote:
> On Mon, May 23, 2022 at 12:25 PM Dipen Patel <dipenp@nvidia.com> wrote:
>> During the repository renaming from hte to timestamp, $id path was not
>> updated accordingly. This patch corrects $id path.
>>
>> Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>>  .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
>>  Documentation/devicetree/bindings/timestamp/hte-consumer.yaml   | 2 +-
>>  .../devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml      | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
> Ping. Still failing in linux-next.
>
>> diff --git a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
>> index 4c25ba248a72..fd6a7b51f571 100644
>> --- a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
>> +++ b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  %YAML 1.2
>>  ---
>> -$id: http://devicetree.org/schemas/hte/hardware-timestamps-common.yaml#
>> +$id: http://devicetree.org/schemas/timestamp/hardware-timestamps-common.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>>  title: Hardware timestamp providers
>> diff --git a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
>> index 68d764ac040a..6456515c3d26 100644
>> --- a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
>> +++ b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  %YAML 1.2
>>  ---
>> -$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
>> +$id: http://devicetree.org/schemas/timestamp/hte-consumer.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>>  title: HTE Consumer Device Tree Bindings
>> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> index 69e8402d95e5..c31e207d1652 100644
>> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  %YAML 1.2
>>  ---
>> -$id: http://devicetree.org/schemas/hte/nvidia,tegra194-hte.yaml#
>> +$id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>>  title: Tegra194 on chip generic hardware timestamping engine (HTE)
>>
>> base-commit: cc63e8e92cb872081f249ea16e6c460642f3e4fb
>> --
>> 2.17.1
>>
