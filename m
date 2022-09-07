Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1185B0D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIGT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIGT7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:59:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4391862E6;
        Wed,  7 Sep 2022 12:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNaOEeNlQZYfqhGAWW/tdMIt+slP6AkOmlWX7+p1z3hEQ/20atwV/R2PtKkR05poDQvU2TPzWn+Y2xsu14w2DdUYPnRy8ufWwDr+xOE8msHmMhKj62EIe7dURneB8ET6lq5v7aBgYtNyEDDz1fylp1cdGum+DHo9TwPh5bw6tmlDxlVQK7iA3cUScTjYGc/uJp907MSGuFIIOzcqvffPnKmjf00/XvMpSEN4qjnJ0eHXnNzqySRMjOvBF4lN3QQgwOQxu/GqtnpVc8Kwt3apbRiEOABQUr2Kkkl+smcbh70TcPPIs3zkSUnptuYHs9xbcp+Mvgelr0EIPyUH+2vq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzAufIVP2BQ48P/L/rZHNc4XJzmOWTq6Q+yuVHLgMk8=;
 b=cP7hAj+t99ipO7fDNpnq2GtznNkGDt/XKqQbyblo3vx/CO1/nlm8n3ioT+Az0z8M0tE6LRdx071MNuKI23azBt0eVf+5rP0v67h/ynxuD/g/w0yxXDBPBGRZ5aHLEwUHCh2E7SnGOcTohJ0fS8MiqnrJF+maAf4r07PBjz29SsTVWuqM1nEd+HU9a0uLgnyFSeOK2Qt0BVtJNmbL+uC3MdZeC1Vya6nQ8UBWdeRH5SEFoU/YMl0L7F1cpjlTTDkhnC+1gRSg7T1LIQfBJVTWndBDuPAN4LdXPFdetV9SrK0V00SnI1EH4q56eEyzmRKfymthsKu9doOULXzIF1lYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzAufIVP2BQ48P/L/rZHNc4XJzmOWTq6Q+yuVHLgMk8=;
 b=ppNh2HZyKAW8J9tLrC+d9EpzD+s0uBHivHc7hKjL6QFoS3JL7rVkQFHgCq+S5H6Vbfd6h9vTPpkBX85JVQ9aApqprEZdKCXZJ7Fp3Cel6wTQdq88EuF0aZNmR0EWtPjCOWbVOj8BdaJ7NpuJcziWUSK/e9dZ5/cEwAm0eh73veI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 19:59:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%5]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 19:59:31 +0000
Message-ID: <24c64113-f815-f3f5-708f-340a758f781a@amd.com>
Date:   Wed, 7 Sep 2022 14:59:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 05/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, sandipan.das@amd.com, tony.luck@intel.com,
        james.morse@arm.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        eranian@google.com
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257363444.1043018.17384356050516925226.stgit@bmoger-ubuntu>
 <ec61c77f-260f-d9b1-a85a-1888fc45545d@linux.intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ec61c77f-260f-d9b1-a85a-1888fc45545d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:32d::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 443e75a2-cc34-4fb1-70c2-08da910b7a6d
X-MS-TrafficTypeDiagnostic: PH7PR12MB6585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vv451ilOcu5gFRu4bilciA30PMSpvlD/dCPWSju2kP2Eh8LLfiQwr/Cj3RsCiO/+Bp+vNAo63LgOewsz6nTO04lMuQwsS4P8OPWIGGaUHny+fBcWJYCrOm9eksMc1hGS78wVwJKGEhX6IV+wGdFi7Vx9YuXcQmqe43nXzd1cvGslfzJCDnGVScNyBIcvup7wAaS9dfvtALdKPHRJmZTvLwEf4oD4ZR4GQti2Vw/dDbXB7OkWDqKcVtAlK39iixN34MY+FGJmzK6OqetZkxhcSldf61Zy9CnJUnNOiDThF1G6OoVDfSuYUczZLt9lfq9kw8l8hbqXLswP8WUa7BchUXgH2sUIax07obuyEgbNR5LNOwyauX9wnFASlzsX75mIzx/6Ojl1W2zqpMG9uCmYceuqiq1BnzdP65mD0kJYViZrxKt1nGdCHWDQ3jVRII58rHq0E3FK/l9U1QEoSRlBDy05MGp6GgNyPhiswAPIBOQtVhuuk2WMnCUYj+av0V6D3uoyr+3PvMzINhFCZfimkALlqqdgWX9PPk0UR/RMIykKUdeA+JlA5GXVTNuHr1eeeTI4uK478qM/N9ukT5k+B+RJzAYa6k9DOtnSl3VDY4oXOlPJ/GzC3afWCvqMhvTlhJK8215dzKQefnnPXjb1vmhQlJovL/hskIXzSdRYDaTYv0khD2dTScroY6jGV3F7ENIKICb8/AhQiISpSgZzM97IwC5pxNsebTFsLaf1yPJO0G4Fg6Dp1MlBCcwYud11OT7w9oKbZfTpm79piZpE5kkVK2fg4JwZVGoM+UuSZE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(31686004)(36756003)(38100700002)(186003)(316002)(2616005)(4744005)(66946007)(8676002)(41300700001)(7416002)(66556008)(4326008)(26005)(6486002)(6512007)(2906002)(86362001)(53546011)(5660300002)(478600001)(66476007)(6666004)(31696002)(8936002)(6506007)(3450700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElQRCtMMGw0UGhJTVpyanVNTjlTdm5Yd0laZjFIYTJFQU15MEZCWkRwa2xS?=
 =?utf-8?B?ZEtJbCs0M3RSZnJpQWZHZnBZQVVaRVRDMitUVTZZcnpHODNtL255M0gxL01B?=
 =?utf-8?B?aTVacG5XUzVFVGdKQlFXQ1RUTzJTVVdDMDBGdmcyWUV0UDNCK1ZFblhaNndx?=
 =?utf-8?B?SmRsd1ZXMjM2bkd1S2hpY2kvRkU4SEJNQkFKd05ld0dSeGJtZElZVElyOGNw?=
 =?utf-8?B?TWZUVkJQSFN5aml4UVMyUWU3eERVRURFL1NORUVpTXRXU1lkWGsxNGlYeitO?=
 =?utf-8?B?Q3drOHJ4cThlblQ2czl0ZmhwQytORWxlUHdJTWlnbXJOaFdqTnhHNHdwc0t0?=
 =?utf-8?B?Vk9UNFk2RFpISjYxZEl2dUZFWm01eEdycm1CR3VGTU5hSUpCc0hOVEJtc1oy?=
 =?utf-8?B?dm5JVS9iUTNzcnhVMnREaXR2Vi8xUzAxcFlHR01QdE5md3RQZVFnQ05qK2FR?=
 =?utf-8?B?L0lNcy9LaDNVS0g1YVUxMkxzYmlpRHZxL3pVOUxMczB0KzR1TnBkZTRuOG02?=
 =?utf-8?B?OEhQSTlzSHFrOEVXdTVkMkJwUlFUb1JpTEVaa1dQNFhaL01SaU5vdTdhRDVs?=
 =?utf-8?B?SlVRK2ptdVNOV0plak0rK3V1Q1E5UXdQQi9NS25KdHZuUXJ2WjYyMmo0OS8x?=
 =?utf-8?B?RDhVZ3gwVFlGQ0lMdEp2RCtEb0NqV2FwdFZnc0dsMzRzbk9sWXlLTXBFSU01?=
 =?utf-8?B?dnVPWlZNaGJ6WVZwWHN4NXNVK1Q0SHhhU0tNRG9GaGtucjZCakZHWThaMnBl?=
 =?utf-8?B?NXl4bFVKYmlMYWtiN3pKTGRQWDVHNjVGd1ltVExnTk54Y2dBaTZxQU5yNmQ3?=
 =?utf-8?B?aUJValA3QkJJTWNNMFFLNjlVVG9Ob0NDL2c4YzVEeDU3dGRqSHUzcTdUL3Z6?=
 =?utf-8?B?M0JGRmJRL1psd0tUMHZRZG1qNFZSMW5IalFGRE81dDRhcGNzT2ZZaXhHcjN4?=
 =?utf-8?B?dGI1blJIeTJrakVsSERqK0l3a2NMdnd0cW5pbFJJbVdsQTdyL1l2ZU5uei8z?=
 =?utf-8?B?SU14bkZCVkdjNlIyOW9yUVBmVldRQnd4MkdRWkJvK1M0TU9FTVRhY1hpdUNE?=
 =?utf-8?B?anI4U09EV1c0QVNnMzNhc1NVQUMwRUxwWmVLQUJyK2lIVGtZU3BnU05DNnpE?=
 =?utf-8?B?NXFyVVIvRmk4MkRScTR4d2lsZUlDWkU3MlNkNjV2cy9LZEVkbzZKQjBHanNr?=
 =?utf-8?B?RERMc21UV3NXakp3OVBualA3bVkyVGtUa0ZLdFo4aUxwMURPdzIzaVdsdzVY?=
 =?utf-8?B?UjBiZHIxdjB0VytraTVIb2R3WC9JV0VxRmNIRGlGeUZnUjMwaGkwYkJ0bHRP?=
 =?utf-8?B?T3Erb3FSVlU2WWVjUCtkaFhBWmMxR3hrWTZ6RW5oV0R6RElYV0JrSFJUN1VL?=
 =?utf-8?B?aGQzSGs2SkFNVVJlMGlBWmtlTno3dEtTbTVySGhWQWFpbk9vQTJWbVRQQ2Vy?=
 =?utf-8?B?MEpWWCtHL3JQZWZBekF5YlVVcUpKMXByTjhidWdtamhmY0xQK1h2WklnQit0?=
 =?utf-8?B?b0gyTWtEQjdUbzdDeHY0RVRxMFlEQmtIRG5COXZ6ZkdkSExvTTBhbUF1MVhx?=
 =?utf-8?B?M25kNEYwVUVjbkgxZ3NGTkRGbENIbTlPTUtIdi8vVkJaV3JYait0UjFvaHB6?=
 =?utf-8?B?ZFZsem1ONVA5VEtwUTRWcEdFTjdZc1JnOFgrbUVqcG45akhWSnNTakpoZFFD?=
 =?utf-8?B?bVZvMDNyRURCYjI1QU1Zbmx2MldDZWM4SnJ2MUxnazVwakFILzV5dUs3RzR6?=
 =?utf-8?B?TCtvUkphZjNLMTc2R0tlYWEvVDFwSlIzU0dPckZIeDYyNGxrc1RMVi8wU00y?=
 =?utf-8?B?bzU1WFg2WmgvcDhvdnZUVzRBalFLREgxbWxqYVhjcjlQdnYzZEFpSlRmZUFO?=
 =?utf-8?B?WThIZG1uMXBtNEdKS1RIZHUxRUhWcHZBbGRkL2pEd0RXaGwveWhRVlY5dVJs?=
 =?utf-8?B?Rk92OHdxY3dmWWdUaGpiWDJoL0cxZXYwWjlsVUpoeUlsYWZaNW1nWENpS2RY?=
 =?utf-8?B?Z1pxazllUDEveGthUXhGajc4UTJlRTBtRzhpT1A5OFZ2eUdVZlJNbWxFdHZa?=
 =?utf-8?B?TWIyQjl3K1dDY3lTakZ3UEtodEJtczc5RnJMbGtFNnpjRXR6U2w4dm01VUlM?=
 =?utf-8?Q?EQscc0QNpBujqKSsfdlRxjIUZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443e75a2-cc34-4fb1-70c2-08da910b7a6d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:59:31.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0n/SOIFRIcFhChfrAtSc1iRl/5BRNqHKccIPee4k6G3XmNEc+fsWpPp1zS4FB1Js
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 9/7/22 13:36, Daniel Sneddon wrote:
> On 9/7/22 11:00, Babu Moger wrote:
>>  #define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory Bandwidth Allocation */
>> +#define X86_FEATURE_BMEC		(11*32+18) /* AMD Bandwidth Monitoring Event Configuration (BMEC) */
> Shouldn't this be +19 instead?

Sorry. Missed that. Will fix it. 
Thanks
Babu Moger

