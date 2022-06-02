Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0853B7A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiFBLK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiFBLK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:10:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499C3BBE3;
        Thu,  2 Jun 2022 04:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654168255; x=1685704255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=olQ0OA0H1c6Sts3x+w8aOXscdnJ5P5s3LhpfS4yRNpE=;
  b=Jv7phIW5/ZND3ALAr9M9pf05AeKhWqO5UzRa3L2JaYRHYg12ew0yz85n
   51dgNNjDjHiHR6b89wBGyJBaNSzZQtMf50BkKJU+fGIMqpOv7bEQe/kVT
   D0/HTjL/WjhzMVr6/L0a/ViYo07nTIrsXm4VOEy5Uy+L4ZBhe877kK1HT
   Qq58KuG/WhchDux0S6lSGZLzP2OrERcCVLxxRUhQiVXYi5JCmSAEz7S19
   b9wPrR0Ys2Qy5j2IEX9ZxxNRe2DYXUKrKDBeTxoK/WN2DemKcK79nQNZT
   JKGSzMRyilGCLMaaQKMRHAKDsXmhpKM+eDgiueF/sbVKqfF+L4M2O+9Yh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="336573571"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="336573571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:10:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="721260311"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:10:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nwiiz-000RZf-AX;
        Thu, 02 Jun 2022 14:10:45 +0300
Date:   Thu, 2 Jun 2022 14:10:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [RESEND v12 0/3] mmc: mediatek: add support for SDIO async IRQ
Message-ID: <YpiatZh+ZMpoAp/K@smile.fi.intel.com>
References: <20220525015140.384-1-axe.yang@mediatek.com>
 <1d07579c0a6b8853ab72e345a0bd0be73549de8c.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d07579c0a6b8853ab72e345a0bd0be73549de8c.camel@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 02:07:04PM +0800, Axe Yang wrote:
> Hi,
> 
> Gentle ping for this set.

It's a merge window, so your code perhaps will be considered next week,
or later.

-- 
With Best Regards,
Andy Shevchenko


