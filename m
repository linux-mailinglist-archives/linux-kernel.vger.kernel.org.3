Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266C25AF04C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiIFQWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiIFQWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:22:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FEB88DEA;
        Tue,  6 Sep 2022 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662479448; x=1694015448;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MmtupbQVoleGylosPPA8hqScPfbuh+QUNUjEeIS7yZo=;
  b=Im/6/mGvp3gmcWEv0lHXqJgzIyVloHisJ5YL31SeRuHnLWuIUrOYBEXk
   tNTOZ7ZYIWgP5U3Fjdr8HAJsiJf6clzBCyRoo1316hpURj2MXKqeK1bY5
   o98VwkQ6uxjwy0jbYsYSo/16+fQZv8jxUY4nE5HrnZ3/8lE4gX91KihU/
   RCdCkveitETV6PqEK3vcwd5kZcHVpXtq8Y7g6xHN6dgTFeviwUoMmvAOQ
   I5etPzNdaaY4JPTauWH2G29y5kFyR5ujbNQvNG1fQV6IO2gc7lQ2T+DCH
   BrcDhyF/eykp3mpE0zQAWl7c6JOx31cn70kqVMmhIEGSHM09Z4b5v6GnO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="322805084"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="322805084"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="739942908"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2022 08:50:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 08:50:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 08:50:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 08:50:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 08:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVBP5ucJTRkVIC22ARHZIxhYOxzyUXU7ykma022gX/FYRuhm5xqWUKAA6cRWv4RFMUMbw13iceQXOYNoC8B/PoehXUKDUj4Y0ajZ1emQXfnhkF5eq09JykGvij94jYkjIuH0P8Q9LLlBtZ1nnzIoZc1GJavf6WtEjSp3nQ6bJ58UGJBPtJp4dx5TYsrwPty5+Yt0lbgFWr7XDsNYVxyCQNb4UIgUkEXyrXi578ZqD27fUxABNgAYFCzDsj2OBoy5OO6HZqaQmU4tBeVBAithmYKPts3VNqzaOZixGcHzvuvIsIYUmcfmHzubZFx6YZ3qpbLkWbvu/WGo/fRCL+6M3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liN8jIHLfWAmPa5rGsI42NxablikhQPQKSof/VpGS00=;
 b=Ph/VFzGhD769mdVgddfyAvpdKtiYV4QuMQ293BWrRpZe1ZTeyYkzD2/XA0vWhyURHLTeDO10Hr5oJF0ixZ/DSSmLL81Il844BQ6E7IUkZccJkopbkImvvtl3GHK0/qUvtYkWiK2KHfYKa2roNXW6hjdMB9Y0Mfl34hYQTAF9VM9d0hh+Lo07Do3bUpleTQSqRih7OATpZTqqVwvAvTilhwetnwOGKtCM+0nyAKV0sH0u1ewrPy/RqT3TKJFVoqYzrK1NGMCvGGU7hc/kD20lFPiiL89bEEdC7jajGHHZJdugoGl8lem7XRitorTk/5aDIK1fN/E3XZEJVX6bi6eFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5424.namprd11.prod.outlook.com (2603:10b6:5:39c::8) by
 BN7PR11MB2753.namprd11.prod.outlook.com (2603:10b6:406:b0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Tue, 6 Sep 2022 15:50:40 +0000
Received: from DM4PR11MB5424.namprd11.prod.outlook.com
 ([fe80::850b:fa11:b53e:c5a4]) by DM4PR11MB5424.namprd11.prod.outlook.com
 ([fe80::850b:fa11:b53e:c5a4%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 15:50:40 +0000
Message-ID: <7eec0b6b-060b-159a-e334-6fafd0cb2a9f@intel.com>
Date:   Wed, 7 Sep 2022 00:50:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] overflow: Allow mixed type arguments
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Andrzej Hajda <andrzej.hajda@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-hardening@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        <linux-kernel@vger.kernel.org>
References: <20220830192147.47069-1-keescook@chromium.org>
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <20220830192147.47069-1-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:a03:331::28) To DM4PR11MB5424.namprd11.prod.outlook.com
 (2603:10b6:5:39c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b7de37e-1300-423c-b6cc-08da901f8cab
X-MS-TrafficTypeDiagnostic: BN7PR11MB2753:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yBa5xVgTgPHhhACjQlqIjDn+jd7OaXKO40xACfmyGSN+h7EePzSt9FdyI+rDWsolYWmra+Ti3m9dzzBsCfO9HdfO6msou9FWZnU/Wc0iB62Sjs7HxBoeorg6gcXFWVW2bFrTZQb86YOrMqMNNBQdrmxm+eSRr1Immu2ACOt49DpQBTLUnSj3y/gj517hcspLFg7ftLB2l8R10l5gKC5KCyknFNMOEy8VJf5D2cYkfFeiCZTp6qsR2LV6clN3GxwrcunNwHaIzqrgn8ROs/b7ZZWccIYrCF3j7Ef5G3YcSelitLA8I7SCZFJzE8uWLxWF8MIP1/CWIpdfsP5oJSGOCnLxBnYL+4muyFg/Tg1G9KaXjgAPCFq3VON7G2w5vS7aUQHcU2fbkRg0uaK6NLZNGbeSA4QohzzBBbuxJbHvTMELUU93/UykIOVCfyL6mILFSJXTGieeKDUoYeKWEdgCCZAQv0fI/CFN2f6C18uf+0/jBNAw4g6JDZlG9mBzSpP1cibGUUmR3IoEZwNlqsgAzYDmUPhcHuqscXhLqxcsASj7399RXftwZOPxT+MqngwJNkbM3H/IFeZH6g2f3iNBSdYfB7lMR/liyFlpCwrDYDCWMoSWMqUyOmebhxAxVXs0HzyJkzcyZ1NiWZAI9IFwBpWEaZh0/0JJq6oOIXL58z94GNhhRFpoXfgkIORAfJyL0rV7WeNNG80MmzkCVrtVBRa93OtPx2yT7/vCV0dy+yaDJsK+HsCipMkeLwTNxHtCWGkVeoPnKdARLNzqzI2Yx8IxJeQs5SbgD3ysT7P9oK3soI0tJYz3QP2wT37xOFNwptXcvhl/9/WKpE/lTM25rRDtylbGEuX2BN2nNIc5Sk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(39860400002)(136003)(376002)(66476007)(966005)(66556008)(38100700002)(66946007)(4326008)(8676002)(478600001)(316002)(6486002)(31696002)(2616005)(86362001)(186003)(6666004)(8936002)(30864003)(53546011)(6512007)(26005)(6506007)(83380400001)(2906002)(31686004)(54906003)(82960400001)(110136005)(5660300002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNoTDVyK3crVjVRbkRGZVNzV2cyWkVxNWd4UzhpZWZBR0xmWVZaUjVCYnlX?=
 =?utf-8?B?aC92UmlOczZlbHRIckF5cHZ2dkxqbzFjSTRQQXBvV0JKMjlNT25kTGJuNFNo?=
 =?utf-8?B?N2dLSkk1aEoxd2JUempRRlpvd1RoYXljMFFpTVJILytUeHA5aEgyZ2IxTU5a?=
 =?utf-8?B?eEpwOUs3aHVQNS9PYkVwckNNNEpUUmpHNnRCTk1wL0I1SllRcjl6NmRSaVQ4?=
 =?utf-8?B?SDdmTEZ1OVhmSWx1UDErSGtMUUdhYk5oejY2OXc5bFM0V0cwYlBvU0JXTnRW?=
 =?utf-8?B?ZHdzUW5tN2xPaVF5ZzloTGJ6WE1CNlF2Z25ZWFRsSUVuZ2ljRzZnZkVURzdW?=
 =?utf-8?B?R253OVdjbVo1SENxY2FjZ2VlWGhZMXhOTHowUDdIVk44UEpZNVphdW5sY0lu?=
 =?utf-8?B?M09pZ2ZtUDdyZGozN3U4VmZTVVptNnpYb3o2MGlDZ0RxbXJ3QlprZGFQLzVL?=
 =?utf-8?B?VWVzWlFLa0l3cDJPNWk2V3gxeE9BUVIwYU5tQW1CS2E1YWFUcHdILzEzQ1A0?=
 =?utf-8?B?SEZQY25mb0NTSDRQK1BvYTdxZUVzcDlIdzF2eVBaK2ZOVEZ1M3UzZnBjNzVp?=
 =?utf-8?B?YWt5a2RlSnZrNnlKUlRvdFFUYUVSclJQcFlFalVldHp0WHhOeERkSmRnVGFC?=
 =?utf-8?B?bHh5L0hlbStsY3gxcnBHMzFtNm5sZXNsYUZ1WVlTVXBNU2gxWnFGUkdmVjZU?=
 =?utf-8?B?ZGxFbGFBNzlFY3AzL3dBS0VPMGZveWJrSUJxMHJtWFAxa1JzNjcvZkw5SVZF?=
 =?utf-8?B?T25adlZuMld4Z2xDRVI3V0o5MTJ4bTdPWU9mandQdnVuMW02clRnU3ZVZlp2?=
 =?utf-8?B?WXNTd0g2U2I5M2NwR3VweXd5aDdIK0ZDZlpCVlZFbFFOdFA3QjVoelVyWXBv?=
 =?utf-8?B?dVNuR0NXTjh5bElHdklTWmlkb1NTbm42ZUo1OEx3RjB2RWMvNHNsQk1tUkhV?=
 =?utf-8?B?dk9ZUFdYeDFqbVJmUmpxNDVxdEV6c1p6SzRoNU9GRHpIUWx3RDM2SEFYTHc5?=
 =?utf-8?B?a0tGaW9LbHdGcXdHRHJPeWxGdlVCdkhLWmhZTVJsWWI5QTdyTHY5eW02MEVa?=
 =?utf-8?B?cmM0b2diczl4QzduenNzT1NlbHErY0hoSDBPeUQwUDEzZTJxT1BzMVRhdnp2?=
 =?utf-8?B?RUR3VW9wbC9ldUlxY20rZVVyRWw4aGlPajZWM2NHL1lnS1V4YVZ1bW1uKzI0?=
 =?utf-8?B?LzM4RElUNzhGckpLYTVwa1pob1oyRVJCbTR0NVJUb3lhU2RKeWlHN0tiWmFp?=
 =?utf-8?B?YVgwdGRDNmd2R2ZBUERkKzMraXd3M2tjQWlaYzliODJBVWk5OXY1SXNnN0pt?=
 =?utf-8?B?LzZCMDZzVGlJQzZiMGt3ZThmQUQzYTc2V3pUSE9jUXM1N1dMWTc0OEV4VmZJ?=
 =?utf-8?B?R0g4RVUwUXZiS2lFY2hnajRDWFV5M1NQTG5CZjNoclRnbmcxa3RQQ09acnFL?=
 =?utf-8?B?R1BqOXVsM1ZMc051dVlYM084aGM1SlYzb0lDYmlYQ0RreFZyaExrMUpPait0?=
 =?utf-8?B?dnBLSTdEM2pFMGpqYTZDRlI5eEpFYmpUcWt6VzZCcXppUFJrSjlsVGUrVVlK?=
 =?utf-8?B?SFY5NFJWaENxN3crL3NqcnZjaWo5MlhOdWl3d3ArOUxscDY3dWVkOU9aaW92?=
 =?utf-8?B?TU04c1dFVVVSU05LcXdOMEdsM0ZOQjlwd29MYVlvbXE4Wm03MHMrNDF5aUhv?=
 =?utf-8?B?TXo1dlRiUktiWkliYjc4VzUveUFLekhQSVcxc21GMVlpVGp3U1cvWTRkYldP?=
 =?utf-8?B?Qm5naU4vRHNBamNabWF1OFAxSEpUVVh5R3Bjbk5QaVRsR0pabVZJUGEwSXVx?=
 =?utf-8?B?ZTQvWGUzSTB5Ty9LY2dsUWNsWEpZOUNoUjBZelBxR0VlaVNQcTM0TDhxZjBU?=
 =?utf-8?B?WnY1NVd3SnVDcG5pYzVHSm5tK29YWFBUQUlnRDJKdjVZdFBqT2FLdTFYeDRn?=
 =?utf-8?B?cmxRTXFGczJkeFlNakFGcDA3NHc3NWFkZG9lZFRGZk83dTVSRFJodll2TTZQ?=
 =?utf-8?B?Qnkyb3FOQ1FqdEoyMUY0MThSOXRqRjlQdVVvN2RNa3R3bjRZc3c2a2wvd0w0?=
 =?utf-8?B?SU96QUxscWRDKzltOU5ES3NrcXBaMzRJR3NzeWorWVB3MTdNcmYrU0Z3NUc1?=
 =?utf-8?B?c0lpbGQxODVaVEZvMHIwNlpma1NZV0ZuVDBNMEtMM1lwS2NTN1loY2N4anpH?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7de37e-1300-423c-b6cc-08da901f8cab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:50:40.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Hmiqpj9bc+v8bVsnxmy0Qg7Q+VTwWFpA+B+8AkcbATE+B4o7NOq9Gu+GDjDniMhietY7Ep2YR9cqx7g51BHP1QAt3bIdltousSKQAxFFQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2753
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.
Tested with overflow kunit test
command: ./tools/testing/kunit/kunit.py run overflow

Reviewed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Tested-by:  Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>

On 8/31/22 4:21 AM, Kees Cook wrote:
> When the check_[op]_overflow() helpers were introduced, all arguments were
> required to be the same type to make the fallback macros simpler. However,
> now that the fallback macros have been removed[1], it is fine to allow
> mixed types, which makes using the helpers much more useful, as they
> can be used to test for type-based overflows (e.g. adding two large ints
> but storing into a u8), as would be handy in the drm core[2].
> 
> Remove the restriction, and add additional self-tests that exercise some
> of the mixed-type overflow cases, and double-check for accidental macro
> side-effects.
> 
> [1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
> [2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com
> 
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: drop needless local variables (Andrzej)
> v2: https://lore.kernel.org/lkml/20220829214550.3443472-1-keescook@chromium.org
> v1: https://lore.kernel.org/lkml/20220829204729.3409270-1-keescook@chromium.org
> ---
>   include/linux/overflow.h |  72 ++++++++++++++++------------
>   lib/overflow_kunit.c     | 101 ++++++++++++++++++++++++++++-----------
>   2 files changed, 113 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 0eb3b192f07a..19dfdd74835e 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -51,40 +51,50 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   	return unlikely(overflow);
>   }
>   
> -/*
> - * For simplicity and code hygiene, the fallback code below insists on
> - * a, b and *d having the same type (similar to the min() and max()
> - * macros), whereas gcc's type-generic overflow checkers accept
> - * different types. Hence we don't just make check_add_overflow an
> - * alias for __builtin_add_overflow, but add type checks similar to
> - * below.
> +/** check_add_overflow() - Calculate addition with overflow checking
> + *
> + * @a: first addend
> + * @b: second addend
> + * @d: pointer to store sum
> + *
> + * Returns 0 on success.
> + *
> + * *@d holds the results of the attempted addition, but is not considered
> + * "safe for use" on a non-zero return value, which indicates that the
> + * sum has overflowed or been truncated.
>    */
> -#define check_add_overflow(a, b, d) __must_check_overflow(({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	__builtin_add_overflow(__a, __b, __d);	\
> -}))
> +#define check_add_overflow(a, b, d)	\
> +	__must_check_overflow(__builtin_add_overflow(a, b, d))
>   
> -#define check_sub_overflow(a, b, d) __must_check_overflow(({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	__builtin_sub_overflow(__a, __b, __d);	\
> -}))
> +/** check_sub_overflow() - Calculate subtraction with overflow checking
> + *
> + * @a: minuend; value to subtract from
> + * @b: subtrahend; value to subtract from @a
> + * @d: pointer to store difference
> + *
> + * Returns 0 on success.
> + *
> + * *@d holds the results of the attempted subtraction, but is not considered
> + * "safe for use" on a non-zero return value, which indicates that the
> + * difference has underflowed or been truncated.
> + */
> +#define check_sub_overflow(a, b, d)	\
> +	__must_check_overflow(__builtin_sub_overflow(a, b, d))
>   
> -#define check_mul_overflow(a, b, d) __must_check_overflow(({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	__builtin_mul_overflow(__a, __b, __d);	\
> -}))
> +/** check_mul_overflow() - Calculate multiplication with overflow checking
> + *
> + * @a: first factor
> + * @b: second factor
> + * @d: pointer to store product
> + *
> + * Returns 0 on success.
> + *
> + * *@d holds the results of the attempted multiplication, but is not
> + * considered "safe for use" on a non-zero return value, which indicates
> + * that the product has overflowed or been truncated.
> + */
> +#define check_mul_overflow(a, b, d)	\
> +	__must_check_overflow(__builtin_mul_overflow(a, b, d))
>   
>   /** check_shl_overflow() - Calculate a left-shifted value and check overflow
>    *
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 7e3e43679b73..0d98c9bc75da 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -16,12 +16,15 @@
>   #include <linux/types.h>
>   #include <linux/vmalloc.h>
>   
> -#define DEFINE_TEST_ARRAY(t)			\
> -	static const struct test_ ## t {	\
> -		t a, b;				\
> -		t sum, diff, prod;		\
> -		bool s_of, d_of, p_of;		\
> -	} t ## _tests[]
> +#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
> +	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
> +		t1 a;						\
> +		t2 b;						\
> +		t sum, diff, prod;				\
> +		bool s_of, d_of, p_of;				\
> +	} t1 ## _ ## t2 ## __ ## t ## _tests[]
> +
> +#define DEFINE_TEST_ARRAY(t)	DEFINE_TEST_ARRAY_TYPED(t, t, t)
>   
>   DEFINE_TEST_ARRAY(u8) = {
>   	{0, 0, 0, 0, 0, false, false, false},
> @@ -222,21 +225,27 @@ DEFINE_TEST_ARRAY(s64) = {
>   };
>   #endif
>   
> -#define check_one_op(t, fmt, op, sym, a, b, r, of) do {		\
> -	t _r;							\
> -	bool _of;						\
> -								\
> -	_of = check_ ## op ## _overflow(a, b, &_r);		\
> -	KUNIT_EXPECT_EQ_MSG(test, _of, of,			\
> +#define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
> +	int _a_orig = a, _a_bump = a + 1;				\
> +	int _b_orig = b, _b_bump = b + 1;				\
> +	bool _of;							\
> +	t _r;								\
> +									\
> +	_of = check_ ## op ## _overflow(a, b, &_r);			\
> +	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
>   		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
> -		a, b, of ? "" : " not", #t);			\
> -	KUNIT_EXPECT_EQ_MSG(test, _r, r,			\
> +		a, b, of ? "" : " not", #t);				\
> +	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
>   		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
> -		a, b, r, _r, #t);				\
> +		a, b, r, _r, #t);					\
> +	/* Check for internal macro side-effects. */			\
> +	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
> +	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
> +	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
>   } while (0)
>   
> -#define DEFINE_TEST_FUNC(t, fmt)					\
> -static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
> +#define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
> +static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
>   {							   		\
>   	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
>   	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
> @@ -245,15 +254,18 @@ static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
>   	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
>   }									\
>   									\
> -static void t ## _overflow_test(struct kunit *test) {			\
> +static void n ## _overflow_test(struct kunit *test) {			\
>   	unsigned i;							\
>   									\
> -	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
> -		do_test_ ## t(test, &t ## _tests[i]);			\
> +	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
> +		do_test_ ## n(test, &n ## _tests[i]);			\
>   	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
> -		ARRAY_SIZE(t ## _tests), #t);				\
> +		ARRAY_SIZE(n ## _tests), #n);				\
>   }
>   
> +#define DEFINE_TEST_FUNC(t, fmt)					\
> +	DEFINE_TEST_FUNC_TYPED(t ## _ ## t ## __ ## t, t, fmt)
> +
>   DEFINE_TEST_FUNC(u8, "%d");
>   DEFINE_TEST_FUNC(s8, "%d");
>   DEFINE_TEST_FUNC(u16, "%d");
> @@ -265,6 +277,33 @@ DEFINE_TEST_FUNC(u64, "%llu");
>   DEFINE_TEST_FUNC(s64, "%lld");
>   #endif
>   
> +DEFINE_TEST_ARRAY_TYPED(u32, u32, u8) = {
> +	{0, 0, 0, 0, 0, false, false, false},
> +	{U8_MAX, 2, 1, U8_MAX - 2, U8_MAX - 1, true, false, true},
> +	{U8_MAX + 1, 0, 0, 0, 0, true, true, false},
> +};
> +DEFINE_TEST_FUNC_TYPED(u32_u32__u8, u8, "%d");
> +
> +DEFINE_TEST_ARRAY_TYPED(u32, u32, int) = {
> +	{0, 0, 0, 0, 0, false, false, false},
> +	{U32_MAX, 0, -1, -1, 0, true, true, false},
> +};
> +DEFINE_TEST_FUNC_TYPED(u32_u32__int, int, "%d");
> +
> +DEFINE_TEST_ARRAY_TYPED(u8, u8, int) = {
> +	{0, 0, 0, 0, 0, false, false, false},
> +	{U8_MAX, U8_MAX, 2 * U8_MAX, 0, U8_MAX * U8_MAX, false, false, false},
> +	{1, 2, 3, -1, 2, false, false, false},
> +};
> +DEFINE_TEST_FUNC_TYPED(u8_u8__int, int, "%d");
> +
> +DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
> +	{0, 0, 0, 0, 0, false, false, false},
> +	{1, 2, 3, U8_MAX, 2, false, true, false},
> +	{-1, 0, U8_MAX, U8_MAX, 0, true, true, false},
> +};
> +DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
> +
>   static void overflow_shift_test(struct kunit *test)
>   {
>   	int count = 0;
> @@ -649,17 +688,21 @@ static void overflow_size_helpers_test(struct kunit *test)
>   }
>   
>   static struct kunit_case overflow_test_cases[] = {
> -	KUNIT_CASE(u8_overflow_test),
> -	KUNIT_CASE(s8_overflow_test),
> -	KUNIT_CASE(u16_overflow_test),
> -	KUNIT_CASE(s16_overflow_test),
> -	KUNIT_CASE(u32_overflow_test),
> -	KUNIT_CASE(s32_overflow_test),
> +	KUNIT_CASE(u8_u8__u8_overflow_test),
> +	KUNIT_CASE(s8_s8__s8_overflow_test),
> +	KUNIT_CASE(u16_u16__u16_overflow_test),
> +	KUNIT_CASE(s16_s16__s16_overflow_test),
> +	KUNIT_CASE(u32_u32__u32_overflow_test),
> +	KUNIT_CASE(s32_s32__s32_overflow_test),
>   /* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
>   #if BITS_PER_LONG == 64
> -	KUNIT_CASE(u64_overflow_test),
> -	KUNIT_CASE(s64_overflow_test),
> +	KUNIT_CASE(u64_u64__u64_overflow_test),
> +	KUNIT_CASE(s64_s64__s64_overflow_test),
>   #endif
> +	KUNIT_CASE(u32_u32__u8_overflow_test),
> +	KUNIT_CASE(u32_u32__int_overflow_test),
> +	KUNIT_CASE(u8_u8__int_overflow_test),
> +	KUNIT_CASE(int_int__u8_overflow_test),
>   	KUNIT_CASE(overflow_shift_test),
>   	KUNIT_CASE(overflow_allocation_test),
>   	KUNIT_CASE(overflow_size_helpers_test),
