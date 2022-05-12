Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81EB524451
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347446AbiELEgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347030AbiELEf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:35:59 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D35765FB;
        Wed, 11 May 2022 21:35:58 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1np0YJ-00CnG2-KM; Thu, 12 May 2022 14:35:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 May 2022 12:35:51 +0800
Date:   Thu, 12 May 2022 12:35:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tytso@mit.edu, linux@dominikbrodowski.net, rostedt@goodmis.org,
        ardb@kernel.org
Subject: Re: [PATCH RFC v1] random: use static branch for crng_ready()
Message-ID: <YnyOp+8v6inyB0P/@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynug580srdedsiY9@zx2c4.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Tue, May 03, 2022 at 03:40:52PM +0200, Jason A. Donenfeld wrote:
>> +static bool crng_ready_slowpath(void)
>> +{
>> +     if (crng_init <= 1)
>> +             return false;
>> +     if (in_atomic() || irqs_disabled() || cmpxchg(&crng_init, 2, 3) != 2)
>> +             return true;
> 
> Nobody chimed in here, but for posterity I thought I should point out
> that this approach actually won't work, since in_atomic() doesn't work
> with CONFIG_PREEMPT_COUNT=n kernels.
> 
> So back to the drawing board in trying to figure out the best way to do
> this...

Well the standard solution to code paths that require sleeping is
to use a work queue.  So any reason why you can't just schedule
a work to do the static_branch_enable?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
