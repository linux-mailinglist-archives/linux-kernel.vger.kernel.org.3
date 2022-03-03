Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588E4CBEC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiCCNT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiCCNTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:19:54 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3661516A1;
        Thu,  3 Mar 2022 05:19:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpChS0nk0M6QCcgwA+iJTQuUeZONnwRl/22yLVwSxJ3QwaMrlSdizsNUHC1TwrK3iTRHDB4ESona5bYY324OTYwRgjsSagX1ZHPklsP9RepdOfWKdIBasHaIvK6o33TTt2P1jHTtBG6NQdlt09QVwXLMBteWLI25AcSfnuqy/csd8SZuqhF8E/1W5wuroD+h0KfWzCmXOYrr8FkdvyRbqL7ChW6uQXKH/6BvridvAccLbCQ6CHvAmLLgQ3W2wLNhnF0uWYubVBhdjLr7fWKx95jBDOS32mMKiHFrzTdCID37GJE9Bl4VK+Cvb9tF76VImRR08/kkgigI4Nn/b8TyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5Hg0zHrDDckKpVKvdMskDnxA6YySmM100lMIkgC8ro=;
 b=KkmnV35H0xKSjEsYwn+QP+XY8434MQnLyFnYVHQFhMlHWKBjahmpTJh+7vrc64C3HIVhGGvdyyrB3tZKoPV5slIplBT5RjA5Egieh1p4DZ3Q/IPt+l+K5/QO3Gf+WBkMogzi6yOQ2Hmp65908H1sgS1B7g9xBg+pfiL/sRyIMCrNqoupvAqyBu9269ZZ8efDGvqU4mSVfAyzsXCjlLe9tm8KOvt+DrCX2er4FWfCCbJk0v8j8p/4MCnpsC6r6ixYCWj0kKnj2RWoFE++x6aVLqncyly35stn92Q/nPhRDkKCUYAfW3o2sOswmn05YmRu4KTdaXIcCtgJ8UOjufBOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Hg0zHrDDckKpVKvdMskDnxA6YySmM100lMIkgC8ro=;
 b=W5IklotcaAk9xKfxOByoBzBRHehISQcEqnARR8ebxicL8r/UgGSHgzW4SpacQnkiZdkMMu8T9HwIynTYniUFUoGGhYGFC+iVx+sTYs5NrHkHCe/9eDZieImfFLo68rWlcl3VzRfgaaJsG9qDzL/YK6Pqo+ijyjIQ6BLEgTjqrH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 3 Mar
 2022 13:19:06 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 13:19:05 +0000
Message-ID: <edd464f1-916e-191a-3683-45b623604e4b@amd.com>
Date:   Thu, 3 Mar 2022 07:19:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] [RFC] ata: ahci: Skip debounce delay for AMD FCH SATA
 Controller
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220303100453.30018-1-pmenzel@molgen.mpg.de>
 <20220303100453.30018-2-pmenzel@molgen.mpg.de>
 <0a7c8ee9-1e09-75a4-3241-883fc8540561@opensource.wdc.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0a7c8ee9-1e09-75a4-3241-883fc8540561@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39)
 To BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13282db8-ac05-413b-6c15-08d9fd18646c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB377574652B360A554B2F7947E2049@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoNGLIHJk0lhwP5CT2S7x+zK0Qwi4BFiEYfFh2gtkYeAhHvDmsJ33k+mVlzAw04kt9u+vQVEdKFFFTsi3qEkLGBbkkKhXPMnMB07tSiXJQUOwiPhXZS8v74Te7ZRUMLLSwSscnDTGs9qWR4X10MFILndrBTVpw4j7yDre42J9Qf4pvY2vk+RCgwccWbqwEK8bt7eoWP6cIopVvqS+b7PzwaiayWxN0uzOiO28GJFHfnu5K1iNnye2/uLVufkiNBwkdGyQ2azZlzcj4elvMD9J+VdFXuhPudJxL5DTibLtoyEr5uJ3YbqaGrjKPIVDwH90anFVDQ7DZq+igbuuyw1cXnVN3ZxCRwiV657AtmFdRG2I1oBpib/Uos2J8Th5Q4TIV0l9MYBRbaSaH6J3vedr35FjY917g47/YqC8xGEIjd/XtSDbn1/y/8+6LgKesj50CHM9anQi3QGYzx5P1XFXf2x1Z2sTc8jGRtL0GnyHjyE86mdJDzJHGmnH8tSlJYf+J1T9cFWGwxYX+CDsrtw+RVlTuDQsGZkKJGnfYmRpiTISKgdAe/9pXq5MulkTHVNKRqnm1wGGP0oxmCoqjq3zo8c4AY/3qGeQMDXhFK2by4smqLZziUa4TDWnI4Say0eUSnWIe5xddYbEXG1/VB4GT4TuciYvj0jB8a8eaBKRFXCMYqoQ8h47UdiMRm+XivAiYK0RfDTOszp2LJSPQ7fMmpn1STMIDvp+8bcFo2q8UE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(4326008)(8676002)(66556008)(66476007)(2906002)(36756003)(5660300002)(8936002)(66946007)(38100700002)(44832011)(2616005)(83380400001)(6512007)(53546011)(6506007)(316002)(110136005)(31696002)(86362001)(6486002)(508600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZWZUs1dktMMjRyL0xDdVFvcUVmNjA3RVhHRllaTUZkbTNuZWVPWkxRSWNW?=
 =?utf-8?B?SnJSR0kwaGlBa0xVTkNoWkNiOURFdlVRYTI0UWg3clQ5T3ZaRUlnMmdSZzFH?=
 =?utf-8?B?MHJFTzVYZHFYTUFBc1h3dWxiUVpWTldpWXU1MUh1YW1EZURmK2ltdm5IRmhl?=
 =?utf-8?B?eVlzSjZaNnVRM2Erd3ZIRXoyejZHOVZOMDZ4ZStLRTJYbFlndEJVaTg1b0Ny?=
 =?utf-8?B?TUZLME5rWTRKdUQ2aVJLVDNYL3I4SGc4Q0VPUnhCMG9iUXAvOVR3WmU0bGJB?=
 =?utf-8?B?QmVpOFh5NzJ3bWUxMkE4MVgveDMzT3c0cllnTmswajVDd1A0ejNmOGc5Rk5I?=
 =?utf-8?B?V1NhN1QzWXVJbWFyYUlBOHN6RWNTdWhhMk5BdnBCRHBpNUVBZ1RhR0xackhh?=
 =?utf-8?B?bDQyb1ZWak84NmR2N2trOEIrQkswRFVsWnJIUDF1WnhhU1NRRnpVMFdaUDBZ?=
 =?utf-8?B?SS9WVHFaQ2pmSDJJcmNZekR1bWNSOHExdUJ0SjdaMW5sL2NyYVNGdlZiME5v?=
 =?utf-8?B?YktJRUhhRW93RTh0Yy9qeTJnVk01NGRGZDhBODE4QURzNTdKUUZNN3ZubVRN?=
 =?utf-8?B?dGhmTXVlMGF1b05yckRkU1YyZ25FaWkzejE0cXhlTXkva0VUUlVOcmNhcy9Z?=
 =?utf-8?B?WHNLanRPclRCUi8rYU83ZkRPMmxnM0Y1b3l5cFZTclRZRU1FdXROUWZHbUpq?=
 =?utf-8?B?NkpnK3U3YW9YdVNBUXRCRjBjeVlNWFp0WUxldU9uY1FDb2NWMmRmSThicVFh?=
 =?utf-8?B?YVROR3ZBWFVQQUxYalB2SzVuazM5bnU0dSszdkw2VUNIYWkxUkhVTXpOVXpB?=
 =?utf-8?B?ek5nVnViWVBDNUFNL2ZEb2hNQXR0czkvckk5U1JQNi80WXNKbDE1anRxMWtU?=
 =?utf-8?B?VmFGbktuTHlHdEJjbDJtYXhjaktMcXNCbnVUNHR4eDRXVFJrL0RuWXBNRE9O?=
 =?utf-8?B?azBodGZydktUMUdHU0krVURESG5CTEVIU29RUGEweHNUdS81cC84N2k4dzht?=
 =?utf-8?B?bG9jMFFXc0Y4RHp1bzVjdHpGL1dMbmVBMGtlSVkrWjZpbjFQR1JEYzZCT1Jq?=
 =?utf-8?B?NVJGaUhMeXJtZm03cU1VOFo2ay9TYWFQZnNEemdMTnR2UXlmZ1pYQ2JZcVFL?=
 =?utf-8?B?UVBsQURYZGtDcG9ZV243dG50U0F5NVhEQ3ZiT0VEbkhIeVdHOFhnb3JFVGk4?=
 =?utf-8?B?WnNONnNreVFCVDk2Y0J5SzJvd1FVeGFaYVltckd0dWtlM2ZIbHhUa2NnRThO?=
 =?utf-8?B?ZDFmTnJqMTQrdkpvMVVEQkV2WWIzM1NodFVCZGh0Wk9zcklZcXZIT0NNUmNJ?=
 =?utf-8?B?U0FVTXJLUHNycjVucjhnYnp5ZkhyN1Brek9VQWFZK2srVkFZY2o2RVJ6d3cw?=
 =?utf-8?B?d0FIR3R1YUJUc1VOUjdQbm8rblUyR2dTOWVUbWFXUnF4L0tVcHpkdXVsZG5t?=
 =?utf-8?B?SC9BOVFjS0dOWkl3ZUtwaHRNaUpFbUtjUmFnZTFBSjJac1FCcmhHYzJjRTZu?=
 =?utf-8?B?ZXVhcEdFS1A1dWUwUEdYZzdqY3prRGJRWEVWSTYvc1ZZbnNNZEV2bTR1eENw?=
 =?utf-8?B?cnM5alQyZGx0MjQ5R2xORW43YVExRmJoMHlvaUFoNGlSL3RKNkZvWEtUbk83?=
 =?utf-8?B?Wm5xNGxQNHZ4V3dEU1JIek9xQTJKRUpmZytYL1YyaG9UVXpZSjNRYThCTzdy?=
 =?utf-8?B?WjJSTkRBazh2WCs1TExtbUNzWDB6TjdoYStPd3Z6RkdOSmIwa0p0ZHlsY3Ba?=
 =?utf-8?B?NXltK2o1a1FHVTJDbTJzejlMYjJTZ1doUnp4aXZUbFhiVzhyWTIvZGtOQnU3?=
 =?utf-8?B?cStXcWpPSGNrekcra003RnZCelZSQ0NlT2RCWWppd21sN2xDRHZpd2lSTDhC?=
 =?utf-8?B?ZXRkRk5WcE1KcVFsRkdkdk0zREtqYlI1QzlLbGtYVzc0RVF2OHlFdkhVY3ow?=
 =?utf-8?B?bnZnUUFTOU15SHhPZEgxUmJPRm1jci8zSXFoaVFwTkdDLzBHNDlaUEw1QW51?=
 =?utf-8?B?RVI5bGt0emhHYmtqbFZXMVAyVytPaElqellYdXZKVnJkcVBLREJVS2dFTy9n?=
 =?utf-8?B?MHBHRkIwcUNoQ0FpRlVrc1JYK1lpb0ZnbTNoSjJWaVdKSXNyaEcvenhGK0ty?=
 =?utf-8?B?cm53ZUYzeWtDSzIvanJ2OThDOVB5THl1ZFNsZnoyQStCUmhWSXVidTVJU3dn?=
 =?utf-8?B?M2xXQjhsVkxDT2llaGN3TEd1Nnk2UldROXNiODI4aG13TmJOeVFvQmc5QVJh?=
 =?utf-8?Q?DwBnoIjGfQ0I5vRGk3NzGFe5dJz0BPpZCGJHbcIsp4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13282db8-ac05-413b-6c15-08d9fd18646c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:19:05.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8j0U/xFVhguBY0rMV7/IM/IzKaCx1r9IYfdWY2mY2F34cG6LXFobQtf7YeyJkruAmIQAoIGQFrSlqjyj7t21g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 06:23, Damien Le Moal wrote:
> On 2022/03/03 12:04, Paul Menzel wrote:
>> AMD devices with the FCH SATA Controller 0x1022:0x7901 do not need the
>> default debounce delay of 200 ms.
>>
>>      07:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
>>
>> So skip it, by mapping it to the board with no debounce delay.
>>
>> Tested on the MSI MS-7A37/B350M MORTAR (MS-7A37).
>>
>> To-do: Add test details and results.
> 
> Please squash this patch together with patch 1. Since you are adding a new board
> entry definition, it is better to have a user for it in the same patch (this
> avoids reverts to leave unused code behind). >
>>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> I am travelling so could not test this exact patch just yet, but I ran
>> something similar for several weeks already. It’d be great, if the
>> desktop and AMD folks could also give this a try.

As we are trying to drop the low power definition for 5.18, maybe can 
this wait until 5.19 so we can see if that sticks so this doesn't get 
caught up in possible reverts?

>>
>>   drivers/ata/ahci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 0fc09b86a559..44b79fe43d13 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -456,7 +456,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>>   	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
>>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>> -	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
>> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power_no_debounce_delay }, /* AMD Green Sardine */
> 
> Really long name, but I cannot think of anything better...
> 
>>   	/* AMD is using RAID class only for ahci controllers */
>>   	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>   	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
> 
> 

