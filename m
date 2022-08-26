Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925A95A3101
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiHZV3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiHZV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:29:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB3A7226
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRe6K+X427otyIvhPTrhnhFSa9W86RKou2KLHrJzfu6CHgne5Xr7sxXVkiWcOnVBaUNAn483Oqk+2o61+hYTQMVQQ3imWykSVUufCNe3hip3+SYLOvRh/xi2kaDNgzu7RwB+l/CvQRXkzuCkjFCDM5NkjCbJi01C9sFE8THSJzZ7V8tDa8XHBFRIOR0AMDTnb1k3heI2LokqbgzwDfHSY/ixkI4hhzdr3uvyB4GG/KG4og6WFzYQH0mLZFbTOoNWNAyLh8SpROY9Vmw3mfYR38F8Yf4/gdCqzSY/2CRWNXcpwgZyza9dmeAt7H7Fire1Cgxv3eGP81AidrnV7iDLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6waJVi4vDNOeV1nN3PT61iMn2lWbupo19V4i1niclw4=;
 b=EjQnpClzHAgvuB1xU2m6sACEc0IMcjN6G40T9Zg5vKaNS8bC1zW6flECfm6IPCSUPMJtWUikSSFwmX2oXV9t9p3pQ0isAAqnB3nXS1g+EY6+0a/+fGpmchDV+OXGDlk4EcAUWqkEl+O2KfTycC8wNauiCFw8JOiSNNlKt8N7KHPa56pLipjPV8XbdTDX16jY54EgOENfQZbawnfuDFlZRiHWmFyMN5vok1pSK6N8XvPe+riDLqqopQArzPkfiTnjRo1oHSvtk0hMJNPfDNJWvRh0QbAAgERgCfO4zm8xeJvnbpO85ED3D+3mzTI/VP+SiwLYdQlWrAA0425EnZHa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6waJVi4vDNOeV1nN3PT61iMn2lWbupo19V4i1niclw4=;
 b=s6YMRMfr+XqUHe6BXk/CJtmYppEvXF8OWC4HZeawoPZrGGbqwMOCzxXGaZVkbOSXkaC1OctrxtRaPen059GKSi/J6jcUPkxeXdpAgcDISEJkn6OeL4oKEc7ze73PSMINvrTffx+1ZgEwFoZGaMRcoHnXL/H8ajTXV8TZmFtjps4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM5PR12MB2392.namprd12.prod.outlook.com (2603:10b6:4:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 21:29:15 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 21:29:14 +0000
Message-ID: <58903fe7-c4d9-def6-71f4-6173b47fe462@amd.com>
Date:   Fri, 26 Aug 2022 16:29:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 4/4] x86/sev: Add SNP-specific unaccepted memory
 support
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1661437397.git.thomas.lendacky@amd.com>
 <fe519747d14dd16a64e0e92e4c0354cb2ec55f59.1661437397.git.thomas.lendacky@amd.com>
 <CAAH4kHYVes8wezA+R9uAiNxpYCyDnwewn86tUKmeA=bjmAWGgg@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHYVes8wezA+R9uAiNxpYCyDnwewn86tUKmeA=bjmAWGgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0020.prod.exchangelabs.com (2603:10b6:805:b6::33)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab69a9af-8f05-4809-973c-08da87aa065f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2392:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksHyQJvyvYnwPTZUG8kCz3MsTC19iQnN07ygNct0BQdGciJxXlJd4sObrLA1CV+Pz52vkZ7cGc3j/Ig7WjVpeleHfDY9JaPCaIxFbuVCE9iD72YT4Lmmh9Y1Yj+hcWg+dOazkRN1JmugB1w9grPJNjDaZ5YT0+LJbid0APedyNXUdFZw8SwV3Ii6UT3uvA57DRCs9RXqWwX6NN7QpP0u3c0QuMqL82OKwx+Ojc8T31TMZRpINLbhfNelDu+YuS/xPYkBz9oASHX4Rgd04698GQqaNqiormPeYJABAOPEX/NMnHqsaOYipsiiT2Wmb7MsjZZyLXLsBj3APoodkTpCYbtUAWPiBSWBRHDjTYFL5znaso4O6ZvHxwAe98GFmIKHvTO6LoFvOgVtLSEmVwqSEJwFc2mmqwalmAg3r0JcmJl+nzJFrtsYIWzZWTWFXZCcQEYrD4Lf3AhBT4843gC5+Yhino6yNhDAzK1zTensRztE9TCxvRhCxYA8uteYYq3V1/NNq60kwb3yvqGxNMgvyUMOixNcJUWARU1xZOhPTtavTYYeagrO/BybhLOphBDcRtZskPlJIiz4OjB4qvatqqtqnylTZ+0bB0fLO0FiP8u6DLkh82ZcW1DvWMtzgHUmMe+9mObXk4PFhidVgQXud1TjEss81zK1oeSihcbZuy4EAU+jFqRO9D5EBaGths6UFaQyKP1OghSZObSRlG5g31N7u1CyBq4noxI0L4hdftGgPinmusBApsJuUC99jgzuTawuJ63wCOGvUu4l5UqctuGJsxJELpJQBmcwq15hGLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(41300700001)(36756003)(8676002)(83380400001)(54906003)(6486002)(6506007)(31686004)(186003)(2616005)(26005)(53546011)(6916009)(316002)(38100700002)(66946007)(6512007)(66476007)(66556008)(478600001)(7416002)(86362001)(5660300002)(31696002)(8936002)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVZ6cmNpd2ErSVJ4d1J0NHJ1bGQvdW9GaCtXOVkwQkRvMWpTTnhqYjRwd1E4?=
 =?utf-8?B?QWtwRi9oOXR0M1JyR1RrUkkyck5nNE94dWo5UEpPNkZGNHFKQWp2U1JjNVoy?=
 =?utf-8?B?a05iMkQxVkF5anVWZXlYODlZN3djVEVOaFlUeFIxTDVPd0JTbC85cUVwejcy?=
 =?utf-8?B?c3o5UVphQzMxK2JLZkh6R2lPZTZ4N3RNRVhOSHZHUGVZU0QzOGZxM1h2SGZN?=
 =?utf-8?B?UG8rZlY2eDRPNHd5Q2tNVThUdWt0U3lIckJZZ1NWcEN5aEoyY3U3RXJMYUsr?=
 =?utf-8?B?eksvTnNJd2Z6S1JtekN1M2ZGUTVRWGJtQ1hLUjE0S0k3dmJqMCs4NENFUGNE?=
 =?utf-8?B?L0ZnUGpFWHRZUjFrdng0OE9kQ2N6ME9ISnRJSjc4S3VEZmVUc0tWeXhQZ3pW?=
 =?utf-8?B?ZFRNU0o3aVlrRE13VUhzQ0N4ekZweVpXY3AwSStuRWxOUmNFeFRwaWIya1Bk?=
 =?utf-8?B?Nis3dmxqOEhpemJoa3AvakNVSFg5VWsrbnY2QnBFMC9GRmh5V1dIUU5rcW9x?=
 =?utf-8?B?YXlwVzFCczB5dEtJZzNYdnhmeVBPMGhiNEw3c3FpWG5wYmkzSzdoUm1abXBL?=
 =?utf-8?B?ZW9zdENjckdRVjJEK0VJTjc1eXFkV0Y5cTZvR05XTVVaSG9oYkNkcXg2L2Mz?=
 =?utf-8?B?Q1UrT09Bek02aHdNd1AydjFRenNCS0dnTEFsekZQTEhMZGR3bys0citXb0ZH?=
 =?utf-8?B?UytnUE1OanF2cWtpQ04yMHMzOUs3Mm9HL1Q4dUJCemgyK2R2SkhEcVoyVkNG?=
 =?utf-8?B?TlpWQ3hRTVRWdzdEbi90MFdoRGZYaGlNVFU1UVJoSXRHUDdUWkhNNE9FM015?=
 =?utf-8?B?dFo5TDVMOFJ3NTk5NWNoWHluMEtMQlJkNHhtV3lyTnZqTjlBTnhyNHdGcjN3?=
 =?utf-8?B?VlR3enVtUzAzcU5rYjArRFBDWHFoVkdGbWRia25ERmtITGtzRG10bkorZmta?=
 =?utf-8?B?Y3RDbm1HY0ZCbWNieC9tcVNBQmJ3TVU0TkR4ckFYODRzQ2oxd1IzaTYvY2Z1?=
 =?utf-8?B?U3VuSWxldklEWGozY052OG8wbm1FSTdtbXljUU1rZXBOblM2YWpWb0JZbENK?=
 =?utf-8?B?MG9GbTI4OThSU0pRZHVNdk8rd2ExeEZ6WXFWalhvUldOR2dIamQ4bHNJdTc1?=
 =?utf-8?B?d0ZudWQ3d1doL1NXUUxjN2EzVEZ3bkJMNDZPbkdkUFJEYzNNYlgya0NrMk5E?=
 =?utf-8?B?RWo1K1BFa1ZRQzNVYkViaG8xcFlTWFhTQ3p2UEcxVzAxaDR5V1RwNm9PU3Bu?=
 =?utf-8?B?NW5JOE9MZVNxcjM2TnFqNTFkaUlUZ2hpRkZQL0FTYlBxQmYzS3lJVEUvR0hS?=
 =?utf-8?B?OHA3RjNnSEplTkhmQ0l5REVrMzFGc3k0N0ZQMU5aaFl6RndPNndraGxQbTdo?=
 =?utf-8?B?Zm1BTnVGVTh0RmdsQnN6VEtXTWlKSkJqeEtLVmpJcmxLRTZOVUl1Sko1NGNa?=
 =?utf-8?B?aklFdkhWRDkyaURVdmpaN01PbitZcTBkUGNOQ2piZFhaaWM3WG1YNHYvejNQ?=
 =?utf-8?B?TnA2Z1JIMkdxY2dOR09PZW4vR3ROQkkxQlRVcXJ3c2Y3eGNWZ2dUK2huWkNE?=
 =?utf-8?B?aVpmVFZ2Zm9wUHhhcWRRUlVtUG4zMlFFMWhHRzZMbk15R1F6S2l3Ym9KVWFr?=
 =?utf-8?B?R2kzY3J0dU1ybFpoTFJrZkpwbStPTmxBQnkzdi9veFVLQlF4V1pYRUdZS0I4?=
 =?utf-8?B?Y0paZ09nY2tzRHZvR1hvTU1ac3IwNE9zZTZHWmhhMnNtcU1xL2pIMFlxMGQw?=
 =?utf-8?B?RXB4TTdvNWJtNWVzcnY0K0FxaFh0SzZLSjFTYU5LMXFvaHVMeElJU0pLZjBr?=
 =?utf-8?B?RlBXaWdpZjc5blBTWklFM0Evcm4zQ3QvQjdtU2FtWmtSbk5UQnBVVnVLNTM4?=
 =?utf-8?B?dTZnNUR4Y1c1cnRxem5LZFBKTUJMd0t1N0NzbWJTTUtrMXdzQVprM1YwQW1Z?=
 =?utf-8?B?bmtWcTk2MHFWWWNnYW9ILzBiT3ZqN3lVaWRvUHIreGlVREEyUlNESXhNcGFW?=
 =?utf-8?B?ZC9DOWZkdGU5WUQ4QW9VeEVUR1pjbzZYUGo1R1R2eW8yM0xsYXgxY0RiVGlG?=
 =?utf-8?B?Um9xWXZscU9JNG1iZ0xPQUlQS2c1UUlraUoyaDRUSWZuU3dBdzRZaS96UFFy?=
 =?utf-8?Q?5xxeoe9Kj8umihLbe51TGXoVQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab69a9af-8f05-4809-973c-08da87aa065f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 21:29:14.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFXSFlf4gglJ4nt9WhcG5uFP6qfezQlT9/y7FfNLyLZBJYRLUsfiGaeekjeyn49d9zwkhp190ECISo1g+eLu2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2392
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 17:10, Dionna Amalie Glaze wrote:
>>
>> Add SNP-specific hooks to the unaccepted memory support in the boot
>> path (__accept_memory()) and the core kernel (accept_memory()) in order
>> to support booting SNP guests when unaccepted memory is present. Without
>> this support, SNP guests will fail to boot and/or panic() when unaccepted
>> memory is present in the EFI memory map.
>>
>> The process of accepting memory under SNP involves invoking the hypervisor
>> to perform a page state change for the page to private memory and then
>> issuing a PVALIDATE instruction to accept the page.
> 
> Thanks for this update! Tests show the boot performance shaves off a
> good few seconds over eager acceptance, and it'll get better when we
> have on-demand pinning.
> 
> The uncaught #VC exception is still there for 256GB machines and larger though.

Any chance of getting a stack trace when this occurs, e.g. adding a 
WARN_ON() in vc_handle_exitcode() (assuming it happens when logging is 
enabled)?

Thanks,
Tom

> 
