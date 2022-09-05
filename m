Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6230E5AD34D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiIEM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiIEM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:58:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FF320F6E;
        Mon,  5 Sep 2022 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662382673; x=1693918673;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=VXMcKB3DdldFwDRD0EKbSMrRnnI3yqws137j82xytbE=;
  b=V1vcWUYao1pq0OWGJw98j0r57wruaPX1vIeMjAQPDwC78rt6QR5pDCPx
   sbf4O+zYCuw3qVjexZgJpy4aijHDRQnIwkMyL3odZeD2+GK9UlyqCCTXF
   6vxhRtTHnd/T8Bwlbw8HldonfjgVGRpyacsPMO6E7RDPvklENxACmoTO3
   0aQFUjcWHBx4lqIeVetSMX92WagWP6UTZtCWOujd+NJwgo+/duf/zCJT2
   AlnOiiUt4+9i6gPrlgu+2G+sLYtm1/P7iqghNL8uJU+OmYVBbhADUa3t5
   SJvu0qr3Kf1QRQtQ9oSrECM+8KD7C+rxvqIQp26sIq2CCUpzhEkHTZDpg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="283377767"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="283377767"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 05:57:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="682056988"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 05:57:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVBfh-008fsS-0N;
        Mon, 05 Sep 2022 15:57:49 +0300
Date:   Mon, 5 Sep 2022 15:57:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/17] pinctrl: cy8c95x0: Allow most of the registers
 to be cached
Message-ID: <YxXyTCSKzL42PF1D@smile.fi.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
 <20220902182650.83098-3-andriy.shevchenko@linux.intel.com>
 <CAHp75VcNGEVRnkWeVThaq4zNYoiZGSY-+KfbV5_9zG_5XoriMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcNGEVRnkWeVThaq4zNYoiZGSY-+KfbV5_9zG_5XoriMg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 09:42:00PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 2, 2022 at 9:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > It's unclear why many of static registers were marked as volatile.
> 
> the static (yeah, forgot it)
> 
> > They are pretty much bidirectional and static in a sense that
> > written value is kept there until a new write or chip reset.
> > Drop those registers from the list to allow them to be cached.
> 
> This patch is not correct due to indexing access. It's sneaked since I
> forgot I added it into my main repo. The proper approach should be to
> create virtual registers and decode them before use. This allows to
> cache all ports and as a benefit to debug print all port actual
> statuses.

To be clear: With this one removed from the bunch the rest can be applied w.o.
any change.

-- 
With Best Regards,
Andy Shevchenko


