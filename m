Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF24DBA50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358190AbiCPVuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352294AbiCPVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:50:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A14E0C6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647467332; x=1679003332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TgWhDHdad9Ttq6B9F5PYRrcTTXojkyTzIhhggu7RMlA=;
  b=Mfh3rFtbMENm99vqjgaDrToJdP3pVEqNsPMq2sO4wEi4qQAEA+MhqWBF
   R43UudNdtUZTGcTQtEyhev4Flp/EQmJqIPhVukCsw5UHfxGUWocGjMg6c
   +2v5gRt5ZAtdadU7gmzsIA31jubWhx1UtY6+P091MaHd05TKslJmS7zM3
   wn7E8SO8hwrwO6U4EPMrJVEFeRaFQ1smNsauuJclkT3J18lqrwJvLTZYY
   Lvpqdc83ee/HEl+jhBB+PcW0ktMCmKSMhClkm6QsqUCsdkbNyamz6+Qcy
   IiktxDJDXA0U0ipRZesBUm/yB4t9Bo/r2zI+wZudd6B8pwMu7CGEE3jgR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256672858"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256672858"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="557647666"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2022 14:48:51 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:48:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:48:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 14:48:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 14:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFUxnbL+nMMkz+cxFRUKQe2VJBHw5RwRYeeFNDLosezo961/MlDbbxErq9mmI7yVXtHfFQ7aR/7RwEfarHMmkFspZposi/NGR6q3F6TQThuV7PKnDE+i/q8LXpKFOIcLgsl6/lOeDc19FhoXD/YuNcfckvNHYwcFHTRf6qf+oV67crfDAafvEgKU4m0C4kZIh3GbtHf1Grw5yWkBdZx1/jgJLOeTikXvLOVwxhd5afcCfq9joWyYdTL7HdXeh+/857lch0zwaRDGJz725VLxyfMYNhHWlEWrOmKrOsZEbt0F+N31j7AJCa2ckH318GmfyCcPUBD8lxbbqPJ1jBVIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3CDl83Z1ZuJTgXpVqWf/ZTY8O6wzanXGciMl5YqQqE=;
 b=Rrbrci+7cOy3Hjoq4/4ZU3+q0/0P/cnen8Sf+JDtKKdqAImXaj+MTTegjfmrfGVnKW6lZHswIJgRzhTPz4GBVpFV1IFhpSV/RqBS/LOZA0XsCH7FiifaKYev1LVL4p3/wdlyBvH7pk83tNvw2uJiVpkvsd7LH58Ddi0Z34EBCgIKgwuvxwd7RVJ2oFXENVBP1BvmTQt0p/JzjxNCO/b1ekesc8fUw/udcGDpcixhtCes5EgNkt7GJHWPhqcU4eqCzmUYYo06Qo9fqbPFoSACZSf1Bqpcp0y5q0yWifV4iJwLLRLng9wmelcDh7CiIK+jbrI+AqJR9uwBZxTJy4yN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MWHPR1101MB2334.namprd11.prod.outlook.com (2603:10b6:300:72::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 21:48:48 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 21:48:48 +0000
Message-ID: <80bb5d8c-5eda-e0c7-3da1-56a6667b3971@intel.com>
Date:   Wed, 16 Mar 2022 14:48:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 01/21] x86/resctrl: Kill off alloc_enabled
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-2-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220217182110.7176-2-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a93d6f-38fb-4d6f-9561-08da0796c029
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2334:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR1101MB2334C134C9FA24AA96A95CE2F8119@MWHPR1101MB2334.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /miCzDnowZt0wCPqvLbDENfJolmuOkDCK+CMoJLwDZT75xbpoxqLzbz3qVjlM6+i8Gv5FVDIBXJxR0us5sDRRDfXEJM79AXH+HdVFSXScVKA2uQw/Qdr8WbGLSUcOLep8qlkSfduOfc9/ojJtCYE19m5NcLK7EiFitaIw1i2XeXIujNcyQOlJSzgdoEYPlzmRMdv8a4Z880YfjL9C7HXbv6YK2isyGZ+cJbrT0Uk2kwKDu2Oj1Ex/yFpeOpGaBY3l3vbW21gU4gw9wT0fJtWiJJyrxsYZcr1vt897bgDqP2gZv6yk7BIr9iKuzRISxgPuAwHAW3OCIRQOVsXqtjXEJqPg4zc/bqQMKdHH58gk5kCmbPlPVRCXQFKMWXUQ6S3/0IfeAeYORbMV2etb0EEYlB0SX9qzVbC2ap+q4c1Z42zanQjW+EossqIOoQ+3/GPxRELcfxSf/7YUnJ3WA5rxQ0bxR8ar/SO7EYhTzeq6wwZx0VchipBkwLpyTfc2A1xzazpCKb28jEfPPGfmtLvREhVpsEjOo7jnLHeMyf+kJn+99tbAiktT5Ei4F29hwac1sUB20rGisZ3aX9hWx38hmfN74OwRkC3wgPxeVDy5neLn+YAuuQ/U5++fJt0NFx5AxBmyoOyFW4VrXsd30NAzg8+MI8xosSHbJp+/I94hyW8+yNrvni697kPbCyhHmKBNxVRrco/Af6mODjCrRTgrOnV2rz8EgTgWF9uvZIyb+oFmy+u6G+IS7EDNXTdYZ5v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31686004)(7416002)(5660300002)(38100700002)(8936002)(36756003)(82960400001)(26005)(86362001)(31696002)(54906003)(186003)(6512007)(2616005)(6486002)(8676002)(66476007)(4326008)(66556008)(4744005)(508600001)(44832011)(66946007)(316002)(6506007)(53546011)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlpFZ2Q0UnNWTjNwellCV2xjMktYMVJua2d2TG9rbzg3WVExb1ZJWkJiR3R6?=
 =?utf-8?B?MnQwaGpiOXRJaGpjc2JTQzJsSUtlUytWYjlzOFFiVUE1VmsxWUlPaFJTZWVH?=
 =?utf-8?B?VVFiOEwzZ0p5Um1hb2tRNFpBMU52ZzZNbjN4Y0pTVUhxaWlQWXA0Z2V1ZnAz?=
 =?utf-8?B?d2svNkdYSGRJVEM4ZDZWOFU2dWxJalRVT3UzdGg5aytXeTVFc3NGbUEvclA3?=
 =?utf-8?B?TzNQaXZqbTlXOERvbVZtRHFOVEo1OWs2YTJkRjlHWVVmbEE0b253NFNMckwx?=
 =?utf-8?B?Q1AvTnRUdWN6OVg3NUNxWWRyenJPZDNmZUx5emVidnMxMmN1VUZPZVJxMlR5?=
 =?utf-8?B?Q2E0UjEvMlpBZEY3YmJUVDVlUGRJODZWNmxpaERLektROWZPYTVpNkh6MFpT?=
 =?utf-8?B?K0dabUZwSG5kTTIyTkxWWTEzMU9nTE9xVVVjT1N6YnBHcExqaUxLVlZoTUxH?=
 =?utf-8?B?VG5NbEJ0Q0RMYmFQenpYSG10d0xCVlMraVFzQmhoOTk0UnhabzN0bERJenBU?=
 =?utf-8?B?TmpHMkFiZlVPRmNlN0pIVWJDcWtNU1lqemczY3RTVU9WMnRQWHBtd2N2MXFn?=
 =?utf-8?B?dnIxS25jWUpZcEViSHNiOFRPRkVDZDViSWM0b0k5TE4rOFhTMmgyMkhBM2sz?=
 =?utf-8?B?bXdTc2tHOENLYlAyMExiU2Q5akhScGJqSkJwVGRzL05yNko3aE5sNW1xZjdR?=
 =?utf-8?B?bUYxckE4RDlPdHUvUUcza2RuUHJxeFNsNUZtRGwvOFNpeTdlKzdRMlhLbVFF?=
 =?utf-8?B?UElzOUROUHBVaFpqc3dLMnZWdS9pSzNMYTRWVnFYQmRCT0dEbTZ5T3h3Qk42?=
 =?utf-8?B?VUp0dGFyakFqSXZQSXFSSU11MzBBTWhIcWlhVGRQdUw3ZER3M3VBTkpqR0xk?=
 =?utf-8?B?M0JqSVgvM3NVbVg4d0NRcFh0TllaWG5yUlBNa0EyclhheVZNdzZtMC9yUnY0?=
 =?utf-8?B?ZXhidmVMS09jWVpXdzVZM2xaZXRyYTJyVUVtVEZBUXI3cFdDdWt6NUNjOCtQ?=
 =?utf-8?B?STJMT3RQMDdHcmY0cmRiWWl0SVovSnBkMjFBa2w2N3NpOVZNVDl2T3lZYy9u?=
 =?utf-8?B?MTlQdHlCYy9VSUJINng1QUtaK25KVEM2YXBQcmsyWVg1UWhqM2N2S2oxWlEy?=
 =?utf-8?B?U1RzNzFTM2hrQjErb1pTU3duWDRnZkowMHR6dnYzVGttdVdLaThvamU4SkFo?=
 =?utf-8?B?ZkJiYm00Y09sV0VBUS96ZDRMMUx4USs5b1RFekJseVNzMTFndG5yYTBQb3d4?=
 =?utf-8?B?RXNIRnhnZWprZjkxczdPZHFXbko5eUFDMmJ3QXNLdVlYT3VWSjM5aXdnbVI5?=
 =?utf-8?B?S0srbzdhdmJFNkdXNXFNMlF3Sno0ZlJhc0E0Z0ZnOHg5SlZZdFhIMURTaXdq?=
 =?utf-8?B?bGhxSWpWTDVKd0RxUjB4REFZcVdPNTRnL0FpdnRQNFZhQUl3dTlHQzhpSVhH?=
 =?utf-8?B?QWFMbUdlaE5FSDBreU5zd3NSOTRBTzh6dytYSFJuY1B5dm8zWk9OYW9BMG5R?=
 =?utf-8?B?UUZ2aVFzMTBRQU9FKzdoakE4TmZWblM3bmhkbGt4WmlaQ3FvK2xWZEdHWGZC?=
 =?utf-8?B?K1ZpbjVmYWpuZThlMXpXaE9qTHRXNnpTbGZWNFJiQXZhWkJsSHplQ2lMNlQz?=
 =?utf-8?B?NGFpVUJSM05tNU5qYXdVRkdhRFhDTkM2bkptOG1qUHdHRC9pR1VFQnp3bHhG?=
 =?utf-8?B?czBpT2RxcFExTjBQd1UzdFl3U1hEbUZtcWE2MUdpMmtoa2hCZWZtM1pJQms4?=
 =?utf-8?B?OWhncy9vR3dkVi9xN3ZaVm9QK1FvNmkzcCtXdXhZcm9VOVBWUWo5NldEVmZy?=
 =?utf-8?B?U3ZuQ3VYUG5acC94Z1VrRmJPbEsrRGdNTERwQ2dOQjNVOS94bnE3K0loOFVz?=
 =?utf-8?B?bHljajdSbW41QkVnY3NVbElvRHFuVWRWWHIzaThmV0dCNENxRlBzRGhjNC9G?=
 =?utf-8?B?b3d3SG11UXI5VHNWVFI4WVRSQ0FIaS9wV1dqTWJsNUxsaHAwLzRLLzVnY0F1?=
 =?utf-8?B?eVhPSW1NdjlnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a93d6f-38fb-4d6f-9561-08da0796c029
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:48:48.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLcBz403rtpWjC8pF7+lyIbRA2PKc6wMJYYEbNenkJlHG8ozpS0gPkqVTu6RgzL8VJhlkFfbFwBF/GdIkyMb94lMfPE2EBfYkrHZNZ2cZNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/17/2022 10:20 AM, James Morse wrote:
> rdt_resources_all[] used to have extra entries for L2CODE/L2DATA.
> These were hidden from resctrl by the alloc_enabled value.
> 
> Now that the L2/L2CODE/L2DATA resources have been merged together,
> alloc_enabled doesn't mean anything, it always has the same value as
> alloc_capable which indicates which indicates allocation is supported
> by this resource.

"which indicates which indicates" -> "which indicates"

Reinette
