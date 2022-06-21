Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0E55302B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348128AbiFUKwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347851AbiFUKwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:52:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA37CE027;
        Tue, 21 Jun 2022 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655808732; x=1687344732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OwXcx+GuuP74ODQ1pL8evshto3I/UO+zbsBn3qxF9XA=;
  b=Ft8NAvmGp1lw/Q2DZSLBSld/vNDa/4JH3iRxyjqbrIMRpGup8FxhTkLm
   G5jDzSeiNWv6NgNy1I/eSOgCKnaov2JHmaPQuDnYZRv1JfmncbkERlOaU
   FEkaM8QG+LD87rTk2dHndetgD7X5ZF9gCuubSnPJsxaftaKoVSOcHq+4Q
   3CnQsbF2Gc9FK5x1KSlySwuGE7+WnJEOY5b0niXualspTE8cB/Y9Y2WeL
   h+NZ1nR+ONKrY4LmeDGNQsAeuxbVpoaV1HeJqz+ZjgCKEQTBt/DU5yrzg
   FIgfAFkkcnOTjgES2o+XNc8FH0W8j05lHrneADK6+q7xXKBdOvyAGT9wF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="268808102"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="268808102"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:52:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="676945083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:52:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3bUL-000qwm-SB;
        Tue, 21 Jun 2022 13:52:05 +0300
Date:   Tue, 21 Jun 2022 13:52:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Message-ID: <YrGi1Zo+sLF3fUgf@smile.fi.intel.com>
References: <20220621103754.12771-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621103754.12771-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 01:37:54PM +0300, Andy Shevchenko wrote:
> First of all, the additional conversion from vIRQ, and this is exactly
> what is returned by platform_get_irq_byname(), to vIRQ is not needed.
> Hence, drop no-op call to irq_of_parse_and_map().

Actually this patch is not correct. The MFD supplies IRQ lines without any
domain behind it, because of that the supplied list of IRQs is abstract to the
hardware and has no meaning in the Linux kernel. I dunno how it's supposed to
work (perhaps it involves the GIC driver hooks for IMX23/28 platforms).

-- 
With Best Regards,
Andy Shevchenko


