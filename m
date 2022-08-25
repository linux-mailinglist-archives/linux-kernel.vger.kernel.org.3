Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF945A1061
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiHYM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiHYM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:26:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F8B2869;
        Thu, 25 Aug 2022 05:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtT7EN7CdTY4NArma0i/KJagDGuNifmL+AfUbPV/nLIGJvCQOuEO/Kq3Z8C8RKo90s3QRNY6WdbnVISvYU1NJjWD0TmOnd66Fh1jCJggHJqzXOjGTRrNSJ3YTfmsfnk2NcuwPU4wgi+KuC0tF5FZgKXxOUgd8VgLoYBsJwtwGu4+6SN2iNecsVmoPUqVF0Y4eJngf+BiQ9VNzrhGuQECzFXNehwBSrGCsVEE5TEizxgHR43Y9NCn7Y0dLIlF7uUEMhkkws8jnDc/Xose8Gb40E1i5JPiV64vKNsS6ec2X6J6K6ExCRTtzsoMqU9VtSmFZFNw0gsoe9xTgMJtQAUKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/5qQtxHevv6TBFbyaGbJJyfXo6ub0pKZXJx8r9E3T4=;
 b=Zz86FeLFDJUDjuPBW7lcJqGJB6sco4c1OfACeVPShK/AL/qz5TRrzgofIeI614+pcaablUU18NSJ4VgLB3vugomS+7k/HnBpj+jq1trqeq0A7XPYMdwc41bFemwXSrdDuHsjTswP+g1Mlu0ASrqxjNrQMfUpDSWphpEbIw2q6GmZvwD0/pXnoj/Yf22VeTjUZEqA9Zk8WtUWl0GifsV/JhMTdXxUFuBF7hXDbcKxnkvYTdnYS4c5QhPNUminsp1CHgF3yzHlBXvlHFrYruIcp5CLNnTqL76t6gpdXqlZQwmdRLop2SPOknxSrh8vyZBmaOMcqvIKc3DEJ84KtoXCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/5qQtxHevv6TBFbyaGbJJyfXo6ub0pKZXJx8r9E3T4=;
 b=eiYbeVsImz4HlYS3i7Rvv6fPOgcizJVTco6jtD4+cke8VYEMUBs1LfB+bx1LI7gDsfq5C6bZ+dz9UocxNLTD0JJTEScYJut9P1pZ39YUlgUnSJvQyXxRu85QXyIjvIYy8KJynzo6UT4WTl+sMIJdSIElMkY58Hs6tyUE14MeL/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 12:26:52 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:26:52 +0000
Message-ID: <275f10b6-23b1-6939-d58c-d109e127bbe8@amd.com>
Date:   Thu, 25 Aug 2022 17:56:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, acme@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        dave.hansen@linux.intel.com, like.xu.linux@gmail.com,
        Stephane Eranian <eranian@google.com>, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
References: <cover.1660211399.git.sandipan.das@amd.com>
 <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
 <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
 <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
 <YwNG1XzcyR5ys+rA@worktop.programming.kicks-ass.net>
 <06e9a357-422d-1870-ae72-18e74964caf3@amd.com>
 <YwOEIESeDSuekmf8@worktop.programming.kicks-ass.net>
 <91cc5c2b-75d9-1b2a-9ad0-a94a60ee72c2@amd.com>
 <YwdNwBeHI3pBQ5F6@worktop.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YwdNwBeHI3pBQ5F6@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf34ba61-1a0b-4551-8a39-08da869516b9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5801:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+iAhw4ZmWetwxdUBg6B5w2UU8f6ccza1p17v5/g3ke4AzsGN2/QOLhCnPNau/yAbl9JnAE020oKhu+9BJ6tZJNtKKMGTPJHSSk23Aq05s9OUclTX5b7AjzAxDA/FEKqtBa/NkV+ALIrMCXz7B0reMMtXWMUvbaaQhJ7qJ3yl2dlN+AafInVJrfPm1FZGkqziFFHbbnw+HXWPwG1WPYoomvCYv1J+wkj8XICSFoNGZ1uGdhKmmDZf+aYWsPE8YaoiWBHJRCuWSVCWDCk5Ihcug6azDILhodWcVyVK2Mjq2r/sFvVV5pCNblxULmhhzb13e2ouNERfU71p0dKtPWOoqTHwgAVVQg8yy2qrTjEV8ceFmljFJWwy6Fe2rYgR9lUJq339ZZybtpI9SwIkyVK9wWal+MVg8w91+kAjAcNXVb5JagP3uRyg9Tnb26IXRF7AxL9bud6n5QvIcaLrDftq+7GFfktPvRHHJK4mQc6SWutYO8HbTSMcKODJXuyf7QglXjV6hM3f3qu2tkSJp5QZ3Pru25eLpas5qJFmFnArTKxy+oQVuYgpfmogLgVIIYqraY+2UbkqRndUHJokMzQka3ep4RQy+OynkcfbkRWCdnyVw6ohYB0r7LzVRIEDybQ389cuxQLTWUFnpubQ0sn6QT43g8uhOOFfJ1iJR8SsBOmGj6IkdXff4iw+495XurslrKfFYcqzpB9d3HFpx+IMR4j4IT08UOvx7uHbrCVRabvU8/TzwFFtaFrq28yTqY5vTgPXcqFrSBryMjHCNrozQE3I54KrYNKTItCNn/NbRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(316002)(186003)(2616005)(6916009)(6486002)(26005)(7416002)(2906002)(36756003)(558084003)(5660300002)(31686004)(44832011)(8936002)(31696002)(86362001)(4326008)(66476007)(66556008)(66946007)(8676002)(6506007)(6512007)(6666004)(53546011)(478600001)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9RenNMaXBXcUNmKzlSb2EvZ1EzOTQ5S05OUHljZlgrWExwN25VckdOUTdo?=
 =?utf-8?B?QUZrRFZWRUhDM2NzNXVzeFBiRlArejBhVTNDTkdxeTdTMUVoS0RRTG9OMloy?=
 =?utf-8?B?SmxrMmVFRlhrR3lVQ21oMy9jREFxd2RXeGwwQlRmaVl1SHVCVXBxM3R6cnla?=
 =?utf-8?B?U2tnenNnQWlIeFhIY1NzeGJZOXgwUXZDZlh2T2I2Tk1jM2t6TFFNSXgxTFVn?=
 =?utf-8?B?QzMvS01oWU5OSjhZUEJWa1YxUFB1VVl1SFpxTFF3NTg1WmpKSVo3dy8zcDl6?=
 =?utf-8?B?L0YzcVVlV0d0NFh4cU9QeEJ5c0hnMHo2Y1FHL1ZnTXlDaldpajRxWU1sQWsz?=
 =?utf-8?B?alo4MFZBT0JoemxtUWRMQkdIWUsrRGkrOHI4UE1sS2FkZmtuci8rUGNIQU9h?=
 =?utf-8?B?L3A3QUNKTGJNcnR3SHZWd1hTc2RpczlYeWlHZU1MQVV4SGYrZFNGa3RjNGl0?=
 =?utf-8?B?MGNNSmY1MlNDODU2L0JtTVZzSVIyc0pBQllBNUJnTmtNSFc4V1JSVWY5Ujdy?=
 =?utf-8?B?bEFwRjY3K0pEbEJMSnF2UzlsQXlXRXRrMFI3NnlPNVAzdnQybjFrZGhkbTBP?=
 =?utf-8?B?NWE2bzNXbVpRT3hGcmFYS3ZOd3k3MHFOOUlKZm8xaHQ3VHVQdXdDSjdQVkNV?=
 =?utf-8?B?VS8wQThxVlFFd0ZjOW1FRW50WjBUT3VOak44RUhBQW1VNTlTKzAzVWFWejk0?=
 =?utf-8?B?aVhWODREZ0treFIvRVRCL1J6dnZnWFRIN1lJMzFoZCt5eE16VnFhTFlxd1ov?=
 =?utf-8?B?V2taTHlVeTNpSnBuczBwZG5sTzE0c1ltRXlsOGVlc3FNWEpZRDRKcGlNZXZo?=
 =?utf-8?B?UjhHb0l3eGRnSk1uNG80TmpUYUZOVThoMGtzcXp1UjlTdlpsK3pMWWtPUDND?=
 =?utf-8?B?QXZkb2RwOGxmdWo4MDNhQWZ4Z0Z5dmpvMi8wOTFRSXM4M2k1WmU5YnFwaUZC?=
 =?utf-8?B?T3k0dXFwanRaZnZCNlNBcnZPZG1UNC9KUDNsUUthdWl5TldlQjFEcHJUejEv?=
 =?utf-8?B?TTBHYlp0ZS9sY2o4V2MvWUIvYXhVWTVBaU1SdzlGcHVJVTlCUTRjekZORUtv?=
 =?utf-8?B?SVZYcUpZMmZsMnB5TDJ6d0JWRCt6enJHdE5YaUxGYWl3czVtTldxUDJ2cUY2?=
 =?utf-8?B?OFJESWMvOWR6TVJ2bWtUdUc3L2JzamV5Q0lUZ3I3MEJ1cjVQbVJVZ1M3YUlw?=
 =?utf-8?B?ZlkrM2E3ZDk1QUh6dkhGbWJuMlRnUVVkYTlBS3IrbzB2Z1BjR1l4UmtXNEtO?=
 =?utf-8?B?OXgvWFpwVjVVMWhiNitYakE3TUhkaFZEY3dpY3MyVzQ4Zm93bjNNMzhDKzh2?=
 =?utf-8?B?VmkxNVloODNmM1hwWFAwS1R2M1ptcUNlSCtSWitPbFlPTXZKdDNObEowRnpi?=
 =?utf-8?B?QUVXL293V3FUL3B2Vmx5Q1FEazFGTktNYWEyb0RYQnlrRjF4YUtJSTVWelhG?=
 =?utf-8?B?YjB2WVlQbDZ2ZzVGL3VQbjZMMEJXK0ZlZUdPdExpbTRtM2NhYlFoYlhSNW9r?=
 =?utf-8?B?RWI2VzllbjBUblJ1UFRPaFdWanRBSlo3dmtUY3Q5eGkwcGlFYUNwV3JzMVBF?=
 =?utf-8?B?dU1xeE9ndE5GdEtIOGRGZXoyMHZGYTltTE5wMWJ2VUtrSWk0VnZhNk1jYktD?=
 =?utf-8?B?NHB2ZU16T3NySDZVcXFDWmFkRWlYTVpvYzRtU1laZUFLdGhKSDlaajdEYVdL?=
 =?utf-8?B?cC8rR2RMcGJyaDN1QmlUUlNqZkh0WXg2ZHJzSzVubzhxVGJaYlk5dW1Xamdn?=
 =?utf-8?B?WWwxNmtwb015T3U3aWYzN21nSEdrTFUrU3pCQkk4dndJdkZ3QU1STHg4YThy?=
 =?utf-8?B?eXdGcWE5WDRTdVVsalY0bFhSS0FsdkRjUE5IS2RpSVBaTVVwZ1dRMmhRaVlO?=
 =?utf-8?B?OU54V0R4WWNBaHhEb05NcnorWEF0WU1CWDVuRGxmeVFEZlJTbCtBMGhNcUJJ?=
 =?utf-8?B?M0pQS0RqQUhzZFFKampZdjk5WkRONmo2MGhQU3AzZ00rNXJEV1JnRDNncEdy?=
 =?utf-8?B?a3VOVnBmYVVOM0xsMUprMVV0VjBMNW9RUEg1K1YzeU5KU3dHVXk3cjNiOThp?=
 =?utf-8?B?cVFNdHlUSzM1V0psSldzazZEUUJheGtpVjFWaHMxa2NrM2xHZS8yYzVsR3po?=
 =?utf-8?Q?tQkAPddGjCE6BYNUC/YVwdCUa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf34ba61-1a0b-4551-8a39-08da869516b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 12:26:51.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ne+UGayPX2mYlesoU3PLFwqDGEqQMaTq5BJQiNf5UgafVP9yIoWpdV3tPNgfiFrC1P035jq8bNEo2UvnJg+pqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2022 3:54 PM, Peter Zijlstra wrote:
> On Tue, Aug 23, 2022 at 02:21:06PM +0530, Sandipan Das wrote:
>> I can rename this feature to AMD_LBR_V2.
> 
> I've done that and stuck them in queue/perf/core. If the robots don't
> hate on it I'll push them into tip.

Thanks!

