Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166F05AE1A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbiIFHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiIFHzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:55:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0901B2CCBA;
        Tue,  6 Sep 2022 00:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0wtbJ2PBJdPtaoQ9Wz8BBUSjSF3LWLsrKpNlF/aOz+10wz3ThFnyP4TUw3DmgwS8UD59eS2KF7rgbeJUBx3Ocwf1rMKoS+rT8NNtjdO97SV2HknAWxNWE5x1M+di+BKJ4Qf+O6Y3l4x0Hf31LHMbodNn4cVN53Mao5Gii1bJbxR52LvKGefEeoo3Amedl9OCvTc+ZhdBnFmfT4bxiNhKpleZosC5h11mrybxfzuo2JUY2hNY9jU6DBwbgIFShmqpzE1JPY9qG5wJirCs16dxhFPDCDpb9ebj2YYOAYnfdF8F4uWaU8+6W5pTsXgPapnYYd0M+vzIF2DtFPrUXvlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3iBN9yIIwZ5GPSALp4PucljMGOqkU9yuJwLf6SNncI=;
 b=dcd7sTQ4J1+UEHFAQBHxF+Vs2/oWccMolqcI/gdiTXkgrbflVXhPWhb7pTLATI7xSZsAaZ7c+0akueV8N36XWADYudHeq5WXe6/HzmQUoRSq2SxznHMvDsYcHp0VGEjvNfYqnmWB7zyNwRz6w0SsOgAYpnSPwPuSs0oTKPBXKXt0LVnjvWNkJb6i+waBQ/emdmxBWNXZ+/lXqdJNEhSrUAM2BWTgPiQYPY9T/acSP0cySNgzrOVKaAUjjIJhdTI4tf93x8WR6AKMmaT7e3SyB+HYXCc8NvDy7bXWNzmLkfLO+hn7kRvFXuWJQfsQBRLEEFhxnAvbuJj6StteUVBFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3iBN9yIIwZ5GPSALp4PucljMGOqkU9yuJwLf6SNncI=;
 b=CT3m67aV9D0nZDb+xGbDaGnscIRzbTZWggd+PaBvKOVkSRSbIumDziIyoMBcK3kuLYHRsyHElPhdUmmi99rco5K0AkauyILCzdTp4bwficmddpBOrWTRsxizfORjCNZHjQmREMQDoPeopldbhBh5T/akz5Jz4URJ1wXAWqMh5ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by DB6PR0701MB3032.eurprd07.prod.outlook.com (2603:10a6:4:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 07:55:44 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::b333:1f3b:1b01:50d9]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::b333:1f3b:1b01:50d9%3]) with mapi id 15.20.5612.009; Tue, 6 Sep 2022
 07:55:44 +0000
Message-ID: <38ce81f1-0038-b0aa-7824-a7455698645c@nokia.com>
Date:   Tue, 6 Sep 2022 09:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] MIPS: Introduce CAVIUM_RESERVE32 Kconfig option
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
Cc:     cminyard@mvista.com, joe@perches.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, tsbogend@alpha.franken.de
References: <20220725091740.28188-2-alexander.sverdlin@nokia.com>
 <20220830030259.3503212-1-yuzhao@google.com>
 <CAOUHufY76AfTbz0wKixae=m0Zdh5P3fW2cosOvYKrJ-x0XpzJw@mail.gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <CAOUHufY76AfTbz0wKixae=m0Zdh5P3fW2cosOvYKrJ-x0XpzJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0160.eurprd04.prod.outlook.com
 (2603:10a6:20b:530::28) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR07MB8658:EE_|DB6PR0701MB3032:EE_
X-MS-Office365-Filtering-Correlation-Id: 596feedc-0ecd-4eda-64da-08da8fdd338f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbrISopPnmqmKtAgdQ+0q80c0MMkkWnwoYa53JnGeDNtJ/kWIzuSGEj1WXol7F/xrv9+IhlG+xSFttMktiZBNCzlkplwihpH99p7Zud63UaYZJ94qmDAssd4K8C73bobJYYI2LRz5d7AiRFmw0z4kAFwxpukHzFIBDxoUaPKOWnQyi5DJRRStN3lUGECR8SEIfj/L506Y2ocHjy5ZnPwXcaE4KEQnXO7KpMP1tM4JYzw91HfHiJRFOu25faiWnspeSmC9AW1oPX1ugF2XqQUVrg4ig7e3vaUbEXtybUVRZ0X7H+iV45VWpZKRh2mGyzbltljhjTQvZ48kPqFEhO7chl+RPh1fDAyI1GD8aKgdBeAxQCzOtBNCYQCq64w14hzSrxB67Dn51G4BJLG2L7b2+PrtcYbjNZxEXTx6RVY6WykR8B2FUxIsO0Cno85U8fHxrLUen2DYeNgjsczud9YZDlhHPDfupC0DzoHfgYGprhK9jqoSn4ZBQsj5dvLRojULXhFNwUMkAQCLzCsQcpf7f4dJZ5AYTwgNAsD5AIgu8NfW2r+hfzqRwuROSrtw9ZLTwdGIqw2p0IHl0VsfsviraSAlqraiJ2rLaFpmH/MMyRCxM5aE3kMtmh88IcIg+mGLmjba0sC4BP9hKQgBBwk3K08kOhgIW/cZm4zUk0XZVVMurW4UJHaatVLYcFKaRCyv4BCbmjp6L8K3YSmgKWdWOswGnis5ZhvnpN6k23rQL8uDr0urVTIoBmb5om1lnGjpQ7ZRpI+Y4v2SX969YijMZ6nG0YMKnM0OHa932HeUiAfR0d2Z8itugFe+d9aM2C/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(82960400001)(38100700002)(66556008)(66476007)(8676002)(4326008)(66946007)(316002)(6916009)(2906002)(5660300002)(4744005)(2616005)(8936002)(6512007)(186003)(83380400001)(478600001)(26005)(966005)(6486002)(6666004)(86362001)(41300700001)(31696002)(44832011)(53546011)(31686004)(6506007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1BNMjFhUWdNdys5WmVJQWEvTWZaZmUyWXkyTEVtenNJbStyTEZ2d205Wkt5?=
 =?utf-8?B?NFY2bU9sM0hSQUo3SkJhSk13TmZpTEt2OStnejBQeldBK1VyRFkwZ1VMTXlY?=
 =?utf-8?B?NHN5Uno2dFY2SmRETWlKdFY4bjJSZFI2M1crNHNRTTNkSTJhQ043NnFTUXB3?=
 =?utf-8?B?V2NGOXZWT1hyTzRJZCt3K3VzU29tamJLTU5UeUpyOWNlV3BaWEZiMWJDK0NM?=
 =?utf-8?B?WC9iSVMvcFIrUkRwWUpGTXgrcjBYQUh6ci9qK2pEcGZpaUUzckRVd2ExTzNr?=
 =?utf-8?B?Vnc0cjNKNkxGYkZnbm5qa2dOYytFaUo3N0lBZ3BQQjhMWTl1UTRPMkN0V2Zi?=
 =?utf-8?B?QUlpUkV6VWlqNWNadlNmQlc3VnJsekY4RVFJNDFkYW9zeWkxQmhMRXNjZDV5?=
 =?utf-8?B?VlpCQmtHeGpLSlpjMmRkdWQ1MzEvRkhXeG5rTVY0YllWcEpaS0lEdTJhNklY?=
 =?utf-8?B?QnFRUzRicnNlYWU4Vm9QbmFkWENYc0FKLzVhNGcrT2M0cHNlWVRkR3g5M1Jz?=
 =?utf-8?B?SzlMczgxZFVpRTFHdjFmTWhrSkxmVTdFQlowS2ZkdDVYbVhxWm1CTHNDZi9t?=
 =?utf-8?B?YzIyaEtCZFV3NlI0aHRHQnNaajJsZEd4THRFcDFwUDR6VnkvZlc4YWlWZ21w?=
 =?utf-8?B?VjFTcWhPR3dRSXYrdUpDYzdoWldsOTlaYk5VOEt4SWNRa3FmbEt2Zm10VVRw?=
 =?utf-8?B?ZmdqNWFCOWVjeERvQXRNTHJXTHo0VzJXcFhOc00rVlkxMVM5MGhmMlRGeGYv?=
 =?utf-8?B?QmtoUEJ0UjNIeTlialhaU08ycWc3RS9oUndNcjN5NGxlUkFjS3hFRXJaWUJC?=
 =?utf-8?B?SDRVQzZ6Um1hdzdLbi9HWkxpRzBDUVZ1bTNTZWkvK2l2aDZUK3luaTg3TGZW?=
 =?utf-8?B?Q0ZVUVpDbmNVZlU1RktKTE5jL3NqUlp0Tk5JRjJUZml6ODdGbkIrcUJEQTFJ?=
 =?utf-8?B?VVErODg4dWhQVVRzMjRUMndOLzNNWXFYeStQYWpkZG9HazU2QjVzczZtNVBy?=
 =?utf-8?B?Sm5UOThTSm1BSnFuRk8rVTJub2cvaFM1SUNuNXdIZ1R6K2FXc1NDQnZxM2VL?=
 =?utf-8?B?d2tzOE0xRXREOTdZbGliZUx1WmZndWdVNjlFMHc0eW5yRzNrbXNmOG9RVGUv?=
 =?utf-8?B?VVptOHQwT3RrbXArSjNJa29nWTU3NDBDZDkzSW5EcTlheDNJQnprTjlUbWhp?=
 =?utf-8?B?UWFnZFdKRGZQUkEwR0dmYjJFUzJ3eS8yK0gxWDlDNlpyZE05UXpnTG9LUGEr?=
 =?utf-8?B?NVo0L0lVU2xBL1VncmJCc2VmdWkyNzNaa0c1NWwrRmNwUkIrVVMvcFJlSEJF?=
 =?utf-8?B?bWJ4d2p4WTNFRHJ6amtQeFlxcm1uR3h2RExLakhDWFBCTVNrcVNrcTRDTDYz?=
 =?utf-8?B?cFk1eFV6dGpKVi9GNzdNeFMybGhoV0hFOUJoQ1JUUFZkbFlqQXZKTHJxRDlH?=
 =?utf-8?B?V0NvdVBXc0t5SWVTM1ZFVk04cXI0VkRnUzdXeW5zVytTV0E1d2ZPLy9JczRH?=
 =?utf-8?B?OEtqZjNHcUtJQjVOcDN4a0NaSVBPVW0vaU1qaW9zUHJJQjNJNTRTeXNaeUNs?=
 =?utf-8?B?L25GZkU0dmlRcXlHdTBtdUxNRlJpVzJpMWltRld3Q1VXb0NwNnc4dGFqbC9x?=
 =?utf-8?B?RXd5KzkrYTRTczF1c0JiY0o3RnUyb3l4cDVybitvcHRuTGVwdXNoMWZHdEVM?=
 =?utf-8?B?K1kvaFpPYThWenJVMzcvakR5Vll6RkN4LzAyanB5b2ZsejNtOWZKMmJFY2pw?=
 =?utf-8?B?R3hpektORkdReElZNWh5SVE5ZW5qMlk5Q0FDTHBYRzdDTmVRVWtJOUtaVHVw?=
 =?utf-8?B?U2RrL1R4OFRRMk04MndZWWU5MmtTU1pKMzBtd0xMYUVWRG9sOUlOZkdleVo0?=
 =?utf-8?B?d0VvNFc4TXFzdXB2c0FkMk9zMkM2U2ZGeWxNOXJaTzNRZ2Z6VTdiMFBVaHo3?=
 =?utf-8?B?eGZtdjFWMXFyYk5yU2pQTzhEZlQzZEtXR0F6SWRRRUpzVU1JNXhPV000dCt6?=
 =?utf-8?B?MnlRQ01FUWpQa2NHTVY1NHpqUXdWREp4K3FOWmh2LzRERU95NGhpT2tUMjVw?=
 =?utf-8?B?cFJFcUVmNzF0VUtvWkxOT1VxYlMzaVNyZUtPaitXaWw2ZW1VcHBlTFlXWGlE?=
 =?utf-8?B?Mk5zcmZULytROWFLV1JVZ1ozaDdXRWdqRUFFMWtyVFk0VGRpZVBGNnpXM3VR?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB3032
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yu,

On 05/09/2022 20:50, Yu Zhao wrote:
>> This commit produces a bogus error message on systems that use the
>> default value. Please take a look.
>>
>> Thanks.
>>
>>   Linux version 6.0.0-rc1 (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
>>   Failed to allocate CAVIUM_RESERVE32 memory area  <<<===
>>   Skipping L2 locking due to reduced L2 cache size
>>   CVMSEG size: 0 cache lines (0 bytes)
>>   printk: bootconsole [early0] enabled
>>   CPU0 revision is: 000d9301 (Cavium Octeon II)
> Following up on this. Please take a look. Thanks.

thanks for following this up! I thought I've sent the patch a week ago, but seems something
went wrong... Nevertheless:
https://lore.kernel.org/linux-mips/20220906075253.28491-1-alexander.sverdlin@nokia.com/T/#u

-- 
Best regards,
Alexander Sverdlin.
