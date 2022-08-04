Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1782558A3C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbiHDXHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiHDXHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:07:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A28F101F9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 16:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c99mq13Om/V78Gu84wJnzs+aqJqbhkjHX00Xpi1CXBgO33HfHnBz9o3GCjfV4Advrf9qBHrdBCbOA9n1HakHOwKo/ArP76Rs7MxjjOHMEbCxD6iEuXQsl46n7Tkcn6BKG0/rQK6jcIRJ5jITaOQOgTwTKcgqsp67/1lW6wWvCUCYY9R4c/rviIWJ6Xo/qcdx9VBJ82xNVP5ggF7B/BekSKeu5Q0KQJ271K52WHJ3EbbnCjwvDjlUk4qKEc6a2RZxWwNS6dnkUZ7i6EMx8UPp78pRule/CnjZLNYytxFQddJzcbOZ/+uTN3FL2rKw+Y2ZjZjJEBsMJsk2LU+Fcm1Emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0Pmop7LwqhKRr4IdKIT/wx0yeiKpn6Qujr0PcaYYpo=;
 b=Fl8sY3NoO8PsyvAHOWKQ7M/BDdemrbvrOj+2gei1skOQXBTv/q8zMmPyLQA0/PEDRfAfPGByEG7tUybPErs3pk1F1cL/6mH/Odyd0Q8toSk+ijtJiNWFVnFNP2Hw3vBArCGcUnbxvJ7zIO7naTGy0iNWHD7AmBz261/smmFrTtqA1txlXnyxzy0FsIyHI/1QxSBHrAfUTF8llTbzamtzwEQDyqm7AH3m+5NEZYmCiRnzimndRyLqhP5Cy4jHeCBkMDpBNqogaCMSMeEEFnC8stT4xIzBwtwh++p1r5Ze5Cwuj+k32kHqaOOryldrA6kyuJOYE7utBUMXvCvsW4uBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0Pmop7LwqhKRr4IdKIT/wx0yeiKpn6Qujr0PcaYYpo=;
 b=NeugPlrRX3iZBYFw57bw/sI5FQpFl9/chiAppfoj1ThbbUD/Nl9igPBvTckTkWw9wRPFvlg/vNnMyFpswR0jbMCogra+bJ28nil79MrOeH4YxbJRcWJl/xNlDD1hSLlXDCBAkkS0E+ZKbCKxCDYrw3gGwlpbC2CDX8tMg/npxapMGl9DW5oZCR/EO59f0HOI52Ce867GsSIv4JOlwbyt7+DUApIJFlsUiAP8CNkTN9gWi3kdGHDdjud9K9UjKUueECgKCM/8NpX/s5YEQPifxJkXI1X6xO+6s4gltiuzwcdYPsJzuiaTsP67OZeATaRnbAvI5+ib6xFmxANIKiY/Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL0PR12MB2354.namprd12.prod.outlook.com (2603:10b6:207:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 23:07:00 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 23:07:00 +0000
Message-ID: <d833eb25-fd25-0211-2031-f3b4a5215139@nvidia.com>
Date:   Thu, 4 Aug 2022 16:06:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/gup.c: Refactor check_and_migrate_movable_pages()
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20220804032241.859891-1-apopple@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220804032241.859891-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f787fa18-77cd-4ea3-7a1f-08da766e091c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhZ+u5KybOdE/eVlhfuahi26t1CIOD4XLR8HX1XkSevdu2+UE9sIpfStNumymj4briwcCs624PIVmNtszUDF13tTDtNEVXalWOFiiK36++4cqsqjyD8KI6Xm8Fo05dvoIliQvrDfM0kIUV61OuBQcK48zsy2wz8YQniFFJ7UtV2wzdlAeeGPasZWIyYESKOsnaybL51eQ+Ta8bz6oZpftCTBTV4HWxnhEhIenZhyn88VYOssgrE4txkaj3uz1uXW2I6ndAydea347nvR0Ny0u0VaGXgB+en/HQUCQfbYVIMiJ/UvHpKyjbLq/AO0Zjxmi7nLu7qpS0AaAwzJOlhaVQW7D0i6yqfGuaTVWlzkykEW/TL59Kd4DKvpKChouwfg/2jXDHkEoqqOUZ++nCgFJDXqJzGn1v9YwyjnIsXXgDTgQ6m8kIp3lCUW3v1RnKYfgsAkiQtlmYaVa/qkotQYXBlW5Hh4SFQVm/JQ5lxgHupjjEBJRu0EuL3eF82qQpSqIhlJHXka11PLUO3GsbK9Xep28q490N4BzZ3Rxr8SebtfTnbv3gJYCHszmUOnXEXdZCuCpJdWYfllm61D/pQa5bejsczDf6drM/8OuupsUTVGaCYski205gT6cNQuK/JcUxb5CkNYEyM/C36iLx0tDvuX+QDZc6abZa3vveF/kF+89huFOXiCZUP/uhkS88GFO50oEf/RsReQsRmfsrlqTI4rp7mKODGS2oKxbVn8ACNuRlpLIMFZaVSl0Xoh/vJq4uNGW4klZBShHFh5b5opifnKpRJJgbO2cuGm07JOSB2nDlItkdGgAlzqs2f48xfRY0FJJ8t1DUPYDRc5LvU93w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(53546011)(54906003)(186003)(41300700001)(86362001)(6512007)(6506007)(107886003)(6666004)(26005)(36756003)(316002)(2616005)(66556008)(66946007)(8676002)(4326008)(2906002)(478600001)(5660300002)(6486002)(7416002)(8936002)(31696002)(38100700002)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRrbzNHSmN2YjV0TjhLVXQ2R2cyZm12enRxMnRLUkpsejZtdW10V3pRbTRM?=
 =?utf-8?B?TnpKZDhrVC9HRGtnM042WG1tMlA4cW9kdmNESGRJQmwzRUk2dWZzMllhcExi?=
 =?utf-8?B?RmJaR3pSMUVaaWxUaWVIWTMrTGVGeWt0YlBmQWFTK3FDaTNFZjE4R0pKN1Vs?=
 =?utf-8?B?d2ZzVUtKTnNPazA5bythQ2s0dHRaTjgwcDk5NE5EalNFb2hTUG5YcmduSi9m?=
 =?utf-8?B?b1FCZTN6Lzl6b1hJYzVFeksyWHdzOTVFMzFvVmJoWWQyMVVpQVE5SHNkeUM3?=
 =?utf-8?B?aVZEeE84Smp4bWxFY3AxMjNFVmtYbmp6MVV5VjF0K1lsQWtDZ1l0ZEQ1cFVV?=
 =?utf-8?B?d2FWczRwallnbjRCQk5yRU9XeU8yVnNJMjBFL0doQWdBWU1ZMHBnQWh0aUdN?=
 =?utf-8?B?YU91K3Zyd09MejFDd2V1eDhDWDBVc0ZLdC9ieHZ5Q2phZ0toTmZhdFNMeHlC?=
 =?utf-8?B?V0RPeFRqOFRmREh6SnI2RUxCakQ2NzZmV1RQZ05wbExqYldzaVVOUmNSWUtI?=
 =?utf-8?B?cWZMcFpNSjBDUkZUS2NXR2dkZUNOaGs4NExRL0RjN1RKWWU1SmY4eUdacmdK?=
 =?utf-8?B?Y2VNeTVKdm1NRXFYb3cvd0xFNmZGRXUvVmNuaXh5aUdOTGNEWG43d0ljN0Vl?=
 =?utf-8?B?RUxHQm5PYzFiamNNUFdpV0o1eEY4azJnNVk5TTJTOERVd2x5SXRuc2ZXWXdj?=
 =?utf-8?B?WkVyVkswaW1RR1Q5NW9FVEZpK2pQL1dJT09kOFBmS2dhVkhFWHh0ZGdRZU9I?=
 =?utf-8?B?SEFJRjV2eEk0ZCtudGcrdUw2U0h5L2hoUGVEWmRKWkJpRkFsQklQSU83MkFm?=
 =?utf-8?B?TUpoeC8veFpLN1o3YVpkNEV0VkdjTk91RGZzSGt1R0N2Tmo2TkptVHZ6ZFNT?=
 =?utf-8?B?MEh1N3JPNUhlUFVFK0ovSlNmTCthbVRveFVrV1ROQm1talA0MENhamk0eXdr?=
 =?utf-8?B?OFRJS0w5b0JFWHBCOXJyU3U5aTl5ejE5Wk9Cb1N4ckdGVU9zbi9YTGpXa3lv?=
 =?utf-8?B?Q3g4UVhGVml5cUQ4b0RvbC9mWW14akVZWkhHdVptRDZ0VTZ5WEV5dlVJemhV?=
 =?utf-8?B?V1pPSDhaZmFxaC82OXc4bWJIZjVlUnFYUTZkRXc0TGlpNjk1RXRTM1ZPOWk4?=
 =?utf-8?B?eVZCVjB5Yi9xN3UzdlBaUDB6R2xKb2hWcEVHSnZKelFYZVZWQUFTazFyOHdt?=
 =?utf-8?B?MkkyKzlxdVFPcURrSFRJNnI1MUV3a2pKSGhXYUpweU9iZzg1dXBETkxhcnpT?=
 =?utf-8?B?MjJ1ZE1YbkhXNkFLTmRqRGcwYmF0RERuLzZvVGhVVnJaZVRjeFp5ZllUVmky?=
 =?utf-8?B?MlVxTWlLVTkzNFNYOUt0Mm91dE04VDZ2RERXNnlrRGtqMEZHY0VTbFp5Y2V1?=
 =?utf-8?B?SVQxVnk2SjZJMmJhdW9KVDBhMStET3NZYkJjcUhpbkJZaFNMMUM0WStsZWE3?=
 =?utf-8?B?dVhlLzhRclJXQjB1YmdValhuZ0JNTXhiTGV0VXFBd2pDRm93TkRtV3VrbjBq?=
 =?utf-8?B?NEovUFdTaWQ4RXo2VU1qWURUN3QyMlJ4Qmdzc21MZFNvclE0Vnh0YUtWemls?=
 =?utf-8?B?bUJGelh1TktxTzRhUTZYQ0hVRnd1WWZDSzZhMFR3Z0pxS3U2aU1rZEJXWU5p?=
 =?utf-8?B?KzJDVk1mYWp5M3RKZDAvdjFsV21TZm9vSDdjTjBYNkJha2ppZ2MvRkdmcStB?=
 =?utf-8?B?OWFMaGtTQ3VIK0VXVy9hRUNYSEZnYkxRVUxyeWJSUVN1NUx3eWVLUjlBNSt1?=
 =?utf-8?B?WDRTK3dNMENOUmRnclZGb21QWENEbVM1UDFNN1NDK0VRQjVqRjhVTk9iYkl0?=
 =?utf-8?B?SFFNM25nTGF1T0YvUFFkT1ZTSWRlYjRGeWJGdHhSSVh4NVl5YTBpTGhwTEtG?=
 =?utf-8?B?b1BQOC9mZVVsLy9TazdUT3YzT2hNUTB1WTZ4QW15MHU4djRWb1dSYzhxaEhy?=
 =?utf-8?B?VjJrUnRpK25vanBMKzBCZXpPZTFYRmVwK0V0QzJYVzBCWVFFeks4WjF6cTl1?=
 =?utf-8?B?MERsSHNJY3AzdVc4VElROFV1M0g0K3F3LytzS3dtSnJ5anh4Q05vOE13b3BQ?=
 =?utf-8?B?NHU2SElPV0R6ZVJiVFh3aGdmSjJrRzlTb3BhTkJuY1VLd3hNSUQwRmorZ3BE?=
 =?utf-8?Q?dHi9Mm7ER743F/W3/hh/hhA+7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f787fa18-77cd-4ea3-7a1f-08da766e091c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 23:07:00.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYz0RHwfK6iCFY6Kv0AaqBDuVovlfGXcGBltQXViqNJLdFslAwHrEGX5/0tFhANEqaNUwrKcVltV1KVJ350+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 20:22, Alistair Popple wrote:
> @@ -1970,29 +1968,25 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>   			drain_allow = false;
>   		}
>   
> -		if (folio_isolate_lru(folio)) {
> -			isolation_error_count++;
> +		if (folio_isolate_lru(folio))
>   			continue;
> -		}
> +
>   		list_add_tail(&folio->lru, &movable_page_list);
>   		node_stat_mod_folio(folio,
>   				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
>   				    folio_nr_pages(folio));
>   	}
>   
> -	if (!list_empty(&movable_page_list) || isolation_error_count ||
> -	    coherent_pages)
> -		goto unpin_pages;
> -
>   	/*
> -	 * If list is empty, and no isolation errors, means that all pages are
> -	 * in the correct zone.
> +	 * All pages are still pinned and in the correct zone.
>   	 */
> -	return nr_pages;
> +	if (list_empty(&movable_page_list) && !coherent_pages)
> +		return 0;
>   

At this point, a second part of the (rather long) routine begins. If I
were refactoring this, I'd split it into a top level routine that calls
the two parts:

check_and_migrate_movable_pages()
	collect_migration_candidates()
	unpin_and_migrate_pages()

...which I think would further help in working with this thing.

(I realize that this is additional work. And that it's best done as a
separate patch. And it's just a suggestion.)

> -unpin_pages:
>   	/*
> -	 * pages[i] might be NULL if any device coherent pages were found.
> +	 * Unpin all pages. If device coherent pages were found
> +	 * migrate_deivce_coherent_page() will have already dropped the pin and

"migrate_device_coherent_page()"


thanks,
-- 
John Hubbard
NVIDIA
