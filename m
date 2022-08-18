Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697CB597BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbiHRCri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiHRCre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7ECA346D;
        Wed, 17 Aug 2022 19:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689C9614B0;
        Thu, 18 Aug 2022 02:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8B0C433D6;
        Thu, 18 Aug 2022 02:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660790852;
        bh=c7uT9koc8U8mgfCsGXhV/NIvZmDySC2I31QPHpGYGpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dR0EZJNzAk2Z1wWG+mFvzdBQtmynKli0LWqiGDrTXoO5+NDnm0TPKVTh4iDIOoJei
         yF6t8sGdVt8Qmp7xmRSDO1+4bopBQ53eUCXqE/QQ0SFcnYPSW4khCvV8jzoO9FCvsW
         qwj3Kw5Q4iHM6ThRtcYdcArr3vc4eIEwWjvwP/yGyDM6YdMikHAK2rrgoZgleDHzaR
         uBl5Hnw7unSNCTZt1tvagUYFoDqmwCLcSfQeFdpVM+63kLO06jyAzDieWdcIvjwnMJ
         kcJBg04CunxB4myh78oHT4fS6q+CohPGberCIz5ZiybET+00C1z4z7FIzQqgBrfD9R
         nUW8EhETqrknw==
Date:   Wed, 17 Aug 2022 19:47:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Message-ID: <Yv2oQijegCNFQMO1@sol.localdomain>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 06:20:47PM -0500, Robert Elliott wrote:
> Improve the "make menuconfig" experience under the
> Cryptographic API page.
> 
> The first of two patch series. This series extracts all the
> architecture-specific entries from
>     crypto/Kconfig
> into
>     arch/*/crypto/Kconfig
> 
> A subsequent series will work on the entry titles and help text.
> 
> Tested by running commands like these for arm, arm64, mips, powerpc,
> sparc, s390, and x86:
>     make ARCH=arm O=build-arm allmodconfig
>     cd build-arm
>     make ARCH=arm menuconfig
>     make ARCH=arm CROSS_COMPILE=arm-linux-gnu- -j 55
> 
> Notes: 
> 1. powerpc doesn't build for reasons unrelated to this series.
> 
> 2. arm (32-bit) requires the fix to the SA2UL driver included
> in this series.
> 
> 3. arm (32-bit) and mips require increasing the following value
> from 1024. That change is not included in the series.
>     CONFIG_FRAME_SIZE=2048
> 
> 
> Robert Elliott (10):
>   crypto: Kconfig - move mips entries to a submenu
>   crypto: Kconfig - move powerpc entries to a submenu
>   crypto: Kconfig - move s390 entries to a submenu
>   crypto: Kconfig - move sparc entries to a submenu
>   crypto: Kconfig - move x86 entries to a submenu
>   crypto: Kconfig - remove AES_ARM64 selection by SA2UL entry
>   crypto: Kconfig - move arm and arm64 menus to Crypto API page
>   crypto: Kconfig - sort the arm64 entries
>   crypto: Kconfig - sort the arm entries
>   crypto: Kconfig - add submenus

What commit does this series apply to?

- Eric
