Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135F74A807F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349537AbiBCIij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:38:39 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:32865
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235967AbiBCIih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:38:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJNb4k+JKBWwEDpACPuA4QEOUjxF6xQJGSWshY66yWaXh/UH4arNglfPyAT2JrJJ8VcuNqcUN0cavDflXu/Qd8wED8GzCFNbedV9t7GL2vlmtuUOgFBgLdu0P/2mzikbWD3OFdDkOTJqZDQvL7CPvxmYrh6rzAFOTVIpofvWfhSW+nuxToFdBgtBf2oo7ImUHMBn6ZmAXjPZMdGQDqW5ftb8BNN17FjT0JKnuVajNtOD7lbyjcPxVP3vvyDNiZCdET/BMqf1LbNv2OBjDMXH6I2Qx9SvLg7PDfo4AJ9jHuqSxw6aRyWYePf9JEe2+SuaWhGokyWq9MbEJEnZYSyBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECGatShs7O/jYI12UUGfqoYXZUxQIXsL11R768nXKXo=;
 b=JT77P10yPlmSfQUTHSnVE3dMUzrNguAdGJyKYW+IQ8pgEGRWMegMA8LjNqTWmPJps07HcPgKWfHOm1WjyPcqVe26W7rlRoKa2ECbU47SYsL9gnBK3n/gwwONB5md0DK4vT0i3zBqUdeGxp/z/rTYOshoIzwXgZmmrU9864Hm6Wt9d/wgM3GQntkrZw1hn9UF+AcyWcJIC+44LHskidMPRTyRqksNLMokV7umJ3F3kKcPtcKbn4HEH2n8Ug4sVzENTceSUYsFdxDfvfK5SxV8nE1jgUl66Vc20X/4chz/mMPrfU45ayOAd+zpnDyTAsJ+j5TL9V/kB4x2lq2rYaULpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECGatShs7O/jYI12UUGfqoYXZUxQIXsL11R768nXKXo=;
 b=gz9pSDI17n4boyXahY/mH74dbj+Kr+jCbS7fXfdyfuLF3Ldrwttq1vUIeyoa95uJ7VqpBfFUPI67pmTKZ6xh5MixYy3iq5/AWWeBR2Auhyw9n/GIZWkUazoLjYTYGrXC0COeSEE6upchtxj6AB9uvsKNind3I5F47ko9BD8HeqV21AF68n/4VRJ65CiATvPo9QXGaJfwzqPL54J82qyPgbX3hbH63H6S9ZCmibUgh1YylmUrllZ+eKtepfFoc1e2ctICqjlpwxi55CqZ5mcgNFA1dgbvbsSqxNSlqKt4OL81AdMGCAFPqUToqI/kq3+0JPL4VeszP/dcKt5YFIfvOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SN1PR12MB2351.namprd12.prod.outlook.com (2603:10b6:802:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 08:38:36 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::ede5:7f12:c1:b25]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::ede5:7f12:c1:b25%7]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 08:38:36 +0000
Message-ID: <6d38ed2a-72cb-3eb6-5af1-caee61d94005@nvidia.com>
Date:   Thu, 3 Feb 2022 00:38:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Weird code with change "mm/gup: clean up follow_pfn_pte()
 slightly"
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:a03:100::36) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd3f9c2-c516-4869-784e-08d9e6f091af
X-MS-TrafficTypeDiagnostic: SN1PR12MB2351:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2351F1986EF5021B48FBBC70A8289@SN1PR12MB2351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4nIIxAcOxKCRHzwSa59peK8wksYmZYBbqHQ8RuKvnNMBPIHfDfb1Ldsk9C3jD9eJHp/Ie8KML6xP9F9j/LV9P8sOrwZ9Y9i0aRZ9BAW+E8erk3o4LggXCKzVZ5xfzSIlzrMYwrlgKmICeyRiVvwiJgNVI8LKoSDlJQ6/ZS0JDQTcCw+DflLWA+SPDjGmQgUAKygazIYexZ7bmtkqT98BTnHjCXXF3kAYB0r6LvwKIXirXC3i57tF1dXBBywSdDf8JpWmRhqgV8B1xeocqOUxthyZkkdRa2qccdssN3MnBypoSvVlyR81Ct/lilDfPZKQRRNy37RY6eS7Y3AgN80TkCmyQ7j1qMejZY6m56iww6JPL32rU07QTzmyHWqaUby4GN75jJJuDlMDEs/AbgSm1WYaaB2tZZlORQiRv/ULQesxuHKh/oUlebun5+4p88UnSXc0+WDjLDXBC5OMkJEyRgrIvmcgfNnLzl7ZskEfe9UimKYMJfsM+M5JggWWRbX3ghIFFbkhEeixOgkI49V6Sd4cY7vGjt7UzLHtmuwiCtC1IYEOo0FsEqLUnCqPPCNXvMYfHnzzxUae81sDmHfSBfuongjdUFA3+rD1aEQTYhhD+A7okTcTNlx5HLuMehGhfVsCt8QGLb1gYRS1C8Gnde8WgnyHZJgLtsGf2tdPiJd3M3oCv2FVzAT6ZeFISiC6UPW84x6xjsGUWfeo7YcjtoZ0W2Qr2lNJXupbBNjHwV6U8GhJwe3hgnWQm6Jc9rpc1HeJ6jw40oowfPvyBdc5/RiBXBFUWmVNZ5wR+Iy/dMliWxo/FyNme/eP3KHtlRD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(6506007)(7416002)(2616005)(6512007)(6666004)(5660300002)(110136005)(54906003)(6486002)(4326008)(966005)(66946007)(66556008)(66476007)(86362001)(8676002)(8936002)(31696002)(316002)(53546011)(36756003)(2906002)(83380400001)(31686004)(38100700002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWYzMGFNYjVVeGNVbTI0RlJIR3Rub0pQSk5KemJCeFY3VkErZjJmUUFVRGFj?=
 =?utf-8?B?TWgwUlFnaDhkdnlFWSs4QzJFd0J6VTluMzcwWXZhRDZuRi9HdUtYWGJyNGk2?=
 =?utf-8?B?Z0l2a1prczZhdFEyNDBIa01EaVlXVy9OTit3djVDRWtpSTByNHR5bGVqZHo1?=
 =?utf-8?B?anRRYkxPem0yK09GK3YwU3JEVHgrV09GdjBoWDRMaHQxRjdmT0c1OXpzdzlt?=
 =?utf-8?B?ZVdIVDlRNUFUcU1jOFdLd3ExQTdBUGRDb1dOSjEyYm0vSGhxUjFjVmRGaDY0?=
 =?utf-8?B?VWpyRG81UXhrSVNWMGVERGZOaGZBNGdvc2RyYWJtV0greVJhcTJFS0VPWitR?=
 =?utf-8?B?NkRVcyt3ZUk0WVlMNVIxR2cxYVlCcnk1ZEhnVzZjNkV5RUNFcUFZcHBzOVhZ?=
 =?utf-8?B?bWZJMVZsSU0xWjRvMzl2V3pkSVNONmpBWkd4bFlHZG9IWFBQYlJpazE0QWpv?=
 =?utf-8?B?SDN1U1grQmREZmVFTUxsODlqaFYwcFFYQXV6ZDNSR2dsU0J4UVhDSDNZcnRj?=
 =?utf-8?B?OUllR3JWMHI1VDFaNTluYkFmRURXVUxyTm15YjVTM2xvbTRlZjZKR21jYm52?=
 =?utf-8?B?K2V0ZitTRE0xbzYzZjVkZmFSVVRBaVcwdVZtR2NLVUlrSnpNMHFMcHhjV08x?=
 =?utf-8?B?MEV4RVRQWHlLSHNaZm9KSjJJcVlIOHpOTU1ueFUzRWN5ak0zUllPV1E1dGVa?=
 =?utf-8?B?cGlUbHhOWkUwQ1FiMnhjb1lrQUpXQ3lUWjZINFZHOFIxcE01UHVxUWpxL2Zu?=
 =?utf-8?B?UzMrWWY4Sm84Q3hFUlBHb0JEM1lOYzNxWk9Tbkd3Z25LRkpieVNISFZub1RM?=
 =?utf-8?B?T3F0NFlBQTlDcm42M0RGcENSdWx1Vjg1ckU0NFJvMVZTbFlrT0xBRWJRdWw4?=
 =?utf-8?B?MlFsSFhmd0xHa2xacFF0dkJtTnhyUHlXTWFmZ0xkMHNzTHd4Z3JBVWQ4R2lm?=
 =?utf-8?B?bEgyUFd4ZHp6NUxYQ0xudXp4bTdVbDlGNytpY2xaTmZXdkUxMUFDU2hsUDJE?=
 =?utf-8?B?OHM2cnRVLzQ1LzhyOHpkSXJDdEwzR3pIZ2Y1U3MrZWJGVzM3Y3VNVng4bys5?=
 =?utf-8?B?LytOWFJETGgzS0hFMkNpaHlLTUlkWVNHVHZyRU5EajdkNTFUaGNBZ25FdEZn?=
 =?utf-8?B?VHFpQTFwZi8zb2pybmRZZmQyUEROMkJyS1I4TUY4TTBiaHl3TUdscU1XZW5M?=
 =?utf-8?B?REVvbmNmNEFTZEhvd3N0bUw5N2Fjc0J1TzNaMSs3dlBIQ01NNFJDc3d4OVU4?=
 =?utf-8?B?dHhjbUlSWTQxbVFGUllhMXRBdzU4R3F1QmhCOXNpSEZjM2lzN0RFblVTd2Zy?=
 =?utf-8?B?SDE3S2xuRXBicU5lL1NyUWR2WHp5dFJnVHA1d1Q3cnpvVDVxQjBSQTR1bnBx?=
 =?utf-8?B?NkVZbkFmbXRpekhFb25yTGF1M1IzaWVaRTAyQUZIRWVScXpocEl5UnJLT2wv?=
 =?utf-8?B?dGQ3MzhGVTdQdjMrazhBSXhPNVgxUFVzb2d3dHNlOVdrMmdGMkpVWDhZS2pv?=
 =?utf-8?B?bjZDMXY1QlNwMGl4T0pGZ0ZUdnd6Mk0vNFZwSmUvSXQvUkZDMUJObktLUWRT?=
 =?utf-8?B?Qml6ckpoMFBzUzJ4ZVEraWZYNFBwTUR1MmlZVUU0VmU3RDl2c2lyTVZpaXRX?=
 =?utf-8?B?Wlp0VmMwU0VuU2VQdFpUQ3F4TzhWTDQySlYxbFpqZkdQaDNYdHVndmJVQkM0?=
 =?utf-8?B?TnRveHJRNHdUZGt1R1JWbUNZbE9KVXVpL3lUNm8zWUhYandJZGdlWU9welc5?=
 =?utf-8?B?cmJzSlVNejU1OXFseWN1anVieFZMQWRVVUMzSHpKeEFDYmE3Z2hDS1RQTjhF?=
 =?utf-8?B?bWZPSDZzQTZWRkVZeHZ2QXVuVS9UcVVRY1VIMGREQ3owR21tU3FVcmE0U3p1?=
 =?utf-8?B?M05jUzAvTTdwb3htM2FNV0FDcnNvYzBQbkxUUTBMR21iZjl3VS8yNlFlWUpQ?=
 =?utf-8?B?SmZPSGRXeXY4eTZUclZmOWJ6V1YwOHRHdllaZ2dYZWY5d0FxNU5ydTRCbTgz?=
 =?utf-8?B?dXB1TFVGR1lDcTlwN0E4YTFJWStUWngxaE80Tk56b1NUVnVyVUNiQk9wQ0FN?=
 =?utf-8?B?UUw5ZzZRSXlBR3RSN2g2NDZsYktBYkc3QWZSVUJpWWRVanEzZ0FKTjloT1p2?=
 =?utf-8?B?SmQ3OWVjYXppbXJBZi9lazRjL2daVkRVNlgyNWQ0akxuQ05zOHpBOFdUdnZG?=
 =?utf-8?Q?4vZhI3lOeKI5YAPtsbD3iWU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd3f9c2-c516-4869-784e-08d9e6f091af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 08:38:36.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENPjCzOmLSKiDv81zDr8ZSzOcy4b3w1EWnKGPwrGD9n06RmvFcVkmWio6M+nVLMSVJPaPvKRZMQXEFAc/iMf3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 22:27, Lukas Bulwahn wrote:
> Dear John,
> 
> Your change "mm/gup: clean up follow_pfn_pte() slightly" (see Link),
> visible in linux-next as commit 05fef840b5c6 ("mm/gup: clean up
> follow_pfn_pte() slightly"), is somehow weird.

Well. That sounds like something to be avoided. :)

> 
> In the new branch if (pages), you set page = ERR_PTR(-EFAULT) and goto
> out. However, at the label out, the value of page is not used, but the
> return uses the variables i and ret.

Yes, I think that the complaint is accurate. The intent of this code is
to return either number of pages so far (i) or ret (which should be zero
in this case), because we are just stopping early, rather than calling
this an actual error.

And since we do skip over setting pages[i] = pages, it's pointless to
assign page to anything.

So instead of this:

	if (pages) {
		page = ERR_PTR(-EFAULT);
		goto out;
	}

...I should have written this:

	if (pages)
		goto out;


I'll send an updated series with this correction.

Thank you for the report!


thanks,
-- 
John Hubbard
NVIDIA
> 
> Static analysis tools, such as clang-analyzer, rightfully complain
> about such weird code.
> 
> Maybe you can have another look at what you intended to set in the
> branch of that commit or if you intend to jump to the label out?
> 
> 
> Best regards,
> 
> Lukas
> 
> Link: https://lkml.kernel.org/r/20220201101108.306062-3-jhubbard@nvidia.com

