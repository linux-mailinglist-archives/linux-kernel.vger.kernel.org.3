Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9243D485431
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiAEOQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:16:58 -0500
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:28992
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237028AbiAEOQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:16:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrp1MIzYWPBeCC8Of460HF8sMVO2lhlAysd6BAj1wbtc3Xzvl0wa+n/WAR485H3duvPk3FZwUgYJ+B225uKlS01ggbt1xk2Kj73sY/+51ZeeJcx5P1PooPD+kRUP4xFUgIAHstPKVX7OxocGiTv60kJCgpUzqQq2PPUXUpqMmLLCNX8JE3329qd27jIYfbBibBxpSMaVE4YZAHlslWk2TMMtyDRy4kTtrpTaT7SEwNQu63c4ug9IwclaP50numNwKb7stoCvOpwRUHYok/ZB4IQdHZfHF1bU7HjTel6KUAqhUCz/GTGzayoShjRoCcMMccxVc3okK9DV+RTInoSyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxb2Ta7YYyhAMX3R6Oug6gtoVQTEi/ogPz/4rWP9ec4=;
 b=ZapiwtKQrjsvacHs8seEtUf5IETtn/MBkXx02cAdLURwavSrqfqVHVNY7QRtx7nr3KEU5JgbrDOJ4ZqPK0HoWbX/5LSgFuShzyYNwUGIJJZFI8Yunf56fU9/eFgecHJlfe0f74aXG4SLq5KOKIXRZSHFd1qItJJr1Ijjp0hAwqSJQ3W/JhW+lApVfyZmEs4esXiltij8gmjPT5hSwQz0ScELDS+q68dbDfsMXJThuovbrb9OZ+3uotgNGj1wKPpye59CVLEeBNRp4Ojtvucx6a0YcXSqcE4nfSTaqJMPTnDJcc2paKbJO74HZdy3HMTlHD9p2FbglbHXegXElf8eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxb2Ta7YYyhAMX3R6Oug6gtoVQTEi/ogPz/4rWP9ec4=;
 b=elb3Y3nxPFNmyQcgg/dHLxtiHwG6WQZ62oKB4B0keeiUioHn584w2c2C4ZcrOL18Qf9vEQHIjXtib4UvfAPYl83efphzwgmw+o4II7Hf7AYuhVR+OioBkOry6olDdA/9FzwR1Dc6nDJlnaQoHCVHGLKxStf7kAcK/teDZOTMIiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5551.namprd12.prod.outlook.com (2603:10b6:5:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 14:16:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2429:24de:1fd2:12c5]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2429:24de:1fd2:12c5%7]) with mapi id 15.20.4823.023; Wed, 5 Jan 2022
 14:16:53 +0000
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
 <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
 <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
 <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <3fd5d9b4-87ac-4f3e-bb89-60813808389b@amd.com>
Date:   Wed, 5 Jan 2022 08:16:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:610:11a::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6429b3-a9e8-450f-d2c6-08d9d0560574
X-MS-TrafficTypeDiagnostic: DM6PR12MB5551:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB555170173459CEA4A132DB8EEC4B9@DM6PR12MB5551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lgJDP8nyB5QymPWRH/z5QD7CRNSxuvBb689e3xQPNgNREc2uIUbMFDMlT82OJjUkvsBjaEi9Ofh8JF3j63nu8iRN+kES/xzKbsmo1Qa2LHmOGRvwTtvOvTzHBnhvLu7JnZHQZuZflDzw8aUw1cjBy4+dCe1lpOlOPIPZN/aAWNlZ3YfMcQuKqI9rPtKxo2sbphFiHsnPknyjRLbbAmcwPB15bGBXpPC8LoovRedZXllYCEAHQBqVvxXTX/QTn/l9TIZOoToNUrYCGzGXUPDLO/E3mjI+GNRgZhreguWBMLuS3BqScvTNtmDkTF2oE9uRSCikcoSFz5KZmxIVQm9GVoTG/jiPKXTI7u/vrCJ7BXb8EKFmnCe+f7r5RsI2350cGn9rxgURaF7WDFrSJDXRmEl88YZVyu7hqAMDSbG7ay7tfhqWNz2VuQOzMJa7sGq1zcsvyWKpOBeRZHSapfLAvTAI8nxoEH/BFvHqdimaFToqSrZwKjgNpX5giIhB7C2NLY/QW4H5ApZBYqBu/qrEmi96myhgO2VtOiYxZBBYZeNM14Vb3H0FSRyU/VBg7jzZWNhSi0kLuelSzjbYbQy0ZrSkuK92SCSt8E+nCsSqA7F7GG3q61eJUR8EwpKYy9grdmxrJQWQqW0m3f+8H9XgiS743DYAj08UW75cJKyZaNxnxKhvsi1LCv7p1/82EoaE+pIlV+3p11lFKulvyaSpE+hJztkGGFAu91SSFWKIShU1941vrttTUhkPZA6+MwcU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(54906003)(316002)(6666004)(6506007)(53546011)(38100700002)(26005)(8676002)(6486002)(66946007)(6512007)(31696002)(2616005)(186003)(31686004)(8936002)(66556008)(66476007)(36756003)(508600001)(86362001)(2906002)(7416002)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDg1TUlNQzFKUFhKOGh0Tk4xQnY3KzM1TjdsZkdCUjJiMlAzNi9vQy9mUzhC?=
 =?utf-8?B?TGduOFJOWXEyeXROSlBmUGt0MHgxdU5CSEdMMEQrczNlcTZ1SFdBOHFwOVVC?=
 =?utf-8?B?cGZHSEhVZVdMdnU5L3FDMW5LeGwzRUV6bHpWclNUREt6Vy9MMDhjZVppL1Rp?=
 =?utf-8?B?bitDdXF1aS9NZ3NDcHhhWXhJMi9RTXNhczJtaTVsK0N2SlFDcXVIekMwZ0lI?=
 =?utf-8?B?cjVjRnFCUEhPbU1MbjNWSjVrajQyLzIxZk5kNm9hdy81Q0dlQjdYcFhlWHQw?=
 =?utf-8?B?RDdJdnM1Z2g2Z3hvb2VkRDFSa2x2cHozRVNwdnZ2OWs5WVBtWjVkOURRQ2l6?=
 =?utf-8?B?WjRxUiswQU1YUjZLTTdzVytZanpnNW5NT28yTHV1OVZmd3V3OFZIZ0FBVHph?=
 =?utf-8?B?Yys4MjRLeS93bjBJcXhpVlNiUi9jL1N6L0lPQTNOcDhFVzdrb042aFVxZG1N?=
 =?utf-8?B?R3hTWnBDTkd6dkQrSjlHcWVnMVY2RmFqRllKcGVCRDF6b2JFOFdJclBaOUlQ?=
 =?utf-8?B?eHVHK2QyUkVHL2o0YSsvNVZ1cU5iZWpYcWFLRnpQSm00cDFpQ3JPa0JKYis0?=
 =?utf-8?B?dmZhSWgzZENON0lPYlowYmxybVZNQTIyakZiWVZEdlFwdVMzR00yVlA1RkY5?=
 =?utf-8?B?WXlQYTFHN1hxOUw5WmhXUFU3c1V2c0QrVVpDSnI1cFd2cjNKa1FVMDN1TDNi?=
 =?utf-8?B?S0p5Uktuc2ZpZkR0TndSYzdzTHJxTDM2dmJjMWFBSzdmUVNmVW5JZHRjRnox?=
 =?utf-8?B?MUFGdUxKVWcvU3NGMXZwQWJtZmFZMHJuWmZuelpqUGdVZEptZWRrbTVYSXU1?=
 =?utf-8?B?YldKckF2akpycXpiektyczVTREszWE1KRW1wZldXbWozM0NsV0FnTjlCVDFa?=
 =?utf-8?B?aTBqTW5Ca1VpSVpzU1l2MWYzQnFsekMzQ3RNTldYbk9mcjdaMHFja0wzaWVO?=
 =?utf-8?B?QzlXV2tBQkJDUngxUXE3N3o4S3IwKzZsblFlNTdXd0J4VXo0dkdldytLaTRZ?=
 =?utf-8?B?dEM2SUdxUU04OGtuK1VaeWdCVGhnQTZQZDFTNTRIYWdKVXlNRmRoSzQ3WGpt?=
 =?utf-8?B?ZEduWUlCTTIrTGVXTkhLc3V1c3A3UUlUcmJoQmZ0eHVEWmgxallHKzVQaVNH?=
 =?utf-8?B?QVpTT2xIbHArTmJQbDJoSnFqajhjb3E0MkFRZzhUbWZnNUEzdVVWWnQxZXIr?=
 =?utf-8?B?eW1LN25UaStBd3VGLzZBb21qeHNIditDMEJscFB3TDZXSzI0SW1URHdBeUJR?=
 =?utf-8?B?UFJkZnAyVDRSM252YjYrWWc4b3JJNTlkaW1BcE1jb0dab1Z6NEF2QXRtL1pD?=
 =?utf-8?B?RnprQXlOaitEcFRzNGJEaC90Y1p6YVNQQ1E0VjU4NCtrbnh1dXoxTU9VRTZ0?=
 =?utf-8?B?ZmxRS1h4ZFFsQUJieUJIZDRIa3B1bUhSUmZ5c3EyWmZrd0FSZ2gzUkh0bE45?=
 =?utf-8?B?MEJWNG83VE5LU05qb0c0Nmw3VnFxcW1Pd1V0ZXB6alFocHNPczRUK3lvTW1Z?=
 =?utf-8?B?a3ZkQytXcGRzY2Myb1ZDcDdoNUlPY09uc3BCNkYzaW5rZFlWSW02Wit6ZjM2?=
 =?utf-8?B?K2RMOUU0dUthYzBqejFjaVFPYXhpaUdXUmY1QmM0Nm1HV1dCcHFlVzBFKzBC?=
 =?utf-8?B?SmRnbXlEY1NadkVpdjNuTjlWVEh4c3ZyZlEvRGhpSEpGbjlOVm11OGhVS2ZV?=
 =?utf-8?B?ZkIwbm9Yd3NUZVBUZExFZEtUZFQzcnlxTmRNSWdXd2lpUFB2Y1lScStmZTlq?=
 =?utf-8?B?WUlaNlhIZm9LU3RwLzJ1VWcvVEVLQjNvL1Y0UzlOWXhrK1Q0QnY5bCsxeE1j?=
 =?utf-8?B?SGRQWElkN1dKUjlxYjN5UHRiV3VvZ0R1RDRlT1NuZk9aenlRenBRMkk3UEVs?=
 =?utf-8?B?NFhja25RTkl2c0I5akcyTWNDaW9ZbDB1a1p4aUZJbG11RTFmQXVmeUdZSHlL?=
 =?utf-8?B?WndqS25qZDcrWVBnQnN0NG9JNk5YTjErZTN0TDF4OWJCTDc4V0NOTElqLy9u?=
 =?utf-8?B?dmNmb3VDVXMrOVhUTXlKaGpNK1loazNQTHovRGsrdGQ0OWN5Z1F4a25hRUJY?=
 =?utf-8?B?NGZCL2hFL2JhZnl5aVJnTHlLcC9KdmQyNTlZS2lWN29yLzh6Q0xyalpraDk5?=
 =?utf-8?B?NlZCR1dNUyszNURjTlVzclJSOHFsY3NvY0pXZk1PZVI4R0x0Tk5MK3ExeTJK?=
 =?utf-8?Q?s5zTAKiJr0W9aCcDF3Oui20=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6429b3-a9e8-450f-d2c6-08d9d0560574
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 14:16:52.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eRMZV3nvvjLRY1Ef/qE8Ujg58ODLVPxjdM+iXiKPcYU1N1bqdSSW8d1g4t8YnIADGSMP7EVUZKMRQYbLccVjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 6:43 PM, Dave Hansen wrote:
> On 1/4/22 4:31 PM, Kirill A. Shutemov wrote:
>> On Tue, Jan 04, 2022 at 12:36:06PM -0800, Dave Hansen wrote:
>>> @@ -57,7 +58,6 @@ typedef struct { unsigned long iopte; }
>>>   typedef struct { unsigned long pmd; } pmd_t;
>>>   typedef struct { unsigned long pgd; } pgd_t;
>>>   typedef struct { unsigned long ctxd; } ctxd_t;
>>> -typedef struct { unsigned long pgprot; } pgprot_t;
>>>   typedef struct { unsigned long iopgprot; } iopgprot_t;
>>>   
>>>   #define pte_val(x)	((x).pte)
>>> @@ -85,7 +85,6 @@ typedef unsigned long iopte_t;
>>>   typedef unsigned long pmd_t;
>>>   typedef unsigned long pgd_t;
>>>   typedef unsigned long ctxd_t;
>>> -typedef unsigned long pgprot_t;
>>>   typedef unsigned long iopgprot_t;
>>>   
>>>   #define pte_val(x)	(x)
>>
>> Any arch that use STRICT_MM_TYPECHECKS hacks will get broken if compiled
>> without the define (as sparc by default).
> 
> My read of STRICT_MM_TYPECHECKS was that "typedef unsigned long
> pgprot_t" produces better code, but "typedef struct { unsigned long
> pgprot; } pgprot_t;" produces better type checking.
> 
> I just compiled these patches on sparc with no issues.
> 
> ...
>> Is it the way to go we want?
> 
> I _think_ this was all a result of some review feedback from Tom
> Lendacky about where the encryption-modifying pgprot helpers got placed
> in the code.  I don't feel strongly about it, but I'm not quite sure
> that this is worth the trouble.
> 
> I'd be curious what Tom thinks now that he's gotten a peek at what it's
> going to take to address his concerns.

I have vague memories of pgprot_t and what a pain it could be, which is 
why my feedback suggested putting it in cc_platform.c, but said there 
might be issues :)

I'm fine with it living somewhere else, just thought it would be nice to 
have everything consolidated, if possible.

Thanks,
Tom


> 
