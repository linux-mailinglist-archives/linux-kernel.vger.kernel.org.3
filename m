Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92C48B11E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349611AbiAKPmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349558AbiAKPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:42:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2EFC061756;
        Tue, 11 Jan 2022 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PiD83U+1isWh2ax7X4ez/W8TF/mH0BpegLiMXOO1s4I=; b=lY0TwRytqeXGZ5eVocRlXe8XfZ
        KujVjbP95Qook0wO4qMFjKPG/Yv7qdG9dRUhpnmVHLRUg81aGHP1sESTHourfI1DF82wnxPvaKpbp
        hKczBgGtD6wuoYseOVpOAtO/whLK//4DAjzl4Z8Pj3iToFT86Wz1ZJ11r9Xb9h53SUAqIdF/pPclG
        bhvxZiX05/XWHgApaP/rc1XgL7p+jnD1eC7Wpt31x44J52OkQ5+MoyRx75QlwhAFcXDE7RP0kcjT7
        22DUwoGvIsBaMoEzZOu0unZsuWWbAqULHsoYSJOK7az2tAnoPqAA4Cj0KhHAQsS04kN7z853X3jRu
        ClNQB6jg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7JHj-00GlVI-0b; Tue, 11 Jan 2022 15:42:07 +0000
Date:   Tue, 11 Jan 2022 07:42:06 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Martin Wilck <martin.wilck@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <Yd2lTm+lILv6KbRm@bombadil.infradead.org>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPsqR5ZyiFwJul3@bombadil.infradead.org>
 <YbP6Q9J++OVKqPfn@google.com>
 <YcC0zpFV8ppOCtZw@bombadil.infradead.org>
 <YcFHZVHbIG3ujDlC@google.com>
 <YcJOUvQJJGSHmlCE@bombadil.infradead.org>
 <YdJmRzDwruE5jt8W@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdJmRzDwruE5jt8W@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 06:58:15PM -0800, Dmitry Torokhov wrote:
> OK, so I finally got around to doing it and the differences are pretty
> much noise, as I expected:
> 
> 5.16.0-rc7:         Startup finished in 5.022s (firmware) + 6.106s (loader) + 1.370s (kernel) + 5.685s (initrd) + 10.842s (userspace) = 29.026s
> 5.16.0-rc7-patched: Startup finished in 4.958s (firmware) + 6.701s (loader) + 1.382s (kernel) + 5.278s (initrd) + 10.822s (userspace) = 29.145s
> 5.16.0-rc7-patched: Startup finished in 4.953s (firmware) + 5.912s (loader) + 1.385s (kernel) + 5.327s (initrd) + 10.457s (userspace) = 28.036s
> 
> Also see attached.

If kmod didn't do the decompression I suspect things might be slightly
different, but I agree that given the different with kernel compression
now being done, removing userespace compression might just be noise as
well.

> > > We still reading and uncompressing
> > > file in kmod (to make sure the format is valid)
> > 
> > I don't understand, that seems wasteful.
> 
> This way we can make sure we are not feeding kernel garbage and abort
> early. Yes, we could just check signature and hope that the data is good
> (and if it is not the kernel will reject it) but this is not a hot path
> at all and amount of data we decompress is relatively small, so I do not
> think trying to optimize this makes much sense (as shown by the numbers
> above).

Sure. And if an LSM is used, one would assume the LSM does its own finit
module checks.

> > > and we can uncompress
> > > using large buffers (we are not concerned with using unswappable kernel
> > > memory).
> > > 
> > > Maybe in the future when we have streaming and accelerated in-kernel
> > > decompression API we could optimize for that in kmod and see some
> > > savings on very large modules.
> > 
> > That would be very nice.
> 
> Again, practical benefit of doing this is pretty much close to 0 in this
> particular case.

Based on what is observed so far, I agree.

  Luis
