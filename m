Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB207596CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiHQKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiHQKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:46:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9567153
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660733174; x=1692269174;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RLA4ZUEWxQnAXPlAcYv2dn/N9ybgJrCo2ZPhxlNGpUI=;
  b=BJON/6RNPVBvD4zFG28rgXghNV95CjsjCsLOFAM8vooYDT4Ld9V1IvGM
   YilzLarknxac0/NpI4AM2o1gKBZ7pgdRlme3Fn2kctG4P/Z5JuZBplCZG
   /cIg/ylvXaYJDjxySKZjnyVBKjB8UYdm5e0jfGZgY3PzOTndgj+kbdMQ3
   OeM9XVtrrVRQgsPG4MsB5bjkpvW+nUb9EIpYB/RTRKme3QK8xNFDaWSgq
   i6S178VQsn2xxa6vR2R3Vdd+WP1RBkUzAuShybb62LvGw3QpCQwetn0ko
   tabU4ZNjlpUEyE2NCYPZSUi7uG9uhpcy9ekf6hvpE3iGLM0kMbK9VDj8i
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="279426262"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="279426262"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 03:46:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="610602824"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2022 03:46:13 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 03:46:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 03:46:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 03:46:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 03:46:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFmwclIr451MK2nJBVLjq4bE4nDkB7hV3FpmD0ke7WYTCFHquifQtt5GjRWz+AuMapFn++SKHt6RuPh88jJeVGX4wtIPe7HkXf87j2O+DVX7ZhwbPNgJE1RFfBqWr5SwYK9G+Kc25xPTLC8UL/jCCd3zPYyojiPhj4qRZTMlTiytpYWirSKVpe8TTjNb8dlxEhPe7G22rHclJ6Swb5McjHnnlw2cTmNnnrXq/f5tU6LPFv8sP9Sr3Z7tjX5bW7aXmQqPkSYwXqquHySEX9JxUPUH6qQdx9RWETkY+iMpp7kmnRu8ShE0OFaqZH96tTZj/02DHEqw4SINOqB9mSDgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apCjSlTCxOLfETvvpnaRpSHftfup7Usr6XHYNLXH07Q=;
 b=SGfndxYNTWRnVc5W/KepJ4bZW+Y+5+zdrnKU8thlxi6nmA+PW81cwYOVj84IMU4p/EcNX/ywRXDdDBu+3+i/yY5pR5TeFOIN5nNaSHV8Bo2TjBqgbBFy3zT+wG9aX2zYf7mc7KJbEPMqwqvaxOjbUegjQIj5NCdVpKLO+amUNiQ+V88j8DOFqsjwqE8WAyRFmCYTjd7rGCgBr6nkwp1BqoKupFQIhoqMp/mnruApbsUMxzKyN5iG223Mk5QashmcKNtq6Ic92RNE5M2EDin7CqjsbcK0psqjp4u1Br7ewN4gK9P5IrNJIzPpnqf6N+zpKYkQZbrNOlFVnkyJ8x0Klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BN0PR11MB5728.namprd11.prod.outlook.com (2603:10b6:408:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 10:46:08 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Wed, 17 Aug 2022
 10:46:08 +0000
Date:   Wed, 17 Aug 2022 10:45:49 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 1/5] x86/microcode/intel: Check against CPU signature
 before saving microcode
Message-ID: <YvzG3eLXvzpRPRp9@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-2-ashok.raj@intel.com>
 <YvycC5cwBKJFgefV@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvycC5cwBKJFgefV@gmail.com>
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ccf2c6d-9e72-4b92-e6ca-08da803db117
X-MS-TrafficTypeDiagnostic: BN0PR11MB5728:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6alqKUdPkY5LtyyHkBg5sOGbkOPLoSYTB2aocD+njNoA9yP9IrpuJjJXBMrNv55Ts3Cprnt3uzqbmGjxxyz0A9069sI4e2HH8lmDHOatUR8v0NKyCNMcgLJkqUkAgzutRrLsJuSqCtdH7Cf+bFpuoYMtM2pDdDFf6xu5nYC8d+kBqvV+i8jGe+s2+pAwufzkTkn1uPOgbjIOTQF6GA1vpEMulrun7y4AskBsmYH7P2vL/6aAzbuTckXaS8aSNLO70hkCWn3BzghjpWjfo+zjcetUG2XGh2w3WF8AZ+guCDt1Ep5JmCOfyg8P7GUM6H/fyVGu7jMsuBNydpC64x2IQPM5JxgdA69OOYAN+yE9TC9w63BXt6EX/j1QOumAVRWiKSzUmfbkiF26CSibgi2dAtasWxhzg++VtGvxDT/Ub2nUJKK5545t+u8NFOpglSVAEG+fQ4AKCKb1fYgsx4hu6bVvyxzTbg9y4zQehZL8J+vSI8aZTvdT3sLkbqGZX/dmtszkLo6Mzyt7AbgaLj2JGqaDpG4yZeUFkVCXWfdUWaRl19xYdOBoD4BGkPbTA5DYCtQ2oGiV9ZKH49VBXOVDJZMyi0T0lBa/IOGzfAPkytceX5YmLMt7e6304moa2vpbaP3xg1a+BRF0hF8vyOJh25kxXMiIySAsC7U7IS+g6YpSsS8txzFDgaj36PIZ6J8MwCedTbrIJ7tUf3p6gD7uQEbeLhaOwoecPBC+T3shEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(41300700001)(26005)(6666004)(6512007)(6506007)(478600001)(9686003)(86362001)(82960400001)(186003)(107886003)(6486002)(83380400001)(33716001)(4326008)(8676002)(66946007)(5660300002)(66556008)(6916009)(316002)(54906003)(38100700002)(4744005)(44832011)(2906002)(8936002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ER+wQ/YBuyBvgNgK3alrw1RuNT1l3hPRTGoG4qN9gtynwESvnwkUTbw9IAlj?=
 =?us-ascii?Q?RX/63Il3/roQcSylD6fDv6YJdoiUHKF7zNR3en1z2GZDLe70oyNtoLODjdi5?=
 =?us-ascii?Q?VTvLVDjPBJy+IMawJkowiNZuYIuz0Y8j6tKSokwDfatKvyNbkRnB7DBR3I7k?=
 =?us-ascii?Q?20xyu7jVTYrqfTKVxv5JGcy1I/1S9y7y3hOvNNvDS4KTylCmDdQYVEpghNK/?=
 =?us-ascii?Q?ps2C5L/VBJJBrY0JoqWmHNagBCmzp9w5gXdj5f1HxuuDCyvp3tjt5vUMetNv?=
 =?us-ascii?Q?tqxhoQfVDhgw1yCKpqy0H4vT5IyWlCHzqJIFoJl9P9bfX1evno2/lCfA2a4y?=
 =?us-ascii?Q?VrQh72NOiOu2Ppl4CM3VKIHZ7Td0ZyvSoIiI3akggUHpuiLEvAb/QbgPMpR3?=
 =?us-ascii?Q?dNpi5dZ/XlrZFta9DXs+n7vzzwdhnsfxysVRjCoVAju+7aXnIeJ1snmFNAQO?=
 =?us-ascii?Q?k/ubkiFdA7NabVULR72Mku9PQOtjL3xy9nsfTgxGKS+AU1xfc53i2vgx0a3L?=
 =?us-ascii?Q?YsyeTpwLS33OZOPflGwvwhyHX1NR8MMqn/R9DzxJCkCQZBZsAkq4ZgCDx+pW?=
 =?us-ascii?Q?R10lII8XeHBtuozfhOUiEAcM4CZYzxB2h8CWmumr63UYMpedILxU6nFQnR+Y?=
 =?us-ascii?Q?NMTV/8ZwD0r1CogjWNwX2tg1mR36XDSgsYSHiQkcD4ap9YM6oZJgdACB8N3g?=
 =?us-ascii?Q?5PCViNtseI3hxODc/3Kuxlb3Mw1sN2ZemdzaY5L6Xr8wJNan+VdFtAQ4EvyK?=
 =?us-ascii?Q?wM7BjF0nTfEygYSHfQ9jte+JEHKVZjgzpm/YKmqUesknB9JuLZPWFr66OUH5?=
 =?us-ascii?Q?tSAbSbvPrCtFp/dCWS6qr7uEbf85ozc9bGMGo+sfYfnllZwaX2BXNtrnT24F?=
 =?us-ascii?Q?/TNJusneKfcgewTut9aUcGw51Xbm4FibbteS6Cyp51hD7NTuRslUYP+DsplW?=
 =?us-ascii?Q?w9YDQk1SCKDbOCd7SW6wn7q7oRh9YwHi2Mld0hs3nl+sPN/pMWHAu7wBc3nZ?=
 =?us-ascii?Q?Dh8IbdZp++xgfURjJ5X+jeGEvHOfaaVFft3iYjAjnoDsQJb24jvrpd/NfejX?=
 =?us-ascii?Q?FyG7hWJjcjTc2PwS1ERpwW+YL22pW9+IVwvHx4OWu2Q/dBb9cnKHA2h4ua00?=
 =?us-ascii?Q?LHrbJ5o0kXpaxEnPJMHTJJhwD74R8VdWdhENQyvxqTImi5FSZvWEEnR0rLFj?=
 =?us-ascii?Q?RrXQNehcb++g988o7XUhbOLmLSCB5myF9587xHWbEfLctMXZSdq/0+tlEejO?=
 =?us-ascii?Q?znY+hYt90bdLVCBcXrbFozCynu3ghOO1qFR9kDm9qDg1z3FGXMAZSudboHSJ?=
 =?us-ascii?Q?ddOR+6XI8DyUAqeFTgcv7s3RcanWEyaUJNwBjSmvKNv7uM6+r2pfUaGxWneY?=
 =?us-ascii?Q?M3OOg+FwICpHi/Qi40qCYDen/IyOdhXdVqKRTxdaYsKvGGtwH4J4MPMjPXP8?=
 =?us-ascii?Q?6yzWmd22/z98gD1UhFDPVCjS2wB6k+N6VzQGu6hUFjDROEdUMU88iEY/e0TU?=
 =?us-ascii?Q?kcuelmf86rAFAg1oYarXll1fPbcmygRKw2bixNA1VCp+usLbSe3CR+1CHzzF?=
 =?us-ascii?Q?9lzNNjkcjOLdnJ34gdsEDxQlAktRGnErsGImMY/iSG1fU5q7QJnfA18MKn0h?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccf2c6d-9e72-4b92-e6ca-08da803db117
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 10:46:07.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvOHCRN4EnuWvg0C0FS7e/hhicuJgbbFgtqVsx34I90klU05a9i+X2eF87sk+RsBHlXD/mqPOXuVe4moOga5Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5728
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo

On Wed, Aug 17, 2022 at 09:43:07AM +0200, Ingo Molnar wrote:
> 
> * Ashok Raj <ashok.raj@intel.com> wrote:
> 
> > Cc: stable@vger.kernel.org
> 
> Not sure the series justifies stable - there's like a ton of things that 
> could go wrong with a series like this & we want to have some serious 
> testing first.

Its my bad I got lazy and put this patch in the series. This is a *bug* in
existing code, and completely unrelated.  I must have submitted it
just by itself. 

Boris, let me know if you want me to resubmit and I'll do this by itself.

> 
> >  	list_for_each_entry_safe(iter, tmp, &microcode_cache, plist) {
> >  		mc_saved_hdr = (struct microcode_header_intel *)iter->data;
> > -		sig	     = mc_saved_hdr->sig;
> > -		pf	     = mc_saved_hdr->pf;
> >  
> > -		if (find_matching_signature(data, sig, pf)) {
> > +		sig = uci->cpu_sig.sig;
> > +		pf  = uci->cpu_sig.pf;
> > +
> > +		/*
> > +		 * Compare the current CPUs signature with the ones in the
> 
> s/CPUs
>  /CPU's

Thanks, will update.
