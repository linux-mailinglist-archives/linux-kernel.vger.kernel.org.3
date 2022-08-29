Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D345C5A5765
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiH2XDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH2XCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:02:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D488992B;
        Mon, 29 Aug 2022 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661814152; x=1693350152;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FNWMaf94x48t/auNOctJRfWm6cKaXTSONpJclMHqQjY=;
  b=VTqiPYSJjJqrhrJLI8f83dvofh3AxW4QMYvmEbCoga4HK/DDBWGbV5WK
   uEM2sZTZwj/wTKX2EBPyX+eSwM91F5hQetxnWIclJDJ3Q7/BUoFDlCAzd
   I4ncOY6U9QB5N6txP2LUMeqBhWNpim9n3bEYOnfjHgLOZis6lp+5djdCh
   SslE4F/VLjErLxtRI5imIdK6B/i/3DT7Xyao496iZOeaLftP7iQ5J06YL
   BAy6a9+b/gTNSmLKaeddf6BKeW1yQc61ZYNb6RVliEVseJNW6fj/bYQkW
   zBik5wYdCVXO/ww04P3z419kcbw0n6rRycFRXySpYIKTtrSqYVNlviiY5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295799642"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="295799642"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 16:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="753803777"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2022 16:02:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 16:02:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 16:02:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 16:02:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 16:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBfJEIMyXs3KFAiblyNGG5J4QrdIr5rO5RlUd9gqPQiGCwhx5jc8dpdEfFBQdQmAuKU57LoI+ylBEe83bz4hUha6U+dj5hB3F9opF/syG26V9JBERItsE2zggs262CvZgf+4yd1tCHazjjGsPygjHimJloC0jfuNDOcQFyg8gSBob6foWR8/GFUsSGhLzkNkfPFez1rldn1YwhwypPCOkb9DDD17WeUcYIABiX0N3fNjhz9z2RzXSWgnnbWc/bDX/q4nfKe0icRoThnN8FHGJ9lQx1g0ZAMkQOVJ2RHiFM/kxhXpdHx9xhvke2OorDWRGGdEZI2rgiRf4t6bq+aA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks94J4Ccnf4z7bIzicGqKItyIBNj6JUF/69Wm2Jowbw=;
 b=l45UYjSiC3yxVGF1pHYVP2aem69zAs58UbuttFpmbjmmMeC6WPwkyxVItD7agqdtdgHM4ynw9yQ4KX2HDHU6IgoZKPTXlOWXRoq0kbB6jssatkh/cyQMNTe0zqbJBdA2b2I2XPeAw7GyL6JlWloFr1EbXuRfEBqLnyWaiu9naHVsyRqcxukARGKq0xJBsoFfw2dpKHiUxMg++haIpKxYmJBPM4WsbZS0sWYin3BsfFiao9tf7h5t600upALfPEV0qDEqr3RvGLGLkoQ6DUvUpYtAeZZtZIJsHZ/01nociftgrzAZ5s14BkzcOk1vyIwsH1cSri/qa42WdIK9db7eMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MWHPR1101MB2287.namprd11.prod.outlook.com
 (2603:10b6:301:4e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Mon, 29 Aug
 2022 23:02:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:02:25 +0000
Date:   Mon, 29 Aug 2022 16:02:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <x86@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <bp@alien8.de>, <akpm@linux-foundation.org>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>,
        <dave@stgolabs.net>, <hch@lst.de>
Subject: RE: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <630d457ee7739_259e5b29444@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220829212918.4039240-1-dave@stgolabs.net>
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a58cab4-22f0-4a4f-e333-08da8a1289eb
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2287:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtkuFUQz95m227ZFwwXycawgmHQwfgQ/aBzc84mpdNRqJJzziQz94KaorgN2DABzdyP49jyanaW50JLOtkBOx49wpxrECqoaUcCfSLpFusXAegVLXfdQuI2g7z7YEzTvP0y+Iz/HDMU0JStqJCZrsTlvwPahwXYcIzKu7nvf8TsV0ixqQ0KYvZrPIGaoEn6YFmVGIImKZ1IMwFW0jS5IYw9dJql01ayYpHcLV7MJe1JnHvL+Gsog7Y8hAKuf/8fF+QzgTTuxJplynUnDGEC55Vf+A5H+pezYfyi2oxmrrbIypYRiYyRlRgdV3JmgIeMdy8a78HABLHBinon2lhElWHzDeQLRrzu892N5JJyUZQwK57N0j87OfMORvzAG9Z6TUs8SsHWD0E5NRCDXPWQZ01KiiEPJ88YuiwKLy13Cjx8u6JjLWHTy7DRaPtoFVHMz9ztmpwf8vr/rJDUSdH4cd1tDIktEHSjF3BtRk+73+XIQ/f+jwMkCc9Bg4G5Cjf5L2UkIK0mk2oIvkq25eyOH113OPObIk6rHQU1lApQQE1aKhSb8ZaeoNj6QW8pb9wy62d+ufoBGCp19sx2Puj38AYX4fe56BxOcDeHWBdbib9P82CbG87wmSQwvTtD1T5yaP3jFHEXHs8v3z08XxIzAm521SuGf+E2W5EIFzQ7vQtJBtYXUCaafSs64faYO3SNQmlxk8OpfhIAgem7a0coAn+9SEy5c5wFZtbOx07FOehY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(396003)(346002)(39860400002)(316002)(5660300002)(186003)(83380400001)(2906002)(8936002)(7416002)(6486002)(41300700001)(4326008)(478600001)(8676002)(66476007)(66946007)(66556008)(9686003)(26005)(6666004)(6506007)(6512007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TAWkamx5b9hvbVljUMe9HmPuSZqoc3woN+DrEpcGHx9FSU2Svan9DUGPHjF?=
 =?us-ascii?Q?BjgsV5yM/aCOwCy0cXrA1ydOs7NNesCGPLDhgqMCR4Opyed7Q7srhXgJQtA8?=
 =?us-ascii?Q?ZQ9NYOo1ZoAQbtRkDnOiKFbaxRlwSIE4HJgKMRiV3gt72qsCwnpg7Zd2x+mH?=
 =?us-ascii?Q?hEtPOZgsWqnYjI21cLZEDC2v8lbwBqJ3OaY4tCKQhIEGC1qpQI8xRK8Q0G6G?=
 =?us-ascii?Q?Cuf81SiQTVr6+4sbE6CsUyX34kQXFnn0XZRNaxug0fIp3DqMmoJdR7OU5oP6?=
 =?us-ascii?Q?idCsIGw3opNbZYuWNp1DsG2s3KFBE/51vXDix9T7v2KMVOwVKBmoacdEwE/1?=
 =?us-ascii?Q?C7m5jWVdao+N9l3Tp56XDmMzWSKpklJno8Nt+/DLTSiptrxahSQ4S8hVDkzK?=
 =?us-ascii?Q?skp/oEiHq5uDnA9vj1t4mZ75xgQp8XUoQB8BdqJYaT/uO4agNK87aisCr1fQ?=
 =?us-ascii?Q?SRX9RXVPO45+UBIXxyehjkeIjBitdaD4JybKxq4yWsxJuLGPbSzhqy3YH3DU?=
 =?us-ascii?Q?Xq9nkLXpU8bXB1chP5oHjpyG8PiSuhqI7TvUWQNhYkbwFBhOAapTJuSbfzXv?=
 =?us-ascii?Q?FP1vA26Y8ye+vLCTRB2YZPlVh8c4wXDKCh031hlcJfnHsxnDNot8BIs1KXFq?=
 =?us-ascii?Q?JW7knzt1aZfXIi2h9Mz79hNQAGCbW724Urc+IP/kHk36Lw3ZOefmvOI2VUi5?=
 =?us-ascii?Q?aBvU9UdSTrFrog2KZDybJKuNCzZ9/umRuRlIu8tBxrCBlEO/mBrj1uQB8llc?=
 =?us-ascii?Q?wNE32uBTce0U80q975IpzSgvEX85hOaAX9xr9oGj+usnYNw+VBTxqJMrNy/z?=
 =?us-ascii?Q?gSRImlITiYeChIfpazeD0LNaivNYfVG5D5Q4hM8v/44ZWfv8Q+lLHcrawM59?=
 =?us-ascii?Q?Kej/ZkykgMjsb9Yy5n/1RmRBCIzLBrKH4hZ0ia589aNKkTL0Jj5KJgQEBovr?=
 =?us-ascii?Q?NDybDHTEnvozNawl6JPMp6hbKCgCd1DHkAHI2g5BldwwAfoDWFCI5QRPjs5y?=
 =?us-ascii?Q?AeJ2fjP5O60XWcf0fb6RRi1FKcOgDCxz7jHj4duqOD5/DkEwSB2+g3DiZuDC?=
 =?us-ascii?Q?GLvdnThaZJFO+gVoCLpLsQ55WM84r0zcGaG/07FnyXityynN7EhF2J8FD533?=
 =?us-ascii?Q?toCZrOhHg/k9fagzjRn7CRu9j6SLtrv79tOwHIsIow7XjyIFA95J9TsHlY0z?=
 =?us-ascii?Q?XN477CSrRJikuqUesYYbN7CHbLnWisBIX16Zd0XG0+a7zps+cBu6yGhH8Vdl?=
 =?us-ascii?Q?L9/+BPho7khYAb63y6VgOhE/D4RncRQFNQn1a0rwYbwzKxafzMou7z/tKqSd?=
 =?us-ascii?Q?I6p87H7mTAl8RicWxnlf+8dbugEp51DYj0Alq7049THiuVpStFG5+BLGOOU/?=
 =?us-ascii?Q?xV6BUmknLuAbUIobiAiQcUwl2wwwmr6us+9knps7frZUJK6uKQ2B/NHyMKiJ?=
 =?us-ascii?Q?nB0bJ4+iQrmcVRAWOtVuuL2xWsUmYqYygVaAQ/m7b/nDfUYWqMHkeViYCEY9?=
 =?us-ascii?Q?UwRU2QQa/edUt0NwaYxhl1w2bN6QuEbH5sgzdfPhVXE2guds8+O4ONB1K1M+?=
 =?us-ascii?Q?jQuSqbT1PR1EVHNoaJHljk8qZpCmT00ybfxu2NLzEr8gzLuV6s5xuMu0vv7u?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a58cab4-22f0-4a4f-e333-08da8a1289eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:02:25.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97OO0aTeKBWd55yTltPsCosk8pCrnhENVure6d90LalHYV508HTL5mjyO2WDjwWWPNRlKzxWldNP7MG8zhdkm0u6JaoBVFWg+tCoMWrJcis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2287
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Christoph ]

Davidlohr Bueso wrote:
> With CXL security features, global CPU cache flushing nvdimm requirements
> are no longer specific to that subsystem, even beyond the scope of
> security_ops. CXL will need such semantics for features not necessarily
> limited to persistent memory.
> 
> The functionality this is enabling is to be able to instantaneously
> secure erase potentially terabytes of memory at once and the kernel
> needs to be sure that none of the data from before the secure is still
> present in the cache. It is also used when unlocking a memory device
> where speculative reads and firmware accesses could have cached poison
> from before the device was unlocked.
> 
> This capability is typically only used once per-boot (for unlock), or
> once per bare metal provisioning event (secure erase), like when handing
> off the system to another tenant or decommissioning a device.
> 
> Users must first call arch_has_flush_memregion() to know whether this
> functionality is available on the architecture. Only enable it on x86-64
> via the wbinvd() hammer.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> 
> Changes from v2 (https://lore.kernel.org/all/20220819171024.1766857-1-dave@stgolabs.net/):
> - Redid to use memregion based interfaces + VMM check on x86 (Dan)
> - Restricted the flushing to x86-64.
> 
> Note: Since we still are dealing with a physical "range" at this level,
> added the spa range for nfit even though this is unused.

Looks reasonable to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
