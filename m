Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB224B7E20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiBPC5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:57:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbiBPC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:57:08 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D152A70A;
        Tue, 15 Feb 2022 18:56:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzTOEli7yHFTvyPfuWTglwZva7A7svDW7x6q/eyGfSTo48jkaZKDKhr0/0WAyxGza6wZS2b1nFCK6TpsGdAxMtgxTqaPEX6QtTWGyAW3FGlAqWcA9f6YRayrhGQpOkoMVeoPstnY4KvkWIaJlTM50vPl5NJYQP+zkB+E8p72w/ikbXk27AE8UIe5rg/nVO5s9OHOzb0cOFzYDbHLEXogqvecNnx/vMSLUmcbgSU60kUzdjtx2za+O3Qs4PYNgDpcWwq9xVm0GZfU991w6sEm1sUe2VEKTBqmnOwVNMBKik2ZPZNMF39Og9t2b82z1AA4OMYyBXSjGk+XQBM6guMxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeSRx/HOXH/bVtMvCTlbhqOOCSY/Ng8TiLZIgQYJkws=;
 b=CTwrm+2kHAhkHhfXehpw3hYt2cxQIBKkLY/YASWRZIslyn+6puTWo2d/CUvpREpjHjp2MDXoUCnt2lF3McMS0S0g/qV52D0uKW9DY9+9j6O6g4bxwvpfevc96fL5T7Fj5ZRagBTos9qxtVGA8NImf3gQONn+f+6LQrEpSY/iJn31lpJbOOLNrbghxBs5jBbFTTJjse0EiDCPWm7wJg8jNe92C6Rl5FbGOLzXg6Zv2oteUeIsInSgaS70T5BSUVhq/3mNxfeZ6DdSRVGP/dh1XAYWX4/aCozyKx2dceSEDfp+c9kKE12djL8AwAB4bkT6c+irwz2BvtcQCt4629FRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeSRx/HOXH/bVtMvCTlbhqOOCSY/Ng8TiLZIgQYJkws=;
 b=nzAcucHpEtobd8FOHjE3Yw8d80n1G7DMwg7SshMtl+YtEAIgXyG8gdaRRmoeC1iLW5Ulao44N4WBVNibgqBpDo7oQe0n4cuiIraVifgSw3ZyNlBMvf1O1CgxgoSn+fGjYKR3HiwaRGlLiKj5WqKWD5KPlOHI/rOodgX/HZbSm7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN6PR1201MB0114.namprd12.prod.outlook.com (2603:10b6:405:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 02:56:47 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.014; Wed, 16 Feb 2022
 02:56:47 +0000
Message-ID: <cb4bf44e-1399-277f-807b-1a7f26f80c1c@amd.com>
Date:   Tue, 15 Feb 2022 20:56:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] ahci: Add Green Sardine vendor ID as
 board_ahci_mobile
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
 <960946b8-8f73-9f81-735a-64e5cc555a9c@molgen.mpg.de>
 <DM4PR12MB516853204C9D7E7EAAFBC91FE2339@DM4PR12MB5168.namprd12.prod.outlook.com>
 <6c846941-151d-e8a5-3ce8-a392b97186a8@molgen.mpg.de>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <6c846941-151d-e8a5-3ce8-a392b97186a8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::16) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fa6085a-4d90-43c5-ea0a-08d9f0f7f8c9
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0114:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0114F54C82D30E20A7B0115AE2359@BN6PR1201MB0114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MHMQ44bfJL3yDOYE45fBuWtghql7wPLHRPVrUhavHFLBzp7etj4zYHJz1CDdPK1n89659PYfobeVeDTqmvjFIZJZc2MP2ClqbA2VSZuELArtQP3aPJAsFr2P12H3lDDfXZdJ5GTd2Yj9VsD7yoZx/96Z/f/ko0PiEBWRUMsftOnihMUjq4q+zSpQzv49+/SifoqThvaLKvpA/pDW5ugCSTiUaFDAaEIBV9Hgic4OIwmqzFhNY5/BYYRXTKGjmmnciKGDwXRqh65Ed4ARd8C8a5AmUh28S7LvFwe7qG/NW605bzFYzNYvinm5Rwad5m2AJPGs3I3+y5awRXxH6Wkzx3+opp1MkaB/4bFk7+iyccrE8jxdwDIKfz/uZ0ZyjqDpBjfdDFaomRZ0tDqb+deSZic8JWJT4/C+81nXWdm4H6mVK0pXoouJEQJnuhmABf3+qaqNcfsL5iUtga0JvKY43UAoHBhsRCCNnDzdWmBBzvt6/TJuCvKwdIEyWafz46WljAw6HGysONQeFbPP0E/tG+SPgCeTdXgb19vfAGBpYi1IHu6uf05gqUXd+2iZpwSIjcUM+N8c8bN2Nu3gkcByrAK+bSigEp3/heBupHVX1aLZtlBMgnR0Mc/KkLjvGjCvI5csgAjZS7yhN7grtupNa+ca+CEvLMgo4sQ9vMY34hb/h19nMH9pB2nkilO49poW6iuI4RHR7Ou+lWTDitpbTid8azJpqE+pnZLrc2gsGNCMcPKgkuZx9bD8HnnmujM4bSOQgo54n8SIkZWuF2dHQR+YfeWmWeo03Yic262tfnhDJMt0GSLJdKJwAiwqpEOUZndj77HY5jWt0nMvK6NvF6G1qEvEs/wnAufeRcB7tE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(2616005)(6512007)(6666004)(966005)(6486002)(38100700002)(508600001)(45080400002)(31696002)(186003)(83380400001)(86362001)(4326008)(8676002)(316002)(31686004)(36756003)(2906002)(8936002)(66946007)(26005)(66476007)(66556008)(54906003)(110136005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm1jZUJheXJKVG1sYWZRQVBwaHJNZDEreVg2eURwOVBPMnE2d0xGWTNSNkpy?=
 =?utf-8?B?K3dPTEpZR01KVTk0THptM2dPcjV5MHZKSU93ZFBkZXBXd1JORk95VU1jdXU0?=
 =?utf-8?B?OUdXclN3Tndhejg5b3YrNXhtTS9lOVBMTzk2M09aZERlNWhObFVKUXBZNnFa?=
 =?utf-8?B?WFRETE9QN0NobmpqZUZsRlRwSmIrUml5K0pxSjY3Y0t1NGttL2pxWUdjQVho?=
 =?utf-8?B?bG12WFBFbTBoQ3JVR2NtRnhyZzM5c2l6M2NoWWwzUEdtSHV4OWVBYXVxRWsr?=
 =?utf-8?B?VU5zZmppU0VBWHNseVpKY1k4WE1vMFlMMVdzS0hINTgyYTBZVUN1cVhuOTBK?=
 =?utf-8?B?MmEvT085cGN6WFkzR1o0L3B0dzFiRmpjV082WVNaL0dBUzc3dU02VVVVVm95?=
 =?utf-8?B?VUtNdkVJcDRpbkpxZWxlbTA5OUUyNGlIVkg0bzB2OEdUS09qUzB6MldIUnVl?=
 =?utf-8?B?QUVsK0o5RFlXMXZlclljWElxaElCcm9jSGt0Q1h5YlhMUmVyMS9uV0E0N1c3?=
 =?utf-8?B?L0hQaUdjbzJyU0xTUU5vdUZOQ0RMd1YxMlRnQTRjVmMyTmNZS1MrS1U1RHY0?=
 =?utf-8?B?RU1iMGJzMnBpQXExQlgvOEVzekh0SmIvUC9tbGt3K3BXNzlTTWdvWXd6c3Yv?=
 =?utf-8?B?VG9mZ2F1UG5Rbm5kYzdNQmNEQmpINVFPQ1ZHSFNpSFFGNW9ZRkR6bE52dVdG?=
 =?utf-8?B?L0M1Z3RDK2RXOFNOMXRwYzRzSS9FbUV6SlBESGFFSFdpaEhSNWxXbWRBbld2?=
 =?utf-8?B?K1hGak8rdVZ5eWc4dnJVNUlCRFRJY1pROCsvZldVcGRlaGtoZkxIZng3clRj?=
 =?utf-8?B?aHBkTXowd1htNjc2VXZZRWFSRkVhejNBbURBL3Z0WEdrRDdoSUlqUGJtYkhC?=
 =?utf-8?B?YktUZXRzaHJrU0ZHUzBSM1ZEeHVsdTZIQWZ6enllYVNBdWNyeVptaGF3cWJt?=
 =?utf-8?B?Z3prZEhPYm1pcWsvWVh1U3pZdUxBbFRyQ0FCVG1YT05HZVZHa3RvZGRZSDZX?=
 =?utf-8?B?TGdhTTV5cDZUNEhyVTFLcTZPNnEyZnVDSDJKUUhkMVdWQkNmZnNHTFZNTXkx?=
 =?utf-8?B?SzQzVXlaakxhb21UNnpMNUdsUjhxVWVydFNPN3FQdjNlMjgxc1NocVViVHhn?=
 =?utf-8?B?RFVCbW5CRlJ3cjVuUll1MmZxQlkzTG1oWXFTL2htVVNEQldNaUIwam1jRnh2?=
 =?utf-8?B?ZGxBVmdHUWtETy9jbUtGR3VnNXFjYmVrVkFTMUVobjNwdFFtVGxlcEJWSkhP?=
 =?utf-8?B?Q3JSOUx5Y1JaN0cvT3BQSHhGU1Ezd2J4WW5wSHRuM1Eyb0h3dC8rdGtQaEdj?=
 =?utf-8?B?b2VFZEZheXZiUVVDMjlSaGl0ZXhSSU9wVldmQU5yVmFadS92SWQweFlDekQ1?=
 =?utf-8?B?WW9neVFCZXBEZW4ycFArejZNUzdKWVJXQjNOWmdUbGtXVm4zc1RsT1F2NG0v?=
 =?utf-8?B?Ym15R0w4cC9tOTlZS1BLWDRrVk9jbmFnRkdKNkpxZlo1QkdOSXRFR0REa3kr?=
 =?utf-8?B?UUdrNnRSTU9YbGhqc2NOd0xSUWt6UTZwcTdiZnRzQW9NTWNxdU5ZVzJCNWNw?=
 =?utf-8?B?Q2cwTVR4RU9KS0Y2YmFkT3QrTmFWN21GYkNwVXppWTN3dFFsNUQrekNmUGtC?=
 =?utf-8?B?bHQ4bkRUQnNlRVlpNUFOb1hTcHhBcjdHbERHckpKemdVRGlkdkU3Y1pGTTFV?=
 =?utf-8?B?eE41TG9CelA2UkdZcmlLT291S3NrOE1qTG1PRHh2amhlNzY3OEhRbUNJVkxs?=
 =?utf-8?B?Z1lMbE9CbE03NjdWSjdTNU5zSlhBRlR6eHJ0YzUwQjR1d2swbFNLcUE3dzh4?=
 =?utf-8?B?OFVkQkJhbHBweFRoOENZbW5ibjlaUWE3RGF3TVQydUhjYjBtVmpuYzJRWUpN?=
 =?utf-8?B?NW9xVW9uRGdJSFBRNzNxZzVibW9pZk11aGROa09qRVFoZTFEaFIxTFN4YWIy?=
 =?utf-8?B?VDhqNEtvbGJuR2ZrOUtGNENXRkhOUnJyMzBGY0xuT2dpM0ZCZHV3YjVnTThQ?=
 =?utf-8?B?cCt0L01Qek1XS28ya2JybkFFTGtRN3EvQ3NhZFdKaVhYbWV5bUFUVHBUNmYr?=
 =?utf-8?B?NG1JWGZUOEtaN2hpR3ZrdXB3bEZsYUVMTWdPa3FYcUdRS0ppZDhKWWJndlZx?=
 =?utf-8?B?RENZaHowUjlwZUp1d1dBWDdsNG93ZzRCai85WDJJUjlValF4V0JISEdjdEZJ?=
 =?utf-8?Q?rajWHzYB3S9JYG0SCtT3VLI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa6085a-4d90-43c5-ea0a-08d9f0f7f8c9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 02:56:47.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqQv8JoIPThmeDunc+dmvhMkTZm0tvr2knzRfzItWpaeN08l2FU9WMmftXnEC8UpP/s0QmQlNVn+XHVvp0KONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/2022 01:05, Paul Menzel wrote:
> Dear Mario,
> 
> 
> Am 14.02.22 um 17:07 schrieb Limonciello, Mario:
> 
>> +Hans
>>
>>> (For the records, is part of Linux since 5.16-rc2 (commit 
>>> 1527f69204fe).)
>>>
>>> Am 12.11.21 um 21:15 schrieb Mario Limonciello:
>>>> AMD requires that the SATA controller be configured for devsleep in 
>>>> order
>>>> for S0i3 entry to work properly.
>>>>
>>>> commit b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with
>>>> SLP_S0") sets up a kernel policy to enable devsleep on Intel mobile
>>>> platforms that are using s0ix.  Add the PCI ID for the SATA 
>>>> controller in
>>>> Green Sardine platforms to extend this policy by default for AMD based
>>>> systems using s0i3 as well.
>>>>
>>>> Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
>>>> BugLink:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
>>> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=04%7C01%7Cm
>>> ario.limonciello%40amd.com%7Ca32a202d437544cd2cbb08d9ef9112c0%7C3d
>>> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637804228648002522%7CU
>>> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>>> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=CbfImBnwc8uV1L5QRBuV
>>> PLkP72wpS9yif1UbUwykhNI%3D&amp;reserved=0
> 
> You have to love Microsoft Outlook.
> 
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/ata/ahci.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>>> index d60f34718b5d..1e1167e725a4 100644
>>>> --- a/drivers/ata/ahci.c
>>>> +++ b/drivers/ata/ahci.c
>>>> @@ -438,6 +438,7 @@ static const struct pci_device_id ahci_pci_tbl[] 
>>>> = {
>>>>        /* AMD */
>>>>        { PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>>>>        { PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>>> +    { PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green 
>>>> Sardine */
>>>
>>> Aren't 0x7900 and 0x7901 the same device only in different modes? I
>>> wonder, why different boards and different comments are used.
>>
>> No they aren't the same device in different modes.
>>
>> Reference:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fen%2Fsupport%2Ftech-docs%2Fprocessor-programming-reference-ppr-for-amd-family-19h-model-51h-revision-a1&amp;data=04%7C01%7CMario.Limonciello%40amd.com%7Cf25ec205dd2e46253a2208d9f0519b39%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637805055570772355%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=POXfSI626inWB7k73CqJF3IMp6y31r%2F%2BugdCXOkvydo%3D&amp;reserved=0 
>>
>> Page 33 has a table.
> 
> That table misses 0x7900h. (Where can I find it?) coreboot has 0x7900 
> defined for Cezanne:
> 
>      src/include/device/pci_ids.h:#define PCI_DEVICE_ID_AMD_CZ_SATA  0x7900
>      src/soc/amd/stoneyridge/include/soc/pci_devs.h: * SATA_IDE_IDEVID 
>               0x7900
> 

You can see that 0x7900 was introduced in the kernel back in 2013; well 
in advance of the controller used in Cezanne.

So I really don't believe that CZ in that context for coreboot means 
Cezanne.  It's from an earlier product.  I haven't referenced any older 
documentation to confirm anything but if I were to venture a guess based 
on those names you pasted it's probably introduced with Carrizo and 
continues to be used up until Stoney Ridge.


> The PCI database too [3]:
> 
>> FCH SATA Controller [IDE mode]

Just FYI the strings in the PCI database is based on empirical user 
submissions.  You shouldn't rely upon it to tell you what generations 
different devices are in.

For example I found recently on some family 19h laptops that they claim 
to have a family 17h DMIC according to GNOME Settings which stems back 
to a string that was in the PCI database.

When I encountered this I submitted a correction to make it more 
generic, but I'm sure there are plenty more like this.

> 
> 
>>> Additionally, the device 0x7901 is also present in desktop systems like
>>> Dell OptiPlex 5055 and MSI B350 MORTAR. Is `board_ahci_mobile` the right
>>> board then? Or should the flag `AHCI_HFLAG_IS_MOBILE` be renamed to
>>> avoid confusion?
>>
>> Are you having a problem or just want clarity in the enum definition?
> 
> It’s more about clarity, and understanding the two different entries.
> 
>> This was introduced by Hans in commit ebb82e3c79d2a to set LPM policy 
>> properly
>> for a number of mobile devices.
>>
>> My opinion here is that the policy being for "mobile" devices only is 
>> short sighted as power
>> consumption policy on desktops is also relevant as OEMs ship desktops 
>> that need to meet
>> various power regulations for those too.
>>
>> So I would be in the camp for renaming the flags.
> 
> Why can’t the LPM policy, if available(?), not be set for `board_ahci` 
> by default, so `board_ahci_mobile` could be removed?
> 
>>>>        /* AMD is using RAID class only for ahci controllers */
>>>>        { PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>>>          PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Freview.coreboot.org%2F10418&amp;data=04%7C01%7CMario.Limonciello%40amd.com%7Cf25ec205dd2e46253a2208d9f0519b39%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637805055570772355%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=vqX1NjUKE0STzvmKSWtJxhrrdQnH%2BmqAiXGuqNMQAt0%3D&amp;reserved=0 
> 
> [2]: 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Freview.coreboot.org%2F20200&amp;data=04%7C01%7CMario.Limonciello%40amd.com%7Cf25ec205dd2e46253a2208d9f0519b39%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637805055570772355%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=oz3K76NGXrp41wq%2B5QcPUtJG%2BfqxCGOTVojfYb%2BMIlw%3D&amp;reserved=0 
> 
> [3]: 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpci-ids.ucw.cz%2Fread%2FPC%2F1022%2F7900&amp;data=04%7C01%7CMario.Limonciello%40amd.com%7Cf25ec205dd2e46253a2208d9f0519b39%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637805055570772355%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Y32YS5rIxBXTyNQ8VOuTxBTbfsOipBcIPAvmhBhSz7E%3D&amp;reserved=0 
> 

