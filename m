Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1555B5A4BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiH2MfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiH2Me5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:34:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B17A1D19;
        Mon, 29 Aug 2022 05:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg44UQfdo+fks5KDR7XN8rhajhaMHnGshHKfbnMv2wYS69NB9vuQZAKMwvCn28uRvzvUIVhGKF6I40Dd1sYrGBeHvb5eW8WpPY+t0J1H1Y5BTXh+tHC6Qxmo+eo+l4xwPgX5hlfRlPq5TlSYM/ggqkygSS8fYvi9/Ldxn03w1vymH8xd5/5Tlf7q61iSLXqpx3Bt77utnSp/7xm4m0lMsTg9ffhyAKPfKtjCQ5NM0+2OgjnnVbnfsxv7r0SxZ5oLMW9Tgz/a7sazDMBX7w3F3MWPje4rKJi9LqfLmZ/djaX6jvafFi+Q2kyzBDR8+1pFZsf4SeHqrnU5bdzz+WSV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6c5WZQwUgy7OL/UXCPkfsvB+yvZP1YDxIWGTma8zzc=;
 b=jgAncVQ5DFEeNO6tJTXNl4yzbdCeaE7PPSBQu5Am3IKNodTJCOAwNcg8g/lh6AdtVdUh/J7o2dRjywxPyt4FLT+E2M0ZpLCj8G+MBHhmZJWA1nBCLQyAlILz5tb5Hc22Xlc5RgI8fs4FewVHC8JvhhN0yH6Gzg7g5L0nzLNIx8es3DLx1RI1ZVgj4/nDUzJJPfrs01WBZRiP/f/5HBZqQmbNMwAhzgnOfVab1J+XQLn0eBfw7r9dVP7i22E+6Lu2iAe3yRnVYMqYQ6tgW26TkI0pzLJ6HNd7IZiP1sFL+F8HmNjquoWl2hzU7FHC8xomJiAV/ilArWY2Vr5BolUzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6c5WZQwUgy7OL/UXCPkfsvB+yvZP1YDxIWGTma8zzc=;
 b=Pys0o8Ex5LNreGPyvlZeJEu4NFScteLMV6iHM/YhkH+f407VDFv99DyQHc6QKtPaBuC0ivlBpDpsJ4o5FPpmvgbIKcW/UpjnV4MEZ4cs19O00FMpd4I+v9vniHZODTVETaRy9JrPor06yocucWnrX5foucoflwv8IEpPaXqoktI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 12:17:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 12:17:50 +0000
Message-ID: <12b98ed4-6bc3-455c-3b90-a159d811147d@amd.com>
Date:   Mon, 29 Aug 2022 07:17:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] platform/x86: wmi: Lower verbosity of some duplicate GUID
 messages
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220826170053.2124-1-mario.limonciello@amd.com>
 <a547f88a-7ab2-e665-aa6d-d80ef74f4fd4@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a547f88a-7ab2-e665-aa6d-d80ef74f4fd4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0051.namprd05.prod.outlook.com
 (2603:10b6:803:41::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a13980f-01d1-4a86-ab8e-08da89b87dad
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueU5VEEDF1iBf7ffTYfaIbqmA+eSUO7MPbwkP1D2Taxey+/Zy4wPLSvZoX3TzcZKw8nkHRnc3YygAOVNBsGL25Rzg1x/pmgHugQ6GhQ7zyLdN2t5CRS1KFGJW77YTXNa0uh5lPITgrJziFE4Wk5dYhng8EH9L+/gDpjOoNsF+95U1iJx7Cia1z1Bxp2VDyzdVqF8s8/+KZvuIgMreHH7dYpwBTGH34nj2BZrMrcH4BVUkmAbKJ5J+LXjSrKOjeawozVtSjLezAmlfOOtqn5zM3iQ4H5jb7iWsanNcr6kYXiDthngzzII4ZA19b+r5vldgA3QgVE6rFSQn/s/PsrpP9k7xJV4OM8/l7orBN6x0IWCFfKF2BmkkmhuQMN+kCqiAqDzfzPxfum4H6EbFL0QZHreyBhcrP2U+I8DRWrgjmUnkYiZechUjRNYZZnjAYHu9m3kHAI/P7kxJPdI9P0oR3fY6LnxkAk7EHWRJy+fZ+PbAkIL6TtccbpwDSBZH96my8xJ2e51aoQ6dng0lNC4LpZ1bBXi/8ThlpQCaPnOp9HykG+wWcSvFq2Srlp/XjjPACMGr7/rcrxwzoW7clKCM5NGx7ioN+o26qWuoz7reayVtbXWKR0Rr01lcR+3aqhDIbcldjH9nb8KKpIGpiaVZvcvDrJgPCuO55GWRpdBEvInEGu/kaHL2z69XdkIqjWbL1h5jzPGmX8tf3iecTb8yqhn2x+SSQos0LZR3pb3WXu1BbfYhHC6C7O8ggglDBJDthTEtzuWd/FuEXawgLsfR9igoM+6HN8wWz438Nd5ot524bC/E7nGqnVsAC31CL7UViUmI6a6Q+IC8J/afAUdxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(110136005)(66476007)(66946007)(66556008)(5660300002)(15650500001)(8936002)(8676002)(4326008)(2616005)(31686004)(44832011)(45080400002)(316002)(36756003)(2906002)(6486002)(478600001)(41300700001)(6506007)(966005)(6512007)(86362001)(53546011)(31696002)(83380400001)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eklHTS9kN21RcGkxaGs4ckhOZnMwY29CaHlXTk9sNXhJTXdJakJpN0I4V3hH?=
 =?utf-8?B?eElzN3I3L3lZZ1NSOUdOc3FOWkx5RkZVV1hkRVFtVmpEZGVQVUpBTm9wdnVI?=
 =?utf-8?B?WUd3U2tHYStNNEczMStpamxNd1d0VW5WUnl1Q2YrNlcwRXVSNkx5OW9kUTZK?=
 =?utf-8?B?UVptQ1kyRkR3bTRNQUZsUnBxYk5KSmNuV2pBYUU0MVkxL1J2UTNlVlBobWZZ?=
 =?utf-8?B?bFI0empyd3l2Unc4SlNnU3dTN1NKTTBFVVFtMkd4NUdJZ0tJMTZDSlFPc3Fz?=
 =?utf-8?B?RlBkSlgwZ3hqdXFlTHZydFJVRmt1MlEvMzFGNEV2Z2taRGplS25CUXBhU05R?=
 =?utf-8?B?SDA5YXV2TmdxTGRVeUVCcHAvVitZWjRxWG1XNTI4M1hIeVR6b05TdkVJMVNY?=
 =?utf-8?B?UnNCUmtFNkpremJkV0wvYUdnaFl5S2poZXd0S0tGT21YTjFUUTZjYmlERDdQ?=
 =?utf-8?B?TzZVUUppNU9laEVOenhMOG9ZcDk3L0tYcGpEOXJTRnFwWHlycGhWeVl6dmVE?=
 =?utf-8?B?SjhyQmhnNGloT3ZEd2dNN0Q4MTViV2lLZGJmZkRUc2NYZ1Z3THF6eEt2L29R?=
 =?utf-8?B?amVtT2poV3BhcUtMempxYmRjaGN0aXFzVVhnS1lkWmtzdGJuQ1Q4NmM2OG9D?=
 =?utf-8?B?M2RSMHc5UFdoNi9TRjNNb1IvVFNRdjdyeUFwS2N1a3FvM2Zja29NRi9BYThm?=
 =?utf-8?B?SS9Td3pGMlgyeHp3KzF2UUpjSUhmdmQxNlN6ejFMbnNTekhac3Y3UFM5bUkr?=
 =?utf-8?B?NzF6VTRvNHVranRzTXNUKzU3eldFUFMvQW5DeHJzWlRNNU90cXRLYnVzSHZm?=
 =?utf-8?B?c3FmdmhDbnJaSWNkNVJOdWxUT3dMdTkreEMvZ1NXd0xNNlNOS3VISkpwU2Vt?=
 =?utf-8?B?L3NtUGRXb3pmY01yMy90NTMzTnAyRzA1K1ZUZzlPbHJ2K1doZGJkeHpuZC8v?=
 =?utf-8?B?dlkwWThmUWQ1UGxLZWQydHJ6YUxpQytsUE9jVDdsQ01sV214eWNTdzVCR2ZF?=
 =?utf-8?B?NUFmRDNWNmhkUnVZc0RqSUkreWkvR2o2OTNadjY3TUtMSHlyUE9sMVNSWDFS?=
 =?utf-8?B?QlBzLzZTVFZHdFRiVTBzazZNbHRaeUM5cE5OeC9RZ0xOQXZGUlZiVDVoVVRV?=
 =?utf-8?B?azhldVZyWlA2d3RPVHBiRWNtT2NiZUlkK2JnRDdEcnZlQXRQNUIrMCt2ZWNn?=
 =?utf-8?B?SThYYmN2c2VPZjBTd24vaVdtcjQ1NHJoMlRUakdJdlhKd0QwOENJSlE2di9v?=
 =?utf-8?B?WU94NlBSN2RZWTJqV2QyNFdvcStrZFhHNjYwMksrZjRmcWNLQkxDWXBlSldk?=
 =?utf-8?B?dGtvSjJJZWErN0gwME50ZVJ1UjBSVVFKOVlTTWFNL2F1RnpOaDZlOVJDVDVJ?=
 =?utf-8?B?V1ZkZzF0bklrdVJ3aUsxbStSY0hWbCsrdkFYL0xnUHVKejZQQmJCRlRrVmxz?=
 =?utf-8?B?MklOTjQySzFNckxSYTBleXBvV29aN1hOdENIdGVybXFEVjY5UTZmSy9UNmFO?=
 =?utf-8?B?aGJPR2crbVhiNjZJbEdTV3Q4VlJMTXd4TVFCbEdINkZvcnJaZnd5TjRmSWU3?=
 =?utf-8?B?MzNmN0Mrdy91L2Ficm5PbnhRT0ZJRWlxNktMR3haRGNUcUgzQXdJSlRUTnZI?=
 =?utf-8?B?ZGZWQysrRVJXVm9vL3NzbDFqZ1o4SEExdnYwL09FRCtGUmE3V1hTMDU2Tllh?=
 =?utf-8?B?Tk1yNlliT2F5SHRidUlIa2ZTeW56SXZMdmNTMjBmTjdJY1piZkh4TFo5YnBS?=
 =?utf-8?B?YXJVT3orTzVpT1FmYXF2UWprS2hHMnJwa2pUS2E2c0oremIwUUYrU0w5a3lk?=
 =?utf-8?B?REpablFFV1d3QTZiSWhGTFBVQ3ZZMVFSUi9rY2tRS3Z0Lzh4NFo3SlhQczBX?=
 =?utf-8?B?WTYyanl2L0RLbEk1WjNBWDM2cUxLMTF1U29lSVVIdWh0aTJnNi9tWUFsVTg1?=
 =?utf-8?B?c1I3aXNjUVFXZUh5NlM4eCtxZyt2aXkya0RCQW9lL2NtOWNWQldtdjhPekl6?=
 =?utf-8?B?ZFFlL2QweEs0RlNzWGQyOVZXdi85VlQ4MWhjYlQ3elY5ZGlHVHY5T2s4UXov?=
 =?utf-8?B?Mi9vbnNKWlgyejNTcFNVeE9xc1RKWmF5NjBtbjVpRWxIN0tlbVBJQStQWWxu?=
 =?utf-8?B?bGk3L2Q1Q05WZXpZNWxYT1Evelo3TjhNSDhZWTk4MDYzYjlyU2pzNmJJVmRl?=
 =?utf-8?Q?Rpw58XXVWmd7XyQyTPflyS03SYuvgpGBmMlYwYa8fjSe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a13980f-01d1-4a86-ab8e-08da89b87dad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 12:17:50.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4J3ThagOP3hatA90e07mScGv+EdlB3U4rL499eNdS0TjOaiUAqFK/K1EFZzWfWLzELis7fMrEH3TiFwnFluT7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 06:45, Hans de Goede wrote:
> Hi Mario,
> 
> On 8/26/22 19:00, Mario Limonciello wrote:
>> The WMI subsystem in the kernel currently tracks WMI devices by
>> a GUID string not by ACPI device.  The GUID used by the `wmi-bmof`
>> module however is available from many devices on nearly every machine.
>>
>> This originally was though to be a bug, but as it happens on most
>> machines it is a design mistake.  As there isn't an active need to
>> get the binary from each of the `wmi-bmof` device, special case it
>> and lower the message to debugging.  This will help to identify if
>> there are other duplicate GUIDs in the wild.
>>
>> If there are and the information contained in them is desirable it
>> may be worth considering a design change to the WMI subsystem to
>> access those.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2017%2F12%2F8%2F913&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Ce38feb41da464767725808da89b3efcc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637973703162395560%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=sGh1bVTcO7vXOF6%2BwibhS7nbSiH3aEEdVNGfanKkGF8%3D&amp;reserved=0
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I am a bit surprised by this patch. I though that there was
> consensus that the right thing to do here is actually create
> wmi-bus devices for the duplicate WMI-ids adding a numbered
> postfix to the extra devices (lets not add the postfix
> to the first device for each WMI GUID as some userspace
> code / scripts may depend on the sysfs paths not changing).
> 
> IMHO registering wmi-bus devices for all the WMI devices
> in the ACPI table would be the right thing to do ?

I don't disagree it's the correct eventual direction, but I looked at it 
and it seems to be a much larger overhaul because that means drivers 
would also need to be able to specify which ACPI device they're 
intending on interacting with from wmi.c rather than just a GUID string.

So before going down that path I think it's best to understand if it 
really is just wmi-bmof causing these cases or more cases (low priority 
IMO) or if there really is a strong need for the overhaul.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>> ---
>>   drivers/platform/x86/wmi-bmof.c |  2 --
>>   drivers/platform/x86/wmi.c      | 10 ++++++++--
>>   include/linux/wmi.h             |  2 ++
>>   3 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
>> index 80137afb9753..af46e9e03376 100644
>> --- a/drivers/platform/x86/wmi-bmof.c
>> +++ b/drivers/platform/x86/wmi-bmof.c
>> @@ -18,8 +18,6 @@
>>   #include <linux/types.h>
>>   #include <linux/wmi.h>
>>   
>> -#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>> -
>>   struct bmof_priv {
>>   	union acpi_object *bmofdata;
>>   	struct bin_attribute bmof_bin_attr;
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index aed293b5af81..d7a1f4bf443b 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -1157,6 +1157,9 @@ static void wmi_free_devices(struct acpi_device *device)
>>   static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
>>   {
>>   	struct wmi_block *wblock;
>> +	guid_t guid_wmi_bmof;
>> +
>> +	guid_parse(WMI_BMOF_GUID, &guid_wmi_bmof);
>>   
>>   	list_for_each_entry(wblock, &wmi_block_list, list) {
>>   		if (guid_equal(&wblock->gblock.guid, guid)) {
>> @@ -1166,8 +1169,11 @@ static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
>>   			 * we need to suppress GUIDs that are unique on a
>>   			 * given node but duplicated across nodes.
>>   			 */
>> -			dev_warn(&device->dev, "duplicate WMI GUID %pUL (first instance was on %s)\n",
>> -				 guid, dev_name(&wblock->acpi_device->dev));
>> +			if (guid_equal(guid, &guid_wmi_bmof))
>> +				dev_dbg(&device->dev, "duplicate WMI-BMOF GUID found\n");
>> +			else
>> +				dev_warn(&device->dev, "duplicate WMI GUID %pUL (first instance was on %s)\n",
>> +					 guid, dev_name(&wblock->acpi_device->dev));
>>   			return true;
>>   		}
>>   	}
>> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
>> index b88d7b58e61e..59acdceb4411 100644
>> --- a/include/linux/wmi.h
>> +++ b/include/linux/wmi.h
>> @@ -13,6 +13,8 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <uapi/linux/wmi.h>
>>   
>> +#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>> +
>>   struct wmi_device {
>>   	struct device dev;
>>   
> 

