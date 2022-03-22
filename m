Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482D54E394F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiCVHIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbiCVHHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:07:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F753723;
        Tue, 22 Mar 2022 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647932781; x=1679468781;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W6+C+tjNsFPIggC60uO1N1X1X2MoTSJyFlV01A2b0Co=;
  b=lub+FKyZufsiFDDHDICryHfSowVrZVRRv+nsDGWfZr5dBEnz6ZYszaiV
   TBfIEVAcjSyn/KfDiQMGN+1ig/vvsUwE0SEAJ0x6PMNi+DsdGd+Kf24xM
   bzdk9g2AUTMkBb13raujNr8CEPiBsYaFKzGtvMeXzEEzWQ2sZahs+EdxP
   X7sBLmLquCcWCBDDkA3zczz+oRgFzVPYVplpROXLLjD+oXC2o1JNffgZv
   hc+2RKqMr1sln05+L/xCV1YsGXsFibP9p6H0uFh/dyFWE1xt1WY4xZw2S
   kO9qRiEuvYtlZ1dfuFN3lgcBZyt1P/3zS8x4T73EkB7eijMKHKb8ct9ve
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282576618"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="282576618"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 00:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="824812675"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2022 00:06:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 00:06:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 22 Mar 2022 00:06:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 22 Mar 2022 00:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljCnUhSRWiBYk+2o1xu/542e1YaN0CNQ28QlDJNY6gse4QW198jHn2lYmRBlEHaaBxmDQxFg582bLijkV6xIgA3tWWVRDhm3r7U56dw0nTXh3gozaSzSybrHeaBw9ZRH4gtWzd0oAzhgTcHR2fVHFQwiVkhigajSNSQOvko+6hJbLVatA1MOzcuCBYRePqug8Ik/tUmwMWYnOYTjAGRZSuNu2/totBN3lKLjywK+DgcW7WpxW3vyGZ6sen0PmFaRQfIM9WgV4yaShfHDEEdW9WX+MJc4VUg1qPQVkEO8n23J29z+gmMwogyHK9JABSNfdGcZyqcZzlNn+KqEQVa8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exjPxVTxN2BhQtgvShActp/FxmJEPyxKRcVX+s9X8/I=;
 b=kzwDO6b1BzpTCSkJnuxhYemTugOcPtNOVU3NYPb9gmjhKsao1ZvKH9Ks4ZzrYbeRsLtrDBMxyCUk2pfGqqH2IWw9ZmdccJaGa2KNABAFHi67RdD6VjCNuy48nLANIRvJaHmSZN2QbzJUqfTbV4bP8rYjUd0Pjy7iEg+VTJOEF1X3pKsKc8Q0QtS9rdZP889Jba6c+0im9BFr3uDVNfVDqs/zYL2lepSNjjZ8MNwyBDx/YDORuF94xNSUw5e6O2KT8god0vRr2uX/I4mgg1XgnOMpeQ48RIhnS8bRf9R08VHVWicnQjYv3U2BjWGNhZp+JE9xwxMAQctSH1qlAERO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY4PR1101MB2087.namprd11.prod.outlook.com (2603:10b6:910:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 07:06:16 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8516:e462:e23c:85fb]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8516:e462:e23c:85fb%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 07:06:16 +0000
Message-ID: <fa7c8772-2a70-c3c7-bfbd-4804abbd28ea@intel.com>
Date:   Tue, 22 Mar 2022 00:06:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] intel_idle: Add a new flag to initialize the AMX
 state
Content-Language: en-CA
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
 <20220309223431.26560-3-chang.seok.bae@intel.com>
 <CAJZ5v0g2ZU8PY8QkGD1Nb6VH37pm=ho8ZYa3h3UBRWDoH+xqnQ@mail.gmail.com>
 <8fc192be-348d-0102-22ab-57b974e9d840@intel.com>
 <ad071c01174bfb76ec790a2b43db2892e5b652e9.camel@gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ad071c01174bfb76ec790a2b43db2892e5b652e9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 845be648-1a8f-47c1-ff9c-08da0bd2751d
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2087:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2087B7337759DD4B4B59027CD8179@CY4PR1101MB2087.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uR92WPLpxyExbGv0eao3AB8OAfvvMByf+GraKjBwIWZ/jn3zpOKYds0pTeNIk7BRG1aIWLpgz4ILr3BQY0H/vkonKT21H3mdNcvGpOq7q7fklH/wwmFAzIZ/0SUewme+T7T1pEu9Wql1ECOZSWtcz7USZpn1OMH6m7btKJw1pZDzCq6aniCUj4P+wfaLu6NnX5xW+hYQpc3hQRA1o2gJwmV5vXq1UZyZlV+TcH2GyooqtRUnQuiw81HP4yfN2e8wb1zu2YWhtucWXsTJE/lKL1anhPVYQ5aYKwRrEfAJYc1r9BQPjOx5cX1vVdKb+7eJmjliCDeTVSeAOJeTF8MTQ0smAQqqG7peQzYjh1uOH3p237vaJPpx6KtdPpo6OT76b1Xurj2AR3zYEY7r3oMNnxSkPWrQIALjXfdPmVz9MLlb1mAJ11jRdptl82NjzvfVQ6EfB2M7nQUWlRZ7pgUmSMtR3AGIf8e42TBMyY0is0icfEB4wKrGv+Dhael7TOK2rlN/NmMaxjEpqupkhL6AVoO9u9Y0WhEyy/xx7ITno9AU7n1SrJmAy9QuJNLb9Q1bAnDyKhl+W2ZsS5v3rp+7I8uiW/fuO3eePVqljnUeQU3Ie0T0/Ar9lW1QmTyW+KMVqViU4tZrTMVW3hg8Kk5j6CpDW8UVN2Oraxbfh2zofh+Wi8QQMvKP1YR2Jrs/LS4de8yFTYZgHbg8r0Jye5gTnS1utHECxj+dqmFSghn7saRh+2RnTFDD4PM/iL005PYU7qN+4JXFYW4YDLTiub5CC8Mjzt68E1/I0T6qpT0/01o4kNUP+43OUSwABfe+uvmI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(82960400001)(31696002)(86362001)(38100700002)(966005)(6486002)(54906003)(5660300002)(110136005)(4744005)(8676002)(66556008)(66476007)(66946007)(4326008)(2906002)(2616005)(6666004)(6512007)(508600001)(26005)(186003)(6506007)(53546011)(31686004)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlreXAvb28yV0dESUNkSUZTZ2dmcXFibElFdnZpWGZaMitTSnRUSFhReHo5?=
 =?utf-8?B?KzAxQThLS3JDcGhadkF1NkNnZ0ZYWmk0T1BKeE5pYkUxbWRYdWwwMzdkUDVa?=
 =?utf-8?B?YVZMZDZRWTRTSWh4VVFnVVhrbUxmTzVjcVhNRVJHdDd4all1cStRbW53a20y?=
 =?utf-8?B?WlZvdkJSQVM0blNweTBCYm9sN005Yk9WRXpQN2ZJMzhFTjdVN3RUTTUwNFkx?=
 =?utf-8?B?ME1yaEQvdDFPc0FnM25TVVNrcllBcUp3cXdlWXJ1dVlrUGsvZ1hqYXZIM1Bh?=
 =?utf-8?B?VUhac0xOK0tSODc3Nks3TmZZeWZDeGJaMk40OGRkN3dXa2lSTnNSRHZra2t0?=
 =?utf-8?B?aWREUzVld1pYUWJzaFBxQTRJbnlrOSsyNUVXRVpXK3MxVTdtNCs4dHpmYkRK?=
 =?utf-8?B?bkk3WE0rckV4NGdIdWRPL1hLV0I0R1ZrLzNxWkVDY1pRTjF5azdJRDBNR0tx?=
 =?utf-8?B?NTRPTFRTNmptS1BDSngzcGRGZ3o2ZXJ1S1FqSFdrekp6UDJ5OFZGa3RoQ2JC?=
 =?utf-8?B?bFE3dE0xYmhXbXRSUzZFYVlWanJ1RDRLOFVILzNmMkE1V1kxYjRVZndLZkFL?=
 =?utf-8?B?RERyVFJnNGdXK0trM25YbG1ZNkdTOTNyS1orOGNNQVBJVEIrbVRjMTVTZFJ1?=
 =?utf-8?B?S1h1MmlkNDIwL0pCbWMxcEkxSWZSZmF6R1dLL2dLODQ1TU54TXFVYWpoZGkz?=
 =?utf-8?B?YlJXZTdyV1JuVkJnaStwZnpyMHozSXhISnpNY0VVQ0R2R1dLMnlFbHhvaHFH?=
 =?utf-8?B?d1MzdkNuc0dnQWN0Q2JzWnRZazhOZHk1aEtpbThIaFQ4ZEtIVkw5TDVxOCsv?=
 =?utf-8?B?NlA0bVFCL3puaU9nR1QwcWhKaVRNcXlXSGFDakdjbmlkYUdqSWdUd2RPNXpq?=
 =?utf-8?B?Qm4xZzRObjMyTnZ4NWN5eFk0cUU2blBjbm1JazR3dmJoUFJiSHRNTSs5RWJI?=
 =?utf-8?B?R0l6VXFzTytOMFNoVFB3V0ZoLzI0VXg4OXQzMlF6M0NwSysxNmdGZ1RPSC9m?=
 =?utf-8?B?WTNVZEQwa3RjQlFBSHYxVnptWGY2akNHZldhRDZtQkZOQ3pwdW4xZXQwemdt?=
 =?utf-8?B?WWRIWXY1V0pheURSNFlNYXFxdzBWcmxYTkVSS0RVcjd1WUVtYnNpblIxWStj?=
 =?utf-8?B?ekxscURnRTA2R3JybTJQWmtzR25OdkQyWkw2ZUdWQXFGeWFTRkplSDljTDd4?=
 =?utf-8?B?V0R5SitXRnFnZnZ5Z0dWUGFXLzRKS05ta1NPVTdqMGFZYzRMRGZwclJCN3ky?=
 =?utf-8?B?RWFxaEd3YVBkaThJcFg4M0c4M3lheHh0MWhKWUtpeE1PVGVEQ2ZncnlYaGRr?=
 =?utf-8?B?TFllRW03Vk1SQWQzbzJaakxVQ1lCOEc3ajFMLzd5Q2VxRW1tc3NzcE9CK3Nq?=
 =?utf-8?B?eGJySVp3cXhIZ1VvdlZ4b2ZJcTBHSWs3RDVSNG9aYklvOE1mdDVGalhVVlZB?=
 =?utf-8?B?ZlhsbmRhR29oeERjL05SK0Fiak81RU16SXh3V0J0aUJubCtTWWYvdU50VDB5?=
 =?utf-8?B?Y3BqYTBhY0VIam9XQTZKNmFCYXZIdFV0cC9Keno4RFFQbTJVSk96R25jWXdI?=
 =?utf-8?B?Vy9NUFNlZ2J5U0lZRnJPdWNDLy90NmhBeXVPUlIwbDN6cHJvSmdaZkRGSGE5?=
 =?utf-8?B?Wnl1WG5FZHFhM1A2bEJOcEVpa3EwOEdDREhITE55cDlsbHJaU3pFakdyOW5O?=
 =?utf-8?B?WGFZME9LT3dJNjdHdlF6WVF2UzhNWFZ1ZmJTY3NyOGhHS3pYRi9hbjBvVHMv?=
 =?utf-8?B?ejl0bUtvMXhuSDBmaWtGc25KUGJPamhDTHl5MkZCN3JuZDRqWEh4alRZaU81?=
 =?utf-8?B?aGN3cXpLMWRoaW5XWUwzd3JJUnhGaGQ5eFNDL0lDczJPdkNyUUxzdWYwSXd3?=
 =?utf-8?B?NlVsNkpOd1p4Ym5xUTRwUkpMRVdiVVc5U3pPalFnamQ2SFhCRUc2Vkgvbnls?=
 =?utf-8?B?ejY0VTF1TkR1bDNkM3VCOUVNUmpSRVJKTEltZ1BIR2x2MHFLYWUzeHdLYUt3?=
 =?utf-8?B?S1FrcDRBbUFnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 845be648-1a8f-47c1-ff9c-08da0bd2751d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 07:06:16.5732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bg5Nl6D7NWTclsBWQ4mK9RftQwy2jJrdWHz+gKpYe4yaM1+23cUmjVgm9qooqd/q/dLaC/asReLc8WM2l8ciZKu6A5VIYf7r6pEeYrk1jvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2087
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2022 11:33 PM, Artem Bityutskiy wrote:
> 
> Let me know if you would remove that backslash at the same time, or I can
> submit a patch.

Looks like the table was merged without the backslash. Rafael thankfully 
removed it via:
https://lore.kernel.org/linux-pm/4731792.31r3eYUQgx@kreacher/

Thanks,
Chang
