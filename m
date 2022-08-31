Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F35A87D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiHaU7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiHaU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:59:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8500DDC0A4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2tNn+wPrxt5HBXezQgbrKpnEPUbmeIHE5s1DVSZoh7U/PgaMMDxnF6UcJlwxMtnJE2jn5tI3fjC8fUuoijVJLZoGye+TJxRXU3PmbneXWYlkT7uJM5Q19pdB2LewavejHbhVL1fW4yFPycFiaRV1a9vNMgVePvLhP81Ph6972JrUdPH+O70voWhuR+N1mKO2poNiGQ/vAFH1eNOAyNtnu13PkHI7gdQgUSvvaqEIwqD8FgEb2e8NHXGpl1aV64zIkEDh0zGgt/QrP2plROAC4OzyDj/oYCZXK6Z15J8micuRHAfMh/efsuKsKASmdikdOHjE82i2n+U2KZ2B3PP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TpELw+MjTniD2rOJfQPekXTuZA0t5BD6ZWhfXrZkDQ=;
 b=U234iA06j5xdBQBdxYDOVe3yf5w7Ezsr5eUfzutIVkZEDUxnq4IAJlt7+LBfl3xz1iWzjQ5crI8c/4MWUh6thN0osLUuAReTdSiDH9dQqQLJecjUnr8le4UmiubtBOfROEGlCjQ59o/n9/ULX9s5MHzN8oyQsyScrOuaPNoTZ18b2RmkvvcmgyfmhBfaVHdbFCL0db0lHV+Cm+yIh2Sflq7lxI2k7mEmOOIY5i4MhXzR1StAGSdcYRRMxGwr49Sa6zNorcoKGsizpmZ7STvTIms9gWqPVfdFiiKXsrJKeGmgei/60Gku6sVMau1Xjbd7WuG6OtbYI1DInQhYfnXXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TpELw+MjTniD2rOJfQPekXTuZA0t5BD6ZWhfXrZkDQ=;
 b=Iykvdeq1GTGIYPo56Fndt/Rgepr/sIGUVOMy0CQCWJFgVtHq9yKoO+86k+gaFRv4FwwwWdZDETT1bbDmVn0FJwJSulXFJFNNGqYD/e3/CMpiGSi/DtKAXCQxsBeh4TVU6FktQ1HEzVF8cO9AucbrOWgm2HRd0KbP5GTjmTL4Ze16O4ie2yASIS5Ttm51Mppoc5iAJ5ALjsegIpV8HJ1hHlLmEuv9OQfAjBsmxnI0TyXm6MEAS9wI6uFc2i/91UqrwsRfZhrMiCsKRJtf4OO8cfQn0nfAHIeUGcvrVZK9H5TKlG4+FRjv7/M5o5IXaBhO3IBhOCUAsIc4c7QCLifYyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 20:59:40 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 20:59:40 +0000
Message-ID: <f69772bf-1f42-fd0a-f23a-ed933888adc8@nvidia.com>
Date:   Wed, 31 Aug 2022 13:59:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220831083024.37138-1-david@redhat.com>
 <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com>
 <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com>
 <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
 <94c3217d-df73-2b6b-21f0-95baf117c584@redhat.com>
 <CAHbLzkp+HNmz7hGS5uDrfDDW0HpSj5Z+xmmkRbwvgn1qYk8Btg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHbLzkp+HNmz7hGS5uDrfDDW0HpSj5Z+xmmkRbwvgn1qYk8Btg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06007733-a662-4867-896d-08da8b93b90b
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6830:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfRWgIM2q9RdmOWQk28fR6NN+PU+wB2tJskHUOBUTIlO2hzSN9foMDqDmiNTt8uO/dnSXF0RwT6NNI2rL+u6oAI+4WMmEhXcDN4O+lnHHVnB63HNp5ItVKRiENdEYyswhT+TXGSsq32d/vNNNKDzxVA3pZ4qLf9jSXd3ZRaFHIUWIR/hdvfwXILhKu79Lkb3mr29rIuQdQy2rOB9Q76f4i8DaV+h6shKE9ZBb8b766wt3X/cowI5zQz6CcACmJZPyZCcczHT7s2Jr4imVBbJLqCS3sjdjJE6bzCikKy+1iMTW6vxdRtzt44P6aH+4SFKCz8Wob7QTq1wSowKXlyrV8ORw6F2MvQQCTQAeUUJZVlr89DoP6KTlbBKHFh/FEVy8X2Nd/G7VZyPdu9F42yPZ8AKjzK+ZpFF6h+qT+pdgvg1mUo4aSqv+ugWTAd54wHVo70RXmKmad4giwuvo7IobAdjGAmZpAPk/bxqfaDIleEIjPtPjXXwK0t85QDnsP81irwDMiNAEuMDhVwFhmFFTbNrznt38rQpO70bxtRHShFll1vtgMoYbiIrd18zA017Ikyw5LAXhvxOW6jlg7Dui/WrtPkNZ3lcO/2NRT8QyGFLDrLQg3doHqq1tjAuhPADeCqREvwAGdZkvMMH7aD8nVI7n3SNfPVZLXhCe8Zk89jbzC1L8Pd5BtPT23CRZNV3jJFL/vnmxWoetPMHNbl+Yf6a4Lu0HDipTrGK1WHRFo+X1nRGZEge+h3pkXudTrYp2XpTE/yLZHS0qQxGNPOQQoDxnmgoF4uy29SF1CTCxCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(110136005)(38100700002)(31696002)(36756003)(4326008)(66476007)(66946007)(2616005)(316002)(54906003)(6486002)(31686004)(66556008)(86362001)(8676002)(186003)(2906002)(53546011)(83380400001)(8936002)(5660300002)(478600001)(6506007)(26005)(6512007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJjUHpmREhTREZDRGluTG11c1pxUklqYTREaUhNQit1dkRocTdDUWp4VFo1?=
 =?utf-8?B?eW11MGNZRHAxaUx0alFOY3U3ckFTOUJ3elVCeGc5aUdyM0ZRWFQ4ZDU5L0lV?=
 =?utf-8?B?cFBNZXRXV2VFYzNqcmJrVmR2c3VZK1dHb1hKWjZXd1dBV1lvRmNmc0pMdHZi?=
 =?utf-8?B?N1h6aFJ6TzA0NFBDM29TaC85KzNWSlVEZU1BR0pmbEdXZ21idTMxZkVrYjdY?=
 =?utf-8?B?TWVwSHJLUUhPeUFzOVVpdjhzc1JrclhRYjVzZklwK0pycGNpcjZ1VDl3S3lR?=
 =?utf-8?B?ZnVwK3lza2RLNHNTdXBjQ0NJancrUXIxbTV0SXh6ZFlMVW9CMmZ1THAwSUkz?=
 =?utf-8?B?dmY2ZEdkYUpOcHJXWjlaL2xCYVVoUkxCZWQ5TUdPRzRmTFFwbEhBMWk0ZmZF?=
 =?utf-8?B?eHR5SG9qbDNxb0lqN0tJeDl3NkZGclFTOTdCS1RmK2pwN3FYSjNmdGIyT3hY?=
 =?utf-8?B?azlQZzBOUlB3WXpRRWdkSGlhMXpIRm1TZTZCZDR5aWpIUUhCemVKaGh2dnNM?=
 =?utf-8?B?WjU0ZEtNeS9wdFFrQWM5bXFMUDhjR1hGRjNxUmlIdXpjSkR1ZDM2NEJDYTBT?=
 =?utf-8?B?UU8ycGVWSXNSYU9sa1FZTVZEMG05YWFsN2N4T08wOEJGQ3R3M25zZmdBQ3RG?=
 =?utf-8?B?VkRWdE01UnNJRmg4Q283NmUvbDNrNlZiM2M4RXpFUitKc3J4cHNEMjd2MFkz?=
 =?utf-8?B?NFZzMW1LUjEybnR2emJ5eDhjcG5QYXdicnBqMmJ5V3FjNVpIaEI0MnJhZWoy?=
 =?utf-8?B?aFpYcnM4R04xdXZiekJMQlJ5cTlMSk85dVFuNGJCSjJRWjhjRk5HWTVzeDBT?=
 =?utf-8?B?WXpsaklhWlBvWlhRMmlkc1A2NHliazY2WUpjZXd6ZnFtS2d3ZXRyR01GRnIr?=
 =?utf-8?B?MjFTRFh5OWpNcXFxb2ttMjNBWld3SDFKN1hIaHNGaytJUDdBbmk2OGpEcVVO?=
 =?utf-8?B?a0tjN1NvMXpjTHdLY01ra0N0Z21oWnZkbUNmQ2RweTdtK0lreFNrNWpjS25r?=
 =?utf-8?B?WTJGNGp6RXp3TWswY1JhVnRIczFjM041UVRFZENxU1RUSU5FR3RBTHZjNXJj?=
 =?utf-8?B?c3NTeWhOZzJrSDNMdTN2MnFVNXhtczQ0WmZkeWZONmJBZnNaVmFhVjMwUllL?=
 =?utf-8?B?VXNnVzBMUWx4eVcyOVNPdStWYkpYOTNsNkQrZDkxY1RwVy8ySVQza01SZzJP?=
 =?utf-8?B?eVp4RzZJYzFvRVdxaGhFVURCckdleEs1OW5wYTFNM1M1d2h5WVRYcHhSamFB?=
 =?utf-8?B?RExmQ3NNcERZeXJZdk1vRHoyeHhBVjROczRhd1p4QUdmVWc2UWhubVdVaU5k?=
 =?utf-8?B?cFc5eUhqNUZPVElmcEdqQXptdzg2OU1tek1YY3JjS3ArZkgwYkQ1L1pWL2tV?=
 =?utf-8?B?RDlpaWhDZGpSZVlyeFdkYkl5SzNuMTR3cVN0dkNINmtsU01CU0krT1cyQnlL?=
 =?utf-8?B?aUhaYnJKQ1RJTUR0N0k4MWYzT24rU1lkbzZFbHk5Q0lMMHl3OWltaFF1Vkhn?=
 =?utf-8?B?MGpwZ0VndkF2ZndxYkRlRVhlQWtwRWF0d3N5dkdWb2tTV0x6MFZUczJpeThj?=
 =?utf-8?B?WG9TMVZqeis0eXF0b3doTlZ1aGNESTBvNHJjWlQzYXFBQnJXUWUrQTRhMWxP?=
 =?utf-8?B?NDcyTnVJU0lVSUhVUDFmVHd5U3RLZFdUemt5eWhKYW1xVDdSL2JGd25BdFJM?=
 =?utf-8?B?K1NRLzJsazFqQ0sxUXpSb3p4OHdBMk5zTVhOdEtvMzVDOFBRREZyd2ozOU1N?=
 =?utf-8?B?alR4QzBDTkJ5RmsxRnZUN1ZjamtxUHFteHE1cXdLOXNuK1dYUCthdnpja0xl?=
 =?utf-8?B?YWpBbC9XbHpOSzNDd0lPSittdnlCQVRpR3ZZb2RhT2JnaE0zaHZJNk9way9W?=
 =?utf-8?B?ZHhVWEU4T05KQk5xTmY3T3h6d2xvUUt2M1lyUVZZQWVoRGR1MzRmcEtUeHZh?=
 =?utf-8?B?N1d6MENQVEFKQzV3LzhoOVFuM0RleUNtai9LR0lsd3lUUUVjU3l1VURCeS9F?=
 =?utf-8?B?QjNld3l3TFZKS3I5Q3Rzd21tRTI3bVFyK0hoMzBLVFdTVHhkRWtlZ0dYYlBn?=
 =?utf-8?B?WFZUOTd3MXdJZnpnK1lyT0pPNUg2UXQ0aVMyR2ZBcjROQnVpUE03N0JXT0Fn?=
 =?utf-8?Q?2ph3yLdcfFUwqnJagaOcH2hP9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06007733-a662-4867-896d-08da8b93b90b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 20:59:40.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AarqRiyoqCAgAsTp2DBz848EZ39YNl4huGq5oAGbQ/q66/kMCd6HP2Ll3B2rfGFT1oYzU/acUqfypwsGQ9fkSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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

On 8/31/22 12:43, Yang Shi wrote:
>>> It looks powerpc does issue IPI for pmd flush. But arm64 doesn't IIRC.
>>>
>>> So maybe we should implement pmdp_collapse_flush() for those arches to
>>> issue IPI.
>>
>> ... or find another way to detect and handle this in GUP-fast?
>>
>> Not sure if, for handling PMDs, it could be sufficient to propagate the
>> pmdp pointer + value and double check that the values didn't change.
> 
> Should work too, right before pinning the page.
> 
> pmdp_collapse_flush() is actually just called by khugepaged, so arch
> specific implementation should not be a problem and we avoid making
> gup fast more complicated.
> 

And just to pile on, about that gup fast complexity: depending upon IPIs
added a lot of complexity, not just because of the IPI dependency, but
more importantly because only some arches even *have* IPIs. So an
entirely different set of reasoning has to be used *in addition* to
working through the IPI story. And sure enough, we can see the fallout:
you are uncovering lots of half-correct comments in that area.

So getting rid of the dependency on IPIs in gup fast would go a long way
to simplifying it, and maybe even improving overall CPU load (insert
some hand-wavy notes here about IPIs being worse than things like RCU).

But the real win is in the complexity reduction in gup fast.


thanks,

-- 
John Hubbard
NVIDIA
