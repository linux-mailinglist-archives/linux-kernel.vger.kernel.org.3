Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB74B4FBFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiDKPFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiDKPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:05:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D622299;
        Mon, 11 Apr 2022 08:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKRtXCBFTPWXSsdhZzu4Nvr6q2FCFI0qgaC+AwYamnMVefjzCtOJb8qxK//Sx3qAOL2IHKM43oMFBXh1hhqvlyesHoU3/n6k9PHrDrjiQrLCYusyO8G62wOUYqLb4ZMYy65i9xZGBp1N5xOEfprp/dtcdOF+CGoPjMkLKcRiNIciw8ab0fbWrfEQ6AVqhEeTV4psXcRAE/xqXliXk+tWhzio7HNVt4hS+BFezc759UeZiqtaGrL7McPlyW1xxFuaTQtgByZBwREl0+NPtojkTqZDmWUyQwcKYZliC3h9J6dGNC+5HANjdeKAOvKDM/zo4dopT2DwnR2QNe1KI81MYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su5t40FRhc08L3FQlwsJ3FmsrbOoKXAw1UOXjhjie3A=;
 b=LAvkjv4fKhTFraYFBrY/xpyHqv959FH2hw1WHe4MDbg5aKXzJBerMy7OH6EuqPXKfn/vwtiUlgA1p/UlGvyaRX47geSZKoaEX4o2r4La8+n55ikuds5KFrJwtjtXaCe618lRsv3P/RbZfVDkG8fOsWyvGbFs/TaTGVZFzlGl4Bjfwp3N5kakpwaB+kbHey8ciCeKnnXxZ7hSjQVRCG1ZZlFn5TRqIbehKcoRaWZk9yni9Jf8BX/YQCizCp2vAF/lLUPFINIw1z7Gzbfelg8k7UVxZzAaFsqfYpayiCNOUwIJbi+BNTClxQ5xHUHOXzKOMnrq9UdWQgfxtd4Qk5A40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su5t40FRhc08L3FQlwsJ3FmsrbOoKXAw1UOXjhjie3A=;
 b=rPWjMmsSpJyFSKz/5wNWWCm3uah5njxRGh1ccYdKP3OT4+4i5L3qBdq2aGFhvlr1ZewyAf51mGwirIfNH9n+nYnejDcTbYm6HeNGIMR3yITJBVJDN3XpSfrjCno6V0OA+DJ3FmYdnDoagzdXmVaFmmer/IsXPOIiJjgxOsxTp1RTwLBpfbhbi/CJo+gF8u9xJZa1CiJOiQM24Oy08Eo7qQj5vIYJL9WiUgkShw76hAuyxwmU2QgUM3pbSrbgL0cwcVStNt8FRTa7/jPzr1F/TNa6tUM6W2ZOxJTUTiGRXnyu7BYSd6dtlACvNw4IUDG7KtNdNUy8iOM3UWQBv7M4KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 15:02:54 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 15:02:54 +0000
Message-ID: <81686bc4-c580-862b-1c29-51b34e419154@nvidia.com>
Date:   Mon, 11 Apr 2022 20:32:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-4-amhetre@nvidia.com>
 <3e044f9e-3200-bb26-897d-1977e3825c92@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <3e044f9e-3200-bb26-897d-1977e3825c92@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::32) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da5dff40-773d-4ae0-fca6-08da1bcc5af0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5851:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5851577950295F99A069D0EECAEA9@BL1PR12MB5851.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWhtlOs69VA5J2u3k+HlzVSjqyhQn1VhToYaSZY0GLo4U4Ce8XvGtgd9rDF9Mt7HraIYJPVOlvqZNXs8nsOLVDmHWjD5oDIvKpb5PYszJaVKEJDvSFkFgMRXriHqL2iDUaCD6rzpu+uQUh9/RjJ9JACl/VSvXG0RxUGnHNIaRST1nRuzbOk1N4kEdyNNihGuEgwsRcuXQljEPsyDT8BPQdLljQz37BMd6IsHET9QIu2oSmEWEORZS+sfFob8oWwDKmXjaU+lbIRUjYSxffg06tUg33dSwA7wXfxFmGTlZRDq/rroxXccv4p9HPFia0zrOF6+HJyQ6pqyxAgzug5vPbH7jnCoNcydYD6w7joZhFlBHaProHAm2YtgWvtRM/BbmECkTnm6FtBS0oPrwl8DCDzqDYCHT7BVPoFv81e2vtX5/oBXRew1UxSnPEkWiN9tPQoaBFliDlSTiaVXunwWGQpjxIH2XlGc1t7/j4iyztWnFWuOoz7T4gxM2D36jvBHn4k6Zew0/hURle5Ypbh8szCCCSWzUukW3bsajDLx/7zTlyuky3+IEitl8M/rl7uuFh5Mwud+FvF1fcXdVFXqP+8SDclZMGQltTQRZ6zg7ykwcvxI/HA5rFZ8y3EmNsQPgu1DIqd8r+vPR7z0aPy2G8DwaR53gtSAaXixhnMQbjBA3VcDCz+NY1ky0fyvGFyzqaeN+3U7ML/VESRTnKnlHeIgaDbi3BsCYo6LZ9Gdsx4kPB8VGzNRtc9lSvsNgyM2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(508600001)(2616005)(107886003)(6666004)(8936002)(6512007)(5660300002)(53546011)(6506007)(2906002)(6486002)(38100700002)(31696002)(55236004)(186003)(26005)(83380400001)(66476007)(66946007)(8676002)(4326008)(31686004)(66556008)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHBRY05DVHBLOG9Qb1FHNXUxTmdMVzhkbitTZGVidXNKcFB3eTFiVlloZTJa?=
 =?utf-8?B?eFZQdXEvSWdpQUdDd25rWnMrSmtBNUN1QU4wWGJIWVRkWnY0Vi9iSFM4a0Ur?=
 =?utf-8?B?ODRxNmM2a2J6eDNjdmxJMURhYndvbjZ4RnlYUXN5WXlweWRUK2dXeUhSSSsx?=
 =?utf-8?B?SitHaEZST2d0OHFUUU9DMmsvelViVDVmeGRtVFBTNlBzVm5VdU0zcFlSb3RL?=
 =?utf-8?B?bVRKakhWRndVakRGZEt5NE5YSWNmMnVLamVucE4vTE14NisxRytxVGx6SjhU?=
 =?utf-8?B?TG5yYVRHaUJodXU2cmR4bTAwdmcraUxZcFQ1OVZnUnhycXovV2hoZzQ2L296?=
 =?utf-8?B?elBSN21RbDBnbDdBblFibTJoODZQZFNXNWhQRzBBZC9xTTM0YTJiM3FCUUZX?=
 =?utf-8?B?N2luNFN1Q3ZlRjkvZ0U3SE9MeW5BOWUrckUyQlZqRHN2akxaK2Iydm1JQjlC?=
 =?utf-8?B?RzJSRUwxRm5zdldyZjZhaEhkOGJqV1NKaHlrQlFSalZTK25jTXl2Z0NmcUh3?=
 =?utf-8?B?aVd0TXVUMSs4VWJMK1JMWW1WWkEyaDUveHdGay9JVloyRlRSYURqbWtCazdW?=
 =?utf-8?B?NFhkdHJWK25qZHRoVnhmdHVKZkRqMmV1T2J4MGsrVnFWY1VhRUtiU2JiODN6?=
 =?utf-8?B?eFhYNVRqS0pWcmF2U2NSdG1GbzNobXJRS0l1cGtPYW5YaUdYb1VUWWNYYmRk?=
 =?utf-8?B?a1NuMVBVWGhqWi9TSTZyWklUQ0hNMi8vZlJRaWpHZndkdmVwK09ickhjV1dq?=
 =?utf-8?B?ZHhOSHBFRjBVQ3E2eXpCVTQyeGJucGxvbkE2TUZMRDhLNmpQMmxIQXpnZGUw?=
 =?utf-8?B?QWREbVcxZHhKMUx0clhpUEhYd1lCOVpjQUNLYXNpWVZIMys0azVFbkJhcHNP?=
 =?utf-8?B?WXErdENON2ZKODVtUDhSNVdGaklDZzBiY1lFVGtJUW5NTWdQdkRxbG5iZWZH?=
 =?utf-8?B?Y1l6ZVNVU2xTWEZlSkQ4enN2RlliMDZxTmpSK0VYM29EYVA2d25NeUVJQlNH?=
 =?utf-8?B?SG5hRnRtdWUwZWR4QVlVbTBadjdzUXNsZGNVU2plbU5WaUlZTXc4Ty9oWnh2?=
 =?utf-8?B?TEorQkJzbks3eGZ2T0kwVUlSclhKZDFwdExBWG9BSm5xSXFVUTBxNUhydWdQ?=
 =?utf-8?B?c0RTK3pCby9qMEQyeUowL0kyVm5Cc0hadHhHcVllRUMvUmRyd1h2TlRLWEU4?=
 =?utf-8?B?WDF5YjJacXE5a0RIT1RlWUdzc0hNNUVYclk2ZDArSDR6Mi9CdkFnZWY3TUU3?=
 =?utf-8?B?a1BKZHBpckZoNVZBdXEwTFBjazhYWW1SQXVKUGFkVUdTVVNhN1BRWVRWcWtJ?=
 =?utf-8?B?dHB5RWZiWWpRMnpkU1pBdDRtcGlyM1VNSjNpelNLUWpNOXNMN2p2Qmo5Ykxk?=
 =?utf-8?B?dDR4NWxoV2MveGpiVlV0SXJRT2h4Z2g3MmRDdmlTQ0Noamk4NnBNcXFlamFJ?=
 =?utf-8?B?eUxabGQ3TGR0KzlQQjl0YUtJSkhHY3dncXU3MXg0QVJ1Z1l6TWY2VmdZdjVK?=
 =?utf-8?B?dEpEc0M2ajAvMW4xWDdPQjY0UmFoRXNLWE1YZXV6cG0zTGxPYldldTZpVm9F?=
 =?utf-8?B?ZFJsZWlWT1N1NGIzNWh4TmZUckFqcSthQXQxbTZoSUg3UVViaG9hNHhIL1RU?=
 =?utf-8?B?L1NsdTlUaG5zbTJ3Z3dWNVdqQ09TNmRIYlRSZlovVkRsOGhRY3JXNkEwTlA2?=
 =?utf-8?B?Tkp5NEc0YnV4ZHJmcTJLMUtYcGxrNk93S2ZNSVgzdjJpY1BxYW02YUdsVWE2?=
 =?utf-8?B?NE1rWG1NbEc1eHZXYk0rSDRzS20rMmxFVUhCNEdPS3NoY3NNb2hkdWRMbEx6?=
 =?utf-8?B?cWM2NXZrZTNOYndzcWQ1U1VxSktRaE9CR1JFeUhVQ2FDZFl5alBNT0pVMHpJ?=
 =?utf-8?B?ZlZpTFR6bDZiMGhRSVNIYUwweE9yM3FBbXZNcWVoZ3BCbEVja2svK1NRTzdh?=
 =?utf-8?B?VjNOTDNrVW13bFFBU3BrRnJFNHlGdENMdE9YMGZZOEZoMC9Ca0hTRGtXdVV1?=
 =?utf-8?B?dWtEVUVzS09VUWJMMXR0OXYvSzh1TGlYZVhRSkJWSmh1NEFDZWUxU2xHdWFW?=
 =?utf-8?B?MmNKSTR4QzJibC9ONlVUbHZTRUsvZEI5c3IySGxMVGlDRXZOVzVKYXo4Q0dr?=
 =?utf-8?B?WjIyVDEySTg0VDRKa1VSYVRzUmNjdWkvTk9Rb0N0bU5UM3dyUE1EMUhLU0FK?=
 =?utf-8?B?Y3dNMDJZNEk3dE9IcmtOUnlXTVlMakhPYmhlRkhKWDlYZ0o4d2ExWlpySitZ?=
 =?utf-8?B?RGcxekhwcGQxUUx1ZWhLMGp6TndEYzFpMTlER21MZURWclVSUXpaS1BiMzds?=
 =?utf-8?B?d0FqTWJiT1V0aFhUL3p3RXJEOVlDUXNieTI3STZJUHBFWlRYaTQzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5dff40-773d-4ae0-fca6-08da1bcc5af0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 15:02:54.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TD147+xxr97BP+e0ETG10YscxGmY+S3yqPMX4ngvsS8Z+aLSPpRAyFIY41HQP1xH+uKX0xjidhyhNVZm508M0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2022 7:51 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 06.04.2022 08:24, Ashish Mhetre пишет:
>>           memory-controller@2c00000 {
>>               compatible = "nvidia,tegra186-mc";
>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>> +            reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1", "mc2", "mc3";
> 
> The "mc-" prefix feels redundant to me, I'd name the regs like this:
> 
>    "sid", "broadcast", "ch0", "ch1", "ch2", "ch3"
> 
> 
> You should also add validation of the regs/reg-names to the yaml based
> on SoC version. I.e. it's not enough to only bump the maxItems.

Okay, I will add validation of reg-names as following:

   reg-names:
     minItems: 0
     maxItems: 6
     items:
       - const: sid
       - const: broadcast
       - const: ch0
       - const: ch1
       - const: ch2
       - const: ch3


We will have to keep minItems to 0 in order to make it compatible with
old DT, right?
