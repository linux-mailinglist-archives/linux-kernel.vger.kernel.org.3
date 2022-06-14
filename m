Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1954BE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiFNXd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFNXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:33:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3554C7B7;
        Tue, 14 Jun 2022 16:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655249603; x=1686785603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y4FKZHKqsJqrgo0rZLbjPy41hyqjua5mA514+7rOyLI=;
  b=hk77gHOuAYva7NmfR2PASG8rIWRI7i8XsA8x4eu4hX4Gfa1dojqonwK5
   w6hmmO7CskafYD15EV8Ra78xQhSY//D7XH0PGaI6Ww7TP/c7Yr4lMoW+s
   8kHZR5ALSsfm9nCU7pso4XtMCKpgQyh537AUwPjFqEubf0+QlBBlDEdym
   ZLQgRNfn8WvmvCEwRwBJbW3eCb9T8WlVFjmZraQzmjRQvbhVYhIk75SEO
   N0SpPR9fylsiUAr6DanAuOoz28W3bCDPPnuRG8KQl7jrpVoq+/MbjufRB
   KJ5yU2Q5DqNJgYabNq//cn+tR9cgOJj6z5GnOQbK+S4LeezQgPl1P/bgl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="278818609"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278818609"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 16:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588756170"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 16:33:22 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 16:33:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 16:33:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 16:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzNzM3hHflnpB3965V0Qv1IfKzNTrVqCjWqizlaWQP4T/UX+BXDElIY4ATeyJNL0DGkfhZRaWrSe7kDxGFc1cAyt9gz3BgPLAXMwijBY56u3Yahn05e/A8Foo60ffL4lzskb85slwrv/KrOuGRftG6JfYqT7D5EgUKy7bpSziECdtQq5PQ4sR0ovux5S2xB0MYTc738HvalcSary2MzmO3hrYQK3DDPChskWJz0uKPf7In0va4HqBaMQP50AzbRVJFuxP0enzAA0KEcFnn85zudgbHr0XqhcREnJOGTXJnvPoaQ6Lq1YxrI3ZzZCvfqGGDbCl3fzk3o3Sq+nFJ/WeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drPS0ipK1HZNNpO+Kbjh78AkmkgYASBTMue/ZVHcvTg=;
 b=JWEUyefLHaYf/fofK1nK2izu5c7uHYTAZ5a6tChnpVsIN1yzx0DtraCh40zsw00A83KBbhueVHvuCmpvLLL4byS41aayOZwQ4/kxhFPAxRt5u0PTtFg+7D6tVkzVqLNkxGH0KzxvthU+s8YbHvDs1H/Go1udISGCmPq/iI3ZmUl+8lIjxMlPu3hZlLOKB/6hk8lDnNpnyEjjSKn+eho3pe1JmI6WqionndRHVNa8X/Aq2zdFsTlVDy2LpE4BvpSdgqC6h1RKKI/jPMWsje2TKmh41gcikdvXTvdDKGTTnzq7Fc8rUSBx1ruTpk8UWGduUHl57AVyQojkO+ElhaCJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Tue, 14 Jun 2022 23:33:20 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 23:33:20 +0000
Date:   Tue, 14 Jun 2022 16:33:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Message-ID: <Yqkauy1EmrBlUz1c@iweiny-desk3>
References: <20220614123115.522131-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220614123115.522131-1-bagasdotme@gmail.com>
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb77bea0-ad77-4efe-7357-08da4e5e4429
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5166:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5166C4A98D866F99FAB38B6BF7AA9@SJ0PR11MB5166.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhmPjoYXA6fsJqpIkhUFtmqUHA9XPQGbKwlCxlnCIv08RsQjHOHo8fv2HTyyT8q/upmLeZgXbG/CoxTuOkWlQ4h87yHjLe5iC6t0rIpG7BTwDm5tuzkZXB7BaxmKzBygqOA4dIUBfcQNtzWwIDRpJCHPZ8lcYJ2T695YetC0MrtjyeruVNkkwewfY4bpg+Z//9vq4E+Q3WpMRZ1l2hYHze4hoE2FO/43TxTkuyEVbcgp3878SrAUdNoab9Nyjm3XxYErxRIZTr3XEPQe87vOM+pQ508Seh/dH/RNQjnOgAU70C1BaS/TRVuMm+fEFTeDpJ0zdf0C2wabjTyJOQ6nDzBOUpAhEkTyKywI/yap5WQhYH26WuOPYYdZCixLlqPsqRrw01pDex/LYsgEGhTLPHUcO3/H8u6eL6Ii9UsdvZja8F8Y5w2Kg7ihOGiPURkt1QYxFZho5Kx8KuRkJuLP3QyvjwxuBIkVZKOU0z/7rUFHCvxuo6RdyzoBsXwJqvJlc6/m3fuBArtWrZfIY2AmLinFKYXYQHU/Iwy0HXHOSJ0G21gH1xvhZfc55Fg/hgFHmUFvFOcrFBohkJvPySGicw2ppNfi6a9yMznlN6RZGquSJslaCW2LexL25D0Ae2TTJz0CEzN+SqSBWsIO8ot2Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(26005)(316002)(186003)(9686003)(6512007)(83380400001)(44832011)(54906003)(66476007)(66556008)(66946007)(6506007)(6916009)(6666004)(4326008)(8676002)(2906002)(6486002)(5660300002)(38100700002)(86362001)(8936002)(508600001)(82960400001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NcnqLExjxuOEx5nMdT1FcvMlZNegdp058ELwZCttVEly7PdtjBbVT9cIVnCk?=
 =?us-ascii?Q?2yDAoywM6Np119WfZu+aUlK3vzZd1aTtgfbxS/MsMF5LodZqczG1NZ+mp61M?=
 =?us-ascii?Q?PS2h31CWNyRM0iW5mqZBEqciTEgHgkrjHGByyYdtWZXpOtOBQeMO1q1U5X3f?=
 =?us-ascii?Q?0r+lgTXgS8DQjr7wWkoasxZFpKxXGcXCnguW5N9zE12fZVMIH7GQaeDsJJIo?=
 =?us-ascii?Q?suiHEpL91Hqx7AXDME5vPrxeYy37WEmqoVC6yG7OJtgSk7J2AQeVgimMqHy+?=
 =?us-ascii?Q?uFZM3Lllkxs+vAugGDE7sPCGpL9HSfT/uu2SyN1ySi8Kg4og/GMoZ+g9rPnX?=
 =?us-ascii?Q?N8eHWW/doF0r2xXbQemdbmswSdOMYu3rXqjJkX3sT9WmLbdrAVtf0ST+HFlb?=
 =?us-ascii?Q?QwMnbdhCJ6p/flI/2Ql48pF0VCrHmK7gkMKrOlz1V5bzZjf4iGJU3a7YVMNb?=
 =?us-ascii?Q?OpvpWtrgiGRm0HU89B8DJX7E0uPMxYxz+I6/+mnJuWgJmSzzpxCwZbkc8R1m?=
 =?us-ascii?Q?DadAJmp8JocSiQc6a5cnYkhHdBRW4wFBGEpeyuJdtnWVN0TrhH3D/U3hdEdc?=
 =?us-ascii?Q?T31lC1fuS3aP8zGit8HbfkfBp96Wu+D5pBqde/9MfAYKt5wcwAoiaXJeIHCV?=
 =?us-ascii?Q?LRUVHD/+VoLFpQH6VuVA+H5W1kbNlTtNGMgA/U/tXPhIZsl/tvqvQbzI2ifd?=
 =?us-ascii?Q?U5URoBSx4HOPC2gcEIqoOFUq2yyouXpHNZ1TePDuHXZu0zdLIEwrbVa3oar0?=
 =?us-ascii?Q?A/l0TkWxPLsO0Ise8EtxYvH5dU4QKIL977jV5f0x0XSEQKMv0kqDIiTFxmLC?=
 =?us-ascii?Q?dJ5hmGCvXCm1OSG8SgsMMHIXZbilDIORZ8FUrTGabqPYZDvt6M0fnfJ/zErh?=
 =?us-ascii?Q?LIgnF2/kOoXrQovRwRcpbZACjfo7ZoIoEzlKkDYZeYZldsNmwnuF08G+Qg8h?=
 =?us-ascii?Q?Jue41lt2fk7PJxsa3kPsWJiADLy+B8LyAoMuuJqw46Xaekd3vVcOy7lHvVjd?=
 =?us-ascii?Q?WAd2BG2DM//j5p8g5MN2+1ZEYNQBoB3LhxGz3PKqHstbclGDG9WLIwsd5CUS?=
 =?us-ascii?Q?g8QjVPMP0QBRdPy+v8OjKSp73/yu4bVv0OMX2Njvf3q9z3jTeN9BLx9aEr5E?=
 =?us-ascii?Q?uDfxXkRwHB6orh5oNKtNlETsSopaSa6LPN8gZ3Q7cfp5ou5YTdG2loIPkhNC?=
 =?us-ascii?Q?WAE6QoOQ8yWNSAV+cpjWmVeBo9070b5CJN/QFpUcwqBNcLMY3DGF6NBRUFBt?=
 =?us-ascii?Q?/J5N9vNyR92ji0IXPGLuR2HtEiH4+gS5lmXVfWZTLQ9EqWlqUcPQpnl3WpWF?=
 =?us-ascii?Q?m4l+8GXUk0a0hQ9JaLzgVzf27eSQQgFRzENvOAPHOfNCLNGKWUP1KBSOtV91?=
 =?us-ascii?Q?AsXlu8IqRZhIy3RO50qIVFNjzMVuYYbA+OsPoaHDa5oq4FXGmfFIZNAimL53?=
 =?us-ascii?Q?IUYAoyBw7w3y/xfTchZA6DyQglqwLLnGYw5FhiwzYbp7joCmz3sysZ/qBIWr?=
 =?us-ascii?Q?Bzc5GhERUkQ5vu9kqxTqgHo/D+BLxLB/l599/O909QSOaxUsqea3VZ3dT7cF?=
 =?us-ascii?Q?z5Z3QMH34v/EI+GGsX9g5Yl1qJq2nFXd7hBp0AqMepAyTNVIQRn9V52a5Fp2?=
 =?us-ascii?Q?keKMkIx2V/YjoPmHQbSuT30vxXldo6hT8QFykCpFBsGvKrOwcpwKKeI04bgK?=
 =?us-ascii?Q?qtkRu4whfPqCxszV1GDybuW+GPSmEtN2nreWq0sx0rqCjcK6sVpu5btnuGTl?=
 =?us-ascii?Q?TOGyK4XY4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb77bea0-ad77-4efe-7357-08da4e5e4429
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 23:33:20.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBXnsWGLpKgijUuR9I4gzNLdN5Y5s1SIPGiV3PqPFZbryb1vGlpugz6daS1eiLgbqJnVeXU+uLs2ufj5fjiCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:31:16PM +0700, Bagas Sanjaya wrote:
> When building htmldocs on Linus' tree, there are inline emphasis warnings
> on include/linux/highmem.h:
> 
> Documentation/vm/highmem:166: ./include/linux/highmem.h:154: WARNING: Inline emphasis start-string without end-string.
> Documentation/vm/highmem:166: ./include/linux/highmem.h:157: WARNING: Inline emphasis start-string without end-string.

Nice catch.

> 
> These warnings above are due to comments in code example of
> *kmap_local_folio() are enclosed by double dash (--) instead of prefixed

As Willy said these are for kmap_atomic()

> with comment symbol (#).

I'd rather see '//' used since this is C code and it makes the output
consistent with C syntax rather than mixing shell and C.

Thanks for the fixup!
Ira


diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index a244e0345c87..56d6a0196534 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -151,16 +151,16 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  * example a page in the pagecache.  The API has two functions, and they
  * can be used in a manner similar to the following::
  *
- *   # Find the page of interest.
+ *   // Find the page of interest.
  *   struct page *page = find_get_page(mapping, offset);
  *
- *   # Gain access to the contents of that page.
+ *   // Gain access to the contents of that page.
  *   void *vaddr = kmap_atomic(page);
  *
- *   # Do something to the contents of that page.
+ *   // Do something to the contents of that page.
  *   memset(vaddr, 0, PAGE_SIZE);
  *
- *   # Unmap that page.
+ *   // Unmap that page.
  *   kunmap_atomic(vaddr);
  *
  * Note that the kunmap_atomic() call takes the result of the kmap_atomic()


> 
> Fix these warnings by indenting the code example with literal block
> indentation and prefixing comments inside the example with #.
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
>  include/linux/highmem.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 3af34de54330cb..a244e0345c87ca 100644
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
> + *   # Find the page of interest.
> + *   struct page *page = find_get_page(mapping, offset);
>   *
> - * -- Gain access to the contents of that page. --
> - * void *vaddr = kmap_atomic(page);
> + *   # Gain access to the contents of that page.
> + *   void *vaddr = kmap_atomic(page);
>   *
> - * -- Do something to the contents of that page. --
> - * memset(vaddr, 0, PAGE_SIZE);
> + *   # Do something to the contents of that page.
> + *   memset(vaddr, 0, PAGE_SIZE);
>   *
> - * -- Unmap that page. --
> - * kunmap_atomic(vaddr);
> + *   # Unmap that page.
> + *   kunmap_atomic(vaddr);
>   *
>   * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
>   * call, not the argument.
> 
> base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> -- 
> An old man doll... just what I always wanted! - Clara
> 
