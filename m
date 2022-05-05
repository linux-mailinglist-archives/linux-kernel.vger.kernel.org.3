Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82F651B671
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbiEEDVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEEDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:21:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B91F9;
        Wed,  4 May 2022 20:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY59760rdKBKqx4AVhh/2qD7QOGvhaPXUL4WUAHUjAW7jl/5q9Flwz/W2TQhxIPEVCPyr2fUXNK60zQJ2NJO+N+Un2OhtOvchpY2WaoLxs6CEFP07Dqwy2vSMXa89zbW4aHA4lF2gr9h2NXgGWc5uIo5SC4EWCABC+ViW3VqQzQntUeToTcsAClt9/Hj32LcPXol7CFzoexdqFSGiitHv7sCFzZ72tCDc+QBwGerAyldEq1+C5Is0v24KGEgyavDmG2oAKnk07r9L3VGCty6zYebw/CVcT+2mqYr+8wQZDUDWqNuO+bDp3hlgeEzg7s1y+IgW1Hcr94Vja8kHzg5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDJtRKHF4tEEl9KIrlMK7P5uYutQHPRRmUv7iKwY6R4=;
 b=QNYVqG+OTAiiVcXsmRMYYTyQr9DPwohoEY5XxmQ7TeuSNUl/BqYpjV3WFKqAUaQ+xP2xFlHkh8zAgXl/S2rpa8AfhSJGCYYbfDyxED4PBGkyrsOKuOP1Jn4n45j5T7M0/4vhnRVwf7RqH8b8ulgPtdL9dsNMaGatxXoNcd5TwY7UW3//kL18Lb4mtqMKi3IUCgcSNeajXZ+4Uaxae1DW/FMlWxtNOkq2g4JQqAfhwaL7Zgjvk8JyicdtvRcSirVaL7pBok+NYZapoDI+aYs+9OAveIhHuuDvysetxyeM5dchIEuvtGZodRBRDNFqF2u6C/L4WawkT4v+2061UDxL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDJtRKHF4tEEl9KIrlMK7P5uYutQHPRRmUv7iKwY6R4=;
 b=esSRDap6t1oAvAa3vlFJ/Lvyltt+SJjmtPl982RL2rq+DvMGGiS375vmOXNdNLQ1GkRNyZkrZn7I8XpByTsPfvKd+doaUyt7Xt9KxOalmcm3MNnzBMIedmdFFE8x/2zG6dPuDiRMDDQ0HpJEzqUXFRMtUNFyJ83ycvmJDeSdY/1/zz4FPgzSXnB5Qcm7X2MIWeuxg5HA2p0lsJU/7zgorHTJujFHKfmOqcpIT3dcsHYkThMXLfBXZM/FbQMxd9unF1xB7tM+/F7h+5uuS1BXmzjeGHQr0FkXBKwi9rffT+U4r8ZBUyMBaECXeokfuo8pBpviyMFCgR8VnPCJDaojAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BYAPR12MB2646.namprd12.prod.outlook.com (2603:10b6:a03:65::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Thu, 5 May
 2022 03:17:51 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c%9]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 03:17:51 +0000
Message-ID: <05e94e6a-86d3-5d60-081a-6adb3bcafb35@nvidia.com>
Date:   Wed, 4 May 2022 20:17:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: build failure after merge of the hte tree
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220504165956.531c4b53@canb.auug.org.au>
 <YnIlh++OJDRrK9sz@orome>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <YnIlh++OJDRrK9sz@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a72baa8f-b8d9-45a6-5cb7-08da2e45d67a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2646:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB264661AE72146ED805C66D11AEC29@BYAPR12MB2646.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EXRzMlhS0VSJWroslOwpLRNwwW0SKcJk5OBzYUP6xD9vcrq3imBaBeuIF699qExCEZ89cw6bexhD/82hN91ozQPNQqre7/64VFYyrX6/WNTAK7pnVaqModm4eU4SuVshX3sHi5+uilJUiy9JMSZEAFog3C7aT2AyvlCDHsC8nes82MJ1wNZWcxsqIUHFd+uaaBLV2Ra/aEHUBSBD6+Gcusj8AMV79rU2FPIVrmrWMAmSLyDvWyn+QoQ78zKP7QL4Fe+4tylAdu/au45DPgDLfjSkR76vua0xX0lBWAv3m3Csw8/iU+/kOEpoiZW8YNG0zgrmZjSHa1lmbzSMeWaxjz0yeBONQt8cH4uVY4p/f0b7y5U86uuLcn0hk/ZNAFa0Cx1jZ2c8YXDuV9VI26j8KEfhSGD7pzBbxpP7eB+OklpKgyQRvm3GKIRW7h26qoc6dTEafDTvIKn78qiRf4KTg/8AoWjXPBU4Pszrb7TWUPKYo9lV9I9NXJvwaPMKpZezY3lkw9ys5n2E3oIvuM5Zabg8ak4iiFw1lfRtCCeCtwnQUriAV/6ljnNe9Fsl62jmbcaGYnamUcoL7CkPXpEIUgIkMzgRCFL0urC5vaparkdSQzFBbgcXnbK8C3foTB+bQkfNEMKTPKSe1awn2Ce6pBiUpMM6ZsypYe+SK846EYXFQbvcpoXntAi/yFatbe9pFeCK+YnMMa7xFVaIeMDHDdup3FD05P1hqCbs3CNtc8U/3rzrtZ0pRJjiZRLK1YXN/PapvpheB14ygedmIePlKbCL8c4oazXSbLuDe20MbgtIC4X5cZ/hboJ7mDyArD+r7741gu6dyDCV0FK6qloVvL5zrIYNrOHBlAjRle1l+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(6506007)(6512007)(2906002)(2616005)(38100700002)(86362001)(31696002)(83380400001)(508600001)(6486002)(36756003)(966005)(31686004)(5660300002)(8936002)(316002)(4326008)(8676002)(54906003)(110136005)(66476007)(66556008)(66946007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1RoaXBGSXZMQnZ1M1VlbEtXMHJjY0hJUlhNQUlqL2piSjR3Y0hic0x6UU5h?=
 =?utf-8?B?Tmo0ZExJVWVWdy9iandOT0pGNk5jck9ydUZpWW5wRGVnZmZGaTdEcEh4OXMy?=
 =?utf-8?B?aFRGRDAwUS96dStMSDlpVTRmQmJBMVBMdTVTNnlXczduMUVKYzdESjh2RldC?=
 =?utf-8?B?TWtseEFQL1RBakc5Q0hYaGttRld1cU43SERET0llaGpDOTJtMXB4ZCsyMWR6?=
 =?utf-8?B?NnhWejc1UlFuRk5MRHl1WTZyc0dYaFZQcXN5MG13elB6cmwvYkpQSnExT3da?=
 =?utf-8?B?VFc0ODUzaWZ4UWdDcUw5MGJUQTB2OVFkMUtWSitDaFB3ZVc1SnMrQU1KTDlI?=
 =?utf-8?B?S2pJN0tISnQxNzAxT3JiNmpQQVd2cittNUZWclJiRGZNcVZiUXl0NVV4WXlx?=
 =?utf-8?B?Y3o0ZDVIRGl4QjYrenF4am41Ny9YV1A4Mm9IbWp5alNaOE5oYUIvNWc5bFkr?=
 =?utf-8?B?U0hjOHhVemxjMVZhc0E1d25GV3dXUE40SUVHM3RTVmNON0pYL1hHaWQyUXV1?=
 =?utf-8?B?R0VVY3NkNEtwald2VW1VVmZDVHErV1B5bkxmZ2h4akxVZVhDaGVyVEhCUFJN?=
 =?utf-8?B?WnhKSTRjb3h6ME50SU1PeVNFcW9jK0lMNVZlY0pJMGxmSWttNHVHMVVTaHpy?=
 =?utf-8?B?OXlmcVFYSDdHQTQwMERqT2YyK3o0V2JVa21JUE5LMkV6UERsWlVQTTlYUU5C?=
 =?utf-8?B?dnAyNE1pNWt6RGpnWk9yNkRKbFlwOEFwYWN0amFtbk5GbXlJYzM2V1NEcjg2?=
 =?utf-8?B?QndRWW43L29FaVRiNXlvSVBxTHZjUU5pd3ZCTnp5K0xoaHdyVnVFOGtrWEhh?=
 =?utf-8?B?TjZiaDFuR0phdFBYVExubDV6ZVRacTlVcHcvS0J4NjIxN201ZUpyMDBnSmk1?=
 =?utf-8?B?NjRiNTBWaXh6bjBuaVcwRURlZE9YRlZRaWltRWZ2alZGTU1kMlhKOEFVVm8x?=
 =?utf-8?B?UWVucDg1dW5KTDRjMFdNOHJXZ0lDditISldmNGhJa0RtT2g1eUtwZktqTFhR?=
 =?utf-8?B?ZWVvaWFRSmZHOGkyQ2NKVDdYNWpNU05SNC8rL3lERFgzNnI4K0pBUmowNDFL?=
 =?utf-8?B?ZmkvQk1QcnlXUXNpamhVVmRTcUJSZ2EvcHRkYUdoeHA2UGdDREJ4dDdlaHg2?=
 =?utf-8?B?dHM1dVZaeHd2YVFqTTBBRi9tZ2VRWE5weDNwdEd6bEZra1BoRkMybnFNdFIr?=
 =?utf-8?B?bEV0Wnh3VzdTd3ZWQ3VKN3p6TUN6ZWlnbGxxcnlDU1Z5LzlRSm10KzdhZEt2?=
 =?utf-8?B?Z0dvN210bzh5ZGNuMm9xUElHVGN3Y3ZsZk1LQ20wUWFaRkFrOU0zeWVPNVVy?=
 =?utf-8?B?amtQVjBqTjJlN1lHMjVURFRaejhMT0hNajZZN3kxNzVxRmJmQWluQTk4NGs3?=
 =?utf-8?B?VXU3bnFNcjNhN2Znbno4V3U5clZQMXFUWHdQSlpIVG1QbllwMzIvSHV2a1pr?=
 =?utf-8?B?dmdrdUFnMDkxeDhQelJKTmJlU1pDZWNVOTE1VXJnMk9PaUpwMGVSRHlnUzdQ?=
 =?utf-8?B?UUNtRlQzZG1aSk5vNGNUaUJJbkMrd2k4UC9yVDdQajI1blJYa0haZnlVcVBt?=
 =?utf-8?B?Kzg2bDBiek0zWlBvbnBjOU5tQ3hnRkV3T1dtYWx5QzRra1RMdTdrZlQxVlp6?=
 =?utf-8?B?MWEvcVFDeVBLM2JheFF5cHJlU1VzVHlGdWpROXhhV1ZoZEs2eDhmT0psVzRi?=
 =?utf-8?B?QTR4d25hM1hYUW9MZmNBcW5iQlF4NGRFZnlRTE81TER5NUNud21KL0ZmN0Rk?=
 =?utf-8?B?MWx5VVlSWlVzRjFmajE5MS9QUnRxNFJoWGZ4djFWY1doRTNJeVdtRWlia1Nx?=
 =?utf-8?B?a0k2VUgvaHA0SGxpTWFTMk5ITnVIcWc0enRCeGpJVUhuUkRST1ZTYStrTmp1?=
 =?utf-8?B?V3VIWTlGbXFVdXp0YmpiaUFubCtUNFRTQU40cUYxUnJoNDR2VEZXcmh0Z2pJ?=
 =?utf-8?B?T0VlOTI0L3B5NnZ5WkE4cmhSWE8zRXloNTdpNEpsUUo4dXVJRkgzVThVcUZ1?=
 =?utf-8?B?cHlPbEo0MDlWaEZ6NFY3T0xqUVlOOUQwQTROZFFKdHJrdy9QQXRhTHZ5enJD?=
 =?utf-8?B?V0VtTUR4b3Jvcy8yZW9WUkhVYThtZ2M3WHNQbU1kcVlpVFB0UE5PL3JLRmpV?=
 =?utf-8?B?NTAzRTVJdU1ISWRXOWhsTVV1dGpNSFdpNDRsakt5QkdBR2lVVnNYR0hOVWZE?=
 =?utf-8?B?Q1Y0Yzh2SWxUZnNuUGt4ZlhNYjRNZVpxbWE4c3NkNldsVnQ3cDdMQllSZmUr?=
 =?utf-8?B?STdxUm9EdEswdk1pVk02aGFkc0NEVXNOV2lVY1A4ZmdxSlhiMko2NGE3clRq?=
 =?utf-8?B?RHVScjhOOEpwVWJ1dmU3b0F2bWNqNS9kSzF2bUMveFJWRjdrZTNHdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72baa8f-b8d9-45a6-5cb7-08da2e45d67a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 03:17:51.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em5i4QoUjiFi2KNwYTNi/7sZREXG6XmS5LTIPH/TWd2xnHIFQtMvwRDwwsmGtbt+CG3QOgq+89yt13O2WwWgIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2646
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Thierry,

Before sending patches I compiled and tested with or without HTE config successfully, I used gcc arm64 cross compiler. The initial problem kernel boat reported (reproduce step snippet below) used clang as compiler and that gives typedef issue which is what hte_return_t is. Do you know if we have to treat it differently with clang vs gcc or did I miss something?

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git hte/for-next
head:   cedbe14082d169f4c1136c70c5170a76bd9a076a
commit: 98935236600d4e179b664ffcfcd54e0ec3a1b4e3 [7/10] gpiolib: cdev: Add hardware timestamp clock type
config: arm-ep93xx_defconfig (https://download.01.org/0day-ci/archive/20220504/202205040454.CGWxoTt3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git/commit/?id=98935236600d4e179b664ffcfcd54e0ec3a1b4e3
        git remote add arm-tegra https://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
        git fetch --no-tags arm-tegra hte/for-next
        git checkout 98935236600d4e179b664ffcfcd54e0ec3a1b4e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash


However below failure seems like (correct me if I am wrong) Thierry might have changed typedef to int in one place and possibly not all other places.

On 5/4/22 12:04 AM, Thierry Reding wrote:
> On Wed, May 04, 2022 at 04:59:56PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the hte tree, today's linux-next build (arm
>> multi_v7_defconfig) failed like this:
>>
>> drivers/gpio/gpiolib-cdev.c:572:8: error: unknown type name 'hte_return_t'
>>   572 | static hte_return_t process_hw_ts_thread(void *p)
>>       |        ^~~~~~~~~~~~
>> drivers/gpio/gpiolib-cdev.c:623:8: error: unknown type name 'hte_return_t'
>>   623 | static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
>>       |        ^~~~~~~~~~~~
>> drivers/gpio/gpiolib-cdev.c: In function 'hte_edge_setup':
>> drivers/gpio/gpiolib-cdev.c:851:41: error: passing argument 2 of 'hte_request_ts_ns' from incompatible pointer type [-Werror=incompatible-pointer-types]
>>   851 |         return hte_request_ts_ns(hdesc, process_hw_ts,
>>       |                                         ^~~~~~~~~~~~~
>>       |                                         |
>>       |                                         int (*)(struct hte_ts_data *, void *)
>> In file included from drivers/gpio/gpiolib-cdev.c:27:
>> include/linux/hte.h:234:75: note: expected 'hte_ts_cb_t' {aka 'enum hte_return (*)(struct hte_ts_data *, void *)'} but argument is of type 'int (*)(struct hte_ts_data *, void *)'
>>   234 | static inline int hte_request_ts_ns(struct hte_ts_desc *desc, hte_ts_cb_t cb,
>>       |                                                               ~~~~~~~~~~~~^~
>> drivers/gpio/gpiolib-cdev.c:852:34: error: passing argument 3 of 'hte_request_ts_ns' from incompatible pointer type [-Werror=incompatible-pointer-types]
>>   852 |                                  process_hw_ts_thread, line);
>>       |                                  ^~~~~~~~~~~~~~~~~~~~
>>       |                                  |
>>       |                                  int (*)(void *)
>> In file included from drivers/gpio/gpiolib-cdev.c:27:
>> include/linux/hte.h:235:53: note: expected 'hte_ts_sec_cb_t' {aka 'enum hte_return (*)(void *)'} but argument is of type 'int (*)(void *)'
>>   235 |                                     hte_ts_sec_cb_t tcb, void *data)
>>       |                                     ~~~~~~~~~~~~~~~~^~~
>> cc1: some warnings being treated as errors
>>
>> Something has been missed in the contruction of the git tree :-(
>>
>> I have dropped the hte tree for today.
> Yeah, oddly I didn't catch that when I was doing the test build. Let me
> recheck what went wrong there.
>
> Sorry for the mess,
> Thierry
