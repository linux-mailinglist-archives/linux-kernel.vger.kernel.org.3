Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DE74F8669
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346518AbiDGRpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346509AbiDGRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:44:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D427A22C1F0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsmEjzWmAXE6BE5Fj70KsZNaxZArdm9/ohMxo5L0TnXSJsLzmcRC1o5BQond2mNke1LFmOiaacXRgImJWvDpcS/KZGt8kV+9YKzBnKHhLN1xFydtTVfHiR5hwKDCOaE/5T+gUX0lBeZRSlek67iaDY3a0AbSDpRDgirQlNyxR1SSfzD7oDVyx9DQ1FbxBuWRFF03J4KktNMM8nxMSYVwD1WVK1C+EZ7AeMzFxPYqyNyoVfu1FqJXUiZT8dJY6668KPvBtYQPvvuDvtGB6DzZpUZrQ8st46uiGQSTLDGjisI9QyKxPYbYUEBK+dyZ6hCSdrIqFDbIojDDpq31NWqy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1HQu5tXLyNzG2fNFKfMgcJJpdUO1/tc+1V2wh6FpZQ=;
 b=DWkxZlkpzM09l0ZXimHcZCjwDBbIYCUuxcjDEMCqlPY08lFLHDdzmvqu0627JxyMuDqdeEcAgp7RbbtjRaEbbMhubHuGDLiQ1rEh8ADyBhIireDpDi19d8ZxMAHPVCg/XiLWzR/3GZ2v7U5q4pyruK5JLBUI/y9YgxBM20GbXT8h4duPZfqm+FS8Mn5eY4OzpBk8BfWbuoiKm/V4QlR7+Nim+0tSW3WCOLc1Uin3D6EQnbG6Qv5bXFS98oGVQ5y+ml11Lw9EMl4f9kg7ycVW4uCOflnqBE8iSmH/M0MlsOUQEgncYe5CVQkTo90OGzo+Lz6CJrr5iQdRWW7BB67Sww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1HQu5tXLyNzG2fNFKfMgcJJpdUO1/tc+1V2wh6FpZQ=;
 b=dMpY+GjURvQrG06oRIsOTHo2JKIe7c0igt6cJC/ATI++iM4acgrMp3AALMM5Uxv4+BmNPL/0Z92eWhZyMtOhXXX/QCgASg06EX8AcgQBeZmN+NX+fz6ZFrS0MHShrP4bcboLHrNLgz7SfjMchmBfMJlJQI+s6GBG1zMrEseQHjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN6PR12MB1299.namprd12.prod.outlook.com (2603:10b6:404:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 17:42:49 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e%8]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 17:42:49 +0000
Message-ID: <bafc1fed-fe42-08a3-6627-12ea946746c0@amd.com>
Date:   Thu, 7 Apr 2022 12:42:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv8 00/30] TDX Guest: TDX core support
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, brijesh.singh@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
 <b43720c6-0763-f4bb-64a0-7745c6ad920a@intel.com>
 <Yk8WZn+etpj/o0OM@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Yk8WZn+etpj/o0OM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:610:5a::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c844fb38-50ab-412c-e888-08da18be0897
X-MS-TrafficTypeDiagnostic: BN6PR12MB1299:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB12998F8842F08B909E643881ECE69@BN6PR12MB1299.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPywdbMXrTh1AObqgC2nRgk7Wn29rlTfi/YQWkWGd7HxbzM5i2Kw4nb+LIT8FBU6vtGN5c5kQ7GfHgoDWtorC8ORsyZc9BfVAZAUmRHfsSKV6Vy83hENNZtbMe7E+xuN9uEqpJeLF7sUzTpKh3Lys8+/X123qBipjc7c9BrGploDEwbI+OFJv7CbHnAqTpxEDkYAWtAkbh7QkgKDUB3eBkSty2ybueNI6qb++ZZItrVA5qk5JgZQb7p7WyuCEKTDklJflOaTYa71OvoqNp5Buagm92NpsRhmvHRZvMaAaYAckbcnkDrNI0I2Dx+5SVlSgLRRv5RxgQAo0PA/nhec95jOBCl+ey/wjiRyuCyqvIY+F7ZMVKqWcSZpnY1T7k6m1cEFMCK4y7iUeLczLbcz3MuHk49m6iBMFOxMTiZs26CEyfK3hWYZpER0c8H+HRctJO/SWqVu6AyHx+G7vJ8VBqXm2veXIP93I8/dK/65pZM6R1MYTvPvHgoFED3R89HEFnWqaZg/4NlqUVSc1f9HKzlnQ+RRYKUBZNtT9VmmnfcDNEE7SeRJ1NiynX6q9PVTieTRLDygpc7IYgFKku80E41E+5/Q9hKx85NbIUOkCGvPunQbVzFy4q4fhTcIi/LF4WK7jTpSWi1+7Ofl0d2loJLZZcupJ4QnG3lpz47kA+k0VuG4sQ9qv4pcDHDLKpa6FeHNxVTd5YQ/Wz6lmTwtSJCAIpHLHhHr+Hv0+IFhvpz1imAIgoJ3gbwPgmy2vSEe0PkWHbXhJyjH7YvEZUGcW3sAeBfG+Ne+RO+see1QTNiVSlUqUn6f0pRUCr0h0g3LAShfHa/mK+lflI7uykkYfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6486002)(6506007)(8936002)(53546011)(966005)(86362001)(508600001)(6512007)(4326008)(66556008)(8676002)(31696002)(66946007)(31686004)(2616005)(7416002)(26005)(186003)(316002)(110136005)(5660300002)(36756003)(2906002)(6666004)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2tPRjQyZVR0eUdSQzBySWVHYksxN1NwOGR0NTdFMVNzUzIrSXVBSTI5dDBs?=
 =?utf-8?B?U0lMdEV0RUpLMkJqVThWTjVwUmlrc0l0ais4R0Z5UTkwZVp2bjZabDlLL0tE?=
 =?utf-8?B?OWEzVm9kYXF3ZFB4RjJQTGNhVzFGQWZZZ1VyRElnUmwyZWZ0cmVDQTg2a3Z6?=
 =?utf-8?B?VjRoYmNScjY5enVPQW5hOTM3UVRHSVR4VTh3LzZaVWZvZFNXK21UaDVZY0Jq?=
 =?utf-8?B?TEY5WDlLWUVWemx3MHpuMUtOaUpLMnZ5aUtOcUlwOGlNMVAwS0lNVkdTbGdj?=
 =?utf-8?B?d3pGT0RYTXlJOEZia3M1MGRXY3A5ZDVLbExVMVBTa1FqeFYvU0dtWVkxYkFR?=
 =?utf-8?B?UTZ3TjFqRUFZMFlwZ2FNaFg1ckNFcTYvUkNUMUNDSHVzZzZMcVNRY2tFSk1E?=
 =?utf-8?B?YjY1V1BqR25EUmVFc2VseTVLSkw4UXNUMFZjejMvT1h2VXkrMUcyT3dyWStD?=
 =?utf-8?B?V0x6b0RJdFdwaE9NZG9vR3JickdqUS8vLytGWHM3a3hTM3lpZTdTMStUTjVy?=
 =?utf-8?B?NGhsSURrOXBUT3J1akY3NjFsZmswZEVhZ3dYbmVVaHdiaVp0RE1XVE43R3Jh?=
 =?utf-8?B?cFdVR1N3aEV2bkxiNFQ5dE1KSHlBbHVOMm1uMVhGbkxzU0V0OXd5cFhxaGV4?=
 =?utf-8?B?OFpZTWd3cWszVlFCN0NXWHBNRzEvZmkxNGFFeTUwRGtRaUhHS1J1a1V2NTBD?=
 =?utf-8?B?ZVErYTFJT093c2gzR2Y5YjRMT0x6RU1id1FTcjEzelNuV0xzeCtMQ0Fqeldn?=
 =?utf-8?B?RXE1aUt2U05pTmY0T3dvNHRKWXU3TW9vaTQ1c0U3WWx4RE9sZUQ1ZGRBellY?=
 =?utf-8?B?a2FORHA1dVdDb2EyN3Z2TndIQ2dpVlJTSHZUcFFULzlqaU1lTCtBN29oZDIy?=
 =?utf-8?B?K0NQOFFaSko2N3JiTkMvRWFVakkybXNBb2h1eUZlekJJWS9pRk9yK1VaSlBP?=
 =?utf-8?B?bEx4cVdiWTlBTmFUekdOeUIzRUd2bnZIMHV5WHIrM2ZCNkRPTlhwZ3hPTVd4?=
 =?utf-8?B?YVp3Z2R1TzlTa0I2Ulg4Q010ZXk5ZVhBendHK2NBMTdPbytwc3VqNTA0dzVD?=
 =?utf-8?B?cTA4Rkt5eDNiV3IvY3lpM1BTMW1GdUFtSThvNGlGQkloT0QrRnJSU3ViVVN6?=
 =?utf-8?B?M29nTUo0Z1hKTTNMSnZqNU1OTGI2cDUyc1NKZWd1YS9rTEVhcktBOS9xSlk0?=
 =?utf-8?B?akhBVUYyYlZyMjc2V1RuU2NPSXdVbEFnaDJ1VG5rL1pLYlAxa2cyemYxV3k1?=
 =?utf-8?B?M1NJc3BaSzI3STYxbml1bzhVbjFHellzbGM1YmVHTmdjZnluNUhsUEdrZTAv?=
 =?utf-8?B?d2Y2WWtVWUdTeVVuMjdNUlN1V2hlTTBXR0RkNmtwZXBOWFdZd2txeWxLWEpm?=
 =?utf-8?B?eDhDQS9RNVNPMWxHNFpZeUkvSFByVjZtOEtBZElydWRvdldPcUltT0g2aFJW?=
 =?utf-8?B?WW04K1M4VTRpOUVQUCtDdmVWM0wwSWVHWTZzcTlDYkN5eVpoN1kxK1pQSVE1?=
 =?utf-8?B?YWF2RVhDYzRqa25yMVFLc3FRRFZudXVjRE9YQTdKVkhwQ0UrMmFVaWt0ZjRC?=
 =?utf-8?B?aHVIZnVRcHpmTnRJVHdQKzd4VStyTEUyT29BczNudGQxT3lxaW5QbXE4M0pm?=
 =?utf-8?B?QUxSTm1OQVFvbkJBRXczV0dmTEVSdHdNU0l2Z3dLaTBOL2tTQWNXelBWYWFi?=
 =?utf-8?B?dmQrU3ltUE00dXd1dzMzdmdSdlg2cjlDQ3c2bmZJRTFENklHemkveHMwOVBE?=
 =?utf-8?B?T0F0WDVOdHpUUm5qWjhDWTRpUHF2SWlQMHZWaWVOdEovTXlKbVRmbm5PTGZq?=
 =?utf-8?B?VklYb3BrSXd1SG9ZYTAxOVc4WE1LT1NDSmNkV2V1WGdseXBqR2pxZEpRMnd3?=
 =?utf-8?B?ekduSVEwbU8vZWJVKzROd3JHbVNQVVZKK2JmV25JdVJVOGd1UmRwWlVMcmZ2?=
 =?utf-8?B?bGF0V1F4d0J3cE9YeHdncFZYSkNsLzhwTkpXY0l6WGJqalhBbXpYVGpoWG1D?=
 =?utf-8?B?V0lUUk1BVDZtSkFTOWR3T1NoYXJiRXIrWHplUWM3T3JaWkc2ZkRUcEJORHIy?=
 =?utf-8?B?TUI4UjByRnFuaEh4amk5YkVHaFVDMTJZbUs0c1RTUnFHVGtlM1FXcDJmL1k4?=
 =?utf-8?B?eGJaSW9iQ1RpbWNBWGZNV2ZBU1F1d1NTanhIMWVyQVBPK0c2SCtTbW5jSEJh?=
 =?utf-8?B?Rk1kUUxxQ1YrVGxoaW5ubmZlNVBYL01BNXJKOThoV3E0bndVL3ArK2hXMlZ4?=
 =?utf-8?B?V2d5RFRPWk4wdUx2S2J6bVhySkNaSkc4WWNoTXdrVlBLMWVYdXAwYk5SYjlX?=
 =?utf-8?B?SGxBTVNZK0x6bkFuS0Q4NGtmMVVPVEVUTmQxdlB1bU9yS3RKSUE3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c844fb38-50ab-412c-e888-08da18be0897
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 17:42:49.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hjE7IBZRNAw5C8EUncjZH0i8j3V3nXm6n1uhfaar3MEhLV8q6fduiCMFZ55SkeQk/YIgYlHwiWpp17eEtQ7pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1299
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 11:50, Sean Christopherson wrote:
> On Thu, Apr 07, 2022, Dave Hansen wrote:
>> On 4/5/22 16:29, Kirill A. Shutemov wrote:
>> ...
>>>   arch/x86/coco/Makefile                   |   2 +
>>>   arch/x86/coco/core.c                     |  22 +-
>>>   arch/x86/coco/tdx/Makefile               |   3 +
>>>   arch/x86/coco/tdx/tdcall.S               | 204 +++++++
>>>   arch/x86/coco/tdx/tdx.c                  | 692 +++++++++++++++++++++++
>>
>> This coco/ code currently doesn't have a specific MAINTAINERS entry.
>> That makes me a bit worried that folks like Kirill won't get cc'd on
>> patches.
>>
>> Should we just do a MAINTAINERS entry like this?  It would also be
>> really nice to get some SEV folks on the list as well.  I suspect the
>> coco/ directory will grow more common SEV/TDX code over time.
>>
>> X86 CONFIDENTIAL COMPUTING
>> M:      x86@kernel.org
>> R:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> ...
>> S:      Supported
>> F:      arch/x86/coco/
>> ...
> 
> And/or a dedicated vger list?

There is a linux-coco mailing list (linux-coco@lists.linux.dev):

https://subspace.kernel.org/lists.linux.dev.html

Thanks,
Tom
