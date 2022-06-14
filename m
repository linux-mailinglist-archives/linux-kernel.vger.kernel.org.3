Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394BB54B792
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbiFNRXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiFNRXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:23:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8E52C10D;
        Tue, 14 Jun 2022 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655227390; x=1686763390;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7RTOnMQCQp2PTW8G37tZ3HlBkPz45R17CfJq54E8zk0=;
  b=m6GNCBAek8XtdrjRe6tqa4/LS9P70AY7SvaYw5X+0/CSL1w+dgtQadDq
   C/yn6ALwy2Zxq5tyDrrdkTFEDPFbgL4/h/Y0GLZkoxDFdveT6BI+m6dOg
   dUNwm5m5eLRBDe7gxU7w/CEIlqW5+IpJM0aEYTbz+uatQVFziHOdRIj3A
   BoAu/nn/Jqi++LYDaAwYwIHQiSUsXh+YDbXwA0RCP7zoLyVVCYS2nC0C6
   Gsa8dAW6BwQgROzhBP6W++uoM8GSocnwT6r166oF3/kEAbzgmM+LZN/Jw
   gv1xXtQFQYkf7CLps9LBurNFyQ8E3cMoRXG5X8lJt0Op7KtdhWd+/5Dt2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="258525792"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="258525792"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 10:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="570099189"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2022 10:23:09 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 10:23:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 10:23:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 10:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqgwzjQmPwDJJKTyK95GgEMR9HZY1WGr15PFXuysypYj0FAbee6FSgAf8N/NGLifY+37m9gBf8eXrYXsbvoyTe7WV/Z+5Ar+jiUEx5NNadfjx3h5VOeDdmVZFGQcIOOtv/gxY3pkVha0fci91y+vLbciyyxreIxAMIoLmqwZubPC/XxbShaJCx000twD12nqHXkxutBhHFK9gHA3wIAHX7Mf49+PiQg4dLZwQYE9vmhMcTM7cieJmu5teRe760qs1zF1sfGpJYukxjF5/iKW+YTgS3ZqNZDKXt49M3oMnNwqxxeVhI3rlXnv642o2hQvFgtJaQgq1/xWkipQsJfJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU99lTH4Lnfoq/yfKVhw1Kt0icaCIfkMuG++vfl5LHw=;
 b=Jhnb4+31zDn/QjHut/XK13MKpScOiIykg8jNRrUu0E+Aff3OKEOAgBnETlROTbVDlPgnGHBH7gtT00Yu/IG5igL9XCAmGUcTo9Dq0c4jMUXMKsZS2nlUsXar2u5hlsaMItTAoctid3AEc6+dg6xLGyJujn+nj473xBJuad93hKP5Yt2lWCN1ufdU8emXit0T3EtqmwthNmcuL9ZChQpWqhc8i0QsfjqD/WuRGM34q6gV2Q+xImXPukQAfreQDCF4pqRN1QjwqZM/RJfGq/dITdPywGTVyBEY3S7Wa95O36wQfk7sQwU7Fuykm4Dq5B240sCSZcjDphXMlJdUWxADIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by MWHPR11MB1293.namprd11.prod.outlook.com (2603:10b6:300:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 17:23:07 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::1c70:a7e4:c7e5:1c9c]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::1c70:a7e4:c7e5:1c9c%8]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 17:23:07 +0000
Message-ID: <b5dea7bb-239d-9054-7130-03a9d1421bf5@intel.com>
Date:   Tue, 14 Jun 2022 10:23:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/2] intel_idle: Add a new flag to initialize the AMX
 state
Content-Language: en-CA
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <tglx@linutronix.de>, <dave.hansen@linux.intel.com>,
        <peterz@infradead.org>, <bp@alien8.de>, <rafael@kernel.org>,
        <riel@fb.com>, <bigeasy@linutronix.de>, <hch@lst.de>,
        <fenghua.yu@intel.com>, <rui.zhang@intel.com>,
        <jacob.jun.pan@linux.intel.com>, <lenb@kernel.org>
References: <20220608164748.11864-1-chang.seok.bae@intel.com>
 <20220608164748.11864-3-chang.seok.bae@intel.com>
 <38cd51750ef7b995506d001eae3e4ec872cf5b77.camel@linux.intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <38cd51750ef7b995506d001eae3e4ec872cf5b77.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0fbcaaf-4a59-46ad-2361-08da4e2a8c09
X-MS-TrafficTypeDiagnostic: MWHPR11MB1293:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1293F6AB1D69A0B62F7C009FD8AA9@MWHPR11MB1293.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiERxTxkpuLuaZ4kLmaKK7MU5+2TrxofqgSgvB+J6BCeC/ak6z+REPVjlpYDfR68L1iL36awYCtspXxZUZZrCQE1QcPIR5xojZCmRGr2a/5vx1akqEtTTSFwS7QrjtckLm+ykntVkc9oUaV9CpFrmxr0pw1giDNu+2er9/9g6z2iHmDp6YcTbByLji7H1cJ2jDGCVRclL4sZ3pYO5LHqRwq/BburqmJ3VBEkZo20AWqPiibRBsuizX2crPm0kDYm7OXJtc4lHvfzJqtBcRGxInagn0zjvmqv7GRxC8Ax28Ippv0hCWvOGUCm+q3STh/JHp+JreuFwMZvnNuKL8R+xGU9NIcQeZlg5AwHLshhODqP4vGV80MOMXlQYX+j67hBjP0vNjS4u8pAFuyigG3BJP4fGROmflJ2KZx1orozsUpR/Y38qBGZdQQIwes3J3c6qebIJsbIhgwo2ZiZHyJusARo4VJQYdr3nR3R47qKpKR7jU7W/ptvmlc59BwsKJdX9mAqplWXL9UOv3cfpFclr9ndR4OcjjbU22k5iMdxgwtC5p62jTE6l4YH5+/tE3hfUdqRelRDRgAQCWWygUVJqp5sBoUsyXaPoSl/OzodQkEF+dLlET5bpCaGOJLceL8G/zrBts7rrJeQBgXVmgADgmAhlboyCyagAGnCtJYsZZbCGOYXwrF33smx7/zKPyXEq0ZBTjzRfMrg2Ia3/+dWBUev8O7eWKFWWV5aTNs3QAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(38100700002)(86362001)(26005)(31696002)(7416002)(8676002)(4326008)(82960400001)(8936002)(66476007)(5660300002)(6512007)(66556008)(66946007)(53546011)(6506007)(2616005)(2906002)(6486002)(508600001)(31686004)(36756003)(186003)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxEc05GbVVXMXA4ZWU3dHgvaEZnV0s2VENTVnlIZGczZWppWUI3dGs0TmFu?=
 =?utf-8?B?NVVWd1JHSWM3MjYvRmROaTgxZXNUVjNHaS94cGh2bWR3aXl5YnVzdzFPYU1O?=
 =?utf-8?B?bjk0emYwbW9VNEx6ek5aYkdnL2IvcmptSHVENTZVbVFzVHZPSllXTWxuVC9Y?=
 =?utf-8?B?WmlBRkhTZ2pjVmN1cEVwMlF2b2VSak1PV2hLYktRd2s3V2doWDBIUmM1L0JG?=
 =?utf-8?B?SVY1Q3ArZEh4MEVyN2xPZ1lxS2luOGFNeThJa0ZqY2JodWlyQ1ZjSEgzWEQ3?=
 =?utf-8?B?aUFac2JkcUxlRCtHL3RObnBTdTAvemFXWnd1ZkZaWDJNN0hKR3VtWm02aGNY?=
 =?utf-8?B?SHFHQXowUG5ZdGhXQjA4aDBEbnRlaVgxdjZSZHFZWldYai95bW40YkpSMGVs?=
 =?utf-8?B?Q210VGxJSmRpdDdSZG9NT21nWXh0bzg4RitHbTBPaEFtYzdKZC9YNC9ja0FT?=
 =?utf-8?B?UzRpZExoL3RmT290a2lWTnBCcGlKaVV5TEhuZ2pybEMxSWNPWnAybFBMMGFH?=
 =?utf-8?B?aWd6cS9iT1dzRnpDSTFhWmJlcCs4cFF0eXZ3RjJWV1o1QzN2Zi9QdHNrNUox?=
 =?utf-8?B?TDIyRndGT0tqOXFBaFJ0REh2aWF3clJLRmoxbkU1RzRibVMwVnJWdHhwdzV1?=
 =?utf-8?B?b1VRb2t2RFRieXFFUEh2RVFUcUdjd1ZCa0QwQUQ2UzdzQm1icWtwSTRNUVVk?=
 =?utf-8?B?bkgrZDdZdDJBanVoUU9pUUt5YmFhSCt6c0hGSVZXeWdxMkJmZSt5djYxYit0?=
 =?utf-8?B?anRoM2p1bTRyUC9keFdSKzl4UTFMK2FYZ0FaaWYvc3A0cEIxTVdVRk1INEZF?=
 =?utf-8?B?T1NCVjlIRnlnSCs2ZE1hTzNTeEFhQkJXMVNYTnA2TDdOK3BXVDMvRFB1aFZG?=
 =?utf-8?B?Tm1ITjBxZ0FXM2hmWHJISWpWcnFtd2JrRVVPQm9ZditsRXI0cmZRYjNvQmFB?=
 =?utf-8?B?Q2NnOUVSQU1mZjdUamxXNVlETm9nOTY2Wi9hTEdlR29hdUJreTRoZnAxN2JD?=
 =?utf-8?B?bURtd0M0ZHZRZTlPbFRFZ21RZXBHbzhYQ2hQcFlPSlVHOW5SUDcyNG9YNDVQ?=
 =?utf-8?B?ckpzdzUwUzV6cmE1dXBZOXlBZHBvWmFZMFNqbis4UE5KUGd6RG16UWhFbXpM?=
 =?utf-8?B?SHdSUTk1MnBncTI3VThFaGh0djZ0Mnpsa2lTODZXRVI1dzJJUlZrdTBEWVVx?=
 =?utf-8?B?K3BRZXY5a003eW1qYXBWc0xYMDBydytjL25qVzlvdHVVVmh2TUNMVGVSSEtk?=
 =?utf-8?B?OTdscFRqQmlHVjg2bEM1K1RnK3BvUzVCc21TcExkMENBOXNERnF2bUdnQnpm?=
 =?utf-8?B?RnBuak10RE1aK3E3MzMvZ29BamQ3OUVUZ2pCWFdYS2RkZUhCTStoUWdDWnRl?=
 =?utf-8?B?OTN5cGc5VXM2Ni9YekIwd3RDbkRGNnkrVVIyd3pQY0V3dGpXY3RJUXN5eVBa?=
 =?utf-8?B?V0o5Y3VSWnpGbU0xc2JFczdQSmhSb1FLY2pxM1h5ekdSUjlkRWppV1NpZFZ4?=
 =?utf-8?B?WTd0SGNHNUI1bU5uZ0cwa2pFcEprdDFoaHZoZjZkMG4xaFphTEhYakdoU0ln?=
 =?utf-8?B?YmVIdUxLekJKK3pkcGlqWjEzT04vZ0ptc3R2L3Qzc1dtRTBJdXhaak8vb3Ni?=
 =?utf-8?B?U05CMUVYTkJzOEJIUGNVV1pHUVNvckVNalNZNytuVGRKNE9XbXBXYkFSV1Qr?=
 =?utf-8?B?UHBqQWpuVFlDdHY5cHF6YU41R1R5RWxRVE92bXJDSEZ5eExVUS9sc3YwdU1z?=
 =?utf-8?B?QUVpeVVMbDE0MHNleU84dk05WG1UZ0tPWEg2UXNUNUJwKzIyOVVWVlV4N0tp?=
 =?utf-8?B?RXY4SGV3dzdwUzVZTEt5WjNZM1BhR2x3OHd0c2M1bjF0NFdEakxZYkZSWnh6?=
 =?utf-8?B?RlFDMUlONGQzQ0psV2hkN1VXYWNWY2hON0NWVVFYd1F1amgrZHdSSlJUdU82?=
 =?utf-8?B?bGtLaTdiUVkxMXVqZmdZVVZrTW00aW8rWmVOUFVpNUptcE1YVkdsZ2NzdWNp?=
 =?utf-8?B?WUY5Y0Z5TG9FM0FLUXBOeVpEcjJjY0tpYWN6TEFVUjEwZWpPT21lRFBLVXJx?=
 =?utf-8?B?T0E3MVhLWGRnMHJING5USklQU0x0M1pIa0Y3MWtUUzY2a1ZxMnU5U29PenNO?=
 =?utf-8?B?Sy9GRjFvaDdJNmhMZ0NVSU52RGZ2MzdYRjFORURBM2hicHRKZmNxT3BUbCtC?=
 =?utf-8?B?cVl4aDFQcnJKdTJqdXBGWG9QWitpVmk5a3UyanZlWDZ4V0tZWEJidEVJa3M4?=
 =?utf-8?B?RnZDdnFZOVNldXlnMjZZekF5MC9TNmxRblRLbjl4TWhwK0hCRVViUlVYRXIx?=
 =?utf-8?B?K3ZSNlNQOHIxSjVqZ3hBWEJiRk5RRnlQZHpqeFR6NTZpL3o0KzJiUzJKQ1Nz?=
 =?utf-8?Q?w8acSRZ5T4yNFUJg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fbcaaf-4a59-46ad-2361-08da4e2a8c09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 17:23:07.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUi5j+U9Zx5rppNCORdrpyZ84Wp+9cOB8eAh63JTSwvnO/q3Dp0bri0ULu8w/T86YkGX6niuRs5QC92X7vccFIF0LfzxyfOI6L9K7e5vPE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/2022 3:02 AM, Artem Bityutskiy wrote:
> 
> LGTM,
> 
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com> 

Thanks, Artem!

Chang
