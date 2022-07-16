Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631205770BE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiGPS3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPS3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249117582
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD63611D6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 18:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF38C34114;
        Sat, 16 Jul 2022 18:29:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SWNlm1B0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657996153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kozS06OyS0xBHMQiwrn8PPEbEmlJYFwVaVSdQVH4P/Q=;
        b=SWNlm1B0KYnwKsdoqsVERfUtBJwBgzSA7Q8zagEE7G3tkxFfL9Ew3fHSnDosziwVbtDd3o
        L8UPbF3sg86CPwBsbeSxQE+RxzNGd0owwYTpbUGAIFDiZhw/u31zpDP28b9+sVT1OJszIf
        3PnRH3k1e427PXlmwoniHf8wj9CXFlc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8a3e529f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 16 Jul 2022 18:29:12 +0000 (UTC)
Date:   Sat, 16 Jul 2022 20:29:12 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: Use try_cmpxchg in _credit_init_bits
Message-ID: <YtMDeHO93SQh0ufA@zx2c4.com>
References: <20220714182822.25142-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220714182822.25142-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uros,

On Thu, Jul 14, 2022 at 08:28:22PM +0200, Uros Bizjak wrote:
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> _credit_init_bits. x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Also, try_cmpxchg implicitly assigns old *ptr value to "old"
> when cmpxchg fails, enabling further code simplifications.
> 
> No functional change intended.

Applied as:
  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=6a66e096619e3a737297eb2f9f535a287af43a95

Thanks for the patch.

Jason
