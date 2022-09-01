Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02E5A8D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiIAFLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiIAFK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:10:59 -0400
X-Greylist: delayed 343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 22:10:57 PDT
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F810853F;
        Wed, 31 Aug 2022 22:10:57 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 668752000AD;
        Thu,  1 Sep 2022 05:05:13 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id CD4E08084B; Thu,  1 Sep 2022 07:05:01 +0200 (CEST)
Date:   Thu, 1 Sep 2022 07:05:01 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Levin <levinale@google.com>,
        Rajat Jain <rajatja@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 1/2] random: make add_hwgenerator_randomness() more
 flexible
Message-ID: <YxA9fTXqVFrHvyTj@owl.dominikbrodowski.net>
References: <20220831172024.1613208-1-svenva@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831172024.1613208-1-svenva@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Wed, Aug 31, 2022 at 05:20:23PM +0000 schrieb Sven van Ashbrook:
> add_hwgenerator_randomness() currently blocks until more entropy
> is needed. But, the required delay function will depend on the
> the caller: e.g. freezable kthreads have their own freezable_XXX()
> APIs; and delayed_work might prefer to use mod_delayed_work().
> 
> To accommodate these requirements, remove the blocking wait, and
> let the function return the delay needed until more entropy is needed.

AFAICS, there's only one caller in the kernel, and its specific requirements
are currently met by the callee. So the rationale for this patch is wanting,
yet you may wish to justify this patch more explicitly as a preparation for
the second patch.

Thanks,
	Dominik
