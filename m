Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227DB50DABE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiDYIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiDYH7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:59:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28ACCE2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650873359; x=1682409359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XQv8wyBFruRQaLwD5UI6qiGXru0gitI+QJEBT5NMidw=;
  b=Tqdlu3nuVTEnNpl8BTYZy6aQr9Qa0HOYJB5BxkRQFOSOTh5yt1RURySQ
   daTjIFYjWEsphHYXQrJeOaRZxrhgG+oWM84C16d/ojaxXzVCvfgsX0Ebd
   /G8XzjL8mvPrcn1ItyHXppxzK8Y+RuCqIJye1gBf45hAMMn0IMXPE7FPN
   JKD9ga1VJj2EjdnVCLWC9Zigb6F1s+VTEEFmgOe3YEJwnhq9GbhxJOcZQ
   5Bg90rczVFcYk2nupfTqAXTwimz+E1qEg86bGate/VfV0Op2Y6rgCGxem
   xn5xu4xs67cJAT8noA8j82jAMgwhg6mVxf6GfwMjj5HScnAt3ej+gkA4A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264025372"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264025372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:55:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="660037713"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:55:55 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Apr 2022 10:55:52 +0300
Date:   Mon, 25 Apr 2022 10:55:52 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     "Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco)" 
        <oocheret@cisco.com>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mauro.lima@eclypsium.com" <mauro.lima@eclypsium.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: mtd: spi-nor: fatal issue during the mtd_erase() calls
Message-ID: <YmZUCIE/ND82BlNh@lahna>
References: <BYAPR11MB27570C5DC510D0F37FC106E4CDF69@BYAPR11MB2757.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB27570C5DC510D0F37FC106E4CDF69@BYAPR11MB2757.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 23, 2022 at 10:32:28PM +0000, Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco) wrote:
>    Hello guys,
> 
>    recently I've faced the fatal issue "mtdblock: erase of region ... on
>    ... failed"
> 
>    working with MTD device (Micron n25q128a13) on recent kernels with
>    version
> 
>    5.15.x and newer.
> 
>    Commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q* entries")
>    adds
> 
>    SPINOR_OP_RDFSR opcode handling ability, however controller driver's
>    side
> 
>    (i.e. intel-spi) cannot handle it properly in the intel_spi_hw_cycle()
>    what causes
> 
>    a failures in the the spi_nor_fsr_ready() call what breaks some mtd
>    callbacks.
> 
>    Are there any plans to implement this SPINOR_OP_RDFSR opcode handling
> 
>    on the intel controller side? Is there acceptable way to provide
>    ENOTSUPP
> 
>    case response from controller driver side to spi-nor driver?

I think the Intel controller does support this internally but it does
not expose this to the software. I wonder if in this case we can, like
you suggest, return -ENOTSUPP and make micron_st_nor_ready() to handle
that case?

SPI-NOR folks, what you do think?
