Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A5D4EE248
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiCaUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbiCaUF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:05:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734C5103DB6;
        Thu, 31 Mar 2022 13:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htk2ALw68mltlzRRNoPa+xSYXCPFtvonnYjmRncK0WaZJ7yk3HMNfdVGZLfxdgL4soTAp50vkVJmiY+RJL8qwMfaFXLOcL7GPZdPHYspxqVfr/ovrbh/mcDAPBSg3+P+DRQ/FsfDanmkfQnNxGTDi1YsSiH4uxADM8txvaD9yAXL0fXEvwB2HVI3njN+k6kdchDbp8q8u4+aPreCz/jUa2YTdol1+/nCy3Xev5Kf6GUL6DJkmN/k/9bB5eOqG5ijpbqfj3eMQYz/C6NwJiO7cc4EEVgMUXp8t+DzZlxdnJbX0QMdJWt843wJ7u+re2n28o24HKmfTb4If5oRsoEBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4tj/P/782czuAkoSC/WELMV6t9tDB3+oSmSqKxWlMM=;
 b=TQ9wui9eFuIk/m1F7wMigTdxMcvCWe/JT++fWc4NWdgVnOIBbzNVK9pB+MU+Y1W9rIxPN2mPTnvFucvGfypxJGx9Yv+d13Z30hY1tKnE2vNMv+YDvJJG+d5DUXajzQUs4pmQJQmScanOXvlarDnypRY8o1hctih6b75zFEu2sRYRhbJIt9DIQQDzuuUoA1hspmrNQEpweyMoK3aLxp5Um1F9y/L60v8Le2DEwMGquY+0d4EG9xFREocgsJrtUJ+RjKxBjPBwt25CESRmfr3h3ocGoafTG9/MP+PJqjbbiomPryPt/IrYAqpFHIYPyvUGEznjOvORpwDpGeZF8oGVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4tj/P/782czuAkoSC/WELMV6t9tDB3+oSmSqKxWlMM=;
 b=kyfq0lnKYvBzDhpXZucQpX7Wkpj+KLQQ6Q2mmnsyMHhoqM8bjkyjPEmkGTxTM6ys7o72/PiPvZFcXvKfFugJP2zcfwxGdigzYSaJOSv8lxTXDFyHIgvdGWxe5v+s8YcdfUn4E+gsyNPs5boY7bM9i/YSlxmw5g2d3jMV7BebfPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4633.namprd12.prod.outlook.com (2603:10b6:5:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 20:03:37 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e%9]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 20:03:37 +0000
Message-ID: <1c2e7840-23c2-a0ff-abd8-ab216ad3480a@amd.com>
Date:   Thu, 31 Mar 2022 15:03:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] crypto: ccp: Export PSP security bits to userspace
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>
References: <20220329164117.1449-1-mario.limonciello@amd.com>
 <20220329164117.1449-3-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220329164117.1449-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:208:d4::45) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9faa891-3de6-466b-ead1-08da13518b48
X-MS-TrafficTypeDiagnostic: DM6PR12MB4633:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4633A8B61B677E50F7713F25ECE19@DM6PR12MB4633.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYXaTg301BPxdOyRz0Jzxanb2tfxQhlq+uM0ZzJKnTXR/K1YoKr9AoxsD2y8YCin+462DEhh/XfeBEhQ551ZufykzGtKx+/MX1ZU7p58DUn02d2Vaf945VnDIrpyMqIQj1r4/vSn/9MHXITkc2y8a+oge/uDv9fK3j7zBBtDFo4Vt6vt+F1N7a4PRTYC2GXmaMxIsrY6XHYgKj59JGvm3TfK/oZm5Vcpk5vPEZ8EZnW5F/96ZIKQaS8YNVeWpcGVpB0buQE11Bt0pYyhuuGG0UB9vPaQ4zm/UB9otDivdVLuPJrLynH832YUsvzs45oUtOMAwcpz6lPhPYDnkYOpff+qL0mCMfegP3sfS23wYYAjZpWW5Ysp86z+zFqfFKGYAgFus5vyJonEo79IRIvXg3r4R9oJCdDDQzjOxQMORg0ZcmfMsSDD9i/NmsU2lejr/DcCdi/WMe9U0Gd5coMTx5UlzQ70zXRCNOGFfRpmMVvJ7vMvYnlnn2vw7F+3vOQd9jV1yErTzlBinRH3JSNjUJg6eWXQ7azriXhsHASP6kgl0GM4upizu6W8aqrp3YbX/qhyDQLOn0HzYz1gurD9Fp//psNhXtq7HajkhThT1lpVjPi5ht/I0BIKp47UAGnwjxBLs4Smi9ga43dAVf15JYKwKvlFmczNlWqMZPAqzT9E5SJ/Ah5CgbFFL9yNidPw2ct/DImku8Ei0uNQqpxUWPanUqEoGlsKsxowZhmzWew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(36756003)(5660300002)(508600001)(31686004)(53546011)(15650500001)(110136005)(8936002)(2616005)(2906002)(4744005)(6486002)(54906003)(66476007)(66556008)(38100700002)(4326008)(31696002)(8676002)(86362001)(26005)(186003)(316002)(83380400001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1JKMEhWcWE4TENCMEl4OTBoV1hqOVhPMTNxVTN4aVhjcjQ2T2ozQjNoNnhD?=
 =?utf-8?B?bldwQmhLbmhmaDRlS2xwT1VIa1B5WHlKY2VWYUs1bVBDNDc1ckt1VHBrQ2FB?=
 =?utf-8?B?cjg4S2ZUMFUvOFpwV0Npa3MxQVcvRjdrcWliVzhGclRxUkoxaWJpNDljNVBB?=
 =?utf-8?B?RXdhVGUzOTl6b0lZc2wxNTlVd1FIOTIyRU4wT1VKQzVXMXJxWTBmVlRUU0hK?=
 =?utf-8?B?RFBSWDBBMUJWUHo2Q1Nyd1JFdFJGRUtGMnVvaWRBTXVLNUVOT0taZ0QrWG5E?=
 =?utf-8?B?ak5LU2JSOUgrZFFBSFlEUDB3Z284L1NocFViZWhhRW5qQnpsRmQ0Q2d6TjBy?=
 =?utf-8?B?M1pvTm44NVFTTUJWNnBHcTdRa20ra2hTMjZRQ3l0VU5iRWJyUi9yb2ZrK1ZG?=
 =?utf-8?B?SFlzbVYvMVQ3VWsvYlNna0U2M0xoMTB0QWRlSEVnS2pGR2NLc2hqTWd6N1lF?=
 =?utf-8?B?YXhPQjBHRjYzMjZLMjJOMldSU3ZhNjduRDVCUHFjeDV3ZjlSYjNPZ1dhY2dj?=
 =?utf-8?B?ejBjazdVWHVqNWYvOWJsWVRsNWI3M3JLaEkyQllhWkRZNFI4R0M4czlVdDNL?=
 =?utf-8?B?Q05xb1NrZm81NWxraVlhNGNUOXFVTVMvL0FZQTRsVEZPL3orWFZ1aXNzWlIx?=
 =?utf-8?B?c1R5c0t1Y1MwdHl6dHhxcVVCdjRybjB0TEQyYTNRamVDRTVJZUNBbzJLdS90?=
 =?utf-8?B?cS9KU2todGNoa3lwdVVBNzFOb1NMZWs4K0ZEKzA3bXNYaFN2TGdzWVZuUk5z?=
 =?utf-8?B?ZVhya25mWVFOY2g1cDZJbXZmZVpkaG9zaEdxQW4zVDhwL2psdld3aWpaQ1A2?=
 =?utf-8?B?Y2N3S1pVS2lXSTBqWVZWajdoOW5PM3RyRHRqQTd6K0RVbStiK0tMYTNRYjRy?=
 =?utf-8?B?QjgvYjh2NzNhb3RqWExqaEZpeFBTQzE3OUJKZVBQRzhNeVg0Sis3dmRYdHJZ?=
 =?utf-8?B?dGtiZ0VFaWZDcGdIZjZpdWNWN1ZudWZvZXgvNzFYUUJ3SmNOdng2MVArelFH?=
 =?utf-8?B?T1JCTWxrdkl3QmM2WnZHYTE4V0hXMkx4RnFpbktkMTRZUkhQOWh3S1ZYcGNF?=
 =?utf-8?B?Nm00Ynd5OEZCR28rOXdmZjBjZ0pIcTh1bzVNVGdnWlJ5UWZYbmZQS1NzNXNZ?=
 =?utf-8?B?N3QyUE1qT3NUYmFjeEZaWmFEbHpLTkpJQkRQQWJSTSs0bG1hZWJzaTMzWm8y?=
 =?utf-8?B?dnA3TkhZaEhtaERKN1l5ekFvdTFDdkFSUTZzaENOUVlORGJJSFBKZTFGdGFG?=
 =?utf-8?B?SzgyYzN0Q0NSMVlXNCtzSXZLUXpjaHhhRjMxLzM2bzA4Z2RIZ24wd3loeXFX?=
 =?utf-8?B?dmdsczl0SDFKR2R5bGc4OVh2UVNjMXBMNEdzNHkrWmxnSUsxUUpLVEZScVhz?=
 =?utf-8?B?cE9qZ0ZsYVljOTl4MWI0elh4OUNRTXRIQnI3eklmeHBsM28yclhJTkhnMkUz?=
 =?utf-8?B?a2VFcGpQUEJhMm95djJaMFFVdHUvdXE1bW9zbmFTb3pqVUd4UVRFSStaVjIx?=
 =?utf-8?B?S2U4VTdRejBVblA2RnkrcE9wMEtxcEo0MUtQTjErTTVJYkpSby91VlEwR3F5?=
 =?utf-8?B?dGRJVnZzM1YrVTVNVTVoOWZ3aTNmSkRGaGdzMnhpcjhML3lRQzZRZE45TVg5?=
 =?utf-8?B?aHZaUkpvTGFJTDhWcmJCcFlEZGdOaU0xbmIrNERTWHJQUEpjQVRnc3ROOGxP?=
 =?utf-8?B?S1BMb2VZY2pEUHhqSTJ6eGVxZ0Q5S0hBVEw3d25XWGJ6eUZwRGQ3b1lGVmo5?=
 =?utf-8?B?QytnTnVCNnRKVnpWTEFMRjZESDcvd0diVzZYSW04a3VTQlJydVVpdW5QbmNm?=
 =?utf-8?B?dWRCdVFPVS9CSkMwZGxBTktRZHhDTmFSYm1EZDVjandaaGhBOUFuUWZFaWE5?=
 =?utf-8?B?MEZFSjJvNS9PTGV6cWZ0cXc3YWVtT2Y5NjBIQVMvNFpnQXI5Rm95KzJuOVho?=
 =?utf-8?B?alltU04xUEdYcElRazVUeHpYVnZ4NkdFUXNwclBLSlEzZUFEK2ppSnBhRk41?=
 =?utf-8?B?bHRhK1Vrand5VUtCYXNnL1ZJMUs2U0Jlcy92bmpFeUtBZG5Qd25TQ2xkV1VV?=
 =?utf-8?B?MU1Sa0YwS0tRRm9zQ2x3a2NEdGZidUxmd2tWQmNJWmNRT2hRaE1GMC8ya3JY?=
 =?utf-8?B?Q1JBWkV0UzdJRjFNcEZLVVJHaWtGdWVVOWdTdDFxSWh5dGd6Q1l0VDJKZFJJ?=
 =?utf-8?B?NmxuWm1VVWFNdC95dkxYR1BCN0JIUno1dWxHTjFLMTFhQTN4UmszUndEZW9r?=
 =?utf-8?B?Q2hrRkx2MmpDS0ZOQkhEaVdiaEMyMDhDeTdoUnA1WGROdU0xcnhReEhNNzFo?=
 =?utf-8?B?SnNOKzA0RVdQOW1pZFNjQVV0ZFFyZitHR1Bod2gxSTQrNklQTFAyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9faa891-3de6-466b-ead1-08da13518b48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 20:03:37.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJOfYiYBxNRCBlqtA4a5x84NTd2ASnGaTTTDVl7lhkfez3tc4ets+IU0buRhN2Lx75ER+F2D5dBLVY+zhrDsIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4633
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 11:41, Mario Limonciello wrote:
> The PSP sets several pre-defined bits in the capabilities
> register to indicate that security attributes of the platform.
> 
> Export these attributes into userspace for administrators to
> confirm platform is properly locked down.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   Documentation/ABI/testing/sysfs-driver-ccp | 87 ++++++++++++++++++++++
>   drivers/crypto/ccp/psp-dev.h               | 17 +++++
>   drivers/crypto/ccp/sp-pci.c                | 62 +++++++++++++++
>   3 files changed, 166 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-ccp
> 
