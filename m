Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9659B816
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiHVDlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiHVDlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:41:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2462494A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 20:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDBuz8XcZl02hz+zuBeO/e6CUexdj2n1WOL4lUdFivUcd25pbKviIRDHhE8d9y70HH3z6KgGDbzZzKM6OVVIwyqmQbXN/rdpHJHV4YaztLlwgD/cBbaYGS5kcnjwqn2fi0ElR/Lyz4BLqcpaFISL7X+Djje2HCKZkORdFXnsNKTpIRD8qUtdixm8XUyYPcrsanIhCk6m0afHwZJNQ8QMDeblqOSXpFUYgkBi1TKq2RXnLtyZxDkDpdgL4QQdGTOsIQyAk33BgygGwjooznjylsLp8lWIBWRPBgc7kQA3NgHTp34BX0H33ubYwp/GQ2OK6YBSynQY/T4kKSSZsGEZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbQg0wNA8sg3genWxx+proDR0r3hfWcitSDF9qp8jGM=;
 b=U8NMYOmuDiAAeQqcNZ4h3IApu9D/n56ZKRDUXkWNFxruniLQCEs2gtMGuB0ebcAbRUlSkAtDzHOULGnZZ/TgyOCwz+zu2SLw7NlbopjALfAC4EM8YHPcnlko1QTIyMOPYTSKejCTVF/ONo3XxN6A/JtUdsaaZ2q/MT7SbmLFRjnVrK+PJYZvB6eNjXEX/hYdsy6D1tx1GMYAiHQsK0CIkvV1bsLzeFPCghTFGhfJ5s2dLSY2ivSINkrmLOzvduWk4REZGADptJUbvy1CM7u3Je+HRFiad/jphpQnYpNv0uiWOEybgKQYyE+LUn1YFCAq9qohOY8Ehx6U4oEo9tlDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbQg0wNA8sg3genWxx+proDR0r3hfWcitSDF9qp8jGM=;
 b=DKSIWVXCFc5Oim66mYqmIdTRFaDwumnDrbOBBqH2cFCDnUkoAIOiRj9rMzN7K+k5x7EBxTAgr7NRqZK7tl4THoO0pfENPCMjMykyjzjYtZ5hZIlBTzoL7XfCF2U9mcCbNkAYiGSs/TFbXhWh9wQldrWQeSEyRSHkJASO6daIoCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DM6PR12MB3276.namprd12.prod.outlook.com (2603:10b6:5:15e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 03:41:30 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::bda4:d489:fb33:6edc]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::bda4:d489:fb33:6edc%6]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 03:41:30 +0000
Message-ID: <537a6b8f-547b-3f12-25a7-90718a1675f3@amd.com>
Date:   Mon, 22 Aug 2022 09:11:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v15 00/10] mm/demotion: Memory tiers and demotion
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
 <137cf90f-abf9-4a6d-08fb-ef3922685ba5@amd.com>
 <20220819173431.5c391297042eff209e821088@linux-foundation.org>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220819173431.5c391297042eff209e821088@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d3060a7-8ba9-4443-40ea-08da83f032f1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3276:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QO2ikC5lL9O8EIhCe/fKXRhsh3Z8aVRfanJBEeEVghdiVD/u/hLN3+rYHT+o8nUhkoKbXC5mMeDM1BIfK/NiA8+Coy6mcBLsEvd2HXr2No+un1IWDgWqTTGlbRCAH36Ig2Vhr/ndayiFb7KgWXxUxqoOl0HYjl5oF5jLvZwNpLtei+vtVAzzDLrveKL+0WRH0DMU1OQ6wI3SeGumu0f6qr6qRDx5rjMHorRXgPI748cmCle1PbnZOdW8ga0BTb1UrQVniYxOtP3qbGQ9+tLVP5fAJWGklBRIy5gChxNQNu7/Xhf3ofUCHPM2JV5oxyO3aCisCTNRF2OWFUg4CyuSgo7K3rsdt7+zHy7fxP5tQW/Ve7NBMNm72IpzUPmEAtoDk5x4Y+2+pbZM+UuUsYYbqhGrBnnqccRiYCF+sfW9OFozel3pi6PG1ZA2Fzu1cYPmjDMBEpk3+ubdQnjtGTRy0uKZW4ZPKZpaduCgd0r52LXKtzisTDIYgGPBLTVAh81AiFvEExwuj5DMNdjLMXvl4XCHocOQwxzgIy7ipH9Q9ch5huRVE2nlvOwPwfkXcVxhA94eJ7yqZMLNIZWZyu5BytdNzRNKq3g+5Xug1LN/7Lf77+BE+hJs0MwHIGbmuPoMnv6f60GWAw/ly6VNX1+Ela5Is8PPSus00KPJ2+E0bjmBx3gx3eF3F/rIXlItVdqEBdeSVOx5J9tc7UjukbkajDmYABU1VzEpj0x/YPofpjgNNpWkuS0nMYc8QILTwgDeZtbZsDThdvghompSGl0M5eKTgvmmxvxKVRrbqqx1UzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(26005)(186003)(478600001)(6486002)(6512007)(53546011)(6506007)(38100700002)(2616005)(5660300002)(7416002)(6666004)(66556008)(8676002)(66476007)(31686004)(8936002)(36756003)(4326008)(2906002)(54906003)(86362001)(31696002)(6916009)(66946007)(316002)(83380400001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRqMnJ4MnkzNkQyQk1RY3ZZUTNicC9oK1pOYldlOWllNW5NL2JoTU1relRn?=
 =?utf-8?B?Yit5ZEJHWDYxaXc1aWZkT2orMklpdkNHVE1Tb1VPM2JWSHJIdGQ0Yi9aMHdP?=
 =?utf-8?B?S0VxaXJ2c3M1MWpJTXJFbks1Ny9wV2Yzdm1pamdBVmVxOFhaODNHeVRLaC9n?=
 =?utf-8?B?NkVKcEpad0pZeDFZTy9tRFZlRHRHTk0xamt5dlNaUnZUVStYZll0dHM3S0hP?=
 =?utf-8?B?SGdpOU4xcHFsUGZZbFpwSWRGN1QyUXc2d01sQ2RPYThmWkVUNFEwc3pOR0dE?=
 =?utf-8?B?RERodGtBUHRpRG5uY1ZzYXd1bE1jYXNzZExFcjd3SFdaWU0zQ1pnYjFVMWF5?=
 =?utf-8?B?bXoyZmhKaDNPZmdzWVRTRVBRNzJyZS91Ly9yV0pNaWdoTnZrOXVHY2pFUU9H?=
 =?utf-8?B?TkNBSG8wS1d4R3UwNWRHR29RbVlxSThZQmRHWnZEbzI2VnFOdjJVTE9xU01n?=
 =?utf-8?B?RmhyQWprRm1FMTVTdW9rUmVpM3diS1gyNlh1KzB1cS9QYWk3WmdyaFBDY3Np?=
 =?utf-8?B?TFlEdW1uVkU2TkJUUm4raFpIbG0zTFBvV3p1bEI0ZUdXOXhZQ2tibUpaU1dZ?=
 =?utf-8?B?QlJzSjdwVEhZeVlVSVJOV1Jib09mcmJsdTd2ZVQySHBUR1BRTXB0bDk2OWpS?=
 =?utf-8?B?RlhrTTNTbnBORzd3QVBjMFRPcjJYQVBYdSs3ZWRqbEYvdm4xenZqZWlsVDFq?=
 =?utf-8?B?cjdXKzUwcHpjdGZ5cmNMbkhZWElPZ3p2dEhlZmF4K0RrN2RIdU9wSFVQTVgw?=
 =?utf-8?B?dnRrMEg5VG1UelNSbENQMDBCSkZNWUFtMG1XN2hFaURQL2I4Z29uMHJMRElL?=
 =?utf-8?B?Tzl0SnlzU3RJaFgyN21YNmR1SCtKdmpIdkdFejhvdXErSEtKUkQzTU05V1g5?=
 =?utf-8?B?VnhUKzlNb1JSRmtBbzEvQjkyalJvZjNrdXBjSWJBb2pYVzlBWmJTUklJSGdQ?=
 =?utf-8?B?YURrMGFDMlM5S0E0SXhWdkppUk5LdWQyaHArYVU0bWJIbllNNWVvanZtR2l2?=
 =?utf-8?B?eUxyaUNJWUlwQWl0M2NXR2I2TCs1bHBDNUZUdE1NMWp0TTVNR0FBNzVjSk56?=
 =?utf-8?B?TDNMODZNd3E0VFZLbmVBUnBMTVVzTkUzdkVyRGx6ZXppV2tmZzQyMWx2cjhq?=
 =?utf-8?B?QXFtVjE3SXVPakxWVUVIK1VDMGQ5eFFJck5MQktkRFVSZHptSnB0UXVVVzFt?=
 =?utf-8?B?UVRNZVJUODN3TWdUOGoyalAxYmYvSDBEalQxWTJlcFpQeUJnekRydFNRZDVo?=
 =?utf-8?B?SExzeWxLMkR0KzNaNUYva0dKZ05yY3JyR1BMaWRpcitkVElnRy9HVE9hdFhG?=
 =?utf-8?B?L251M3g0enZLWW5zNm5tZWp5ZWY3Rit0ZFBmbzlKV0xnRENJWXZCZTZZRTlh?=
 =?utf-8?B?Ukt0c0ZKdUI1QU43dkdDWENUaU5pYUF3OTBTemdweWF1dTY2UlNQWWE4dVFl?=
 =?utf-8?B?cksrVWpTMit3Tjd4VitCdU5sbzNZK3ZBcGc1UGJ5Ymo0dGhLbERFd2RHVktU?=
 =?utf-8?B?eWUvV2Y4SDZ1eU44YzExTS9lb0pidWVYTnlmaXFYUlJkUmgrZzB2elgxNS9x?=
 =?utf-8?B?TlZCWm1ZT2xabVRoY3NXL1h0LzIwOFNTZ1BzeXkxd1pZTWVDc08rL1hzc2V4?=
 =?utf-8?B?djhldDRrb0xKMUtSR29hWFE3YWQvTDl0TWlONURlTTJoRDlJdE5rY1VJZ3Fm?=
 =?utf-8?B?TXBKaW1UT3c3WWh2c1orMDdsQXpwZG1UdkpnaTI0NGZ0dG5qMjF5R2h5d3FK?=
 =?utf-8?B?RGlxcFdGQ3ppblZpeVp3ZmFuYkxFcjB5SUxKdGhQRDBoY3FiVWg4S3NrQytP?=
 =?utf-8?B?MXVsUklXWDhydkw5eFRjb0VVRFJnclg0MjhocDh1TlBYd2JKYjRGWFdUYmxs?=
 =?utf-8?B?Q04rRW4wOThpOURONEJweTVJRjV2b01LZDMyVW0vRjF4Rit1cCtOZVk5VW55?=
 =?utf-8?B?UkI0V08xNUlWb0laTVFuNllKWDdiOTBGVmthTjNRYU9pVFAvT2g2YU5RRlRV?=
 =?utf-8?B?a0hvMUMvaDdHTFUzcGhQclRLSW5NTXh2c2REQTF2dXY3TzU2RG1ndnFvRi8v?=
 =?utf-8?B?ZFRNZFh3bkI5endMZFRJQnhJdStFMU5LZTFJQnBPZU9EZ2U4YkRzaWpISlc3?=
 =?utf-8?Q?In6J+EWratyy0QXjchgs1vTHc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3060a7-8ba9-4443-40ea-08da83f032f1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 03:41:30.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H405WhkP3D1c+omaUBJrLzcYWzUNDHOQaDFQP5gxJKa7ztjbXmXGSVAaRHPL8It7JCTeKeEaFsk3Ig2eE2n5Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/2022 6:04 AM, Andrew Morton wrote:
> On Fri, 19 Aug 2022 11:57:18 +0530 Bharata B Rao <bharata@amd.com> wrote:
> 
>>> The kernel initialization code makes the decision on which exact tier a memory
>>> node should be assigned to based on the requests from the device drivers as well
>>> as the memory device hardware information provided by the firmware.
>>
>> I gave this patchset a quick try on two setups:
>>
>> 1. With QEMU, when an nvdimm device is bound to dax kmem driver, I can see
>> the memory node with pmem getting into a lower tier than DRAM.
>>
>> 2. In an experimental CXL setup that has DRAM as part of CXL memory, I see that
>> CXL memory node falls into the same tier as the regular DRAM tier. This is
>> expected for now since there is no code (in low level ACPI driver?) yet to
>> map the latency or bandwidth info (when available from firmware) into an
>> abstract distance value, and register a memory type for the same. Guess these
>> bits can be covered as part of future enhancements.
> 
> Should I add your Tested-by:?

May be not. I have done only a very minimal testing of specific scenarios
as mentioned above. Thanks for checking.

Regards,
Bharata.
