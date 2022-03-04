Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8C4CDD26
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 20:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiCDTKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 14:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiCDTKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:10:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B82067C5;
        Fri,  4 Mar 2022 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646420984; x=1677956984;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0qrCBFJL972r6CeZbicUAPTWD6LsMzJsCuhwF1lYj2M=;
  b=DXtEe6O25zuWx0gjEUqaH+yBhTcdoeIWTpiUO/FfLyd4faPymdwaz76m
   wTsv1+eLrG7bqebhd7dGm16erN3x/dvKucmwdey6Y9mWpFGG3V7x0xTmi
   aWc2A+Q+UrFii0fmUbuHgab8xzJ8s30KDuT6jDA3J+nPX9WpWn1yWOnK6
   kOokqUlxNNDlRgI22bx7P+O7lLLzlGPoE7SjaItjtYcB/DDRfF1Nl2ZGP
   gBpLRhVjsZJbaCVkaTQk6zKPnt8Br1m3fKXs/uq3IU3RrmGnrBl+ho2xT
   BoMw6IvYNQSItemowqNHvQ3fi5zv4dq65G3T1/qsV2bAnpREujHrZUhZq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="317274309"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="317274309"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="509069876"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 04 Mar 2022 11:09:44 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 11:09:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 11:09:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 4 Mar 2022 11:09:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 4 Mar 2022 11:09:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klTbindLrD/ddoDo7NXMnr1WMj6i+mfIwTYSSgxnJD+3OU4TtodRlc03eu19wq8QpARTUP7AyfGKpmZ46qFtssXIpHYw8KtPG85GKp5oMHvCOeKY640oEwmVbiRRROSbNcef5cESfrb4J25JhyopE4WC7PQxfjoYQfrRk7X6kbZuaNa2q0Gsc/Z2/P36U8mU6W4nEO6xJLLSy3zgal2EOFL0JGDb246yeifBBcO62T5VbTtNVN1RC0JPSK0CLsGJsibauG9iEECw7wI4EDfGX7p2goR7kie6ZeQR8cj9AFb8K23F5934nw1O0fQbfvA7A/P+qHySdR36rzZu1Pud3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PXkvsCzZnBAmC/vsKZ8CBG2mdyxudypn2gBnkqZXV0=;
 b=kqpZsWK3abVOkIVAnUB29XavqLbXkJN9QvsqoPSSHobtiZagqwaeXro0alsK5A+h/G46ip+84tER1feVTIKLbxKZi0eoF0oCSAoar8ur5aD/wsEPNioS/GztFSRc6O/CuPuUE0MZeLaBJ9+J816GqSzN9w5f9WdXnU3+IZJJVig0K8nXjz8LWyAUw/TNpNfB/ALONI3Hx020B3lSr+eF1Q+xBzYTCzmKV9LL3Plr9vTDbY8Us5WA1fIvI/4lx7+VOX1FdWZ22T8zmOOogM9E6wF+ABKCob/N86C8Z547eu6uFX1aWrlJgst4k+zXe/Lthy1jrhjiavB8Un3XbFlaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4011.namprd11.prod.outlook.com (2603:10b6:5:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 4 Mar
 2022 19:09:41 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 19:09:41 +0000
Message-ID: <684930a2-a247-7d5e-90e8-6e80db618c4c@intel.com>
Date:   Fri, 4 Mar 2022 11:09:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v3] x86/sgx: Do not limit EAUG'd pages by
 pre-initialization policy
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220304033918.361495-1-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220304033918.361495-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b3cab1-a46d-43cb-c556-08d9fe1288b5
X-MS-TrafficTypeDiagnostic: DM6PR11MB4011:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB4011393EC48F1E090107D89CF8059@DM6PR11MB4011.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KBiwIDzzzfCrNun7EwogU0ZFCKg0ugB+msEZ4Doks7yBVft+rjMEutq9Lv5S8pr1ziK/QJm6TaFcku7qynPt2koXiA7dABzYa1GDrsSLdAmxGwaI/+a91Fm0g2XaIKzVhBfETEmaVvU+iNPIAk+V1gMLbMxYqGoAlO4IkAwYk09YGRkUt83v2QQKHo5suBVuhundFRPcqM6oNFORSJS8ZP/OlbIZUL9Ak6Ia5d7C9RW1JdLEKd85Z8aUj4y90xHI72sa/FVfYVQ8MWzRiFxh8s0Jx7VzYEkTn/J8ykC5655/Op5nLwP0AkY5362CXWQ1MJZiOmBswZP2x3YKTOCmxCrzG/DmPEpfd1o+Oe0hXxqHBYhBJ2CL1TEnr8pU3qdHIoI5vvNsYop9ViyO6kgoyNyqHgy9VamTA/mIBfsRdnQl6zYfYFh7NJFelJIp4zlyrUFxb21LChv2SaX8Rm14vgBRLVYoI26HLxxy99XfCVSzD53jkZQiybWeQn9OAo4BltpclQ7iPswcDclDiJEz64clWbBC46DBp3YVlcB1TI7OXKIyhHimC1AXLzA2np640ag7rAF3mF9qH/dsy4+2BOeL7QFNFxVXqYIowlvS+Vn0FDu0OJbTBDL8skJhsuyH0JlbgxrCNaqIwgeGs66HbGEkC4s6eTe3p+YOy1t8ocPUssCm2BUQ8AWn8XzwDEr1EjxC0/R22+fiGFlxSLfmBoUwfQ/3vaxrbmrSfCXgMFu+RsnsgUBciRIqPFvwcMjmeODlM6aiF2RqVbd56GcCVsion52j79ULxoC2UZ9X0/Ag4D5HSEWedRmk/QTy7Za
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(53546011)(6506007)(82960400001)(966005)(86362001)(38100700002)(508600001)(316002)(6666004)(66476007)(54906003)(6486002)(36756003)(5660300002)(7416002)(31686004)(4326008)(6512007)(83380400001)(8676002)(26005)(2906002)(8936002)(44832011)(186003)(66946007)(2616005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXR0MG1qKy92WWZadVQ5eTRLTTg1M3hYN3hNU3ZVaFd6Ti9rSUwrcEM1ZFh4?=
 =?utf-8?B?RE5DOXR6NTZnOVgwYm9yZXJTSzNYR0FKNXNtUnRSMXB2UWtpR0VGNHg1UHIx?=
 =?utf-8?B?aVJ3U0pOT282cWwvbFgraHBZVzhWTk5OOFFuTWhtSlRrZURCNW1RRkZsVlNY?=
 =?utf-8?B?clFaNlFXT3E2dEhtaVppc3diQkQ3Kzk2eTJrNWZQYjltYWw3K3hGRkhoVlBX?=
 =?utf-8?B?S1lwQndkS2hXSUpnaFVqRVg3ckRIUGFOZThiYkJ6SWh4RDN5emQ1RDBUTjJC?=
 =?utf-8?B?VmhVOW1hYVhDYTJnQmE3SThmamU4QWtjc3dwbUthM3gzSnF3TmorR01zVVlB?=
 =?utf-8?B?czNuVDd4RUpCdXN3K2R6TndqWWpSVGpGd0s1cEwwV3VnTnhpRDc3Q1VCNEZI?=
 =?utf-8?B?d3l1dHpjTC9CYVFWb3E2QWQzMGV0czZXQ1BQdkpocDRNbkZhRTl6YzIzRU5E?=
 =?utf-8?B?WXdqWGtTSlVvQjBvZE1SbVYyOFdrQkREY2pCVlNGeURQUXVVampUMlVUY3c1?=
 =?utf-8?B?SkdXdEJlWXZNUXFZbGdHdEJWa1dRTjBtajhCRGpHNHByblJCaENkeHMxT09V?=
 =?utf-8?B?SGd2TTlnMnR3N1R2QnNRTHlrckFXRlYwRlVNTEljT0N4Y3RGSlNaTmR4TjVS?=
 =?utf-8?B?T3VZMW5GcVpJeWIvRTdPN3hKZkd1eS9Ud1ZXdGN6em5TTkkwSXRDdCtCTnZ6?=
 =?utf-8?B?aUgxWXhuRzFiWGl0eDNTUm5QKzNBK2JaekN2NW5hOFg1dDFJWDBUZjNacWNS?=
 =?utf-8?B?L0F4UGZWeDVWa3ZFb0FmeUZyUFVEYkdCNC9XeFhKOEFtQWVRcWgyaTRveEpy?=
 =?utf-8?B?YkR2VmtkRmNrK2hTb3hQNFQ5RFUwWTlqTzFvV3RXb2lhL3VGZEFneWl6bkcr?=
 =?utf-8?B?dXZtRnMxTlhzcVlDR1U2eVozVVFJaC9TOW10eW9YVUNZT2dxcTJOcWxZZ084?=
 =?utf-8?B?cFAwaG1TL3Vha0tsejlsaXRQTlpLUFRxZTljMVpCS2trRlpuaEhZR2EybE9i?=
 =?utf-8?B?RWlOZ0RQL2lNYmtZbzdKQVJUNldCem9GcmwrMElEdUxnd3dodWsvZlg3ZTdz?=
 =?utf-8?B?ZUFCNkcrSEY2eHhwZlN2U2p6dENtVVhseVdHUXByYi9OeWlyZzBZVWsrdmtL?=
 =?utf-8?B?dml4QyswNWZWTW9WVkpKYVNpU3FNWkxBRDU0dEJVcmw3VndSUS9hRmFEcmdq?=
 =?utf-8?B?YitqYVRCQjdDS1FrZVViZ2VTOVVWOXNSRXByc3BQN0h0TS9CdjhJTGNBY2cr?=
 =?utf-8?B?dGx1VTliWTJDOTQxY0xBNkVLQWYyN1JDMWgyNUJTNlUxMEZBMUJYb2ZwTmpj?=
 =?utf-8?B?T3pSRU1pWnZ3Si85NE05ZFkrZjR6aGpUQzkyeGhzOENKTUgxd2sxcVhLUldp?=
 =?utf-8?B?emlnTFU5alBYdEFsV20wMFdGTjhIc1VidlpSdUNsY3RuZXhXQ1JkcXFiQ0pM?=
 =?utf-8?B?YzdMeDNyUWJpUk5sM295WjVTRXV2c0tjYjlaRFJXYTVqK2JPR2M4eU9RVGlT?=
 =?utf-8?B?b1NwaXR5R0N5YUdkOWpRR05CRmdwcHZ2T3ZKS2RiMFNEWmJtQS9mcHhzZVkw?=
 =?utf-8?B?MjM3bnRFQ2FzaktwcExwTjlGVlhITEs2Z0grVVlsNytVWGJwbGpoTm83c25G?=
 =?utf-8?B?TU9PYXNiZGRkclJkblRuemd4T0RCUk9xb3VkYXdDZzhZRUMvYWNpS3R6d0Rq?=
 =?utf-8?B?T1dVZWNBWUNURStvTGJKcnI3VGJ2RGFmNDNpbnQyQ1pTYm1BN29vVzdDd0NO?=
 =?utf-8?B?OWVHd1BvMWd6NnRsVS95ZWFGUi92SkVGb1hzSVRFbWJ1VGtDVC9TbUR3SmNC?=
 =?utf-8?B?RzA5ZEQ1N0ErYkw4Ym93dGxpQUZNYkZqZ2Q1Z3hZNFFRY28vdmZXSUxPSUF3?=
 =?utf-8?B?Y09wT3JkTEhrVHM2YytJcDBhajBXdmZMb2dZSVluZ3djYnp5c0ZYclpxWkNK?=
 =?utf-8?B?bXlJOXhWUFZucndya0Nyb3VvMFVrb08vUG5tb3RtQnQ3aGVpVExETEk2U0F6?=
 =?utf-8?B?KzdwMnAwdFpFUU1WeTU1aDRUaWxHdURRUlhJNmErVmVWdG1xN0grWnJtelZV?=
 =?utf-8?B?NUQrMkRRYVUrUkZZa1MwaEd0TEczRGhOZktPMXlnNVQ3VjU0WG5uWmxselM5?=
 =?utf-8?B?QVNMZC91aFdJNElFNVNCQlcyaDVPOUg1YVdFeFlSYXp5WUZhUDN1TXRHY0N3?=
 =?utf-8?B?M1EzM3l2dzBjemdIbng3aHBTc3Y3U3pzN0RhaC9ZejFrcEVDYVhCNzNsS2hr?=
 =?utf-8?Q?y1OcYWlrWZUIEsp7EQSv6ll4YQn/dQr0Ge7Wcq9k8c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b3cab1-a46d-43cb-c556-08d9fe1288b5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 19:09:40.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqYaELlUYGg6ZE/uhDFaN/E6jQ2aBFBNwkbIDcvR0qDvocsj1xWgnyaSj0IM/knZqlF4cfSPpmfubpHe08xCCcMaptDuWVAJuNMPfnP7QkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4011
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/3/2022 7:39 PM, Jarkko Sakkinen wrote:
> Pre-initialization policy is meant for EADD'd pages because they are
> part of the enclave identity. It's a good practice to not let touch the
> permissions after initialization, and does provide guarantees to e.g.
> LSM's about the enclave.

I disagree. There are scenarios where it is indeed good practice to
modify the permissions after initialization.  For example, pages that
may be used for relocatable code can start with RWX permissions but once
the pages have been populated with the code they should be able to restrict
permissions to RX only. It is not good practice to require RWX permission
over their entire lifetime. Ideally pages should only have the lowest
permissions possible. 

Supporting the modification of permissions after initialization enables
the security conscious enclave owner to support the security
principle of least privilege.

> 
> For EAUG'd pages it should be sufficient to let mmap(), mprotect() and
> SGX opcodes to control the permissions. Thus effectively disable
> pre-initialization policy by setting vm_max_prot_bits to RWX.

Setting vm_max_prot_bits of EAUG pages to RWX results in dynamically
added (RW) pages to allow RWX PTEs!

Please correct me if I am wrong but I do not see how mmap() and
mprotect() will control permissions here. Will these flows be able to
prevent a RWX mapping of dynamically added RW EPCM pages? From what
I understand SGX controls the permissions here with sgx_encl_may_map()
called during mmap() and mprotect() and it will allow such mappings
after this patch. RWX mapping (VMA) with RWX PTEs of RW EPCM memory
will be allowed, correct?

That means, an enclave using EAUG to expand its heap will have
enclave pages with RW EPCM but yet could have RWX PTEs pointing to
them after the user creates a RWX mmap().

From what I understand this circumvents the kernel's security mechanisms.

This also breaks one of the original rules of SGX as per:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/x86/sgx.rst#n74

"EPCM permissions are separate from the normal page tables.  This prevents the
kernel from, for instance, allowing writes to data which an enclave wishes to
remain read-only."

In these changes the kernel allows all dynamically added pages to be
executable - even when the enclave wishes them not to be.

> Then, remove vm_run_prot_bits. For EADD'd pages the roof is where
> it was during construction, for EAUG'd we don't simply care. This
> hard to keep in-sync variable adds only a layer of complexity and
> nothing else.
> 
> Without vm_run_prot_bits existing, SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> does absolutely nothing. Therefore, it can be safely removed.

Removing vm_run_prot_bits cripples SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS.
With this removal SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS will support the
modification of EPCM permissions but PTE and VMA permissions will continue
to allow the maximum access possible for the page, whether the enclave page
supports the permission or not.

I find it risky to circumvent the kernel's security mechanisms and
I am not comfortable signing off on this. Or am I just not understanding it
correctly?

Reinette
