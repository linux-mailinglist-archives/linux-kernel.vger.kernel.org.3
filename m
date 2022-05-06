Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6AF51DEFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391220AbiEFSXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiEFSXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:23:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5909120AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 11:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpd5+CTQUCNO/cyOvDBNq9N6DyKExO5xjj7y4xM7Ja9e2PXAPmsK7OHi0zTuox/Y3NZFkxUwcaXqeBHWlxYzXwHE35JX7zzRJ3TphFHKk8A2f9SDelka0O0st1EcZygGcRncO7mopmEQTcs8uPhVUspASEwljg1UhxriYB0MXfcemCcOGgUFZi2COGj1HUr9SqpX4+YUAVfizElNEtPiISRzdsqILQ7S02Re04rXHn18KhU+IKLu2HQZAzJEehY7PZxl5YD36z553Nx28WgyERAh9ybiFqXj/0Asziq0zNIt1bS2Dh1Q60LjuA2qQDo0lpd27mO0oxJC3SWiIFcKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TJiqtcisY8lA0q7Q/q4lYk2ugio9dnvazu6xoDdec0=;
 b=BeMiwiGPedIFnILxUMwxtylLkeKi1KDO7RATDhLvD4W1W1yqNL8kU/OKY5TsoKsxfsGgooMGMpeXaE0UwC2GjoGBHevO4G5CBCzA+Q//CxQn/lqw53fbFgI8DH5eIf3ahc/+B3tIbRY5nAKBJttwqQJvzh/hP4pgTWQvM9RRMcnjrCAm9JCNBVHIK93EpXEayvL8WAsVd6YpeNKokI0FtkmhrIQzQX3jKMU8zNQxzz7tK1bnR6rcxPzkymTAvN4LF65lHfjcdJCEA4LvsgxYCwstK0tCAH8TDYsfOWCezs69HOyt++X+hCplnlcuuc9b1sA8HkDwPg+s44PsJo9ZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TJiqtcisY8lA0q7Q/q4lYk2ugio9dnvazu6xoDdec0=;
 b=23dPtIWnePd+LnP3PmED3BHrRr+Nqvku/T6VExoXxBMLlWumptGkXLCM91/40kyIDf7ojCYqYX3amrpIRU50jRp5pnA6WAPXjA5PJ17vsRWkXaYQOT7BsXZcJYhLwRF7mVQtXq3HFDwAtKAKmmFfT6M9J+n8S+Fr/hKrzzyRzps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 18:19:17 +0000
Received: from BYAPR12MB3368.namprd12.prod.outlook.com
 ([fe80::1c22:8110:ebf0:f38d]) by BYAPR12MB3368.namprd12.prod.outlook.com
 ([fe80::1c22:8110:ebf0:f38d%7]) with mapi id 15.20.5186.028; Fri, 6 May 2022
 18:19:17 +0000
Message-ID: <4b8b9ae0-07ba-0d54-d1ac-1844062f1c4b@amd.com>
Date:   Fri, 6 May 2022 23:49:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <20220505104856.452311-1-wyes.karny@amd.com>
 <20220505110140.453184-1-wyes.karny@amd.com>
 <0b501f18-a6b8-1d9b-e72a-ea6cb33720a2@intel.com>
 <fa4e26df-d2e7-7b13-a961-4f741b319e79@amd.com>
 <1a806ced-4bb9-c18f-e614-75e9d9722d08@intel.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <1a806ced-4bb9-c18f-e614-75e9d9722d08@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::17) To BYAPR12MB3368.namprd12.prod.outlook.com
 (2603:10b6:a03:dc::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff4d4d7a-591e-473b-f184-08da2f8cee04
X-MS-TrafficTypeDiagnostic: CH0PR12MB5139:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51392535C7A18BE5729835C584C59@CH0PR12MB5139.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBewFQ0z0H6ESXw9riK8eI2USh9u7MDgrr2//DWzGRMWWd/KMHn0ymaoIynCe+PPep6rieB9eJMa5JsUfktyyCYDqh7bbH1OktVF9bTTyxDKoVopvqewCIVYcdy+bXxoeKPDsMD71+2eRxvr+EnnRaPL2gnXyJLlTz/Vs1V9juMsZ2qUnNkt+oFD1YLnpDnbZBmYzqidok8ZFye6jjhiF3hrax3urYYX6A3v/bxY/zmrlRcF/Fpyydv0aEqrzNhO0P796XxqzZooBq8JQOondl+nv0igYe/ZznmbNZtz9OowEb1L+f3yGWqSjTWwC1TDr3b/8HoRMC880dtGZ9aI/TntEF2exuAOMrF0HXKjW0Me+3R2hIgOypO9TJfCAfODEeCFjLlQ9Iv4/h0HaSER9ANkIZ8nzW08bhVvNca9gNXm4VAOEsGfTmT26ZxX8zk3b60jPxL/Kem4r/u8mhphu647gWY951VM67pDszDtvHqtP+XgklYNSKhPfYpd3nQ2proBTv9x0G6BnHkihnq+elWFydq2ZE5q9TMLT3m6Iko+9+KmJB9nC48Xum3AZt4OX6AOHGEQ0HXUy3rKAwYPjn0XG4TD4Y7AHvVe/gsOjQPc1Yv91Cyq/5K0pqtjCNFjZUk8CJumtVPF4yxI44u0cpJj8TGTROd2kz2Zr+uYLNqsMpuIY9Xs6krXKT5/hpK1Pjyx2WfnLtYMY78Pbdo/l2qK53Bt6ijOYQeXZqRXHqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3368.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(508600001)(44832011)(7416002)(53546011)(55236004)(316002)(4744005)(38100700002)(6486002)(86362001)(4326008)(31696002)(8676002)(66946007)(66556008)(66476007)(6666004)(8936002)(186003)(36756003)(2616005)(2906002)(6512007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnF6NnFzY05rOU1sRVVHM3BvRU50SDVhalFVUnJpQ25sVnNRWGluK3hjb2c5?=
 =?utf-8?B?RWlKa09hc25DM1NkQzZlWUxsMUJEbEU3M3RsZFA3K0U3bi9iQm16bFJTazVq?=
 =?utf-8?B?SG9PUjlPTFdWMDVqMmYxOVpVQ3R0aHhoRElxRlpFZGJmSWs2T3dQaTd5QXBY?=
 =?utf-8?B?dEpydlQ2Nk5KS0s3ZTYzaWF4UU4rTDNqUXIyZkhRSDJaOEMvdFBSL0EyM0xm?=
 =?utf-8?B?WU96bTVsN0RUaVhCRkZvam90a25WTjFoNDFwME9adUVwSnA0TjJCakUwU2tu?=
 =?utf-8?B?TXdjN1dnMi9SRS94MmllYWF1eFBGVDcvOE9jMVdtK05vMmxwUzFRbWpPVC9S?=
 =?utf-8?B?eWJwMG1lRFI5cTNtY1FmZ3NwL1hSQ2pJRXY5bDVDTlc1ZHh0QTgyWWw4emkx?=
 =?utf-8?B?OW5xYnRqd05GYVJCL3l0SjltUk5pdllmMDdUeDZhRkV6bDlMZ3J3OVdSc3Ux?=
 =?utf-8?B?OUhyeHRLK3A1dUs2VTJPMDRIazFFcWtHWjhpUTYzOUxOM01XUVZzRGt3M0hP?=
 =?utf-8?B?YjZwNkphVVlXQTRrQzZ1NEJXZHJKM2N4VFJGMVBFVjIyeUYxbzV4ZXBPSklW?=
 =?utf-8?B?Q2ZPSXoyd2VHWXI3aTZncitCVkFManhpYURNYVVsc09iTHh2QkNwaGh5amxh?=
 =?utf-8?B?Q1Evd3JKaTBJSkRnZlRUUXJIV3FBT1k2eDdRaFpZU3NRcFRKNFNCZkNrU3dR?=
 =?utf-8?B?UnIzWFFST0swRTVZZUpEU0lnWWJKZDdWVUx6RC9WZTh5RUdrRC81RVRkMW96?=
 =?utf-8?B?MUdqalVyUHNzWmpMNVlwbE9uc3A2V3c1czJCMXlackQxNGVhL3JpWDZhUzNs?=
 =?utf-8?B?a3lGWnlsaEFESU45eThjbWU2Szl5OUJVbS9BNDVSR04rTE5wUzF0ZHBxR29R?=
 =?utf-8?B?eHpkT3V3Vnl6M1dVRkg1Z1JEbzJlUlh1YS9RZFFoWVhoQ1hNVzdYRVNkZThn?=
 =?utf-8?B?NWU2d3BRQWhRNDBpMHZzS2xFK29oNk10ZDRvblhzb0c3d0UvZURYb0hFNjlP?=
 =?utf-8?B?YnVxcFBKYUZtTDhBOE4yWlpGRk5UZlpGSUFBUXdxSGZmb2JvRW95c2ZLcWNH?=
 =?utf-8?B?VWlmSERYK2dCNWhjcEZLNnFtVk5vRkhHQS9UYW9xMGVDbTM2STBxb2tDak1u?=
 =?utf-8?B?dTZEa3ZCcEhOQTVRNCtTcDQrYVVZeWt3UURRK0RkYktRNjJPdUdnTVd1S1BF?=
 =?utf-8?B?T3VyeFhKTTM2OU5FUGNtMStJZ1Y5VGNrejBQS1lEL0psZmVXS04yREd2RWdz?=
 =?utf-8?B?eDJYZFo3a004ek9Gemd3amlzQURCUzlCbng5ZFFMSktKK2ZoUG9zS01xUkdH?=
 =?utf-8?B?S0hCTk9ZRFJTK3RVUm5wa1RGQTZadE9PUjhMYk5zbmZmZ0Nra3dwQ0gzQTdQ?=
 =?utf-8?B?aEk5VUpOTnZTaFh2RXRSR2tGWmtLNExXQmJOVXRjTkprRzdxa0txN1hobTJi?=
 =?utf-8?B?YTZqekZFU3BpNjBuQjFIdVo2d1pkYmJxa09YcFFHVUkrUU5hTWVGbEdUTHV1?=
 =?utf-8?B?TnB6RXlzSDJRYjNzZjNzK3c3ZFp3WGR6dnUwN0tsb3BjdlIwa3pUeDZMNXlB?=
 =?utf-8?B?Smd4WStwTURBa294dFU1Z1grZDZnU2V2dkpUdEs2TzlobVJGS0x6eDZxU2ww?=
 =?utf-8?B?TVJ0dE9qZjB6UkZKMUJlMnJSOWdQU01INnkvdnMrS2F3M1g4cFA2TjVGVzJV?=
 =?utf-8?B?SVVmaFo3YXl3UXpsWVJGMFdlai9tdEFrM1Z4dUF0M2JsUHJXWmFNM3VHUWNY?=
 =?utf-8?B?eUVpMVA1dXBiYkIwS2lBc0dRZlRCZ2lBWURYUjNtYjlrUnV0cDkzd29lanl2?=
 =?utf-8?B?RktJWkM3ZURDZm9CNGtkUmtJTFZSQndRN1dZb0lNQjJRbFJueUxDWGJjdGFa?=
 =?utf-8?B?aThlSnFJZ3hzV0U2N3BXNDNZeGFGSkRGLzlZN0pqdGtMbE5adFFjSXRLSmhK?=
 =?utf-8?B?OVhiQ2pUeVNBdGFIS1cweWpGSU01aFBFb3pJZEF0Z2ZKeHVBTVYrcHJTWlJR?=
 =?utf-8?B?L1NNdytVK2Q0Wk1oQ1lTL3VtQ1dEQUhEeGxRZFVpTENyVjJwcXFVVGxIQ0JV?=
 =?utf-8?B?VVNVRk13U3h6Ri8xdmVuQWtwb0tqUWV0Q21zYjAwc2xQR0JMZytia2FXOEVL?=
 =?utf-8?B?azJGWmQyVXdJNmZlR2ZSaEltQUhCQSttaTAyTDFXcEhCSy9PQjNoWG9wRUVK?=
 =?utf-8?B?c2lJbmdWSXBHSjgrRDJMT0VYUnh2SGI4L0pML0w2ZWpBZFRkcllKRUJ6Szd1?=
 =?utf-8?B?VndCc0pGR1lKSW5xUy9KNzR1bUlZMzNVV2JxcDkzMTQrOVh2bkJtU2FKbEFR?=
 =?utf-8?B?YlN6K0tia2Rza0tONVVUR0JIQmdUREJpN3FUaWViUzFBUHJWYWhLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4d4d7a-591e-473b-f184-08da2f8cee04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 18:19:16.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6riIaK6CeIjF6nOq8Pc4UYf27Jdja6R9qvyTTjTbUyQRufIgcg6EukiXxsZdTG38uiYN45BlZ15TFlZKM7YCUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/2022 9:22 PM, Dave Hansen wrote:
> On 5/6/22 02:42, Wyes Karny wrote:
>>
>> So, if CPUID.05H:ECX[0] = 0, MWAIT extensions are not available (not allowed) and hence 
>> it is safe to use MWAIT with EAX=0,ECX=0. Otherwise, we have to check CPUID.05H:EDX[bit 7:4]
>> to get the number of C1 substates and this should be greater than equal to 1.
> 
> Ahh, I misread the comment.  I was confusing the CPUID leaf ECX data
> with the use of ECX hints to MWAIT.
> 
> Could you add maybe a sentence or two more in that comment to help
> clarify the situation?

Sure, will do. Thanks!

> 

