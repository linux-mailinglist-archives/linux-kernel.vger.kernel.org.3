Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABE64F0FE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377645AbiDDHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377643AbiDDHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:20:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1BC13D58;
        Mon,  4 Apr 2022 00:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fovhpo734H4krvdDVyH8o0N9lBNEBjccO/VJif1/OFEfoYChTgndLR2vOBIgbC5/SpR+5K6mw/kiBZ63Woj7/izCe7rDJY7kGOYJqa8b7s4g5fB92/4mv0v6PJhk7vFRqOaBO/X6JM3YX+vPr/s2/0egv/dOdvQR/RnxwrZa2z+ZU9SIb+Zskw2GYx2/2BFBcq80omvCWy8eoL55mWXxlr2OFxyEJKSWoOlI9GG7fXOP29SpZKpNQYqsLlTBgV4v5i8oiI9dHzZlvnDMEf7y1VnJ3EwbrTPwRuQQu5oibtmMaJqieaN7S+b0cjUPYveaG4T+0iG201PsGmZBxmJD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UUrzUZo9w7bCJPbRxK5Xob8+jJQoHjUS2u+StvVIGI=;
 b=nyhmCfCH/VrKAQI2+Zq+dYBZUy6cZuxgAhxA2d2wqT5aT+k3+UUnUvKKqjXCRUKeJA+pigxYaj9UW5m5svD+nehF2KlVHsaDVlQnZooWrtXMURGFAIdJp0sITGvpqZht6UawSVZ3YT8dSpjCCWY0OXypoWycOeELaiYrBinZK/uHzYFBJXkoZOi1WBTgQIp1E//tL2bVpzPs7Z/quIMQt+CsNmDlq5lsRahgzODNCP1F0kGuSwX+c5NA3qDGbMePT6Q68cqZ9pA2HaDD5ar5WxS5YFo98/VlEfW8n3mwBsRv7ltYEm34I7qZDuIuyOQbDsUqD9CPKhRbgL3ktt5e6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UUrzUZo9w7bCJPbRxK5Xob8+jJQoHjUS2u+StvVIGI=;
 b=KKH47zBV1iNiockVSxqMrxQGmexPkuaBxakI9omDJU4RWZYrOUKbF54EBMUTkKAv/5CUQBxsm3Np71TRXiu7A9GKCz0C0fY27v873SGB5aXmTm4CWr+d9bvjv1cmEnQ2dUYObHDZitznrqobcrFwrXoBIVo/q6oDgd/ONTqcrJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MWHPR12MB1837.namprd12.prod.outlook.com (2603:10b6:300:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 07:18:43 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 07:18:43 +0000
Message-ID: <7dfb121f-848c-873e-f3cc-43239c264f21@amd.com>
Date:   Mon, 4 Apr 2022 12:48:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression
 on amd_sfh on kernel 5.17
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Marco <rodomar705@protonmail.com>
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
 <0499f8ae-6966-be4b-5af8-e7e568bfcd5f@amd.com>
 <6fe27103-5e35-5f16-d213-29bd71412f5b@leemhuis.info>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <6fe27103-5e35-5f16-d213-29bd71412f5b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::33) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af90e545-52be-48cd-e7ba-08da160b59d2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1837:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1837B2E4E397801BE863F8E2E6E59@MWHPR12MB1837.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+vCs9dpWqRyliEmU4fJrF+tltDdlE2Fd4mpv+1peI8GNAt/2kNUGlqcHIvrh7eMSne4oU2lFEbF++GOphUD5RXOfLxz45KyQHSyexC5D5mccBVZ5GH/iSi98wiGEhM/rTOF8aHriVGCn5d0CBaEzt5D6FTDxKcgQVogash2/jyNT34a7fmDEpJ8zzQYeBvIToDO4zJP9LXvzLrCalJwv//lxTJefiIPgaZdAH7zlhqYzgXKOk1lEXon3TACXBToEcqWNUegtiSBr3eCyFH5g3O9Upz2se3+AH01SY/f0L2TVGW60pjelzHPNlaMdrs9896CZNMz/SpGylVNdo3W67jP/pc718nGj3CGQ4FafXEMT08by+BooSuZk/oA4rFZNTDKMQSm5xVlIk7wBY1ge/PT4yxYeQxBJQxzVXxjRlxkbCeLS/k1QyGGZwLXgzQG8v3gQSlmjmB5itDbd7W0oybx5IW/ERzSG2ZN/wqBcSsbCT9fl4sTpozJs4I288kBQCubS9dU094rK3i230Zfb3E9/wcMGlWzUowsqwsN0MAKWJVXMrmdD3EpYiAu/E4PUXJoNXmoobwr4/UECQqWI5VX0VNwPgwa2UJJqY5lGsHFBO4DakHNwZHMlERXVdw7hxlC2JFDpJxvFkLFNxE7gVt2P+qnQpV8j4VDF8VwsGhsAkkjMBdmrwYGXB7dF1cZFiB7rMcBQpYYGCHSb4ffLazu8PkHpIBth0r3FKPihImmpqg1mAb5Xn2hk2K8o9fpSP1uF7zDdruG0geHDwPq5wOIRr3ZBj18rLkvUTpAs9Y0BeSu7xu8EyuIpu5NqveH/7CHu3f6MtCJhh5+TJnCxDlZOHU0Itnk8Ne4Or2C8e0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(84040400005)(66946007)(66556008)(45080400002)(31686004)(6636002)(316002)(5660300002)(966005)(6486002)(66476007)(8676002)(4326008)(508600001)(54906003)(6506007)(36756003)(110136005)(53546011)(186003)(31696002)(2616005)(2906002)(26005)(6666004)(83380400001)(38100700002)(6512007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlVdHMxZitxR1RTdi9weGJpTU9BR1M0RU5Gb2FuTnAwZDYxeStWcFk0dUMr?=
 =?utf-8?B?K0VqL1ViWFZ2ZlFLUmZQNjEwSUwwTk1OVVRVSUh0SDd6Q0RQczZnbkc3YTRo?=
 =?utf-8?B?eDFEN2pFRHZ3UEdrWVV6MC94aWkwZDZ6a0RtZ0xxT05FR3F2dGRmOWNiNnJw?=
 =?utf-8?B?Q3FiM1lqVjhJekg4WEZsa0FUZG02M0VsbkRnVVRRVlh5OW1maC91SldUd1Nk?=
 =?utf-8?B?UDRmcjVWQjhveUpwS1hjck9qdGEvcXdDWVFHemR5Qmx3UklSb2w5Tm1kU29t?=
 =?utf-8?B?V2NiUmNaU1Irc0p2aWNVcElKbVl1SmJPcldrMEZBR1BWSUxxRy9mUStjdkNW?=
 =?utf-8?B?RlF3a0xiV2g0K0dUMWRFbW5Oc0toNnA1UUk4WmtRcE5uenhzUjVDcGJFNWtL?=
 =?utf-8?B?U1A3ZlM5Sit2N3hSOGczRC9CL1BpS0wzcVkyR2NTVnFrY0tJL2h3dW1jVTVO?=
 =?utf-8?B?eG1OWkRVOEJYZTN1NTVPQnVuWnBXUE1rL1M4SVVBK1crZCtObUFLSnY0Y0Yz?=
 =?utf-8?B?c0lNZ0IrbkhVWHR2dFdjWFdGY0crNE1Fdk12YjNvejZNVGRFSjY5dWQ2Y1lL?=
 =?utf-8?B?NGovejdMQ3M5ZlBJbDQ3TTRQV2Zna08wNFVRRFc0UUMrWkhHM1pJK1ZHcmpJ?=
 =?utf-8?B?SFNLOXpST3hnWTg2aUZjMVhqK3lUMVZZSlhGMlJHSDdQT09uQUlBY2tVNmM5?=
 =?utf-8?B?SU93NWhsVGtCU295MHNZYjRVUldvem90ZU14a0VyWnRSZWMxYXBnR1AyN1hj?=
 =?utf-8?B?aUdhL0xzTDAyOFJwMVhVN2NUNk5CUksrRERFdWh2dzVIajZDRlI0MmdOOWVz?=
 =?utf-8?B?YW5YVTdEejNkZFI4ZjhoRnNIMjYxcm9GZkMxYWhDck1mcW1lN0tTbXlPWDky?=
 =?utf-8?B?MGx6empTZDdlVjdzQ0NBcGNiWG1WQjhncG9wNVU5amQyRXlucWgybHpqeDdG?=
 =?utf-8?B?TWtoLzJKNGh2NSs1YmNGN3AyS0RDek5lYWFkKzZVZWh5UWV6VGU2VUFMc0c0?=
 =?utf-8?B?NXlZcXBxUWJwR21UZGt4TzYybjhVUGVPWGlhb1VlL2pWbmtNanlwb3dwaURJ?=
 =?utf-8?B?S0lMaHlxQzhRdzNhRllIQnFSRjZOWnBzVkpqUThicEFsSkpPb1MzRFJySmc3?=
 =?utf-8?B?cllPZ0ZrTThMTW9xaUhlVWc1OGU2VE94RC9GcG0ycnNMMzhGUDdOZjJZOXlF?=
 =?utf-8?B?MlVNOWNpbXJsUWh4RUJ5eHl2YU1zZmh0RkVGbDJKRFNiL1dOUFBycmFPNFVZ?=
 =?utf-8?B?VTFwWEl5K3pNbGd6aituSHB2U1RaMFh5ZENWdWc4MkNZdU1RM1dTWGhhYm5t?=
 =?utf-8?B?SEFuaEZZVlRlUEIweGRXdnEyU0JjRkVBNjBTMnh3VVVKYVliTHRoK2U1UFRG?=
 =?utf-8?B?WWk0SXQyNzNJOXI0VmYrM1BzT3hJaVovNU5GOFpyc1c2Z0JVY1JuUWEyV1RV?=
 =?utf-8?B?em9BVmZEb2k1amVUK2lDS05aODh4Q29uY09mZlR5TFJTNFpLb3Jvb0puWWtw?=
 =?utf-8?B?bTZnVzludXg5TkNmQWNmWGZsQ0N4b1FySTc1YXUwd1lHZ2tyQ0J5Nnh1Z0tG?=
 =?utf-8?B?WC9GTlF6YkpNZHF0bzRqWHR6dVVYSzljNXZqZURoNXhSSVhERkRWSXZEdkl1?=
 =?utf-8?B?VGk4d2RrejhMRHRDV2NvbEJ3Z2JtM0RwcWRPQ0hMbjliRmZodkxmNm9lSk9I?=
 =?utf-8?B?RWoxTHVXSkVOK1g2RWVmTHhrb3FQRlA4MHFuQzU2UTRkczh3K0tjTDdmKzZI?=
 =?utf-8?B?eWtPd2xKYzZrKzVQY09icE5IT0lpekxGWUJJZ2ozalVnelhEWjErdDBaOU1Q?=
 =?utf-8?B?YnN0TWZrS2R0S3BFT1BVYzg0bFBjalFzQXorTnZ3SE1RMXBRdVljejdLclVD?=
 =?utf-8?B?OUt5Yk5BNDNORmdNTFBwaEswdzdTWWxobEJ2bjhkUTYvajk3c1VyaENheTdo?=
 =?utf-8?B?SGw2WEl5elE2bHArTlNUU3hUTC9EZ0hUNmpYTVBqOWw0M3pKcDJCbHo2RUEz?=
 =?utf-8?B?Qlk4emFuWjNwVzR2QXZLWTA1VkpnWExQTWx5Nk9iYVhLT0t0MEplUkVmQlp4?=
 =?utf-8?B?MGZvQVE2MldBVFI0QnYyUFBJZWs5RGk3Q2tJbG9mVWVIMlhEK1F4aU96QTM1?=
 =?utf-8?B?bGtNSys0ekNYaVo3SklINUtzMS9PLzJnMGRpYTVGekJYVlp6eHJJVEVTR2NS?=
 =?utf-8?B?cjhpb0p4bU9YTldMUDh2eHVBSnkxaWRMMjdjaEgzOTJwZXVSZ1VmeXVMdllp?=
 =?utf-8?B?Rk4xTGloVnlrWW1jOUFNdHVTNkVUaUNSWTNyMjhodEpYOFRwMTBFbE9DeHdG?=
 =?utf-8?B?NlJFVWI4RGhHVXlwbDdobUxLWWFkQXZMaENtdy85QlF5ZEJVbUdVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af90e545-52be-48cd-e7ba-08da160b59d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 07:18:43.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGYXOSmkGSQQx+6+hZ2z+dOcFthevvvq8qvqTiHPUSvs1pntIimLhbGFYNlG5hfitolWZf34JdKHLPjtI5QmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1837
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2022 12:05 PM, Thorsten Leemhuis wrote:
> On 01.04.22 21:47, Basavaraj Natikar wrote:
>> Committed patch is disabling the interrupt mode and does not cause any
>> functionality or working issues.
> Well, for the reporter it clearly does cause problems, unless something
> in testing went sideways.
>
>> I also cross verified on 3 system and working fine on 5.17 and not able
>> to reproduce or recreate.
>> [...]
>> ------------------------------------------------
>>
>> Looks like this is not regression. May be some hardware/firmware bug.
> Well, from the point of the kernel development process it afaics is a
> regression, unless the testing went sideways. It doesn't matter if the
> root cause is in fact a hardware/firmware bug, as what matters in the
> scope of the kernel development is: things worked, and now they don't.
> For details please check this file and read the quotes from Linus:

can you help to answer the below questions:

Did you attempt to test it multiple times on the tip of the git to see
if the problems goes away?

if same test is performed multiple times with or without reverting patch
on same platform (laptop/hardware/firmware) on which issue is observed
we may see same working/issue behavior. if it is regressing then always
it should work with or without reverting patches on same laptop. is this
the case here?

I don't see any regression here. I requested to retest with other
hardware/platform/system also as per my above test (output) all working
fine in 3 different platforms and not able to reproduce or recreate for
my side on 5.17.

Thanks,

Basavaraj

>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git%2Fplain%2FDocumentation%2Fprocess%2Fhandling-regressions.rst&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7Ca64876e42c174bf2df5608da16054550%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846509153638366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nv4ZzNeRgRCrjnEgh5wHGcqSAHaCffdWxGm%2BsjiPu0Y%3D&amp;reserved=0
>
> Ciao, Thorsten
>
>> Just curious reverting this patch how it is working just suspecting
>> firmware undefined behavior.
>>
>> If possible, please check on other platform/system also if same behavior
>> occurs.
>>
>> Could you please provide me platform/system details so that I can check
>> this behavior?
>>
>> Thanks,
>> Basavaraj
>>
>> On 4/1/2022 1:36 PM, Thorsten Leemhuis wrote:
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>>> acted upon since it was reported about a week ago, that's why I decided
>>> to forward it to the lists and all people that seemed to be relevant
>>> here. It looks to me like this is something for Basavaraj, as it seems
>>> to be caused by	b300667b33b2 ("HID: amd_sfh: Disable the interrupt for
>>> all command"). But I'm not totally sure, I only looked briefly into the
>>> details. Or was this discussed somewhere else already? Or even fixed?
>>>
>>> To quote from https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7Ca64876e42c174bf2df5608da16054550%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846509153638366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=jXu50hKBHkHzjOrfEQ0sXme3%2BdliBd%2FleA%2F9oE61EpI%3D&amp;reserved=0 :
>>>
>>>>  Marco 2022-03-25 15:22:19 UTC
>>>>
>>>> After updating to 5.17, the input from the accelerometer disappeared, completely. No devices available from IIO tree. First bad commit causing it is https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2Fdrivers%2Fhid%2Famd-sfh-hid%2Famd_sfh_pcie.c%3Fid%3Db300667b33b2b5a2c8e5f8f22826befb3d7f4f2b&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7Ca64876e42c174bf2df5608da16054550%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846509153638366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=o443EB8xRW%2BwEi7pxB82A8B0oty64pBSQwAEU4sF2UA%3D&amp;reserved=0. Reverting this and the the other two on top fixed this. Tried to not revert only the above mentioned commit, but it's still not working.
>>>>
>>>> Marco.
>>> Anyway, to get this tracked:
>>>
>>> #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d7f4
>>> #regzbot from: Marco <rodomar705@protonmail.com>
>>> #regzbot title: input: hid: input from the accelerometer disappeared due
>>> to changes to amd_sfh
>>> #regzbot link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7Ca64876e42c174bf2df5608da16054550%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846509153638366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=jXu50hKBHkHzjOrfEQ0sXme3%2BdliBd%2FleA%2F9oE61EpI%3D&amp;reserved=0
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>
>>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>>> reports on my table. I can only look briefly into most of them and lack
>>> knowledge about most of the areas they concern. I thus unfortunately
>>> will sometimes get things wrong or miss something important. I hope
>>> that's not the case here; if you think it is, don't hesitate to tell me
>>> in a public reply, it's in everyone's interest to set the public record
>>> straight.
>>>
>>

