Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA85A6E30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiH3UNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiH3UM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:12:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562E8564F0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRo6bcoggdPskwMLt069+HFLKAPlqjZI0Ul2d74pmz9cATE4g+SbM89W6LuZ+PwcdaWcV7UeLS43/byOYf5h3wM+A6nH4tdN+LEB68Srs4bnzjIoV/m1XPzkvs7lI1C2bOxXvc/9Uqj49x62ATt4NaBB65CNVW6z0hSPP5LYhBJSqcsBNDCw6+ZmYiuSe3+WMBBZ3mvcLqLIER0TTMnvmUj3BWa0PMmsNJcKU5lnKqZ9ml4xN6gsOYzfWFwtso46Tuh3oWZ908sDwMf2MHjohDaBLyOJXeb0YNbRj0K8U8uOe8YabVN+g+63e54+J2IRZ1ohC89MsSM2Eh1hzdSGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuwvyeCAfNdtTOcACp66hp7Egtov+Mn6rKz1pqhsztg=;
 b=h/x6sIGu7jEDvqnipHJOqsakcg5FiExnnPpdlLO6Huc2g+VD5DW72nEaKyNDvZb7xp33Se0BGmwyNAXKt1UesN8VnkISM45iTpM5zvATGC+3IL0Pq07GV9PUJ6RBJscxeUe6oOtKNLmfJQFtieSBX3IE4mSSzL9dWLzbtNEy4q5mLP8uacLeuQTjCBYlqk7pUz00i65mJg5Hy5ksoGuTJBIIeqabh9hCxeNLAXkmuzqCLsLE/4L1swMd4V3cvHpNpJbSigO7DtYOwqK7V4w6eQdzjVfOvomIU9ps5Eexdv/5A9P0DiSHRfcgcDVR01n5rnWlRbNSne8YSXSKknB9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuwvyeCAfNdtTOcACp66hp7Egtov+Mn6rKz1pqhsztg=;
 b=CfG1TALfbIjpdfJ0pezJaWDrckKxj7yLePCPFUbE9acJTrvkHnhNX345x+OvNVFaZ4TWQSIUHyyJxNQBQZxSZebXRu0yivXCHezVfYv4g2iRtysKaDniu6M7eR09khZ+Gvsc96lfLpyDKqlur5dGWyDTyELeDODFOEtfDcSlVnsE/tQVNATuTltDvClhTkMqhUZPRaYrmVRX9+9OwERbgSgs77OU7G3nHwV2EYE7/GK6a6ASkE6F1nGYYYI1iRsRoiTZ36Mvq0qP42kHKOZPgrlRPSZTw16cePYVp00Roc2wDPmAmRvv7EJc8FcoVBi4eMx7NuypPIxxak6OWw1tbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 20:12:55 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 20:12:55 +0000
Message-ID: <391bcb8c-faaa-905b-4dae-b674828a6a37@nvidia.com>
Date:   Tue, 30 Aug 2022 13:12:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <Yw5rwIUPm49XtqOB@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yw5rwIUPm49XtqOB@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a863ccea-79ea-4dd6-8343-08da8ac4066f
X-MS-TrafficTypeDiagnostic: MN0PR12MB6294:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NNkmGJzppnH1bJ5+Y5xKTWDxNdSkPd5gJLcuT0uyXhx2GYq6eW51TX0FJoHZWT3PEAhGec/ZUtiVd6OZjltGtPdEMf4DJqpH7WaKsM5P4H31D5rCEvz9yQkeaeek7cV0VRzbGj7uYbLKqFSVjBGweRbjh+tB1NuPP+SPYWPpEbSH3kHeldSatHEXnzvG59/KYz6LQ690g3KtDPo92WbWcdochSSHSkcWyWSfRU8Y2QOegOLTtbTHv4ChALl/zDwwXct9LOgBvYNeIm78ZYRl1viu8ja2ujNYDvbOFI170dq7DC8OvNyB+WbiO6jHIGWQ+74ROoCf2sUUbNql53PKqMBF24KhX/iQUyaESPUT3dPuNV0EEPwgd+/3cxJHJ8XoR0COADOpF/hhFq2WwcjRWbSOjNMieGeUnN+SCxuANNDpCouaZ1G7Csj5SwENy0XQQKOuqLjG1YXoqbuutAvo4C3rxEZVaT8+cTIWFbYRhzJCzCRJuA97nCSUlECN4Vz1Sl3eV7Zyw/Dld0L+LSt7gshwc4wYBAdJbbXQgu+DbYv2+EHN/MimSxD5tRFhgCSdL/5xrJbKSRDTt6oJBGedrcLNyYCu/cDpnNHAmn1upU1rs6SmHHF/rmD3ljuEdkCRrA5s21V+8Dn0IlWd7o/JJxMs9fLAHDrDgOWS2ILsm8QyiYldFNEi5RBjvmF3USVpolkqPui6bpDOwdnQej5uwUk3mGYlFrms1dfRo5zBk9vJnSnEk9SuSba+hNAq97cWq0DD6SAKFjwy0yYJwrTwzAimSTqzhm+sc2mxKLjTjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(86362001)(54906003)(66476007)(31696002)(110136005)(4326008)(8676002)(66556008)(41300700001)(5660300002)(6486002)(478600001)(8936002)(38100700002)(66946007)(316002)(186003)(6512007)(26005)(83380400001)(53546011)(2616005)(2906002)(6506007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1Q2bkhnd2RCRXBMMXQwaVBPYzdpdUVvckdqZ0FtMXpmdVBGSkZ0TFcvaEpR?=
 =?utf-8?B?SWpyT0NOVmNjOVo1UExPdTcxL1o1UHRWWWZnVkVHd1BHaGdlakV5akVuYzRh?=
 =?utf-8?B?Wk1leG9mQ2hiQ21JR3hGUmZLNE1mU0J0Z3p2RTNKUEQ3Z1dxZm9xMWV6akd2?=
 =?utf-8?B?TzZ5bEU4OHJyVFNVSzZZTnRSSmR6SUxtQXpEMmU2WWYycXg5aXc3WFdiUGR6?=
 =?utf-8?B?emJHNTNtdHE4VGVZTWpUZ3J0RG54K3pmM2R5TWF2MDQweDV5Zzg2L1k4WW1L?=
 =?utf-8?B?ODVjTnBiSkRRbzRqRm03OFZUdDBtYkhJR3RIVTRvb1Vqek5NbWdGWHRrMHJ1?=
 =?utf-8?B?ck54TVZzMGlqQi9iTUZWZ3BCYWNmeEV3ZEJ2Nno5bzhvUWNWTm8rRitOdU9j?=
 =?utf-8?B?U1R6U0YrMElVaVdSMStRVkM4ai9EMUZUOWlpaHBVVlZLVW1CTTdNZlRhUnVy?=
 =?utf-8?B?U085OEZIdlA3czZtMUc2cjhtOFZ4Qm9qNGlrdW5TTmUxK0Q1TWNObzNnRE1L?=
 =?utf-8?B?a3RWZXpYaFZZRVZrbEVVQWtrdkFKcVZVTHFoUnBFS2M5WGM2TEF5Rk05dTZv?=
 =?utf-8?B?N2tkR0lOOXczNzdtU0FFMFlTWkpMQmVNM0w2aElreURhYTF4aW9sSVpnVVdu?=
 =?utf-8?B?dS9JdkxIRStUS01xbmNoYUg0MmVXbUxMRkZlNEFpQVVwSE16dGdHWG1uNWpQ?=
 =?utf-8?B?TEZTSWJMcWhVVWVMclFEcFJoNTg1OGs4VmdCTmZNeFF3SE4wOEU3NlcrNzQz?=
 =?utf-8?B?dHVwMTlSaGk1OHNOd2g5L2hVNXNIMTJtaEpYMkdZR3BPTCsxVkhqclF1b1V1?=
 =?utf-8?B?bzB2TDhVQS85SWRUTkIvM0ExR2lDVm1ITldyOWJkSy8rWDZBUjg1ZmFHamtP?=
 =?utf-8?B?RTdldWxlZkFJWUlzSUMxa1pGZTVwUThUQk5obmhicGJYQ3dqU3JPeEpLTEZO?=
 =?utf-8?B?MWE2NVRsU3F6ZWNESE9CeUwvMXlHZDJ1UzFJbEhzMkhiZGlsRkRYbFJWNi93?=
 =?utf-8?B?M242YUFZbEVlaFkzM2kzUEhNaG50ZmdFN3VISDJoTFp0dVBsQ01ndXVNdEdj?=
 =?utf-8?B?N1RnUzhIRXMzd045VVB6cUtvUStlTWs5bm5GOVFzakZIL3UxZzd4ZXh1YkFq?=
 =?utf-8?B?aGU5emtpZkNKN09ZbitIRDBjRno1eUp1UWFBUUJuaTl4VTF2N3N1SGFwL3NC?=
 =?utf-8?B?c2lTMmQwbkZwNzcwYjN2TW5SOHAzSklPZXBYc2VUNEFvOXArQUkyWUtNdVR1?=
 =?utf-8?B?ck96aXhpTnM1WkpCam5JWVJQNXJ3c3RpRlcwRm9QZEkvY3EvS0R3OE92dWFW?=
 =?utf-8?B?NHFYd2VZZTFVQWJURGZJbmkySWVWMHMvQVlQKzhoNHZQS0ZRL1N1ZnhtQ3kz?=
 =?utf-8?B?U2xxM3JNeXhBVE8xTDU2RDJlZjdra2NONjVmcUFYcUhnR05HTDF3S2ozaHor?=
 =?utf-8?B?RWpyRlhaN2cydW5nc0JPc05nN1M3OVoyMUxXcGlTc3JxVG9LT1VacFNTbVZn?=
 =?utf-8?B?N0ZQSjk1ajB4aUpkOGdnN3BWek15SWw2QTNFREN5c20wanpFVDY1Sk9zcENh?=
 =?utf-8?B?SmU1bkN1amhRZWVXalBPQW55RVB2eTRHTDJjaG1yakc2NW84UHcxUHZMZFJu?=
 =?utf-8?B?enNTanBmeTdVYnBFckNwU0k5WVFyTEgvZFZGZUJELzNUbjc1cGhYdmVlckds?=
 =?utf-8?B?NzYwNnk2WDZYelh2N1ZROUorNlhkb3J1b2t3bHF3NEcwS04yREJLQ2w2c0s1?=
 =?utf-8?B?K20yMS9GN1NKUWZlRDF4eWROTnpLanNrNStIOEV2ZVp6MExKZnhSWHVzd2xO?=
 =?utf-8?B?d1BrSnNvTkd1djFnMTBrVEgyMVp4c3hqSjJBRFBLNk5pUkdGZjBvLzVlTGFO?=
 =?utf-8?B?WHdZYzRzYmorSCt1SzZRZ2hMVDN5TEtNeGRVME1pMXJ2dE0zU2pybmRaYUcv?=
 =?utf-8?B?KzJVclNFd3Q3NXhUeksxUFFCSHQ0UkVuWnhkMVRxSkJ2a3BrQ0FhVjhlbGo2?=
 =?utf-8?B?ZkdvZUMvS0M2Y29QSXdkWFQxVjZ5K2hBVHpxaHV1ek5XUm82eW9uZnNBOVRB?=
 =?utf-8?B?eU5CYlRrekxrOE9yczRROTl2U2ltejdBcDVyTzBIRXhWejRLeWljWFZRQW5P?=
 =?utf-8?Q?O7azUY+Bj1ZP2rbJlizgNkLUO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a863ccea-79ea-4dd6-8343-08da8ac4066f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 20:12:55.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oO4J5dN/tPm5C4yQdbkau5nvpfaA+n21MNJgZqvsDE1uXMv18tF/hXJM5UlLTCAUiPrIuyU/x3JiPBLw3kdUxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 12:57, Jason Gunthorpe wrote:
> I don't like the use of smb_mb very much, I deliberately choose the
> more modern language of release/acquire because it makes it a lot
> clearer what barriers are doing..
> 
> So, if we dig into it, using what I said above, the atomic refcount is:
> 
> gup_pte_range()
>   try_grab_folio()
>    try_get_folio()
>     folio_ref_try_add_rcu()
>      folio_ref_add_unless()
>        page_ref_add_unless()
>         atomic_add_unless()
> 
> So that wants to be an acquire
> 
> The pairing release is in the page table code that does the put_page,
> it wants to be an atomic_dec_return() as a release.

Thanks for making that a lot clearer, at least for me anyway!

> 
> Now, we go and look at Documentation/atomic_t.txt to try to understand
> what are the ordering semantics of the atomics we are using and become
> dazed-confused like me:
> 
>  ORDERING  (go read memory-barriers.txt first)
>  --------
> 
>   - RMW operations that have a return value are fully ordered;
> 
>   - RMW operations that are conditional are unordered on FAILURE,
>     otherwise the above rules apply.
> 
>  Fully ordered primitives are ordered against everything prior and everything
>  subsequent. Therefore a fully ordered primitive is like having an smp_mb()
>  before and an smp_mb() after the primitive.
> 
> So, I take that to mean that both atomic_add_unless() and
> atomic_dec_return() are "fully ordered" and "fully ordered" is a super
> set of acquire/release.
> 
> Thus, we already have the necessary barriers integrated into the
> atomic being used.

As long as we continue to sort-of-accidentally use atomic_add_unless(),
which returns a value, instead of atomic_add(), which does not. :)

Likewise on the put_page() side: we are depending on the somewhat 
accidental (from the perspective of memory barriers) use of 
atomics that return values.

Maybe it would be good to add a little note at each site, to that
effect?

> 
> The smb_mb_after_atomic stuff is to be used with atomics that don't
> return values, there are some examples in the doc
> 
> Jason

thanks,

-- 
John Hubbard
NVIDIA
