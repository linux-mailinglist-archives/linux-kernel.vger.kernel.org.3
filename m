Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9C526E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiENCwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiENCwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:52:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E498130CDA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOdnhcNR62AxUL1yNvYMSFruHqgKEJFXR+xMXD4gfq9yAjouMg5VSzw9PUz3IkeaAeqbmQEU3jxciD5D7XF9Ecqrd3owHr0aIEl08xvBPnjI/0mZBX45TssNH+e4XGqL8m01FeNmkJpFD4Gn50lAie0stNCKRFoq9fYS6YDpObXyJfiQOoVh4zO2I+8zi2nbioAJgtqXiFhjz6yJgnr6WXqMBMiPmtqnI96ALpq5alr0ywYauGBxEAMoogqisSxZM+fyXTNs+Uig9TtvFjZ4KTwIWBnrxcCxB8FPpahDAJgKOn/kPI7egf0AW7bBZ47Zv0P9Nz2oP5RapsP68Ny/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqammOmC/7TpzofefPy4xPHLYmdCKCI+5BDfICvGUJo=;
 b=NLD60EITK7st7pnpJI+Dte5S75jNUCAivoZ5l/CxnEhCfSPljm0frzFxCNFjNIn9AxSClWGvtUS6dKtpVMgCbl+EvZM4a5HSsqL9zh+OQgGxBVVJUmjlHlF6TUJkSq47fTJUY395C5jwa16+V9u1U8CYcgb/HMGIotVzSziui9nXbgoz0gtH60NsnrjlKf7jYDpqb000hulkLmHKVBZ3PSTSuCXtfG85TRKW6h3Ed0b7cHzQvUi+vIj0Wst9ve3+VlkCVGEuAtHD5X6s4HdDBVugkgW9ElcY+PTZBlQ+dYKLmnGGEE8tHo8LfeiF1W4mczWU7w08HjLwJw4PQSX1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqammOmC/7TpzofefPy4xPHLYmdCKCI+5BDfICvGUJo=;
 b=AXlHzNroPu2v3GWFKPNA5heDVixpk5UFwlRpyC5RUL65H8oFNcw4fLkhDYAgB6os1/sL/GL9rcXJIyxLEjHzwJj/2YlNTXk1DnocZaPFI3U8TIqaHsHBoPgfKMOg0phnbfAxvdfrMJ+VA4f2I6cf1xjU/PrgeE+L36/1D97ZzwHjprhqwR5G4MJoiO5Ul946jyru0QdZsD0gbajcKrWcZc9r45+hNChQdVxcrb+C09pcstM1EzAIjcpwY4oIsUMXdiGJvfxjmhFcObA9Ljv/PG5KQ7odUhWIU/iTqt3c88TbUC5/fpbk4QBiEPlxrPWp7LqIq+1RK+1zM+OKW4PivA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Sat, 14 May
 2022 00:57:02 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5250.017; Sat, 14 May 2022
 00:57:01 +0000
Message-ID: <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
Date:   Fri, 13 May 2022 17:56:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yn73Hz7LkSUv7ycw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a4c8d5b-7406-42ed-d505-08da3544a7df
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5351AD7392BAD33E321208CAA8CD9@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ao6fCeKWGYg7qrTk/DP1U1Kd00O6wDUMFLyLlcViigGQG19DS+WebB4htD8BtN9MmFUk51xDoDSedApIANCMgJYtIB2I7lDN9vdgGRJUiRSh0ZucCjqBLnESDkBVXH62pjClV2Yn1WJMZehHjiINuxxO1Y4lrq6xXDDx41xwMb3aqGtQWxKz1/r8ntjsUZMjzKAPlus5l1CmxEIzChmqka6OGgpqR8hlpHThpdDdc9v7mICjJTheVybPO1H0VKbx6Z+wWff3bGkJOOJGo9Lea1jGpKGYYPoGf19qBvj11QTyjx4+ZyYvL9yoeeTrURw4GfSDjlb1jtdQo14m+xz4+Xhal7QB0sY0Az1oi9DZ1pdUr3oLQFYlAbZw6mX44LtfVncRNLaj2veUnvE6cGnbaDl2HYhARAxBKCZ0GX5f4NitUcD0/eOrSrW7lE09yX0T0N//QOVr8s1xqIhB1S99ziQ5FaJnLPudF19DMRkz70SgAa1f3J8B2G6XcipDeytQK7Y4KUWWtJ8W4yi1QSOfZhLZgOa0ca9sAvqEF93cHbWymDVQM3YPDnpdh61U1iDSoS+J0b46OEpV1330TG5NoPc4tPyqZIyClnFrtuk32Z3U3ZMPceWz3bgJCM/YDsksBFTsexU88eiOyCghlJvFghPlMCJLuJx549I58wcSpm9GrjU/vD+kSLfbOEr+7L04nyQY4nfq0p0MLS5T1glnm8e32G8ekIxHcR9CMf9Kl9fcx/gXGloKP6jIyeRDNznq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(26005)(38100700002)(6916009)(36756003)(6506007)(6486002)(316002)(54906003)(53546011)(508600001)(6512007)(4326008)(66476007)(31686004)(186003)(31696002)(2616005)(66946007)(8676002)(66556008)(86362001)(2906002)(7416002)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRvZDFWNGppQ2h0QlpWNFBpTlJCcDNSWjg5UjYwancxeGZpN0lqQWdIVllC?=
 =?utf-8?B?eFdQMklsT2d3QkU3dFVTZXpYcmh0SkVFVTJkU1l4bWZJd1Jna0h3SkVWY2dI?=
 =?utf-8?B?SnRKWEhHTC9IR0NQK3ZXUkdlNzdtZ0xEMlhuVWNXWVR6TmZ0Wk9aZWNnRUlu?=
 =?utf-8?B?R2dGdE1Na1RUcmZEVlFzcDF4SEtDU0g0cy9IZkdMVGwyNXJ0VnMvYUNXaTJu?=
 =?utf-8?B?d0FPRmJFQVR1YVFpWVZwVWZGRTNKSGV5MTNMR1hkZ1ZsdFBZS1V5a2prODlF?=
 =?utf-8?B?a29ZN29VTWEvclYvNzdmd1R5eUdueko5ZTN1czRwcExxV3BveW8rTElMamxm?=
 =?utf-8?B?UWpXSWdDQTZ5RUM1NXlQeDB1V2daYzd0TGd2N3lQOG5teXh0blZ1ZHhPc0lY?=
 =?utf-8?B?UFhHVFN2TEFqWVJrcUZwODRKNFlZdnZYQXhtYkxLVUd0SWhKbS9WWHpBODVC?=
 =?utf-8?B?MS9SK1NFazd1RG95TzJnSDBEQmIrYjh1YzljbThWYno4VFlPelFRTFBNWk05?=
 =?utf-8?B?eUoxVHhxcXBEM0pHRTMzM1R6aHJ2bEpJU2xNMEZ0OGE5MDkyWlhUUFZjSzRJ?=
 =?utf-8?B?eFNKaXltbTg2V0FsV25pM0NqbHFmbWl2dkJjRjlNOG53RmtrY291WnpscjRq?=
 =?utf-8?B?dEx1OXJSVU9qMTRheUluaFh4Skc5SzNuVXJISzRHSGZ1R1ltUUlHWmk2YU5v?=
 =?utf-8?B?YnloeGIwbXBpbTBldEVzN0k0eUYxc013WnVpT3hhRVN0ZHNGWGl2a2xMcURl?=
 =?utf-8?B?MEJoNHBqRUhaTTlnSkhWQmNTOHY4R2szNDhpN2p6NTVXb3BBZWZ2UjVFRGls?=
 =?utf-8?B?RTNGTTY0R2ppVFNCZng3QnE4amszck43dmVWOEhCcHdSODY2NXBRY3pnQ0FN?=
 =?utf-8?B?UVk0VHR4ek82NDFTWkZZdEx3VERsTkZmSjgxT3RCUm90cDE0YzdwU3FQZkhx?=
 =?utf-8?B?UDlNdmNmQUtrK2VzWHcxV0c3bWhhZFl5b0dWVGxtNGtwZlRvanlKQWdhWDBk?=
 =?utf-8?B?Y01VY3I5Ly9NY1BkeDJpbjdqSE10WUdpMDIyYlJ1NDNnMGNNZWdTNHl0WmtT?=
 =?utf-8?B?TThnQ2NrSFQwYlQrUUc3OENQa21nM2lWRkpLaElCWU9aT2YxOC8xYzBESlRo?=
 =?utf-8?B?b3YzNlR0QjRaelVEZGoxeGhzUUhQbkhtQUpWUzBIU3UvQzFxUkFhdE9sS0Vu?=
 =?utf-8?B?cU01WkRmNFcwNC9TWFdIZ3h3K0Q5VitZZUhIdkMyVWxzNU14QkZkVjVZRkxB?=
 =?utf-8?B?blo1U2FUcWdLdlpCTXQ4MlRRbXRuZzROb1VGL2NEMmVqZWY2Y2Uzamo0c0FS?=
 =?utf-8?B?dVBZRDVxemM4OU5GSmhNSENlYUV6YkIxc0tnUjR2dkQ3OTNibGZ2bjFVRlo1?=
 =?utf-8?B?TzlXcGhTenQ4cnhQUU5ZTk1LWjJNN3FwWVd2djFBMFNNSnlnMEFrVVA4NXYz?=
 =?utf-8?B?THJRYTM1bGFkV2tHc0NTODJwVUlCU1BVWmhYeENUMkp3Nkplc1pFcUFoSkUw?=
 =?utf-8?B?TlFGNkQzMk9sbjBkTEgza0hyemtFa3hhOVJ3NlJMMUwrMjJPZnRsdS8rTlcz?=
 =?utf-8?B?b1dFVzN0bm1oRU4xbjMvTE1IQ1R0aThkaHZtT0xJUng3TUZyYk9TcGhvMHoz?=
 =?utf-8?B?ODQ3TVc2N0wrTjk1UE5aV2YybFhyMEMzYXZ2M3BFcS9STS9GQ3QzUGZpN0VK?=
 =?utf-8?B?WkE5WkJzeEFxZFdrekthSHdPWUJpVUxWQzlwWjB1TEU3c3c2bDBtWnA3SFow?=
 =?utf-8?B?cktSZDMyTnlocTJaM2hQdzRoa2Z6YmlrejFXMW02ejBJeTcrWEFBZ2hSUDR6?=
 =?utf-8?B?MFNqRE0wNXZqaWQramVLNGhGWFU0b3FTODNHNmp5Njk4T3RmZ21TMHp4anNU?=
 =?utf-8?B?ZkxsQTZMOHhlZGNvbklyNEZpOXF4YkxaWDR4TW4rY3Zob2RTMTVvUk9wMk1N?=
 =?utf-8?B?ck1XSmwzRTVSdVBRZnA4dWZrc05aQTlaVFRhUm14Ly9Ld1p3QmhjbDlveTFs?=
 =?utf-8?B?VTFQQUpDSjN1YndqcjlHaWpMZHY5Q0F4U2t2ZldSZDJVbzZzb1ZtZkh5Nksy?=
 =?utf-8?B?QjBiTWM3Sng2SGtYb1lpTWFuL1hjTFpoa01IRDh4czl1amlOQXBzWGhIM2dS?=
 =?utf-8?B?dGh1Mzc4Y09aUjhrRk5TY04xSVl4cjJSUnpyNVpZMWE0UjFHTnJzWVlydUwx?=
 =?utf-8?B?STZXSFNIMUIrV3NsT0ptUzNNR24rQmRuTis1R1BpemFXaUVwL2Uvb25kaWpC?=
 =?utf-8?B?TVI1YXBxYldQMEd3QmxlMHRyU3BEQlNnYmNOaFYwazRaeWNGSFYyVW54dkg0?=
 =?utf-8?B?Z2MrckJoMkdvTFptdXNqeXNRY0RhU1RkNW1TVjk5RThaU2kzcmJrQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4c8d5b-7406-42ed-d505-08da3544a7df
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2022 00:57:01.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvLLynT3NSkTQU8qQyFO6Q4/OWgFNINRaviRLQksDJUk7WrdobyrypqjSH/BXnXf0aYgJ80J3C0CnD85DLcxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 17:26, Minchan Kim wrote:
> Anything else further can we get insight from the warning?
> 
> For example, pin_user_pages going on against a hugetlb page
> which are concurrently running alloc_contig_range(it's
> exported function so anyone can call randomly) so
> alloc_contig_range changes pageblock type as MIGRATE_ISOLATE
> under us so the hit at the warning?

Well, yes. First of all, the comments above the warning that fired have
gone a little bit stale: they claim that we can only hit the warning if
the page refcount overflows. However, we almost certainly got here via:

try_grab_folio()
	/*
	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
	 * right zone, so fail and let the caller fall back to the slow
	 * path.
	 */
	if (unlikely((flags & FOLL_LONGTERM) &&
		     !is_pinnable_page(page))) /* which we just changed */
		return NULL;

...and now I'm starting to think that this warning might fire even with
the corrected check for MIGRATE_CMA || MIGRATE_ISOLATE. Because
try_grab_folio() didn't always have this early exit and it is starting
to look wrong.

Simply attempting to pin a non-pinnable huge page would hit this
warning. Adding additional reasons that a page is not pinnable (which
the patch does) could make this more likely to fire.

I need to look at this a little more closely, it is making me wonder
whether the is_pinnable_page() check is a problem in this path. The
comment in try_grab_folio() indicates that the early return is a hack
(it assumes that the caller is in the gup fast path), and maybe the hack
is just wrong here--I think we're actually on the slow gup path. Not
good.

Mike, any thoughts here?



thanks,
-- 
John Hubbard
NVIDIA
