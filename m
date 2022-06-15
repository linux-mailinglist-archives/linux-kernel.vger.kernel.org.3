Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430454C516
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbiFOJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiFOJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:49:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF8549695;
        Wed, 15 Jun 2022 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655286569; x=1686822569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fgoP/mzTE5gjuDZ8g87/11obiI4NZu5ZOraq//7+Q64=;
  b=JocYUTMKdwhiWynLO13suZIe9lUH5gs9DtMczfQOPoD6anOd1cw+xy6k
   NwPVZ/t0pI82uEO07/oR6gS9PJZosa5kXya7QKH4io2mhIKqECsIYjuyQ
   ZuTNk+oBF8mrUU/LWABE+vaV9Pq3Gv5wo8Cj1j+Ze9pDlTJ0xz0mhXOrs
   EnIpC+wBnix3KjVkF+ZghfbmhhTricdpda4MTq0AHV1SgD1f/ifRVQGFo
   uj+qrm+Y9pbawIabWFg1MSyZpkDO94yqZC7bW36qD1A1JWSUcZ9pdEylR
   jZFKK9keXMsXGF+3Ka3DqhIi1V3Lp4G03XwUObZA4Hp09L57R6mDMdu0E
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="365250969"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="365250969"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:49:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="618386934"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:49:24 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 15 Jun 2022 12:49:22 +0300
Date:   Wed, 15 Jun 2022 12:49:22 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco)" 
        <oocheret@cisco.com>
Cc:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mauro.lima@eclypsium.com" <mauro.lima@eclypsium.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] mtd: spi-nor: handle unsupported FSR opcodes properly
Message-ID: <YqmrIsOEsFoKTwEK@lahna>
References: <YmZUCIE/ND82BlNh@lahna>
 <20220610191548.3626218-1-oocheret@cisco.com>
 <YqbWt9f3of+7Z76e@lahna>
 <BYAPR11MB27570F2863F7BCDFE629B3DFCDAA9@BYAPR11MB2757.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB27570F2863F7BCDFE629B3DFCDAA9@BYAPR11MB2757.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 14, 2022 at 05:56:54PM +0000, Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco) wrote:
>    Hello Mika,
> 
>    in my case (I work with memory chip n25q128a13 for recent kernels) I'm
>    getting return value -ENOTSUPP from spi_mem_exec_op() call in the
>    micron_st_nor_read_fsr() method
>    [[1]https://elixir.bootlin.com/linux/v5.19-rc2/source/drivers/spi/spi-m
>    em.c#L326]. So I decided to provide the same errorcode to
>    intel_spi_hw_cycle() method because older kernel versions throw the
>    error there. It is fine to use -EOPNOTSUPP return value instead.
> 
>    I suspect we need to cover both cases to check -ENOTSUPP as well as
>    -EOPNOTSUPP to let the driver work properly.
> 
>    if (ret == -ENOTSUPP || ret == -EOPNOTSUPP)

I think we should follow the same in the Intel driver and return
-ENOTSUPP too.
