Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377364CB47D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiCCBsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiCCBsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:48:04 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A401B71B2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:47:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET5taqg72L71IpXHNOHtGWh3B8dbHL7MwQOMUbIYzUvZDdtn+BoDshXArQHSPy40wxLCMKVpmG/jQrOkOUoOzY5cYuH7IvctqffSk5bRbBlDEemOdLfLE+6/baJ7/kwr0ySrfCDuCqau3beWGe9NBgrxE7ro86iH24SOqcIePbMJe/uUos7ezKHGp7wN2f1EVmQfDn+PrkMZR9kE9u0UwZuxRuVyRROJCDKLWuYqNOEq0L/hTZ1xN7jtOqCWqiPUqjJuRvCRp4/Xz1f05UG15o7/uIPrPvWBV371wAkVW1riw5o5NCK1ywiv2hmLKN9YLynNKjMfRBXcsOoUdBamiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC3/Ti2IhKLsYvQJelJdcdjdjf7+NDeA6mc6vfsjN3I=;
 b=JguoL5Ovy31/HmwYB88dDaUEloCcKqWwdXDJZ/aINr97+Pj8AhWxCsSmzQJ+mG5L8tr/TilXEhqvoB0wAirlPCHAIdZKTWf/tkTSc0tAAr56MvjQNrSp3b6UlHY/Z2GIpDEbOfhereaxpqoCfPnSApyPxjEJ9NAqi2FLY4+IYZ8DTXce6qeSJg2S5H0eJorFGRI9v08ZX2tpqRvD3kgqRrKPx61BVmtLQU5X3ydkWOcd+l3TImDgVAFBsSvqVoFf5RQpNKMfb/7Us9nWTes9z24G09fvxCdBpRyiwL6eMkW+E46Wcozg2x7eqA7o40Cnm0pBj3H3hOltX2ftzTkY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC3/Ti2IhKLsYvQJelJdcdjdjf7+NDeA6mc6vfsjN3I=;
 b=gXCpPFyyvZNBpfsftayBoveWy+/Zmyux+BAT56H2502a3PJMxYOxGaM6yvNKErmf7XEMhfN9N6hWlHKl0VBom7G6hygyCrRQEin+7MpK/6RpyL5QFLZzuFbvQU7JjpMa90ofWaEx8np9mezCGnbl2EAPVoGrXU4bNZ9/Wwn/LfM0uSvsIrMUPbXBKgn4bWt0F7hS/cLEunfUzTzInbFvrwoZH9EmG79KlwPjg5K9P+5UYBBCh/+ALxSjgVJCceuGhrQGtvGCWPd+0mqX0lnrKig1CzOKrrnjAYnrOwqQAXovTW18fWQHc1G0M5OfGgnbBP6+0HYuccqZ7VclR3y+3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH2PR12MB3829.namprd12.prod.outlook.com (2603:10b6:610:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Thu, 3 Mar
 2022 01:47:17 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::d998:f58:66df:a70e]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::d998:f58:66df:a70e%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 01:47:17 +0000
Message-ID: <0a159b65-cb80-c8eb-7ad1-24b83813531f@nvidia.com>
Date:   Wed, 2 Mar 2022 17:47:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC 12/13] mm/gup: trigger FAULT_FLAG_UNSHARE when
 R/O-pinning a possibly shared anonymous page
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-13-david@redhat.com>
 <20220302165559.GU219866@nvidia.com>
 <fb895ba3-9d7e-7421-d5c6-f5e7a2d1231a@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <fb895ba3-9d7e-7421-d5c6-f5e7a2d1231a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a5413cc-6084-41eb-4cc3-08d9fcb7bf9a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3829:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3829DCBA9B0F642436345DDFA8049@CH2PR12MB3829.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Um6MVcZKUvBt7qmpF8AQy2kpv0ARho2peKT3Rpd052JONk9GVKLZebClkRtHY2JReUMC3L4xN/7NZpVSGkMGOCc+QkH7KEJt1kMaR5EnUk2PUL+yP6IUhH5QBodjeP5S2OIc0R/6ndnjyx+HmonMji6Nq/e5sggDAcChg3FhG5L/c+nciGU18onYTirAH4aOUeYixzrGD+9NjmussWLic1gFqpxB8A/fjCo19XS+6jLqYN0OLVXDmd9YtTe4qYjhYKtr2u4mJAbaYoZ1XR0KVZ0ferqKTrPci5gPQfB1UWGmJPngcggrpSqt3F1vS7Fu7fjAfQAQeXL1uGmFXrlnjxBt6wdQ+nvpToBRg4nqZ3akVRfrij8M4aSdKqKjRW+fyxmLuT2xd/n6iEezUGMNdf0pVgAnjL9oHn3Ip0GmK/v87a0oCr6btc9xEyzgpnQs/lubhr+CdruDWb6rSKJebFUVHHewpTL7EmrudSe7ZMuW50k8NG6PjaonefNOpAuUN2Zjy5Rcr2T//xWFgUPIkcfjWub/+A8C1fY0s3eRW2rcOvtBN5BLEZS5mlmsnovUjDKRz81QZH4qVEfih3OR15xt5OHhhZJ/Pi0pw36+kBa+1LidVW0jxPcG2pkRkevRHb9ZmZtdzqSlUNOjJ0xMD5JV2HBOYuFw4S2eGJDC7C5JtBi7L4pIDjKuXicSgKkfi0wQe3cZniMmR5FEVlvScvTVwTFMKvlxkZEsj72kpQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6512007)(2906002)(6506007)(53546011)(83380400001)(186003)(2616005)(54906003)(26005)(110136005)(6636002)(8936002)(316002)(4326008)(8676002)(6486002)(31686004)(66476007)(66556008)(36756003)(508600001)(66946007)(31696002)(5660300002)(86362001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVJRFZJcE9UQ3ZocFhGaGFkTWY1dGpxL1pmbEdIaDRWM1lFd29yWGF5b1RH?=
 =?utf-8?B?UGIramtMdFYvaVhQaFdoS1FHVWN0UnlvYi84bnlVbndFZElsS3A4eHIxU0Jt?=
 =?utf-8?B?cGpHRStYU0szVGloZWNzSEgwcURlRmNlWnYzY01PVmR5Z21WZDF6bUhabEJ2?=
 =?utf-8?B?ekw1WTR4dEZIdUo1ejdyWWtvQkl2UCtvNjgyYjd3Y3Z4Q2h2Nk90VjVXUmsr?=
 =?utf-8?B?bjJlY2thUlVPQkQ5bWkxa2FOL3U1ZWxWM0xHOWZvclpNdFhoN1lMOTd4aEMv?=
 =?utf-8?B?T2JpNGQxYTdvRldOeEdzdEVEeFZmZDc0VTQvdTB4dWRMSXR3ZVpiWGo5Q29q?=
 =?utf-8?B?dk5TWUxRWTNmenc3Wk53YURvN01SL1pHaC9JZk5ia0E0elh1aEZrQ2ZIbnlC?=
 =?utf-8?B?c29UZ0ppdFBiSmdycmgwM0MxMGo2VWNhMUNzekc3M2V0MWtCS09hR2pQb25v?=
 =?utf-8?B?R3lIZWdUYUVnVmRpTTQ0S3lUdXNDenBGSEN5K3E3bUxxdWdXRWFyVTRNczFR?=
 =?utf-8?B?UWU1WUxuVG1tMmh5YWZQaThRclpCc3UwKzBPMTh0MzNvSGFzMUR2L2FQWkg4?=
 =?utf-8?B?UUlDdjA2alpRUlNLcmRIWnpxVkN6WG0yRWhDaklXeHhvSU5WV0V4Z291MlR2?=
 =?utf-8?B?ZU1uVDc0NTdEbHJ0V2VhaU1xQ1FBeTZna2prM09UYVV5QUczeVFpcmxXQ1FT?=
 =?utf-8?B?UmtDc2UvaHNZdTBRV0xHUWJWTDlLdDBxQjBWSkd4S1BFcE9ySWJjSHlYdVhn?=
 =?utf-8?B?OC90MGw5L2V2WE1xaTBOeDZZV2l2blF5aTJxNHlWR0EwVVRJalpuaXIyU1Za?=
 =?utf-8?B?cytZdEUwdjFhYy9pdkZlaVpLZkI1TmdraHBXaCtEMUpFV21tTlBOa05UbUlM?=
 =?utf-8?B?VTl0SHF4OGg5NXFXV0J2cmE0Q0I1TEFlQ0F0Mk1iVGQ1N3BXaGNsQzE0NkRz?=
 =?utf-8?B?THF3OTZOS3R4TG5ZY0h2ZG9JRkNzYzUwOFVzRWlpamxvUjA2MUwzZEhDNDlJ?=
 =?utf-8?B?MEIzTFhsSG1zaCsvbzdqWHBoTVR4UllZNEpZNGFad0w4YnhlT2F5ME5kU2N6?=
 =?utf-8?B?NC80UDBQYU1vMENzSlpSeDUxbUNiWnJCd2xaWlQrS1V1UE1lcFNKOSs0Uk92?=
 =?utf-8?B?ZTQyK2NFd0t1c0JCUzF1SmZrb1BUTXUvWVNVcEJsWHVPV25FeGNpVGd2Z0lW?=
 =?utf-8?B?WGU1TytQSWYyblhrUTQ0MkVabzhJMDA2aitKMWI4UXQxWjVwdmltRklPZTVq?=
 =?utf-8?B?T2JmeE4wa2hnZWlnaStYMkd2aE5lWnljM3Vndk9DcjZ2cUxSSW41S0wxRHdO?=
 =?utf-8?B?WXJJZXVoSEVDL1ZSUWtTdWtPQXJyUFpxZ1AySGdJYUdJUE02cDBvY0hLV05l?=
 =?utf-8?B?TmU3dThVR1gyazFJY3l1QXZnZno4MDJ4WDBGVWxSdUFBV21ZRmVBQy92clZy?=
 =?utf-8?B?b3BWWkJlRnp6NG41c215OU1GWUZuM0J3K1o2YUlrSzhCamtxS2J4QUV0MmJV?=
 =?utf-8?B?UmJxN1h1ZWZGdWFnamg2ZVBlQVFpWGZ4L1BtbWN0ZUMxeGZxT2R1RDNlWURm?=
 =?utf-8?B?ODVTYytacFM2RGorZTl0VHNKWVArSXJPUFVjZVBKakJBZjBrbnNHckJIR09n?=
 =?utf-8?B?eWpSd2U3aG9pUEdiV3JrSFIvTHhkNHdEaFZSVG9QT3JoaVN5MXBmOUduaDgx?=
 =?utf-8?B?bW5yTGI5QzBPMXA1Q21CK3ordzNtYlY2UmNyc0c3dmplZ2RPcy93Um0xTnd3?=
 =?utf-8?B?bFdtaTVPa1IraVluRjl0UVYyNCtSdUVvVVBqSmRkejl4OWNTd0dHTXFPd1Zy?=
 =?utf-8?B?emdaOGVpdHZEMEFDS25DdXlWTzB4RzR0blY0dmNNQmt5N1RuTThoSTlQMEFw?=
 =?utf-8?B?K3JDSDRWZ25JV0ZCWHMwR21MeUNuWjJqanlQV0xxNGNPYmx4dTNlM09OSXBD?=
 =?utf-8?B?b1NZcGxUd3B5Y3IvRjhqZmFjbWw1RnVRR1ZOenhpUjNBWFBLSnJGemJPRVdV?=
 =?utf-8?B?QnJkRzZ4Q0dMcnFqZkZVai9GUmEyM25GUnkvd3VSdkVJYlhRaFkzMHRpVXpv?=
 =?utf-8?B?czVPckJveW1oZU5FQ2grSFIzSlRxVnNTQmUvaFlwWE1Odm1TaXNvdDZwSTBl?=
 =?utf-8?B?RHYxcFVKSW1LTzdIR2wvR2VTRUgrWmt1OEhzTEMvaUFiTlV0RjI2ZlNwN2pj?=
 =?utf-8?Q?tdb6jS7akkwn/FnAeUhVVU0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5413cc-6084-41eb-4cc3-08d9fcb7bf9a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 01:47:17.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr6Kc5vsnrMWnAzltsgl/hDARTgkQFi5nI3ygPAIEh58E/RTgYW/OPwbG7R3JJZR34f4G5wSpMMTuQ48xkBbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3829
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 12:38, David Hildenbrand wrote:
...
> BUT, once we actually write to the private mapping via the page table,
> the GUP pin would go out of sync with the now-anonymous page mapped into
> the page table. However, I'm having a hard time answering what's
> actually expected?
> 
> It's really hard to tell what the user wants with MAP_PRIVATE file
> mappings and stumbles over a !anon page (no modifications so far):
> 
> (a) I want a R/O pin to observe file modifications.
> (b) I want the R/O pin to *not* observe file modifications but observe
>      my (eventual? if any) private modifications,
> 

On this aspect, I think it is easier than trying to discern user
intentions. Because it is less a question of what the user wants, and
more a question of how mmap(2) is specified. And the man page clearly
indicates that the user has no right to expect to see file
modifications. Here's the excerpt:

"MAP_PRIVATE
	
Create  a private copy-on-write mapping.  Updates to the mapping are not
visible to other processes mapping the same file, and are not carried
through to the underlying file.  It is unspecified whether changes  made
to the file after the mmap() call are visible in the mapped region.
"

> Of course, if we already wrote to that page and now have an anon page,
> it's easy: we are already no longer following file changes.

Yes, and in fact, I've always thought that the way this was written
means that it should be treated as a snapshot of the file contents,
and no longer reliably connected in either direction to the page(s).


thanks,
-- 
John Hubbard
NVIDIA
