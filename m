Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD095526AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbiFTVoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFTVoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:44:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E865B98;
        Mon, 20 Jun 2022 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655761451; x=1687297451;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M++SGFYlMQ7EUf4lZu/Nxw8UrHS2BaRjFDRM2JfqF6s=;
  b=PzJaBSG3rzxrfMozbNdzrlaNi1LycO6X/A0Gy070VFJA6mBi9+v8kpUu
   aLDEdwSPQpRyYCzxm5VXEFjb5khS8QIu4bp7ahwRlN87NXoNcXAJ2AZH0
   PGR9oETI8lz445wbmZdqKbmaucWmgVB9qDIWlm4phSWR/wolvyP5VSKyu
   +5CryF8CkbUuwe/XbB4xw/aI5EYyc163hU/q7T7uOU4s+YktfbFQ745eu
   ruAMIh3mzHt35ZLD9u0/IIz0QnxRMb7TDJo+rbpwoF2+iJ6usNvlU0/nR
   EbcYLSX/NryyS+hK3b/puW0ZkDCXdKeEZNjxnelbEUupy1FouvXLYt2Ia
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="305413264"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="305413264"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 14:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="689641515"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2022 14:44:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 14:44:10 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 14:44:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 14:44:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 14:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdry31XzFw9i2bW+eyXQG3zjIxSaP3vc1yvRL9w7BVpoGUjtzqg1q3dxD3yrsSHreJSx93xLFuudUYcmZYlHVEtTHaVmvqXA7QGxqog+zHhSLMT5w9fi8suU85nUzIytiqkGBjiV3y5wAY3JTH6WGO1m+G5ivhYW8QbKODP/Bm2Wvf7K3WbrDAXvlW8f8y8o/PVLTiNf8CRy6PDuEnY11I3yBnInU60NHwQdMjZi128CBj6bg4loai7hieYJQKJZx4Ap7L6XoAYfwOP4uT4ZuZ61o9jj0Ass0iISixKJhbmxBoFPlnCdo9GU3kjFKTz2JxV1TSpVpqn4AW/l23GgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql9PZDXfL4/3XgsdO8TkUB+yjP5Ds7YoTr6XEyLGiNk=;
 b=S7dwTgzcBsdRxmZ5L/vWFN6wV08ofp2LyBt34yJh3sLXm7oJ4BD27m/qTmWEIii+xKFycLRE4CYF0QkCS4ruxV6EkCRfiq5DVNoU24teN9hcmWauRsYIaqqtG6EWiQmmodXjHAyENru5QUDVPir64xECJbXrvTh58s3xyxRf1s4k31qLLo8EpTtbWbQ4zkmIfaUxiyHILMgfli3fugkTDYY+T4TwvMkH8Vk97+t1RL6KaKlKG1TAurqC3Omh+fPj24ik/j6+i4nkCQv9lJiFpK1GlZZWbH2EsE1Ca33Sv7aiox7lGRRoAyJczDeBZvyC3Zbno0I4fLH7yPoJufl6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM5PR11MB1355.namprd11.prod.outlook.com (2603:10b6:3:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Mon, 20 Jun 2022 21:44:08 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 21:44:08 +0000
Date:   Mon, 20 Jun 2022 14:44:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Documentation: highmem: Use literal block for code
 example in highmem.h comment
Message-ID: <YrDqJB0J1PT8VlwA@iweiny-desk3>
References: <20220620083649.18172-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220620083649.18172-1-bagasdotme@gmail.com>
X-ClientProxiedBy: MWHPR15CA0036.namprd15.prod.outlook.com
 (2603:10b6:300:ad::22) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03c2abe6-c29e-4ad8-2750-08da5306010e
X-MS-TrafficTypeDiagnostic: DM5PR11MB1355:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB135518C0563F113FAE25B53BF7B09@DM5PR11MB1355.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQl+1/xP1fuAUystTtz37j5nr6Iv/x2zTQl7H6ozQb6P4M0xOt/TFhqE9b/LWgqaWk4jZUv/q10dWENGkACIUeUN+jv/LH9Id8RfXibvcqfYo1W4hQW4iiXHoFfjQTjpcKQnymXarhH1hWFzwTG+FslKBYI4NPZ88ywIDWOvaahXvEtQptyoN2b7ujdf5iVcnmI49+OBOyiyqqe+kUrkMCz8JObyiIdqMDvFlWE2DKWhvmQOT3ESfX1LZyYb/3uzlv7uufAS/KsPQ8S/Q2HBFYS9s+cCoRGJFH5Xqtk0jwCaZZfqbdwcYCODbjpcyBmV39byhN9AObfMc/EgzXaOywihteZf6xIqu/Vxq3Hd6mMywtLWIgMrtw6OG+kdIa3kgtdm3K+CrCCNB3J+lkq/51s6zRp9VBxlFmGJxDXeYTlnvOQvOQ4AzUIXDQfrEvf24L+fJh5jhPnRP9LSwz5Iy7mcMy+EjFI4rXf8CGbnWmwXh0TOETpQ7m6ZJYH17kC0jWxSJUFNdYRyXDopwR3Yf4tQN32M4p0S68HIC3ymA8890JQFhLHlncrGBVPiAs4dfhSXQyGCvB9LIrQNIXAWygMvB5pZRgVeiZuYHc8DiH6hY5El9ySwlI5San/GNavjLG3VUdO9XOwT7UzdRwypRQ8V5UGjf594QXMJZnG58nOzuSfvd0ZPP+5rzMIYdSzM0d3ZPEh4d3eaSYz9/8yuJrMNItREu5tUMcbkVz32z6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(39860400002)(396003)(366004)(376002)(82960400001)(9686003)(966005)(6666004)(5660300002)(6486002)(83380400001)(26005)(2906002)(6512007)(38100700002)(6506007)(86362001)(66476007)(66946007)(66556008)(478600001)(8936002)(33716001)(4326008)(8676002)(41300700001)(186003)(316002)(6916009)(54906003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYWY6HjydsHKssYwSn1MtYlz39v0UvYksFuZHv+lJI+i2DPGfwOHCrp7bfPU?=
 =?us-ascii?Q?iO3RntFzC5KH8j1MDjkrx2yiQKdtO/e7EMI3XSKmzxtXo8mVX9z9MiCW6HaE?=
 =?us-ascii?Q?QkIbl3zYjMPP8R7Prg9Zdz79ATbYG7QQrSo4Be1HOhEqQC6T4eeB9iNUz6lw?=
 =?us-ascii?Q?XQgmnivZe/VEEcvHBewWO2r+O9P2EWFe1EV2FawgfNyQZFOQ9dxGih3kEPPj?=
 =?us-ascii?Q?c7Gar/45LduL+P11aN1GTRFL9alV38ZMyXbug6XRiTI0AwLGxTZ1Cv5OnOsO?=
 =?us-ascii?Q?9AHzysjMwm133eQsk7xxibQ7cGMBtFWFwZLjUDAfrxpZR2Gp5LQL1IYTP8Wo?=
 =?us-ascii?Q?g+A+Crb2tj+mCYEUOwMu6peR0LkDatw4r101ceQnxP6z5H8AnhGZCzcUh9Xs?=
 =?us-ascii?Q?W08X0hleOH5/OPWXyT3nZ5cn539BO5Oa2ZpdTiUDFa2KQ/Bv5qfOzqemVDA9?=
 =?us-ascii?Q?NwOio9BLCBBeXCSSQC3g8HP/KQgNZIDZSr4XJrgVXUKQEjpIOhZ5H3TIuPVs?=
 =?us-ascii?Q?0Hq+Qz7vwfGmY1OUfmzswmhbDSuXY+Hs3DFIP04CMqvmRVRZWljN6Me8CUFh?=
 =?us-ascii?Q?uyaUKzdrAhx9KmDApd+SNHQVynDeXIO2Ltsg+130bVqBw8c9exYQTaDwMR7S?=
 =?us-ascii?Q?AFdvGBdv+MsUTRnmCOMlQ5PVqEe20y+bZCrmBf3N1fjgwUK9aoSBCerkjo/7?=
 =?us-ascii?Q?UD2ycxNMx8WvmYGTmCjZbqoBbbuthD2hDGvvrqWIp/fwbp/UNe0ClU81CXTv?=
 =?us-ascii?Q?vZzwmL+J0ZR7l2wDpSPLvGhd5/UQFpz/2wfa6FYzY9zAMNo6r3eIUbHcwp1t?=
 =?us-ascii?Q?xPxkEmNPc2RV2pylinJ1A6Fev5k5B+ObWqcChaPN8fVWrL18C7oMSLyJRcPy?=
 =?us-ascii?Q?/aE/Wpgi9eXjQPsbCvahaZ9wC7udU+lb4S97CvHHlNrJQWqTfFHsx8Sn4um/?=
 =?us-ascii?Q?O66yU9NVEFQ47Eh4xCWtIKeGEVb6oV3Dh4Wa60hkEA3BwZA7kk++9f0lSfJX?=
 =?us-ascii?Q?a1pniY5sIvAnSo2nkMlz/soShr0zniMUPBoGocYjVJFeXJM8oCTzgU4z7mWF?=
 =?us-ascii?Q?hfYlU9Wm21XjurtxulTDFF2UAii0vd9wug2ubZc0f81DHI0hoxs/S5+B8j/T?=
 =?us-ascii?Q?CYEa+gcb2WO7r/YJRDKRvLpRhI1mHSQikIsvZcSlOVOP8G0K8LOwRgdQ+dcF?=
 =?us-ascii?Q?jZS4Kx0ZtDQyqE+4L7zxxgAkN7DYbYkMdRZBaaJLkV/296XkbvKZQTIyeMzc?=
 =?us-ascii?Q?TnryWltPumtHb8ExfSrsKybgobXJpCTAN/L0eSJoW32lO62C7djylXBcp3Be?=
 =?us-ascii?Q?p3xK2mMbmxjaKVOmy/9kmzK+RU7oOyyhW5LyjJCgPc5S1u6bIUlvKlVsyNfl?=
 =?us-ascii?Q?hZI9qmyyt0rEnoq5uqNUWOujPHitn3FFVVNYBbzh+sNxOcZXgpfA1UT2JgLJ?=
 =?us-ascii?Q?Hh83GxfKp5O40K5X5xaItpFUzWH7JmPh95nYAvS926mQv5lI5U06vo6+CDZP?=
 =?us-ascii?Q?0BePx6aQiaevwtjyrTCyLdOHhKVpKXJ7ivQ46NtK1u9nLdgD/rxZm1KDCPQI?=
 =?us-ascii?Q?8EQKqGDXRRry3ir+u4MAM1EERWR8L+p4QEtvRzZ8NT02j5B5NkrJ0AWXpt+S?=
 =?us-ascii?Q?M6x6OWfkZCT3/ReCUlvJ0wfQfQv/Id/Mrx6hMRVt1ALozGHCgl5hLTxgXgsz?=
 =?us-ascii?Q?VPAswh146Yc9SVovXIyjJAQtBsM/FNC+QAIjyf1x0LnSfATs4wF18Zw+PQbC?=
 =?us-ascii?Q?dVlyl/kTUA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c2abe6-c29e-4ad8-2750-08da5306010e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 21:44:08.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5R1yDyag70sdeRQRhWtkgw8SsrZmTkp3TF6YDzOems91w/FnVEMODqrqgbgtndNaJdw9kFg57e/Cgj+3AOSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 03:36:49PM +0700, Bagas Sanjaya wrote:
> When building htmldocs on Linus' tree, there are inline emphasis warnings
> on include/linux/highmem.h:
> 
> Documentation/vm/highmem:166: ./include/linux/highmem.h:154: WARNING: Inline emphasis start-string without end-string.
> Documentation/vm/highmem:166: ./include/linux/highmem.h:157: WARNING: Inline emphasis start-string without end-string.
> 
> These warnings above are due to comments in code example at the
> mentioned lines above are enclosed by double dash (--), which confuses
> Sphinx as inline markup delimiters instead.
> 
> Fix these warnings by indenting the code example with literal block
> indentation and prefixing comments inside the example with C comment
> symbol (#).

"//"?

Frankly I'd just drop "(#)".

Perhaps:

... indentation and making the comments C comments.

Ira

> 
> Fixes: 85a85e7601263f ("Documentation/vm: move "Using kmap-atomic" to highmem.h")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v2 [1]:
>    - Rebase on v5.19-rc3
>    - Don't mention any functions
> 
>  [1]: https://lore.kernel.org/linux-doc/20220615101509.516520-1-bagasdotme@gmail.com/
>  include/linux/highmem.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 3af34de54330cb..56d6a019653489 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -149,19 +149,19 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
>   * It is used in atomic context when code wants to access the contents of a
>   * page that might be allocated from high memory (see __GFP_HIGHMEM), for
>   * example a page in the pagecache.  The API has two functions, and they
> - * can be used in a manner similar to the following:
> + * can be used in a manner similar to the following::
>   *
> - * -- Find the page of interest. --
> - * struct page *page = find_get_page(mapping, offset);
> + *   // Find the page of interest.
> + *   struct page *page = find_get_page(mapping, offset);
>   *
> - * -- Gain access to the contents of that page. --
> - * void *vaddr = kmap_atomic(page);
> + *   // Gain access to the contents of that page.
> + *   void *vaddr = kmap_atomic(page);
>   *
> - * -- Do something to the contents of that page. --
> - * memset(vaddr, 0, PAGE_SIZE);
> + *   // Do something to the contents of that page.
> + *   memset(vaddr, 0, PAGE_SIZE);
>   *
> - * -- Unmap that page. --
> - * kunmap_atomic(vaddr);
> + *   // Unmap that page.
> + *   kunmap_atomic(vaddr);
>   *
>   * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
>   * call, not the argument.
> 
> base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
> -- 
> An old man doll... just what I always wanted! - Clara
> 
> 
