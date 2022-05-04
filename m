Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C49751976F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbiEDGiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiEDGiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:38:20 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB89726D5;
        Tue,  3 May 2022 23:34:45 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3988B2013EB;
        Wed,  4 May 2022 06:34:43 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 70D46806B0; Wed,  4 May 2022 07:36:53 +0200 (CEST)
Date:   Wed, 4 May 2022 07:36:53 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: mix hwgenerator randomness before sleeping
Message-ID: <YnIQ9RJpP/3j5aWF@owl.dominikbrodowski.net>
References: <20220503195141.683217-1-Jason@zx2c4.com>
 <YnGI4lZVJ/FZEkcn@owl.dominikbrodowski.net>
 <CAHmME9o1zhtq=bMetwEx7YEzoW79z36BQ=vTWEv4M_ocChm5eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9o1zhtq=bMetwEx7YEzoW79z36BQ=vTWEv4M_ocChm5eA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Am Wed, May 04, 2022 at 02:45:46AM +0200 schrieb Jason A. Donenfeld:
> On Tue, May 3, 2022 at 9:56 PM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > Am Tue, May 03, 2022 at 09:51:41PM +0200 schrieb Jason A. Donenfeld:
> > > The add_hwgenerator_randomness() function is called in a loop from a
> > > kthread by the hwgenerator core. It's supposed to sleep when there's
> > > nothing to do, and wake up periodically for more entropy. Right now it
> > > receives entropy, sleeps, and then mixes it in. This commit reverses the
> > > order, so that it always mixes in entropy sooner and sleeps after. This
> > > way the entropy is more fresh.
> >
> > ... however, the hwgenerator may take quite some time to accumulate entropy
> > after wakeup. So now we might have a delay between a wakeup ("we need more
> > entropy!") and that entropy becoming available. Beforehand, the thread only
> > went to sleep when there is no current need for "fresh" entropy.
> 
> Huh, interesting consideration. I didn't think about that. You wrote,
> "hwgenerator may take quite some time to accumulate entropy" -- any
> idea how long in the worst case? A second? A minute?

For TPM or virtio-rng, this shouldn't take long. But, for example, the
Kconfig entry for HW_RANDOM_TIMERIOMEM states that

	  This driver provides kernel-side support for a generic Random
	  Number Generator used by reading a 'dumb' iomem address that
	  is to be read no faster than, for example, once a second;
	  the default FPGA bitstream on the TS-7800 has such functionality.

Then, optee-rng.c contains a value "data_rate" in random bytes per second,
and may sleep for a considerable time:

	msleep((1000 * (max - read)) / pvt_data->data_rate);

Thanks,
	Dominik
