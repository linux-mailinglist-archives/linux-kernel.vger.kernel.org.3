Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31821569BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiGGHa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiGGHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:30:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977929CAC;
        Thu,  7 Jul 2022 00:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd9LA4WGXbaVzi3g0kWiB8v30B8iOOEKSDQ3Rt9+JGetz5PmgTxODwrW3UabZ9nQz3Gd1WhMnz7eJWynItB80vycjMF5yZzF2ph/aQm4wDjbwaeapq3pGBEsoU5ncIORBMSCDXARJqlo4Yg4MNKLg7JZiPStGtfhADR19MXUFKhuyLe1WuP5H3NfcUVG3H3i3VZ3A0iujA3SS1CpmNxBhdYUB4A06Xdguggt8yyPiE8736pu0xBfCWNTOCimp+gRDROJVc0i0g2ZcVVJ4/4P+RJAyxJjBcSvw6ijop9yJ3g4oQmkFfvp4Nqh2npzkDSTUDP62c9btb9cAkhEXLkoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/z2sxEstzm1iYG070PdVdx0GAbM3H5OkGbG5bcgWzE=;
 b=AxTF12SD3oT/0GnK/Cx3bAtmuHwVNz2U2fyM1O2cWZtP3h10/KFGSCcdCoqGT3hNvIwrX1+QsEIHbUcuizX1K0X/QmQLHk++3lDEtVPSwads8Qh6k0ZPP8meogW7OpVofjrQRoGNIPuWE5hX3iSiQ0VqSgnrO06CPDQntBOWVeDBxY30SnwqUN6G4XukMSNtNkVanZLmy5k6KsAv7kgXCl7Niq+DDe9JNXi2Iw82APvH+LJ1/ghLJ7EgAaXn+MHXaSKZEjRGySg7hkHAJmVW8iNKhZ5T2l7ure0pvXvrnmPiZ1b/bnX7MjIogtudJCVli4pR8IoKwrIpBWEam3FmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/z2sxEstzm1iYG070PdVdx0GAbM3H5OkGbG5bcgWzE=;
 b=ITn+YRbEQ13FAPaii9K+7VaZzuRaIVOIIbnvoUKxTpgLohmAuEHS8UVLNVW1OFAdN/pV5Pu8Kcs1b1V21ovCI2TBUtrm7xsb/gkuKp+fgiD04CBNEnXgTEZYQp4e5mVf5K6HrOkbtr8eaL3q9jpKMkiwIS2tv9LEB2WWDkqkbBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB3890.namprd12.prod.outlook.com (2603:10b6:a03:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 07:30:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 07:30:48 +0000
Message-ID: <fbf83d60-67d3-698d-e2d2-02dc8d7e49c4@amd.com>
Date:   Thu, 7 Jul 2022 09:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Content-Language: en-US
To:     paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        wireguard@lists.zx2c4.com, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Suren Baghdasaryan <surenb@google.com>, rcu@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Theodore Ts'o <tytso@mit.edu>, alexander.deucher@amd.com,
        Todd Kjos <tkjos@android.com>, uladzislau.rezki@sony.com,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
References: <1656379893.q9yb069erk.none@localhost>
 <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656421946.ic03168yc3.none@localhost>
 <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656443915.mdjoauhqe0.none@localhost> <YrtgeSmwLmpzN/zw@pc638>
 <79c6ad70-47d9-47fe-4bb4-33fcf356dd37@amd.com> <YsXK5A0MiVgHd8Je@pc638.lan>
 <20220706175836.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <YsXP7ZwHh/GvWM82@pc638.lan>
 <20220706204202.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220706204202.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7a86571-96ab-4a67-687b-08da5fea9cd5
X-MS-TrafficTypeDiagnostic: BY5PR12MB3890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUBEyOMZo1gKc1DWlDNMwTlOAnVxn98oWDvNHh+nnltHUIFXbbxuHZhaTNnAqDL4I3U3zdk1oxaeIf6yC0iwp0R6j+QbCb6wEkf/AoZfbmITYWmX3fc3HQULvmEfLB1Nj1tWMM0A/WliHEgyf7Hm6WgEgXO3iGCdo8mA5acNpLlTYNa2AmlMlcCYGHaqdRk1r/+BXddL6plsQQ8ncin/L3uzoKm1ur36hElu3ed6CCoGwlnokAGNIz2RzeEGMUcaI6liSBmrCOiDPOh7nzkscUcHxiZ4IoVN62qUDBH9omXMLS7r04x3nIlV7HUSHArz9XfVPPwTx1+Bu+t6fGsqLIgQW7op7L0JcJKNUWsKBGwzEkmUs7BJUX6f8ydRUiWuKFbkM8oQfGzny/V7WHJOFE1HK1ko9Nrdin46eLj9hZs0ktA+6HMPOgdvxDnJlXBzFLvYrdLOi08gPSYYpFq8UaPJIRb98ce9thwd78CjJP2xYnodFILHOqNb0k8wo+hgIOMHiipPqnqZbloNU0Ytt+q5VcVxl0t6pI6ChOPiyltEy3fJV7mIX2BwWeYSgCqZHqP2wFE7XGpudEg8xWouiBGlSlSJfLuQHL02M74GIhpbliBJNxNL3UTACxWjLj4o7DstxmnOpOpFnaicbcZopUBjomXpXTBfgKrxicUwRNtzbWej16ZHkpuZA/I8y4cwHr5lpdx7BL5KSQeXqBD1QpTVQDjwSPFdy6eFAOnYk5Y2I+PZ+Inz5IgAQqiJ9q76aUyX/4n0SiTSPetesaBxV+/5uM7HkFkiTD86AoMi38WdAA5/UKtqEe7b/Tmedb2Za5NNqwxPK4yLODEEdni4a7lI6ubSJL2NN7l9F2NC3ImAypnrbrv+IbL6RPIOcufi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(6506007)(2906002)(26005)(6512007)(38100700002)(41300700001)(66556008)(15650500001)(66476007)(66946007)(8676002)(4326008)(6666004)(7416002)(5660300002)(54906003)(66574015)(8936002)(478600001)(45080400002)(31696002)(966005)(86362001)(83380400001)(6916009)(316002)(31686004)(186003)(36756003)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXYrL3NnTFdmTGJreVY3L0JERUFwcXc0QjZ3SkFKNzdGZUYvU29nTEdaRDM0?=
 =?utf-8?B?WWliWDRSSjNBVDZvK3MzZWtkSHBpMzBySmJSTDlxMDBRNThYcmhUTFRkUTFT?=
 =?utf-8?B?QnQvQzRPZUd3RmQrYjByMmcvUDJvYmRkNjhwazQ4SjkvTG5VcHdydEFma2Zh?=
 =?utf-8?B?MDVLYXEwcVNURFcxd1haWjdQMTYyK0puNmo3VldJWk9RbjVyK3hQRUFNNk1u?=
 =?utf-8?B?MnJDbzNBOEczWU85TldZOUlyRzZXZGpOUVM1K0tRNUVJSi9hay9mQXlNUTlV?=
 =?utf-8?B?NHVvc2traWtRQytJeEZkVjFZelVlMDlxU3lLRkMwZndtMmhnZkxBZXBYeTVQ?=
 =?utf-8?B?VEMxKzV1Z2tQUEV0NTJ1RnYrUnNuYUJyRFU3WnBVVnJ1U05iWHYvV255TFFs?=
 =?utf-8?B?aGV0TzhNWGxFV1FtaHB3ZEh6MnBRZmlGQ0Vqc3VhTzcwamVkRHlGMHRzUjRP?=
 =?utf-8?B?Y1g4ZW9tUmNNQlN3M3VIR2QvaTZpUHV5VmtvakxpdWl6eTBWbXErL29manRZ?=
 =?utf-8?B?VzNYcmx5SGZoRVZBWG5obHMwaXNBV2dFV2JPSTdBcXM1cWFHM3FzWVhvTGxD?=
 =?utf-8?B?VEkvL2Urbk9jUTl1aXBRelBZVzhGN2M3QmpnZ1pxVVBIemt4OGlNL2xJV3BX?=
 =?utf-8?B?ZVJYd3pBeXBMNlpnZlo4eDNSeEFpZTFxci9NUnkxQ0hyeFc0ekhhMm9KVC9n?=
 =?utf-8?B?ZmI1aDQrcEEvc1ByWFErRGVLREdOS0EwNWVqVFVlb0g0T2pibUtwZ2R3dHJS?=
 =?utf-8?B?a2FIOGluS3VBNW9GU0tSSDJQWDlxTEdnaDJMTzR1a3VmWjV3UW9lZXZuTDVS?=
 =?utf-8?B?bmhOWHJSZmRVL2tYMzU3cnpYMDBCVStjZmhxN3ZwMDRtaEV5MUdvd05Hei8z?=
 =?utf-8?B?Sm5Fc2p5NmFtTk9KSDJJZVhuRTQ0T3BNaXljSko3VFg2bHdlRU90YXNjV0Fs?=
 =?utf-8?B?UW84bXJjc3pMNWJUVU0zMmlSNzZYL0w1TXBrSWZqTWFKWXgwSzdDTVU5Rndr?=
 =?utf-8?B?b1VUdU4rRW12YlRnS3lCTDN4SStqL3RrN05YNWp5VEpmOFlIV1NvcU5LVUVh?=
 =?utf-8?B?RXpFbWlabEIvRlZHV0k2UkpnMVZMU0hqZlZjTUVvVVZETWNxYmlHVndyYU0y?=
 =?utf-8?B?dDV1bW1GcEFielMzZjRsRnlqVXZMUm1wMWNwU0NMRVVNb08raXRDekhNOHdS?=
 =?utf-8?B?dGhBcm40YitoSUVNTnNxSDVXYW1jRlRWM0l3aXI1NWRMVVhLOFg0MVVzMU5p?=
 =?utf-8?B?VXBMb0NkR1gvWk45UUtDYUNzVU16Q3NaNTJNcGlzWXo3QzhJVngxL0U3cjIw?=
 =?utf-8?B?LzJGbWNLWGw3TEd5SVVhM0xLaW1jNWtENDNxTjR1VkZSTm1vOHlIUnZoTXRp?=
 =?utf-8?B?RWNGRHBaSlUvcG1SemJEczJUakVWdi9DUHJrTkFMcHAyRlpyWHJETWhvekZD?=
 =?utf-8?B?b3Fybk1RMnhBeG9YaUxpY2N4cldUZHYyY1o0SUpLZXZ2SENIU1BObUVMTHZn?=
 =?utf-8?B?bGg2N3RUbWNFZlB4RHNrOEhLNGJCNERJMndDdUpha2s3OE5VaDl6V20zZmdO?=
 =?utf-8?B?ZWpwNWZlVWdWeGVkMTAwaVJXUkgyUUFoVnhrS3kzQmpsWWhaVUVrTTRXbFVM?=
 =?utf-8?B?QWVWcXhLYjNLRmFpN0hKazdpNzRBNXMrOURma3BwWUw2QnR5alNTcU1KZWl3?=
 =?utf-8?B?VGlwdldjdDhQVVI1Sjd6QWsvMzhsMkora0dUdkczRHJmdGtMUHlYUkpRYURK?=
 =?utf-8?B?cituM1pSNzMvM0paMDZpdCtYb3FhOE1IZS95VTFWenp3VXJZVzVoUkJpVFdz?=
 =?utf-8?B?VzAyQzBYeFhRVFViTEJacXRNQXNSVEhLRWszbzhzcWxWeCtaUE1YTnV5a3Rz?=
 =?utf-8?B?T2I0VHNVcDVsaG9UWm9lRlV6NHZQcTNEVStMWVVBV3cySE5NZHBSdkFkR00w?=
 =?utf-8?B?T1lCZzNlbXMyVS9KRzlnd1VHa2NHM2gyb05tdVJRNnV0bHNMeVZ5bTd0T0I3?=
 =?utf-8?B?Y1dzaWtuNVlJc3RpSTJUUVU1dGN1TmdPN1doY1c1Y2kvNXZ4dTAvSVpDbTdm?=
 =?utf-8?B?OW0rUHROYmlPcy9PNkIySXNJaEU5WFRRdWJCYmt2QWxRUXNuOE9iNDR0Q2ZB?=
 =?utf-8?Q?QRLHOhtDZDAUpLaM6LsLO/dUf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a86571-96ab-4a67-687b-08da5fea9cd5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 07:30:48.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+c139vIDhGXoHv2nSHvz/P2VzKjyvg2l62E/eHdWB5z/2EFlkWMcXDxX2WufaOp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.07.22 um 22:42 schrieb Paul E. McKenney:
> On Wed, Jul 06, 2022 at 08:09:49PM +0200, Uladzislau Rezki wrote:
>> On Wed, Jul 06, 2022 at 10:58:36AM -0700, Paul E. McKenney wrote:
>>> On Wed, Jul 06, 2022 at 07:48:20PM +0200, Uladzislau Rezki wrote:
>>>> Hello.
>>>>
>>>> On Mon, Jul 04, 2022 at 01:30:50PM +0200, Christian König wrote:
>>>>> Hi guys,
>>>>>
>>>>> Am 28.06.22 um 22:11 schrieb Uladzislau Rezki:
>>>>>>> Excerpts from Paul E. McKenney's message of June 28, 2022 2:54 pm:
>>>>>>>> All you need to do to get the previous behavior is to add something like
>>>>>>>> this to your defconfig file:
>>>>>>>>
>>>>>>>> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=21000
>>>>>>>>
>>>>>>>> Any reason why this will not work for you?
>>>>> sorry for jumping in so later, I was on vacation for a week.
>>>>>
>>>>> Well when any RCU period is longer than 20ms and amdgpu in the backtrace my
>>>>> educated guess is that we messed up some timeout waiting for the hw.
>>>>>
>>>>> We usually do wait a few us, but it can be that somebody is waiting for ms
>>>>> instead.
>>>>>
>>>>> So there are some todos here as far as I can see and It would be helpful to
>>>>> get a cleaner backtrace if possible.
>>>>>
>>>> Actually CONFIG_ANDROID looks like is going to be removed, so the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
>>>> will not have any dependencies on the CONFIG_ANDROID anymore:
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2022%2F6%2F29%2F756&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C8b36bcb4fe61475c0eb708da5f8ffce8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927369274030797%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=eaK66spsbWVi2uRhcFK7eu4usgkHFZCSvErZxB%2F2npM%3D&amp;reserved=0
>>> But you can set the RCU_EXP_CPU_STALL_TIMEOUT Kconfig option, if you
>>> wish.  Setting this option to 20 will get you the behavior previously
>>> obtained by setting the now-defunct ANDROID Kconfig option.
>>>
>> Right. Or over boot parameter. So for us it is not a big issue :)
> Specifically rcupdate.rcu_exp_cpu_stall_timeout, for those just now
> tuning in.  ;-)

I was just about to write a response asking for that :)

Thanks, I will suggest to our QA to add this parameter while doing some 
tests.

Regards,
Christian.

>
> 							Thanx, Paul

