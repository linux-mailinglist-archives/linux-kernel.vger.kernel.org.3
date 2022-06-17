Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFD54FABF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382909AbiFQQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFQQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:06:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C25186C3;
        Fri, 17 Jun 2022 09:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO81evJgtb/iN1KYG66Nc3HL8SEQ0pbv/m1ic5gUNf63ueZfg8WkGg5PYci3ThJnPYW3+LNW2LcZF2/Q61qfb/RUG7FMC4nA0bccGYLoXHIrKRum6cSgAhxuyF8msHUqg8GpO6XVUpPEudKqhSEOqU/OAV+Hh/ertKGVSOkDE+3Xs1iR7KSK90Ojt3Xnk1Ig+cEIxA5X+ebTZqoL6MKrhfu4RaOasYRzsGB8NdimXf00aY80363YhpIKe3Gxx2PQeLPmB/sW8uIL9GXIuF4fbe1T1ZPEnE4r9MMpsU9d6bJcADmZ/DhWmVdswCeKCbWaofOhDIabDe8pWLEcH6bYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3MOKFIy1w6mmurHTvCTlbugEu474hOylf+CubX9f6g=;
 b=BqQnb2N5Mw+3UE8T9Gf/afAu7i10XGrpiHp2zmnfbSQpG/jcIohYAdU6lVm/o6BgSJ6FA+chAS/mF2I11qVks/hX+9tYBIC7LEeT0KmtId6yftMmw+8EBYeVao+/InByjlvNigZ2nR789AWDvpXEnPYkgmP9Cp3a/fhp34+WWb/eZTaohAPy1eQCvrFpevCmJlTUL7pjP5ryhB8GrlhyKVqYeLgfKhq51pP+oEJnlTFRsUoFuATtWBCxHBZKIHP/GQWwXmyd2BKZEfhpmD/ypVZYqsZd9HcqXnvfJHoGDu1TEJvGn/bWFtWiPgPJKQbrBLhHmTBi6Vr/Ci7gz3ge2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3MOKFIy1w6mmurHTvCTlbugEu474hOylf+CubX9f6g=;
 b=aPyF1CWE+Bk2nPRli3XU5R8rJ0cufIrlIeIEy8a0gF2xcQW6zBHHAW/f08+kizFwQ5+qK5UhB5DInp8KDw7RwsBA7dul95DWx30F93soZYJfx01xVXrwU45oRyXNENJhO0fffZlhqR9v7FKmBOcvOYeLH2gYl/IAnis/PIlLwpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN8PR12MB3396.namprd12.prod.outlook.com (2603:10b6:408:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 16:06:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 16:06:08 +0000
Message-ID: <ed0379a0-1360-4271-16bd-cde2e4b3372b@amd.com>
Date:   Fri, 17 Jun 2022 11:06:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Alan Stern' <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:USB HID/HIDBP DRIVERS [USB KEYBOARDS, MICE, REM..." 
        <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@amd.com>
References: <20220616183142.14472-1-mario.limonciello@amd.com>
 <YqugZQiDu35Y8lTu@kroah.com> <YqyYIt2MLmoCRSA9@rowland.harvard.edu>
 <419f8edc2a7744ecbfaa0728227db180@AcuMS.aculab.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <419f8edc2a7744ecbfaa0728227db180@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0260.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b88424d-0d2e-46ec-9411-08da507b4a05
X-MS-TrafficTypeDiagnostic: BN8PR12MB3396:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3396E0EB0F4726D56C13A2FAE2AF9@BN8PR12MB3396.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQ+1I54X+sEt/t9qe/BwJdvuC3QwDh0rtiUjUplBIlJfnaDe9LU/jmnTz7CPfCuPjWzogLvovbrx0DJMuLMgC9/ltx++dLhPluvtwt1pEqmLfNY5iuqTVWvcIQDlnr4jY/dcflLWaVn6Px1vlomRdNULF0iCAcwlY3CcXBbpBB4lIXvCj8S7cp72UM0BfbMxC76c2r0OFWCoLnpNXf0Ym/rirCfl3ylHTHycZM+BFIv+6pc7uMrhC3bhxXNbw1OFwaJr6AE54zvzo7eNJcDLm/5BDgn5sVDJDwfos988t9W813hgk5WWS0b/85/FPk9wb5w//S6MyULARvJkpI4/mt0UvQ2nQu8zm5OtEfdRrl6jl85TBSkyRi9Kk41crATO7AUi1e4WDWVyeFLc8Epo5Aq9r+xUunxkBrT+7DQCuM8vURjVB+qstv28q0fPllUF++83+o5hCGl80KzZbaE9T046OdTO/MRKxLNrj6fiepwbBrJt0Oxsa+nyUKBq2SgGFUAtZgcjEqQ0sTmwue3K4qdqUpHicLTwABOCqYa081m7YTsQUT8FzAF2xkLe3gkRdlMV5YH4vKyGbH9/m18hIAZOk1cWMPhHjKhVsSy0+WbFgfQFj93InWQ6C1g2Nr/FubA3qPe5f9Tm2x5GtYaOsYGIHpJIj3k1QSaoLmkTahcR082fhqQumVVvTwRLIO5PQv+3C7nuJnqildLG7o6bM0SDlqkWwhHPzGDQYmsdz7bBW9lktfoos2Gc89WwQnOR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(66476007)(498600001)(66946007)(8676002)(4326008)(66556008)(6666004)(2616005)(6486002)(38100700002)(54906003)(316002)(36756003)(31686004)(8936002)(83380400001)(6512007)(26005)(2906002)(5660300002)(6506007)(53546011)(110136005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZyszYUJiaGpBVTVNVjVDNUczUlhCNmhxWWxOVmJ4YnJBWkRUVDh3bjFTczhp?=
 =?utf-8?B?REl6TlFjNzB0VVpWSXEvNC9uQVNiakFrY2VDNEdjYjhvdStCL2dPMFFBUjJU?=
 =?utf-8?B?MFhUMTB4T0FRY2pKOWZ2NEJKNkF5YnFFSW0yYjhoZnZhcWlUa2g2ZWt6UEth?=
 =?utf-8?B?aXVaR3BkazFGdFpNM25NZkI4eFBPMVMzdktUUlIrTFZvbTdVSjZlYVpjbkdm?=
 =?utf-8?B?ZFd2elY5NDNGbWZHUUk2bktjNEw2L3FyTmY2bU5ZaHpMOSsrSUJWcnhiR2dK?=
 =?utf-8?B?NTNOVmVGdk1JQ1lZUXBvTGVKOXp2NXl0RmxsWmpLVFJrZWR3SGE5Mk9kY1A4?=
 =?utf-8?B?NlNKY054MnNBbzlpVjNyT3l6N0RxbTdaby96OWVxVS9GSk5TMjdMT3MxbllW?=
 =?utf-8?B?QTdxa3FGQ3ZudW5hbHdzb2NyT3AzbXZnRXVtVnVxSkVmTWZUOVdtWDkveCtL?=
 =?utf-8?B?bzFtd2ZyRmVWS0R0WEJsSmRjSkRJZWV0QkNCd0pZME5kWisyWTBka3oxRTA5?=
 =?utf-8?B?Yld1My9QdEhSSldzb3BBWEV5L2lZVnR6Uk4ySzdSNysrMHRLNW90UVc1SUN1?=
 =?utf-8?B?TWdjTlRIYkVwWThzdTRlSXlpbUhnMmMvaC9mbHp2elBKOGRGdWV4VjFQMFNu?=
 =?utf-8?B?eDJqayticFFsV0pSMEIxNHAwR3lNZVlYa0ljRURyMlZkc3BOTEY5Zm5pSHhN?=
 =?utf-8?B?OFRFZWpJbEdDeGx3R3RWb0g4L0YrbFdPUzNwK0lORVg4TTBFZG9uK3huRVVx?=
 =?utf-8?B?ZSt3OHdxSCsxc0VhZW0zSlhPdnVHL0lMTXlEUkYrM2hHZ2RwYmlOd0tGckNu?=
 =?utf-8?B?V1Y5NGZtTjY3RnExcmw4MU9STVJxRXR2Q1cyMVFKMmJjMUp5ZHBwMnRWUTFu?=
 =?utf-8?B?LzkvcEVrVUF4aDNGRE9KanpWUXg3YS9ZV3dzRncxSndTdU16UjdJWk5SOWJz?=
 =?utf-8?B?SmlEcG1EeFBkendqbTY2SnhBcUw0QVlMSGpCU0dMUVVVK1p3Y3hWT1VGRlZP?=
 =?utf-8?B?OUdrTzRhWFdaanFNTy9FbkFGZkxvZGN4amMwM2M0SFpyekxaY0g5akYrSTc1?=
 =?utf-8?B?NTFBSWxSZk1sWkdCbzJLd0JEWkVpQ25CN1p6SmcvU1JlNjdTWUJPaTNTait3?=
 =?utf-8?B?NGY0L0tEWk1VTjQ1KzdNQkZwYzlpODJFcStFNVc1QlRnTVJnWGhEbTdidWxl?=
 =?utf-8?B?b21qN3VoQng4ZGJoTmp4UytmNWFYMDNDRUFISjhnYWVTUzZhN3Y0SGxmckM5?=
 =?utf-8?B?Znp6QVFSZlBjWWxDYjg3NmVlMjZwQURPVFhzbWh1dnlXYjJRc0ZtR3pUVUg1?=
 =?utf-8?B?N3B3RWpKRk1YSDBBZUNuV08xV2lscFovdHF6YmhORTJSQ0ZLZFRjNFJMVk90?=
 =?utf-8?B?eUo2RUZIQW8rS2lHYjRvZC95SHBZblAvcGd2ZVdOK3pkRkRDT0RzaU41NkYv?=
 =?utf-8?B?QXd4YnE2VXVQWnNoeUo2QnI3RVFDRGZZUWN2NVltNzlQN2xzb09EU0l4ek1P?=
 =?utf-8?B?VUNPZTZFTUo3WSs3czQyeXVvV3JGczNSamVaSHhYckdGZVFZTkZibGJJVUlj?=
 =?utf-8?B?dUVWR2M1NEZ5cTQ4WFYra0JSQ1J5eXVxWGIwOHhCUTZSQlZUNy90VVA5NmR6?=
 =?utf-8?B?c3pKbGpVZm1NMC9hbjZsUUlmaWYvamR2OHhhYTRYZlFITzAvTHFLL3BPWlNv?=
 =?utf-8?B?cEV0SFk0K2FINWZEN0RHeWRVQWRtWE4wcjBlUzY1T0krdHYwSGVvRnRiSHRF?=
 =?utf-8?B?QnZyOFh3V1l2bVlDT2RrSWNoUHNrczVlQlhlSGRmeE1DMXFmemVwUHlpL0dW?=
 =?utf-8?B?SFJOaGFXWkpOTHdlekxKcUVQU1p5SVVzUjNrMmY0c1ZMMFk1M1YvQ2tvSXdO?=
 =?utf-8?B?eDMxVEVUVWJnR0tIZnF2S1RLcG0zeEJsMXNYSks5eTRHNGlMK3lMN0ZNSWFJ?=
 =?utf-8?B?YjVZOVNHamcwSXhaN3dJZmpzU3pBejBkK3B6eWlsbElVOE1UVVZnUG9zdFI2?=
 =?utf-8?B?cWhkdkJGc3V1a2lHQTF6bTF5NzR0Q2dyZVI5eUJvUjNDc2txUVlkRDNZeTBo?=
 =?utf-8?B?VkhLbHdSWnVEbU03Q0V2aWtEU250R092VGowRmhUc0ZwU1JQS3Z1eTVLVHUz?=
 =?utf-8?B?UjVQWWRITVFXQVFKRDI5bThjczV1TU9OeVNtSmhNMDhPSUlmUXNWN0JibXZi?=
 =?utf-8?B?VHZsZzJiSGhGSURYQlJncFFMbGdZdjhTMUprbVZscVVreEEvamxud0tzQjRK?=
 =?utf-8?B?VDhCK3UxUzhXQ0hwUjV2eElGdG9yZys0MEREYXZaVGZHTEhNM1YrcllWaEpw?=
 =?utf-8?B?MlFBUUZmdjJPa0pKWnhOSVZQaS80Q3Rnc0tDNDd4Y2NpaVNHZERDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b88424d-0d2e-46ec-9411-08da507b4a05
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 16:06:08.0206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+hxSJR0bNiGGU/N6sw4JOO8aQ1bN5UHm2aZYVZl9tRoPL7iyywtnTsOm6mnkVQZh3wG/kyIni++1OEWTIOcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3396
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/2022 10:39, David Laight wrote:
> From: Alan Stern
>> Sent: 17 June 2022 16:05
> ...
>> Another issue is whether wakeup for a mouse means pressing a button or
>> just moving the mouse.  For a mouse that uses LEDs to sense motion,
>> moving it won't generate a wakeup request -- USB suspend does not allow
>> the mouse to use enough current to keep the LEDs illuminated.  On the
>> other hand, there's no reason why wakeup by pressing a button shouldn't
>> always work.
> 

At least one of the Logitech wireless mice I have here works to wake 
either by clicking the buttons or moving the mouse, presumably because 
the mouse is battery powered.  One of my wired ones works only by 
clicking (which is as you describe).

I don't believe there is going to be a way to have granularity of which 
type of event will wake the system; it will be hardware dependent.

> I'm not even sure I want a system to wake up because it's mouse
> gets knocked.
> I guess a mouse could include accelerometers so that you can shake it!
> 

I'm completely opposite.  As soon as I sit down at my desk which has a a 
closed docked laptop, the first thing I do is use the mouse which will 
wake the system.

And if you take a step further and consider desktops if you *don't* do 
this you'll have to find your power button or use the keyboard.

> I've an idea that one of my systems manages to boot if the mouse
> is knocked (and it was last shutdown from windows).
> At least, that it why I think it is sometimes booting up.
> 

It was probably hibernated from Windows rather than shutdown.  Windows 
tends to make this "invisible" to the user.  Some systems can wake from 
S4 on certain devices, and I would expect some registers on your system 
have been programmed to work that way.
