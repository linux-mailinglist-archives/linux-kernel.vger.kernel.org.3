Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE954F71A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiDGBoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiDGBob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:44:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB1E9CB3;
        Wed,  6 Apr 2022 18:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiglgNT7j7aRTiPqkEZ9tJ8rPBJUEJFgMFfAOjwL/R/KFHA4yhqSNM+RueTkyBddW0GZj2kNs2ZrLhGPOvsLDhJYWmfLWBElM0LH6mwUojLSW+fd9NvmhcXtMBX9a4FT9iNgb4gdhYrx/d7yBLtk2OxbKj/8rzLm3qiE5SQ4d2OlVe7vp0ihFrg+ZqJ6dUmj4quhZ237GvzAzIov6a0NQ/9Zq0S3/kqL04p8M5wx6ftkZEeB2E/E56hYRAAgFtpta33tegHoaVb/inb/3iIZgOlw1NIgzjQikEicA88EZ2YKCQ5JguGgXL96yfgQYtqKOd3+99BR6eYz5QOXjgUmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkMLMyR1jltJdA8lEbIf8SlcEo+FnDGxjqoZxM7breA=;
 b=V222wQ5fqRQen4MD/f/QibR/O6MuPliUW/BDFCnWP1EUeUIMdgNZ5q6eGh//+zQHajR1W3deQ3CxFQohOfLrCzq3sfDPRKmeI5PIfgUVsekSnT3fzukUAHHYDQf5rNc8pu/sbG+nS+kKu0VHO+xDCI+yw9b3yKpUvKRwcTvvZvxmCInoZb6eR0/Za4qcSql5CnDgoZswj3tCcl/uQYsSNyXuJj/YLZQMTrgOVQzgwGE9mPwMISjAk8QNcVFzvGPyYyg+cX0FbKxvsgLHIxedB8cdDR3CuGbV4vbFeut1RNfkKvpBGNEOHQzbgMDFQ/3XoS1mnAxZPPebBkM6XF67YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkMLMyR1jltJdA8lEbIf8SlcEo+FnDGxjqoZxM7breA=;
 b=N5A/CAgVVfU5Gvymv3gYcnKibAoqiyMsZ57BsoETp1q/TPN/u2OmsDPsM5z4Bc01gCaj8MYz3A3LaFjPyMKuQINkIT6i3vevCaPIp9CoRZv+mNprJdsPjXYcOWgFt/M2FLy9OhHqhrLb4VKVHNjzysn7yi3Sf3ovd0NS7ROXZAtibnOuBMNv/eOTiyyZqlPWN53Rdxym92qocxypFNeT+i1EMPCatqhrwjwwsQeHJUTO2qaBqBLjHqsiM7iG0SLxdzqW0GKShsozI4YZAANTlaV/z+88u32UtkbM1Ts4uMcRJozcuNY9dDmXnbokigxFNCTmzM7ro/u8c6PgJNysyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 01:40:26 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c%7]) with mapi id 15.20.5144.021; Thu, 7 Apr 2022
 01:40:26 +0000
Message-ID: <35e1a5da-a35a-cbaa-f70b-44c2f98c63ac@nvidia.com>
Date:   Wed, 6 Apr 2022 18:40:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 04/11] dt-bindings: Add HTE bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        smangipudi@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        warthog618@gmail.com, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <20220329054521.14420-5-dipenp@nvidia.com>
 <YkOVgRBtXX0k9zr1@robh.at.kernel.org>
 <3b0f3430-bc1c-26df-c93f-517ba395d9e3@nvidia.com>
 <YkRtzJjHQvmYNlK8@robh.at.kernel.org>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <YkRtzJjHQvmYNlK8@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::39) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56cb9a6e-d3b0-46df-e6c1-08da183796ab
X-MS-TrafficTypeDiagnostic: DS7PR12MB5717:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB571740B699A77DC0930ADD77AEE69@DS7PR12MB5717.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SuZU0scXcyNnXQLabe5VzrBb/bJYOCzqa1XP+y3QSdJkyx9F/A5LYLhJuwsQBpPG5cpVBPKadyXtqpq0lKfn7ph3auGaehEYqC0FpqUUIRo8sldsWQpaFoKrK5jldCDenn1zqVJzPcqfakKYl1EjMFZcrGPv9M1/bzeDd2PbxdO4Wh+53khMqdUTxpv94X4Fcd6F5OpvOsvQNiRi+Ms0fJYOQ6yOwbFXtxUURHpBFd4Tt/ZchdzyIAMa+FUBtzp1WhzVuZTGXMIlssuelhi1vnrpYZwaBwYE26RC3LLYJmSYjvQ6im9lZESrvP7NNOSknOmFIXa6jXE7fDShxjUwOWsVJ9j4oBltmTxg6n2aj3tHimX7yitCaVHd4QoxYaNylpS5FgUKwyPx4UL144AHBZOGduqM6RuEf586amPIF5XXD9ZQtMMXSny0KqbtNFWwP/2jOPwozB3aV4+utBop6RYGNuxzS3UWaGRUYENfQmYSmoAIchIb6yJNpWvVJG12icOWwI/+4JhSATl19A53trh7XW7zJbtAFdbDvAMfmU2u6o3vGzM4sK6SVrm5uGKDzhlV/1RL68Yr69Z9bX7jaoO6lhTkDv1sQkVb2foeHn/qZpY7Idaoijl8sBuUs0bW1+VTCl+xJ1zu9Ge9Zu3DSd1L41kZ10cZE4yX85HDVzO/jepUMrURkl0fuEfN5aZgUtz5qa+L+cjgKUj2e5nUyZHD6AYYfhzUJ9O4JnSdDpQvhMY+oA/2827ad4QAn+ID7c7bs5YbjrCs0HmCCoHqiW3EHDJPx7dXNC8cnbTdtu/Vxl3EqtInTMPagXlClEhj82onF68ud2qg+aDTuS82ZAlWuhMS+nMl//eiop0K21QUQEvUtyiQj8hqXg3fPeL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(45080400002)(6916009)(2616005)(6666004)(86362001)(31696002)(38100700002)(26005)(31686004)(36756003)(186003)(966005)(2906002)(6486002)(508600001)(5660300002)(4326008)(53546011)(8676002)(66556008)(66476007)(6512007)(83380400001)(8936002)(66946007)(7416002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGk1QnJ5bjNWWWd6OXQ3eitYWUo4MjFMRkREenFsZHlndnhwT3ArL25rK3Q5?=
 =?utf-8?B?eGtzRWJjdGs3Vno5TURLaURUY1ZhTTdkV0YyYXBiVDl5S1ZWOGcrY3lySVdG?=
 =?utf-8?B?ME1OMFV0emJkRXVUbEQvRGtDM0t3LzlxTXNOaVNUUU5vNTEyV1QrZG5PdXhH?=
 =?utf-8?B?eTdnK0g5d1ZqSUNhMFlsSjd5KzNCTzErMklkUXo4TWRvV1FEb2NNMm14SkVR?=
 =?utf-8?B?ZGxGeXB0WUF3TE10cnN1V0hKRC9yeFJtcHhwQVNuaU5lL2MzNnNYRnNrbjhZ?=
 =?utf-8?B?d05oMm1tbFUyUjNuZ0tGWWs5OEllWEtoMEhtbWJxelBDZlF5b3hpd2ZrUGgx?=
 =?utf-8?B?MzZwb0Z0aHRXM0NzTlg2SC9GeEtiWG5Ua2FlQ2x4bTh6a2owYmQva1JKT0dr?=
 =?utf-8?B?Yks4Y1BtMnppU216RlVYMWtHUTlGZVh1ZVRvOWNvMHFpb0NXa3RWNlBFUlRh?=
 =?utf-8?B?OGxLZmUwbEZ2VGhHdnNNOHFhNTVjNU0xVEl4ZHg3NUZOM3I2UE1GSTRhRXIy?=
 =?utf-8?B?WlRCdzVMN01UR3lHbWZZci9jZkdpL3BaWEtjR3J2U2ltNnBjcDUyZTF6TTFP?=
 =?utf-8?B?VmVxSldiL04vK3BuS2tQMUw4MnRja2V6bjBhM0NmSG55dG9iTWdTREJ4NTZp?=
 =?utf-8?B?RnZOaU5HZi9CM3hwSjFRZnhlV0xtNlNOMUV4djFkam5jdGZqVEpRZk9LSmtE?=
 =?utf-8?B?OFpuTHdWVWZEbHE4NnFNbWdGMVcyNFo2dExKQlZrc0x2OGV6SmFueGlXTE1C?=
 =?utf-8?B?QnFqRDVObGlmN291Ym42Sk9KczBxOVJML0VjM1R2Z3laYWN6NFRrVWZKSnpR?=
 =?utf-8?B?MnQxMVVFS2ZTN082dGtmSFZaelZKUWJseVJrY044Umd0SWdqTENRN1BuTDB6?=
 =?utf-8?B?c2daMW9sRDZxeW5qb05aNXBpd1VXb3hhWWZJd25DYWxkMkVqRjRnOGFvYjhJ?=
 =?utf-8?B?VzNESjNNWUFoa282MnRGL01WUnN2ekpIbmVGV1A1NlB2QlhKZUNXSjg0czV5?=
 =?utf-8?B?MFJUZytHdkNsMmZ5Y1IxS1VNQjg1aExYQTAvN2o0UW1hTldybzZUQmdiWlFi?=
 =?utf-8?B?cDZRbUxYSWFhMnZ5OFBicTVnVTQ4S2tPbmJIS040MjVxRlJBR0JkSjE5TElV?=
 =?utf-8?B?dCticTVMWTYyU3ZSOUd4OW54Zy85aDErL3AyRnA1eS9DNVF4eHBVM3VSVC9z?=
 =?utf-8?B?TklSa2dIMVBMNU1GelJlczhOOGRCZ0FrOGVOODgrNDJVTjFUMUhsWG01ODVi?=
 =?utf-8?B?Ym5TWnBrYWRrVUdDT09iMnA2bW5NQjdhVVkvTDAxcld0R3dnVDZ2MWkzNUVl?=
 =?utf-8?B?VU1MSVRBR1dlYTg2ZC9sNlRmODBvc0VtdnlkWGJpcWhRQkNKZndmVHcyRWJy?=
 =?utf-8?B?N3UrME0rQzJoTU5YNnZVZjJIK0tqanFJaHZxamtGZ3lJeHNtT0tGMmUwS3BV?=
 =?utf-8?B?bFhIT0VNMjVEb29QTjBwUGc4TXF3NFozVW96OEZWbVB0ME9kOHhnK1FyQkFO?=
 =?utf-8?B?RmNoZlM1WllaVnZuTEhYaDZSUG9GY0JXSzMzUXNKQStyODBIRWlNZnFRcTd4?=
 =?utf-8?B?WGlrcFArQklzUmFMaC9McG5qcUVqNGFaTHN5d3ZRaGhYWkhNV0N4U1VNRzZh?=
 =?utf-8?B?czU4cGRRTE1td1V1SU1teFlIUzFOK3NacDYvbGJua0x5ZVdyZURxL1FUUWdr?=
 =?utf-8?B?blU3RTQycFZLUWlFUWFlSUREdHA0RWdkVUtlb3JXaVc2K0lNWHpsQ1pNSGFW?=
 =?utf-8?B?MVh6OHgzTDJaVm5YcXpnU2JvUmVnYitNZjBRbjRCbmx2bzBGdGx5QVE5bE1C?=
 =?utf-8?B?K0Uyek1hNHhCbVpzK0FJdzVLTSs0MUJWNXlRQndmZHNVY3Q0WWlaQUY4RmlH?=
 =?utf-8?B?L0ZtdHkwMTI3ZWFWYWRORFhpaXEvTXI0MVJ3UDZwZjRUa3EwcVRqZ01jVDZy?=
 =?utf-8?B?Z1l2T2RDKzhLYnVSSDJQQWlValFKa2c1M2t3bklXM1NlOVFqMkRmUFQ4VnNR?=
 =?utf-8?B?eWdDS0d0c25kZDBQc2MyRm5vYUhvTExPM0piMlEwUXdFSzFMVXM1c3VDRG50?=
 =?utf-8?B?NDhLZ0VqckEzOFA2aFF6RFZGWWQwRmRIeFNNZ1BLdWRkbWRmeHhVVkQxNisx?=
 =?utf-8?B?RENPcWdzVlJHbUZQVzJGZGNMZ3MwTW5vdTk0S0dDQ1NkbW1nNThHS00wamQy?=
 =?utf-8?B?MUFnOFVMOXVYd2pjaExzNTEzWHp4MDFQRVJHSGREKzhqMjJKTloyZzcyTHZU?=
 =?utf-8?B?S3QrcEpNWDcydUxWRzVPMHo3Y1lEUi9ieWVXaktscVkzWC82ODlLN2JVWHNu?=
 =?utf-8?B?dGtyakUzUUhoRytYMWJUeEk2aUZsbmxleUU4dGUxRS9tTDI4WnZpUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cb9a6e-d3b0-46df-e6c1-08da183796ab
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 01:40:25.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzxybCjJ4Tp/EPkzIij7mTdbZpGlTbfu24fjv16jY/vI8x9FJzik0ktSoxGKKAcgTi83XtTfxt/RqVXblxNV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/22 7:48 AM, Rob Herring wrote:
> On Tue, Mar 29, 2022 at 05:19:10PM -0700, Dipen Patel wrote:
>> Hi,
>>
>> On 3/29/22 4:25 PM, Rob Herring wrote:
>>> On Mon, Mar 28, 2022 at 10:45:14PM -0700, Dipen Patel wrote:
>>>> Introduces HTE devicetree binding details for the HTE subsystem. It
>>>> includes examples for the consumers, binding details for the providers
>>>> and specific binding details for the Tegra194 based HTE providers.
>>>>
>>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>> ---
>>>> Changes in v2:
>>>> - Replace hte with hardware-timestamp for property names
>>>> - Renamed file
>>>> - Removed example from the common dt binding file.
>>>>
>>>> Changes in v3:
>>>> - Addressed grammatical errors.
>>>> - Removed double plural from the respective properties.
>>>> - Added dual license.
>>>> - Prefixed "nvidia" in nvidia specific properties.
>>>>
>>>> Changes in v4:
>>>> - Corrected make dt_binding_check error.
>>>>
>>>> Changes in v5:
>>>> - Addressed review comments.
>>>>
>>>>  .../hte/hardware-timestamps-common.yaml       | 29 +++++++
>>>>  .../devicetree/bindings/hte/hte-consumer.yaml | 43 ++++++++++
>>>>  .../bindings/hte/nvidia,tegra194-hte.yaml     | 82 +++++++++++++++++++
>>>>  3 files changed, 154 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>>>>  create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
>>>>  create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>>>> new file mode 100644
>>>> index 000000000000..e8a69ceccd56
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>>>> @@ -0,0 +1,29 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fhte%2Fhardware-timestamps-common.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C0e094f6ae7b642c970f308da125c64d4%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637842485301457320%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=4UcTV375zNF44HeIpQcDV%2Bp3VJXdtjomZYGWWsUJf%2FA%3D&amp;reserved=0
>>>> +$schema: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C0e094f6ae7b642c970f308da125c64d4%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637842485301457320%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=fGoLuKpVFMNOsh%2BbJ6dLhpky63Y6zQ1oNkiOHDQ%2Bud0%3D&amp;reserved=0
>>>> +
>>>> +title: Hardware timestamp providers
>>>> +
>>>> +maintainers:
>>>> +  - Dipen Patel <dipenp@nvidia.com>
>>>> +
>>>> +description:
>>>> +  Some devices/SoCs have hardware time stamping engines which can use hardware
>>>> +  means to timestamp entity in realtime. The entity could be anything from
>>>> +  GPIOs, IRQs, Bus and so on. The hardware timestamp engine (HTE) present
>>>> +  itself as a provider with the bindings described in this document.
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "^hardware-timestamp(@.*|-[0-9a-f])?$"
>>>> +
>>>> +  "#hardware-timestamp-cells":
>>>> +    description:
>>>> +      Number of cells in a HTE specifier.
>>>> +
>>>> +required:
>>>> +  - "#hardware-timestamp-cells"
>>>> +
>>>> +additionalProperties: true
>>>> diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
>>>> new file mode 100644
>>>> index 000000000000..be69f63aa8c3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
>>>> @@ -0,0 +1,43 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fhte%2Fhte-consumer.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C0e094f6ae7b642c970f308da125c64d4%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637842485301457320%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=E3fspCvDDE5%2F6opK%2FdtpaY5%2FscsPURvDV7O7%2B%2FdbtEQ%3D&amp;reserved=0
>>>> +$schema: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C0e094f6ae7b642c970f308da125c64d4%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637842485301457320%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=fGoLuKpVFMNOsh%2BbJ6dLhpky63Y6zQ1oNkiOHDQ%2Bud0%3D&amp;reserved=0
>>>> +
>>>> +title: HTE Consumer Device Tree Bindings
>>>> +
>>>> +maintainers:
>>>> +  - Dipen Patel <dipenp@nvidia.com>
>>>> +
>>>> +select: true
>>>> +
>>>> +description:
>>>> +  HTE properties should be named "hardware-timestamps". The exact meaning of
>>>> +  each hardware-timestamps property must be documented in the device tree
>>> The meaning of the cells needs to be documented. You are documenting the 
>>> meaning of 'hardware-timestamps' here.
>> This is for the consumer side, meaning of the cells will be documented in the provider
>>
>> binding document.
> Right cells are opaque to the consumer. What bothered me is 
> hardware-timestamps already has an 'exact meaning'. You need to me more 
> exact as to what should be documented. We don't want what 
> 'hardware-timestamps' is described again. What needs to be documented is 
> how many entries, what each entry is (for the consumer), and the order.
>
>
>>>> +  binding for each device. An optional property "hardware-timestamp-names" may
>>>> +  contain a list of strings to label each of the HTE devices listed in the
>>>> +  "hardware-timestamps" property.
>>>> +
>>>> +properties:
>>>> +  hardware-timestamps:
>>> I'm wondering if we should just drop 'hardware'. What other kind of 
>>> timestamps are we going to have in DT? software-timestamps? No.
>> I believe this makes it explicit and leaves no room for second guess. If
>>
>> only timestamps, ambiguity then will be which timestamp it is i.e. through hardware
>>
>> engine, pps, ptp and so on...
> Those aren't hardware timestamps, too? If those needed a similar 
> binding, couldn't they use this binding? PTP at least is sometimes an 
> separate, external chip IIRC.

I am fine with this idea of dropping "hardware" prefix, will update the patch.

I believe this will be applicable to all other properties for example hardware-timestamp-cell

as well, right?

>
> Rob
