Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CDE5952C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiHPGnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiHPGmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:42:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAAB27808D;
        Mon, 15 Aug 2022 20:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660620109; x=1692156109;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3mNZbJ4jPaCdLPXCoJeDTZhKImiFL3eRQLoBZQXLoB8=;
  b=cK4m4DQ6NggtvtoQqVpq9ZLNP4PI+cewdPBucQvpJNZkyYFzJgW6x1do
   ryyBKEwSxImU0VGZd5x3foNA9LyPV3CzakyssS4h7PYgkA5PcPHv18NxK
   g+O3p4kyaI3b7AXPBqAkUs/0AzBEiwndOjU4PBNRSZRjFSH236JTmuymn
   eLw4h/1ajrr41hnZd2x09jc7h4VSk2+EIxgkhI9uMtJhNygltcIXjp2+0
   CKFoybOpB+yt43hAHRcyYNe+wy29VG1GAWoSY9/WiQygOJ0Uehi5/l3K5
   V3QjrDSchc0jOSZkKy3Qc8tl550bhxmALPmpa34IUGLJdXV/JL03FfSxc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378403731"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="378403731"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 20:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="557535600"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2022 20:21:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 20:21:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 20:21:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 20:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCZLpt8T0Lqda2zzjXRD188PXGtwX9HW2Uyf0gfj0GQqhuo0bS5L2DVF3J039U4ovhGDQxakkRV0AuvV/YAYgQOqPpqRX27sB+ddVHSQMvA2A/1O4KTeZN2kgWChKar3PrOSMuL1ikb3vrDEDZcPWAO62hVTZb0eU61XP2wewgBF5mB51c4mJB+YVf12CQT4vK5Vg6J53LWw5Yz7DnxvjIMOBwqfpT03BQ4R7OKBjdXHg/cLmgCeMzKkX9s1b6coJQWnYxHyaGWzRfLbXPJ0OUAQJhZTHuB/Q3/gjqOMzMct9czgH5bfMrzqWnYpUnMOs9vOk9i/VczxSJ8mhMT13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZwQE8MqZzI2ugzniW0CDNfcE50YdfKJTvL4/n8W+FY=;
 b=cKaIA+pHvPbdyxhP5p+8uzbKmyfiqaQR1UgZYqY5HGy6Dgw2wHgXSLxOWODw4+PTRrZH+MfDbBy+E5cEq55/+ZvmfpK2M21D58rc2lQRVYF46CdXVb1XPDj2x8H9ZQj5n0cHS1Ro5yQTfwW1ndbmsQ9zQEmeX8ZSi/778vJ1D70/afE4qRYLBZabkFqagNACaeX/10H6SCPg6pRBqW/+8tdd4gd+FvAQO2k9J48vBQXA24M+2OFk2SKhNHWyzogulYAiZcIt3B2ZOffMFn8HWlvuEq3awaRRhSl0CjnqWeCVGgwgUWsTRfdhq2dUqwOrBJX7cAgKopHzLjWpGR00oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB6477.namprd11.prod.outlook.com (2603:10b6:8:88::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 03:21:29 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 03:21:28 +0000
Date:   Tue, 16 Aug 2022 03:21:11 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-tip-commits@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
        <x86@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [tip: x86/microcode] x86/microcode: Document the whole late
 loading problem
Message-ID: <YvsNJ5Nk8xkt0MKn@araj-dh-work>
References: <20220813223825.3164861-2-ashok.raj@intel.com>
 <166059240569.401.7221163581479146132.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166059240569.401.7221163581479146132.tip-bot2@tip-bot2>
X-ClientProxiedBy: BYAPR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:74::26) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0324fee4-45d1-4ed5-3c48-08da7f366883
X-MS-TrafficTypeDiagnostic: DM4PR11MB6477:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: go4T9wGQQIHZBCCJHIDmqxVxDqicsItmVbBwzP2DNTa0Wl1YOKPuV/Q4iFSnLEYYiAFv2ubkTz7s5RI5OKc8dSRJvwJDavFhhJDNri+8lREUz5scznbep0DTJXZeJH6UnlFe516fQ8Q9WHrDB4eGgVYxcG5xUypkic9ECVHrkUG3SVEveGCOY5dJ8h6HfKSTzXzraSH4Y33Cpv8FQ7SMh1h/sbQn5wDg+JJROUmP4IUVZyD5MCQ96OAI8ED2Y1hfbB673TXh1cNumV6m9AaWw898seQw7G/dv1BBj4ygReOTF28WksFr9aLyhzA0lF5KxGSHD+9GyvDIwNXnKQkt623lsUa3qBajNZYbJlcW/D8dtbBpATyEcfrWJAvZ19+RCs/3ADrbWMlQyoHEREeeYxmsvoFWDbuMHg6YtCXkwCkTRBC6V2AtTrOVjEIF1NQeR/nVNQWVnHL3SobzNb+5ORNY+evib1+fa0eEgjxIBD1KhsUEbKgUk9l07Pakvj1XJbeg/z319mpi588JLcpHd4xtQhTafyNZo2HGOTnmGVN49i40PrNGbvgikbOzq/XNRrEOt8pXye/1soP+NDoJ5H5NTFMp9h7HtV7/vfXI7SFD7ndGWaMaKnXsuhw49NjmJkisphRoQV3PZ9wngvWiTegK3zMjvbvfFcE3gwq6TMWspmSPyKqglLtVGF2A3bJfdcv2X0APvekPxkkfToaCAZBGuos+6o8+rmVCCBMiDsDFbbrqn1nxl+Sw2xOfSnDl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(346002)(136003)(376002)(366004)(107886003)(8936002)(5660300002)(86362001)(186003)(478600001)(26005)(9686003)(6512007)(6666004)(44832011)(41300700001)(38100700002)(2906002)(6506007)(82960400001)(33716001)(83380400001)(6916009)(316002)(4326008)(66946007)(66556008)(8676002)(66476007)(54906003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FA31TaO+Mv/hmsd+PT+pch+QahlXZFQ1F9nrqyV2IE4pdFb7poul0c+6p7IB?=
 =?us-ascii?Q?yiVMkIL5QkXXVbdQnDzhuKI1frThhLdOG8YKJLIJwpoNL1BZ68m6vKi6T8QM?=
 =?us-ascii?Q?jrLQf9zoUgYczfw94vco6tDrTkADjkhlQq/tLSVzX1z2Se30E8x+FbTpUbin?=
 =?us-ascii?Q?k78qrcyz/DU4YqOfm5sFbmd7s6LWg2WhUtzhQ79umealAoGEyBqbvwwNY5dN?=
 =?us-ascii?Q?rMaAx38W8J48rAu40apiCAKeMofLyn2ZeoWIgDtsk7YzK1Thii/hZws8a6cD?=
 =?us-ascii?Q?ODlZ4zXcLpB0Kexx7K/1fx8WnpbWPUhUIfhKaMJdZdsGUm+TpKPRz/0YyWZ3?=
 =?us-ascii?Q?z9ud/JaZusITibepAYj7H4p+7RKKzd7BDFkJkwUgqm23uUwLsspN3Rik2T4C?=
 =?us-ascii?Q?4RlSCYTQbyUqbPD+D85FQesa/dBNfyHd+ebAuIdA80v+kPtK5UlsP0rnzMDS?=
 =?us-ascii?Q?6PKMLbBdaVzP0oiJi1hYqIx3jZ83bpsbuqhP/ruRUwoS4WOiYadZywf01S1r?=
 =?us-ascii?Q?HmK4XutztnVi+Hvfdwr+kOe0uzWS0Y2J3yozyTJcnCs8oijlZbIK8EzzqswC?=
 =?us-ascii?Q?7H+9k7qryS9X3sEkHryeRtITqzSyMBZCzciu8pNcVSR5G3zTc7DbtsZ6D35M?=
 =?us-ascii?Q?m8BnrVJi+G+rVlvChUQ1Vb2JER4ISg7SoAnv+X2E3mtUHKMS6ohRNjeFnSI7?=
 =?us-ascii?Q?ejCiwiEXqC9Z+mRkIDimKOf5kP3Phqx/1QO663BYxRfXL3FeWTs6WQi/sGEF?=
 =?us-ascii?Q?f/ITIudSA1IyTHl4YML6oInH3/VBNGjEOOviNj1swGJKyK/W8lTkUjZ1Ztt6?=
 =?us-ascii?Q?J1hrdwcLIe5LHMCh8hqPzto4qdPoHaenzZIMh8BcbYASICykZQTnnvuCUCFL?=
 =?us-ascii?Q?TpZJ4nYYIgy5CsYIp60cfjQjiaWjfV70aHKoic/Y3Ft5k4aNwaDFMGmyKq9T?=
 =?us-ascii?Q?hdwLAeSfdmy8gy6ejGTlPDVKtQmcjW47QiXjp7oATe02usEYXFxbhXbJWcGl?=
 =?us-ascii?Q?i9Pqmupn9KrKCP4bKjwNUk3aA73pArD0Z9zm6QhRM3BaublxIjfC1SlgqT8m?=
 =?us-ascii?Q?KMPhFbGbPUroM9nBFyOTF8vXhXt3y3S4PnKFcuHupRjL8MafHGIm4bYXdvo3?=
 =?us-ascii?Q?+Y5Zu/H9bi7aH5K29Mqxl9S3lVWMH+/kSOO+e9ETG7amjMWO6jF4LcNYf7rQ?=
 =?us-ascii?Q?WdguolyKvesmg8UQsIwY/06O9pb1YeIDzyx7vjClyY8pSaRYYYbgDT6r1NnL?=
 =?us-ascii?Q?9TJ8cT51JMjiEo+Qo0nYq00/aJIFHe0rVnrx2W6dRH2iOfYjsGgsDcibjcQ9?=
 =?us-ascii?Q?Wrz7OxcDr2P8ZRxT24llVzmoIFQX85IuycFLufP6bi9n4e43wobIXPvr6hh4?=
 =?us-ascii?Q?eq1vWXW+YOtPNoYuslzxfKw6yj0C1LxacwIOphkp3ukwAXI0GmbN0ZgT5HCx?=
 =?us-ascii?Q?E5CyZk41PgFfvGDtK6pteL7DMUBDp+l3CXcBKROGNzy1NCbapiAa+sg35F0H?=
 =?us-ascii?Q?uJgYr8Uhls/fw9yJjmBkHRZofOX20qTqeAxUviIT7WBUiF28bYEyka1vJT8j?=
 =?us-ascii?Q?bdrxAj32623l4Lpxgrfs7a1AXjbPgdmNycW20C+jPN7dxw/IoeuH1s4s0s7I?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0324fee4-45d1-4ed5-3c48-08da7f366883
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 03:21:28.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DO7rDtx6lOW0otjayBFhcz3ikpP58DasOgjCeGMk53f3hfnNCZGj4QCiOjf3c1Bzmi/MK6zv3oGTIy1/Y1orLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6477
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Seems like there is an extraneous 'e' at the start of a line. Think this
existed in my patch patch, I noticed internally due to the 0day report that
a newline was missing.


On Mon, Aug 15, 2022 at 07:40:05PM -0000, tip-bot2 for Ashok Raj wrote:
[snip]
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 7d80e8c..e59a710 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -134,7 +134,13 @@ More detailed explanation for tainting
>         scsi/snic on something else than x86_64, scsi/ips on non
>         x86/x86_64/itanium, have broken firmware settings for the
>         irqchip/irq-gic on arm64 ...).
> -
> +     - x86/x86_64: Microcode late loading is dangerous and will result in
> +       tainting the kernel. It requires that all CPUs rendezvous to make sure
> +       the update happens when the system is as quiescent as possible. However,
> +       a higher priority MCE/SMI/NMI can move control flow away from that
> +       rendezvous and interrupt the update, which can be detrimental to the
> +       machine.
> +e

^^^^^^
