Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01D4CC84C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiCCVpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiCCVpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:45:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F486ED97F;
        Thu,  3 Mar 2022 13:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A569761D08;
        Thu,  3 Mar 2022 21:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3A4C004E1;
        Thu,  3 Mar 2022 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646343895;
        bh=xxcsEvOhq8iB9VW0nycuaFYuEoStGLZGuonqKaIfxd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OttiH7QDEmygRRqAaMhjSAQpHIddoZSaFPdQ9xGehHsbD6/t0iwVh2nEoTEmOm3Oz
         /IkeBQK7WlLJTVtsM/bRRFfNDSLbVw7N3YqmZcHvgXl/5rozDVbUGMl9mIkn+1OdYc
         omoxg5ZsjXeE9XG+7a7StJlja6DyIMWVf+ZHex7hPwZH3pU4WI4k21pyNhmXRwQGR0
         9Um/6UsHSfvtfMjQlWby19k9OWpXKoim6V0CA9xFEQ8lhHgp1sxEeiKBzzJY6r2lrJ
         3Bi49WsEZl2qop+DljA4r6LnO7H20LVXXJgz2qV+BzN2zce9EuC5Taw6cRXOXpjizw
         aRXpvYzegeJHw==
Date:   Thu, 3 Mar 2022 21:44:53 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <YiE21aPGG5DHwJvb@gmail.com>
References: <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
 <Yh9G7FyCLtsm2mFA@kroah.com>
 <Yh9ZvLHuztwQCu0d@silpixa00400314>
 <Yh+FpKuoyj3G16lK@kroah.com>
 <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
 <Yh/yr6oB5yeOUErL@silpixa00400314>
 <Yh/znCnZzWaL49+o@gondor.apana.org.au>
 <YiDHT31ujlGdQEe/@silpixa00400314>
 <YiEVPc2cd38AnLZB@gmail.com>
 <YiEyGoHacN80FcOL@silpixa00400314>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiEyGoHacN80FcOL@silpixa00400314>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:24:42PM +0000, Giovanni Cabiddu wrote:
> On Thu, Mar 03, 2022 at 07:21:33PM +0000, Eric Biggers wrote:
> > If these algorithms have critical bugs, which it appears they do, then IMO it
> > would be better to disable them (either stop registering them, or disable the
> > whole driver) than to leave them available with low cra_priority.  Low
> > cra_priority doesn't guarantee that they aren't used.
> Thanks for your feedback Eric.
> 
> Here is a patch that disables the registration of the algorithms in the
> QAT driver by setting, a config time, the number of HW queues (aka
> instances) to zero.
> 
> ---8<---
> From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Subject: [PATCH] crypto: qat - disable registration of algorithms
> Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
> 
> The implementations of aead and skcipher in the QAT driver do not
> support properly requests with the CRYPTO_TFM_REQ_MAY_BACKLOG flag set.
> If the HW queue is full, the driver returns -EBUSY but does not enqueue
> the request.
> This can result in applications like dm-crypt waiting indefinitely for a
> completion of a request that was never submitted to the hardware.
> 
> To avoid this problem, disable the registration of all skcipher and aead
> implementations in the QAT driver by setting the number of crypto
> instances to 0 at configuration time.
> 
> This patch deviates from the original upstream solution, that prevents
> dm-crypt to use drivers registered with the flag
> CRYPTO_ALG_ALLOCATES_MEMORY, since a backport of that set to stable
> kernels may have a too wide effect.
> 
> commit 7bcb2c99f8ed032cfb3f5596b4dccac6b1f501df upstream
> commit 2eb27c11937ee9984c04b75d213a737291c5f58c upstream
> commit fbb6cda44190d72aa5199d728797aabc6d2ed816 upstream
> commit b8aa7dc5c7535f9abfca4bceb0ade9ee10cf5f54 upstream
> commit cd74693870fb748d812867ba49af733d689a3604 upstream
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/crypto/qat/qat_common/qat_crypto.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Sounds good; is there any reason not to apply this upstream too, though?
You could revert it later as part of the patch series that fixes the driver.

- Eric
