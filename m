Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9485231F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbiEKLlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241269AbiEKLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:41:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A896221F;
        Wed, 11 May 2022 04:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 821D3B82215;
        Wed, 11 May 2022 11:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649A8C340F2;
        Wed, 11 May 2022 11:41:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LoYM1Glt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652269289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0eZFVr0R7tr8pw1d+4up9u7mZ3WWk1zMsEZIi4198wM=;
        b=LoYM1GltXCzbdsQ/25CVajZQVoSqUAN8UhoOsZiWg0Kq6Bi1/kBG7KibB4PZCjJRpmx3fW
        UgdAsOkclk+7raS2ozM4dbiF98xnRpB3RJ9oeo30PrnSCa3xmI3mZ24OWL+A1Oda83vcBi
        wT4anzX9ubyzD6Vdfvg0q2W6EF9o/is=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 28e7ee18 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 11 May 2022 11:41:29 +0000 (UTC)
Date:   Wed, 11 May 2022 13:41:27 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH RFC v1] random: use static branch for crng_ready()
Message-ID: <Ynug580srdedsiY9@zx2c4.com>
References: <20220503134052.646325-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220503134052.646325-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:40:52PM +0200, Jason A. Donenfeld wrote:
> +static bool crng_ready_slowpath(void)
> +{
> +	if (crng_init <= 1)
> +		return false;
> +	if (in_atomic() || irqs_disabled() || cmpxchg(&crng_init, 2, 3) != 2)
> +		return true;

Nobody chimed in here, but for posterity I thought I should point out
that this approach actually won't work, since in_atomic() doesn't work
with CONFIG_PREEMPT_COUNT=n kernels.

So back to the drawing board in trying to figure out the best way to do
this...
 
Jason
