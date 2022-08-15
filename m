Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DC593F62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbiHOVV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbiHOVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:16:54 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC0C39;
        Mon, 15 Aug 2022 12:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPjQUb6Wcj4m/qZ0Cufs7b2mhGrxBefoulurHH+Tgn6pmx/1olJN2RbRAvjE5ua4uGvRsm1MeFqt7wxZzcnkXSQIXqFrvI3tsoZ8YJBOxjxtcTR5fjVbbzYz3CDUTJcFBezzHHpec6Rzq3q4GwvJCfIh8HP0l7Vm+2u5PqRZt5IMlPR4X+QaXzOx7DZ8oVRUnkt67f8IuU3thfj+SBy9Fc6+IcG213oyELnIsFBEFvr6HpZW+o5pGYU7BpkKYayeYzs8bb+4kG41QeRoThDbsSUhirep1poPynNDBl4ViyW6PwhXWDE1Vj6IQAl5IgnJZgh0X+7qAg1j5R3SkSikew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h2YnwujvVy8kzuQCOkWSEcAYpPib+52ebMhj/wSErg=;
 b=N3V5HrlYtHRFT2qq6HbsmXSbU72eulNp8YHlRxFJuZAqyHHN3LNYamBWP5M7gGlMl32MmhbISuWVH5tSwluM0Z+7sDe521doOF27CPmXWowrL9Ca1Svsf0xhJIMH6Bn4q4vd3klUqsDHYOBh9KQ1h17W7Q/Ie8mZKNcEh6lL71uUIUpb/1sQ7aJIIo+twzJg/30xrqrqYSvP2ZXwIql7UceoKQrMT5oDBGbGtO60wAPvKo66mtf5hlVtwmJM+9RvrSJn/Y5FXEIyTdw/1xVKfwSF2RIhOdfqhZUaoSJCVQ2eJiyutS26CpFrfrPmPJ43HI3EatR4nRKuW+wi9TdeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h2YnwujvVy8kzuQCOkWSEcAYpPib+52ebMhj/wSErg=;
 b=4tNwT4LOqiSlD6cngpGYCqxvvx25Rs/KHJAUCBHKdu2YmQVoyaIMnBXlvnMQRod2hjLT3ymYLLH4w67FaeJjBEnZtMBJwjnPivhUdtlK0ko71CqhjzkXx0XDmm09yqxk8DxpTCw7A97w2Psi0usfEEnbG67oXBVa/pGkmHVFURo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 19:20:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 19:20:13 +0000
Message-ID: <97b2a9a6-f08e-0212-fb93-a7158e188497@amd.com>
Date:   Mon, 15 Aug 2022 14:20:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw, Richard Hughes <rhughes@redhat.com>
References: <20220815041145.35629-1-chensiying21@gmail.com>
 <e49679b9-7b5a-5d97-c63f-a6004af0aaaa@amd.com>
In-Reply-To: <e49679b9-7b5a-5d97-c63f-a6004af0aaaa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:610:58::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b3f634-b35e-4a05-fd62-08da7ef32d79
X-MS-TrafficTypeDiagnostic: DM4PR12MB5865:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9gJS2e2iZo3NS+os+gAUESlgoRSaA2PlQZZUGepfcMy0Bzi9EGrkiniUCCTi+R/LIgEeON0d+MRlZTMrfEk9bv2CxwztNgA0SDA6sdDOCbHeDlvv1BrDq9EotyUnrbzp9F7AmtPd209BniKZYfl9RZV4VvFo/8aGqwyUP4Wp66cm5lYPlsQY1eLxS69ul93qgXo+aJ/BMhp2IXIu4GgpjZRQgX2dg1/VjtgaV0JaBc6M5A/duUg3OZhfuBnmcWuKgMt41OBB7BtOSY4BnjmIRra3h0yzYJViO0k9BAQY1AcmHK8sBBaEgTpvY982lzlmsMl0JUmBsl0Qs+W27kUeWBLl96JTrDM3kzbRgdh9iHBIu6EH/S19ahAogvZZWrLfSApg58R7WHtwCSWLE5pZJny7YLhyAvjSY4cG6RhfKjcCKDvoesF7YuJ/o9DTjUvLXnAMfJEvQQDFTimTalzkXrPDP5WokrBfRi3jLHhbwo9fY5guKkDSEw9mbIMLnrWVcA2I8Ub6xzQC0TZlBNoFHf4t5O7Tist/hjn/Nwy6VNDzC6WOAtI4BvrA7cNljcw90FGF1B+w4eppA0mjEVKsB4U3dtgiyWwRKCSWT0TCNiSpcTZ5KT0jab2jCKALskbjaCLgALRi9ZV67K23rz5eXxoqa4xiepxgX+Rfc+uYNmCt7rpD9HNaHIPEVZjud2omgOm2Dxq5oKVExZVUjLlHPNNwuFtq7BXcJ63s9SPK2NuzZC0Ot/g08pwy7jXParV2En4y+c0ezQuro4oTb4a4H15SRryIRpmhdF85CLIEgS5lcHIq2D4x03OkGihswKzYZYKh5BWrepYJxte8ds9GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(5660300002)(7416002)(30864003)(36756003)(31686004)(66476007)(66946007)(66556008)(316002)(41300700001)(86362001)(31696002)(83380400001)(8676002)(4326008)(6512007)(53546011)(38100700002)(6486002)(478600001)(26005)(2906002)(8936002)(6506007)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVlxVU9tUVV0MjN2Wm9BcnpYdjdLZmlnMG1sQjlqSVkyQWxFN1lKMG9GeXdI?=
 =?utf-8?B?MmdYTHZ1VUphTW1VdjdFU3dlNVhQa2EvT3ErQWRDR25vTzkwYmMrT04vV3Ry?=
 =?utf-8?B?c21pK00zT0xEdHhKQS9mSE1HUjRGYW16bjR3MWpadjhoelFFRjBVaGxnSXc2?=
 =?utf-8?B?bmpBclkzUE9ROUIwNnE1M3pVVmtURFh3bC96YXU1eGJ2SE85QWhHUG9MOVFP?=
 =?utf-8?B?OFk2eUhxNE0vbVlWSXRhdjdSWnhyQ0ZXZ0FXdmhRWWs3Q2czWisvU3ZMcmtV?=
 =?utf-8?B?a3VqcElKL3p6Sjh0WEJnRjAwRFZQekFLSEZTSFhVV1BvUVV6NUlqZGwwT3RN?=
 =?utf-8?B?OGlLS0lxNkZXRjk4cjFOME5FSytJR3lob3FUcFh2dnhuNURkRXhibmgwTHdr?=
 =?utf-8?B?SnZFQ1hlendESTJHa0ttRjNtdzc4Q3lmNXJpQW12Mjd2STB5d2dTdVBoVDlq?=
 =?utf-8?B?UWFTT05reHpwTjhVOC9MU0YwR3hzTW4wZDVSMjRvUUpNVFAzaitJbHhMWUxz?=
 =?utf-8?B?a3Baa2t2UVBTdGdCejg1OVJWL0FsNGVESTg3VzJGT1dESXZ6djZNalNwU0c5?=
 =?utf-8?B?QjNTaDY4SlRsa2VERDdVenZYejN4QXRiVE53S2JwVmZKdzlObUNmN1YwNVFy?=
 =?utf-8?B?MmZFOGs5d1ZlanJTRTZqMnA5OTFFRzN0Z0M0NEhrQVVST0hGS0lVN1NTL2Fq?=
 =?utf-8?B?SWE1ZENzdHFnSmpyR0Vyc0ZJc2NtSDBuUHBHekFZUkdoL1cyYkhmTVFBTENK?=
 =?utf-8?B?RFByS0Z0d0VFRzZJT0YrcEJISWhJbWJVRzdXVWZqMkdwcXlYaFpLUWY1YXp0?=
 =?utf-8?B?SmhOVjQzRm1Gem5mWklmU1JtUnJnMk1uWUVBYjZYMWp0YTgvbUNFblZJZ0lB?=
 =?utf-8?B?dXFIZFJDeTVjbWFmSlE0RUhIcGJqeHNaQkY1NWthbDJ1SlA3ZGNYK1hlYTBq?=
 =?utf-8?B?bzd0Q21OSG1CUFhtWUE2KzM0WFpvSmVSZ2syaHgzWHVCcmdYL3BHeUJPQ3lU?=
 =?utf-8?B?NUhkcFl1RTJIVFhPN3N5VGloaWorNGZQeUpwUXlHTllUTDZ1dVdYMzZjcTJH?=
 =?utf-8?B?VDN5K0ptNHJWVEVqMTg0TWRKdzg5SHNLWW1PcitUOGpzcExzUmRqNU0zYWxw?=
 =?utf-8?B?NWNtb0hKd0J0dmtBM2VRWk93cjBlaTk1YlpJVHB0UnQxMFlHdXMrSkRaODRI?=
 =?utf-8?B?Um10ZUdjUkNIcG9EWUlIQ0trTjVzUlJZMm82V01ZY1JoZGxWa1BtbTF2UXhM?=
 =?utf-8?B?dkdkbHRrRnpHSTF3ek9kanBLUkRkRVNrQnpmRGFtYnFwTEZrSVIyWk9NcGZl?=
 =?utf-8?B?ampKUk1BTU45SlJnTjl0dUc4TGZ4L1ZlMW5ZRjdOR0N3eTRUMElnMy94RnMw?=
 =?utf-8?B?L21ybkE3b0R6RXlMZ21EaElrYkVBNkdyeExsT3kzVnJxaDhWdDlhTjdqdzNJ?=
 =?utf-8?B?ZkNWWHczdEd3Ui95L1RNQ0Q4ckNLdVZUMkdYb1REVnNMdUxjRHBOR3Izc2k5?=
 =?utf-8?B?YlREV0Vhc2RSNllpMHcxRTRlaFNUL0NiTUQya252ZjRya3VrUWdheWtBNTZE?=
 =?utf-8?B?UFVwUk5Xdk1QKy9rTTBLZVR2NVlwdCs4alNjZHVCSVk1NGNDL1NiV3NldjBk?=
 =?utf-8?B?Yzh0ZVNWYlNuMGs4S29CeitSN2NsRjhyUlR6K1oyY1FybURQWUc1QXRZcExh?=
 =?utf-8?B?alU3VXVRTjcrdk8wYUp5SG9FQmNCYjlqTU11M3lOWEFuZWlhdkZQNk1abmkv?=
 =?utf-8?B?QjZsUjluVnBxQUZLTlE3ZFBIb0IrRTVaZlVGZ0dCV1Ryc2RGcEFTcmtoQWc0?=
 =?utf-8?B?aE5PeVdIaHlmZUw2Sk5oR1VDUVE2Z3FMRkpPQzJqWmZxRlpham84N3dLMWcw?=
 =?utf-8?B?S3BZLy9qMVhqdEpqbHozMXNBT3Y0MGhiVFAwSmk4eU42akU0ZXM2eW45ZEdM?=
 =?utf-8?B?dTNUOHlPeVBCM1NrbEt0VEMxZVkrWnZCbFV2VW03c0ZhVWw5MHlLMVFlMExP?=
 =?utf-8?B?TkhjMmVqelI5QmRGMVVuSE5HODBXejVucXpoaXR1WklWMnV2MFp1L21ZSkty?=
 =?utf-8?B?NUljMWVBcHY2bWdSaGxQSUEvUVFqM210WnNVNlN5bFhveG5EOCszSHA2R2tY?=
 =?utf-8?Q?x9C/38ov07fgyI4mDvgtTjuG9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b3f634-b35e-4a05-fd62-08da7ef32d79
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 19:20:13.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlNZ+RQauXF+W3MvqBUewj0sPq6REbrhvfSaWvjYW43QHY0EUzk+o2jUWrEMCoaTC28U7CvokqhSWGdqKfH73g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/2022 12:28, Limonciello, Mario wrote:
> +hughsie for additional comments
> 
> Various inline comments below.
> 
> On 8/14/2022 23:11, Szuying Chen wrote:
>> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
>>
>> The patch add tb_nvm_validate() contain an array that has functions
>> pointers to asmedia_nvm_validate().
>> And asmedia_nvm_validate() that recognize supported vendor works in one
>> of the following cases:
>> Case nvm_upgrade: enable nvm's attribute by setting no_nvm_upgrade
>> flag to create nvm_authenticate file node.
>> Case nvm_add:add active/non-active NVM devices.
>> Case nvm_write:update firmware to non-ative NVM device.
>>
>> Our patches were through checkpatch.pl. But the file(switch.c.)
>> have existed 13 warning before we patch it.
> 
> Please feel free to add other patches to the series to clean up 
> warnings.  Just because you didn't introduce them doesn't mean you can't 
> fix them =)
> 
>>
>> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
>> ---
>>   drivers/thunderbolt/nvm.c    | 147 +++++++++++++++++++++++++++++++++++
>>   drivers/thunderbolt/switch.c |  17 ++++
>>   drivers/thunderbolt/tb.h     |  18 +++++
>>   3 files changed, 182 insertions(+)

When you submit patches to the mailing list, you'll want to do two 
things I haven't noticed you doing:

1) When you create the patch with git format-patch use the 
"--subject-prefix" option to set your subject prefix.  I see that your 
patch has been submitted at least 3 times but Lore groups all 3 
submissions together.

The first should have been [PATCH], next should have been [PATCH v2], 
next [PATCH v3].

So I think technically your next submission SHOULD be [PATCH v4]

2) You should add below the --- comments about what changed from last 
submission.  This helps people have reviewed it in the past be able to 
better focus on what they should look most closely at.
It should be something like this:

```
.
.
.
Signed-off-by: User Name <user@name.com>
---

changes from v3->v4:
- Foo the bar

Note: The three previous submissions accidentally used the same subject 
prefix.  This changelog is relative to the most recent submission at $URL.

    drivers/thunderbolt/nvm.c    | 147
.
.
.

```

>>
>> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
>> index b3f310389378..6db2034ec8e5 100644
>> --- a/drivers/thunderbolt/nvm.c
>> +++ b/drivers/thunderbolt/nvm.c
>> @@ -9,11 +9,158 @@
>>   #include <linux/idr.h>
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/pm_runtime.h>
>>
>>   #include "tb.h"
>>
>>   static DEFINE_IDA(nvm_ida);
>>
>> +static int tb_switch_nvm_read(void *priv, unsigned int offset, void 
>> *val,
>> +                  size_t bytes)
>> +{
>> +    struct tb_nvm *nvm = priv;
>> +    struct tb_switch *sw = tb_to_switch(nvm->dev);
>> +    int ret;
>> +
>> +    pm_runtime_get_sync(&sw->dev);
>> +    if (!mutex_trylock(&sw->tb->lock)) {
>> +        ret = restart_syscall();
>> +        goto out;
>> +    }
>> +    ret = usb4_switch_nvm_read(sw, offset, val, bytes);
>> +    mutex_unlock(&sw->tb->lock);
>> +
>> +out:
>> +    pm_runtime_mark_last_busy(&sw->dev);
>> +    pm_runtime_put_autosuspend(&sw->dev);
>> +
>> +    return ret;
>> +}
>> +
>> +static int tb_switch_nvm_write(void *priv, unsigned int offset, void 
>> *val,
>> +                   size_t bytes)
>> +{
>> +    struct tb_nvm *nvm = priv;
>> +    struct tb_switch *sw = tb_to_switch(nvm->dev);
>> +    int ret;
>> +
>> +    if (!mutex_trylock(&sw->tb->lock))
>> +        return restart_syscall();
>> +
>> +    /*
>> +     * Since writing the NVM image might require some special steps,
>> +     * for example when CSS headers are written, we cache the image
>> +     * locally here and handle the special cases when the user asks
>> +     * us to authenticate the image.
>> +     */
>> +    ret = tb_nvm_write_buf(nvm, offset, val, bytes);
>> +    mutex_unlock(&sw->tb->lock);
>> +
>> +    return ret;
>> +}
>> +
>> +static int asmedia_nvm_validate(struct tb_switch *sw, unsigned int mode)
>> +{
>> +    struct tb_nvm *nvm;
>> +    u32 val;
>> +    u32 nvm_size;
>> +    int ret = 0;
>> +    unsigned int image_size;
>> +    const u8 *buf = sw->nvm->buf;
>> +
>> +    switch (mode) {
>> +    case nvm_upgrade:
>> +        if (sw->no_nvm_upgrade)
>> +            sw->no_nvm_upgrade = false;
>> +
>> +        break;
>> +
>> +    case nvm_add:
>> +        nvm = tb_nvm_alloc(&sw->dev);
>> +        if (IS_ERR(nvm)) {
>> +            ret = PTR_ERR(nvm);
>> +            break;
>> +        }
>> +
>> +        ret = usb4_switch_nvm_read(sw, NVM_Date, &val, sizeof(val));
>> +        if (ret)
>> +            break;
>> +
>> +        nvm->nvm_asm.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) 
>> << 0x8 | (u8)(val >> 0x10));
>> +        ret = usb4_switch_nvm_read(sw, NVM_CUSTOMER_ID, &val, 
>> sizeof(val));
>> +        if (ret)
>> +            break;
>> +
>> +        nvm->nvm_asm.customerID = (((u8)val) << 0x8 | ((u8)(val >> 
>> 0x8)));
>> +        nvm->nvm_asm.version = (u8)(val >> 0x10);
>> +        nvm_size = SZ_512K;
>> +        ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
>> +        if (ret)
>> +            break;
>> +
>> +        ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, 
>> tb_switch_nvm_write);
>> +        if (ret)
>> +            break;
>> +
>> +        sw->nvm = nvm;
>> +        break;
>> +
>> +    case nvm_write:
>> +        if (!buf) {
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        image_size = sw->nvm->buf_data_size;
>> +        if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
>> +        if (!ret)
>> +            sw->nvm->flushed = true;
>> +
>> +        break;
>> +
>> +    default:
>> +        break;
>> +    }
>> +
>> +    if ((mode == nvm_add) && (ret != 0))
>> +        tb_nvm_free(sw->nvm);
>> +
>> +    return ret;
>> +}
>> +
>> +struct tb_nvm_id {
>> +    u16 hw_vendor_id;
>> +    int (*validate)(struct tb_switch *sw, unsigned int handle);
>> +};
>> +
>> +static const struct tb_nvm_id tb_nvm_vendors[] = {
>> +    /* ASMedia software CM firmware upgrade */
>> +    { 0x174c, asmedia_nvm_validate },
>> +};
>> +
>> +/**
>> + * tb_nvm_vendor_handle() - support vendor's NVM format
>> + * @sw: Thunderbolt switch
>> + * @handle: 0:NvmUpgradeSuppport, 1:NvmAdd, 2:NvmWrite
>> + */
>> +int tb_nvm_validate(struct tb_switch *sw, unsigned int mode)
>> +{
>> +    int res, i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(tb_nvm_vendors); i++) {
>> +        const struct tb_nvm_id *id = &tb_nvm_vendors[i];
>> +
>> +        if (id->hw_vendor_id && id->hw_vendor_id != 
>> sw->config.vendor_id)
>> +            continue;
>> +
>> +         res = id->validate(sw, mode);
>> +    }
>> +    return res;
>> +}
>> +
>>   /**
>>    * tb_nvm_alloc() - Allocate new NVM structure
>>    * @dev: Device owning the NVM
>> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
>> index 244f8cd38b25..352e64f3dc92 100644
>> --- a/drivers/thunderbolt/switch.c
>> +++ b/drivers/thunderbolt/switch.c
>> @@ -114,6 +114,14 @@ static int nvm_validate_and_write(struct 
>> tb_switch *sw)
>>       if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
>>           return -EINVAL;
>>
>> +    /*
>> +     * Vendor's nvm write. If the image has been flushed to the
>> +     * storage are, nvm write is complete.
>> +     */
>> +    ret = tb_nvm_validate(sw, nvm_write);
>> +    if (sw->nvm->flushed)
>> +        return ret;
>> +
>>       /*
>>        * FARB pointer must point inside the image and must at least
>>        * contain parts of the digital section we will be reading here.
>> @@ -390,6 +398,11 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>>       if (!nvm_readable(sw))
>>           return 0;
>>
>> +    /* Vendor's NVM formats add */
>> +    ret = tb_nvm_validate(sw, nvm_add);
>> +    if (ret)
>> +        return ret;
>> +
>>       /*
>>        * The NVM format of non-Intel hardware is not known so
>>        * currently restrict NVM upgrade for Intel hardware. We may
> 
> This comment should be adjusted as after your patch lands both Intel and 
> ASMedia formats are known and included.
> 
>> @@ -1953,6 +1966,9 @@ static ssize_t nvm_version_show(struct device *dev,
>>           ret = -ENODATA;
>>       else if (!sw->nvm)
>>           ret = -EAGAIN;
>> +    /*ASMedia NVM version show format xxxxxx_xxxx_xx */
>> +    else if (sw->config.vendor_id == 0x174C)
>> +        ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->nvm_asm.date, 
>> sw->nvm->nvm_asm.customerID, sw->nvm->nvm_asm.version);
> 
> Are you hard-pressed to use this specific format for the string?  I feel 
> like it's overloading the definition of a version string quite a bit.
> 
> I also worry that userspace has come to expect "major.minor" for this 
> and making your string use 2 decimals may mean more deviations for 
> userspace too.
> 
> Perhaps should you just export it instead as:
> 
> "%02x.%06x", sw->nvm->nvm_asm.version, sw->nvm->nvm_asm.date
> 
> And move the customer ID into another sysfs file?  I would think this 
> fits pretty well with the existing "vendor" or "device" sysfs file 
> depending upon it's meaning.
> 
> If you do end up having a strong reason for deviating the version string 
> format, then I think you should document both what the Intel format is 
> (major.minor) and your format explicitly in 
> Documentation/admin-guide/thunderbolt.rst.
> 
>>       else
>>           ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
>>
>> @@ -2860,6 +2876,7 @@ int tb_switch_add(struct tb_switch *sw)
>>           tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
>>
>>           tb_check_quirks(sw);
>> +        tb_nvm_validate(sw, nvm_upgrade);
>>
>>           ret = tb_switch_set_uuid(sw);
>>           if (ret) {
>> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
>> index 5db76de40cc1..7f20f10352d9 100644
>> --- a/drivers/thunderbolt/tb.h
>> +++ b/drivers/thunderbolt/tb.h
>> @@ -28,6 +28,22 @@
>>   #define NVM_VERSION        0x08
>>   #define NVM_FLASH_SIZE        0x45
>>
>> +/* ASMedia specific NVM offsets */
>> +#define NVM_Date    0x1c
>> +#define NVM_CUSTOMER_ID    0x28
>> +
>> +/* ASMedia specific validation mode */
>> +#define nvm_upgrade 0
>> +#define nvm_add 1
>> +#define nvm_write 2
> 
> As all of these values are ASMedia specific, I think the #defines should 
> have ASMEDIA in the name.  I know Greg mentioned to roll into an enum, 
> and I think you still can but make it something like:
> 
> #define ASMEDIA_NVM_DATE    0x1c
> #define ASMEDIA_NVM_CUSTOMER_ID    0x28
> enum asmeda_nvm_ops {
>      ASMEDIA_NVM_UPGRADE = 0,
>      ASMEDIA_NVM_ADD = 1,
>      ASMEDIA_NVM_WRITE = 2,
> };
> 
>> +
>> +struct nvm_asmedia {
>> +    u32 date;
>> +    u32 customerID:16;
>> +    u32 version:8;
>> +    u32 reserved:8;
>> +};
>> +
>>   /**
>>    * struct tb_nvm - Structure holding NVM information
>>    * @dev: Owner of the NVM
>> @@ -57,6 +73,7 @@ struct tb_nvm {
>>       size_t buf_data_size;
>>       bool authenticating;
>>       bool flushed;
>> +    struct nvm_asmedia nvm_asm;
> 
> Furthermore if you follow my suggestion on how to encode the version you 
> can re-use the 'major' and 'minor' members from this struct and don't 
> need to deviate in any way from it for your data.
> 
> * Major would map to your "version".
> * Minor would map to "date".
> 
> You could instead then store the customer ID into the switches vendor ID 
> or device ID member (whichever makes more sense).
> 
>>   };
>>
>>   enum tb_nvm_write_ops {
>> @@ -736,6 +753,7 @@ static inline void tb_domain_put(struct tb *tb)
>>       put_device(&tb->dev);
>>   }
>>
>> +int tb_nvm_validate(struct tb_switch *sw, unsigned int mode);
>>   struct tb_nvm *tb_nvm_alloc(struct device *dev);
>>   int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, 
>> nvmem_reg_read_t reg_read);
>>   int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void 
>> *val,
>> -- 
>> 2.34.1
>>
>>
> 

