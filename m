Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E1E59F390
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiHXGVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiHXGVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:21:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC6B72FD7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmyIb2xRsQXQlvWwoMUgnNAw1GkuXjL5o1P3RY0P+y5ep1DsCVXHSP61semNva8JJHSkYm3x0qQ/UVHemYJrTQXThybpts17s5d4RKQ4e0ynB6VxCm19yg2c17ldik+Jp7YIy53ETHqn+3q4u/rsnyK3skiX3ZxreSUvnXO88RbKrp2YBWjieKVFC7Wto9KY9t+hmp4CyHhkCF1xU+5PwT5f+kmDaJa6FZwEqKpFVX7UbFrG8E2bDtzav+Uww2v2g4I4nFEnq0haMTlUCTj/VDzofH/YenhiaE0bQZKUcBY1sOju6kNti3JgtJLQUQlk2C1nPHQoGeCrDQbqgr+Njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pd+XpLAWArSnCjBAv9hx1BFe833wSjuAKM3HCtXMx4=;
 b=A+g2TkGD7xfg6hyT3tEfs+Mh7aIFQmHIRDqyHzbvQ4WzLhYC5vgQIeApvUhDoWrho7Osf3HtNiCCQpDl7cQ6yjROFeCxpZIk4MN3gar6bdHUrPK+hx2nxmAzKXePnQZinIg+79Qw3B7JW1QQISz+PIxfRIquQ45et6/+1CmC+cRzswZw+m5VTVwfMb7XE/jl+p2b95FAS8G5EQ03tGVc4hSqVj7MTXlvcvlXxOEY7fqI6AQvWIdBxP8YXg+mNpqMeHSJajLeio2KNreWpzR7o+8HHl5UAZ026f8E9FWWY1MqM3nm4heX+UL0HnLIeGu5TMRZsZG+5QRZqLENcaEcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pd+XpLAWArSnCjBAv9hx1BFe833wSjuAKM3HCtXMx4=;
 b=yqE4FRxUy/wU8s65sr9fZxL9lP21uAeZeQTb90YiIdZG70iJqFkBQ8MdRPvZgteOPV7WoNDrftsCMtg+GVZpJ6tX7EY8ZGHbGV/NbIC4WB4fyyfKJfbLiJZwAFLtRdXXy/dIYoII0+Gyph4bOzbfn5Xlp9b956vMEBLrsPSSwJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL0PR12MB4706.namprd12.prod.outlook.com (2603:10b6:208:82::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 06:21:48 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd%3]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 06:21:48 +0000
Message-ID: <12eea3b0-8f9b-1c29-a974-851077b80195@amd.com>
Date:   Wed, 24 Aug 2022 11:51:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [peterz-queue:perf/wip.rewrite 1/6]
 arch/s390/kernel/perf_pai_crypto.c:438:18: error: incompatible function
 pointer types initializing 'void (*)(struct perf_event_pmu_context *, bool)'
 (aka 'void (*)(struct perf_event_pmu_context *, _Bool)') with an expression
 of type 'void (struct perf_eve...
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@amd.com
References: <202208240632.w30XSBZs-lkp@intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <202208240632.w30XSBZs-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1914b6-cddb-42f9-8214-08da8598ec68
X-MS-TrafficTypeDiagnostic: BL0PR12MB4706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+w8w9QyEwbtxt9jFZKBmC79C+gfai2DXXau8GGRwaby+mWJhduXRNQWdHeYX4n764X56ddXYeLoTVFlQbox2lQ/jlljC/yQnIhnrPe3Jshorx4m3qK82NgUNAbYJnqu9c89U41GGRUeOg8atxUAbTOgRNK/tUtc8LNQRcWBK/cC3EryPOFnT7poTtWKnylUUEjVBBBX/g8TkOqbB9rw5PNUSPMJzWhqYIyW6Gmqo9jv0mUbxHurCZIDBFdybDT/dUj2INOXA4gOH5noOlrO0n7B8fYGkkmyV89s7g2oO0YrEwTDJqs06XgPE0RKwnXvoUDtv9+u+FQpx6vpSmw4TYD1vW8JERnVJLAkUC1wU9BTvzmGnpH1Bax1oom1byU1mtY12i3iXJqVOjjg5hPQLWRmDhCzFouYAHLOg9MC+rJjWUbLlmnnweYsNMyvPh5x5TQuw+UWa/DJOgIE+cRN+HKr3N2IrTEinCSKRkGykgQZHZWZEcbenVpraL7H4PiSufgKoW/50exXuupQi8rv+jSOLyUBFyu+qUT+aXPsqnHT2dye5t4rckv8gy/aNNn7rKhRlXd4oEaiG/fuNJOnwf+ZLW6qMnK/YYwuBEAqtPfT1CUgJ4RrTDKZ/oR6b1wYbJFKYcaPQcGwCtMyzhqalIjx44cFOKXvL/5jzqi8E+WUJNIzY0l/bhqrIv+t2L2675sV8mOhz8v+ttn75OzujY12h7tOpc3uhR0SSRETIpzyZsqFbglBf9jIR8gBeUOwmTBeZp38BYqf447ETYYiXgkbfPiNS6NDWVs+Lo3V/I/DRcbAYzU2xU4mx7cMX+rR0x+WalF0y7FYw0teadJluL5/0JY9uwwAROsfSfi421U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(31696002)(86362001)(110136005)(316002)(26005)(6666004)(6506007)(6512007)(2616005)(966005)(5660300002)(44832011)(66946007)(38100700002)(6486002)(36756003)(186003)(31686004)(41300700001)(478600001)(8936002)(66556008)(8676002)(2906002)(66476007)(4326008)(4744005)(219693005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDFFT2ozWkM5ZzJqQTM4bEVGQTNmS0dlSTVIdFozR0Y3UlA2WWcza3BNRzMv?=
 =?utf-8?B?MitUYnZWbnJpU3pVMXpHdnNCVTNKNVVIeHdKaE9VYWNDT2lNbERORWtzaUpC?=
 =?utf-8?B?eXNIbjFBS0pSYmIyRlhuZ21aY2JSNnBmN0pTellxKzcrL2VLZHNLL1F2S2hH?=
 =?utf-8?B?WGY1SGxpY01lZWFFZUtVVlcyRDhBWWwrQkJNMFNudEZ5RjUzZXlsNnIrWFNT?=
 =?utf-8?B?QlFFWFEwK3RZOGZCQVdBM0ppU25wcG10aDI0cDFvRHRMajVoeEttQjVEM2s0?=
 =?utf-8?B?SGplOEZzVTJmRHh3MjBJRlBXSjQrNnhVa0RhZW0ycEp5UFJ3ZEFJOTlzQmFJ?=
 =?utf-8?B?Q3JXc2x2N09GdHlRSjJQeFZkb1p3TTZEalNZdC96bXh3RHMwcUYzYzVCMG1W?=
 =?utf-8?B?ZlB4NHlhZEExTHprWmlaT291Rm95QXI0d3pHNW8wcHVsc1BBcklQKzliYVdu?=
 =?utf-8?B?WHdDMHkweFlXalc0cTFZNGc1U0srcG1CWnpnNng0VFZrN281RDQyQUlmZzFu?=
 =?utf-8?B?MW5INllyWmp0NXpmdWxaYXR4blIwSHJZL3kzMUF5S3l5OU8rTDhLMXZUM1BO?=
 =?utf-8?B?UGpYMUJoRjFkWlJoWGVEaW1VSFVCUmFGcGc2aDArbld5V29Fc2xqL2d4Sllq?=
 =?utf-8?B?NW85aVFRdXpFbU44MTNTM3M0a01pekJqanpoM3VCTngyU0JtRWE1VkVzVTln?=
 =?utf-8?B?WVVMQXhNTFZCU3ZCYmZWb1BnYjJUSDdaMDBmU2lYcU11aTAzcWpYQytkVXJS?=
 =?utf-8?B?QkU5dzhseUFyeGR2K1UxV2RFcDBqN1BSTnpMNE5paFQvM2w5QnE0TFVQby9l?=
 =?utf-8?B?ZnhNZkZPNnlCTnVzanhyc1FiTHB6UTdLUHUzZGMzdTY1eEdKU1ovNklCbE1E?=
 =?utf-8?B?WlFJQkZoYWhuVHJGTE05N1MrQXp2aWk4eUM3SzNqUmZiZitYUnpyeDVyR05Y?=
 =?utf-8?B?Y3pMSnJRUnpuc1pMSVN6NW1aVW1kU2V3SFNhTWprWUFjbUM5M0U5MFVUMnl6?=
 =?utf-8?B?SGd6TnA3eFpMSXltVlU3VGVKcHVaaGxxYjBBb3RCWjIxeDFUdzNxdXI4NUhG?=
 =?utf-8?B?WGVrQW9IUHN1UXJCRFNjL2RzY1VrQ01SdXVVQ0VOZGxON3I4ZFhMOEdKVUpU?=
 =?utf-8?B?bTZGbXJFVFdWcGFPZ3Y0RDNvNVZkNVBkemNySml5ZkkzY2FXSGlSQ1l4eThm?=
 =?utf-8?B?ZzMxVFU1WERnVWxWNTRHSjd6TnVhVlVtTWdjdm5yVEhJd3JlVkN6WXlmZnkw?=
 =?utf-8?B?SEVScmtaYitOb3lrRHdyUHppNXErcjRabHlaUmtnVnFBUW9qRkd0SGY0dWZC?=
 =?utf-8?B?S0dIL3RlTTJLaVpVVUNUSURwekF0R2lkWDBlS1hramJ5YlN2THVnU1Q5NEVF?=
 =?utf-8?B?dExvN0UrNTlWcXVTOVZoaDdYM1RycU56TDdyckQzR2ZwRkJ0RWVPb0xuL1J6?=
 =?utf-8?B?T2ZQdTc5YVFabllqYmFsVm01NXdCVXVYeHI5TlJOQldmRnMyRloxSVA4VElG?=
 =?utf-8?B?NENMbDV4ekVBdnB4Rk8rNmRRbWkxZmExTE1PazdaQTFsL2VUbGJOSlBaakh2?=
 =?utf-8?B?bHBFYlFrNHdmQzBDcWpORzdpS2labkY5cDVsZWpmZTdydzc1cVNPL1V3Zk94?=
 =?utf-8?B?WGNTVE1FMXRHcWpGNU5HZUpIMWI5RHhuRGwzZUNmdDhjb1ZLK1BaRThscCt6?=
 =?utf-8?B?aCtvbVZxT0tpMmNWWHBFRXdvTGtFNUZYMDMyNjlXS2M1MERYKzBkYUJJUkJh?=
 =?utf-8?B?K2FFRmhISTdseVlVbTIvUk9rOElNU3FSVVpWZ0xoOGZyZTBRU0JEQlZ2bVFI?=
 =?utf-8?B?RlAxcmJUeHZHQjF4Y3J4aEtTaFNIWUE1L29OQ2hLdHhXQVpGNGE4WGc3Tzdj?=
 =?utf-8?B?dkVGZ05zcVVyL0J6Mit4NllmblV0YktibEhGK0QvbVY3bzlTODlRd0dvU0ZZ?=
 =?utf-8?B?ck01Q0dRaEI5V1JtZkJ4SE1WaWd2Rk5JR0RwMU1Vb3AvTUtELzNLbzZidHRq?=
 =?utf-8?B?dVZtT0lTaGdzUHAydjJSNjF6VHlWRkM2UlVBRm1IeGU3MDRGSHBJWW5UMnF2?=
 =?utf-8?B?aUpZWEpra2F4Zndxc3o3bDg0c05SY05KdXlOR1phd3JjaURBWDFQTHlhOUZ3?=
 =?utf-8?Q?VIyuYe7QhoN3xx12wJXOMe8+d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1914b6-cddb-42f9-8214-08da8598ec68
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 06:21:47.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/MuEQ8/+vRBzehdm4nEyT7PY2nd9HEAz12WouT43EFQKrguXAY6vdBg8omwhOulSZXcMbOCqOU+NAoR7StvZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> arch/s390/kernel/perf_pai_crypto.c:438:18: error: incompatible function pointer types initializing 'void (*)(struct perf_event_pmu_context *, bool)' (aka 'void (*)(struct perf_event_pmu_context *, _Bool)') with an expression of type 'void (struct perf_event_context *, bool)' (aka 'void (struct perf_event_context *, _Bool)') [-Wincompatible-function-pointer-types]
>            .sched_task   = paicrypt_sched_task,

Thanks. Will fix it in next revision.

Reference: https://lore.kernel.org/r/YwOkFqqxONtoGImZ%40worktop.programming.kicks-ass.net
