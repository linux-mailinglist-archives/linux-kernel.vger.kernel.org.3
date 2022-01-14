Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB848E6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbiANIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:45:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43470 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiANIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:45:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6157D61682;
        Fri, 14 Jan 2022 08:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789CEC36AEA;
        Fri, 14 Jan 2022 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642149940;
        bh=ALcCanfjAhMekqhMxi4ZwisyFo7m5c0BQYGrxo+oabQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L3jf+9uMfQNFKk1ms8EH7R2MmwSlh8FGivmpE911Txmh2mhLDV5IOX/PkD4Z8ErtH
         XTuN7lVPZpamqinI+NLVj4XygjWKBNbIbf4qZ06vHQsgiaaCdwlo1IGX/LhHkBrRJv
         e5WC05bS4Mi5vTY0UzWM0695ssRGeXg8qQ/QCnzYMURky6tRNB+6Gvw7be0fq1sGBl
         5wiG21hibt069DECb8lITTx39s4NwA4ZzY1969vJctwvXOByrHp1CPAr5KYbRdEDqj
         IF76Bn7cuniTPihLuDaJ9toJEaik2p6s7PaPWxAlPFOjiPBMZl+9Fjk0xPsCR4axe3
         74iODocYzk8LA==
Date:   Fri, 14 Jan 2022 09:45:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to
 PDF
Message-ID: <20220114094535.5bb9ba94@coco.lan>
In-Reply-To: <e545803a-8f09-f0e7-4ca0-16b673ef1796@gmail.com>
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
        <e545803a-8f09-f0e7-4ca0-16b673ef1796@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 7 Jan 2022 22:45:47 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Wed, 29 Dec 2021 20:42:00 +0900, Akira Yokosawa wrote:
> > This patch set improves conversions of DOT -> PDF and SVG -> PDF
> > for PDF docs.  
> 
> Gentle ping.
> 
> Mauro, any comments?

Sorry, have been busy those days with not much time to test it,
and I'm not expecting any time to test it on the next couple of
weeks.

The main concern from my last review is that inkscape is too noisy 
(well, frankly, textlive is also too noisy). If this was solved
on a nice way, and provided that the output files on both html and
pdf are working fine with those conversions, I don't have any 
objections to this series.

Regards,
Mauro

> 
> > 
> > * DOT -> PDF conversion
> > 
> > Current scheme uses "dot -Tpdf" (of graphviz).
> > 
> > Cons:
> >   - openSUSE's dot(1) does not support -Tpdf.
> >   - Other distro's dot(1) generates PDFs with unnecessarily wide
> >     margins for inclusion into LaTeX docs.
> > 
> > Patch 1/4 changes the route to the following two steps:
> > 
> >   1. DOT -> SVG by "dot -Tsvg"
> >   2. SVG -> PDF by "rsvg-convert -f pdf" with fallback to convert(1)
> > 
> > Pros:
> >   - Improved portability across distros
> >   - Less space around graphs in final PDF documents
> > 
> > Con:
> >   - On systems without rsvg-convert, generated PDF will be of raster
> >     image.
> > 
> > Patch 2/4 avoids raster-image PDF by using "dot -Tpdf" on systems where
> > the option is available.
> > 
> > * SVG -> PDF conversion
> > 
> > Current scheme uses convert(1) (of ImageMagick)  
> 
> I was not aware of security concerns regarding ImageMagick until
> Christoph brought them up in another thread [1].
> 
> [1]: https://lore.kernel.org/linux-doc/20220104131952.GA21933@lst.de/
> 
> Now I can add another Con as bellow.
> 
> > 
> > Cons:  
>     - ImageMagick is not allowed to read/write PDF by default under
>       Debian/Ubuntu and Gentoo systems.  The policy is a band-aide
>       fix to its security issues.
> >   - Generated PDFs are of raster image.  Some of them look blurry.
> >   - Raster images tend to be large in size.
> >   - convert(1) delegates SVG decoding to rsvg-convert(1).
> >     It doesn't cover full range of Inkscape-specific SVG features
> >     and fails to convert some of SVG figures properly.  
> 
>         Thanks, Akira
> 
> > 
> > Improper conversions are observed with SVGs listed below (incomplete,
> > conversion quality depends on the version of rsvg-convert):
> >   - Documentation/userspace-api/media/v4l/selection.svg
> >   - Documentation/userspace-api/media/v4l/vbi_525.svg
> >   - Documentation/userspace-api/media/v4l/vbi_625.svg
> >   - Documentation/userspace-api/media/v4l/vbi_hsync.svg
> >   - Documentation/admin-guide/blockdev/drbd/DRBD-8.3-data-packets.svg
> >   - Documentation/admin-guide/blockdev/drbd/DRBD-data-packages.svg
> > 
> > If you have Inkscape installed as well, convert(1) delegates SVG
> > decoding to inkscape(1) rather than to rsvg-convert(1) and SVGs listed
> > above can be rendered properly.
> > 
> > So if Inkscape is required for converting those SVGs properly, why not
> > use it directly in the first place?
> > 
> > Patches 3/4 and 4/4 add code to utilize inkscape(1) for SVG -> PDF
> > conversion when it is available.  They don't modify any existing
> > requirements for kernel-doc.
> > 
> > Patch 3/4 adds the alternative route of SVG -> PDF conversion by
> > inkscape(1).
> > Patch 4/4 delegates warning messages from inkscape(1) to kernellog.verbose
> > as they are likely harmless in command-line uses.
> > 
> > Pros:
> >   - Generated PDFs are of vector graphics.
> >   - Vector graphics tends to be smaller in size and looks nicer when
> >     zoomed in.
> >   - SVGs drawn by Inkscape are fully supported.
> > 
> > On systems without Inkscape, no regression is expected by these two
> > patches.
> > 
> > Changes since v1 (as of Patch 5/3) [1]:
> > 
> > - Reorder and merge patches to reduce/eliminate regression windows of
> >   raster-image PDF and stderr redirection.
> >     v1        v2
> >     1/3       1/4
> >     4/3       2/4
> >     2/3       3/4
> >     3/3+5/3   4/4
> > 
> > - Massage kernellog.verbose/warn messages. They now show command(s)
> >   used in DOT -> PDF conversion.
> > 
> > - Pass actual exit code of inkscape(1) to kernellog.warn.
> > 
> > FWIW, diff of v1 vs. v2 follows:
> > 
> > --------------------------------------------------------------  
> [...]
> 



Thanks,
Mauro
