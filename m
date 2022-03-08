Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9541D4D1CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbiCHQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiCHQEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:04:00 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2137.outbound.protection.outlook.com [40.107.21.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2AA20F6F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:03:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDVV1pGUNKhysRL7EpoHdEvZ5vLSv7ChE1Ip6LBImfNcEW2wvHc76pzsxQhSlqz5cljipdpDiRnD2oR+IOpkCo7KltC79RA1dcv7n+0s3a/bS90yv3ZfVhT7jea4HKZA8Aw6WV24qwHUPwkLcQ1N7DJxhM/fIN75b9qil8QrvkBXFa9myChkksRtVn5f/WwJR/mrNUD+jAAMTzyoHQ8rXsGv1cXh7QzKsCqdQ6sGJiYe1qXDWHc6OZwmhr+thLGcoF/X+50Rt+GpnIvJ/VFUE8wAxVqYjMZu363PC1dqjhXIBXcOiqe6IkQ2sq8NKuKNkV2Wk+8O57jcfQTExkuO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee7kaV50oVgHt4QfkfGNUBbJGUSLPG6GZW6hGUtojbw=;
 b=BZ1CPPQKWXQ9sQjSfzRuyoF9EEvK+MRBN5zUOPk1tEr3buTAIAEP4dTBBQ4xq0/IPEsJhrcciWoevxbF6aaJ6yh1zdVtU4GakK/x1+TkPVJ0u3rinlSSoNRUnoa0U5ldXx7+yv1+yqu6C33iMAjRcST1famojPLzlKcGw3J7s88iEVHJhf83W1O5ivyV8tI+jbbdyHHxVb6iIwn0N4LKN9xQhXRRYz8h9tsvTbq4NjL/ZzVsnmEgj1Asre4hZGAOU/x7V+m0l0hGctBbtmOwIqwZOFiNnN225FJIHuhotuq7uDEMhgE8EyeK77hqCC7E3iPXRXWCms4h0CiCzv1Neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee7kaV50oVgHt4QfkfGNUBbJGUSLPG6GZW6hGUtojbw=;
 b=epKy3N+KKzLdGLYtn+JKjh/ZX+ug8FCgma9xI+mjavsB8crb9uIh+5xKZb60trW14mSmcdo92LViKsUZo2TtYHN1JZeV4oos4Utg08E4w+bDWighHHYDGvXdwLVTxDPyXTUax2jgM9gc6Cm7b4d75+S76fPBaaEl/F9+78e64YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by PA4PR07MB7518.eurprd07.prod.outlook.com (2603:10a6:102:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Tue, 8 Mar
 2022 16:02:59 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::30a5:64a8:1672:4169]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::30a5:64a8:1672:4169%4]) with mapi id 15.20.5061.018; Tue, 8 Mar 2022
 16:02:59 +0000
Message-ID: <1dec8992-b924-7ea2-8e45-a6bbc10a6086@nokia.com>
Date:   Tue, 8 Mar 2022 17:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: ftrace bug
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@linux.com>, Rabin Vincent <rabin@rab.in>,
        Colin Cross <ccross@android.com>
References: <9a86b2c9-1009-1683-442e-61c5a7dc8cf3@broadcom.com>
 <20220307082450.641ed866@gandalf.local.home>
 <62c01368-b67f-66af-2e31-d62f4df75b61@broadcom.com>
 <20220308102007.6c6618e7@gandalf.local.home>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <20220308102007.6c6618e7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::19) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de614d72-9d3c-422a-5af7-08da011d1d3c
X-MS-TrafficTypeDiagnostic: PA4PR07MB7518:EE_
X-Microsoft-Antispam-PRVS: <PA4PR07MB7518B35D8370980E8E82D10E88099@PA4PR07MB7518.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0AxuWT3WOVdTHp64ae/bm949WR8T1UTCM6hsikLah/oy+7FivHq/8IncguTzDqNlkOnVY0w0oDiXPwBlE9RWcKUMMZubHt3w4oRF/cAVxL3ocg3OSMR/+iuZvMJC+5Nh0NX+zwhkNrdZO5wSC4w5Pn9VAzbYPX/BlYtMSCaLO6g+aZLHkioeyhAHeHwEbKRp/3CMjFoPzgFgDw0EIkrNfTtg53Vpp8SuSs4zKiVQw/noADv/YpsCEgHjtNGvKSuiOgk2F3dLBuQOkrRa3b0ea5rUDmC9gm42RP5HUOJoyAd1FfytdHO4nq7QBaaIaDmw5i1olfo9deObT3GzgSPYxhPKQWrf+nXcBnF1ZYRaMnB2Wp7R9ocTtp5ul/if/YCr5xL3Uj08qSvFY8ZwsrItp0DUs2IxKg/E0cEovn+kdCiM1zAuToM6TAxM6k5XZbe594duASH4cSQc1VGbUAgsEiEXsiWxVq2+Raedo/9Cl6fvzfak+QPXk1bTKvSGtThPrx+CPsVddNGgznO82muOHY6Fuu4NXfvnrjUA1f0X7SyMkq0CibtAkOfnsec2c3KQbFkYJl4VAnypwRmHXxusA6v2DBcMYlwXC/hZR2mmgnRY0wbkaz5b5QNEkYxRewlis8H+HZr+gWFti8+GyVwEwJrMAS3GPVaOmiOcf1gJiiah2030vKE7LV7gMarrl2fzJZLtRm1mtUgDD0j8beToCxyjiLBv0yAQI+FXO1DOpbWChVA0Mva3UNLtSONy+1fFz9lCb57+SqzEEVh7O3PGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8936002)(5660300002)(66476007)(38350700002)(38100700002)(6486002)(508600001)(2906002)(26005)(2616005)(186003)(4326008)(44832011)(83380400001)(66946007)(3480700007)(53546011)(52116002)(66556008)(36756003)(7116003)(6512007)(6506007)(6666004)(8676002)(86362001)(54906003)(110136005)(31696002)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clU4UDFpak90T1JsK0lyTStPcTRrRlV0dFZYR3Buemx4QlNvQWlqb25BVXUy?=
 =?utf-8?B?NytERDZCMEp4S0hVZlM5bVJiKy9RZEhEVTNZbzMxQnZPZXU1eFVnT3llUUVq?=
 =?utf-8?B?QnpQYTdKaE5uOHk0UERyRUFoMjdrd3duVVc5VUl2dUc5QnZHSERnaEw3dUdq?=
 =?utf-8?B?MDRFdnlzazNIcHhMOWZMcWZvVFFaQ3N6VGFuR3RJVE1nYTJ1OWRSNlBWZndN?=
 =?utf-8?B?Uy9wR3pYUXJhbDFPMUFRT0ljZ1dBYkgvVGk4azNLTXlUUkR1NElpMExaeXc1?=
 =?utf-8?B?WXF5N3FDZVcrVVhRdS9xUEg0VjJBMWVlK3ptNlBGOG4vRnRRSGdTNUlQelRl?=
 =?utf-8?B?NXRnOEVUUUFHOHpETUVDZDJSdE45cEpsSCsrQU9UY056czdUVnhiVUJVTi95?=
 =?utf-8?B?M1FsR0xtRnJUOEdDdjc0RXJzRGlZazVxWVJvVDQ4YmhYRHJSRG9FMWp2OFBa?=
 =?utf-8?B?bW5IYXRkdGhlMDlCQUJ1a014cUduZlpGb1dLTHFDOEkwVE96YmRpb0hFeGI1?=
 =?utf-8?B?Nkg3QmRVUDJFaVFKN1UrNFVlTzdYekY2WDZWblBHU0RLRW5TcS95YjFWd0l0?=
 =?utf-8?B?SGpPQWhFcmNncms0bU8vTFd3bFR1YlQ3Y3VMUWtpdUZGeDY4MzlqSjQ1N1JM?=
 =?utf-8?B?eG9ZSUtFbUg3YUVMV0FCcURCVmkrWmtta0JqaUQwKy9iT3R3WWZtOHgrWWFB?=
 =?utf-8?B?eDRKQnBmY05IaW13V3ZyVXdZc1YzLzFrTVJIK29lUXhYaHJVNEFyaTVoeUg3?=
 =?utf-8?B?ZEFEbFZqMUtJUGpaUkVHaGo3M3JmS2pyZHIvRjlvRUZsVW1scUdQMVh2akc4?=
 =?utf-8?B?WkdLa0Q0emdSYWtNK0NtRHI4b0I3aTVaam92cytORmJtNk5hL2VHWjVzY0NR?=
 =?utf-8?B?N042MWp2cFRzRGlVOHZyTy81dnY1bDMrVjExTGRrNlBnSkZQakV2UWFGOUFx?=
 =?utf-8?B?MTdwb0hFYjV3dmdGb1kxbDJtS3BRYmFOU3dpcUhhV0JMajROQldHUlN0UVV6?=
 =?utf-8?B?L0o3cWZ0eE9SaTJaYnF4aWJyUnZEaFBTVFY3MkpQczRTRVF0dWFXZHo0VHRa?=
 =?utf-8?B?ZUVrbUhxdXNKWjhoZVZaRWJKMDQzREhxS3lDOW8ydmZlblB3c25DN1RMaGZI?=
 =?utf-8?B?NmVVbmlpaW5ldnNxNjJRUkFpZys4SmZYcFlSdVFPQUc0WFEzZXpiNm51RG9u?=
 =?utf-8?B?R2VzZFh0dHZjN1ZRL21ueE9vSjhYMytlWWN4cDFoMWowY0hIYzJqOGpoOGJa?=
 =?utf-8?B?eWE1WXNRT1RxaVlyMitnaEx5aVBOSWljbFpQcDJydFZCcWpzNVErbTZRaXgv?=
 =?utf-8?B?OFU3ZWxqejZUVmlhRVE0Z0JGWTBwSFMrbnlwTzF3bmdOWlIxVHc2cHhDcWFJ?=
 =?utf-8?B?c05sT1N0cld2bmFjZVdmWXVrYmdlcTRha0xqYnB4RUNWSEs2enlwSWFIS0dW?=
 =?utf-8?B?V2RXUmhlY0luRzlJSVFHL0RzdWtvR1JCME9FNXM3aUxhYk9OSk0xZXRCWDRv?=
 =?utf-8?B?MjhNOEFFTmJrWE8rNEdiVUNyVTVpV2xQMFQ3c1ZnR3M4d2dlQ1U2KzI4bDdN?=
 =?utf-8?B?cmRKMHJYUVJOUkNuQ1lNMHlQQVQ4QlhpQjlDcTZYTi9ITDlhcWhpdFhEbmpp?=
 =?utf-8?B?aHc0Y3ovMElJM1J0UmVQUFlEYlZlT0Zsc1VRczh4TExUaEg4R0ZxcThkV285?=
 =?utf-8?B?QzZmNHlIK0JEWVp5TFA1ZTQyTFJWRTlFeFRQVWh3dmVUaHFlMklmcXVsamtT?=
 =?utf-8?B?RmlBMDM4N0s5bUxYUUpBUmhZL0RXTWhyVVo0cXptL1hGU1U0U3BMSjdvZUdt?=
 =?utf-8?B?RmhJVkJwVEVrL2RQM2swZVU2WkMzU2NsNUZqbmhLNERjOThEcC9BcWk2ZVhi?=
 =?utf-8?B?ZmlUZmRPVFQvS3lMU3NYcFhJRkhUWXgwVmM4SjlRSEwxOCt4RjdwTXlyMmZk?=
 =?utf-8?B?NFl4NXJYWDdnb2xxYkhPNVI4UnkvUjBjYVQrSytMZzVrOUk2WDl3Tmx1elpK?=
 =?utf-8?Q?dac625ibEglvKOfPGctksir4JDbxrk=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de614d72-9d3c-422a-5af7-08da011d1d3c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:02:58.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj48iQE9CoNojPpfSu4M5JqyWuRg6RNNqQZXOz7mKuBES9/cFiNruWDzdrpVOcUoI27HmyIY+yGMIDlKAG5m/rltd7xDUuApK/ajuK2e5cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7518
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arend!

On 08/03/2022 16:20, Steven Rostedt wrote:
>>> I wanted to use FTRACE on an ARM platform and I hit the following
>>> warning which results in ftrace bug. This happens upon loading a module.
>>> Looking up the warning I suspect the branch target is too far off. The
>>> module is quite large and therefor not loaded in the modules section. Is
>>> there a way to exclude a module. In ftrace_module_init I see a check for
>>> !mod->num_ftrace_callsites. Is there a way to avoid creating ftrace
>>> callsites in a module?  
>> Are you sure it's the size. Just want to make sure that's the reason before
>> going with different solutions.  
> Interpreting the warning statement in insn.c and given the fact that the 
> module is loaded at 0xe3xxxxxx instead of kernel module space at 
> 0xbfxxxxxx I made this assumption, but ....
> 
>>> Regards,
>>> Arend
>>>
>>> ------------[ cut here ]------------
>>>
>>> WARNING: CPU: 2 PID: 1525 at arch/arm/kernel/insn.c:47
>>> __arm_gen_branch+0x70/0x78
>>>
>>> CPU: 2 PID: 1525 Comm: insmod Tainted: P                  4.19.183 #2

This problem is addressed by:

commit 8113e622926ef6590771ede0f7f64821e1751b67
Author: Alex Sverdlin <alexander.sverdlin@nokia.com>
Date:   Mon Sep 27 14:02:45 2021 -0700

    ARM: 9079/1: ftrace: Add MODULE_PLTS support
    
    commit 79f32b221b18c15a98507b101ef4beb52444cc6f upstream
    
    Teach ftrace_make_call() and ftrace_make_nop() about PLTs.
    Teach PLT code about FTRACE and all its callbacks.
    Otherwise the following might happen:
    
    ------------[ cut here ]------------
    WARNING: CPU: 14 PID: 2265 at .../arch/arm/kernel/insn.c:14 __arm_gen_branch+0x83/0x8c()
    ...
    Hardware name: LSI Axxia AXM55XX
    [<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
    [<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
    [<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
    [<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
    [<c03218f3>] (warn_slowpath_null) from [<c03143cf>] (__arm_gen_branch+0x83/0x8c)
    [<c03143cf>] (__arm_gen_branch) from [<c0314337>] (ftrace_make_nop+0xf/0x24)
    [<c0314337>] (ftrace_make_nop) from [<c038ebcb>] (ftrace_process_locs+0x27b/0x3e8)
    [<c038ebcb>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
    [<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
    [<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
    ---[ end trace e1b64ced7a89adcc ]---
    ------------[ cut here ]------------

And if you wanna stick with 4.19.y, it's included starting from v4.19.209.

-- 
Best regards,
Alexander Sverdlin.
