Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719EA54F068
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380032AbiFQFEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiFQFEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:04:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95650666BD;
        Thu, 16 Jun 2022 22:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655442288; x=1686978288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KlkNvpHU3FLlFN/0ZiH/YdtckeEa9++ioBrEqdPOl1k=;
  b=jmGdZedNcosBL8oDwbVkJCQ3fVhMifHbrIv4xl/0h7D0nZXl7ONQWRtM
   JGuwEhhteQeHQ7Gzt8L52UBCsxtdWLHit51w1A3M2cr6gvRfq3H9M9Ybi
   6khxR4xkD/g+1YC8Ml2GFBJ6EU0hWnP5kdO5DfZ+16C6LFGA0pX0/lahk
   0rVsjCUmzVLP8QnmNoovIwgeX1JtZjrgm/F3BNJ+VBriPmiCpJi/3OA00
   oAnLcHn2ymyfmWATho6WL+Muaevv1VzuKE6a6+PbJMmm5+BMPjYlcGkZ9
   8aJjCHkJbomTiWjP4F2lyw1WSGtXrzIrvQKhxeEtTh6DWVaPvd21dkA+/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280453126"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280453126"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 22:04:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619145570"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 22:04:43 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 17 Jun 2022 08:04:40 +0300
Date:   Fri, 17 Jun 2022 08:04:40 +0300
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
Message-ID: <YqwLaIvjdRBsNRuU@lahna>
References: <YqsHcL5NPcZ4De77@lahna>
 <20220616121446.293408-1-oocheret@cisco.com>
 <YqsjGx54+Gd8Aws/@lahna>
 <BYAPR11MB2757CEBE99C3A0861928CD43CDAC9@BYAPR11MB2757.namprd11.prod.outlook.com>
 <YqspM2Sw+Fu9y56Z@lahna>
 <BYAPR11MB2757BD90C63B9F6A31E0600ACDAC9@BYAPR11MB2757.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2757BD90C63B9F6A31E0600ACDAC9@BYAPR11MB2757.namprd11.prod.outlook.com>
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

Hi,

On Thu, Jun 16, 2022 at 08:26:33PM +0000, Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco) wrote:
>    Hi Mika,
> 
>    >    ​However I remember you caught situation where
>    micron_st_nor_read_fsr()
>    >    returns -EOPNOTSUPP
>    >    (intel_spi_exec_mem_op callback returns -EOPNOTSUPP), according to
>    your
>    >    patch
>    >
>    [3]https://lore.kernel.org/linux-mtd/20220506105158.43613-1-mika.wester
>    >    berg@linux.intel.com/ I've noted in description body. So I think I
>    have
>    >    to cover both errorcodes, haven't I?
>    I was thinking that you change the both functions in Intel SPI to
>    return
> 
>    -ENOTSUPP, not just one.
> 
>    ​you know 'drivers/mtd/spi-nor' sources use -EOPNOTSUPP errorcode only,
>    however
> 
>    'drivers/spi' modules (where intel driver is located as well as
>    spi-mem.c) use both errorcodes many times
> 
>    (-EOPNOTSUPP and -ENOTSUPP).

Oh, indeed. I remembered that SPI-NOR core was using ENOTSUP but it was
SPI-MEM instead.

>    So maybe it is better to use -EOPNOTSUPP for intel driver file (what
>    uses -EOPNOTSUPP everywhere) and
> 
>    update the spi-mem.c with -EOPNOTSUPP as return value, how do you
>    think?

Yes, I think this is the correct approach. You need to be careful though
to make sure the callers of SPI-MEM functions do not get unexpected
values.
