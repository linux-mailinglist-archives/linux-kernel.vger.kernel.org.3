Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA54E8E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiC1GW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiC1GWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:22:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48251E4E;
        Sun, 27 Mar 2022 23:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkT6fXudpAHyH4BAuDqBmYf7ensFYNyuYIqOeQDV7XYhvl33BSOC9PC1cab5aV7VJD6d2CEKDpxqwmneZ+3kTJl9V4x5kyggWyUdDITlYr7Autcj2BbadlT+j0/xbuwykX36AazI29Rv9itFui9hfS13nDcjik7UYMsi5augLJA69KkfxTuwP2Op9c5JqlucjD5cQrLh0VIBPXhvh8EKoOp7ToWjqk4jKZITMeO6NPPJFX++byjR5w1/e7+kzXUkkx8xP/eJu3B4HTGFPvpbML/yXhmnbsZ8mrY6jSDZUtHSWA6c8A8y54WGq87xYY8fz0aSj7/4ltJp50FbNOtWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxP9Pa1a94zidhRTUtKJeIhevcUCnvFlq1R0lfQ0ZHw=;
 b=h72ILxSd+YEcWfKpPzR9E8ZHGy7Vs2SfIe2XExEUZissh7bqtcp87KKaRZPPaCFlh6d0OqC2NkctZq2VYtUsqqqFBN3Vi6ofItYR0iSn2yqLyIh6CdkFXBCXAjanF54yB95liTLIkVIZublDvvzmEwnxHCwbrJmKTytY6F7QwJeuR2vSjaewf+teCLyiIMj+fC7wMhWtEMALesefqbneLCJqCgBUrKPpWHqyAwiTurS5xtf8EgawpejAdbuwHysv/sevsYESk4HFu1Z/Vxf8GD0my0hLugXdwvuM4Fidj9lqxosOeHL4oIN6G5fZ87iLSp7ehzas0nJdsIPTFgfDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxP9Pa1a94zidhRTUtKJeIhevcUCnvFlq1R0lfQ0ZHw=;
 b=ZYGJtBKjX1nO7mhk28hNg7eIB/YtJJCItaLNul3BnEThT5TIYPPKKgqjtWIVhJz6qg1fRUoGs/MTE1CTOJAtCSjSWTwe7d9+dRbfcIXfG0pyG8+vDdYdinoOiEmBG5rF5TzVRtvDx+16av3kFLKnwJLZLW/+BZtXp9EImFwxrPlE+juqZsgmrFENi4nq58w+zrHKedfA12RlMTgDV03ItejJubOSzIm2rmklTWatoaNNHAFe3UUdhCmcOEMxtLbhkjSkLB4dXPEcYdQ5IZPAnsX3kicyrWSjnWEUu4cd7UQ0J95uD/2LR6NJml6d4EchsVx5n3i6qli/227jW6ANgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 06:20:43 +0000
Received: from MN2PR12MB4437.namprd12.prod.outlook.com
 ([fe80::9c66:21b0:b8e8:ea63]) by MN2PR12MB4437.namprd12.prod.outlook.com
 ([fe80::9c66:21b0:b8e8:ea63%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 06:20:43 +0000
Message-ID: <3d1658b5-e2ef-c2be-8c80-f5554faffcc3@nvidia.com>
Date:   Mon, 28 Mar 2022 11:50:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
References: <20220325072141.28597-1-mkumard@nvidia.com>
 <f35537de-6352-e6db-b4a6-17b1ab96deda@kernel.org>
 <32e425be-5d78-e1e0-6ec4-70ea21895e15@nvidia.com>
 <ca18fa50-f63b-8131-07a2-8c44daed9f26@kernel.org>
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <ca18fa50-f63b-8131-07a2-8c44daed9f26@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::20) To MN2PR12MB4437.namprd12.prod.outlook.com
 (2603:10b6:208:26f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77a9677f-8e6f-407f-f93d-08da10831678
X-MS-TrafficTypeDiagnostic: BL1PR12MB5224:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52248B8A3CBBC0D59E7C1B9FC11D9@BL1PR12MB5224.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXH1Ab1UW4wgmSYV1QGgtWKboGFgw8zD0WC4FvQUlh6dZn/HQOkEH3UWSL2BF1vbmjiiq8sryixI8rrFZ7NKLHC55YQ8OFfgqSi24OWOEMR7U3rauzmZnE0FdfXtfPlzdMA1tzCTGSe9JMMt8uroVs9GFfvP3a/KvX/XdUsTEkYSrRxhklzrQ7rs1er7O7jGq6ldd9NifiVdGoltchwHxNJQAKyo8XbO7cqbyMMoJSAxZlFHlMoeBzVOEK6PJ3cbkXKD1s0n482UEsfaUpNjPbMITL46XHsph629Y4alSuls1qtZbaAOUDcCWFkqKpYfn6z32me1FakBJEZmBmyaQZUGfyY0qLjxoA0k4HcHWPGpf2azqEFyhQVI8q5VosZ1zQyHBt3fBFWDNEckLGzMbo0MARrCRuclkgeD0VsVYI8eom3B9yHrtEmswg7NGNz+asnCIfoPBKy//1gvVjZxFWcW8x9u4e5cPhvK4bmo+iHkwE9VlLhkIpZfxZhSil+X4RR2MmyTXkFzDAhDMXqQGercJI0tNUEWcnoeWNQYIQsFBgkNw6F2Y0IiMTuk64RcUASbNd2pumkXBXBaBIXuNU3BsNgkn8ewh3ZVsSPCgH5O6ItdDEx1DPCloBdHwViTKEyNOEd3NgPRo2w8rm5JDEvNAw7SMkIBoVQ9AEYldDL4io8ohOKR/Q+n6hQ4LQmwyXtEsBMKsHqdwFjBvOZtmyo2/4SJ8Xiz7zmLnWSTpxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6486002)(2616005)(53546011)(6666004)(31686004)(4326008)(508600001)(107886003)(5660300002)(186003)(26005)(6512007)(38100700002)(36756003)(6506007)(66476007)(2906002)(66556008)(316002)(66946007)(31696002)(8936002)(8676002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW1Ndk1sdjl3bkRnUDRvaG9kTjdsMGt3U3lxR09VMEYwaVdFYnYyQWZhT2oz?=
 =?utf-8?B?VXNzcmZEbGYvY3JaOGZVTVI4N1JLUjJWYlJ6SHRDVDVhdzZaOC9KSUlETng1?=
 =?utf-8?B?T0dOSHkrQjNKL2RaT1BoajZwUWg1UVROUGJKQXBWRGdqU0hNYXNlNnUvZ3Z5?=
 =?utf-8?B?Vm01WUFXdlUyazBOdXRjWlZSdGIyUEhndHpMQnJwRUtiKzlvOGdoL3pnKzRD?=
 =?utf-8?B?d2J0YVJ1TXFhUW5sakxqNDRZNm1sNzg0UVdCWHo4R2ducWlNc3FhM3AwODBY?=
 =?utf-8?B?cEhGeTNQT0FjVmxwaUxEOHBMSS80bFpnMmRZS05ZMENUWjQrMGhBRXBLZXpy?=
 =?utf-8?B?WmtBZG1PS0g3L1BmcjRSTy9GN0xlSENNUnR3M2FvaHhtalNTVGxWOVVJdDM3?=
 =?utf-8?B?Z0NSSVBlUE1lTHQxcCtoY0FRWEQwR3FqRnljTzlrTjBuN1hGd2RESjNsbjMv?=
 =?utf-8?B?c3FQbEhWVFNpR1BiS1M3RnljalpxMW5MUkQ5cEpiY2cvTDJmTFpaZjZjSmky?=
 =?utf-8?B?bmlnUjR2M3pEQm1GVDllZWpxaTN2S1piaEt2eEMrMXNVRlQ4ckxIa2YxaGM1?=
 =?utf-8?B?NEh1SkoyZFAzUGVyRzBrV21IVm1aWk9ITEU3ZW95Q25PQS9uK0UzbkxXdklp?=
 =?utf-8?B?aWc3M1BNMTVhU0cvSVRlR1EwcmR2dDIvVE05cUJRTDlWR3NreDJvUFJWWWlq?=
 =?utf-8?B?M1JQMExpUnlvRzJQWHNOYnNBTUVON005MUJzeGZGQUordVo2NnFiZTQxM2Zz?=
 =?utf-8?B?YW9iK2J4VnkvVHIrU0k0Um1rY2NxV2xneWJnbTl5KzdPL3Jxb09BeUlDM05S?=
 =?utf-8?B?RmJoWk5SZCtqcURqaXlhV2dPNnRRK0hDTWRxNnNYWUxRSzJiME9uVmpEMnZp?=
 =?utf-8?B?ZmxHRllMdWtwWGxDWm5pM0krYTFTUkRYR1FUdVVtQUh3VE94eHNoS1NBdHRu?=
 =?utf-8?B?SmRWQ3Y4bmt3UjJUS2RlMEV2VDkzRzZrRFZlVU94VXp3NFJJQVpEbFhxZXlH?=
 =?utf-8?B?SER4SG93TDFjSUlPZEVVMkpyL3Q3bVNGamJueWY2bVJ5RW1zcE4xTEx2dmdt?=
 =?utf-8?B?ajVQUHNzOC8zQWc0cm9hZGxRZW1CeG9UTkJhdDNCVkNSVmJncU9saUlSdzdj?=
 =?utf-8?B?QlF0MTdGN3c4aktqc095d2FDcGFhZS9JMHBpVFNtSHRvUEQ2RkpNTGhWYlky?=
 =?utf-8?B?SWJpdE15T3pZZVFzSjNLRlVSS2YrVklSeVZLUUVxYnorNmFRQTMraG1lM2hM?=
 =?utf-8?B?ZkpBeS9PQ1VvcTk4SGpvVlpvSkRxRmtRTmMxT2dadjZYNEN2U2R6VVUzKy9r?=
 =?utf-8?B?SE9RTDhVSVZ3Yk1ZZXFwYnJzNlRCdFdYWUE4bHo2VUtkLzJ2T3BZTlFtREp1?=
 =?utf-8?B?SzQrYURmbG5OQ1dZM2FDU282cDhSc1V2Q0tmMTJTQ1dBUlM0bStlYkNqQWtr?=
 =?utf-8?B?di9KUGdNUkY3UEExdC9ZdjJBZFhzeXdHQ1VPeXJDOHlrNUJSK1VHeDZLNlpT?=
 =?utf-8?B?YkRRMUZtR3RXZU8xdktEOW1lWUNzc0JRNnhrdGIzRDJXMTZjOElrV1RjdkdT?=
 =?utf-8?B?ajhac0dleHN4TW8vSTkxd0tEVGhpQ2d6VWhHSnNWeE9sZlp4dWp1TXpIcXo4?=
 =?utf-8?B?K2ZPckd4Ny9iOHRtZ25aZUhjOE8zb042cnUzRDU0UFdMSzdNVlBSM2RhcXkr?=
 =?utf-8?B?ZTNDMEVHd1ZYUDJIOEdCTVlqVEJ6b3RUSjF6YjNlUmI2SC8yU3dRRzV3VEN2?=
 =?utf-8?B?bkw0TjRPdFIzK014dDROL1hEQ0dQaTFLVEVjd3M1RGM1VE51bDRaWS8zQmEz?=
 =?utf-8?B?MVZ6RC9vUFlQUUFwK24rTHRFY216aGw3YUJwb29KdjRtV1oxalE3ZG5oUlY4?=
 =?utf-8?B?bmlxMEo3dW9rRkFxTCszbUlTL2g1alFMSnpnV3FjUWtEcUxITk1DdTRnZ296?=
 =?utf-8?B?U0NaNjdNUGlXckR5NzBnU3JsNXJZVHRGb2dKaUtGWmZOdldjZkExeUM4eGJ6?=
 =?utf-8?B?QnNmZzJhZFlwdGpLVzJvS0RtaENtTEM2ejhwT3Q3RDBPRmxpTUlKc2dsdmZN?=
 =?utf-8?B?NlgxZmh5T0s0ZzRmNTcrZDVzSW5MSURXektXTWx2d0c2U2lNN3hEVWJvbHpu?=
 =?utf-8?B?UjJaQU5RYUttay9PV0dlOGh0S1R2bmtnVzBCYVBNQzIrRlJWeFk5clBXYTFW?=
 =?utf-8?B?akY2LzZlaTY0cU9MUU4yL3JXdEpDTlJUWjQ1TS9veDZSWEJ2clIveVV0OEZQ?=
 =?utf-8?B?ZFRlSGZmbFhqK2UzUGtOSmpycUN6Qm9EQTB6cjVpa0NoNVphREFIa1RjbGFM?=
 =?utf-8?B?Q0Robnpwd2ttd3lSSUs4dm1JQlhaZGhjR2xCYUgraC9ueGhJT0h1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a9677f-8e6f-407f-f93d-08da10831678
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:20:43.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6MFi2GkoqmEqXQZt1Ryk+L938ySYvGbZTWpdS/XK+8Xx4c0T+1a8yalRpDuRTyPtQuSlZJfk9WHYqgAN25QgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2022 3:12 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 25/03/2022 10:31, Mohan Kumar D wrote:
>> On 3/25/2022 12:56 PM, Krzysztof Kozlowski wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 25/03/2022 08:21, Mohan Kumar wrote:
>>>> Add iommus property for hda and enable the node for P3737 + P3701
>>>> platform.
>>>>
>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>>>> ---
>>>>    arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
>>>>    arch/arm64/boot/dts/nvidia/tegra234.dtsi                      | 1 +
>>>>    2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>>> index 34d6a01ee1c6..156d5d95fde7 100644
>>>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>>> @@ -1751,6 +1751,7 @@
>>>>
>>>>                 hda@3510000 {
>>>>                         nvidia,model = "NVIDIA Jetson AGX Orin HDA";
>>>> +                     status = "okay";
>>> Nodes are enabled by default. Why do you need this?
>> hda node status is set to "disabled" by default in soc dts file
>> tegra234.dtsi. The enable is controlled by platform specific dts files.
> Oh, surprise... why do you override nodes with full path? This is
> error-prone and makes any changes (like node name fixing) difficult.
> This should be overridden by label.
    I see similar method is followed for earlier boards too for hda and 
other nodes. As chance of changing the node name is most unlikely due to 
node name is closely tied to HW base address for a given chip. If still 
there is a concern will fix with label in next patch.
>
>
> Best regards,
> Krzysztof
