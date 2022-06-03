Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6453C3D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 06:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiFCEyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 00:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCEye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 00:54:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446B05FE6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 21:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654232073; x=1685768073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=928aeSsrAOgDgltZ98A47/FGkn0S4P24ur/iSUQl09E=;
  b=HYMyHhAQybW4NxZ+Nc8Zt9gVoI7nTqM42tiCKGqC4Rzn5+gh9wOYYAiV
   UqrsDYFE5bXVuekO5VmUbnqsk0tSTqhRhWAHPLg3Dw70Lexxzl73GW3hm
   5h5ZSq6Xk9IRNl8cw/jD5h5egJsq06U+xiQb+NKNzCWNP7HPdns5/kRvw
   1UZ8bGFxRnCwWWkF0saRSTtzGOF6yLBq5qOjMiuNIvi9iB5RZ3+tzCU+J
   ZYVYsts0rMu/9iJqy+ckRATj+V0yPx+f0YG0cPGlfIuQS+0ofZ3K3Cura
   +WHptzS72hccRV5rZY+aYG3FAQw78fddLfGrtciRj9xEhquJvgYRckACo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="336822459"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="336822459"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 21:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="905313425"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jun 2022 21:54:30 -0700
From:   kah.jing.lee@intel.com
To:     rdunlap@infradead.org
Cc:     arnd@arndb.de, dinguyen@kernel.org, gregkh@linuxfoundation.org,
        kah.jing.lee@intel.com, lftan@altera.com,
        linux-kernel@vger.kernel.org, tien.sung.ang@intel.com
Subject: Re: [PATCH 1/2] drivers: misc: intel_sysid: Add sysid from arch to drivers
Date:   Fri,  3 Jun 2022 12:52:57 +0800
Message-Id: <20220603045255.3073882-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4e2ef3c7-f329-eeaf-f330-3da2b30b0b7a@infradead.org>
References: <4e2ef3c7-f329-eeaf-f330-3da2b30b0b7a@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

> On 6/2/22 05:22, kah.jing.lee@intel.com wrote:
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 41d2bb0ae23a..a31489cc092c 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -483,6 +483,15 @@ config OPEN_DICE
> >  
> >  	  If unsure, say N.
> >  
> > +config INTEL_SYSID
> > +	tristate "Intel System ID"
> > +	help
> > +	  This enables Intel System ID soft core driver.
> > +	  Say Y here if you want to build a driver for Intel System ID driver.

> Probably drop the last (redundant)                                     driver
Updated =)

> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called intel_sysid. If unsure, say N here.
> > +

> -- 
> ~Randy
