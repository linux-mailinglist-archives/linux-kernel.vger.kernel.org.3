Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF858D02A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbiHHWf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiHHWfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:35:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB08D67
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPvxOfoTRB8CnUlIL8YEs950VgYi978kNbu7OJPh/dcjWyoDCvvuB9fcmGByOhOobH24SshdM8GWbodDKCIF7hCMFWU+SEIEpx2STjNz6QrTpsKb0lbKpFfkzhO+5Hsng7+7qvAeBFyVS71ABHemjhtkn6gQa8tJeT9e7f4DpZMNWRBWEe3dbo6uVfX1UwldvViHeYDPDM1vk7cmRaMyx2wQGLzR/jHW99mh+AP05SyFHjQI5O9gakELXn2Xury37FvRo0jcclH9pVgALAdmwNPOQKFdiS6Vh/HeDBPQjA7Ju8yVJCKYabiU7MvjGLCCuOiTRv9rBZemrlqk74p43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw7xpjBpUjAxPJGYpw8CGno0ihzwrWsF75oEoEeR/Pg=;
 b=Ovagm0HtSYxDwJgObKMgKMuYXe/Pj/i5Bpn/ElN7Tje4fcodTyApHD+3kP3ElK9Dltjt9lP403kLIhB2uWLA9e/AzdlQQYol8+N0OF87X+jDic+3Bu/mPbk/Q6eNknluafQwHVwRW/izC7JgYCGVReVuLhXFo1P6qMldCEjYy7S+GKPTIfnl7mweZ/y/mX6h+yEgn2l3Oov8mKKQRXCiYVrYvjLaZsknldJnHy0vUUDF7a0TJ/iD8IccsGX/Iq2xvLD3IcrcG8y6S3QVDCw2GtES6pa7sl6QVlzoBjAaRlZIlhgBwt2xHkoB2C2sHTAuD/yiz7lLNjOF0dM/Qa9h9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw7xpjBpUjAxPJGYpw8CGno0ihzwrWsF75oEoEeR/Pg=;
 b=M0qVLZj1Lm/2sQ1aDHrFZW4WuqbAKEQxlJTsqphfWRStbghReMtZR7IjPB/trvG+JEXlZRFtrL446P3dIFaB+Z8/tyRj6DSDICVRh1GESFbYpFDZtvRw70m6/hKPSWqaNk1V3xfGvo8E09sogNNbEUgu4Z7NYFnfEmsRJHr2AYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 22:35:19 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 22:35:19 +0000
Message-ID: <9a12299c-aad4-ca88-0f2c-6625556d4e33@amd.com>
Date:   Mon, 8 Aug 2022 17:35:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
 <50599c3c-eacb-7774-746c-021adf3f56e3@intel.com>
 <6b615140-4075-4fab-de23-e0c7cd3c64d8@amd.com>
 <77087e5b-ae81-8809-bf37-448d18c7b618@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <77087e5b-ae81-8809-bf37-448d18c7b618@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0043.namprd05.prod.outlook.com
 (2603:10b6:803:41::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3ead0cb-495b-4a9b-97d6-08da798e45e5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5048:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3g+vAI6xsfrYQvLelxpLsUUtZ8I211Q2gza4DEgtX1eYiYWJNeRtrNpUYBOwzeoR+/3PmlV8RCMsRw9g+W62XOKT61s7JPzsXUg2tUYoBl5DNinLaTyRKnXEX1dWPv24MLKBUrxq8pa/LNEhWCKgKoQ07b6FaTbRRSS0Gh8h1itIbKclh5SlEpc+n6fiUdfBllQlQFdNmklg4qaD3krIS8CIP9AupE1lvSTVgXXqK/OGHn0ZskFhLSvtM09hACJFkPXgNUE7i1I+iWKHQnZd6X7bzUkrzMMF6+3q100Aw1EBFgGJCqd2C0qZqaeieOImHqtG3/Bkpu6IXkG0yd4vIHhr7HZkv9TpuN7jnKkt1fRrm2H8BPJyb4ioPP5O/q4ryxwDT6uBrl22987GK6A8BfJ2Z1duYv4z2AFp3+yKSObi1ShX0y2FWQ9tJ/5zX4bIgBS1WfT98H75uIw27WS9AZQgyh38407/GHJD35TGUjQlqV+m1YQYc3SfuMtUMqMyYPK/Z0U504W0Fz+2M7OXmOeR5uzhVzLd6plctVEnl5ykTuRhGe3ymIYCfhW1Ih0QVjkRJ/y15TxOoj2S1xiRRGpcUX62skAjMNCJMprvOH6EJlRC4M5eakqXsZo9o0ZcYgaGnvK+ibvmapI8TN3G8w50eBq1IGx/8RoCZWpxINjEiXtlg0lR8N+TK+LAd+92KxDCevs5NMywtmJTFInLIk3lzZJEu6Yblk93meYU7gvDoM2MYESh2i+gVDiNliCzQLGkkUQO5O1OJ9YqB8GITsRIcxJE8mgV4xjM7vHcXy4ft3GY3hMgOtfSuS45hqHbq0nlpJOAM4Cikfu/u75Fgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(6512007)(86362001)(2616005)(186003)(38100700002)(31696002)(5660300002)(31686004)(7416002)(2906002)(316002)(4326008)(8676002)(54906003)(66476007)(36756003)(8936002)(66946007)(66556008)(6506007)(53546011)(6666004)(41300700001)(478600001)(6486002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFB5am9YRWJzME43SUV3NmFTaFdFWW8rZW5VYU50NXVLZ3hCVUtvRDZuajBQ?=
 =?utf-8?B?OGZ1bnp2anp1UllyZ1dPT0lVNXV5WnpNTUJCNWk0TGtiTHhld1FlR2gvOW04?=
 =?utf-8?B?bFNWUkN6M3l2YjExWGJJeVNqZG0vejNtZjc5ckdlbzRFZGFxekFsWFUxQVd5?=
 =?utf-8?B?TERDNkxRcWM3eEtpQ3d2VTVmYytDRW5HelBIbjY1U25NOXpvZWZXMll3bEZz?=
 =?utf-8?B?UjcyUzlZa0lnRlJuK0FCZzBXejZWN2F1TDZwZTNXWlprdCtqSHR1NEprdGJH?=
 =?utf-8?B?cThNNkhZUVhWY1Zndm9VeVhDNE1XZ1kwa3ByaWt0VXhoUUJwTEdHd2YxZERr?=
 =?utf-8?B?SE44N3RnU1JuZCtWaHU0OW9EUUFKRE1ITlVSQWVDNEFRbkRzL0Q0TzdZWk9R?=
 =?utf-8?B?YUwzZW13V3NQR21WcVVoTFpYNE82UWN5azZaaHhJTHl5eFRZOE9xbk53UlZD?=
 =?utf-8?B?ZXkyZElaaFpRVlE1RDdvTUdDOW12cGtFdEE5dGQ2YWxIR0NkSW1qM0NaajNn?=
 =?utf-8?B?bGVza2FyQzBXMHo2cXQzTHBYNUtleU5TdjAvN2piOE1FemFBNmRRQ2dDKzBp?=
 =?utf-8?B?OENKdlpsUXAxaHlMSlNGbHVTVklaSFBDS08wMGMxWTN6VlhRMjNja3RhdVAr?=
 =?utf-8?B?Y1RkcE1BRHNtQkxBUlgzQ2hDV25MTGZsVzVyOURPbG8xQ3Q2MDlPY1h4YTVr?=
 =?utf-8?B?bDJKTmhoM3k2Q0pockRhQ3p6clB2OXpieDF0aFBHQ3VDSmdCaWdtaFlDd1F4?=
 =?utf-8?B?OUpsKzd0dm0yVTRIMERRWGVRcDdwL2JodE00Wlh4azQyQW1LL2c1djk0Z3dJ?=
 =?utf-8?B?amIyOUlnQlFVOWZPYVd3cEZ5eWdSRGxJdlhuSjdweGQ5cXRWcVZielZ6TTRz?=
 =?utf-8?B?QkJobFJLR2RDdm1PUTdvbGc2dzVIUUZySEdUekhjK0dQY29rWWJRQVJoQU5s?=
 =?utf-8?B?RWNKeUFId3lqeXZicEc0aG82cjdmcVVvNXQ5TE12MDhWbUc3d2VJK2Y1ZXZP?=
 =?utf-8?B?NkNMbndhSENyKzIyM2pIOTMyZ0NJTXRuYnc1Zm1iZ2N4WHJRaVlYMGYvakhT?=
 =?utf-8?B?dUw3WWIvSTBPWnhHM1J3SXd5bVVNOHBTSEpXOXNJMmtsZnFsN3RYb28xMUwr?=
 =?utf-8?B?TktUZ0lmS3IxV1h3aDhzMnNqUnJIRGRGQlJSN1dUclZjaHRmT2JoaE1ZYWNa?=
 =?utf-8?B?Z0tuNXpiREFDME5vUHZhL1BleHJiZXBiZ2tVd3ZHYXZ2bVQ5ZFRtaVIzSXlZ?=
 =?utf-8?B?ZFhyWi93bE04V2wyZFU4YllaV3Ntbkdqd3Y5eFB2bng5Z0oyVG1VZkZ1ckNh?=
 =?utf-8?B?cEFBaEZXZWtvUHFncG5nYThTUmpBNnd2cW9UZm5XNnVKYjE4ZFBRWlpMTVhW?=
 =?utf-8?B?K0NPTkFGdWZNSDRDbFcwQmRvY2Y2ZkFlMEd3UU9XVndXMGRCUVU5MXpJZGFB?=
 =?utf-8?B?N3VOOXVhS2dicTZpWU1yWXhoSnFVUTR1MnZwZldpMGZDV01yZG85SzJnVjhq?=
 =?utf-8?B?dkRqSWdkVEhFR3Q3ZTREbmxzcTJJZnFwYkFha2I5WFd4RGo3ZkRMYkIxeWNl?=
 =?utf-8?B?Yldvc2Jza2FzVzdvUldtSEx4VjZuMmhqTWljMENDc1B5Q2drSUZzeUdDWTdJ?=
 =?utf-8?B?VUJDZGFlK0p4ejM3anRoRjg0RU5FRWJGaUk3TTNZbmpuQW9HWjFhSDl1bnFV?=
 =?utf-8?B?aFhEbzlVT0E5RFZ5Vm5kNEcrd3c0bWNQZW5FTERBbWdXdjMxSXpBVXhKUVNR?=
 =?utf-8?B?V2FTVHV3SUZHcmZrUTdRUGgwY0crWUpqUGlMcWg4LzdVVWw2NThmbk5od1Uz?=
 =?utf-8?B?QXpmWFl4Vi9PeFROb1FKeE5FK0o4RXFpdy9wZzNmWXE4aUg2NzJCWUl4K3pC?=
 =?utf-8?B?d3I0Y05hZWxxOUZrSjQ0Q25iNWlqdHNwZXVsS3pDRHpxOWxEMFYzeFpRMXQy?=
 =?utf-8?B?OURsci9YdzJzY2Rvdm81K3Zocll6c0p6ZDVZUWlPZllnTS9nZFhodjJrcHpS?=
 =?utf-8?B?TmF2Kzlnazk2dGgvYmZ2S1NON1NDcWZFRHQzdTZSUXhxWkhMZGxnME9wdW9B?=
 =?utf-8?B?eGQ2SFA5MXdxMEpkYlZCNnBUSGYwcVZiVlJyRnVjYnBLUmJrSEhmUFc0Yk10?=
 =?utf-8?Q?w/zJgN+DGteTlSbIdztg8jgGr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ead0cb-495b-4a9b-97d6-08da798e45e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 22:35:19.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n8zVkAp3EjZW+UCnvQEVNqBRcK4k/SpnMEB2oveZOCriBcSs2rzrW7YB3c7VesMlZXKiOcfYH1kiCLwxnesRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 17:33, Dave Hansen wrote:
> On 8/8/22 15:18, Tom Lendacky wrote:
>>>>    +/* Flag to indicate when the first per-CPU GHCB is registered */
>>>> +static bool ghcb_percpu_ready __section(".data");
>>>
>>> So, there's a code path that can't be entered until this is set?  Seems
>>> like the least we can do it annotate that path with a
>>> WARN_ON_ONCE(!ghcb_percpu_ready).
>>
>> Sure, that can be added. Right now the only function that calls
>> vmgexit_psc() is covered (set_pages_state()/__set_pages_state()) and is
>> doing the right thing. But I guess if anything is added in the future,
>> that will provide details on what happened.
>>
>>>
>>> Also, how does having _one_ global variable work for indicating the
>>> state of multiple per-cpu structures?  The code doesn't seem to delay
>>> setting this variable until after _all_ of the per-cpu state is ready.
>>
>> All of the per-CPU GHCBs are allocated during the BSP boot, before any
>> AP is started. The APs only ever run the kernel_exc_vmm_communication()
>> #VC handler and only ever use the per-CPU version of the GHCB, never the
>> early boot version. This is based on the initial_vc_handler being
>> switched to the runtime #VC handler, kernel_exc_vmm_communication.
>>
>> The trigger for the switch over for the BSP from the early boot GHCB to
>> the per-CPU GHCB is during setup_ghcb() after the initial_vc_handler has
>> been switched to kernel_exc_vmm_communication, which is just after the
>> per-CPU allocations. By putting the setting of the ghcb_percpu_ready in
>> setup_ghcb(), it indicates that the BSP per-CPU GHCB has been registered
>> and can be used.
> 
> That description makes the proposed comment even more confusing:
> 
> 	/* Flag to indicate when the first per-CPU GHCB is registered */
> 
> The important thing is that this variable is only _useful_ for the boot
> CPU.  After the boot CPU has allocated space for _itself_, it can then
> go and stop using the MSR-based method.
> 
> The reason it's set after "the first" is because "the first" is also the
> boot CPU, but referring to it as the "the first" is a bit oblique.
> Maybe something like this:
> 
> 	/*
> 	 * Set after the boot CPU's GHCB is registered.  At that point,
> 	 * it can be used for calls instead of MSRs.
> 	 */

Sure, I'll work on the wording.

Thanks,
Tom
