Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B10592ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiHOHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiHOHqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:46:01 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F487DFF3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:46:00 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F7KuZQ018065;
        Mon, 15 Aug 2022 00:45:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=0UTBHJhJ9viXvcvIC2uwrITdWMAWLvyG/nFhX3gh55g=;
 b=VpaFNPmHejFUsPTD0WQIVO+bUNmiWf+6+2b9J0xG2q8ThX4CK5uqIpval3RnZOdlH/oN
 GChMclAd9oTk3hKJoA8ckUas6DSHqiQac9Lw/dOdRgEugeZDOijcZgaTfCoFFDxL1ic4
 UeYCNFgdL6/U9JDP6XJFEgROGHEpnD8PngD/Tc8XrAJQzHALHB3ObKeUk+ksEnVki0Ad
 Yo1GgJQYepknK2AXqiL4kn4cl5ogUmvnrOJWG1r27S5lTkzr1V31iM3gGrRLUkeAG4QT
 Aj80PcF6jyixvq3OblsEJw2nz672Azs0IgP5ag49oq1Yc1/LOqWLfhuoBczQd1a00WbL 0w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hxbfjh6gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 00:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYEXQix3p7M/QSged0EI6fr08SVfQBzyGJjtRTAWY+r3YzOG6bYbM1CgzD1dqSlBupopYrfJ1Fpns9ctKYuAga9XR0zGNxgGwcLLoNJEaXU+uOCS3k3C+88J1WEhq92oJEaJT4dbDWOEnbbP0U84GKXZS6rjlF+nVzkT18fGCeeFZTXmxKyE8WmMrzFPQgUEo6e9W59AvDe9NK883fVJ1ie99XoybG8C9bvDQf7FmJ6qRaQN4WBBoaiCRycK0c9ohENEwtyz7BhJv64L44NlK/htpEE6gK+emZpgu9Oo3heGSinkxRkyYV5SxUWxQDQUBi+bXq0utqEQZfrKSNZdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UTBHJhJ9viXvcvIC2uwrITdWMAWLvyG/nFhX3gh55g=;
 b=L4pElnWtgtsC9zQFA6eicN9i9axlvlx8JG97ModbpDBPr7WGEh4ADa2b3K9PQoAc0dEgCdoBgchRT1yr63J3bwwqDqufkvDtg0oMDcDvZ9Qb2/clJwrOQtf3j2c6atQ5ddrHAvdIRHqk40M18J05IB2aEhuLsb14HELPAZyHnQIxehXW78NfQa9Dcv9Wb43mDk999yuxJW/s+mcbYCx8yjiRuGiur9wzG33Na5yXKHDYsCVE6EihqQ6kCDlyhLqkzhy1hQsnhe07QAxhyQrSkeA7w11JzC7aYTNHoI60OezczDFhpz2rOWyqtuR6ip0QZurriqKjg6bU+1+PbMUYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by SN6PR11MB2751.namprd11.prod.outlook.com (2603:10b6:805:63::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 07:45:11 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::e962:2a9c:c503:db56]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::e962:2a9c:c503:db56%11]) with mapi id 15.20.5525.011; Mon, 15 Aug
 2022 07:45:11 +0000
Message-ID: <df52247f-3b53-c570-8229-f123305de7d0@windriver.com>
Date:   Mon, 15 Aug 2022 15:45:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: uaccess: Disable KASAN for uaccess_with_memcpy.c
Content-Language: en-US
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
References: <20220711094859.4769-1-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
In-Reply-To: <20220711094859.4769-1-zhe.he@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81464afd-a67a-4bff-c84a-08da7e921527
X-MS-TrafficTypeDiagnostic: SN6PR11MB2751:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLDglJHrMLKXobnLjLey7OE9iL5TC0aE2jr49iBhR+ECq3TVPTNNKnW9DQII19Jft/lGA4DxM+iIerxrg6ixwc2rjJSPxUdnbPjDdhqXIGKm7lS4CMqfVIi5VRK09BOo6sfstaEPuMq+5J2B9HWk2TVsDB6en5X33dCKwEbNrl56K9SOH4UIQFg10rP2mz0fbhBI7oIPB81bfNO+1pQ7I3Ws3K1aoy26JGEx8rJpMf8Aqys5vGwkEDs5TpPhSzOgmXU565q3zIX0OvLRJDj95MBU152VFl5kQqmTVALdy6c4Xp174XwbRIW7puuVrQyJ2+aFSOeJDOrvPWp3r9+nnkA1EB1WH+nRu9mehhaBeOCnaHq9azkY9b9YM/FNpqc7YPC/oYebLQaRfKSx7xdBPfszLzngyxqmtrPmJ2Op3pwtIEta/wOv74J4MtyEzrI8ryV9h7QT8z3pcKBM03jzwgcOUiqZ3p7faXdBthT3VAWiYYy5c3qHUMY/n4cd+F2dk8WBEegU29GODihYmWo9OM19pG81Ysz634TrGEP2bl1bDs/yX5YhQ/Ha0AsMn6s/h9u1QFDecTNZqcX+oTwVT0kky426Ir5yhsdgoeB9sqV+l88z4ZNtd8a8CKBjR+Upv6LHsf7pFmGZOEjzQ+0Rx/ebBwoiLh6wNV+/P3Sjy6zBE358PkCtIXIe3fME8JeAnVb4U5HVIF2vPhI7eBsQI0nPPrN7gfeOtcHHTeaIHl50WoxsRvMHNt2KG7aaNSEf07a8SlyTQJrE9mnAYlBdWQNkjb9PFNaAIo5v5cAAldXN207lqS/jTblcd7RT7i2Udqv2WT24HOdNpQgcbcNvcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1358.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39840400004)(366004)(66476007)(86362001)(2906002)(8676002)(31696002)(66946007)(38100700002)(8936002)(66556008)(83380400001)(53546011)(316002)(6506007)(186003)(2616005)(31686004)(6666004)(41300700001)(5660300002)(6486002)(6512007)(36756003)(26005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFRzOXZQVXhLOHlHV3JvZTM1RFBqbmNkVi8zRUlWUFQ4QVVRS1htbmhJV0Z5?=
 =?utf-8?B?NmIvcjR0Wm5PalFtNTZJdlJ3b29JK0hPelo3dXlTM0UxREJFMHRVeUhjQjJU?=
 =?utf-8?B?QnkzUzF5MmRwQjhYRHE1S25GaU9zUk9IaGUycngzemxQZy9VWE5kbE94L3J3?=
 =?utf-8?B?ejk0cXh6ODNveVBxWVdQUkJxWm5zVFU3eWVWYmNHTDJ4ckxjZkFYbGxkWVFB?=
 =?utf-8?B?OWhlOVlHbEs3d05PaXdMckdmRFNkK0M1YUtDSTlQREEweEkyQ3Rma2MwRDFa?=
 =?utf-8?B?Um5tcUxKNTVJQjREeVYvS2FXSktjaU55UmlFRUsxQlkxN2duTys2NlRSbWU4?=
 =?utf-8?B?bk9FZlV5blhsY2NWTkJJT1pETVhJK1pDQ003S1l1VjFxcitDcG1YRzJPS3Zn?=
 =?utf-8?B?RXQ1VVlXbkRBWmFEaDhtUnR3cEhUZVgrSlUvRGl5b2hQSVgrOEREVnpHQjJp?=
 =?utf-8?B?eDdyUzlSN05KdmlJNHp3aXA3bGgzbml4emVtYTZqTTdQZzJYQXo1YVJDTTFj?=
 =?utf-8?B?bFIxeUVlRUtaRXZ0LzJWYUpJYm5UZnNHMC81UTBLcTVmUkxlZTZvL1ZHbFNT?=
 =?utf-8?B?VUpTb1o3T2lDdWtTWEVpYUYzY0R4MzV4VER2YVNrVTFQTjc0UURITG9hSkU1?=
 =?utf-8?B?L1JVY0hqVm5SanBvQjRHRDRkamFjL2hGUXJmK25neS9EL1l2S01jczdUTXJy?=
 =?utf-8?B?ZldxVEU4aEo5SWp4UmdkMTFlQXVtMC9jTFdKVU1lUUxXb01BczZqdGJyZzVU?=
 =?utf-8?B?Mis2WWFwRXF2UUwxTFI1b2Z1eTk3ZHYzTkFvRHR5VVcrYjlvRTVkaFM0dDNl?=
 =?utf-8?B?VklwdXNzdHpkd0FBNDlvSy9LVk5Qd1NMYVBpekRTWEJzVi93ZVY3emFXeW9G?=
 =?utf-8?B?MWdNSnN6M05ETjh5NnhVcXFoTTdab1hSV2JGbkp6ZEl6QklGdmNLb3U5c28x?=
 =?utf-8?B?dWw1V25oN0xJZ1k1OG5ndHFGT3ZTWjkwdHF5R2dqT1hFSXJKTGZ0cDBuWTc4?=
 =?utf-8?B?aEdJZkh3WHMzaVNXaWN4Wk1oakl2VlZuNTRrQ3JrT3gzM2FidEF1SG04RkE3?=
 =?utf-8?B?YmRvdlYzNGZ1eWRGbzVoTXZ4TkpJYVkwbFFURGhobDcxdW1VOTFlQ2xUbnMr?=
 =?utf-8?B?cHErTnpoYThvRHMxMkV3NWI2U0hsUWc4bFpJbnRzVkk3Q2VvY3lsUWVxRFVE?=
 =?utf-8?B?MWcyQU5kT1RpYXhpb2FyRUxRNXgvM2J4UmNkY1VDS0VtdDg1Rmp6MEJCUWdY?=
 =?utf-8?B?NXV4c0NWaG4vaFNDU203cUx3Q0JmYUw0c2lpQzlMRy9tSEhDVXcvd2lTU3ZD?=
 =?utf-8?B?eFBKRHBMZEpuRDdEUThta2FxM3NuYjdDTWgrL3pPeFF4eldwSzd5MWtxWU5o?=
 =?utf-8?B?WFJQZlp1WEt3RzRuMmlMK3Erc3h5WVJwd2hBYldPNTFqcm9IdFdQZkgwd1VV?=
 =?utf-8?B?ZC9VbEpaTDhhaWFYK1VrZmVwcW5MTTFzRzl3ZU80Szc3cnRGVTd3Q1RnTlVJ?=
 =?utf-8?B?aEdUK0xIeVNSVUV2V0hlYUFGUXB2bXVKYUozSHlaRVB1MXZyRjd1QUtVV0J3?=
 =?utf-8?B?Q2Y4eGdrUDNNRzJndnEvUElXUVZKUWlHbjJhZFFGakdoN254T1JEeXpnRnJo?=
 =?utf-8?B?ZDJwVXBwT25hVWdheGJiMFNVRU9IaFkxUTRBc3U5MnpNMmlYWkUzVlE0cHUv?=
 =?utf-8?B?TG9VREprYTdhbEJoWTI3REV4U253WXJWTkwyQkd0amxWcFNMT1lqcndVd1hX?=
 =?utf-8?B?N2w1cnpHZHo4T1JmSG5WaGZzaGJ0UlpHTDNTY25TbzFXb0lGaFJKZEhWM2JH?=
 =?utf-8?B?cVFRRExyZ2wwY2VrblNTZmlBYTg0cmxWbmdvS2dIUU1MMmd3ZWE3eHpabDBk?=
 =?utf-8?B?MjdKclI4ZlhVb1QvR2ZrTG5kOEpEYmpqZnJHdjdtdk9jd29mVy81Q2Z4eWsx?=
 =?utf-8?B?WjE4SThBY01sYjN0aUxIUmpXcHZyYzRBTThzZ2xocTd1dXRnWjFrQ1Qyc0h6?=
 =?utf-8?B?VmQybXJ6L0Mza0ZRNnp0TVZyVGxkaTFyY240TXV4VzBTeEF2eUZIbkZQWTRk?=
 =?utf-8?B?N1dWQmdjdzVjOG1OM2R0bTIxVzdBdU9EUFcwN2FOMU5sYnFOWkNUOWJockdm?=
 =?utf-8?Q?cTlu7Tykrohmt0s/EKS40HcXS?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81464afd-a67a-4bff-c84a-08da7e921527
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 07:45:11.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlTwrugVWCBw/xNcZ8yIG89YFwispDiJTjn34wNKLFxjPUnHTzlY0vSC+Nw1mOZnc6O3DbAzUM8+G1S15ciEQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2751
X-Proofpoint-GUID: dD7tMM9S8m6Pq3txtLYtdZ0teQlBV2UX
X-Proofpoint-ORIG-GUID: dD7tMM9S8m6Pq3txtLYtdZ0teQlBV2UX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=527 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, some reviewers were missing at first.

Zhe

On 7/11/22 17:48, He Zhe wrote:
> uaccess_with_memcpy.c accesses user-space address on purpose. We should
> disable KASAN instrumentation for it, otherwise we would have call traces
> like the following.
>
> BUG: KASAN: user-memory-access in __clear_user_memset+0x154/0x21c
> Write of size 4032 at addr 00501040 by task init/1
>
> CPU: 1 PID: 1 Comm: init Not tainted 5.15.52-yocto-standard #1
> Hardware name: Xilinx Zynq Platform
> [<80116be8>] (unwind_backtrace) from [<8010ea3c>] (show_stack+0x18/0x1c)
> [<8010ea3c>] (show_stack) from [<80fc287c>] (dump_stack_lvl+0x40/0x4c)
> [<80fc287c>] (dump_stack_lvl) from [<80391148>] (kasan_report+0x19c/0x1cc)
> [<80391148>] (kasan_report) from [<80391b78>] (kasan_check_range+0x20/0x174)
> [<80391b78>] (kasan_check_range) from [<8039230c>] (memset+0x20/0x3c)
> [<8039230c>] (memset) from [<808112f0>] (__clear_user_memset+0x154/0x21c)
> [<808112f0>] (__clear_user_memset) from [<8044a9d4>] (clear_user+0x44/0x5c)
> [<8044a9d4>] (clear_user) from [<8044aa0c>] (padzero+0x20/0x38)
> [<8044aa0c>] (padzero) from [<8044ca00>] (load_elf_binary+0x994/0x1740)
> [<8044ca00>] (load_elf_binary) from [<803b4ed0>] (bprm_execve+0x420/0x8ec)
> [<803b4ed0>] (bprm_execve) from [<803b5bc0>] (kernel_execve+0x15c/0x190)
> [<803b5bc0>] (kernel_execve) from [<80fb9bf0>] (try_to_run_init_process+0x14/0x40)
> [<80fb9bf0>] (try_to_run_init_process) from [<80fccd3c>] (kernel_init+0xc8/0x148)
> [<80fccd3c>] (kernel_init) from [<80100130>] (ret_from_fork+0x14/0x24)
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  arch/arm/lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 6d2ba454f25b..ddeb46efed80 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -27,6 +27,7 @@ endif
>  
>  # using lib_ here won't override already available weak symbols
>  obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
> +KASAN_SANITIZE_uaccess_with_memcpy.o := n
>  
>  lib-$(CONFIG_MMU) += $(mmu-y)
>  

