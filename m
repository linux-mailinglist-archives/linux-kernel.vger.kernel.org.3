Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9B597816
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiHQUfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbiHQUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:35:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD2AA3C3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KY6hNaf+af7kUilT/pJdyesjGHF9H2Su4EO21pzu9IE5GE8eZX92V7mkTcJUw0Rd8A/vhuTbkchfhbbnMqOqf0Wf1DpCKXLc9uNhztl0eKlwIoV8E6QA1ivRckACx/HwIWYDv5p6ZRbK/PHWp/ExEu9RlEx9wVvl5zAZgtvA3B4gbxbSo/paz+2osS36SfngddZ7e7dSZFWJ38D9+x5IPsL6bHHX/IWWN3KNBY49ncmlFV/r29gVZx5zPAYy1qwzhgJVNB/FrYBTMCHwApQsHV2/JSEWznqqHBf+WSJWR0TLCZeO9JDNpvLxDdw/brWtJzVmen9BvMvWvEhcgMPgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUNp77XI4N/1ISnqWFd9LaLp99YGxqaqrpB9jD61VXg=;
 b=oFO8aX0Y0VK+sNt0VafIWtjogFdwhIwKPhRKAS9qGJzR1kqGIOKPMBRM1VHNbdXEzMC8kGYNZuw0MKENcIrOF3d/myGNE4ddm/0QJdP5s68muj9x6JYx4kDRoItLajv/FpZJCfCGLHn9t8FjtnFf2PTnjjbyKuD6GpvwZM7u0zLZBL3bZUOHjVwj/0Ko6Ui2rKmuJJco5+IIU5R/2oxdOQCgrRTeSKHdi+DGaPDNqjmdaM2txh87+CxV8hxY9Ati+kVQgLjRQeE3SARmRXDhES890Gr3GZxmzSHAXaeGIdfOh29O4m2Bq8gQ1YItK0d60bRl6mLMjqamohPUh1jBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUNp77XI4N/1ISnqWFd9LaLp99YGxqaqrpB9jD61VXg=;
 b=LTCtw7JbvtXuoxM2zraSMLurlmpPgCX1KaaxMHMFqwr3yjAIrMll73jPUkX1ItxE9cNW3P8/jnvsq+OyYuIOjgHVn3F38ZRSDriRdNgAXovhGfhZfDP7zN9J1uEK+LIcQWcHxtGxgTOdyeEVnhylSy7IZVgULSRRnG9qLY95wchte+tnoHD++WBNi+5p+O9dS/wVhrkjCXz1qk+NCGN1u5EaTqPyF1mf1WJdjxcJqwsCgigfT431vETBgYez+0sUHonbruZh6tJfAxhEXV7URJ+1ytkccMSgFEMlSKNQ3DWEW7nkajO8b49i2z+rOmp7rlElmrKkY9Tu5Eg589yG/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3870.namprd12.prod.outlook.com (2603:10b6:208:166::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Wed, 17 Aug
 2022 20:35:14 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 20:35:14 +0000
Message-ID: <de9a3db9-6130-fe07-88ec-7e728ff5701c@nvidia.com>
Date:   Wed, 17 Aug 2022 13:35:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com> <87edxgvixy.fsf@nvdebian.thelocal>
 <Yvt/hZYfSvlCbU02@nvidia.com> <87wnb7tycb.fsf@nvdebian.thelocal>
 <YvzaXeRox/9fqfdW@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YvzaXeRox/9fqfdW@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0c0d8c7-347c-460d-cc87-08da808ffd6a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrxCu/VAWCeYEsVEVMpctjjHKtYK+FXP5z4nbkGHhaatgt+CLhIJXayjAYvpx0xcsvW8Xwxl90R5x5eR9GDXswhu40sJ6lKAD5kYJI6VNB4iJtyTWeEbw+0LFqziZJZkz/wSwSBDbevn+MYku0KmJtCbIV0hiXnGDJk9pWr7u0vQE8xlR1oZtC157op6yXmaQnAnk5V+f5DOurWcXY37tPi57P7052uT+NWB5YEj2Q1KjUMK3gA+j2DoGXXkmpldRimCJrFUW09fJHOBwMEbJUSGW/Cr1yrOPW3+Wo6ibZ5OriBmmX7qBWwF6zS8Sy1Yy+mKKqX31h3dtHm3OnZIk4tA0r5fUIUxdrYWG27IMxDrd9Hnvpd+gpFxPjlJ2Frcx4nngL/QO+eXtU6Seaypm1Hc1M6pVThQmc7xWuxe1CWuCBPdFcJEesCZhAopcRxRoMSu/LYjTOOCSoh2IVlX9JEm9sYF7wPQuLnLNt1i2XmH9GKW5jnKVSIolzVnAnQuD2FG+KbTT4udoiBX4y1jc+gSANwwis/hJQBEaRCMVFumSfwPcYhYxC6kTTsZ+6yCgzp1YdlsJdjwxHda/XCr5AZduwNhkdo5xYYPaniThsF6nSy9sk4slhGFbwQru+ibK6FOZoGTUKxYEFRNaASVnZFGQY3pq2PX2RBiGbZH31OlPKZYD+66OZmsvGFSR2GHKoJrGCMvoOv7s5ocuteQ0Y+s3g1JALOtFAXYtuiEqtsUZnj8nzdFfe12QHwDqChMhG1TzfcO+Hw8vX7lH0mwXXSU6ZZE0agdA2+Ryr4Q4v8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(186003)(31686004)(86362001)(2906002)(6506007)(53546011)(478600001)(31696002)(2616005)(26005)(36756003)(6512007)(6486002)(41300700001)(83380400001)(6636002)(5660300002)(316002)(54906003)(110136005)(66476007)(66556008)(8676002)(66946007)(4326008)(38100700002)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJtTUdxNWpEclJQWFJoZE9NZDZXSzBzZjhxSmZ2aHk1dk5TcmUxZnNzcnJD?=
 =?utf-8?B?Q1QveTUzWGZXOFl1R3daMDdVVWJVOVlmWXphbkhraHhtNzUwblVqOUhIZmFa?=
 =?utf-8?B?Y0JOcU5ZN2FxcExJYU5Gc2JiQUZhRTdrRkxHelFiTWJaYitaVnhhOHUrZE41?=
 =?utf-8?B?K1A1aVF1TXhPVjk5a05HbGxBT1V2TG16T2JwRjVmVllrOTIyc056SEtrZXc0?=
 =?utf-8?B?MEtlNER3REgyQ3ZYQklWSGFNQW1peEswaDdqOGNib1ZLS3ZaSUZrc2JIb3RY?=
 =?utf-8?B?dUdMbzVMSnBzZVYrM0lZZEZ1MERLUVhITmNwTkhNakFPK3ZubUFXTDdJOUxx?=
 =?utf-8?B?M2h5QUNCdzE4bEFIWm9YZkFiODRCRjNKUXN1SkpLUEhoKzlqWUJFYmJ4dmZz?=
 =?utf-8?B?cEVWMTdkWmM5T3NsZEx1MTlTTnRpMEhUMCtzcjRNRUljSjkwc04wa0dMbzI3?=
 =?utf-8?B?QjUzNDVLWXE4NkZNUWp4T1FyR3hZNzB3U29GYjY3bEZ3UGU1cTVwb3FiRzc4?=
 =?utf-8?B?R3RIeUFPUmtNNUdKTVA2SXBYWFNLR050NUFGV1VyNXVRN1NlWFZWNm9JbTdL?=
 =?utf-8?B?andDWVZGVXlRM2hydnZCZEJnK1hoSXpNcmZxTFRUclVJNkd3YnhJTUtocllQ?=
 =?utf-8?B?N0x4cGNKc2VCTHRjZnJIaHpZSUJtMkdCUS9qUTFZTWNCVXVsVW1MV0RSTE5V?=
 =?utf-8?B?VGN4ZldKWlMrelpEQ0ozN1drUUNwRDdWZjVzdXYycTdSSmNOVTgrc2lzQnN3?=
 =?utf-8?B?L1Y3VS9jRU5oYzVEZ25sTWJkVENXUnhRQnExM3MydFZjN1hnVUczY0drRkJC?=
 =?utf-8?B?VG9CaXVkWjlwUVhmZExSdzVTRll5SkZxdEQ5SGRWanVaVUg3T2xkQm5URmgy?=
 =?utf-8?B?b1BrYkVMckFlVlkrdlg2bXVLZ1JYTU5FOFBRZW1WTkl0T25YM0l0bkdIMDda?=
 =?utf-8?B?Q3hqU0ZlSXZHazk0QTZSQ1FKVTZwMVdkNmxKMm00ay9ZSS9IOUF4bmU3VVdV?=
 =?utf-8?B?S2VZb2FZMkFxa0g0YUQwaitQK2RPUmtLbVlnd2oxNmN6Rk1lYktJNDVBV2tG?=
 =?utf-8?B?UitoMjB3eDdPYVNIcFJjcjZiYXVKRGN5bHpra0dXMEVXUldaMnRQazNnWUUv?=
 =?utf-8?B?cHQrWm82Ny9rTlBKNGdVcVBwQzRBSGFQdW9OcFFEbTZ4M1ZyWUNwb0d2cmFX?=
 =?utf-8?B?TWMrS0xiSUtyMHcwa1BlT0ZqdFJOQUZVQmxLb0pGRW9FeVZHVmdyRUJTR2pW?=
 =?utf-8?B?YklLQXhHdlNYS3ZNenZLZndBUng3dDE5dUJWMzVnckQxM1VYL1AxYXNyRXRp?=
 =?utf-8?B?MzBIME8yTnQ0MWx4WjcxeDBDNXRQTHpBMnNvUUs1Zk5BV0UybzVic3IyZmFL?=
 =?utf-8?B?Qi8yc3hpQ3pMR0ZSUE9BTEp0eXoyZmNwZGFza3VWUUZXdGRjTW9RS0NxMmdT?=
 =?utf-8?B?b2hWbVQ1V1VpVHdlM3hsM1Q3bHdiQkVibFh2UmhnYlZWT0pxQVB6ZjFzbDBZ?=
 =?utf-8?B?WGVQODRNVHY1dDQrdVdFK3Y5R2dVd2lqSDl3T1hJcHk3d1cvNnIzcVdUbnRH?=
 =?utf-8?B?UmRGQjVwZkJ2alZOSDFpUFNSY1BJNEsydklrYnMrajdmUXo5VVF0MjFkc0tp?=
 =?utf-8?B?RXZVS2hOZmZPSEVrNzBXQytGL1FjdkJTNyt0WFB3Nlhqc2RQWnJrSWdHRnZm?=
 =?utf-8?B?aWR6Qkt4d0JCTU9IaFNaa1VKcGt6SWN6N085VDBXVE1McTFrdkd6dmoyNmFy?=
 =?utf-8?B?VHFkYVRyc0tSVGw3NERUSUhicXFXZlB2Z3hSQzZ4bGIrdzBCbFkrOFdLV3Bq?=
 =?utf-8?B?SkpOQXFvckpPK2VQSldYQ1dOYUp0bmRIRUhoUEtCS3JCeUt4M1RvWkF5WkpL?=
 =?utf-8?B?SUN4RGkxVWN0T1V4MEM1aC90MzJ0MWRLVnk1WDFyUGJpc3J5ejluRkJUR1Qw?=
 =?utf-8?B?c2NwSHZTUGRCczhCdTJuU0srdXB3eC9jZFF2ODBvdHZGeHpXbk5kSnhGYSsr?=
 =?utf-8?B?VFNGaUhUYVhuOWxLSVVxTnVodUxzMXd0d2tlTXFxU3lGTFB6S0gzYWRaWmVm?=
 =?utf-8?B?VlNUZkhidUlpcHlLOUR0WnVyNzF3bVRQRjdFVlp6OFdsbUU5N2ZQLzZHaFI3?=
 =?utf-8?Q?WW2+xlX7jfFjIUUUgqytArdgB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c0d8c7-347c-460d-cc87-08da808ffd6a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 20:35:14.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSMA8TZkIalG+FVcgjbLJHaZktr9yW7VUTCbn/d7rNmswqNF6Cyp75TalNN7JEBuZPvXcZeStYdcg3Rg5ADFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3870
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 05:09, Jason Gunthorpe wrote:
>>> if (!ret) == if (ret != 0)
>>
>> Huh? Unless I'm misinterpretting you or am really behind on coffee
>> if (!ret) is equivalent to if (ret == 0), not if (ret != 0).

Although the !ret idiom is a huge, huge part of kernel coding practice,
it also adds a slight bit of unnecessary mental translation (go ahead,
flame me hard, I know I'm asking for it...but...see above, after all.
Pixels have been spilt working through it).

And also...

> 
> Oh Dear, maybe I am still a bit jetlagged
> 
> Regardless, it is confusingly written :)
> 

...this is a slightly tricky and unusual error case, so it helps to be
extra clear by comparing against zero, and even adding a few short comments.

How's this look to you:

	collected = collect_longterm_unpinnable_pages(&movable_page_list,
						      nr_pages, pages);
	if (collected == 0)
		return 0;

	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
						pages);

	/* If we got here, we have some unpinnable pages... */

	if (ret == 0) {
		/*
		 * ...and we successfully migrated those pages. Which means that
		 * the caller should retry the operation now.
		 */
		ret = -EAGAIN;
	}

	return ret;


thanks,
-- 
John Hubbard
NVIDIA
