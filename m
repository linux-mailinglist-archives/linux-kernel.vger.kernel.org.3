Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2054D9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358482AbiFPF3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiFPF3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:29:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABDE583B9;
        Wed, 15 Jun 2022 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655357378; x=1686893378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxLlY5sY3j1BaSU2opYF6e/oGGZzthY7yGLwx6OFor0=;
  b=hqARtr/2InaNKWRU1MWNr+JYvApy48j3efJxsK3Xb6+1DppqSMYSMvsc
   Q1LoZy7he+MXkNaooRB66H5xuDyDn98I2Nl9dHSB7A4Vgm7FTJXlhdLrA
   mxs1EcEyF+5RSh2APZf8v9yaT9kwFHib1oKBohBTXUrbrJqfgMGKi4JWb
   Rv2CLucntwjDyhSycdtJjOJWcrDLQERnZHvSfgiTmxT5It3iEAG7Xdlc1
   CtpBUWoo+GJfQy4vomePRGF1jfQACFX2AAQkEO7l0pcwY+63eV6+H96uI
   9Rn0hUcAWXW+dBl8I4mDbGXssKDHA+lIe9Mwdtj+xI0CMfwxMMoBIWQmB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259024046"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="259024046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:29:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="687664970"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:29:34 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Jun 2022 08:29:31 +0300
Date:   Thu, 16 Jun 2022 08:29:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     "Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco)" 
        <oocheret@cisco.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
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
Message-ID: <Yqq/u9SAjE0lhxap@lahna>
References: <YmZUCIE/ND82BlNh@lahna>
 <20220610191548.3626218-1-oocheret@cisco.com>
 <YqbWt9f3of+7Z76e@lahna>
 <BYAPR11MB27570F2863F7BCDFE629B3DFCDAA9@BYAPR11MB2757.namprd11.prod.outlook.com>
 <YqmrIsOEsFoKTwEK@lahna>
 <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 08:10:13PM +0200, Michael Walle wrote:
> Am 15. Juni 2022 11:49:22 OEZ schrieb Mika Westerberg <mika.westerberg@linux.intel.com>:
> >Hi,
> >
> >On Tue, Jun 14, 2022 at 05:56:54PM +0000, Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco) wrote:
> >>    Hello Mika,
> >> 
> >>    in my case (I work with memory chip n25q128a13 for recent kernels) I'm
> >>    getting return value -ENOTSUPP from spi_mem_exec_op() call in the
> >>    micron_st_nor_read_fsr() method
> >>    [[1]https://elixir.bootlin.com/linux/v5.19-rc2/source/drivers/spi/spi-m
> >>    em.c#L326]. So I decided to provide the same errorcode to
> >>    intel_spi_hw_cycle() method because older kernel versions throw the
> >>    error there. It is fine to use -EOPNOTSUPP return value instead.
> >> 
> >>    I suspect we need to cover both cases to check -ENOTSUPP as well as
> >>    -EOPNOTSUPP to let the driver work properly.
> >> 
> >>    if (ret == -ENOTSUPP || ret == -EOPNOTSUPP)
> >
> >I think we should follow the same in the Intel driver and return
> >-ENOTSUPP too.
> 
> AFAIK ENOTSUPP is for nfs and shouldn't be used.

Yes, but that's what the SPI-NOR core is using so I think we want to be
consistent with it.
