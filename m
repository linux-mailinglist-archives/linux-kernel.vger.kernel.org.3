Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC64CDBDE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiCDSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiCDSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:12:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96681D0865;
        Fri,  4 Mar 2022 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646417519; x=1677953519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ymhrhqjpe7iYgeVft/Kn+RQXzNz7BxHaO/WuLNq0Oig=;
  b=d4Hp0jxBq702UVCi124uC4ZnTgiApQCi68pymYSuzvB5GYpMpGFPl5Ui
   PaaLb3gZXlZFf/jAhZl2soYdoO/pTz9I2PnTJq52oBJ7aemTtF3ikDwJj
   iy0rIeM8jStO/nKvqs0Xmerjif1PENLmAc7i98tgV8tJ6aBVf4UD1Nim2
   o4KstBFTFwY1Y2oYePEX3ADtO5JeVh/50R/8w/y55cHHjOoH8fs/pVgAf
   YNSrGiJgCpb1GH9jYHy6byrrkgmtLi3T2nlOmW1ktkkB5bxPuUDDbhm0A
   ZdwvGeFNEtmiewJudbkRofdvY0gGgvALQPQRsETd1By0dJ8kLn3mkRKU5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="252858221"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="252858221"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:11:59 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="511936238"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:11:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQCOU-00BKGo-SR;
        Fri, 04 Mar 2022 20:11:10 +0200
Date:   Fri, 4 Mar 2022 20:11:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/1] serial: 8520_mtk: Prepare for
 platform_get_irq_optional() changes
Message-ID: <YiJWPhWGEGg63zbe@smile.fi.intel.com>
References: <20211217181547.48182-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217181547.48182-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 08:15:47PM +0200, Andy Shevchenko wrote:
> The platform_get_irq_optional() is going to be changed in a way
> that the result of it:
>    = 0 means no IRQ is provided
>    < 0 means the error which needs to be propagated to the upper layers
>    > 0 valid vIRQ is allocated
> 
> In this case, drop check for 0. Note, the 0 is not valid vIRQ and
> platform_get_irq_optional() issues a big WARN() in such case,
> 
> It's safe to assume that 0 is not valid IRQ in this case since
> the driver is only instantiated via Device Tree and corresponding
> OF APIs should never ever return 0 for valid IRQ. Otherwise it is
> a regression there.

Can it be applied now?

-- 
With Best Regards,
Andy Shevchenko


