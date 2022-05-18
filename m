Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7591D52B355
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiERHM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiERHMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:12:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E282873A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOahddyKa7IWXMv/ZQ+JZK936s8XGnBwDpi2+ZUw2swWUB/buxSh+SAoOpMlD+4mhZH+YxIKW5wJF79unESq3TmX+zVHGkLb9u6Gfkpyz246vOTbz7spxkW3La5zbjgFFYOQ/LnFAekJFmJBIOEBHI06BpFaU+Fz2WGEBjKJJ4icBmFUM6pxEHJ0v807F9JIq1qO4wBmBnkhyTmfnDH80p6uQGELNnB1MpwT+hrekKgjmCQwCqhvx9gG5BwtDBEjGpLigYvlkFbNSAliHZK0QHSVNbwQPvxwfk4DKZEdo8D3YxOcI0CTqvqhVutC3w8LUb6q2ppPWJ3m24AJJKF6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH2NUAVPfYlVMtjZc9geO7akhy0eK6oKZFDW6Jh/cpc=;
 b=mnLBExiTPSXrSJwhrpmdZ3NhrHfUIN0fDTbGmyMRrqjP9M3g1Kc2wmtXaB1FtvpW31Zvt6ec2HnLDx57rFpn/hwZ9Kt8JxOhLq/IHUkuevGtMxpH1/X9Eb8bveILhtQK+L8k9mGwHGv+3ylW1jR22IRk7DaCc/87jHoXr0PpsmQLb8lXxzUnrP9Xm/xYvFD00AToBMxevfsEynrBi+br7OfmLeqA16CNnixCTtKzV0fJ4aAFKsozKnisiZLAX7AybicA/0MWl33Xr6aKeHuFv18Z3MEPOF0DV55rLoz+J1zV0L6zygoLFUXDShsK8kYicEpwMGsfz/CFFR3tG7VC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH2NUAVPfYlVMtjZc9geO7akhy0eK6oKZFDW6Jh/cpc=;
 b=rsZ2ZKmkWX43saBe/pVLXgD7VqeUC8c7MW7/lSOqr77xISxRbt2/o2vUha7bj0KqBdHUWs5oUafQCPbT/vOg8YrPoinSOPB6L4w49Q8dxLGczHDQSc5zWeATCySGwviyk+V5Qqh7Nm1Vv0h3m9hMB189b1LNrDdvBxBT4G2GJ/S9gGJq3Anjtf/4SqOj06M0dkThEMWE44LcdOY/Sm1JtqiIGAoVbidE3tYH6LSOtprPVPeuAbflWUWOwHS//4rX7ewjzlB4RNEqwpmQduBW93p817CqCs6A0+/snl5QFPc5Sn2E/dExbi8uhJkLeHQrT+lECEzobvTfV2wyYfcB6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN6PR12MB1908.namprd12.prod.outlook.com (2603:10b6:404:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Wed, 18 May
 2022 07:12:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 07:12:20 +0000
Message-ID: <d0abf3db-0726-81b9-5a44-36cb1736a155@nvidia.com>
Date:   Wed, 18 May 2022 00:12:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>
References: <000000000000ef451a05dee0f2b1@google.com>
 <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14277034-419c-4f0c-18fe-08da389dbfc4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1908:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB190869CA7A354D961E0E16CDA8D19@BN6PR12MB1908.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/wnYI9/AaC6i3yC56UncABb4CZanarBCYD8BklGPZFACDokju5Y2LpDisMipSxONPIVOvpMB1FYF8agDwMuXUsmBWMbrYYyWfIFdOkhdxZBRhuYjsX5hp2GjF0gnCD+xFeJ0IZbxYwfwpQBAixOfXDy0EZ6buMjz46aSaH+bpDXH4OeU4tuyAYygrEnCcRkwoAm5r1/jI/WxhrbSRS6bCJ3TaJuzQGXXHdLp/onuoQQJdBb0rEQqbPclrRNsQLAWOOUM1vz/vtEtyTe+50Er1wdg7qIILajmpp+hlniU7DzK2+vycCQDxI0/6pjXY2w/jeRbc3qfJ2hsx5FcBxF8Iu1LgmMA1og3Ab8hoseHq/hXN4aDxSZW1f6NeYBHnBp+oetuKxmBvHtPuaDUTacnTCWnKieHogvaApk2fg242EW4FPlYeIWomKZtm71x7zFJ9D3t4XWU4M7eKyNj9ckWHzZ8r5PFbO35ZvhGKQtgupw0hzVJ/Dso6NgQLXxQTmtYFsRnHlq/IV+D3RRqMFBPgYCGVh7UdWERMPzA2zQPvGvBByKFsm8dRiOs0lpaCwKHslwNFiMNQ/JqNSMMEooH3yEOhWNt22Bdv5mh5bzB9yc21jdVEp7fRwqUchkn0UxQf1XNWrf1fP1YsVkzlpbjsIkTREIEQYH99HpFsAtzF+J3zTsS903K0vlIE8iDKUMUZxFJkgOeHAlrhIAr48AijqIwJxV1vB+JuNJ07JrDERwItxzRRwyDY+MHtNYfOjKRqMKmuzTpLAdEUkRYXVwI24Q707Up2o2iZxKRESIzig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(110136005)(508600001)(36756003)(53546011)(8936002)(38100700002)(2906002)(66476007)(31696002)(5660300002)(6512007)(7416002)(83380400001)(54906003)(86362001)(26005)(66556008)(316002)(2616005)(4326008)(8676002)(31686004)(6506007)(66946007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2dTWmttaE9jN1pXMXFRb1gyVkFpcHRjQTcwR05rb25SWWJvSE1vazhKeVpG?=
 =?utf-8?B?KzlNRmJkdXNyUDRoU0daQ2hOa2JSMEt2YitWMkNSSWg0Nk8xaktFb3o5OGcz?=
 =?utf-8?B?YjlCMkxBUnNuRHllaC9BY1BXSG1GMUtKanhxKzRvTjZSUmlra3R0eVhoRTl1?=
 =?utf-8?B?Y0txa280aHoyZkRpNzI5bkdEcDg1THNDSDdMM3U0b1pXWFF3U016a1lLSXJs?=
 =?utf-8?B?TWszaXRxTHpnRzgzbWVCdDl3cWE4NFhWR3lmQVV3YXgvdWxSNWNzS2dKQkJQ?=
 =?utf-8?B?OUEyYWo1WnJ5dGFERXNSUVl1RzNueEVML3FQTWlqNmluM0t0dVNwY0dtWUxl?=
 =?utf-8?B?c0h5RGdTUnVvdCt0QmlEVlBRQS9PN2I0QittU1Rkb212Y24rWmNHNEZ6bUZq?=
 =?utf-8?B?TENKeDBVNDZkRThKWXR6ekdtK2NHWHhSaS8wbkF4a0JkTDRMNnVnQjF3RmhJ?=
 =?utf-8?B?S1BHc1BQK1ZyKytCR01tM1ZmeVdVekJmcnFDT3Z4VVR5NmV4M2VIcjJGZkhs?=
 =?utf-8?B?Q2dyNitvdVhDS3VyM1d3cGNZVVQxM2VIbVVJRGwyYUUxWHlpS2k3eGIvdG96?=
 =?utf-8?B?TFlMWWVlRzRYbWJDT0MyQStQM296RkpsQ2UydFFFTktOL3Y2dVZxL2ZZc1dH?=
 =?utf-8?B?TWdWdlhsa3ZxODU3cW1DSVRwUzhjOWhlS2NhWVlqRGZHTGhZYWtKVUFmWVJz?=
 =?utf-8?B?Z1FRM05ES290bkJ2TmcwTlZ1Yk9ZRWNaUXpvclpmYjR4WXJua2FFM0gxcEVm?=
 =?utf-8?B?OEt3MUg2NjE3cU96UHExMnFEZHN3ZlhiS3h3NW13VStVRUNnc0lZYWdRODhx?=
 =?utf-8?B?S2gvWGQwZCs0anh4YkpWY3djR3R5Sk44dHRBcDQvRUg0YUJsWTlJRXFIaDRO?=
 =?utf-8?B?bTFrWGFIeVFJUWZQSEZ3TlRKdFlqNm1tVkJuSW5KLzQzY0Q3M2tNcFdSZTNk?=
 =?utf-8?B?Vm9tWWxzYnlKekYvdGUrVXM3L21qMVRuSjEvREFJN21aTjJVNU5tV3MvMTFO?=
 =?utf-8?B?Z1V5UkRndWszdEkwQmliVXhXU2NjMGxmdU9FZ2RJQTN3QURhUkFaeGFTWFRW?=
 =?utf-8?B?bmd2YWoyQitMeTBDMkpzdzV1M28zQzlwWGVtc3AyaWF0NHBuU2JnMmpqM0Nx?=
 =?utf-8?B?MEtkUzBpRG5JQmVpWFBiSzBpNXNRTXlJQVlOVDNmckNuWWwvMzZIc2Eyem05?=
 =?utf-8?B?NEpxSTZ2clVPMHFUcENVZmRCdWtFOC9TK1JyUzVSRkpWZjBGRHpJQVZ0NjZl?=
 =?utf-8?B?aGt4ckJUS2IzV3p3T0xwWWtKbXdpYTdaOVNmcSs3dkNwM2hpQlpMRFBhelV2?=
 =?utf-8?B?d1RXZ0ZMb3BhS3l6YTgzSCtQVmlpVE5CYTY4ZTV5QmJiQitjc25NNHhNeE85?=
 =?utf-8?B?cyt2L29jQjl6MEh6enE3MUJHbmZmTXRETHNOR3VBVDdFM0ZEOGRQeXhYSXBp?=
 =?utf-8?B?QTlUcjh1VFBIaXJOQkxqVm9xSDFUTDIrR0FOWWVReVIrTnZwU0hSMEgzVWRN?=
 =?utf-8?B?TTJUWi9GRDVnVHJGdmtuYUhOeVVFZ09tWlN6QkJoODZsaTV1OEFWTFc0S2VW?=
 =?utf-8?B?SnJuNmpQVGJYSitBYTlzUXBENnVnaFgwV0k0N2VnWmh3NGpMOEZjcFZua2Vw?=
 =?utf-8?B?MVVybGpRM1Z0K0NaK01ic2NiZDdhZHN5Q3E2anlUelVhcE5PMEM1emI0SGkw?=
 =?utf-8?B?RHZjbncrdUQva3RpQlc3bHFoYUpReUp0NGlnUTBYTEtQK2kwbjEvWnlVWU45?=
 =?utf-8?B?RmVCWU1FR2hyeHBJb1ZwNVNUcUhyL2ZYOEgzMjNwdytBdUhoTHd2MDY0Q2dn?=
 =?utf-8?B?WXZwVHVPRFNGODRSbTczdjV3dTEvOHN2MXIreDc3MUVSN1pXdEhsalJBOGxv?=
 =?utf-8?B?cGFickNxVE5kVThwWWo3dGZTRmNLb3pVaktyWUQyVUh4SzFSbVVpaUIyZVZP?=
 =?utf-8?B?cHY2Umpxdjh5STZ2N1pmbnN6dktnWjNFTkQ0SFoxeGMwYzVheHMvWmU4QXFO?=
 =?utf-8?B?USt6M25kcXZRRDN5RGtMUXNmUWNUZG91UndFQTh3ZTZsNXp3MDdpN3A3WUgy?=
 =?utf-8?B?MjRrV1BSUEg4NnM1MDhEZ1FlUXZnZDZmWGlOcmRvei93RVFjYytpUCtCU1pC?=
 =?utf-8?B?OE5JVFdxUWhQOGtzWUlrVW5KSElmVU1VVEVmd2JjU1hQY1BHQWNrSm9yUkxP?=
 =?utf-8?B?SGFXRzdPbTNQWUpkajhuS0ExejZaUU5HZm5ncDk5aWcwaGdYbiswaVpsT0Mw?=
 =?utf-8?B?SWxTNkMrcHA1TTZtRG1pVDhaOXUyNXBUVXErZVlhdHhlcHMyNkdCMVljNTBj?=
 =?utf-8?B?S1EwR2xnd1ZldVc5Y2ViUFZoUWtWL29ya1AzQytaUHNrTjgxNXJabmdJM0Yx?=
 =?utf-8?Q?sKzpXrTU6GS0r160=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14277034-419c-4f0c-18fe-08da389dbfc4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 07:12:20.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCNUk5f7udsrIEEWPOEqASj74xf5fIDDLAloW9NkJZpJGmp45m0lwOxn+YyFn8d++BtKsswb+X3IC4ZRoSWKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1908
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 20:37, Mike Kravetz wrote:

> Later, that code was modified (for performance reasons) in commit  0fa5bc4023c18 to do a single try_grab_compound_page() instead of multiple
> calls to try_grab_page().  At the time it was not noticed that
> try_grab_compound_page had a check for 'pinnable' when try_grab_page did
> not.  So, I think this commit actually changed the behavior.

This makes me unhappy with the try_grab_page() situation: the name
doesn't give you any hint that it now has extra policy in there.
Furthermore, the policy is unaware of all of the call sites and
is already getting it wrong.

After looking through the call sites, I'm leaning slightly toward pulling
is_pinnable_page() out, and letting the call sites decide if they want
or need to apply that policy.

Just because try_grab_folio() is a choke point, does not mean that it
is the right place for the is_pinnable_page() checks. And while it's
nice to avoid scattering is_pinnable_page() all over the place, it's
more important to *not* have it when it is not correct.

There is a counter-argument, though, which goes something like,
"try_grab_folio(FOLL_PIN) is never ever correct if the page is not
pinnable". But that's not as clear cut as one might think. See below.

> 
>>
>> try_grab_folio()
>>      /*
>>       * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>>       * right zone, so fail and let the caller fall back to the slow
>>       * path.
>>       */
>>      if (unlikely((flags & FOLL_LONGTERM) &&
>>               !is_pinnable_page(page))) /* which we just changed */
>>          return NULL;
>>
>> ...and now I'm starting to think that this warning might fire even with
>> the corrected check for MIGRATE_CMA || MIGRATE_ISOLATE. Because
>> try_grab_folio() didn't always have this early exit and it is starting
>> to look wrong.
>>
>> Simply attempting to pin a non-pinnable huge page would hit this
>> warning. Adding additional reasons that a page is not pinnable (which
>> the patch does) could make this more likely to fire.
> 
> Yes, that is correct.  One could easily allocate a hugetlb page from
> CMA and trigger this warning.
> 

Thanks for confirming that!

>>
>> I need to look at this a little more closely, it is making me wonder
>> whether the is_pinnable_page() check is a problem in this path. The
>> comment in try_grab_folio() indicates that the early return is a hack
>> (it assumes that the caller is in the gup fast path), and maybe the hack
>> is just wrong here--I think we're actually on the slow gup path. Not
>> good.
>>
>> Mike, any thoughts here?
>>
> 
> Do you know why try_grab_compound_page(now try_grab_folio) checks for
> pinnable when try_grab_page does not?

I think it's just an oversight. The CMA and migrate-out logic was sort of
retrofitted and I think it's just incomplete, yet.

> 
> Then I guess the next question is 'Should we allow pinning of hugetlb pages
> in these areas?'.  My first thought would be no.  But, recall it was 'allowed'
> until that commit which changed try_grab_page to try_grab_compound_page.
> In the 'common' case of compaction, we do not attempt to migrate/move hugetlb
> pages (last time I looked), so long term pinning should not be an issue.
> However, for things like memory offline or alloc_contig_range() we want to
> migrate hugetlb pages, so this would be an issue there.
> 
> At a minimum, I think the warning should go.

Agreed. That, and either a) bring try_grab_folio() and try_grab_page() into
the same behavior with respect to checking for pinnable, or b) lifting
is_pinnable_page() out of try_grab_folio() and letting the callers decide, as
mentioned above.

Your point above makes it seem like the flexibility of (b) might be better...

thanks,
-- 
John Hubbard
NVIDIA


