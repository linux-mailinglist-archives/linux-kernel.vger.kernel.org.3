Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E783D50AB2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442327AbiDUWJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380775AbiDUWJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:09:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9469743EDA;
        Thu, 21 Apr 2022 15:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3cp5NlO3t8ZCCeXYKXTQEl7o6g+CBYX52hf87nmN2yZBUYtR0UIq4HqPIRZtIxXfbKBQces5UIGJ285gdoOtmHh66zjqhVKNN1h7mcBQFSislsUUWqAhbiI+6Dlv8pbQOQV9EfC60nJ1Mn9GlIsvEdxNItAYrSNGAbKglkIOBbPRW/VwhnYc+clvHRj8fPiK5hD5SsKh8UwH+gsFaNBxHYvICasDrE4KoyzFvCMsQXY9kSsj5n81ms4TojvnUELttLp2fiINnztTrE28zsU5oe9Cm0u9/w1h7N9s/+DFeg3Zb4cMl8x9hliLaZs2oQzW0ZGT6W6dhTZpxHiS7cCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIjnCq/4hXI6LtE2XYNNs7JQOZfljCoS9JU/aFRICtQ=;
 b=XsE4VfmWY4Ib+QD25gmMoQOQZ1hDr+K8d3q7ZI1SVnZAi3JR/qySsvOHtmvDLz+bhV+BophudH/EHC/G7O+7epUzvf+AkG6HcQR2NynwMWQZhFgXLSlRCYcgt+ecDj4AuqP8U8ETFwvSMgS5GlmnI0KKHKSijsMReqgXmnhJ4acUb0U1Q7f4cLc6ybQOfshdBxSuaXHj/mLSvtj809U1vm4+3WnEXfr3/Bxa6rH7jkZUkAFioNbHr427AzcwGVzWd5jqbXQIJwT2eVKFtekgw40Rz/hp2K6aDQox+AC53a/IxmGHeQ8HU2z8Z+Yf0YX8j2KV884Dix+w3rhOkfx2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIjnCq/4hXI6LtE2XYNNs7JQOZfljCoS9JU/aFRICtQ=;
 b=EMc9EfMP5xn61UkSNzTo2btQlfLiEXVz14eiHu7wZ0D+pKMyg4uURQzqUa1ibcF7ppzUhpwCRMWP6gOVyW/0N7T7uyjOG+sL2H6wK1yCxlKrifiCF6s9pgtE54ol3QFQnOctKWmN0ipPCZbfFudcn3+03FqyLdu0438xRjHHKkZC4p5+6kc/MeclmpkdNBZ29Rp71waviK6Ff84twoLKzA6enevx+czeVkBM+fsZ017cdW228m1h2JfSJIllfFMEnOvzuyAoUoOYRoU9D85Ds1yhMI792UujO+Yl5xKfZBWDKzSAwDHMZr4kvayvT+SP+dpQPLht8wk9cKrQDdLl3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB7569.eurprd03.prod.outlook.com (2603:10a6:20b:348::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 22:06:45 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 22:06:45 +0000
Subject: Re: [PATCH 3/8] dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-4-sean.anderson@seco.com> <YmHTwPsZ2QNoFmAF@lunn.ch>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <535b1363-1d74-1068-7270-16a5e582b403@seco.com>
Date:   Thu, 21 Apr 2022 18:06:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YmHTwPsZ2QNoFmAF@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23c9f98a-b77f-4b0b-73e2-08da23e33978
X-MS-TrafficTypeDiagnostic: AS8PR03MB7569:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB75699C14B1223FBC00294C7F96F49@AS8PR03MB7569.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50ABHY/EdbZRtgHgnvOPLedosMR8yYpAhEctHQY2yNx13Sqx6h7v7j4RdgQ2RKdHGZyToobDor3KBU96GlaxdjPL8DszeCX6/gI9hoyrICdt6sOcWy1/7lLqdpsppWcgg+75gM4JsC9urJDn0Z2aY47WIn63KDBPruPc0raYd+w3XCiR+++xIbGsT348FnkwFyoda/rJJnqae4+ZvtPutb5C2h9Ko8egzPb0VZ1Riy6zBDAmDGzoPXpyWXQJPUdJtwhif+vo5c4HiFpVyTZ1mwYnB4E0TQpb7p9ZGDjscoltskGrCofO7jo7x7noJXY1zz8IEKowbciMhJqrg8p+/bWdFyJPaLzPF9UA0uHvS1Tv87qwaw8NRYirWLctdxR+A5ANA3rIp28sRNO1LfFH9FuAO078LsyXZPFX0FLHNiPbVf33vyckGHAmJQYuqSqa+77T/n3yfJrSZ5WcBv/yuyO+K/2kwffGMQ3MM+B0rL4OWWfS8UDHlYk6TvzV+T5Ig00vyavdCVkLfSSOu2osSi434uLjS6iFUSJAAoGifPQG9WsCQKpOgmD6t6+FgPg7uhQw0k4Pzt8o9GfUefpsiyrTj+xAKUxWU7UJg6z8xKeCK3KO3WwcMvmoVBUyXqUSi0i1KfSdmH1V1B4e3vYsdUva4drPaJ5YxcmpCupn9VTuN71KQySybnONwyckIu7BJ2HQUfmMIimv/zNF4kYmOgakAsQ1g7qwsCVDOy6w5suYZLPcWWFyQyhCr/W312Q3ifzC/VlTVC0Dqx3hdBflWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(52116002)(2616005)(6506007)(6666004)(6512007)(7416002)(2906002)(66556008)(66476007)(66946007)(6916009)(83380400001)(36756003)(316002)(54906003)(6486002)(508600001)(31686004)(26005)(186003)(4326008)(31696002)(86362001)(5660300002)(38100700002)(38350700002)(8936002)(8676002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhrZXBUKzZ1S0ZLU0NpUFdSNHZaeVpWY1Q0ZDFsZ1dKc3RVVWx5enhMRVRT?=
 =?utf-8?B?YS9UcFhNOEt6V2pWZEI5anFrdXBLaVZ5L05hR05yeUM4T3A4NDlqVU90VCtk?=
 =?utf-8?B?VjFaUnZBYVp1TzA0MUp1Y2EzbFAzaEIrREFvcjVhb0M5MWkvSE5BbmNKMUpT?=
 =?utf-8?B?ZzFBRkJzRkxSWjZLdzRNTFljNjlJY2NDK2p3VjFYU0Ftc1J5ZU1PaWoxQ3Rz?=
 =?utf-8?B?YVdrNnBMTWhYUk1HS3Nnb1hNYytydDJMOVhPOXZIWkVITGtDbmFrcHdyak9s?=
 =?utf-8?B?YkxXRm5KL0NHck10QTFQVDB5Y0VrV1NLSEtMMndLaW5tRVRzeTdoK1duTW1W?=
 =?utf-8?B?MmtHMjlxWm1TLzgydmNMZmMxblVKVXd0dk0zYk5OMk1TUi9TSEVyRi9MVm9Q?=
 =?utf-8?B?VXR0b3d3NGx0L2p1OS9TckpVam53bE50bE0zV242RHBqQlNhS3JHdmxRemV5?=
 =?utf-8?B?ckQvb3RFNC9NbGV0dk14Smd6MFJEQjY3UHlpUkt5MmFKNUtncmRGZ1hWRi94?=
 =?utf-8?B?OFJDbnhiYVhoTElpUFBJdG1hdHF4NVpndGExL1IvZGdIWlRBNU8zT3M1b0t1?=
 =?utf-8?B?Z2Robnl5WW5VZndIVHFmekFDRFZSWGZUL0pxV3gzNDM2QzFWU0wzS2F6YlZC?=
 =?utf-8?B?cTlPcnJ4YWpSYzJKdHZqUGlzYmZjY01xZ05IK3NqODhhLzRWdDBSYVhjNTVF?=
 =?utf-8?B?NHRQTWZJbFlHUklBa0c5WTRoM1d0WUY1ZkRPT3BlWmxobkt5N3ZlaEZDR3hK?=
 =?utf-8?B?OU5FS2xpOHZ1ODU3RWNic0ttNWJKczVuSkQ1T1BsWjhwSGduT3pCUU1UeHd0?=
 =?utf-8?B?Z3FDaGo2YnZPeFYwVTdSREl4clZVL3hPUkxETHhyTzRrWXFsMkpUcjZBSGd0?=
 =?utf-8?B?TzFJanpWQmdBNnlRQkwyTldsNno0L0ppM3I1YUh2aGdEQy9uZEpaM3I0NTI0?=
 =?utf-8?B?aVAxWnY1TVVHTGUrRkg1RTQyUHR2MTBOQVVadHA4Tk9DbEUxYnpiK3RGMkl0?=
 =?utf-8?B?SVJXODNxUmRmaThlREcvcVg3MUs0VER2amtlWUlOS1VaYlpadDJ1UkZzaUsw?=
 =?utf-8?B?OUtzdExmNlJQbzd4Unp2NkFZY1VidmQ2NWFWRmJHWmRzY2FwMkl1Z1VlWktn?=
 =?utf-8?B?Q0lkWFZrRkE1VGFQYldsazc3eU0xUnZTWVNhd2o4WXgxbTFleGowRDRvcVVJ?=
 =?utf-8?B?R1djYjlrbndjZzN3eUdvcFowYUU0U3E5V3lXQ2VxcG01YmFabjhiWUl4a1Zu?=
 =?utf-8?B?SnBnSmMxZHJlUm02TXpKdVFCamxXSlhTYnNPdzlLWTl2QVdVZUFlQUlONjdm?=
 =?utf-8?B?NmxXb3Rabk1XQVpSQUhwcXdBK29leUFGZ2o3VU84M29pVTZFNnlUak1YM2hr?=
 =?utf-8?B?VThyREJpQzlrbmVPQUY3NkNiNXhjaS9xZ2R0ekJkRm42dEIwZk42bzRwV2JX?=
 =?utf-8?B?Ukh6VVpSNkYzV1lHblc2ekJGSUVZajBkTEhtTVNURXYyc3l6aUVPQmxqR0hh?=
 =?utf-8?B?UzBhQktrTlBkRjJybExwZHorS2NKT0VWd08yUW5lMnBPWTFtRi9UUFZWQ1BD?=
 =?utf-8?B?SU9FSXRPL3AwVm1ZWWppU2dXV0pkcU9yeldqWGJuVTJlN2I3VnhvYWRzM2FO?=
 =?utf-8?B?VHRoelBjZWJ1ZFlRL0VaSlAvUGVNdXMxcUh0UHVieUc1aU03RGJDMnNkK0tG?=
 =?utf-8?B?K3dtdDZHbVoycEY3ZVV5SndudnVhRW5wbXZBMzYrSDJFZFY2Y1dTU011Y21V?=
 =?utf-8?B?Sm5Sd0VCeGFwemQ1aG9YbVVMZFQwcjZxRjJEYVpZVGdCdDVrSnJrN28yVHpW?=
 =?utf-8?B?K0xrM1R2Vm1JVVdUUU9wamo2dEdSNEtxemZ4V0ZiR3JWSzlSdVVLT2Y2WHFa?=
 =?utf-8?B?MWZDc2NWSjFGODh1Zi9CUFFnbkZkQXc5MTUwZGJpRW1QSkQ5SENmR1d5MUlZ?=
 =?utf-8?B?TGFURVpna28zdVhQZlZtSml4SHY1Z24ydEthNlF4SkRqN0ttL0tHb01HSnRN?=
 =?utf-8?B?SGtvUmkvY2VqaDc4OEVDRWNwaXFXNkh4WjMyTElYR0tGamlNN2Y3aWpxaHFZ?=
 =?utf-8?B?dm82Z1NmR2RJZE5FNXRSVUVWd0JpT0duS3YyMlNlM1JFTFhoUUVxUkZDZTVm?=
 =?utf-8?B?M01PZWJ1V2ZmNU1XS2djaGZNd1RNb2ViVUZhSmhYeFEvaklxekJhRElja3hy?=
 =?utf-8?B?alBjbFM0Q2ZNaVZiTmIyUWpUQ2tYOWpsNUhNVFBJRm92Y2xnWVBUV1VaWE9k?=
 =?utf-8?B?QWw0emZVQTYraGloc2RKZ2FERWVBZkJaRUZJMFppK3hQQlFNWG5nMGZwbElj?=
 =?utf-8?B?S0Q4UzNwYm9FV2JlMmdDUkZ4c3RPSDFaNDBNbkMwYytWdEp4SHpmbWhSbTZP?=
 =?utf-8?Q?UkuaSpM35EmP0Akw=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c9f98a-b77f-4b0b-73e2-08da23e33978
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 22:06:45.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efaq7A8JclhGLour9gaRJy6fhChMeA1VALSN35LTFVFprgiqg5VK67RIbdPxUrux5Ds9BUwUPcYVcbvw9xgQIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7569
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 4/21/22 5:59 PM, Andrew Lunn wrote:
> On Thu, Apr 21, 2022 at 01:56:52PM -0400, Sean Anderson wrote:
>> The TA_PROG_SFP supply must be enabled to program the fuses, and
>> disabled to read the fuses (such as at power-on-reset). On many boards,
>> this supply is controlled by a jumper. The user must manually insert or
>> remove it at the appropriate time in the programming process. However,
>> on other boards this supply is controlled by and FPGA or a GPIO. In
>> these cases, the driver can automatically enabled and disable it as
>> necessary.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>>  .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml        | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> index 54086f50157d..e7d1232fcd41 100644
>> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> @@ -32,6 +32,11 @@ properties:
>>    clock-names:
>>      const: sfp
>>  
>> +  ta-prog-sfp-supply:
>> +    description:
>> +      The TA_PROG_SFP supply. It will be enabled for programming and disabled
>> +      for reading.
>> +
> 
> Doesn't there need to be some indication what this is? Is it a GPIO,
> or maybe a regulator?

There is a pin on these processors named "TA_PROG_SFP". The supply here should
be for whatever regulator supplies that pin. So it could be a fixed-regulator
or perhaps a sub-node of the board's FPGA (no such node exists yet, but it
certainly could). There's a pattern property under
Documentation/devicetree/bindings/regulator/regulator.yaml for these sorts
of nodes.

--Sean
