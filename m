Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541495ACDC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiIEIaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiIEI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:29:52 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5D4E864;
        Mon,  5 Sep 2022 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662366477;
  x=1693902477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tRFYGv84M2LaryAxLO+4jpAXwsqd1ialVQ9dqVpUd64=;
  b=CvZLYj8XOiPcjtvbgFgaVsr2sG4JxTIlPlDCniQR4i4dZz91QlG2VW/6
   Cme95nKkOkLlhGtu6zqjXE/6WQxl2CZlOwyYUrmY1OGBQlauRdV+6bOtj
   U+Tubl0eu6xR8Mm1LTlbkCzgh5M2B9OZXozkrRz4fM6cqQPBVaSEG+Kwc
   jMdcTF16H9JpVE+XtBdyTQA0oN4CoomH8ZPhraKulFHxn3M9c37RrGaLF
   4oViz2HZsFrJQkXamV54uFzuPJ7rFSEdvWSmoTjq84MnCfXS2UEDODyKv
   yC3rqY5EKsR7JuCWnGZqviiPS71I8rL1i1w8d9Zj0ErW6GagltDSUrzWg
   Q==;
Date:   Mon, 5 Sep 2022 10:27:51 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: adc: mcp320x: use callbacks for RX conversion
Message-ID: <YxWzB/UdHYW6of/r@axis.com>
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
 <20220831100506.3368103-2-vincent.whitchurch@axis.com>
 <CAHp75Vek8tLnwYWZO91HHr1_i7G_F9tErnRsq-GwfQcpR0FaTw@mail.gmail.com>
 <20220904171559.1bf77d42@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220904171559.1bf77d42@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 06:15:59PM +0200, Jonathan Cameron wrote:
> I'm not keen to push unrelated work onto someone doing good stuff
> on a driver, but in this particular case it does seem reasonable to
> tidy all this up given you are moving the code anyway.

Well, even the moving of the code is unrelated to the original goal of
adding triggered buffered support and isn't necessary for that.  The
moving of the code was only to eliminate the use of the "device_index",
which was already used in the existing code.

I'm of course happy to fix problems with the code I'm actually adding,
but it seems to me that it would really be simpler for everyone if the
trivial comments (especially the purely cosmetic ones) on the existing,
unrelated code would be fixed by the people with the opinions about how
the existing code should look like.  I don't have any special ability to
test the dozen different chips this driver supports, so having me do it
by proxy seems rather suboptimal.  I can only run it in roadtest, which
anyone can do with the following commands (against v5.19 due to the
regressions in mainline I mentioned in my other email), without special
hardware:

 git checkout v5.19
 git remote add vwax https://github.com/vwax/linux.git
 git fetch vwax 
 git archive vwax/roadtest/mcp320x tools/testing/roadtest | tar xf -
 make -C tools/testing/roadtest/ -j24 OPTS="-v -k 'mcp and not trigger'"
