Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900EB518D86
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiECUAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiECUAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:00:04 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B622B36E25
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:56:30 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 37783200286;
        Tue,  3 May 2022 19:56:27 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id C0BB380595; Tue,  3 May 2022 21:56:18 +0200 (CEST)
Date:   Tue, 3 May 2022 21:56:18 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: mix hwgenerator randomness before sleeping
Message-ID: <YnGI4lZVJ/FZEkcn@owl.dominikbrodowski.net>
References: <20220503195141.683217-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503195141.683217-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, May 03, 2022 at 09:51:41PM +0200 schrieb Jason A. Donenfeld:
> The add_hwgenerator_randomness() function is called in a loop from a
> kthread by the hwgenerator core. It's supposed to sleep when there's
> nothing to do, and wake up periodically for more entropy. Right now it
> receives entropy, sleeps, and then mixes it in. This commit reverses the
> order, so that it always mixes in entropy sooner and sleeps after. This
> way the entropy is more fresh.

... however, the hwgenerator may take quite some time to accumulate entropy
after wakeup. So now we might have a delay between a wakeup ("we need more
entropy!") and that entropy becoming available. Beforehand, the thread only 
went to sleep when there is no current need for "fresh" entropy.

Thanks,
	Dominik
