Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4954E149
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiFPM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiFPM7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:59:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EFFB4C;
        Thu, 16 Jun 2022 05:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655384378; x=1686920378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Cc3oGdVH1nDPzLTWA7m1b0GeLH9ZTWSmjCrCfx9L430=;
  b=kXubY9f4V8Xo1ep/gr808gJ14SjE1SQV558Nn+mXBK4iJy3CCp3cVDoO
   vqlTdktrGjYC9sU7absKmiwlZXaLoRpBqLSbzxFz1V2yPSvckvSV4cmxZ
   m6oJNgP52LGFbSRGd8eTKKlcVvH3Qt2h8pq+QRM09w1cdPVTpZjEQ/lPZ
   5rcRqEcK5bN4CEryTdkUPBsvWyAYJ7JxUd0VwT1FvUfaaj8xT8xicWK7t
   8n5C0/0Ikv5p5fvW5iv5jXxMubdb3xrY0Xcz11/pYavmPo1le+ZiEQGsD
   50bf+oUmeX7etO9mFlMZMJhK8xVjnBKpQkJlVkbU8+3LlUSYngNSqCz3q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279299453"
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="279299453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 05:59:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="727880472"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 05:59:33 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Jun 2022 15:59:31 +0300
Date:   Thu, 16 Jun 2022 15:59:31 +0300
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
Subject: Re: [PATCH v2] mtd: spi-nor: handle unsupported FSR opcodes properly
Message-ID: <YqspM2Sw+Fu9y56Z@lahna>
References: <YqsHcL5NPcZ4De77@lahna>
 <20220616121446.293408-1-oocheret@cisco.com>
 <YqsjGx54+Gd8Aws/@lahna>
 <BYAPR11MB2757CEBE99C3A0861928CD43CDAC9@BYAPR11MB2757.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2757CEBE99C3A0861928CD43CDAC9@BYAPR11MB2757.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:54:42PM +0000, Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco) wrote:
>    Hi,
> 
>      > Originally commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for
>      n25q*
>      > entries") and following one 8f93826 ("mtd: spi-nor: micron-st:
>      convert
>      > USE_FSR to a manufacturer flag") enabled SPINOR_OP_RDFSR opcode
>      handling
>      > ability, however some controller drivers still cannot handle it
>      properly
>      > in the micron_st_nor_ready() call what breaks some mtd callbacks
>      with
>      > next error logs:
>      >
>      > mtdblock: erase of region [address1, size1] on "BIOS" failed
>      > mtdblock: erase of region [address2, size2] on "BIOS" failed
>      >
>      > The Intel SPI controller does not support low level operations,
>      like
>      > reading the flag status register (FSR). It only exposes a set of
>      high
>      > level operations for software to use. For this reason check the
>      return
>      > value of micron_st_nor_read_fsr() and if the operation was not
>      > supported, use the status register value only. This allows the
>      chip to
>      > work even when attached to Intel SPI controller (there are such
>      systems
>      > out there).
>      >
>      > Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
>      > Link: [1]https://lore.kernel.org/lkml/YmZUCIE%2FND82BlNh@lahna/
>      > ---
>      >  PATCH v2 updates PATCH v1 taking into account changes from
>      >
>      [2]https://lore.kernel.org/linux-mtd/20220506105158.43613-1-mika.wes
>      terberg@linux.intel.com
>      >  to check -EOPNOTSUPP value from micron_st_nor_read_fsr() as well.
>      >
>      >  drivers/mtd/spi-nor/micron-st.c | 12 ++++++++++--
>      >  drivers/spi/spi-intel.c         |  3 ++-
>      >  2 files changed, 12 insertions(+), 3 deletions(-)
>      >
>      > diff --git a/drivers/mtd/spi-nor/micron-st.c
>      b/drivers/mtd/spi-nor/micron-st.c
>      > index a96f74e0f568..fd52e8feea44 100644
>      > --- a/drivers/mtd/spi-nor/micron-st.c
>      > +++ b/drivers/mtd/spi-nor/micron-st.c
>      > @@ -399,8 +399,16 @@ static int micron_st_nor_ready(struct spi_nor
>      *nor)
>      >                return sr_ready;
>      >
>      >        ret = micron_st_nor_read_fsr(nor, nor->bouncebuf);
>      > -     if (ret)
>      > -             return ret;
>      > +     if (ret < 0) {
>      > +             /*
>      > +              * Some controllers, such as Intel SPI, do not
>      support low
>      > +              * level operations such as reading the flag status
>      > +              * register. They only expose small amount of high
>      level
>      > +              * operations to the software. If this is the case
>      we use
>      > +              * only the status register value.
>      > +              */
>      > +             return (ret == -ENOTSUPP || ret == -EOPNOTSUPP) ?
>      sr_ready : ret;
>      The -EOPNOTSUPP here is not needed as you change the Intel SPI
>      driver in
> 
>    the below.
> 
>    ​However I remember you caught situation where micron_st_nor_read_fsr()
>    returns -EOPNOTSUPP
>    (intel_spi_exec_mem_op callback returns -EOPNOTSUPP), according to your
>    patch
>    [3]https://lore.kernel.org/linux-mtd/20220506105158.43613-1-mika.wester
>    berg@linux.intel.com/ I've noted in description body. So I think I have
>    to cover both errorcodes, haven't I?

I was thinking that you change the both functions in Intel SPI to return
-ENOTSUPP, not just one.

>    Or your patch as well as my one are going submitted independently and
>    can be merged sequentially?

No, my patch can be ignored.
