Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29D53246C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiEXHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiEXHvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:51:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69F344F6;
        Tue, 24 May 2022 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378697; x=1684914697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ezuwNC3Ri6ziJQDL1WtU/NytA9dM8Bj444NnFMP1PZ0=;
  b=TYpjlE5ipDQq9yRs3SGxZWyg9KaEJ67991Cg9ibJD7pL8jWoAXXxAEeD
   8TRVYCD/O5VIV0ALB8R4ag+Le09EktcciaPwVZ5iUpizAtWHVt+H/V5n8
   iKdNUTg58PtSACk4CpHNODPFh+uVhzbC5e61zi5GcddTBXU95bKsfOePi
   AhWWsLCq0WZD3v5Omcbukg7SxxAGdRuJ5DY+nDatHKhIg3Azb9gGx08yH
   ubGAUjZ7c9sOgC32NAevHI0mP5CiRJzKdaX1dvwoerISe9fveTfqmvvWC
   kkYgOpJfH4ypbhaelyJ7h7Wjq7pxkizMLlOEcj/U1ZZpXv1Bny1SQNl0P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="261067825"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="261067825"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:51:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="572506245"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:51:35 -0700
Date:   Tue, 24 May 2022 08:51:31 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     yoan.picchi@arm.com
Cc:     ardb@kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, andre.przywara@arm.com
Subject: Re: [RFC PATCH 2/2] Removes the x86 dependency on the QAT drivers
Message-ID: <YoyOg/kYGtO+nQac@silpixa00400314>
References: <CAMj1kXGAiA-SkTFD5EgcacYao0RKT7oK0AxvxkR7Ho_KZSGXCw@mail.gmail.com>
 <8f6d8d1f-2872-15b9-d38b-1e8eb26f781b@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f6d8d1f-2872-15b9-d38b-1e8eb26f781b@foss.arm.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:00:40PM +0100, Yoan Picchi wrote:
> >> From: Yoan Picchi <yoan.picchi@arm.com>
> >>
> >> The QAT acceleration card can be very helpfull for some tasks like
> >> dealing with IPSEC but it is currently restricted to be used only on x86
> machine.
> >> Looking at the code we didn't see any reasons why those drivers might
> >> not work on other architectures. We've successfully built all of them
> >> on x86, arm64, arm32, mips64, powerpc64, riscv64 and sparc64.
> >>
> >> We also have tested the driver with an Intel Corporation C62x Chipset
> >> QuickAssist Technology (rev 04) PCIe card on an arm64 server. After
> >> the numa patch, it works with the AF_ALG crypto userland interface,
> >> allowing us to encrypt some data with cbc for instance. We've also
> >> successfully created some VF, bound them to DPDK, and used the card
> >> this way, thus showing some real life usecases of x86 do work on arm64
> too.
> >>
> >> Please let us know if we missed something that would warrants some
> >> further testing.
> >Thanks Yoan.
> >
> >Can you please confirm that you tested the driver on the platform you
> reported using a kernel with CONFIG_CRYPTO_MANAGER_DISABLE_TESTS not set and
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y and the self test >is passing?
> >You can check it by running
> >    $ cat /proc/crypto | grep -B 4 passed | grep -e "qat_\|qat-" | sort
> This should report:
> >    driver       : qat_aes_cbc
> >    driver       : qat_aes_cbc_hmac_sha1
> >    driver       : qat_aes_cbc_hmac_sha256
> >    driver       : qat_aes_cbc_hmac_sha512
> >    driver       : qat_aes_ctr
> >    driver       : qat_aes_xts
> >    driver       : qat-dh
> >    driver       : qat-rsa
> >
> >Note that if you are using the HEAD of cryptodev-2.6 you will have to
> either revert 8893d27ffcaf6ec6267038a177cb87bcde4dd3de or apply
> >https://patchwork.kernel.org/project/linux-crypto/list/?series=639755 as
> the algorithms have been temporarily disabled.
> >
> >Regards,
> >
> >--
> >Giovanni
> 
> Hi Giovanni.
> 
> Thanks for the instructions, I did not know of this test.
> I rebuilt my kernel on arm64 with those parameter and I confirm I get the
> same output with
> $ cat /proc/crypto | grep -B 4 passed | grep -e "qat_\|qat-" | sort
Thats great. Thanks.

Is the platform where you ran the tests little or big endian?
If little endian, can you re-test on a big endian system?

Thanks,

-- 
Giovanni
