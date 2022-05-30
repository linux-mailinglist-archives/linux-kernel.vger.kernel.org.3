Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEEF5374C6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiE3Gr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiE3GrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:47:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2129.outbound.protection.outlook.com [40.107.237.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE134ECD6
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFr+8RYEh7VGwwunDxFCjC1lw5xcWmn9eC11y7aOxv/eLA/knAeUyH4ScGbyYnjDd32yQoSAL8SGVk/rc9vsZmtWII1nG6a0QNCcZTirs5UkiWKL45WXfFsW1AefQ9ZVg06D9cft46GIjOxbejBtEYPVDrfKjLCJaOLA+ZRIvwQ5lNdXmqYWnllSwR0z6eC9QyQ9wYboSUzMUNMCyJu4L8pifg61MAdpKRQPscj0P/UTkBubyyQdL8igvApzIVtO+XbH7XfiRJG/Xxxz2w2FO3ROSQ/Ziew8TYujiIa9k40s/i5DUp6QHNmgig9leEs4BxeYfMlvBvmCSpyb0PNvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIcVN7O2vN0JWsj8mOEqgAKQohpcgCcaY0zHZ1yFBOs=;
 b=oeIwzUxKpBcT7stgvvFxn6BELuGcH7kiyL4BvZ8gCgtSqlEeomiWrqbkbvy0i5b9Z87zyijPr4/fDdGOwKKuRBfziRvzaKK4MxnPIUpRiqixMsNLZreksKcw4Ur/I3OLkj0htl3APkwdc3nPYK4KmVdXzdQ4kyFaYxeHsRSrW/PNuiI+8zusL21/Hyk5zTDV/ytzpEhpQJjinxA+XaigB6DO4KHTfGM73oj06rDm8foK1Y4vD1BH7EzfbTuhh/73hlfeKmmZtgqcI26gbBldkRd3/MpuWGSskVR9HGlXUX9GztAtAij+Y55M6G8ahTJ2wur4sOzSUaGvlUtjA54jmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIcVN7O2vN0JWsj8mOEqgAKQohpcgCcaY0zHZ1yFBOs=;
 b=JIaM/hXKJhB1N9k4cuqRLCro7UHzn5b6e/1HKuSvAG9QSP5bGwpljSfwnk3mC355nVufCaz55Vd1/MN0eeMBMtloYeiFdSwG6tsoTCJPkhMRNVQCdhoxb0gP26LzAG0II9KyKdremq7WVsakeLLdKNQRC+wFjN9jzbVqUAhkzKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BY5PR01MB6068.prod.exchangelabs.com (2603:10b6:a03:1c9::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.17; Mon, 30 May 2022 06:47:18 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d9af:5602:f577:b8b2]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d9af:5602:f577:b8b2%5]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 06:47:18 +0000
Message-ID: <c57e0686-bdaf-2646-43d9-f0ac54e7eb22@amperemail.onmicrosoft.com>
Date:   Mon, 30 May 2022 14:47:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 00/22] Support SDEI Virtualization
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shan.gavin@gmail.com
References: <20220527080253.1562538-1-gshan@redhat.com>
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20220527080253.1562538-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::31)
 To DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 753a563c-9cde-44ff-e294-08da42083d09
X-MS-TrafficTypeDiagnostic: BY5PR01MB6068:EE_
X-Microsoft-Antispam-PRVS: <BY5PR01MB60686F3BFB33B0F7FB3FAF10EDDD9@BY5PR01MB6068.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: go9ZICZVAgxC/j6ImxurzUj2Jk1G2EryI+iHibnK7kaI6cL45kbzCr0WGRpo5265vI60XPULk6FIvqZxiACKTRm98ZLaNobJhOf1Fq6Nbet6QOsai6qJTnS3XLFifz+waldp7snZ/YGQGbmwGEZyUL9Iu4H+AgCpn5sRu2O3cGvyxbCai3wSboz4PpirC2zXl2plURMHHhqXTYJ7XRIXTll8E2yHmA5i3nzRhzdsnWjH3/eBoy+iS1J1KW0jTXO7VzKSuMYsmL+1tLFWKXaZksI+kBqdyEt3F6d95GYfQT8+4OV3RWY82KBCxW9IY7FxafhhuXWb+E1jeGxa2zlC9K+n5ypX8/VE5H0+x7vIqHnLFBOW3M6vHBWkHl+tMlkURyXORqi1OVl3r6e3wvk7Y86CoU+Hyb/q1/zFpjpDvNhp3+GJSpCTq1ywC5M6NoGKV9Ujf5CNak60oH+4cK8cERBWOnDK7YBV/udnBjwjqDpHMXAJN1Pka4ACnxJAEbu7uRcAoKkK2FOA/jf6TktLKjG+zm6SuhHnMBL2MKsNvoQ597B7AptMuroirANPn7Yn0R3beXWp1RmiOWMYjBOWutlSyF+bI5bRxMY+6rSwoxqHgxEio87eBeHoZVRsribIGG4GAAvbWhDx3cepz5ShT8cdVQ71Fe3CmSQAstujUGZWCmYx/nTd4vG0GYvGIkxR3hsGv8B6p3BTxwFKy2vKhXth70rqw9dSWlUruzN6XhBI57nSPHTCuVh4UI7netBE8OUZl/p+xnjMDyCYk7BwAXEmj0x5cNBnY8wb2nHlluFbECW9Q61z9YEf+JP+UU1FzhNoVsGpYjztxEtwObvaxeNFtB6vMRmNLDOUgKeRjZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83170400001)(30864003)(6506007)(2616005)(53546011)(31686004)(316002)(52116002)(2906002)(6666004)(83380400001)(186003)(508600001)(966005)(6486002)(8936002)(31696002)(66556008)(4326008)(8676002)(66476007)(5660300002)(42882007)(7416002)(66946007)(6512007)(38100700002)(38350700002)(26005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJlUjEzMHNTMzlzWHYyeUxSRGx1YnUyNTJTb2pUeWF4MkRkM3J2U3NpMS9V?=
 =?utf-8?B?dHVuRHhzN1Fjb05UQ2pUbkZpMFhJRzdCdEtKeGg2R2s3S3pqQ2s1STJYOUVX?=
 =?utf-8?B?ZEpqN0xrQnhKTENnMkg0M0pDekJIbmN3L2VLdlp5cUFGbTd4Uks1RmpJR0Fn?=
 =?utf-8?B?VnZVanAwc2cxa2VzcFdLZGRwam9iYVNwcTU4aDcrbllGQm5XRDlXWHVIcWFr?=
 =?utf-8?B?MWtLSFFxMjdVU2YvamlGZXQzYlVvRnEvZW1RY0pZUHJHL1h1Wno1UXdENkVC?=
 =?utf-8?B?Vi83bk55MzEwNG1XL2hzQnZmTHhMNW1tZ0czeW5XNzJDM1BXSzZ6TFFCVDVx?=
 =?utf-8?B?L1plc2piMDU4YzFSNGdJeC9CMVo0WkljcXA5THBiTVlnK08venA5ZXY4eEtt?=
 =?utf-8?B?c2xjSzF6aVVvbmxCWHVOSi90UmpscjlrbnZ4QTRvUUNQY0ZWT1VxdUc5Kzgv?=
 =?utf-8?B?UUFkbDl6cytNMVZhRlFNVlZNSEZzcERzUWxOa1lOeWw2QU1QMEh0VXB0blpU?=
 =?utf-8?B?azh0SDJ2K1BUOS94Nm1iWDc4ZVV6ekFDRHFWNEMxclVUcUFQcms0dXJveE15?=
 =?utf-8?B?b2s0TVgrbVhrUm5ManczR0t6blBkTGpucFhCcmRhTXVGSE5BUTNpZDRyVHRM?=
 =?utf-8?B?TWpDYVowd3A4bngrVVIxQXlZZlpWY2xiMzRaRE15bEw4dDFBWVk0Y2JuL09I?=
 =?utf-8?B?SDhUSXBSYjV4N1NPTGN1bHlrTjY3YVRQbjJJd3k3RjhzYjUwOVZXclNHeEZJ?=
 =?utf-8?B?M0UrMlowOVdPWUU5OHIybXhBUFVlRmEwVUZkaXZpZXlnTHJnM1pPbDBYVzVE?=
 =?utf-8?B?QzdWYXlxaWsxN2Z3aDRqc0l0ZEpyR1J2Y08zT1JId2Ixd1JvZmttaXV6bUg1?=
 =?utf-8?B?RTMvcDdHeWxid0dHMFRoSXo0eDkvRkxvOFhmaGs0akllcTZ4NmhFZUpOem93?=
 =?utf-8?B?MHFGNWx1V1hlc2hXZis4TnEybEhjYXJHVWJKejFBYUhzZ0VMMitWZFpZeGpF?=
 =?utf-8?B?OHF2OTZYb2hwVWVJbmlFaG8xUWhJcFhOYzRrYVdOZFBhN1h0TkhhZ0lFRGFw?=
 =?utf-8?B?bFUyWExuMVZiKzQ1N2xrUlhFcGhLTlFiWitqSU1VQXlFY3dOdlJLNnQwZERk?=
 =?utf-8?B?emZyQTY0Tklxa0thcEtzTmhyUjVnSDFIZGVEZjhvTXJIOHZTNFRtdnVlbi8r?=
 =?utf-8?B?YXlDS3hVY3RwbnA1ekRtSlYzbitKenZLcDF6RUphWnRYODFFbUxDUDE1VXo0?=
 =?utf-8?B?eXpWNVdNNGNoNXNxYUlVaW83Nzh4OEFtMHU0UW1pOUdFZXpYUDYreUdTeUtr?=
 =?utf-8?B?dURUZU5OUGtRUHZHL2F1Q2h6S3JONXNSTGM2U2R3TSs1aFJtSjgxajlDNXRC?=
 =?utf-8?B?L1ZqeTZla0FiNHJWb0p3alJwMlUyNXN6LzRiV3dXbTVubEpxTDIxOEE1bUh0?=
 =?utf-8?B?WjVPTDE5QUwxN3VBb29MTnpEOWtZeFhuM2UrM1p1RzZFT1owaVZPeHZzOXBL?=
 =?utf-8?B?d21XOHdlL3Bsb3RCdHV4VHliMGhjYWV1Q0hpM0MwUjNiZGJndUI5Rlhubm5n?=
 =?utf-8?B?cWFaN0xqbExRZDN2UU5TK2xUaHdONjJJM2pJZE1SUnBXRUZob05yRDNYb2pp?=
 =?utf-8?B?MVFJdTRwUEo4UTI0QnpRb1JFcmlFTUs1UStnYnBHUVUwdjBveXQyUzNmV2sz?=
 =?utf-8?B?Y0w4bi83Yy84eUpJYVVOM1c1UlVqMlNaNDY0NkU2RXcxWm1BQUN5VTQ1SjNG?=
 =?utf-8?B?NWJ3MC8vNTZyd3FQclFETm56REJJRE5IaFpHL0JSeG9OT0xDaThVaXMyKzh1?=
 =?utf-8?B?VWpmV0kxeFJBVzN2Q2pETndBSDJmektFM29TeE9GZSt5WlhuTFU1TUxLek9j?=
 =?utf-8?B?VWNWUVphY3hGcHlVMUdzTE1IMXkxdUhIT0hsWlFLaVRRVC9MZ01iMHFzS3VT?=
 =?utf-8?B?dkovWm5SNjBKKzNvcmtPNm5WcGoxYWJmb21USDlQMDJpaTY0QXh1cUJHYnlj?=
 =?utf-8?B?TjZGbzROTk5lajZLNEduZmppZ3hsYk9DTVYwTm5VL1I4NTFhaXFNRWdLZi9t?=
 =?utf-8?B?WENCMUNsZ2Mzdk1NcGwxWitFTTVRYW12OXArYVJyVEtsY1hmUktKS1RLUDZ3?=
 =?utf-8?B?SlRBTVd0SEMwamlFY2l6dFlYamF3Zk0wZGI1cmpXMldHUjNHTmxaaG5vbjMw?=
 =?utf-8?B?clp3RFpZOTExNFd5eGIzUE1pc3R6bUVPU0ppSGxlSEdFQnFGa1oyczk1QzNo?=
 =?utf-8?B?cjJocWJFNDd3cXhpWGFhWmZueFlHSW5Oc0lPdDlTVVBnS1h6MXRDeVE0bVAv?=
 =?utf-8?B?YjdtM01NSjg1SVZBV2R2TDhVT0hNTW4rKzM0MEdXeGZ3clRzeTBpVDU4dEFU?=
 =?utf-8?Q?eKEYI2And/1TJsopS7fEp5TfmYDhuYE4hyxT8?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753a563c-9cde-44ff-e294-08da42083d09
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 06:47:18.3200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJmG6dOCm9HSL790LuJG6L4fbsLCp9ZbRL9pHrm3BKSQ36cwe8tEa2a4swCPWOb/kyG1xFQUFtiqA0qmE3pKHG4QU45TEwObIhwfQI2ID2rSlQAc1P4HvGcBf/0rsYAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB6068
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 2022/5/27 16:02, Gavin Shan wrote:
> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>
>
> This series intends to virtualize Software Delegated Exception Interface
> (SDEI), which is defined by DEN0054C (v1.1). It allows the hypervisor to
> deliver NMI-alike SDEI event to guest and it's needed by Async PF to
> deliver page-not-present notification from hypervisor to guest. The code
> and the required qemu changes can be found from:
>
>     https://developer.arm.com/documentation/den0054/c
>     https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>     https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
>
> The design is quite strightforward by following the specification. The
> (SDEI) events are classified into the shared and private ones according
> to their scope. The shared event is system or VM scoped, but the private
> event is vcpu scoped. This implementation doesn't support the shared
> event because all the needed events are private. Besides, the critial
> events aren't supported by the implementation either. It means all events
> are normal in terms of priority.
>
> There are several objects (data structures) introduced to help on the
> event registration, enablement, disablement, unregistration, reset,
> delivery and handling.
>
>    * kvm_sdei_event_handler
>      SDEI event handler, which is provided through EVENT_REGISTER
>      hypercall, is called when the SDEI event is delivered from
>      host to guest.
>
>    * kvm_sdei_event_context
>      The saved (preempted) context when SDEI event is delivered
>      for handling.
>
>    * kvm_sdei_vcpu
>      SDEI events and their states.
>
> The patches are organized as below:
>
>    PATCH[01-02] Preparatory work to extend smccc_get_argx() and refactor
>                 hypercall routing mechanism
>    PATCH[03]    Adds SDEI virtualization infrastructure
>    PATCH[04-16] Supports various SDEI hypercalls and event handling
>    PATCH[17]    Exposes SDEI capability
>    PATCH[18-19] Support SDEI migration
>    PATCH[20]    Adds document about SDEI
>    PATCH[21-22] SDEI related selftest cases
>
> The previous revisions can be found:
>
>    v6: https://lore.kernel.org/lkml/20220403153911.12332-4-gshan@redhat.com/T/
>    v5: https://lore.kernel.org/kvmarm/20220322080710.51727-1-gshan@redhat.com/
>    v4: https://lore.kernel.org/kvmarm/20210815001352.81927-1-gshan@redhat.com/
>    v3: https://lore.kernel.org/kvmarm/20210507083124.43347-1-gshan@redhat.com/
>    v2: https://lore.kernel.org/kvmarm/20210209032733.99996-1-gshan@redhat.com/
>    v1: https://lore.kernel.org/kvmarm/20200817100531.83045-1-gshan@redhat.com/
>
> Testing
> =======
> [1] The selftest case included in this series works fine. The default SDEI
>      event, whose number is zero, can be registered, enabled, raised. The
>      SDEI event handler can be invoked.
>
>      [host]# pwd
>      /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
>      [root@virtlab-arm01 kvm]# ./aarch64/sdei
>
>          NR_VCPUS: 2    SDEI Event: 0x00000000
>
>      --- VERSION
>          Version:              1.1 (vendor: 0x4b564d)
>      --- FEATURES
>          Shared event slots:   0
>          Private event slots:  0
>          Relative mode:        No
>      --- PRIVATE_RESET
>      --- SHARED_RESET
>      --- PE_UNMASK
>      --- EVENT_GET_INFO
>          Type:                 Private
>          Priority:             Normal
>          Signaled:             Yes
>      --- EVENT_REGISTER
>      --- EVENT_ENABLE
>      --- EVENT_SIGNAL
>          Handled:              Yes
>          IRQ:                  No
>          Status:               Registered-Enabled-Running
>          PC/PSTATE:            000000000040232c 00000000600003c5
>          Regs:                 0000000000000000 0000000000000000
>                                0000000000000000 0000000000000000
>      --- PE_MASK
>      --- EVENT_DISABLE
>      --- EVENT_UNREGISTER
>
>          Result: OK
>
> [2] There are additional patches in the following repositories to create
>      procfs entries, allowing to inject SDEI event from host side. The
>      SDEI client in the guest side registers the SDEI default event, whose
>      number is zero. Also, the QEMU exports SDEI ACPI table and supports
>      migration for SDEI.
>
>      https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>      https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
>
>      [2.1] Start the guests and migrate the source VM to the destination
>            VM.
>
>      [host]# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
>              -accel kvm -machine virt,gic-version=host                     \
>              -cpu host -smp 6,sockets=2,cores=3,threads=1                  \
>              -m 1024M,slots=16,maxmem=64G                                  \
>                 :                                                          \
>              -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
>              -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
>              -append earlycon=pl011,mmio,0x9000000                         \
>                 :
>
>      [host]# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
>              -accel kvm -machine virt,gic-version=host                     \
>              -cpu host -smp 6,sockets=2,cores=3,threads=1                  \
>              -m 1024M,slots=16,maxmem=64G                                  \
>                 :                                                          \
>              -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
>              -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
>              -append earlycon=pl011,mmio,0x9000000                         \
>              -incoming tcp:0:4444                                          \
>                 :
>
>      [2.2] Check kernel log on the source VM. The SDEI service is enabled
>            and the default SDEI event (0x0) is enabled.
>
>       [guest-src]# dmesg | grep -i sdei
>       ACPI: SDEI 0x000000005BC80000 000024 \
>                  (v00 BOCHS  BXPC     00000001 BXPC 00000001)
>       sdei: SDEIv1.1 (0x4b564d) detected in firmware.
>       SDEI TEST: Version 1.1, Vendor 0x4b564d
>       sdei_init: SDEI event (0x0) registered
>       sdei_init: SDEI event (0x0) enabled
>
>
>       (qemu) migrate -d tcp:localhost:4444
>
>      [2.3] Migrate the source VM to the destination VM. Inject SDEI event
>            to the destination VM. The event is raised and handled.
>
>      (qemu) migrate -d tcp:localhost:4444
>
>      [host]# echo 0 > /proc/kvm/kvm-5360/vcpu-1
>
>      [guest-dst]#
>      =========== SDEI Event (CPU#1) ===========
>      Event: 0000000000000000  Parameter: 00000000dabfdabf
>      PC:    ffff800008cbb554  PSTATE: 00000000604000c5  SP: ffff800009c7bde0
>      Regs:    00000000000016ee ffff00001ffd2e28 00000000000016ed 0000000000000001
>               ffff800016c28000 0000000000000000 0000000000000000 0000000000000000
>               0000000000000000 0000000000000000 0000000000000000 0000000000000000
>               0000000000000000 0000000000000000 0000000000000000 0000000000000000
>               0000000000000000 0000000000000000 0000000000000000 ffff800009399008
>               ffff8000097d9af0 ffff8000097d99f8 ffff8000093a8db8 ffff8000097d9b18
>               0000000000000000 0000000000000000 ffff000000339d00 0000000000000000
>               0000000000000000 ffff800009c7bde0 ffff800008cbb5c4
>      Context: 00000000000016ee ffff00001ffd2e28 00000000000016ed 0000000000000001
>               ffff800016c28000 03ffffffffffffff 000000024325db59 ffff8000097de190
>               ffff00000033a790 ffff800008cbb814 0000000000000a30 0000000000000000

I tested this patch set. It's okay.

Tested-by: Huang Shijie <shijie@os.amperecomputing.com>


Thanks

Huang Shijie

>
> Changelog
> =========
> v7:
>     * Rebased to v5.19.rc1                                     (Gavin)
>     * Add hypercall ranges for routing                         (Oliver)
>     * Remove support to the critical event and redesigned
>       data structures. Function names are also modified
>       as Oliver suggested                                      (Oliver)
>     * Deliver event when it's enabled or the specific PE
>       is unmasked                                              (Oliver)
>     * Improve EVENT_COMPLETE_AND_RESUME hypercall to resume
>       from the specified address                               (Oliver)
>     * Add patches for SDEI migration and documentation         (Gavin)
>     * Misc comments from Oliver Upon                           (Oliver)
> v6:
>     * Rebased to v5.18.rc1                                     (Gavin)
>     * Pass additional argument to smccc_get_arg()              (Oliver)
>     * Add preparatory patch to route hypercalls based on their
>       owners                                                   (Oliver)
>     * Remove the support for shared event.                     (Oliver/Gavin)
>     * Remove the support for migration and add-on patches to
>       support it in future                                     (Oliver)
>     * The events are exposed by KVM instead of VMM             (Oliver)
>     * kvm_sdei_state.h is dropped and all the structures are
>       folded into the corresponding ones in kvm_sdei.h         (Oliver)
>     * Rename 'struct kvm_sdei_registered_event' to
>       'struct kvm_sdei_event'                                  (Oliver)
>     * Misc comments from Oliver Upon                           (Oliver)
> v5/v4/v3/v2/v1:
>     * Skipped here and please visit the history by
>       https://lore.kernel.org/lkml/20220403153911.12332-4-gshan@redhat.com/T/
>
> Gavin Shan (22):
>    KVM: arm64: Extend smccc_get_argx()
>    KVM: arm64: Route hypercalls based on their owner
>    KVM: arm64: Add SDEI virtualization infrastructure
>    KVM: arm64: Support EVENT_REGISTER hypercall
>    KVM: arm64: Support EVENT_{ENABLE, DISABLE} hypercall
>    KVM: arm64: Support EVENT_CONTEXT hypercall
>    KVM: arm64: Support EVENT_UNREGISTER hypercall
>    KVM: arm64: Support EVENT_STATUS hypercall
>    KVM: arm64: Support EVENT_GET_INFO hypercall
>    KVM: arm64: Support PE_{MASK, UNMASK} hypercall
>    KVM: arm64: Support {PRIVATE, SHARED}_RESET hypercall
>    KVM: arm64: Support event injection and delivery
>    KVM: arm64: Support EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall
>    KVM: arm64: Support EVENT_SIGNAL hypercall
>    KVM: arm64: Support SDEI_FEATURES hypercall
>    KVM: arm64: Support SDEI_VERSION hypercall
>    KVM: arm64: Expose SDEI capbility and service
>    KVM: arm64: Allow large sized pseudo firmware registers
>    KVM: arm64: Support SDEI event migration
>    KVM: arm64: Add SDEI document
>    selftests: KVM: aarch64: Add SDEI case in hypercall tests
>    selftests: KVM: aarch64: Add SDEI test case
>
>   Documentation/virt/kvm/api.rst                |  11 +
>   Documentation/virt/kvm/arm/hypercalls.rst     |   4 +
>   Documentation/virt/kvm/arm/sdei.rst           |  64 ++
>   arch/arm64/include/asm/kvm_host.h             |   3 +
>   arch/arm64/include/asm/kvm_sdei.h             |  81 +++
>   arch/arm64/include/uapi/asm/kvm.h             |  18 +
>   arch/arm64/kvm/Makefile                       |   2 +-
>   arch/arm64/kvm/arm.c                          |   8 +
>   arch/arm64/kvm/hypercalls.c                   | 182 +++--
>   arch/arm64/kvm/psci.c                         |  14 +-
>   arch/arm64/kvm/pvtime.c                       |   2 +-
>   arch/arm64/kvm/sdei.c                         | 676 ++++++++++++++++++
>   arch/arm64/kvm/trng.c                         |   4 +-
>   include/kvm/arm_hypercalls.h                  |  19 +-
>   include/linux/arm-smccc.h                     |   7 +
>   include/uapi/linux/arm_sdei.h                 |   8 +
>   include/uapi/linux/kvm.h                      |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/aarch64/hypercalls.c        |  11 +-
>   tools/testing/selftests/kvm/aarch64/sdei.c    | 450 ++++++++++++
>   20 files changed, 1499 insertions(+), 67 deletions(-)
>   create mode 100644 Documentation/virt/kvm/arm/sdei.rst
>   create mode 100644 arch/arm64/include/asm/kvm_sdei.h
>   create mode 100644 arch/arm64/kvm/sdei.c
>   create mode 100644 tools/testing/selftests/kvm/aarch64/sdei.c
>
> --
> 2.23.0
>
