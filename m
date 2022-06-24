Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B25597E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiFXKcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFXKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:32:20 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF347C523;
        Fri, 24 Jun 2022 03:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqHddVnMaz5u1ylaYLsy9KCdZWQGKPL95MX+f1S5WNz+PAgrON5iXD/E2VT9JVw7hnUiy5X2MVORh7fq+RTynmSOcghJti0Fd102pZX0rMPRrmQLxKOpusIWxwR3EHBL74ttd4w5j79S8DKpNozMSOFTkkPMgKDGvZcXEoXaLRMmmXPnvCYYsJO/DiMiMKodNT3KhIivQDdE39C+XS97cK2fleFP+PU3U76W9BaClYUvYO53x6P56ZGieqWLwoanT/nHjlnwyqrsChxAAmO9c4V3ruhRHq/X+jORiTi0IEDUUpnaRU0H1fTJxljXKeWJJyOJbxt5pP+EHoUlI5VuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9NpJoz+mN796Wld6wkrNNcg2b8DywddivOHbaZA/G4=;
 b=Oz4XduLNZb6xUm9FfqGpi5Raan9ZlrEAPi1o4ddl+FFKXHRHeoR6hs6R5ZECEjHNnQXIxbvYlrpjoFsb6emEg7wlQySSz/+L4ixHsxiJ79MiNIv5z1r7HyA8NXvSSUV/Cgb83aqj6iyJDG/aF+ebJ5twVpPzRVf+g0fqbGt2tzbx9XVNYAm8/sKiSvvruaF5zxftS5S2ujiecEa3OyzJFmx8uw3Zv8qQEW7F3dwgWGHH+yhEs+COHQcQr5FtyRleXdbgRNmAX7/iKgSCkgLTR3a3ReKJgjLJteyL3TNu/9X5lO7DsZOQxK9ZU7HpR1foh18BFA4uRWRYUEOEA+AFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9NpJoz+mN796Wld6wkrNNcg2b8DywddivOHbaZA/G4=;
 b=nkR9nrGLjumv57gFHtmiPexWfUM4HzTRNRfrTeLhIZLlaoFUvDjMrXo2nTjXrPchd3+haSEW/TVJgoL22rGakSjYdwYM4xbDW4c+FekbgZiXAig2nWUtXHf9gF03Uf4mysSCxzY237tsyP191P14T56a7gUMy2Lt2w/zqRbHfn3Phz4tf508Q8MMxa8s7G88SmQcOemSO5Gkly8/XdP6ZrYcLKed2yZFS9Vdb2nUvRR2daQ6hWYA9ZTctqvgHJJbhfS1Xt6AQdJfLSkCreKJ3O933qYwfCIm6Jz7UIalKV+qE5EJaWWzA6s9PM9MakgF11D2td3vZZEdIW7LQW3/Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BN6PR1201MB2544.namprd12.prod.outlook.com (2603:10b6:404:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 10:32:18 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 10:32:18 +0000
Message-ID: <569eae9e-d14c-6736-3cee-9e7ba75da0b7@nvidia.com>
Date:   Fri, 24 Jun 2022 11:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 21/31] soc/tegra: Remove the call to
 devm_pm_opp_set_clkname()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <1e88b248352afe03cd3bf0e887b1f2be86b5afb5.1653564321.git.viresh.kumar@linaro.org>
 <12c085af-1202-95cf-e9ad-ddcfbdadf0d6@nvidia.com>
 <20220624002805.anv62ufihdrncwus@vireshk-i7>
 <20220624005913.ytsskavsaxt4rzzm@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220624005913.ytsskavsaxt4rzzm@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b10cb127-71b8-4656-18a5-08da55ccd010
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2544:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GE5r9ojKnyYkhin7Dzq1zOJ+Bb3fbOlUMODZzrn+lJ28SK8pZ+8iwwH4gEwAufIRBk7c7xuQiexiHFTcCREaanh0/ii4y2H+MduDskbT9+Rco9U3Dnu+VqGTPTo6RqGfiHlCrfqZW70NawuJb34jE2bl8bfKUw9WtChhG0UDWUjHwQFoa17z2MOx3hTRKahEaUHFuQiyyQNvgLWsLz9hBkH0Ptoyskzdy+bfXYMMzDakUBIWBNnzpR+2EBJSCrBijMj8JXIsopVqlqDfipS5Ssty3M1/ja2hnr0xB0+YBTperl69VuQzXHL7XpixG2AeYT8g25muAJqY4jhkhkAEe6iIXrc1J+eUWhwIsOzHMGdhYypdrxdAfyVwd1TxDygmjtcLoMSxyxtrmnSyFhiWX5tTHhOoD1nW1iAnQmMval6F8PHRxgXMePiVrZuTRngl++kQyzjhI1C7UeM8ZJLfzaI43/XTlOV+s4nI0pjDbdEkzewy5A9JpNQh9otRER28v8G1+s9pP1toQ70YWcj9di1b0j9Vn8ABIOt2YwiYXOHfmdV/bF5lUtHGhu2ba9Mqt44+qFhXoXr4ZUOevlZl+g0MBPsCAnx3QxEOUyhBdr+pRvEh+M4LfwJqEfZDT7QEuZVGUEBG9/SBnXEkA0+6Vez/1nkLHRe6UO1fMBmYrebrmSaTZD0yNpQ/ah1PPJIFYe11eYbjUYEeTeZG7Dd5UVtppGDK3qTfScYf4jBauZuea/gWhMqhSvAKDa+XjmOIlt1u+2D/g0Rgpe0cmOf3/lNe01PrS8EadbGzVvsJDQoe1y4sBiKXZiKXSXE8zdCrOAcW4fMQGxSy3OGrt97z/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(4744005)(7416002)(110136005)(66476007)(2906002)(31686004)(36756003)(41300700001)(54906003)(478600001)(55236004)(6506007)(6512007)(6486002)(4326008)(66946007)(66556008)(8936002)(8676002)(5660300002)(316002)(6666004)(38100700002)(86362001)(83380400001)(2616005)(186003)(31696002)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVN0QjR6eVNhc2hVVHZvOS9XenRqZE16UGZyWm5OTzNGaHArWkZvMThSVEZx?=
 =?utf-8?B?U3NUalcwMldCYmUrSkF2a3ZzbDFJazJDV1huV293UHZDNGdSUFhYdGdUZUln?=
 =?utf-8?B?cElOSU5zd1BiWUVYMHJzbmhoRWRkcGtoWHI2MzFJNnE4TW95SEg4T3Q3eW5u?=
 =?utf-8?B?R3orQzlXZStDdjFiTi9hOWFncXZOOUlOdC9yYzNHQ3NVeGM2dTFvd1c0QWdx?=
 =?utf-8?B?TFNTMjVzZG14TkRNS05XRzA5Z29KWkFndFg0Ny9xMWtEeC9EWkI0SUtGekha?=
 =?utf-8?B?V2xXekFub2lGMXVESHRnUjBYWW54QzRnMGFsRmlCeVFoWGc2THpNdkJHOGZr?=
 =?utf-8?B?YVNkaEJGbGhCV2k0RVNkbitpUkQyL0lORGoxL25ON1UzT2JFR1NTUXJtUkxM?=
 =?utf-8?B?WXRHK1VyOGxrZ2pOUnZYRXozT3FBbHpsNUJVZEN3ZHVmZUowZFJyYWtmdXhR?=
 =?utf-8?B?TVpqU0xvdDRTaFB2bFN4ZFROMXJZSE9qRzdEUndrSEZ4TXhhQzM5VHlBbXRq?=
 =?utf-8?B?NHBQdXRFdktsZ1Axa3ZrR2hkZ20vR3hwcEpHUk9BWFF3VHkzZEhvTVptd09R?=
 =?utf-8?B?U0tiVTF4akNDSzAxNjhMMnhXQjRPejlZR3psNTNhdVhhejZrbEJxZ1RVQ0U2?=
 =?utf-8?B?eTg2WXlxK1lRZHM3SCtQcDVWcVRybVFBVUxaMkR6SGIzY082VHAwU2xYMVMv?=
 =?utf-8?B?TDBNeWJ0Wi90MURLaTVqZVpPVDNBejFJSEl6RUNaK0cySHdVVGdiRDR1VDVW?=
 =?utf-8?B?UVUxL0tnRC94Nm9ER3E1T1JkVWlnajZCamRKaXpxeUZqMmxvTlJLeFI5cDgz?=
 =?utf-8?B?ZG9jdmIrRUJwNzdBSWIyZXk0Vzd5eWVNaVN2K0J4YmdKdzZISkRHcFZJekUz?=
 =?utf-8?B?Q0RwMGVWVzV2S2NQVVkydmdPd1liakpIVUl4b3BsWXdFcUN1aW5SeTBnQ0I0?=
 =?utf-8?B?R0FMWmxkSG0xVGd5RnJiWVBqNzBCZ01LY3NDMGNQZ2lseXJWbG0zNE1rVzAy?=
 =?utf-8?B?TjFZRWhtSVdGaTZ0Q2E1L09Ja1ByTE1FUlpwSGRVVy9taW85QWNoSFdSTFNL?=
 =?utf-8?B?MHY0VDhMQy9sV2JFeFJzenpEdU5iZE5kZXlEa1kwa05hSzlQQ1pOVVVLdlBt?=
 =?utf-8?B?SGF6MUtncVIweXlTNWt4UDVHZ1IyRVFoNlZNOG1ab2ZRRkU4TTgxUjkrdSt0?=
 =?utf-8?B?UmxhQVBaMHE0NHN0M3JwYkRyQWxJc1BYcU1BYkFBS0FMSWVOTHQxd3gvUWVa?=
 =?utf-8?B?UEZJWDB3NmNJZ0ppdjY3bTVzREloMGZqTDdESjA0TmxzOVpueGdLanMwWmxY?=
 =?utf-8?B?UkxtVWd4QWE4K2hROXViajRuTlFiWVpqN2tMM2NvajRVV05qODdzNUQ2cnpV?=
 =?utf-8?B?NWZhQkVDaDVjM24wNjJqdmhOYVVJWVIxVStwRXlnd2ZVNHRUemM2OVNFMFZL?=
 =?utf-8?B?dHdYcDB5aVQ5aDNnS0tWUmFXTUFoR0tETi91M2JMem5GclpmU1RSUWJqTmFZ?=
 =?utf-8?B?R3ZpSTFROVVmTTk2VSt4ZDM5QTBDbzJhK21rdGpmVGlLNnpHQkNpejNVTkVx?=
 =?utf-8?B?ODZzdFQ4YTdHUkhzbkZ1Y1lpQklBcms4Vmg3NzFtenJ3d0JJUkFiQXpYVHB2?=
 =?utf-8?B?cE9ZdE5oeHQrMnFSazdDTTcvRThFbWVkV3pXcTZRc1g2WjZFNDdkUzBvazRk?=
 =?utf-8?B?UFdScFFRK3ZJMDFVcWY5ZmNVaHo0UjY2YnBQbm14RTgzWHpudmNWTVNtVnRG?=
 =?utf-8?B?dzB5bEs3bWtLbjBVL1FKb1U1a21EWTZSdFk2Y0RLTlpzWXpnNmpMdWpQYzBO?=
 =?utf-8?B?aXh4a1dyZUh6NnZPN1VwVEFjaVkvbVhSQlJ4aS9UUC9YY0Zzajh1dkdiTzQx?=
 =?utf-8?B?L2hpZ0dQakJKM3YvOXJLWW5sNWpLWVJSRG9mZ0dyeFFTUG9aUHlrM2xzeUp6?=
 =?utf-8?B?SUhub0U1NElCVE9ueHVHQUZpVzhGbDEyTlpIdElEMEp2QXlsaXhEMFdoN3ZX?=
 =?utf-8?B?eEJCZ0lJMS9JY1YyN2pHNDh6QkNpdHlrVzZ6dUkzYld2UGQ2VzBPNXlUSWRu?=
 =?utf-8?B?bDU5SEE0MHAwMEF1eitMek0ySnhhaW9DbWVIMnpTU1ZqRTRUajlnMGtBaHE4?=
 =?utf-8?B?MTRDSFUrL1Y2ODVvVEJod1ZZTEpEYmwzNE9SVjE4RFZOMENhbnNJczV6QmZT?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10cb127-71b8-4656-18a5-08da55ccd010
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 10:32:18.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUMuauZzvwK3SSyQnAtRmApSJwGwGQ7IEUomeetlYFOikQQYrseU5uvNhEeKGvmmhA2nQwIaufRFb3aWBhnLvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2544
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/2022 01:59, Viresh Kumar wrote:
> On 24-06-22, 05:58, Viresh Kumar wrote:
>> Though there will still be a problem here with my changes, we don't
>> accept NULL clkname anymore for the set-clkname API. And tegra does
>> this to pick the first clock available in DT (at index 0) I think.
>> Other drivers (mostly qcom) who need such dummy OPP table, provide a
>> real clock name instead. Will it be possible to pass that here somehow
>> ?
> 
> Jon,
> 
> Okay, I was able to handle it without making any further updates to
> the OPP core. Nothing else required from your side on this.
> 
> I have pushed the updates (to this patch and 22/31) to opp/linux-next
> branch. You can try it now and it should just work. I have only build
> tested it though.


Thanks. I have reverted the previous versions of 21 and 22, and pulled 
in the latest and these are working.

Cheers
Jon

-- 
nvpublic
