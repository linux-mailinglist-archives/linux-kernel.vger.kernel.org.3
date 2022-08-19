Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68F59A168
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352416AbiHSQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352622AbiHSQRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:17:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B9118276;
        Fri, 19 Aug 2022 09:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2azQMjNKSXlv+9X1CuyvFyuajLBufkDM8mYreIBJOr7bKP6lfzH97GZxvU6vdQ8aq1sy8W0TK0kyl9nFUt3SRhK0RAW9O3HYSxzfRk49zNRyKRLnZYAccfdV3Hrz/iyQTidAqYmy7ols8MFTjCe5o5oDsxaxraXH3ki8VRbyug73VbtThhiJcREEL2RdMAq9Oba+7jADXnaFkc6aMLsHCkZmf4q4LjhOymKYIlfVv7RQaPOVa3yyJRGBgBu7MP2pSMoViIH9rvsH/RfzGvs253NIKdUEikZVdvRIp0llFNkKrHwykVtiUYkNcy/cnxKguzYFVgyeV96cW+mD7m83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDwO4T3WhBIQUPKk+XAGRq78pNK+V/p370SlVCRISxE=;
 b=f+S7SbyaS2QKj1oIIU7U1zu/taFikDdyfoT8N0zVLOXSOkORkwxixE3fonNGEH0C4XjsEndNt8yAhqZvMNV/gch0OYeE/2x6wXhSnnlFQhPPd3hU/lMF1oujJKDsxdCsyHUqaQIO76CntrxCGdMoFk+ejjr+cUeFoIS7AQnBVODGvgVwrWvIuGlTC8BX0rHa94qPBiTBOqDon78zRLMbraEa3M0b934aPlCza0II8ZLHbLF/fGON/fl6H2NyIEoBcj52r27SsagSrIj4oOgn8C9PS8sDKNX6j7OdwsikJpO06V60TCkSLkswrnCu8DH3kFAeEZHuZ331v/nsCKMFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDwO4T3WhBIQUPKk+XAGRq78pNK+V/p370SlVCRISxE=;
 b=tjAAgyovB+3yGZ4u3oqLOfovqgQgRC+nrxB7goeErLHFx2GvGbCP6Ym29v1C8ul0F67QvTvP3Q9H82akjX1Gj4CWajxY+sdEunmE4XnbJ5t50s9DWr6WIS32Mt/UKtRJUZSkr2h01d3AGIYCeQBuIqaTZMr/XEkWMry5X01xKec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 19 Aug
 2022 16:00:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 16:00:24 +0000
Message-ID: <57cf9b61-82f4-f6d4-7f43-c3f94de7aaf3@amd.com>
Date:   Fri, 19 Aug 2022 11:00:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC 0/2] Stop the abuse of Linux-* _OSI strings
Content-Language: en-US
To:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, Len Brown <lenb@kernel.org>,
        nouveau@lists.freedesktop.org, hdegoede@redhat.com,
        ddadap@nvidia.com, kai.heng.feng@canonical.com,
        Dell.Client.Kernel@dell.com
References: <20220819142519.5684-1-mario.limonciello@amd.com>
 <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:33::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff00e1e6-72ca-445e-e110-08da81fbed12
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyL/6Py01MuNfyTCUln+zkq745HdIiYw2qrW8HKak2tPyfAhlQvd6WadgMnlKTP1xc7+nwN02FW0r+cvDckxg9JbQZph7vJfCGCLqLXcmd+277W1rlyYBC1TLE09GTmdcQlolD+XmerA5qsbOXiIYptUyNuodZbxmk1WSZozm5fbbO8bPB6h8d6qej6YMjnba87DrOUtT8GPxhA0yILqXsWStrfD4CxToE/WiyJlM4JEwn3Dt8h7VmjXx0iB/LA83n9FyATtbV+IMbqUSeSSv85hmysSWdWQY6QwbrERT/25UevNwPysS+QCGkhB0mtNR8TbL0AKNNtQsycI3dn6xsmIGixjvo9Vog+YinhFcakA6cLeBINNic3lsj4MsWY+DZ+MZ8AdRGgbCzLdKEj06wy1V7R9bX4KYA/g3fg3HxPByNK7IQbhcR9JD6nKhS14C9PY44MycRnB9B2M90R/OD7sdo9Z5nqs42IzfdLBP6oWL0xkVyUtwJIqFdxncYIyTJl2Lqw/ptPYualBOnBgtKzCN3ZzsgcQKbYhJOt4zZhAkhDogPnSgEV+9UHNL5kOxTJCVSXPGbZ7L2zBX98JREBj2WXbbP97LKE5n2cK+d2rls5tDKK1ITrInfmkKPJSwFMws2qKoar7F6LePscCkI2qfOk5P+KX+3RvmRmum/KjqjxCXjNBIaKQuO1QGsVzYdU3ZT09r/F+HYHy40Jm9iYZvqiHh24qfm413kOqsHDPo33DZO2GHbzHzAjCQjKH7j1JyddcdEbIXWzS4RLjhfUjpHDsFdlfVGAAzyXvvcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(31696002)(41300700001)(26005)(6666004)(6506007)(86362001)(53546011)(6512007)(186003)(2616005)(31686004)(36756003)(478600001)(83380400001)(6486002)(110136005)(66946007)(38100700002)(8676002)(4326008)(66476007)(316002)(5660300002)(8936002)(66556008)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1dUUTR3dzNtb1NNWEUwU0I3NUk1QVpPZVAxd2EvZjFqQ1BWYkFIT1RpeWsr?=
 =?utf-8?B?QWZFOHZSK1YwMzBzZzVmbFBHaUVjMG1Gb0Z3dUptL2ZYd1IvVHlLN2REdmJK?=
 =?utf-8?B?NDNEV1F5VHBWSVVwZStPZmx0dVBwNHQ4WnRUeGZETlZVY0hKb2hqNDdzSlhq?=
 =?utf-8?B?WnBWOStXalFFRnpNb2MwZ01UYW4yc0F3UHdQZEsyL0t1Tzc5Y0lkcHRXTjB4?=
 =?utf-8?B?TFA4c1ZYcmMxaklqQmh3THNFaXFhMXdickRpaWxjMGh6RmtUZExzUTVhYUdX?=
 =?utf-8?B?ZmVuSjFGVFg4Y05MMmJ3YjhWZXUxM0YvQ0dxblRES1J2SEZyTklZbTBsOWRQ?=
 =?utf-8?B?d1FwZnNZcVd3N2psb1R1aGV0YkpXYzI3dTBhNEJnaTBUbmVLWTFJenluL1oz?=
 =?utf-8?B?TWhOYmpzS2s4ZjFidndoZUI1WDJqU3RGcjA2QVA2NkxydVEyOGRmN0cwbFBr?=
 =?utf-8?B?cUdka0daYUUrOVI3WUF4Y0ViLzJyTzREZDFtb2Vidk9qOVJJckk3QWp2STA5?=
 =?utf-8?B?bkRmZ2hNOUw4Y1pqZ0xwZXJxeU9jTlc5U2gyQ2tzcnhxN3ZzTDVkK2thNVJ2?=
 =?utf-8?B?ZGMvUHlMNDhXS0pvMkp5WXBqbjFab3gwejF1VFRNb3IreE9aSnNpeTlGb0Ro?=
 =?utf-8?B?WmFWWW94TkJmYkljcG8xNW85VmNxa0grWnNMOXpmUlpZM2NTT3pUUEFZV292?=
 =?utf-8?B?SnpBbnE3aEJMQ1NJSkZLU0NURHhmOGFlNEZEbDdLV3ZUYU1ENElvQllodDNz?=
 =?utf-8?B?cHFOa01hQkcrQXEvbUpxMm50ZlVrUVRxYU56UUlkR21McTdJeGJla3pZOXRJ?=
 =?utf-8?B?ZG5QeHZ6REdKMWt6cG95alRWOGVQVm5nNk9ZWktrbHp5M1pqSTVQTUN2ZFNR?=
 =?utf-8?B?SmVFaHdSNzM5b2VrVUZ4RHpHcXdDNmNGdW5acFlDeGU4VlhGQkxZUHZJSmls?=
 =?utf-8?B?K0hSNVBKdjdhaDF2WlVDRHdRWW5IT3FaYTBPOXV3NEtSTDdQRGVVMW8xbzUx?=
 =?utf-8?B?WTJHYTlQZkZWVUloRmFhVnU4NE1SZllzZENJQzVFeTZzdndKekxoM0ZlUmY0?=
 =?utf-8?B?cHFINFk4c0tEUUhycGg4ZzFUTWpKbVBQSDRqWWVYdlI1QXdhLzVEK0hrYkNk?=
 =?utf-8?B?aDJxQktYTlVPbWdhSWxveTBxMXErV1o5SWsrUmlMK3RoWDVxeStVaXhjQzlO?=
 =?utf-8?B?YWdLZnk4SVRueXVZRVFMWnN6WjhHTDVKQ2JKMFc1UFJObXd4VUdvMzdIZ3Zt?=
 =?utf-8?B?eEIwS1B5VmhGdEppTUJtZlppaWhSdUZtRk45Y0lRYklidUpJSVEranpqYnY1?=
 =?utf-8?B?cDZ1WEhTd2FWUnVxVEVWOHpocEZyNFZyNHNTOHZjV1dlRUxzVzRaOXFpZzJm?=
 =?utf-8?B?a2ZGSjVtNU03SzdtNlRreFg0Z1NXaEpGcjZFbVJyb25VWm9yaExOMDFydEcz?=
 =?utf-8?B?cEpId3dnbC81Vk53MTdGK3pUcnlQTnRoZGZyMmNTamUxekFxVU5vVVpUd1p0?=
 =?utf-8?B?aEgxdTU4Vk9hK1BtNlZOZGdkVjM3TGs4c3N2TEt6Q2NNYmwwS3dHSStvYUJq?=
 =?utf-8?B?WmY2ekhmaGQwRG5wbTluOEswTzFoQXZUNFlLZEVIVDV1RmkwMm51aHdLeVNa?=
 =?utf-8?B?TDRFUzlLNXhqeERxN0NCNVhxRmZEd0FrSTE1Vmh3NGI2MDcwTkZ0bGdzY2s1?=
 =?utf-8?B?aDZZcGNYMmhkN2E1dXp4Smk1Q2o0eERha3RicGVFNzRHOTJjYTdyL0cxa1A3?=
 =?utf-8?B?YWVvQnBSa0FpV3VxVmM0UUdTZzVBZmR5V2ZkMnZYK0NmOVkwR2VoMlN2VWZz?=
 =?utf-8?B?blVKbDRKZmJ0N2xmT0tvSkwrUVpScnNrWkJ1eWRuK3QwTngwbzB6am5nZ3JE?=
 =?utf-8?B?Yit2ODFhUm0vYnNnKy9IL3VmZm1ZUktRVFlLMDRhUXUraTRRZGFEcGtENlc1?=
 =?utf-8?B?dFJvd0lpWGJJTi9FUVR1UnBsaDBJQUVJVmFGTnVicEprY1A2eVhFVlhaclh4?=
 =?utf-8?B?R3NnajM1ZTRLUndUYjFoS2lEc2NXT20wSXhobzBFTWZhYTJpN2RKQUdwZFIy?=
 =?utf-8?B?OUplbGkvVC9GVTNuNjVRQjhjL1hJaDJHSFlweXcrQ2dKYm5lUkhVdnZBSWUv?=
 =?utf-8?Q?JbuVzIcfXDLwQsp9DxDezbNMM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff00e1e6-72ca-445e-e110-08da81fbed12
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 16:00:24.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2akRcDabx+IQfzQvMCAUVJ7bjlS2uv5AMiti4dPUhWsMhYrrz8111Ij5Q6eqc6sftx7ZnXWe1tvn/OD/uhUCaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/2022 10:44, Karol Herbst wrote:
> On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> 3 _OSI strings were introduced in recent years that were intended
>> to workaround very specific problems found on specific systems.
>>
>> The idea was supposed to be that these quirks were only used on
>> those systems, but this proved to be a bad assumption.  I've found
>> at least one system in the wild where the vendor using the _OSI
>> string doesn't match the _OSI string and the neither does the use.
>>
>> So this brings a good time to review keeping those strings in the kernel.
>> There are 3 strings that were introduced:
>>
>> Linux-Dell-Video
>> -> Intended for systems with NVIDIA cards that didn't support RTD3
>> Linux-Lenovo-NV-HDMI-Audio
>> -> Intended for powering on NVIDIA HDMI device
>> Linux-HPI-Hybrid-Graphics
>> -> Intended for changing dGPU output
>>
>> AFAIK the first string is no longer relevant as nouveau now supports
>> RTD3.  If that's wrong, this can be changed for the series.
>>
> 
> Nouveau always supported RTD3, because that's mainly a kernel feature.
> When those were introduced we simply had a bug only hit on a few
> systems. And instead of helping us to debug this, this workaround was
> added :( We were not even asked about this.

My apologies, I was certainly part of the impetus for this W/A in the 
first place while I was at my previous employer.  Your comment 
re-affirms to me that at least the first patch is correct.

> 
> I am a bit curious about the other two though as I am not even sure
> they are needed at all as we put other work arounds in place. @Lyude
> Paul might know more about these.
> 

If the other two really aren't needed anymore, then yeah we should just 
tear all 3 out.  If that's the direction we go, I would appreciate some 
commit IDs to reference in the commit message for tearing them out so 
that if they end up backporting to stable we know how far they should go.

