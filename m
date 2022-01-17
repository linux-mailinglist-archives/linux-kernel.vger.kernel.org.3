Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF98C490FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbiAQRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:35:07 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47104 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239439AbiAQRfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:35:01 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D8379200230;
        Mon, 17 Jan 2022 17:34:58 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 0EC1280545; Mon, 17 Jan 2022 18:28:52 +0100 (CET)
Date:   Mon, 17 Jan 2022 18:28:52 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 4/7] random: remove unused reserved argument
Message-ID: <YeWnVHwcBaS7OZak@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220113154413.29513-5-Jason@zx2c4.com>
 <YeQcpzxKWLuJ9Kcz@owl.dominikbrodowski.net>
 <YeRGSPTpJlSTJdgO@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YeRGSPTpJlSTJdgO@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Sun, Jan 16, 2022 at 05:22:32PM +0100 schrieb Jason A. Donenfeld:
> On Sun, Jan 16, 2022 at 2:45 PM Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > > @@ -1342,7 +1341,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
> > >       /* never pull more than available */
> > >       have_bytes = entropy_count >> (ENTROPY_SHIFT + 3);
> > > 
> > > -     if ((have_bytes -= reserved) < 0)
> > > +     if (have_bytes < 0)
> > >               have_bytes = 0;
> > >       ibytes = min_t(size_t, ibytes, have_bytes);
> >
> > Hmm. We already WARN_ON(entropy_count < 0) a few lines below. Maybe move
> > that assertion before the assignement of have_bytes? Then, have_bytes can
> > never be lower than zero, and the code becomes even simpler. What do you
> > think?
> 
> Can you send a separate patch for this that we can apply on top? It
> seems reasonable anyhow. Something like:

As you've written that patch yourself now, just take that, and feel free to
add my Reviewed-by tag.

Thanks,
	Dominik
