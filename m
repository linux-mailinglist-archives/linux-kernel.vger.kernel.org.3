Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1975454F382
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380457AbiFQItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiFQIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:49:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1615967D2B;
        Fri, 17 Jun 2022 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655455770; x=1686991770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k1Hf4ppqXSBfgS8VjPssKfER3lpSiR1o1Na/R3h9Srk=;
  b=MlSimtEInR+Chi7izI1xQ7Yb8x6HfEr56oiyBqcteWDCW2isyD+s/06k
   E4l86uTNhCBsvGp4PikIMVOtWP4xJIqSAsbQl2hQhiDyGzvp4lf+kSFdl
   NvTELeSRtgGx0SyFgnuoFmx5JSCU+uBoWm4jdeKhNFjbEu+w8BgKhZLSC
   RXjdZiQIPf2aPuSRYRGMs33VGjHLZl9wqPBeXfQDRl0wS4yuyrNYnt02s
   mFKzZtmEfgoJvxbGjkxQuEXjZaoiYv5GPWdTdPS7Vfuph9Jbw6Q/iBllJ
   FEBoh/qlTZdG9pgbUlsXdDrP0q7i4BnjzLuBBoxePbEGrXAMfa5LqUUjT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304908443"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="304908443"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 01:49:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675410803"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 01:49:27 -0700
Date:   Fri, 17 Jun 2022 09:49:20 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Yoan Picchi <yoan.picchi@arm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/2] Crypto: Remove x86 dependency on QAT drivers
Message-ID: <YqxAEID8lu497CCe@silpixa00400314>
References: <20220613142535.222041-1-yoan.picchi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613142535.222041-1-yoan.picchi@arm.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoan,

On Mon, Jun 13, 2022 at 02:25:33PM +0000, Yoan Picchi wrote:
> The QAT acceleration card can be very helpfull for some tasks like dealing
> with IPSEC but it is currently restricted to be used only on x86 machine.
> Looking at the code we didn't see any reasons why those drivers might not
> work on other architectures. We've successfully built all of them on x86,
> arm64, arm32, mips64, powerpc64, riscv64 and sparc64.
> 
> We also have tested the driver with an Intel Corporation C62x Chipset
> QuickAssist Technology (rev 04) PCIe card on an arm64 server. After the numa
> patch, it works with the AF_ALG crypto userland interface, allowing us to
> encrypt some data with cbc for instance. We've also successfully created some
> VF, bound them to DPDK, and used the card this way, thus showing some real
> life usecases of x86 do work on arm64 too.
> 
> Changelog v1 ... v2:
> - add COMPILE_TEST to Kconfig
> 
> Andre Przywara (1):
>   crypto: qat: replace get_current_node() with numa_node_id()
> 
> Yoan Picchi (1):
>   Removes the x86 dependency on the QAT drivers
Would you mind re-sending the set changing the headline of the commit
messages as reported in the previous email?
https://www.spinics.net/lists/linux-crypto/msg64584.html

Thanks,

-- 
Giovanni
