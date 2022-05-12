Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133365248D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351938AbiELJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351912AbiELJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:22:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B675E50453;
        Thu, 12 May 2022 02:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfJU0n/f32km24Ow/Mof/wgs27O9Z2T1pfJ8zHAWOIkg3T6nvjPbExfQjATZI+Z+PWdR0w/z2K114jrX0UR5btNFY89XmYdX5ByUESypzMmHl/LELOhS+SeM/uHm5vk4UMAjPmLTgJPKOF+eRUm6RekIOA/SiP7MB+wDpTmARUBlLtfGYvOVFKASa6L2u/ZmkcJcauDT6eIW5cX3H6HgRCndrEtKeD17rBLW5Tsh7OJihmw+gx96AnsyjCdbsYIIMXfFd0stcKz9SRgd38P/APLYs0jLD1UciAfyF0ZbQBXLHNEz5DBf+XNAfjzvVPaTbOu4mnPY7DxDjEegBGbYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy96Q0cBmXWOpDSvIfDnKss5PHqoaN3rI54/D2Z5NOM=;
 b=B+aRQcAbx6MkXBQz2CF1z+vhSwi0c0FqFikRbQr0Jx0NXDnRCJ/kGx5ClAOXwII8UrtFKslD8FGW86ehgdQy0CYOLWbzELoNeJTysz8FLT/BLEokIwy0cjcCr9V6auJMdRu1BYPA+MUoOwkMr6oJIQN6MPcD7TsmRuNh2qeSl/fBQVdLy0oG0Q++lxHY6Glg/VTt6HZ37DtQIfUciEoLbihxpFHPfoMWbNQCuouN8b1EoQIeNID0LDfpRX5lwZeSlDAy6JORECA06vLxXHFAyzXLpSBjUgeM9Kr3BLunewSrx8YA87Lnwo9bF1GVeqQf6ymFqBSdPej7jhEvQdOFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy96Q0cBmXWOpDSvIfDnKss5PHqoaN3rI54/D2Z5NOM=;
 b=bfDrSHMlorWvDc5+BggfVlfDnIoSZUSUbLleb9kzNvMiNezJEUc/id9cWynS0Vxkmde2WXlNJt9Ss1HMVHqyDLTiGGISlCRc4n8n+w/UXa1TS+0+bH8rxVECfQQIigPv0YRzHMZFvSvW3kAw49anfi4HHzwEHtDhDGwAxnqfAyFJ2hmrE5Tlmdw1KSLcXHeq+/jfFWunAesQqooETJJy7Tdie1oqmCFEhdmKGde72ISIJLpgCodDXEWWB0bLkCA8zup68j/g4DPwo0ajdUsUpVGlKkEJ+Ry/17ULEGJZLzV4uziOuxi83grj2twoMrYuy3cico0oR4EdYMgrrmEiZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Thu, 12 May 2022 09:21:56 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%4]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 09:21:56 +0000
Message-ID: <2e082196-1566-c18d-3793-028f07c1926c@nvidia.com>
Date:   Thu, 12 May 2022 10:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/2] Add GPCDMA support for Tegra234
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Akhil R <akhilrajeev@nvidia.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220512090052.47840-1-akhilrajeev@nvidia.com>
 <2e2cac21-1071-546b-7091-8be26860f5f0@nvidia.com>
In-Reply-To: <2e2cac21-1071-546b-7091-8be26860f5f0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::26) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 561b0895-0e36-4e85-f3c6-08da33f8dbbc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4232:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB423221461FAEF963E8D3918ED9CB9@CH2PR12MB4232.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NT9rz/5ysxuhZNztr6Z7ej3bLlyM9uebM8sI/Sa9Cnl8AohHZbGygJdbx4w2kayunCW8vLYn2mG2o3aT9kq33RMW2ORFG2ld/kdz7OaxEDW4yl1gZwpJn441ojyc5Z9PNZ/m1IrgD98qfv8YNdxRIeOkwoT9IIrN2Iw936E/bb9UJ9aRYl+jiIIe5CbjTzevltthvFy/fUKJxJPd0ACAuyc5jDb1QI1Wz9VoGlPhNKE8Oe+SW+mhgsA3hBhGtk3tZZn+LWZnPYHcvALewq3AEf+LuyErH5uSzp5jVEyLxpc4pBDE2AzrwlXYGbgjNi9LHjrognYsG1JFOyfiMLjXna7V2L/l4HBMR/HEvdIPfATNUBs1BYp0R6uOf0oYdu97MEs8n+hFSsbe8kZbjKvtTxcJaNGQ3oS9KA7R+HP9Rg076vBI3W3fCZ6EBZ70aqc9s/WptA/QM+YRwVAs+c7sJPr32wysWS+cpcNLaPPFQoyBl6Ht12Bi/5YGVgAytUAibZWWTN31RUdKNtBR+fAhcAOR5l8hHgpFuzVfm63HgFw6YgVIQZw/vUC81l903tOIByv/qmDCsa4JebZDAfhPdGbcmBBgl5C5SzawQbF6X+QbBPZBPw4zBsswBQxzAo0GwsLYSbgAyNw51Qmg2P8oqjaMGImEQINT8ZCgtKmGAZGxR83QBlaEfQGS+v8jDWBG5bgVHlzmd0Jy6bBsRj10sGB0OuO0+v6pXHgj4j19FbPTzbPxD6qwQvdRy4mwIsKU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(4744005)(8936002)(38100700002)(66946007)(8676002)(31696002)(5660300002)(66476007)(66556008)(6506007)(55236004)(53546011)(186003)(6512007)(2616005)(26005)(6486002)(508600001)(6666004)(31686004)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk94SHYrMTBPUXNXYzIvdWJFcGtUWGM1UVN0bnRrQWJ6dEk5Yng2VlBveHpv?=
 =?utf-8?B?b1BYcVRybk43eTk1a290aWFQQ2g0ekk3Ym55U1M0ZlY3TWhESG9aMCsydWUx?=
 =?utf-8?B?RWhXa2J1d01VRzVQWEtIcTE3dTdlcGQxKzZISUw5WnVQRFRkQ1FnV1R6RHVU?=
 =?utf-8?B?ZXlxSkI0U0NrV1dmRmhVSWJOT0psdFpwVEJUbkxpOUw2QmVGemtYWFFyQTIy?=
 =?utf-8?B?b1UrVkhLQmhkcU9kVjVPc2VHV21nQ2VyaFU5Z00wN2JJLzh2cUZHeG96Ym13?=
 =?utf-8?B?cmxnYUVPN3pEVzVRejE2REY3U2ludjFDMWN0UmFUcERjU280cDlFUExnMmlw?=
 =?utf-8?B?LzMrMCtIYUhiaEM2My8rYnFVNVV4MmRGSE9LN2N0amVlNStleHhyVWJpdXVH?=
 =?utf-8?B?UUJWTzJCdkJYRFZ1RGkxSmhuTk5qODRGYXpwK2kvK1A1VndBcUlqdTN4UEFX?=
 =?utf-8?B?aDZuWDNGeEZIL2ZkTzhsZ1FqRFJqRWpqMFlLUDhrTm5mTFFKeFhHK0diZGZI?=
 =?utf-8?B?L0FYMzhXSGYwRzRUMUZqcXY1Q1UwZWlZOFlGc2NnaHNmS05HcWliOFNZVkY3?=
 =?utf-8?B?SVVYclczdnU2RGNYcUh2c1lGNkxpd2RKaGw4UjNkUGx1Y2xqNktUQkxRZ0Qw?=
 =?utf-8?B?bXY2V1hUNVd0TVFpNjJCTEtETUMvYm1SSEJYZE81M01mUm56M1ZMMXRrVWVN?=
 =?utf-8?B?cENKTzBNNnkwWEJxSjRwYStZY0JaVVBLZEhuMU43eHhDNkVFaEs4ampkaEwy?=
 =?utf-8?B?Z1orZGNZNlRHSXhBQnpjNHZSUGd5bVVUWURzQzdVNk9NbXU0a2pDNEU3cndM?=
 =?utf-8?B?T09RaENScC9ZWUF0T1pSWVRMNTdkNnR5YzN5TzcrTVJObVI2L0pmZnNPbkZz?=
 =?utf-8?B?OUtxZ21HVHFMbU1xVjJhWmNsZjJabkFNa09zaUVkb2pLd3dodWhRMTF1cm45?=
 =?utf-8?B?ZGFpc1RTdnF1UUphdmV5U1pscDFIVVN4cm5KWlJZTUR0anRHOXd1MGdoR05q?=
 =?utf-8?B?MTIzQUpHdUxqU1NHOVQxeFFPK1RpZUtNSk05NFpZMk9mSEJMSkhqNGdhamxk?=
 =?utf-8?B?NkhFaG5NT2lDYlk3SkZFc3V1aDFwQjR1YTg2WjVaZFcyTEpFYlRIRmpDdDNK?=
 =?utf-8?B?Y3puUjFiK0dvLzBkalAxRmQ5QlRUd3lSSDJpcUl0Qkl1L3BVM1UzMHI5UUJX?=
 =?utf-8?B?dmREZVNhTDZrUDJNWEh2a2pSOXcwNkx3bXl4ZXVjcU1xb2Q0OXhvb015MzYw?=
 =?utf-8?B?K0NFVlJnWjNIYkR2NXdhZndwN0pjOFVIVGI4aXFsZm9EVWV0Zkw1UkkveGhO?=
 =?utf-8?B?ZmtGemNJNHZiN1pNTE5rVkJuZC9GcUloWTl2eEY1V2dvam1nbVhqRUdSQUxu?=
 =?utf-8?B?VDBBVGg5aGx3V1dlS0JhbGwwMmM1ZEFNRzVjcEMzWmNYb2R4U3NnYTNlOHNZ?=
 =?utf-8?B?ZzF5WWxGclVmY0Vhb3ZxMG1Gb1RPUFM1UHJwaEduRjhocGczMGlTenVzWnNk?=
 =?utf-8?B?VWlCSlY2SWlxQWt4dkV2MitkcUxZSUlwNjQwNWtxcDI2Zm5JSitkV1M0dmpE?=
 =?utf-8?B?N1loazA4VURQVnBGQndPclEwOWZ6cHVHam4yaVBtV1NOMHA4b3VCOUU2dzJ5?=
 =?utf-8?B?YUEyUmJWbVZlbzJuOGZaL0l1T2ZaNVhEbk9CendaS1RoemxLbnhYeFF4QjlL?=
 =?utf-8?B?enhhcTdqaElmdWlnUmkrL1dmUXBQcTRITzVvdkRRZWJacjJCVE50WkloYnFP?=
 =?utf-8?B?b3grUXVYUzhYclk5a2pxSkNIeHVacnBDUUZsVCsycmpDeW0yMklqRWxvWUxP?=
 =?utf-8?B?enpyUXM4NWVHeEZSRFovcGozbU9mK0QrUXQ0WG45a0x6WTFjZmJiQ0k4NDRD?=
 =?utf-8?B?M1JsRm8vV1IxaWQ1bTQvZm56bmhsaDNtSUJWQnJFYm1iTGZtaVpoR21zVFVK?=
 =?utf-8?B?c25ta0FVdUp2SkpENjVHQWNZNHJyUTh3UHlNczRsbGxFZ2lvanpiNDFPMisw?=
 =?utf-8?B?MGtpMW5oWUJVdXFnSCtGbXpLeGZuNDZaWEdCWFRMQ20ydWFYOE1ET0szeHBV?=
 =?utf-8?B?N1hzcWFSbGlrRzJ1U05IU3U1UWVYcmRFTklNekwzRmw1Y090QnhJOStvTmxt?=
 =?utf-8?B?V2tWbTB3bDV1dm9yd21WSUNYaU5rZVA3d3NMVnpIcDR2RXBHekVmbFVIUkJh?=
 =?utf-8?B?SWN4N01mazJNZU1HMkw0dE9SKzV2Zmt1N1duSCtSc1VxV25TdEs4YUhYcTdq?=
 =?utf-8?B?Z2F4YzJXcmFWKzYwVi9uS2Y2ejVXUFZDakJYVHlydHRwMUI0elpMK1BaaDUw?=
 =?utf-8?B?YXpKdFUyR21jMnU2Q3VuU0VNQWJKT0FZU2xpaTMzVXh4dkMwVWMwdjg3cW5D?=
 =?utf-8?Q?hxUq4HyVbizb/RiE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561b0895-0e36-4e85-f3c6-08da33f8dbbc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 09:21:56.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6qAMkpUlxYkvPD/DV52NzhcC7Da9AUrLY50qRMaQKPKWErCF27F5ths9k8pN0miH8MsQXlnMC3UvTs1X613nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/05/2022 10:09, Jon Hunter wrote:
> 
> 
> On 12/05/2022 10:00, Akhil R wrote:
>> Add headers and device tree node to support GPCDMA in Tegra234
>>
>> Akhil R (2):
>>    dt-bindings: Add headers for Tegra234 GPCDMA
>>    arm64: tegra: Add Tegra234 GPCDMA device tree node
>>
>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 43 ++++++++++++++++++++++
>>   include/dt-bindings/memory/tegra234-mc.h   |  1 +
>>   include/dt-bindings/reset/tegra234-reset.h |  1 +
>>   3 files changed, 45 insertions(+)
>>
> 
> This should be V2 right? Otherwise looks good to me.

Ah sorry, I forgot the initial version you sent me was not published to 
the external mailing list so this is V1.

Jon

-- 
nvpublic
