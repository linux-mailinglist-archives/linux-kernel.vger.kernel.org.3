Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C345A529271
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348347AbiEPUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbiEPUuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 16:50:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA6CF2;
        Mon, 16 May 2022 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652732759; x=1684268759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+Om2Nhj5JA77vWK4kvR0zricBYgkeFtHqrTTN0lf4w=;
  b=P65PJLmllKTEKMmx+DJ8cbBA+nVDvwzHcLVOfdZd4meYcB3aXM1kAzlz
   BX9JXVYLf1la3PRyGmINcYaus2j62bxLzDwgJfUuxOsZqfT/xYnJNZIF9
   rsLZiphKh3g2IrV5+IrqKGSKreivyF8ytm/TDuB6sDbSizOtBuXg4cqD7
   CcNTNpJKUrq7W96z6/+xi0h7cwl8EHUk43GuZBu1owTy9hhCvMkppAi2m
   oY1XPDuOpYRGGguTTjqxQdUEvwFSey0tj/ZXMNs2i5rJbgjIlx72+xvdn
   lsM/8bNzyEqgYVVzSvHI9wOqPno76HvInODT2kBXtjfVtgJLRrmCQel5T
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="296227225"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="296227225"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:25:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="544535615"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:25:56 -0700
Date:   Mon, 16 May 2022 21:25:50 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     yoan.picchi@arm.com
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Crypto: Remove x86 dependency on QAT drivers
Message-ID: <YoKzTtBv3qWQf4SI@silpixa00400314>
References: <20220516101635.1082132-1-yoan.picchi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516101635.1082132-1-yoan.picchi@arm.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:16:33AM +0000, yoan.picchi@arm.com wrote:
> From: Yoan Picchi <yoan.picchi@arm.com>
> 
> The QAT acceleration card can be very helpfull for some tasks like dealing
> with IPSEC but it is currently restricted to be used only on x86 machine.
> Looking at the code we didn't see any reasons why those drivers might not
> work on other architectures. We've successfully built all of them on x86,
> arm64, arm32, mips64, powerpc64, riscv64 and sparc64.
> 
> We also have tested the driver with an Intel Corporation C62x Chipset
> QuickAssist Technology (rev 04) PCIe card on an arm64 server. After the numa
> patch, it works with the AF_ALG crypto userland interface, allowing us to
> encrypt some data with cbc for instance. We've also successfully created
> some VF, bound them to DPDK, and used the card this way, thus showing some
> real life usecases of x86 do work on arm64 too.
> 
> Please let us know if we missed something that would warrants some further
> testing.
Thanks Yoan.

Can you please confirm that you tested the driver on the platform you
reported using a kernel with CONFIG_CRYPTO_MANAGER_DISABLE_TESTS not set
and CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y and the self test is passing?
You can check it by running
    $ cat /proc/crypto | grep -B 4 passed | grep -e "qat_\|qat-" | sort
This should report:
    driver       : qat_aes_cbc
    driver       : qat_aes_cbc_hmac_sha1
    driver       : qat_aes_cbc_hmac_sha256
    driver       : qat_aes_cbc_hmac_sha512
    driver       : qat_aes_ctr
    driver       : qat_aes_xts
    driver       : qat-dh
    driver       : qat-rsa

Note that if you are using the HEAD of cryptodev-2.6 you will have to
either revert 8893d27ffcaf6ec6267038a177cb87bcde4dd3de or apply
https://patchwork.kernel.org/project/linux-crypto/list/?series=639755 as
the algorithms have been temporarily disabled.

Regards,

-- 
Giovanni
