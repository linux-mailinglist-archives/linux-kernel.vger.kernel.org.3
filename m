Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1754B54D9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358519AbiFPFbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiFPFbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:31:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0AA5AEF0;
        Wed, 15 Jun 2022 22:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655357471; x=1686893471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=idniUYYiBsnK5KguXLq8aPFkLwIsz0QVjklyx1DP7CI=;
  b=SHjv+zq0vH+9PpbjmJmSJIDkRsIQXKhs92GMdY23QqCv+wBPdbF3Hx1k
   hXYy1qHbwwu4U2oyXFsW5ytQnOlXL09wrnqELC6VgwUnkxoaqbSFi9WU9
   bF54cyiXh0GytctG61v6X9i6srZs55BBt/m3Bv34uu9HtcRoezwnlRV+r
   D8h+4aBQVQabHxegkmK9nKZoyxNhINWBnLV08f4V1cYXyUT/WTGnGnoLU
   da058kHdxHfkr/DIstBCSKZ9l0GMP3BCmMDAOp9+XjwTU+RCTiTJBQwyo
   UT1zQMcLBkbTWlZBn7UNypjkbVOOhtCyO3PRo8ytf8Ca2/sAtaSDQLJaz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277966547"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="277966547"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:31:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="613034481"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:31:06 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Jun 2022 08:31:04 +0300
Date:   Thu, 16 Jun 2022 08:31:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Oleksandr Ocheretnyi <oocheret@cisco.com>
Cc:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        p.yadav@ti.com, michael@walle.cc, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, mauro.lima@eclypsium.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
Subject: Re: [PATCH v2] mtd: spi-nor: handle unsupported FSR opcodes properly
Message-ID: <YqrAGKLUazeNH1XK@lahna>
References: <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
 <20220615191153.3017939-1-oocheret@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615191153.3017939-1-oocheret@cisco.com>
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

On Wed, Jun 15, 2022 at 12:11:53PM -0700, Oleksandr Ocheretnyi wrote:
> Originally commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q*
> entries") and following one 8f93826 ("mtd: spi-nor: micron-st: convert
> USE_FSR to a manufacturer flag") enabled SPINOR_OP_RDFSR opcode handling
> ability, however some controller drivers still cannot handle it properly
> in the micron_st_nor_ready() call what breaks some mtd callbacks with
> next error logs:
> 
> mtdblock: erase of region [address1, size1] on "BIOS" failed
> mtdblock: erase of region [address2, size2] on "BIOS" failed
> 
> The Intel SPI controller does not support low level operations, like
> reading the flag status register (FSR). It only exposes a set of high
> level operations for software to use. For this reason check the return
> value of micron_st_nor_read_fsr() and if the operation was not
> supported, use the status register value only. This allows the chip to
> work even when attached to Intel SPI controller (there are such systems
> out there).
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I don't think I signed this off.

> Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
> Link: https://lore.kernel.org/lkml/YmZUCIE%2FND82BlNh@lahna/
> ---

What changed between v1 and v2? And did you take into consideration the
comments I gave?
