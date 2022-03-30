Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CB4EB767
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbiC3AU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC3AU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:20:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C261B53EA;
        Tue, 29 Mar 2022 17:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB6QMX8jEXMVNLMXVGcCvW9xLpPaUr4MR8a/zzrFFttcC/YQyIGUXPY7bt4FfnRIfdHC6lWIG6RL6JIzVwf0Ijf7uCVq0IHKJdCLIEh86iAWbKNFqE3D1uCGzI9JB799IhRzhZUP2FbEDH8Yy/9pivi1zl10vMj2xKgRc24zjik3znzTgQsCLgfkhWVCQSkNUW9mknSiN3uRt42W0HuRItPAZiAPKBePGwI2RdyDW9+dVgoNkpp3n2oA2K44J6MXX1YH/fhgmEH6saJCzaSAESOrMktDCJTU3cFqIHdn3zhWldDB8MGrkPbK9rfrKCGZ9ld5emthJUi4HUdX1sqJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBjTgPbxvtsDU/4JexbBZuUD2AJk939MkzlM5YzHcS8=;
 b=ERmWNGNE1AQbzYSAH5Sh2fFdI+/COg+TzSNYI3zyLExAehzP4tNT1To33zewirB1jTz+1mYvwZiCMRhX0bWFHHUqs/KV3ngKFDuliVnsrurwovncuvb60V0Vp7iKHJ/9sTmT0JeIhqwAVaSgmZN6uZplGIcOniOdirGckCnFi1tSSkTXOU/V+yszs29mBPCMulwUlwCx1VT7IZQ3pAFTxaOclELNw6zXh+WJtsjAatRhYJ3C5C6QIEesjyf72XD0GXBtGXBN+MbNhyQ7VqZvUNzs205rL8lm3MNk69NXJutINfs1VaoOB6lPYbF7lBXU78jTqhKKzEtuMT9JGibx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBjTgPbxvtsDU/4JexbBZuUD2AJk939MkzlM5YzHcS8=;
 b=DStm5JwN80qs/KMKjI0uKEjFdJ0Uh0spZfICu32NLLzQqqICu0kzjvvflHgrsQiPb+hhNBiJ/1STSwqRYuzfk3y+jgccJsAAj47pDQiGuMKA/uNb1QlZwE9kD3LT9BHwVcDMaylllX9YK4W7ZU7okDU9gLFn0LAuL1VI0izAD1LNhA+AAuDbzCNqFB3/yPRdZTJf/dvM064jdKkTywjQH1TNXpRov59vVrkBMcheLExWM6VkxgMUdW/+mfKGA3I9BYRh8Ema0IelDOFvkwPTZWrNw8EnMYrvxqkyFbgUPiY1gzGvW7X/jrtlAK7e7A6Kjf+o4mft2F0PhfrQi8Tr2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 00:19:08 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b%6]) with mapi id 15.20.5123.019; Wed, 30 Mar 2022
 00:19:08 +0000
Message-ID: <3b0f3430-bc1c-26df-c93f-517ba395d9e3@nvidia.com>
Date:   Tue, 29 Mar 2022 17:19:10 -0700
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
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <YkOVgRBtXX0k9zr1@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adab102-51d9-4358-dfc8-08da11e2e85a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4472:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4472A2E31DE0349C45CB9C7CAE1F9@MN2PR12MB4472.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HsDm7vnNxjsXlRXAFIVOwfomdqfsaRzg1YrDG2m6IcW/t1cEnO1jKHKlnWyasBFGUbHQVE+6Om1pK3y3lDKr7bxyoNw7dMO//gtSXR3ms5D02hsptp9+JHmbLPdTGQVWgHQ68pHB9KY/LkUskReFFtYVf3Z+Uabq4uLuXmweJE2/K4mD4/IL/fFJFBu69BKqzrNoZlLmJUIWupFuh5vdTL/c0TplOGcs4i0HNorTF7JegMIf0FTAbKmba8eLOBBgi2Tpl7PhJK7NvYIDrCXG6z+fdq6v7gphBOTLfhzNzIzJTYXFkJOc365iqUx/RAYv9JC62h7STz4felwzNdeDC2kKIKqtfxxzWuAjbL+f5SRISGReoMcotHBS/tYP6FJ9ORHatL9FvzOleueWr1Z3F8dh4/D4cbFWfVMNCUt4ObxQmsFOVn2veBinzOLBlkdAOxeCq7j+OshZrPXNbf5iYnLR0zqe+RN/i+TnILT4snfquHmKRlIYcN+xdJahDVFp+e4Hn17+ECwYtXnaLrNPuJWMqTF0B9xTu3o52WDYKBzHcQobla3o5H79AERoxFD8wamWIWGKX/TeF9/XT3y8gZUgzx1S2oOHf0IbCERs5EpVqa0y1vadyI9NoIaKyY4XBbRT4eVuHAtEdtGKj9Lb3HV0NiVFSUeaei6aj1uFY9ArA34+SsBW9bZtWWdn+lvilDQSOHS1TodnbKJwSYSHcjI6MZ5zy9qLs+HriLMyDhQWtB0m2ZOFiLQyXWRTW8GdLSncByY7QQzBKQ2wSK2UA0VR3ETxCGynvu6qvah8E+8NlRiQ90823WDfEOtrj1xSvMU30T22fsXJkeRKf2FsL08X0wWwWlWR9gMk9RRnTeBcJpHZwv5wvJ1Hks5EwZo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(31696002)(83380400001)(66476007)(316002)(31686004)(66556008)(66946007)(966005)(6916009)(86362001)(508600001)(36756003)(6486002)(2906002)(38100700002)(6666004)(6512007)(7416002)(5660300002)(26005)(186003)(2616005)(45080400002)(8936002)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBVbnNxdUd0MXJYV0JoYTlCRFZsTFM4OXY2S0ZmYTYvVHRNOXVseXVoTG83?=
 =?utf-8?B?M29RekxSblk5MmFvUjhvV2FHVmtXTEN5Ym4rVkxYZ3RhS0I1eHhqS0RyNkx3?=
 =?utf-8?B?WFpTTENmVXVacEtTWEJTMjgyRXNGaXdwSG5acWUxOGZpcjZrQS8vSHNTaklr?=
 =?utf-8?B?S0RiYVc0VTB4VmZSWitjd1MyMzBNZTFqa3RjSk45WUZlWnRBM3JTWTFEZjVx?=
 =?utf-8?B?eEZzYkNDeE9uc3dKNVNDU0s4dDVUUGJ3V3hTUlcya2c2dFQxS2hxcFJ6b244?=
 =?utf-8?B?N0EyOU5JVEtvbUZqbENla1plZGVlclBHRUlndGowUXBQcXhCcmwvS0VIV0pD?=
 =?utf-8?B?RlloVU93RnJZNzA4aDRNNWdBS3pQUS85R2pKeHhleGhyVk5STHg4RzgyckZo?=
 =?utf-8?B?c1pKbUJKK2NhZXF2allDQ2xXV1M5b3ZzVTFhR0tSQXVUY0RvMzdZRnVZbGkz?=
 =?utf-8?B?dDA2YzFBSUZGNW0yMjhjVjZQOG9ZK0xRR3lkS05HR2Z2ZmcybElCeVgrRDlE?=
 =?utf-8?B?WTQ1NHRRcFF3UmREYUhVQTI4bFZUeVlpYzQrdFY0MS9pOUZFSzdjb3Y4N2JB?=
 =?utf-8?B?ZWJIb2EzNVkrc0tnVmQwbHRKU3V2V242RjBwWW5EbTVYdjR0NFJ0Y1lTMHhV?=
 =?utf-8?B?dERqVkg0TkxoV2FEdnNSV0JHUGV1Q2FrTFRXR25raHd0QzRTYWRuRFh5eVNq?=
 =?utf-8?B?aXcybDNvRHpCNUxDTmllWjc1STlEZVZyZ3hDa0g1YXYzSVQ4emc3dHAzYmIz?=
 =?utf-8?B?Z0EwMFFjOVJaNjZOeWFReDVDQVNGZXF0UENjY3FCYUsxV1ZRU2dVYzRZV0tx?=
 =?utf-8?B?MWNqU243dkZJZmhtNHdnam8xVWFqdlFmeUpWU3JNODRUVHBLcUM1Y1oyY0J1?=
 =?utf-8?B?d2l5bnNUdHRmRk83UzlzalRVVG0yVTZGNUQ4N0QvejB3OVVkMElHWGlCSEFi?=
 =?utf-8?B?QXMxMzNvR2g0ZE5kQTBqK1hoTGtXOXorb09RSWJOZHpKYUI5UkFnQnIzWUxz?=
 =?utf-8?B?NUc4WjFxWlZXNWNhbkFwS0RXVldwcW11Yk5iSDE5eDlPbGUyQ0xXMFlweFlO?=
 =?utf-8?B?RVN6YVgwM3FzZmt3c3lQWkoyZG84dWNNU2szUFZNc3BDUnBuZ1pjNTRpcFZv?=
 =?utf-8?B?MVprU3UxbkN2ZTh1WW5kdjlBUVJvOXVZRmNZOXM5VUtaM25ZajV5YlFoY2l5?=
 =?utf-8?B?VWRvbjRlTEE4Z3N6UFJpT1NQYWJsTzNHRFo5TUEyRXJ2NDhyM2pEazN5ZkI0?=
 =?utf-8?B?alB2RlZQMzduVUNXMUZKVGFNeXJHaDRkSGl3Ui94NnEwOTQ3emU2cks2K0hw?=
 =?utf-8?B?VXZXcDRmSmJkYnFQVmJhRFBMOGZiM0JxWWlzTU5mSHoxbW1BMitmNG5uYUxU?=
 =?utf-8?B?dHJQVmd0TDVjcUJIOHhNRDVzSmw3ekpZeWJPYTlVank5K1lSKzZxNGp5ZVVI?=
 =?utf-8?B?b2NxQXQxVjRtY3loeUROOG9pUWN3Y1FiM3VDMExwTDdlTDIrRldOMlpGbGhP?=
 =?utf-8?B?cWJNNlhwRnpHVlZNRXhSdFFPVGM5aUcrUnBCUHpNc0ppajlBVklxQ0hYaEdp?=
 =?utf-8?B?YUJ2dHd2SlBFdkpIazd6S3pEODZpUEEzV1pVWU4yTzAyeUJTU085MlpyK0c0?=
 =?utf-8?B?UUlRRjFhZ1VlOTVHR2xGK2dySlBnVDM0aEh0SHBNNlNkc1p3b3hITys4ZTMw?=
 =?utf-8?B?VlJ2dDdPdEZtNHVUSkxVOW54QUNsRXVjd1ZWb3VYNDZ6OE1qcWMwaUpYY3Vt?=
 =?utf-8?B?QVcvdkhKQjRmSm9KNUFOTkNMMzFmQzNOdEV5VjAwV2FySHdUNUNzYlYvTUJB?=
 =?utf-8?B?RHdWZVFOblROcDJMQ0tIMHRIVklSbjI2bHoyN2JRQVNBWVM0MWl3dDFaUldH?=
 =?utf-8?B?MEtjSytoNUkwTWI5UDNPd01TdDBzbEgzb3k3SDZ6LzZiVENNaXRnZUJXVE5h?=
 =?utf-8?B?MnF0M3lHM0IxZFFhNzlURU1kU2tha3RUU24rZUtZVTBEYXhUS0d3OHFKdFBR?=
 =?utf-8?B?ZzNFbXM0ekcwVTd5Z2xTL2dhY1Byc3czL2VSbUp2c0JRdXBHci9Uc2RJT3FS?=
 =?utf-8?B?R3N0OEs5QVkrd1NPSENtWFg2L0ZTQ1FTc25lSktjdHF5K1NzVnAwVHZua3hV?=
 =?utf-8?B?SlhzSEJ3a3N1SWdEQ1NpRU43OC9tWVdEa2dpakxDVldrbnh2TFEyRkZiaEZ0?=
 =?utf-8?B?ZGlCcGdYN0hkdEh2MEczWmplQlRadG9nQkk2TEpDWENDOGhVUlFBR1V1cEph?=
 =?utf-8?B?NkFvdXhEWW5DdVZIN0xSQUtvSVE2dmVPc3JRNnhybGMzZFRFNkhQV3FJaG1l?=
 =?utf-8?B?S1FNeGlZYWNOcFJkOGczR29OUSsrcVJzVVhBQzVGVmZNcTJIbmlnQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adab102-51d9-4358-dfc8-08da11e2e85a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 00:19:08.6928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nnthhgQpiSIwIqOOfc9rX3WUemQZI5UBVXX75faM3wqU6p/LfbTJ2SX/FTiAzWTUVaaBXFbyT6rGOmTKqf3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/22 4:25 PM, Rob Herring wrote:
> On Mon, Mar 28, 2022 at 10:45:14PM -0700, Dipen Patel wrote:
>> Introduces HTE devicetree binding details for the HTE subsystem. It
>> includes examples for the consumers, binding details for the providers
>> and specific binding details for the Tegra194 based HTE providers.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes in v2:
>> - Replace hte with hardware-timestamp for property names
>> - Renamed file
>> - Removed example from the common dt binding file.
>>
>> Changes in v3:
>> - Addressed grammatical errors.
>> - Removed double plural from the respective properties.
>> - Added dual license.
>> - Prefixed "nvidia" in nvidia specific properties.
>>
>> Changes in v4:
>> - Corrected make dt_binding_check error.
>>
>> Changes in v5:
>> - Addressed review comments.
>>
>>  .../hte/hardware-timestamps-common.yaml       | 29 +++++++
>>  .../devicetree/bindings/hte/hte-consumer.yaml | 43 ++++++++++
>>  .../bindings/hte/nvidia,tegra194-hte.yaml     | 82 +++++++++++++++++++
>>  3 files changed, 154 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>>  create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
>>  create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>> new file mode 100644
>> index 000000000000..e8a69ceccd56
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>> @@ -0,0 +1,29 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fhte%2Fhardware-timestamps-common.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589163420%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=oyeG06oNMukYew%2Bkji%2FlXsDyGwIIrIvwxLHKxaiFBto%3D&amp;reserved=0
>> +$schema: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589163420%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=JOY3MmZlMo6Mopr5dwjUky%2BaQX4b0QSiDt8zo3mSu1k%3D&amp;reserved=0
>> +
>> +title: Hardware timestamp providers
>> +
>> +maintainers:
>> +  - Dipen Patel <dipenp@nvidia.com>
>> +
>> +description:
>> +  Some devices/SoCs have hardware time stamping engines which can use hardware
>> +  means to timestamp entity in realtime. The entity could be anything from
>> +  GPIOs, IRQs, Bus and so on. The hardware timestamp engine (HTE) present
>> +  itself as a provider with the bindings described in this document.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^hardware-timestamp(@.*|-[0-9a-f])?$"
>> +
>> +  "#hardware-timestamp-cells":
>> +    description:
>> +      Number of cells in a HTE specifier.
>> +
>> +required:
>> +  - "#hardware-timestamp-cells"
>> +
>> +additionalProperties: true
>> diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
>> new file mode 100644
>> index 000000000000..be69f63aa8c3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fhte%2Fhte-consumer.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589319655%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0f1FFB1IotZESaxDlXX5mo9YyMN25BlFAyq%2FOQJtVoE%3D&amp;reserved=0
>> +$schema: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589319655%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=B%2FvVGGwp9JghUpT33cGk0EZHDRlaOAzCbtv93Z%2Fa9YY%3D&amp;reserved=0
>> +
>> +title: HTE Consumer Device Tree Bindings
>> +
>> +maintainers:
>> +  - Dipen Patel <dipenp@nvidia.com>
>> +
>> +select: true
>> +
>> +description:
>> +  HTE properties should be named "hardware-timestamps". The exact meaning of
>> +  each hardware-timestamps property must be documented in the device tree
> The meaning of the cells needs to be documented. You are documenting the 
> meaning of 'hardware-timestamps' here.

This is for the consumer side, meaning of the cells will be documented in the provider

binding document.

>
>> +  binding for each device. An optional property "hardware-timestamp-names" may
>> +  contain a list of strings to label each of the HTE devices listed in the
>> +  "hardware-timestamps" property.
>> +
>> +properties:
>> +  hardware-timestamps:
> I'm wondering if we should just drop 'hardware'. What other kind of 
> timestamps are we going to have in DT? software-timestamps? No.

I believe this makes it explicit and leaves no room for second guess. If

only timestamps, ambiguity then will be which timestamp it is i.e. through hardware

engine, pps, ptp and so on...

>
>
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      The list of HTE provider phandle. The provider must document the number
>> +      of cell that must be passed in this property along with phandle.
>> +
>> +  hardware-timestamp-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description:
>> +      An optional string property.
>> +
>> +dependencies:
>> +  hardware-timestamp-names: [ hardware-timestamps ]
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    hte_irq_consumer {
>> +              hardware-timestamps = <&tegra_hte_lic 0x19>;
>> +              hardware-timestamp-names = "hte-irq";
>> +    };
>> diff --git a/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
>> new file mode 100644
>> index 000000000000..ce6f1313f52d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fhte%2Fnvidia%2Ctegra194-hte.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589319655%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=op7oS69fzQyvxJjQkPq8ScLuEEd32eCRjL%2BuCOPIKko%3D&amp;reserved=0
>> +$schema: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589319655%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=B%2FvVGGwp9JghUpT33cGk0EZHDRlaOAzCbtv93Z%2Fa9YY%3D&amp;reserved=0
>> +
>> +title: Tegra194 on chip generic hardware timestamping engine (HTE)
>> +
>> +maintainers:
>> +  - Dipen Patel <dipenp@nvidia.com>
>> +
>> +description:
>> +  Tegra194 SoC has multiple generic hardware timestamping engines (GTE) which
>> +  can monitor subset of GPIO and on chip IRQ lines for the state change, upon
>> +  detection it will record timestamp (taken from system counter) in its
>> +  internal hardware FIFO. It has a bitmap array arranged in 32bit slices where
>> +  each bit represent signal/line to enable or disable for the hardware
>> +  timestamping.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-gte-aon
>> +      - nvidia,tegra194-gte-lic
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  nvidia,int-threshold:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      HTE device generates its interrupt based on this u32 FIFO threshold
>> +      value. The recommended value is 1.
>> +    minimum: 1
>> +    maximum: 256
>> +
>> +  nvidia,slices:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      HTE lines are arranged in 32 bit slice where each bit represents different
>> +      line/signal that it can enable/configure for the timestamp. It is u32
>> +      property and depends on the HTE instance in the chip. The value 3 is for
>> +      GPIO GTE and 11 for IRQ GTE.
>> +    enum: [3, 11]
>> +
>> +  '#hardware-timestamp-cells':
>> +    const: 1
> Need to describe what the cell represents.
Agree...
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - nvidia,slices
>> +  - "#hardware-timestamp-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    tegra_hte_aon: hardware-timestamp@c1e0000 {
>> +              compatible = "nvidia,tegra194-gte-aon";
>> +              reg = <0xc1e0000 0x10000>;
>> +              interrupts = <0 13 0x4>;
>> +              nvidia,int-threshold = <1>;
>> +              nvidia,slices = <3>;
>> +              #hardware-timestamp-cells = <1>;
>> +    };
>> +
>> +  - |
>> +    tegra_hte_lic: hardware-timestamp@3aa0000 {
>> +              compatible = "nvidia,tegra194-gte-lic";
>> +              reg = <0x3aa0000 0x10000>;
>> +              interrupts = <0 11 0x4>;
>> +              nvidia,int-threshold = <1>;
>> +              nvidia,slices = <11>;
>> +              #hardware-timestamp-cells = <1>;
>> +    };
>> +
>> +...
>> -- 
>> 2.17.1
>>
>>
