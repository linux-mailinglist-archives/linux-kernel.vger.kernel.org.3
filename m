Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022C04A3658
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 13:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbiA3MsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 07:48:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60180 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354798AbiA3Mrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 07:47:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 196FAB82923;
        Sun, 30 Jan 2022 12:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6ABC340E4;
        Sun, 30 Jan 2022 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643546866;
        bh=aVDc8Yu/ogmHGWUx29IlMTDDegp/e73DqnCrg8ODuZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nq98CGrIZ9nAbhUKlKnlO1se4qC21zkur0zkN9RF0QmQi7sRv3hgrCPDO3KeXkk/N
         LwBhir3pOpKJ/eYM+PMrYYsBVEgUJ715DysFda3xnH4J8wHJLxPsSvcRDVvUp+Nuek
         VdiLYIxlTlaLWEgDRGPFTxoCkk8BsMe4ql2/Ok1jVsBoIwotEswkzlZAkYtMKOiTFU
         Nk+Twtf1OSlTXocd5i6I+l6Wm6/wIxVDa/yDzA5C1yegc297stc0eESw2yjI/vpWuz
         mruHdwN6FwQX77xQckDBK4qNhwh91pAeUCwpzQHpovNMO4iHJ4R+CiMtLpoK2esNSu
         /GpbCT5mXKvWw==
Date:   Sun, 30 Jan 2022 12:54:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 29/54] drivers/iio: replace bitmap_weight() with
 bitmap_weight_{eq,gt} where appropriate
Message-ID: <20220130125408.0cca0b66@jic23-huawei>
In-Reply-To: <Ye6fsynB1/q0ZLui@smile.fi.intel.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
        <20220123183925.1052919-30-yury.norov@gmail.com>
        <Ye6fsynB1/q0ZLui@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 14:46:43 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Jan 23, 2022 at 10:39:00AM -0800, Yury Norov wrote:
> > drivers/iio calls bitmap_weight() to compare the weight of bitmap with
> > a given number. We can do it more efficiently with bitmap_weight_{eq, gt}
> > because conditional bitmap_weight may stop traversing the bitmap earlier,
> > as soon as condition is met.  
> 
> ...
> 
> >  		int i, j;
> >  
> >  		for (i = 0, j = 0;
> > -		     i < bitmap_weight(indio_dev->active_scan_mask,
> > -				       indio_dev->masklength);
> > +		     bitmap_weight_gt(indio_dev->active_scan_mask,
> > +				       indio_dev->masklength, i);
> >  		     i++, j++) {
> >  			j = find_next_bit(indio_dev->active_scan_mask,
> >  					  indio_dev->masklength, j);  
> 
> This smells like room for improvement. Have you checked this deeply?
> 

I have no idea what I was smoking that day.
It was near 10 years ago, so I'll blame my younger self ;)

Jonathan
