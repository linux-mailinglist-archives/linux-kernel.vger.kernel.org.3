Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BECC4B2F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352815AbiBKVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:09:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiBKVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:09:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC21BF7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:09:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl4j6EezmUeQg2GsjzPol9Oelx9M+MO6uk8plmTBfU5wSiO9l8uAeo/IV3keQzR4dv307iVw5z071xRbYNYgvygQlPbqN6Zp4e9SBSMv6O0v5dXp4Rv4CPUv+E0qz99jDauR94rdt5oURMwKMBH6tNgMtSJspgO5r6jIbMzCfg8XNPzfbQhzwXnERQTNNre9uvAmBou8QMboM6puLcG9J7aKH2gA/ESvlI5dr1PxS/bB/dBBzQAt2LaytZ1jGGjvRi7L7tzy/p3vgRBucAlDq5edBnBc+BxopOAhdWs/VlVzMEaKwXzmkVXCH3JMOTFD2CCn2hQ9Dgs5EFqsbH11Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K5TN6f04TuAtGRll6VMHDAboF2w23b0QKVz6vXm6mY=;
 b=QoIKopjUkmEBr/fog6e9+nNX2QaAmp0cAuFSn03ZANuB9BEjuN2/ZCFmjhqktk8NLrbg/9s+IA6/wRx9mricS4dmL4Cj1VW2m4i5jQCcLVfojLV/n4TsenfFG2CUCIkRF00Mu/0LRBWNCAkNsLiMMgwLVvbgruGV+mrXYgBVSCJcqGPRcrDExDORkmNsEWHO8hqR2Hxl1d0eR2gE4Ghq9OPYkbDwOMYH2yg6nRzsFxHfXZobZpc1M5wOe88VuvgTTs/hUwn1JDm3ub+WFE72Wk+ppLWEz9Og4kjCnDSFVEpT0J9q1TIdXYbMP7jvMwKon2+5xK5PW/ZylQvWP/GD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K5TN6f04TuAtGRll6VMHDAboF2w23b0QKVz6vXm6mY=;
 b=rHE5EARiXfonGtf/ytZF3N+lA7SxVbLnZZVzppCcuDqILwTT7GSFqh57aRah0P6sEAKu+a4L43KkFEbTmHZRkZMq8c6bmWBOCjIZgbtdgg1WK8a26cW8AA5FVpPZyo8q5V8+6M6VD7UC5yJUsh/YJHMk9CTYkV7t3S+pFJjiRRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 11 Feb
 2022 21:09:15 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%7]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 21:09:14 +0000
Message-ID: <d476d448-cd68-0c93-c98c-4f952d7caef6@amd.com>
Date:   Fri, 11 Feb 2022 15:09:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] x86: Use CPUID 0x8000001f to confirm SME availability
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org
References: <20220211053652.64655-1-mario.limonciello@amd.com>
 <568d9945-ed0c-90a7-d9cf-a5662f1dbce2@amd.com>
 <a52990c0-3e54-a5f2-22c2-3446e92f4294@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <a52990c0-3e54-a5f2-22c2-3446e92f4294@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0401CA0040.namprd04.prod.outlook.com
 (2603:10b6:803:2a::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b746da8-9315-4202-2376-08d9eda2c221
X-MS-TrafficTypeDiagnostic: DM6PR12MB2697:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26976E98B39A665E5ECE5C91EC309@DM6PR12MB2697.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLNQcUQRGyaN/EVFuayeKCwOM+vMD9RccDjEgQWAuuMmJts7YjDbyJbU8pzL2us+QFgjW6b2hNQwKqfMnKMX+xGghfEOfKBUkRQqApYmaWoqhtcHHENmmblCkGhd2Nb+mkgsLHow3BHZhgH9X5QigfXwV2oxXqGAOVbQcGoRBfe+rUNlv2TPum61KxXWU2knR/k4lt2qlIrRSKrSOze8xF7Ni0/Xzpl443SCVlww7iXpHjEFCz0OrgxvqxXLqLmRbVLS/EqLhyMJEnagFFfhQ5hjn1PYOnQ2mwNpH4aTawzOxwQU+3+1MMMYDm0m1QIgOG+P7GGRyoge3xXA0rEJvz6VeA7dd9k2suew4Zag6M571bLQmUUEugNS2wH2r1nzh1vWsTSAxMOt0zipfNfymW+FpJhZjL50skxzSuMXGf02tYqgOpEymAMq6IJaNvXzJAFAJX2fJgc8wkwMFKWrCh0XX0xkGlc87QeyCCkmtTch2Ibl2b6iVvFW+LlkmNxgqZ8fjmcREkzq3yl2LM+x5KM9pZeVnhiS2L42ka90qRnYJV5KHBOxNyGbrLHw1MK88baEh6GW14BiyIdgqevGnVxp6qydLgzGVYRVyTliWOuFwbFSe+38J8lfBYaVCxiuM7Y5UPQr3oC+RRBKm7v1B9ASRG3VZSansjNp+76BIfcahczx4UeqQ0gNqEx3J0jP5J5ylw7XptqmqLieOyhjeXAAAhwhVihpiUnWDtqw6H9BvNwqKfRQoAakogPLhaGr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(4326008)(4744005)(6506007)(53546011)(6512007)(2616005)(38100700002)(36756003)(26005)(66946007)(8936002)(54906003)(2906002)(5660300002)(8676002)(31696002)(31686004)(110136005)(508600001)(6486002)(86362001)(66556008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjRxWS9qa3FJZlV2ZllqekIxRnlIUDkrRDRzSXhjc2FRdm44WlhoTjd6d2lM?=
 =?utf-8?B?YmFFSGpYVUV5cG1QUGZuMDQvNXk5WnZnVkdmbzlJVnp6ZzVrZmhqKzdhcmJH?=
 =?utf-8?B?ZDNsNG54S3RiMTZoRkVUNXNvUW5IT0JacjZRKzFvSVVGTzExdkt4aG1BSWt0?=
 =?utf-8?B?bEdQdWNYRTlvWVZHOXZyNld5cGpSYzU0QXdCQTl6ekExbnA0QmVDdGNoSWZh?=
 =?utf-8?B?di9vQTM2UUh3bmVOKzRoUnhVUkF5OHV4L3FoUVlhaW16RnFySm0wcW9BRC9q?=
 =?utf-8?B?cmQ4RlhZbDlremtZQm9yOUR4Tk9lSVJWR3I5NWZNT09wa1lPODBmemJwd2lN?=
 =?utf-8?B?ZDNMSk1FM3V4dDN3N0JReVMvdThOcmFiV2ZHZUVqVjlPM05VSWM1VWdKbWI2?=
 =?utf-8?B?OEhKMkdBSlFSeFF2WjZ4cFA5Z2J1S0U5eThDK1piM2I3bjBoRjNHbW5PWlNF?=
 =?utf-8?B?eHExTTFxU0RWRnB6UmM5dVJNdzdwQTNJZFIvVkxRbHVPUlg5b3FzRU51ejlH?=
 =?utf-8?B?ajVjR0JKUlRCTXVLRGlSSkRDeUIvSFhMTFdQOTdxelBEZ1k2STBCc0o2RW41?=
 =?utf-8?B?VmROUHhZOFdLZ3JteUltbm5XK3d0WWcwVkVOY1ZQb24wNkh5MVM5WGZiVmE2?=
 =?utf-8?B?UnhuM3NJaGxxcGVYZlZOM3VEbXZnc202ekxBWUtiUHJuSzAvRmJQd0RJdnRT?=
 =?utf-8?B?V1Q5SHAzaUNycy8rZEdSWGUva0h2MFpjcXRaY2dIWnB3Vm5VeXdzMlByZmpL?=
 =?utf-8?B?VXZGd3NzcWtKWmRtQmJvNmw2eVk2SWNLUlowZFZKR1REUCtZVEdFQzkvRFFV?=
 =?utf-8?B?dUE3S09wRitBMjd6T1daY2xNRFNYakRlYzY1UUpWY1lraURYQzc3eHRCZW1n?=
 =?utf-8?B?Rnp2b1FDc2hHZUlWMzQxMjZXY1pzaWovV1FpSDVEbTExTWRzL3diRnU5TXE1?=
 =?utf-8?B?L2FYcnkwTkcvYk50VDdCemNmN0tIRUVtQ2NGTldGb1NWY292d0FicHJEalFw?=
 =?utf-8?B?M2lBZGFHRHFibkk1WGhXWWMyNldLZHlWelgvdnB6dElSMjlib292cmhXazlB?=
 =?utf-8?B?QVB3L3lzUmMvc3dXSjdmVDRKNy9JS2V4ajRKSXJZWkJFYVBzS1ZaazFocEF2?=
 =?utf-8?B?aFZ6YnJTRGp5eGV6UFBaTUQ0NnVaYmk2RFM0T2hNM1VlaEZEQzJINS9NK2dy?=
 =?utf-8?B?blB3YVcxZGhBZkJlRGNtU2FpSnA2VkkzMHliMXVYcUVmZWlKK1dDYVRSaUxw?=
 =?utf-8?B?L1E5RUxnV3lheUc3OTRyVFhUZmJvakZpWU1tTU5ka1VRVVFIbFNFL1l6Tmsx?=
 =?utf-8?B?a0Z3YWxKUVMvVXBOOGo4Y3Y3aHdNd3VId1FuNXJLU0FUZXhrL1JIVml4YW5U?=
 =?utf-8?B?ZCtHYTdtZW9GVE1wT2h4YStsWmsyeFZ5bVBUNlBseVBuL0VnMGtmRmhTQ1Vj?=
 =?utf-8?B?VkYvMVdDK2p1WjVrZ3dhRDFWWGEydFBJWlMwNHR5TlRFRFNoOExheDlUbnpG?=
 =?utf-8?B?R01ZVXlDYjhQZ1QxZDZJeDNtcm1JYmM4dll1NzBJY0lrOTNkWnB5QkVmdDhD?=
 =?utf-8?B?S3d0c0t1SWIwdW5ZckdVTEhXdmxZN3prUlhZSWQra0UycDF2UklvU2Y5Znl1?=
 =?utf-8?B?MHRkVWVrTm1BcTZwRFFUM0l1YjdCWHRWd1dFREZkUk5nbVBDTXhlNjQ3dDJi?=
 =?utf-8?B?Wm9ncnRXY0RXdDhPNHhBSzdSZ01OazhQaEhEOWZQUTRyak9pQjluTXdTMEpY?=
 =?utf-8?B?SUV2NmVhNm4rUm9QVENYZ2F5cEM5WStMejRKMVlIU0s2VWpEdk1oZ2kzQ1Rs?=
 =?utf-8?B?VHR4OG1jc2V5dm00elR4bkQweGhoWDhRWHMvUjdKUDEzazhQR3h1ckNnY3Zj?=
 =?utf-8?B?aXR0ejZIQ1ZIdTZHUW1rd2cwc1BPY2VTTUw4emQxMU5XbGQ0VlZPOXlUdlRC?=
 =?utf-8?B?U2xDWEZGWHRSenNiNG94OWNmYjJEekNYK3BZNlJUc1B0cGNIaC91NWIyakhX?=
 =?utf-8?B?MFU5bEtUSG9IbVc2QVJQdXdYcUp4WlRTVC93V0hNWHcySm0rVnFob3V4a29D?=
 =?utf-8?B?VVgxZ0Z5OHNVZ1JkYlFRL0Rwc1pGeTcybzVJeERFN01tbVozT0lRQUloVVdz?=
 =?utf-8?B?OG1CNHZwbGRrbWJROFpzWEVxWDFNaDMwS251YWVaWjVxNzRMR2dzTjVtWTNK?=
 =?utf-8?Q?yzt1PrScaW9OzJ57zYbjSQY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b746da8-9315-4202-2376-08d9eda2c221
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:09:14.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qeytg8k2Mr18p2CF/1RfNgb10lwk1LFlM8gfFN/dbT6udh8TNh8Mzn9zoKAPAQIwtLuBfyKKKHVUlUlEZsYYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2697
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 13:51, Limonciello, Mario wrote:
> On 2/11/2022 08:55, Tom Lendacky wrote:
>> On 2/10/22 23:36, Mario Limonciello wrote:

>      1254:       f6 45 d8 01             testb  $0x1,-0x28(%rbp)
>      1258:       74 02                   je     125c <stop_this_cpu+0x8c>
>      125a:       0f 09                   wbinvd
>      125c:       eb 07                   jmp    1265 <stop_this_cpu+0x95>
>      125e:       0f 00 2d 00 00 00 00    verw   0x0(%rip)        # 1265 
> <stop_this_cpu+0x95>
>      1265:       f4                      hlt
>      1266:       eb f4                   jmp    125c <stop_this_cpu+0x8c>

That appears to be the same as today after the WBINVD is issued, so should 
be good.

Thanks,
Tom

> 
