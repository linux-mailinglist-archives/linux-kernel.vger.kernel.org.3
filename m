Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2957B50ACE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442973AbiDVAng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiDVAne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:43:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0DA3916D;
        Thu, 21 Apr 2022 17:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D34E4B829D0;
        Fri, 22 Apr 2022 00:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BD7C385A5;
        Fri, 22 Apr 2022 00:40:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z5yArAFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650588038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8D6g631qLAwI/Wgaap5lXRE2XihUy4yfmouFApINF20=;
        b=Z5yArAFed/D7nFTXjOVHkEl04z1TTazL5N806Me6tJH18NljY964EzAVjPwNSIXUyejm5T
        k0qNYrH0eMlIavHP6PE+qOjaIx5JbrRcbi00cb6n5KYx9WCTAkm4fVlL+jvwQWWQGw74dD
        /m1zQBlk6DaffpoE1FUJMAsQ6J/OjTI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2ce7d876 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 22 Apr 2022 00:40:38 +0000 (UTC)
Date:   Fri, 22 Apr 2022 02:40:36 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2] siphash: update the hsiphash documentation
Message-ID: <YmH5hDrUZKBymqYE@zx2c4.com>
References: <20220422002731.63801-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422002731.63801-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Apr 21, 2022 at 05:27:31PM -0700, Eric Biggers wrote:
> +On 64-bit kernels, the hsiphash functions actually implement SipHash-1-3, a
> +reduced-round variant of SipHash, instead of HalfSipHash-1-3. This is because in
> +64-bit code, SipHash-1-3 is no slower than HalfSipHash-1-3, and can be faster.
> +Note, this does *not* mean that in 64-bit kernels the hsiphash functions are the
> +same as the siphash ones, or that they are secure; the hsiphash functions still
> +use an insecure reduced-round algorithm and truncate their outputs to 32 bits.
 
Small nit: "less secure" rather than "insecure", as I don't think
there's a super realistic attack against 1-3. I can make that change
when committing if that's fine by you.

Jason
