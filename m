Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B44F3E16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354903AbiDEMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiDEIwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2AD64DB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZK02BCPoXxYY6I3Ak+MfByJrZ9yN5qnU8mQhupAISxha2DswCPMORNwdyq9b3XKaMotYj1g/BWqLKqo6si5z33WYMP6RlG550a/jh0uivxzvb6bu7T2tD0v1yb01+o3ao5Q0q3EiJJ81Rh6WOwed41xgKqquS2+5UODqD6dBhs94rIOsJPkqDqRA5XZV1q8tQSQyNZiXj/4j3tMeGrpQg89CXQEKApk2P3Pns7UkaZ4ry3GwaAOi8+FM8KknjUzUeBbFgjzVQ6X/bXy3UTsQJ5TNmdRt3/Qp3f+v6xwlzlxplAQ/jGGl4WrCoPQQ8xUM+tmG/GYr7YK1iRvLVpvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fifLUnxgvwwG3se9OpBNXDZnfpHHII4EU2/bYBBtEbY=;
 b=XdqqJTrIW8DX2dTHtT5QJeOFmQA9IvFwHKp29VTRfWGoKuKtPhvL2VIGzP8z0nKl8l5ROcAZQIFlJibxkL7/91nLvWHC/SUDRoCG7lMakzgK1L1HEx7kVX0oIPWQAeKhQyHEmgN8Jjg9NaM0Tbgti9cz0pgiMK2r/UCQYjWNkUt+JPQSTDYv4O/mBQcbwAI70CyCubUsoCiP+arvOY0lvB1s/7OxOOstWKP0/LI9QMFFb3S2BKwiGDoVJKwAdxFczg+YeZVsQKTfKf6HqMkBNcEul7L1/oSlJxk3cdjFLJ7MOt0xKdYfb4SI1ik881CiSoceT6mPXqfMqWzC5dSA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fifLUnxgvwwG3se9OpBNXDZnfpHHII4EU2/bYBBtEbY=;
 b=C+C3nwptsfNfAnqTpDiIBR985dgMHgjUXCkx8w7grKuCnF+9amxoqPj/Nb9g10btvvTIUG4wnunDPF6zv4HnpIP7PDdBObIygkfddl+n6GbFT7IvHeCqhcAILZbvxZmdm/BS1nMm6DkPfRY2mOuR2KozyyoyVfNe1WD5eD9c+EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by CY4PR12MB1128.namprd12.prod.outlook.com (2603:10b6:903:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 08:40:57 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 08:40:57 +0000
Message-ID: <7da72067-6196-932d-92d0-1ff2018cee7f@amd.com>
Date:   Tue, 5 Apr 2022 14:10:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shuah@kernel.org,
        Oleg Nesterov <oleg@redhat.com>, ananth.narayan@amd.com
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
 <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
 <20220405081427.GD30877@worktop.programming.kicks-ass.net>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220405081427.GD30877@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f403a659-79e5-4497-b92c-08da16e000e9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1128:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB11287B29367C7F6DAEF0F37EB0E49@CY4PR12MB1128.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzBYCE7xooZPh4LmCphwCk7hUqdzuPDw6pYgh7R1OOJE2oi0BtRiORyo1fmBj2bphVnJfMppux1Zq6+jIC8DTj4kQ8rRcbfuGM4xemaHbQ9mB+YPYbwrZ/rI+GMbt/sI93DzD6D/rv3WEmo4Fh9CNDWyXeXiZrvzUixk01GFEqaXdcipOe1gC0WZxQz6pH1m/f2CRY9zaddOzFHe3mhl4daRyqlruuhmYXQf0F1+GZFycuFoyt4KtH5Zi7h9/gZy/yv/4wiK3jv3YTMTpGqkL7EtL/bRYpumPm+g99hn1AOl/Nu58SN8wx8w1dAwSdYa9mmArg05P594raC1R66AjarINCGS5T2ISflfnAn53ArdK+phYS1RGpYrlunfo0+deLGyKsjkv3MtSPtDjhefGXL8ZsiKGHcvi/J1WjN9+iPXYPZSq46cvJ8GzsV6C/tJ5D5vn0WX5bxyNLdCrSRltrDAPqw6upuWFrKqDXCucJqeERrG4bmEf2ARMK19UgGYcbZ4puDyZ88V7UDmXVbJnjp376D8xey4f9iAxhBpCaB+QrT/pPOeiMgCC4nhYtiMs/zCtKW06apMuIju20jtwMVawNYrn1Xg7ZFzH38DDpdDoGb3R5Wz+dCXoJTMk3MQb7TuWEi/nKCPdhpdAJx2iWaDOTQczm2WQgC7f2A3dXStOrwXnIYskrvtuGpatj0BEnxqvhW3MG7Z4ArPdlmZ3imK+3CGbWOKVfdxZamvU4cDGOrRak4gD0WdSO56tmPC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(316002)(6916009)(2616005)(186003)(53546011)(31696002)(26005)(6506007)(31686004)(6512007)(38100700002)(5660300002)(54906003)(86362001)(36756003)(83380400001)(8936002)(6486002)(8676002)(4326008)(2906002)(6666004)(66476007)(66946007)(66556008)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3RYN0xNZWk4QTN3eG1XK2tpNXI3aDdYRTIxcUYwRlNYNFR4ZHVvOUtUV2lD?=
 =?utf-8?B?Rzk5SUtFcFlXMzB6NGxTV0pTaG9XVWNYTDNYdGVmRDg1ZkdUQ1ExYTlEM3FV?=
 =?utf-8?B?STN2WHRSZ2tBUCtiTTl1QnpGeUdXbnpzblJjempIdWdWRzh0d2RLU3AyOEdW?=
 =?utf-8?B?bzY0N3JTMkJpZkcrYzM1ZmJRQUY1MzNpK24yWDEyZVVLaWExOVBZN09XTXdl?=
 =?utf-8?B?b0srdVpIYXl3R2tmb0VRb0k3ODFybDJUK1FYdjVaa3lBdjU2R2Y1S0o1L013?=
 =?utf-8?B?N0FDMmNEWnEwMlR0ZmpSR2puTjhSbkN2b21Cd0V5NHRocjRzb21KeHpDNVc3?=
 =?utf-8?B?cGxYdkp0bjFYMFQwTkwxTHlacFdXQ3M0MG1OTG5rZHE3OHc1VGpCRnk4K3hj?=
 =?utf-8?B?ZzJHZEsva1V0MGo0VTNkeGdaZHRubHJ5RWNYaGd4V1VmSTRFVmluYnpMUjRY?=
 =?utf-8?B?NmRPWkh1S0o2WHFjQ05WdEdldjdTSzhqQVBQTFlnaHA4dW9RdFpIeGV6aDhH?=
 =?utf-8?B?azJob3ExOEE4d0VPSjVZVHpyT0kwS1BzWjhheldCU2JLS3BnbTcvZHduQ2t1?=
 =?utf-8?B?MDdQR3hyUGNEeVMzblZGMjN3RXpiVHRHRGQ4ak15d0dlWmg1dzJDQWhDSjBG?=
 =?utf-8?B?WVY3MWZGZHFkQzZ4MEU2bEQ0MUhTSnROSlZZZDl0UkFvY25wbC9NblBESk1J?=
 =?utf-8?B?MWJSWEMrT1BrdTNiTlA3NFRLeUw4NXBOczBraEhQa29obysxVmo3Rm9LMFlC?=
 =?utf-8?B?cCt5aGJUTmxsUzhqYUo5ZUVrd20ydTRwYkt4STZZN2pRb0FKeEppSU1ZcW9W?=
 =?utf-8?B?a0lNZFc1dUVsazczTVV2dnVTWG5JdHJ5TDlaSnE1WnpOQkZ3RzVuTmZpWlFC?=
 =?utf-8?B?T0Y5QnZ4enZ3REQ0cEtrOGNVS25HK29rcVp5UTlpdmZ2d1ZNWUx4RTB6WXhX?=
 =?utf-8?B?dnlaTUdFdlZrN0hLUEQxaHlOUW1lQVVlSnZ6VGxLSnlEWHNZd2xVbGZ1aURy?=
 =?utf-8?B?aWRwc2gxdk1zYUFOd3dGaFh5ZE40ZDhYZmtqbTBiNDY0bEZ5TWM0ZmJPcHhh?=
 =?utf-8?B?TUtmTDJSK2I1QWxTb2FWejVEODlLamd4UFZVVFZZY1JNQ293MUZDek16cVQ2?=
 =?utf-8?B?dityeGtiNHZIeGFhNlRrR0pDNGtkOW9BN0hNN2RLU2NhMnYzVlJic0FweXRx?=
 =?utf-8?B?WTFVY1BYNS9ZMzRhV1VWNmVydnc4NEJiNzV5OTI4Tyt3MkEvUDBDbFVpM0ZV?=
 =?utf-8?B?VERqc09pZ3dWenYvR2hCZ2Mva1RQQU9SMHRMcnV0QXNUL0ZlSDhqTnpnR2NI?=
 =?utf-8?B?K3FZZU1TS2NVcHpXNVdoU01BaEZhVWUyUnFPZzZybGR3MFFqQUVxczMxYzBq?=
 =?utf-8?B?NTFkL054WGtqbjJQWHptQUdSK2lJQy9GRENnUy9OeGVDOU5MZTh2NGxiQkJV?=
 =?utf-8?B?V3NURk05UzV3UzJCeld4V3JnVXlLdStjZlVESDFuL3ZXNVEwMWxqNUlUTHMy?=
 =?utf-8?B?ZFo4RmIxcFE5KzM4M3M4M1A2VkpqNHhnMTlaU0ZBZDhTV0wraExvc0F0U3hh?=
 =?utf-8?B?b1MySzlhcm82cDc2cVV6UTRvaHVUaDNMS2RZSzkrYzdwR0laNkVKamdLMlNq?=
 =?utf-8?B?YWswaTBBcUppN1lzRUE1dm1JRnlwZlUzTGRBcEtPSFNkdVV5cXNzTEgzSktB?=
 =?utf-8?B?b1RHMUVYcStONUxGU0czNXZPUGtKZHBPYi9weGhYaTY1SFF3L2k0blFDUExs?=
 =?utf-8?B?V3FkK2dVQ2V4ZXVESno2N1p1V3Z5blNwSCt4dUtBQ1hhWnlJL0FBRGZqdUt3?=
 =?utf-8?B?YXVEWHR2a1gvZlhRYjBER2dxTWtEbnhyQ096L1FGdnE0TzZKWXpuQkRqZVRD?=
 =?utf-8?B?VjlpZ0ZCdWFhYlhsemtla0ZZakxnYzdYQjFTM2x5RTlTU0M1dFFvUzQ3bXBC?=
 =?utf-8?B?Uk90bm82K2Z2MUhXWXdYNE5vZ0t6aVlVcW42aU4wSDdSR2c0aFFrUmJRMHF1?=
 =?utf-8?B?MVVVSkdNd3IyeExIUlF0M2dRUXVOdlNUbktuUlFOd1M1Q2FwY1RMZ3JweEpr?=
 =?utf-8?B?UGhGYTFwNDNnQ3kwdXlucU85Yjg0cVVOTEpsaGpLNEJhL1U0dVhlZnBQdW9o?=
 =?utf-8?B?dFNNcGxxbURZWmI1WEZudU8zVnc0OXRCR2dLT2IrYWJVZjFQazRqL25XM1h0?=
 =?utf-8?B?Vy8xMHlHSVpGWkVJdDNSVWVFcFNyaFhpc2Znd21XMy9teWw0U1RJN25nbEla?=
 =?utf-8?B?YjBuMFFEbTBaY1J4NUhRQXhDVmMzVHplRDFSazFIbGJJOWdaSXAraVVCYzgz?=
 =?utf-8?B?Qks0Tm54VS9wMDZhRERBSUpnVHk0TDc3SDcwNmtnTk5hMnY1Wm5aZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f403a659-79e5-4497-b92c-08da16e000e9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 08:40:57.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKu1xaeCWRQN6ib/E/ffAKPlQ9ZxCvXwrO+potYZNLDMbyx7TfdEX/TdlKYe3Ffr5Bl8W5ArGLApRnv9oycyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1128
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/2022 1:44 PM, Peter Zijlstra wrote:
> On Wed, Mar 23, 2022 at 01:18:41PM +0530, Bharata B Rao wrote:
>> On 3/22/2022 3:59 AM, Andy Lutomirski wrote:
> 
>>> I hate to be a pain, but I'm really not convinced that this feature
>>> is suitable for Linux.  There are a few reasons:
>>>
>>> Right now, the concept that the high bit of an address determines
>>> whether it's a user or a kernel address is fairly fundamental to the
>>> x86_64 (and x86_32!) code.  It may not be strictly necessary to
>>> preserve this, but violating it would require substantial thought.
>>> With UAI enabled, kernel and user addresses are, functionally,
>>> interleaved.  This makes things like access_ok checks, and more
>>> generally anything that operates on a range of addresses, behave
>>> potentially quite differently.  A lot of auditing of existing code
>>> would be needed to make it safe.
>>
>> Ok got that. However can you point to me a few instances in the current
>> kernel code where such assumption of high bit being user/kernel address
>> differentiator exists so that I get some idea of what it takes to
>> audit all such cases?
> 
> The fact that you have to ask and can't readily find them should be a
> big honking clue on its own, no?
> 
> Anyway, see here:
> 
> arch/x86/events/perf_event.h:static inline bool kernel_ip(unsigned long ip)
> arch/x86/events/perf_event.h:{
> arch/x86/events/perf_event.h:#ifdef CONFIG_X86_32
> arch/x86/events/perf_event.h:   return ip > PAGE_OFFSET;
> arch/x86/events/perf_event.h:#else
> arch/x86/events/perf_event.h:   return (long)ip < 0;
> arch/x86/events/perf_event.h:#endif
> arch/x86/events/perf_event.h:}

That's a pretty good and clear example.

Thanks Peter. I do now see that auditing all such instances would be
an uphill task.

Regards,
Bharata.
