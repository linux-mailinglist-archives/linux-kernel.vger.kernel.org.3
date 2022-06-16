Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300CC54DF32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiFPKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiFPKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:35:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B75DBFB;
        Thu, 16 Jun 2022 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655375735; x=1686911735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bfn7Kr/6Mg81QIsDd2mRVCMs364rPZOp5AMz87j7Fog=;
  b=C+HO0dlgTSRS5BfiNc1wvbzLqRPtBxh4lxKP++PeFC57ARyGINKRpntX
   0zyMKWsvVTNVYHuC6ewnc1eT2T4K4Edtlllg948WtjDY9EIBPNC1wEAi/
   7MfO3q6B4v1XjQ564zn8Ec5n0B0cSC96prihpGOri1RhurvnFojyhC6o0
   /jnxvSYj/40fOFsU13bsfC0UY/6V2aLPs+4Dccvg5a2qUxrOAYdrBM4P8
   VDXzqMJHj65sGGZQOgeMOONPgWe26/IQevpSVxwI4BHXe1cHfVlF1GsPE
   StZzrOtvrn6Phr2ycnJFnCt+KR0bxXIWRt/thukjN0Cdtt3+qtzXu++Cv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259681977"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="259681977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 03:35:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="727840496"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 03:35:31 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Jun 2022 13:35:28 +0300
Date:   Thu, 16 Jun 2022 13:35:28 +0300
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
Message-ID: <YqsHcL5NPcZ4De77@lahna>
References: <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
 <20220615191153.3017939-1-oocheret@cisco.com>
 <YqrAGKLUazeNH1XK@lahna>
 <BYAPR11MB2757B1146457E3860389F4D1CDAC9@BYAPR11MB2757.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2757B1146457E3860389F4D1CDAC9@BYAPR11MB2757.namprd11.prod.outlook.com>
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

On Thu, Jun 16, 2022 at 07:40:18AM +0000, Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco) wrote:
>    Hi Mika,
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
> 
>    > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
>      I don't think I signed this off.
> 
>    I thought if I take your case (-EOPNOTSUPP) and update it with
>    (-ENOTSUPP) I need to keep
> 
>    your Sighed-off-by: note as well.

That's not how it typically works. People will give their tag explicitly
and then you can add those.

>    > Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
>    > Link: [1]https://lore.kernel.org/lkml/YmZUCIE%2FND82BlNh@lahna/
>    > ---
> 
>    What changed between v1 and v2?
> 
>    ​I updated v1 patch taking into account your changes
>    [2]https://lore.kernel.org/linux-mtd/20220506105158.43613-1-mika.wester
>    berg@linux.intel.com to check -EOPNOTSUPP case as well. After I
>    combined both patches I've got v2.

Please put that information after the '---' in the patch.

>    And did you take into consideration the comments I gave?
> 
>    ​If you say about keeping -ENOTSUPP as intel driver errorcode - I took
>    it however doubted to use it here because of note about nfs above.
>    There is no problem to restore previous variant with -ENOTSUPP in intel
>    driver errorcode.

Well we would need to get some feedback from SPI-NOR maintainers. I
would personally keep using ENOTSUPP to be consistent with the rest of
the code in SPI-NOR code (or convert it to use EOPNOTSUPP everywhere)
but it is not up to me ;-)

For Intel driver it is fine to use either (whetever the decision of
SPI-NOR maintainers' is).
