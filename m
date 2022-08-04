Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7ED589D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiHDNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiHDNvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:51:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3509D641E;
        Thu,  4 Aug 2022 06:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfh1BLjo10pbq6CrlTFkhU7MPmbhFnJMQQfOKQ0tYpYx94M5rZCEiJ7Wk1c1cO0aGbBj3BpEzaNUb0BYHAg6JR2lv6tjcZglquqqdcVvNd4UVYkxmD8T2KzmqtQZz7fGPf+/wNDSvFaGOKihHVDHh0F2G9t4/APfh6xNGSD81jTXWFEscm20deOZ5KAHMF2QvsUII53v5LgLuWkoa1azPV78uRgWNHCIuW/5huVhYjrfduz6+5DOkIh5LOIfFnAyYEL/GVIjLytgaZv8372qH5dvuoslmFZ/VpeneZBP56plcxk+DkkZ+DyOFoCdlDgImHzAZTTsfo33HLc9p/Q4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVh2T3N7o9cXMrQiwv4/5k1S/t9YN3bc/DyEYvyDDvs=;
 b=njfOEuq8i/dTX2ZAQHBy+lrWYldOcjZQwLVNhbiiaWhxGlEP/4biLdTrVarRuXSqDwL/QOh82kBDXDjb6mejq12jCHBZ5bXdgKsEeFHQ+kmjIAKJamTcPdZi9BoKbP4ob3eBf/Y1jdHcGLDrYM1+OPVkSrvF2f/2DKEtuljfHrdrtENNM6jAkFPYrDWOIEyJYHonBc8+B2wILqy9cp7MXw82mPC+Q99afiV/lxZImHTB64H6XorQQhaoCgQmYJArNJlEhewEuWCUOpy+JdOEU2OonFIvb6KxRuMP+O8zscMsY2Xc2SNze5CSu7Nqc5QS3sFh5YehXSBGCLhGCWhL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVh2T3N7o9cXMrQiwv4/5k1S/t9YN3bc/DyEYvyDDvs=;
 b=XyEcRtOlWv3xUKwGl/agsOM+cJF83DzeKAueXNTrpehX4OLAxarGZU2iZJaqQHjXtrjknPxf6+BZFvhKUNsW+sq3QIKY4+EfF6RoHoX24efPJ/5etfZPSbU1t5n6JLf/wAcgAMPbbd9Zk7IEZRDjgc7GvFgw57YABhIp39ok7II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN6PR12MB1284.namprd12.prod.outlook.com (2603:10b6:404:17::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 13:51:04 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 13:51:04 +0000
Message-ID: <cd0d79a9-310c-2181-401a-64a67f454c66@amd.com>
Date:   Thu, 4 Aug 2022 08:51:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] crypto: ccp: Load the firmware twice when SEV API version
 < 1.43
Content-Language: en-US
To:     Harald Hoyer <harald@profian.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220804010223.3619-1-jarkko@kernel.org>
 <58e8f9dc-a8d3-a2a5-2dd7-0783355e2567@amd.com>
 <de02389f-249d-f565-1136-4af3655fab2a@profian.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <de02389f-249d-f565-1136-4af3655fab2a@profian.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:610:60::40) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff2d3b7f-670e-4665-1cf3-08da76205fb7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1284:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJeFFN3r55IHrwbbkeCQAt6XyGCiYPOLF02vDaNiaotWZDwnxtNkEXo1mN8B84xDq7tQ4nvpvnNj/n+1sj9caeQX/Ie1rUZc1nqvpm2H+gheIOatT/ql+fvBqylDnisIyPrcJ3bAWJcVh8ZdN9mHA/0w7Z736BSiV9j2nxOkD/+0nMSjiHHVLJi9kfXzrhwSnOiDNUnatvq1i2YLAVqrm8o9QznLbJ+SaAruH1aOs32X30m2xOuj0zdxLdOFEbi/1H7fK/XiTkWX52Ur5ZYXQr7/IoxTsyPxmbyOdUFah1S+RGvsyPp5iAGPKun3vJF7qrrGUm4UxUuN0AQQi44XUMGLB5hP1cwoli4uIQZ43eP0CP3rePfi+rpC3e3aF7xZqXwyS7hj8kdFjSAMNnsN9wu7ZsoABPEr5E/nwI8vkhQQkHx0RgbEIgBi0Fwp9suLYaUC0lDgtjNYyCKwKU87gpht+DMSiunahTBnbaPoKFWHfDYSrjBAX453sdsF9gvp3t/v/7AlYFRkotPyk6DAr2dHv5HHPHvLZGwcxtmjAp6GMpdLZHNA0Y8zgZHBN906fhI8+pAPWR77ac9bhPUCqeu6wlI2WL0ReeYER2xBb/Qv36zig3Vzp0KfzA9CFud7xTv1wNSrDzln9ffxrc1jrRd6WnjEB+GMyQpCK+BsXH1B4KuHBB8VKufYo+TGFjgTXw/f/15Mk/YzTi9Cqtn2oypIfhdVLJM7TkOvQ4M7Xuv/Vkahh61zVoXV0LTu2fSvEH2tg1fjK4EbT4HGrXJ02be+hKRD1wNU40pJren1mzZ4AZ9uYWAJd9OOXdfbUHJznV2EkIaip2N868R+gk1+IfxyDKMknkVGLLgz03kfeyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(478600001)(6512007)(6506007)(26005)(53546011)(41300700001)(36756003)(31696002)(86362001)(2616005)(186003)(31686004)(54906003)(966005)(110136005)(6486002)(83380400001)(66476007)(66946007)(4326008)(5660300002)(316002)(8676002)(66556008)(38100700002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmRrZlpvcEVpSXFSTTlldU9MUnlHcmc4ZTAxT2VzeXFNS3pXZlFYUTRRK01M?=
 =?utf-8?B?ZUNJRzlnWFVIdCtHa0UzVHNteGJDZS9WWW9yUEJIY1Qzc2JIR3YyaERqaDM0?=
 =?utf-8?B?STNqTVRSVGU2SnQ1QjlaMER3b0lpSmdKT09paXFrS212eEdLQ1FKREQ1Q1Bi?=
 =?utf-8?B?TFlhZ0kveXNnUkY0OUZ4QjBKMzVOUU5pbFBRd29wQ3Z0NFFLSUtNRVFzaGNQ?=
 =?utf-8?B?bW5iaTh3Z0ptaVZnV2Z1VzdjajV4Zjh5Z1VUUzc2SUtRTU1jMmp3NzRvNmpq?=
 =?utf-8?B?Rmg5SHRGWHFQa2RFY3JrTU5IRFFOQnZ0MjQrZHhadGlYbGxIM3JVV1B3eUp0?=
 =?utf-8?B?VWt6dGhsTTY1WmZrdTVDenVXaVBSbTVDa0hXdXRvd2FCM0xVczlvcnFPVHNn?=
 =?utf-8?B?ZXI5L2VibXVFcThQa2pzMkVtZnpNcTcxWHYvS0FjNDRWTTZHdXRqQ2dtRnV5?=
 =?utf-8?B?V24zRTNTSEVlQzlYTHFUQnZSMUpFVmEzajBuRDRSM2pwcGV1SU5rTTNmQXdy?=
 =?utf-8?B?a1EwV21IdUREYy9QSlBrOVBwMStDSzhXcTM4Z2syQUR1b2FCS0hEbzFRei9V?=
 =?utf-8?B?TkZtSEZlckNNYllGN3oyMUhzNjd2aWsvNWJIUnJNSW93Qllxa1lYN0RadkRh?=
 =?utf-8?B?TGY4OExsYkF2RVcvZkZjdE9Db1JmL1BOOERCWkRxbU9jaFExUmFPYW9Lendj?=
 =?utf-8?B?YklSeWl1TGhXUUFnU21KaSt3S28yUndnT3RJUVJnOUYvRkxuNlBTZmFPa2sz?=
 =?utf-8?B?ckxHMkNnY3gvN3luM2gyTGUzQ1Iyc2pyTWlCTzcxZzlHQlRocDJsblBTMFI2?=
 =?utf-8?B?K2ZVM0dTdDBuRzlmNjhJd2RoY0pYM3o2QTNYVUpvaHBQS0tmM2xmanJWdWpC?=
 =?utf-8?B?ZU5QeUJZMFJodlB5aVA3RGhtSUVaa2ZPQ1hPR045bkM2UjdwaVdzZnFTNWs0?=
 =?utf-8?B?Tmk5NU44Z1lGdDlTdTNtbGRsbXpVMU5SOU5Tek9GNkcyZlg4TlRwVmhrdkJB?=
 =?utf-8?B?R2dOeFhtVjZ6SUFMZzhWNG5ZMU5ud1BuKzUyQ29oUTFvVnEvZzkvSmJFS1g5?=
 =?utf-8?B?MCt5Rnl1aDFtVFp4VTVDa1crWktLNEFGNDc5eWEvSW8xS1pGbEZ4TWUxZDlt?=
 =?utf-8?B?d0Ryc0EwQWZaSEx2Y0JnMjRsMm95UVdTbzFSSE5VVUV3Um1Lc0YzNGNDT0kx?=
 =?utf-8?B?NVNmQVBzS0E4WTNzY2c5c05uNW1XUkFyM3ZzbXhuWW9taTRYeWhjSUUrYk5u?=
 =?utf-8?B?TkNNcjRIRFNpdEhIcW1XcXB1SThIZFllc2lmSHh1V2JtRGV4NVFoQ01Rd2xC?=
 =?utf-8?B?UWlSR2VSdXorQURmRlY4UE5RazNpVnhLQ0didVNYeWUxRzJZVFUyQ2krRW95?=
 =?utf-8?B?djJOdGd1MjliNUdFYmVwL0pkWFI2MkVZZFlaa3RuaHA4VEpZODBxMnJpSm9S?=
 =?utf-8?B?eHVyaEY4SDRwUFVqMi80bG55cG1sNm5rRTlzb01nSW5LKzB5Qk9tbnlNSjJN?=
 =?utf-8?B?WlFvYzc0ZktBNk8za2FmRWdnVkMzczgxbzA2MWtBNXRMVDJQQ1dpNXorNWhD?=
 =?utf-8?B?amVRK3d5bG9tZkl4ZGNTK3NqbnZPU1ArUWNCS0xUSmh5Q2R4UVhUbXQxOHdO?=
 =?utf-8?B?SmlETTJNYmFwY29BRlZjL1VtVXpCTTd1dTVISFdQSDFsNENKVFJ6S3ZaVzlT?=
 =?utf-8?B?K3ZvZytJNURSeW4vOHRVWEd4MTQxNEE1YzFpUHlvaktKMkk1VlFEMmFqalNY?=
 =?utf-8?B?Y2NUVHJqWGdPOXl4eWp4MzF6TEU1dTlXZFlDR0FZempWZzhSNVk0dWxOZ01S?=
 =?utf-8?B?RE1VcjJjbnAwUUh3SkduNklTdkdwYkhXMW9RVnZuSnZJVU9nZTBlbDl5OGM3?=
 =?utf-8?B?aFl6VFJzKzBLT1JBWHZoZW9kdmxtZzAyWlZJQStCV2VJZTBCY0c2aFpsUjR0?=
 =?utf-8?B?QXh4aW1SRlFiK0JSdVpibXVkUXhTM2ZCakpxdXg1aFRZc05meGY4MjFPa2Fx?=
 =?utf-8?B?VWdobWx1eVBuWS9LZE1UelBMTFh4SVM2MS9sVWlzRE95T0J5aTF6YnI4aStJ?=
 =?utf-8?B?SkNSVDVTdmtybFJRMmhCbzVuL2N4TDVrR0VvNWllblg4M3QvUTY1NXBSR2xX?=
 =?utf-8?Q?M9DostzIqhMJexrOIAbD8nQbJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2d3b7f-670e-4665-1cf3-08da76205fb7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 13:51:04.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCE/MUNrkR1Rf3/sTw5md670aH3JvKvOSExW6ublzomwOdHYwHC6dyj+NUgmX/YiaE9/X9kLNJkE4NLJQAaN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 08:37, Harald Hoyer wrote:
> Am 04.08.22 um 15:13 schrieb Tom Lendacky:
>> On 8/3/22 20:02, Jarkko Sakkinen wrote:
>>> From: Jarkko Sakkinen <jarkko@profian.com>
>>>
>>> SEV-SNP does not initialize to a legit state, unless the firmware is
>>> loaded twice, when SEP API version < 1.43, and the firmware is updated
>>> to a later version. Because of this user space needs to work around
>>> this with "rmmod && modprobe" combo. Fix this by implementing the
>>> workaround to the driver.
>>
>> The SNP hypervisor patches are placing a minimum supported version
>> requirement for the SEV firmware that exceeds the specified version
>> above [1] (for the reason above, as well as some others), so this patch
>> is not needed, NAK.
> 
> As described in the "Milan Release Notes.txt" of the AMD firmware update 
> package amd_sev_fam19h_model0xh_1.33.03.zip.
> 
> "If upgrading to 1.33.01 or later from something older (picking up 
> CSF-1201), it is required that two Download Firmware commands be run to 
> fix the "Committed Version" across the firmware. CSF-1201 fixed a bug 
> where the committed version in the attestation report was incorrect. 
> Performing a single Download Firmware will upgrade the firmware, but 
> performing a second one will correct the committed version. This is a 
> one-time upgrade issue.
> "
> 
> Note that `1.33.01` is not the same version number as "1.51" in [1]. One 
> is the firmware version, the other is the SEV-SNP API version.

It is the same and are meant to correlate, the 33 is hex => 51.

> 
> I am definitely seeing a wrong TCB version, if the firmware is only 
> updated once to `1.33.01` aka "1.51".
> Reloading the `ccp` module, which triggers another firmware load, cures 
> the problem.
> 
> The patch might be wrong, as it might not do the right thing, but the 
> problem and the solution exist.
> 
> What is your suggestion then to fix the wrong committed TCB version?

Hmmm... ok, I see what you're saying. We don't want to have to make 
everyone update their BIOS/firmware to get to a starting level above 1.43 
to begin with.

Ok, let me review/comment on the patch.

Thanks,
Tom

> 
>>
>> [1] 
>> https://lore.kernel.org/lkml/87a0481526e66ddd5f6192cbb43a50708aee2883.1655761627.git.ashish.kalra@amd.com/ 
>>
>>
>> Thanks,
>> Tom
>>
>>>
>>> Reported-by: Harald Hoyer <harald@profian.com>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
>>> ---
>>>   drivers/crypto/ccp/sev-dev.c | 22 +++++++++++++++++++---
>>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>>> index 799b476fc3e8..f2abb7439dde 100644
>>> --- a/drivers/crypto/ccp/sev-dev.c
>>> +++ b/drivers/crypto/ccp/sev-dev.c
>>> @@ -76,6 +76,9 @@ static void *sev_es_tmr;
>>>   #define NV_LENGTH (32 * 1024)
>>>   static void *sev_init_ex_buffer;
>>> +/*
>>> + * SEV API version >= maj.min?
>>> + */
>>>   static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>>>   {
>>>       struct sev_device *sev = psp_master->sev_data;
>>> @@ -89,6 +92,14 @@ static inline bool sev_version_greater_or_equal(u8 
>>> maj, u8 min)
>>>       return false;
>>>   }
>>> +/*
>>> + * SEV API version < maj.min?
>>> + */
>>> +static inline bool sev_version_less(u8 maj, u8 min)
>>> +{
>>> +    return !sev_version_greater_or_equal(maj, min);
>>> +}
>>> +
>>>   static void sev_irq_handler(int irq, void *data, unsigned int status)
>>>   {
>>>       struct sev_device *sev = data;
>>> @@ -1274,6 +1285,7 @@ void sev_pci_init(void)
>>>   {
>>>       struct sev_device *sev = psp_master->sev_data;
>>>       int error, rc;
>>> +    int i;
>>>       if (!sev)
>>>           return;
>>> @@ -1283,9 +1295,13 @@ void sev_pci_init(void)
>>>       if (sev_get_api_version())
>>>           goto err;
>>> -    if (sev_version_greater_or_equal(0, 15) &&
>>> -        sev_update_firmware(sev->dev) == 0)
>>> -        sev_get_api_version();
>>> +    /*
>>> +     * SEV-SNP does not work properly before loading the FW twice in 
>>> the API
>>> +     * versions older than SEV 1.43.
>>> +     */
>>> +    for (i = 0; i < sev_version_greater_or_equal(0, 15) + 
>>> sev_version_less(1, 43); i++)
>>> +        if (sev_update_firmware(sev->dev) == 0)
>>> +            sev_get_api_version();
>>>       /* If an init_ex_path is provided rely on INIT_EX for PSP 
>>> initialization
>>>        * instead of INIT.
> 
