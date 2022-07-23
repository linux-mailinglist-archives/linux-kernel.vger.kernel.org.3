Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F3857F209
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiGWXJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 19:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbiGWXIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 19:08:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E71AF3F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 16:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CD79B80D11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE37C341CA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:08:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="key not found in DNS" (0-bit key) header.d=opensuse.org header.i=@opensuse.org header.b="bKIAvm/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensuse.org;
        s=20210105; t=1658617729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBlDwPkms0blEARPTlBdVEUCUmRBC2AdWFMDOvhbc98=;
        b=bKIAvm/nofQNnMrczwxP53GdoYf7rzYBCWQ5S7ZsrJ4V1jti+VQtrRMRtpQUayMmEmXxJJ
        IBMzLAy36iYjWt7VhyUTUnok+2CpEZXO1xkiiW9Pjp5xXPpkO7Vm8m6bmBULz/nd5Tvh48
        JmDHkidS3KsRNO3hy1Xs2sRgxOJmFrU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cf6fb87b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 23 Jul 2022 23:08:48 +0000 (UTC)
MIME-Version: 1.0
References: <YtwgTySJyky0OcgG@zx2c4.com> <Ytwg8YEJn+76h5g9@zx2c4.com>
In-Reply-To: <Ytwg8YEJn+76h5g9@zx2c4.com>
From:   =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Date:   Sat, 23 Jul 2022 15:04:36 -0400
Message-ID: <CAPBLoAdtEcpJg7sZQ7+z7HeCQzAs7Am7ep9GBFuBGxUeC3NyEw@mail.gmail.com>
Subject: Re: arc4random - are you sure we want these?
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     libc-alpha@sourceware.org, linux-crypto@vger.kernel.org,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Yann Droneaud <ydroneaud@opteya.com>, jann@thejh.net,
        Michael@phoronix.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 12:25 PM Jason A. Donenfeld via Libc-alpha
<libc-alpha@sourceware.org> wrote:

> For that reason, past discussion of having some random number generation
> in userspace libcs has geared toward doing this in the vDSO, somehow,
> where the kernel can be part and parcel of that effort.

On linux just making this interface call "something" from the VDSO that

- does not block.
- cannot ever fail or if it does indeed need to bail out it kills the
calling thread as last resort.

(if neither of those can be provided, we are back to square one)

Will be beyond awesome because it could be usable everywhere,
including the dynamic linker, malloc or whatever else
question is..is there any at least experimental patch  with a hope of
beign accepted available ?
