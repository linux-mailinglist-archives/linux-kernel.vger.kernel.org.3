Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6839555B604
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiF0EU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiF0EU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:20:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6762DFE;
        Sun, 26 Jun 2022 21:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1F/VDg7Bz/KX1Q7PzdWMwKlWZIlIRsB6yBtgUjw6HnhdLNGBVO8pWRXL+Wyuu4eOshZm+eOVSmKcd4ifCyGZAos+RLvOqnLoNEar0e3iB3gK+SGM13IjJrGPUHhVj0LyyAAbZD2x7Qk5hAXsQPdW3yTD4ZE4oMi+DrXluEWmAGk+xBaCnZKCCBv3pBqkrCt9Kfe5IEceOYRNaNxUUar/l5tri1b9TOh3RtWmwXj6O9rST1JE7wEIQxLq03SyynbuxQCM0o3vFpms/h6ghbYFjduooOzCNIo2yIVfgVGShmb21RAzdIjIaY+LSgO4lQz5HXbiLw1v084mPS3rF4RuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL7yPtAqgwRMtaX13Vm2PgYMFt2zayBiIccqUpp+UeI=;
 b=A+y+XQshbUSIC/Scd1pywuLiFrbTRqSWbPPvuSoLC7IV2HG7dhEa92tX3jbhZTp3TrbGxv9TBN++JrZxO+ux2hz6ceQYaX0U2YAET3NMHYC6j5y6b6Yh6kgdKrrECwQbHjS3/sdYDule5lgQFVJv+SKOzKCAohjdN0cXlgyjdhL+tcpeAHca8+2L4NA+UqaFTRpPup+FHw74YU1OPurcqrtyzFIKMRSXdI6j9mRA3leqUJRmqqJKvp5b6jb+aYcqfCaYaLjPew3nQ/yjdAMafJzxX4xTMDh8yJbgesmCveLITnlGNeVJ70RTwMz0fe94NWpU8StOXkYqKMR7T8vKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL7yPtAqgwRMtaX13Vm2PgYMFt2zayBiIccqUpp+UeI=;
 b=MGQcM6xbwnjs2bJaQCudAsVBOXNI0CGz8CApPf/c3PeXXXyerloz444gtNnhqk5c8jG/lzOY2dlWSQFRvcMJXY8YokmutThHtjFSNnir4zGQ05Vwo1dFGw5dt0rGN/D4ZiCsiLU8S9o5UelS024FxokJzzKeYmFt6Uca5SelktQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4026.namprd12.prod.outlook.com (2603:10b6:5:1cc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 04:20:54 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 04:20:54 +0000
Message-ID: <bded09a4-6954-2b03-4723-e6969c898b32@amd.com>
Date:   Mon, 27 Jun 2022 09:50:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 0/8] perf/amd: Zen4 IBS extensions support (tool
 changes)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        rrichter@amd.com, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>, like.xu.linux@gmail.com,
        x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
References: <20220604044519.594-1-ravi.bangoria@amd.com>
 <CAM9d7ci9Th4Aye51G+X5F12BiDXTnffZdj-A+HGRfUX_nWuQdw@mail.gmail.com>
 <YrXkFii1Fme9e1AE@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YrXkFii1Fme9e1AE@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91e2bf75-4f2c-47a7-7d03-08da57f46ce1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4026:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kBeTROnMS4eZgbJ7KWkZcZNK0UINszsKiCZGCt/7Z6akgRbyOlfQyYwi8CfQsBWeBhQNLuumjztNq4ua5RB2iZptZeUTeR3cAaA4z1/s64Jx9QIFmd7Cs1HkcRZT0w3q6C8EghgXwMxvlr0h+nahVYideZj8vqwqIYxJ3453njn5OV72yYaGSRB4WF4GTxPT+61qcscC5UKGFgS6f79B4uRZOHQR2eGbkCAOmvIjxhoGv7lRrlr3eyQFODUuwLKiA8dMt2eKZkqxdDzkomkH7fuo3TgvOoHkCnXPnmwuyGr2bL3yq9jUyDNfFBYQfybT1oxpqvpO1lOiJlvxfpk73wyP58cyZAU+tNgeCNLHzw4DdT3ENkur4rgaz3ykY3UJWTODFuDWK1CHde/Gc/h74AMhHfey0TzsmpuhO4RWPXjKHsJrgTphGXFZsZA+dd++5TSpLjxODSZegDAUOW1p/iIP1qUSrwn8gH+vr+mThfybmPa8+6uA9ZUWHRjNvLVIr21FPQR/A+fkNI8XMZCe9OQKumJZeup/LGXiKsAedtH7MyGEa0ihdib6KLkDr0y81Rm6vZ83kiVeNoBXEh8YSiHFoSco2KF2Upux8T0VU+CxtS2QnMPYNiixZZfkx5mjpLNlX58+pUjptAbTFnMzxGrSV6peaR63XNgXmzD7oxBOzL9A38dGyCIAtAEHIigxot/dkGhtcGD5t6XTJ7SnrFw8+fzDG23FOkBeHz0s0AA6hjvshDAH4Xf6r2awv0laV3T0dVARsEgRMA/qJHrE+7npNvFEbvSf7ILg8lAEicy36LKkyR6If/gL2/seX+epPioR4EQ7+lH8izog+tAYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(4744005)(7416002)(44832011)(6666004)(31696002)(38100700002)(2906002)(316002)(186003)(4326008)(8936002)(41300700001)(8676002)(5660300002)(478600001)(66476007)(86362001)(6486002)(6506007)(36756003)(2616005)(53546011)(66556008)(110136005)(54906003)(6512007)(66946007)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhnaTkrL1RjTURUZjIxZEc1blRYVFErWVlvVS9EK2Y3REJFUnJqQmFUek8z?=
 =?utf-8?B?NnMzYW1VUXUwZlNDa0VvZWFKQk5nM0ZLaTlPTWV6QnRzOU8yZi8xenZoa09K?=
 =?utf-8?B?QkJFSU5yWW04cXkxS0pQZkpFVytMZGw4UUJRTGJyWEhxT01zNXNMc1A3OXV4?=
 =?utf-8?B?bkwvNHB3NWp4N3F1WlBpb3ZrRHlVNEJsU2hLVGJwUHl6UDQ2eG9tdkNjNUcz?=
 =?utf-8?B?Z0pta0hSUjFRQTk2ZFRaTmg4S0xoV2xaWkNmN3oxWlE4aTZ6ZGFIUzF1L05n?=
 =?utf-8?B?MEkyUjR6bzE3Q1hjdDhqN3RWdFlsUUUwZVZhMGVvaFFjc1BIQnNmWUZaem5t?=
 =?utf-8?B?eUQyM0QwWTAzYzQvSXlmZDRYVyszN2ZiUWJrQitRYUdJRXpFZy90cjBlMlNt?=
 =?utf-8?B?U3FhbnNkQzF3VVNPajhHelZZSXpzN0hYSzdTdGV4bGV2cTFkcVVEWlZrSnh5?=
 =?utf-8?B?U2MwV2R5Rlp0Zm9hdTRLbVlqdXc2bHNFZmt1SFJnRXlabDFyNXFYTkpwN29o?=
 =?utf-8?B?cUY3NDVMTjd6bXE2bk5MaG1tcG9SREJCWmc4NjhyUjhmRTB2TWFpZkV5Kzhh?=
 =?utf-8?B?Q21UVFpDaWFNbGs2bnJNSUV3WkxxTHVzSHpMTTRITlo5UHlDYWRQZ0JheVRL?=
 =?utf-8?B?a2hNME9vM0EvZ2hxQXZqeXdzUVRMVDlUNkhTMTcwdGZyMlVoV1RueWc3WlB1?=
 =?utf-8?B?RGFTZ1JSMnlYZTByNFpXZWJ5THJkWjJ6MlNUbUFKR25rc1p0NWpvT0dsM1FY?=
 =?utf-8?B?ajdtWFF1dVNUTTJSM1B3cE9ZVjUvUkp4WUwvR0NQWHdWSXF2Vk1lTkRJNTlo?=
 =?utf-8?B?aVdnV0RqcFN1emFZOSs4OGtnb2laQTF1UkJzMDFaQmYxU2MwTm5QSi9uYWND?=
 =?utf-8?B?Q2VjaUJ2Z0FFQ3pKTCsyeHNocDdQaW9xMUh4WWZDZCt2N2pudmRXT3pCcDZ3?=
 =?utf-8?B?UWFUUEl3cjRaYWd1RitmZVdEUVJMczdKQ1JFc01zM2VKWmRjd2EwZjRIYlVB?=
 =?utf-8?B?bmY4VVNja1kxVFBSb3Y4Sk5HSDFBU04vRVJheDEzT2Z6cnIzcXhSb3VxRUJk?=
 =?utf-8?B?b3JwekVRZGxiMmpHd3h2TDMydytqVHR3Vi9MQXQ4Smprby9lbDdSNThVMHI1?=
 =?utf-8?B?c1FDZjJVRWNyS2VyNkdlSG5rcHkxQVNPWERGbVlzNzA5TVlsVHNtcG5PZVNN?=
 =?utf-8?B?bFZhbjJiNlVVZzFsZG9namc5L2p1ZTlCS0JZS29XTXFseTFic0tNMDRmeEc0?=
 =?utf-8?B?a1hCcC9iakJsQUZXczBkdUNBQlYxSldnYVdiUWNtRGRJaDRhMlpBakRCdENZ?=
 =?utf-8?B?QlY0SWVQTzQ2N0hIb1hGUkNWRGFjNFBMZnlSUlZzSGJhcllIU0hDQkh6WXBn?=
 =?utf-8?B?RmFTcC9oTmxsNU1MazNFcktWR0gxRUd5UFRrbldVYk11U21IdXA4Q0d4WjVL?=
 =?utf-8?B?REV3d2dIVG9ROHNsUTBQRXVuWFZsM1R2K0hEb3pka0Q5MFB5S1FjU0J5ZDBk?=
 =?utf-8?B?Rnh1Um0wMXNCbmREVkhiVFVPZEdoZTNzZU1CTTZlOWoveisxM0dWS1lWdC9j?=
 =?utf-8?B?NGY1bGxlMWk4akR0VTZjaEU5TWZEN3A4NHh6UFlFdzRhTWxPRHlKTEVDWkl5?=
 =?utf-8?B?ZzBCVHNXTlNSaElHallHWU9CUFUxRDJvRG9zdU9BMS9Ja2NKNklaWnk2YzFM?=
 =?utf-8?B?SHRWZnh6ZW9YLzhKbEhSY2VVdUVVcXZXcFJPMDZaSWo1MnhXdEV3Ti8rMERD?=
 =?utf-8?B?dkpZSUFGd0hPTjF4MWUvNzIrMExhUGFCTjhMUnRUanhrSTVKdkErZThEVy9m?=
 =?utf-8?B?eklwSzlZWVZLTlBwTURqd3JKVlI2YjFwNXZiL2lGaFRnNlo4ME9UNWRKYlJm?=
 =?utf-8?B?b2RjRW5aeUdjaXljQjhBaWhMR284elA0d3B4MjIrTis5a0dVcUlvOGNXcWx5?=
 =?utf-8?B?d0VHUU5uajZuTHJnOUJ2U3dVMVVsT29PTlBCY2pFcnJONGNjd0VlbU8xVlBk?=
 =?utf-8?B?aGkzSWhjc0x0SlRETXB1eE9ORjZySzlJMVV0YmFVYkpNVnJZb3pZU1YrZmRy?=
 =?utf-8?B?WkQxZEFMWm1aMjZROHdodzZXUERpT3p0dHFPMnRPOUZqTGNqWm84UGQrN1Av?=
 =?utf-8?Q?lbV7CmfNdeMOTwq1FnCaFFYvV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e2bf75-4f2c-47a7-7d03-08da57f46ce1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 04:20:54.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAozby/qsRVTUak3uLsxEeZ0bX7iZWC1XYzUUZN2O+v/wnN6kz/STPBzXdWOBqJLk3JQMmx7zxKKPB8MFog31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-Jun-22 9:49 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 06, 2022 at 04:46:57PM -0700, Namhyung Kim escreveu:
>> On Fri, Jun 3, 2022 at 9:46 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>> Ravi Bangoria (8):
>>>   perf record ibs: Warn about sampling period skew
>>>   perf tool: Parse pmu caps sysfs only once
>>>   perf headers: Pass "cpu" pmu name while printing caps
>>>   perf headers: Store pmu caps in an array of strings
>>>   perf headers: Record non-cpu pmu capabilities
>>>   perf/x86/ibs: Add new IBS register bits into header
>>>   perf tool ibs: Sync amd ibs header file
>>>   perf script ibs: Support new IBS bits in raw trace dump
>  
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks, applied the series to perf/core, except for "[PATCH v6 6/8]
> perf/x86/ibs: Add new IBS register bits into header", that is outside
> tools/.

Thanks Arnaldo.

Peter, Can you please pick up patch #6.

Thanks,
Ravi
