Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1C535B11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348654AbiE0IGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349354AbiE0IFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:05:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EBFFF583;
        Fri, 27 May 2022 01:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A72AEB8222A;
        Fri, 27 May 2022 08:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AD4C34100;
        Fri, 27 May 2022 08:05:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JFi+EfgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653638734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egFvemp/OO1mIsOgG16kHg3dT2DLh+FIRIYNI2ypg1o=;
        b=JFi+EfgRmro9BNBYct10wu2NqaGsDCM1eL8d2JwRDvzg5xWPo8x7Rh24VzOSx2NFzckLJe
        0aAptJtLns/CyhwzsWBYEi4EgtOOi8peLurn1ys0P4JQkEoLa92s5jC4nBVVr9Q5BqCwtJ
        YxXNKSTKkW/vR1DhfzYugZIPo237BXI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 85d4a319 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 27 May 2022 08:05:33 +0000 (UTC)
Date:   Fri, 27 May 2022 10:05:22 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, gaochao <gaochao49@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH crypto] crypto: blake2s - remove shash module
Message-ID: <YpCGQvpirQWaAiRF@zx2c4.com>
References: <20220526092026.207936-1-Jason@zx2c4.com>
 <Yo/Afs61tFwnaOV8@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo/Afs61tFwnaOV8@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eric,

On Thu, May 26, 2022 at 11:01:34AM -0700, Eric Biggers wrote:
> On Thu, May 26, 2022 at 11:20:26AM +0200, Jason A. Donenfeld wrote:
> > BLAKE2s has no use as an shash and no use is likely to ever come up.
> 
> I'm not sure about that.  Anyone who is already using shash (for supporting

I'll tweak the language of the commit message.

> More importantly, this is removing quite a bit of test coverage because the
> extra self-tests in crypto/testmgr.c are more comprehensive than what
> lib/crypto/blake2s-selftest.c does.  For example they test the case where the
> input data is misaligned, as well as the case where the code is executed in a
> context where SIMD instructions are unavailable.
> 
> In order for this to be acceptable, I think you'd need to update
> blake2s-selftest.c to be more comprehensive.

There actually already is some alignment tests. But I'll add some more
and also compare implementations. v2 incoming.

Jason
