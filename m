Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D128F524480
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348065AbiELErv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbiELErR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:47:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA9A25293
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXZv76LUCkGliaHR14/VZ2pYHmVgMhopaSc4RiLmJYHnZ0WNM/FxTZvoPCjKZvtUwYZa/GwIdBiz+V1sneoyqYOTMZKa9Y5oTpwbd80yMQymcpSjq6ZPEg98TC64LpaqR6CVOwTCOJZmly/5QSpDebQI3CYfQT9okAfk0IeystCBgHUo8CkdhX1xRChydByNt+l3j5kDYtawry20qdaayEA/AwhFjDa1ul1Ko47d5W9X0pQVoBO/lqTn/eGEuHtFhSflQk65KvmRJc5AKc8161adZaOy4NIFVlYY8yz/QSw6qrAMLTF24tySCNgZc4Lu5+/UohbmAFSxfUlhIH6ZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SbPOoBNqWTe++Win2aQ9kXWihGjhvlIaJy9Cp0yncE=;
 b=mA1QABFodQc/+UNnhobEFUsc5E9YGjXXVZ+lBLErchfvMhCfT8rhbEGA++kZqZyfxrm1EL47ridDt0ltX5w/TElYLUgjr5/yY2Y0VWn/0x7kpyPT9hiIZvglEUj5xQ6+fXITfhTUmfTDK6ZLiNU6oB7JPw50p1TtncZAT/g3vXpFmETIfC0j3VaCP1/SUeZ0k4SdxDNYwVpOskAAdohkMo7eamDtvvnXsl8bVpLkaSmj3k/vSAFvSMh99k1RZvZ+MzPlr3wUAltpXvqBuQ6xF7aSrMuGz3PJFaDfpFB6xPB5mae3x/iUayciWJFV784hpLljLuNCkzQMvgSAkNqU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SbPOoBNqWTe++Win2aQ9kXWihGjhvlIaJy9Cp0yncE=;
 b=trG/oiNdY5LYfZnbzVOuSFXdinBXF8YzVEdpzwQGhP5hWHlTc6UnNlfsgHUZgtxmMl9BT7QoWO2eT1KfP2TzOufi0uSH3pIU/L/WpWSpT8/3iPXFIqfiyo7Yu4HNkZlnzAWDoRyY7L0lqbpPK5KrF/Xypo6hy71k7VPlUy0ke9tOh1YL6xSDFdaZQustLITWslTwPBbPa3Hdfa2Txu0R+ISgB/vl2hvPNi/1hZgoM2IylCZv8yychp4DCsowQhXpO8ihQWtpNmDigvr45RRztYv001nopLaEOEig5KSioheKM2a0l765N0/FzCtAfoW7quuruYRrPwjqifwU4+oPWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 04:47:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 04:47:15 +0000
Message-ID: <4eea4f5a-0d29-75f3-b93c-fdcb57b4cb8f@nvidia.com>
Date:   Wed, 11 May 2022 21:47:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YnyCqwY4DxcZ/NjM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cc6a73a-6abb-4980-2651-08da33d27cb5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB421745146453DC4026AA1834A8CB9@DM6PR12MB4217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWCg9wVDYcNfNsgRaw3ibd9NWJ0czuU8imNUz1cdmyipp+c5SouOUUd6JA3wqpTTy1b0IXJPZFQqpw14rMzHhU1OHMyyEcb+32ZbWcRYysfT1T7dbbU8QYCq/eXw7DLzSF/Jiu0vERiSGaudUxbMdXYq1EwwVxavQcky4hDwABqM/VsERJQfMW4f984O6tODelWtb2kgLhOLDF9KbJ7+h3tmw5F9zmrUy/pmY3p0jTMMCgWvKV+Sxj7eFSr9bGJHYnCyv+MAD+dP13TCOoff37/jHvxiL2vGraCTLAr4dNn5EE0JQt6+LfXv1aYuT8n7CIzafRhQ5DUqE/jXUqhotbhwu1gPDfymc6MX+dmOL2eCP4mndBX7+9dUTqBQP8Ehfdam5bqb4nDdh3ap9D9DXknBXDK3K0gkHW6PaRnO0lZiUxNDoUC6mD4TUk0xvbqoceqSjWyYHhSxLXnCk/4JmPOaOnkzmcaXd3L2IG24yB9F7A441R2rvAivPMCrdFZk2b5ufWKHUQ10udvYp62IimgFBY7k+l8z1nYiOnHDfKlddhqxqgfdforUL0BJW2BDD42QpTUz1J1yKqDDNaLNL9BOHV7kXmd1wrbMkuxuuyGg4ORPnhiPIqyZ21f+YtpjiAzWMn86umgaQ3/00kj4iKOSA1GFFMKHB18N0b7HLmmb0Qr68VN8CQnucI42GHkR9vDV/KMVHl0i9Pi80XYJRselVrvLl8hq1Ai2BxicI6HD2Sal8PuC3H0qc4KNfEER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(31696002)(6486002)(8936002)(508600001)(53546011)(2906002)(4744005)(83380400001)(6512007)(38100700002)(5660300002)(2616005)(26005)(186003)(66476007)(66946007)(54906003)(66556008)(316002)(6916009)(31686004)(4326008)(36756003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldvM1JKdllqd0dsRVByYjFPYUEwU1RYSzZsUFlYMW4xWndFSzFlbkpyTXVY?=
 =?utf-8?B?Q0ZrMXdJbUFFZVg0cURaUlY5c0lkeExFRnVWR1VXTnVFUHpFWk1xdkV6OUJR?=
 =?utf-8?B?eUZHaDVtcHJuVVljbXpEZm5CL3Jhb2tMZEVDV24rTkVVQmVaVWdwaVVsT1M5?=
 =?utf-8?B?Q0ZpVmcvcSt2TjN5NnR0K1R4WTFmWGxVNHJOYi9KNFVhY2RXU1NScGxoeWpJ?=
 =?utf-8?B?dWRrN0RPVXhHRHIzWlRKWjU3MU9WUyt5TCtkZ2dHOGxvQzk3NEozSkNuL0c3?=
 =?utf-8?B?NDZRSVVZMzYwT0ZrL2thY0NMcloxb3NaM2tldHJhaGZBRTVZZFJSTXA0OE5j?=
 =?utf-8?B?SFBjcHBnaWp0cjJPQ0NvWW5YT2Y2ZnY4ZW5wSUNKa0ZYUHArYlNraVoyUTRp?=
 =?utf-8?B?NDVVZ0VXc1E2OUNtcnh3MHdCQUY2WURYNEtnSzE1Zk1SVG9TcTZ1bjB1bEtj?=
 =?utf-8?B?NjlwS2JIdWM1ZkJ5bTB0OWFWaDB5aGQ0NzlQQys2Z1VadVpjQW1KbFBaL0RZ?=
 =?utf-8?B?VjVoc0puYng4N1FSZ1ZWdWtUTVAvK0hlRWlPMTh4eG1jbytucDVneFZKcEpP?=
 =?utf-8?B?WkREeHEvVmEzSnF4UDJOMUlTREtTMHVOOENEZ1psazRFNVpLUlZRNk9KQUFx?=
 =?utf-8?B?Vno2TTNIa3ZHVXdIWklhS3pYUExKKzc4eWMzMXBkOFJ0MlA2dU9JQWtNQk5T?=
 =?utf-8?B?MlVtaGw3YnRtNmpxanlKQU9UUE15eHBxNzAzMnA5cG9xYmxrU1NpQTR0dW9s?=
 =?utf-8?B?MFl1MUs4NzBPYUhTYS9mY1NIa0Rka0lKbDE4c2lNaktLMTNZMzVkbDhBVklt?=
 =?utf-8?B?MVl2VGpJQVVmRkxPaG9zTzQxVjRVY2NnQWN0UTZNem8yM1BDb2Q3YVFJbm5l?=
 =?utf-8?B?S3ZPWGtUWng4WmpsQ3J1cElNdnF2VitSRTM3QzF1c2N3TCtERCtzTVovWWFB?=
 =?utf-8?B?RVhnbk5sNUZKTkZ5ZWxrQTZIUzVvNDVhWk91aFJEbFNTSEJEL0hKMmgrM29z?=
 =?utf-8?B?NkhRQy9VUHkvY09YR0FVakcyWFlRd0FtSXo1dFR2Wis1Z1FweG15LzlLc21N?=
 =?utf-8?B?TnlDL1d6N1owMFBtUnhVQkFUWDNjMzI1UFpmWldRbGg5TFR2c3daQ05CMGRK?=
 =?utf-8?B?TlYxK3htcCtCWlN2bFNMeHlpQ3ZVNkFNZ05td0psR0FNMzdJZUh2amhocEZz?=
 =?utf-8?B?cEdaMHFvU1RiblhxUWJiL2c5VGNMQXBNdUw2MGMvdElRc0FLcXdidjFrVmlp?=
 =?utf-8?B?VVpENWlRNG1uZjFmOElWQkNUeWpXaG14M2NOV1M2TzJCaHNzS1FGS0N4TG1U?=
 =?utf-8?B?UWpkWEZOZTJsdkpsdlM2RG9QK3gxenI4czVkcFZ2UHVyUlYwOENlaVhFQWpy?=
 =?utf-8?B?NHZERS9zWlQ3VGVFUXBLTlgyeklzZHdsYmQ4VlhlUGV6Q25FOEQycE4xOWNT?=
 =?utf-8?B?M05uYUtBWmNSenZTYXFqclFTYzZXODdJeUFaVEpvb2lzTll6dEsyZlNPWGlM?=
 =?utf-8?B?NzRSRTNiSUY4M3ZiaUlDTHB4RERCbTNYek85UG96TGlpMDg5cndGQnBoY2cr?=
 =?utf-8?B?SXpoMk9GVHRpaFYyWU5YUktvcG5EOTZWY1FMcWFSTWU5TWpmV2QySDY3UVpC?=
 =?utf-8?B?VHlKa2t0TlpVeXlDTllrZjFxMFJKY2JQWVlrd3YyZGpyMk9US1hzUHo4dStD?=
 =?utf-8?B?QzdSNlRFT1BZSkhCY25lRjAvOTh1eUh5VDdpZjhDcHZqdnRqQzRKMnZoVk9D?=
 =?utf-8?B?c1RUdEdxOVNTN3RXaXV6SUlXZTJOalZIOW9KZVJhWlVuTUNhdENlYytuRGVT?=
 =?utf-8?B?Y1d1dXZ4ZGo2ditETzJteCtrT1NBYVNrbHNDSlZtMDkra3BFa0lzSTZwQXVS?=
 =?utf-8?B?UllKWjdyNVNrUU9vQ0NwWUpibmJLYkpPSnU0M0xPanNtWk9rczYzUTNrOEZP?=
 =?utf-8?B?SnpVTHRQZ2VuYkxNTU85Q1huWE5tUVlub0hlMWwxd1BOYkFReUlaWk5yNndB?=
 =?utf-8?B?YXNyRkszb2JYS3NnZDhOR0I1d3BsT204UnNBdFVmNHJwVUQzZlJ0WnBxYlJm?=
 =?utf-8?B?S1BFK29rTGhBa1ZDM1hYaVltNXJydlBuTzdEbEhmSXJSNm1WQSs3c0NnWXhx?=
 =?utf-8?B?ZFdiZHdZZjREVjVmaGFZNU5XV0VZMXgrUGNzMkZCOXBaRm54Nzk0aU9uNGta?=
 =?utf-8?B?Sis1ak1uVWhYaVJRalRuM2IzTjVYa1JaTzgvMTRVYlliRTJQbzRYUm1vTDRT?=
 =?utf-8?B?dWoxR21jSkNJZWlSZm80eGZObWhES2lOQ3VvMlM5OVZnM3BNMEdXbXROajEr?=
 =?utf-8?B?Z1NpMXFBR2JVcnVNSzJZM25ubGtKSXhCbmpuNU5wUlNuc1BiUWtMb0VDNzhO?=
 =?utf-8?Q?GYwu9gCj2NTod4VM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc6a73a-6abb-4980-2651-08da33d27cb5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 04:47:15.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruWg9B3WohPSHnIHmIdasf154vugYcGuRpzcyNsswujDakXUhNcePBqojX516e81ORnnhfMYwD4tx+c0v2MBiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 20:44, Minchan Kim wrote:
> Thanks for checking, John.
> 
> I don't want to have the READ_ONCE in __get_pfnblock_flags_mask
> atm even though it's an extra memory dereference for specific
> architecutre and specific compiler unless other callsites *do*
> need it.
> 
> We choose the choice(i.e., having __READ_ONCE in is_pinanble_
> page) for *potential* cases(e.g., aggressive LTO for future)
> and if it's an extra memory dereference atm, it would be multiple
> instructions *potentailly* as having more change or different
> compiler and/or arches now or later. It's out of scope in
> this patch.

Agreed!


thanks,
-- 
John Hubbard
NVIDIA
