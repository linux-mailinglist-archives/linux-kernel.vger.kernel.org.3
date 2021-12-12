Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884B14719A0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 11:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhLLKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 05:38:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40600 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhLLKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 05:38:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B864DB80AEB;
        Sun, 12 Dec 2021 10:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D306EC341C6;
        Sun, 12 Dec 2021 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639305498;
        bh=Am+41ubCC8rkSmzoRSTLkBwWB738N2XLeFzWhjzxHlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kFN2xbMfSsQOljYnCTYOkMgJv30ClZR1xAKyLVwy8cy6LFTYAsosuurUa8Or85zLc
         wfZ7ED1tRcaNqZLJ2eUlD+BYIi0ai4pJEmiduWtREl6e8wg3Gne9Qal02h0qCS3QuE
         WSwwKEN2DVx5JWmobRDsl4NjEtAHWZ+Jkvoxz40MJyAO3xknul6yP+EZ63RSGvNG3+
         rAE9uj4BG7NFElWxagVwsvyOig0oFxBI+KYs0foNEq0yEWyTEESc533EfA0zBSLFk+
         Nkwut4TS4PfRdEcDlB5eLj4Q/XWPNnYo1CGUKiwl0/OBEVVkZFIbCRA+JASV+SxNwx
         yBEWdZkmoOl7Q==
Date:   Sun, 12 Dec 2021 11:38:13 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
Message-ID: <20211212113813.058e99fc@coco.lan>
In-Reply-To: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 12 Dec 2021 16:59:53 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> This patch set improves conversions of DOT -> PDF and SVG -> PDF
> for PDF docs.
> 
> * DOT -> PDF conversion

First of all, package requirement for docs generation should be auto
discovered by:

	scripts/sphinx-pre-install

and should not break the ones detected by check_distros() and that
supports PDF generation.

> 
> Current scheme uses "dot -Tpdf" (of graphviz).
> 
> Cons:
>   - openSUSE's dot(1) does not support -Tpdf.

I'm sure I tested pdf generation in the past with openSUSE by the
time I wrote sphinx-pre-install script. Perhaps some change at either
openSUSE or at the docs makefile broke support for it.

>   - Other distro's dot(1) generates PDFs with unnecessarily wide
>     margins for inclusion into LaTeX docs.
> 
> Patch 1/3 changes the route to two steps:
> 
>   1. DOT -> SVG by "dot -Tsvg"
>   2. SVG -> PDF by "rsvg-convert -f pdf" with fallback to convert(1).

rsvg-convert is not present on Fedora (nor on RHEL and CentOS), as far
as I'm aware.

> Pros:
>   - Improved portability across distros
>   - Less space for graphs in final PDF documents
> 
> Con:
>   - On systems without rsvg-convert, generated PDF will be of raster
>     image.

Raster images are a very bad idea. Why don't keep use "dot -Tpdf" when
supported by the system? instead of falling back to raster images?

> * SVG -> PDF conversion
> 
> Current scheme uses convert(1) (of ImageMagick)
> 
> Cons:
>   - Generated PDFs are of raster image.  Some of them look blurry.
>   - Raster image tends to be large in size.
>   - convert(1) delegates SVG decoding to rsvg-convert(1).
>     It doesn't cover full range of Inkscape specific SVG features
>     and fails to convert some of SVG figures properly.
> 
> Failed conversions are observed with:
>   - Documentation/userspace-api/media/v4l/selection.svg
>   - Documentation/userspace-api/media/v4l/vbi_525.svg
>   - Documentation/userspace-api/media/v4l/vbi_625.svg

What do you mean by failed? With the current way, the VBI ones
seem OK to me:

	https://linuxtv.org/downloads/v4l-dvb-apis-new/pdf/media.pdf

(This is daily updated. On today's build the raw VBI ones are in
page 1031/1032)

Do you mean that your changes caused a regression there?

> If you have Inkscape installed as well, convert(1) delegates SVG
> decoding to inkscape(1) and the above SVGs are rendered correctly.
> 
> So if Inkscape is required for converting those SVGs, why not use it
> directly in the first place?

I remember that the main focus were to be able to generate PDF at the
major distros. It should be OK to use whatever tool, provided that it
won't cause regressions with such distros. Not that is should matter
much for the others, but my particular interest is that it shouldn't
cause regressions neither on Debian nor on Fedora, as those are the 
ones I use for PDF generation. Debian is used at linuxtv.org, where we
do automate builds for PDF, ePUB and HTML. Fedora is what I used locally,
in order to test and fix issues on media PDF document output.

> Patch 2/3 adds a route of SVG -> PDF conversion by inkscape(1).
> Patch 3/3 hides warning messages from inkscape(1) which are harmless
> in command-line uses.
> 
> Pros:
>   - Generated PDFs are of vector graphics.
>   - Vector graphics tends to be smaller in size and keeps looking nice
>     while zoomed in.
>   - SVGs drawn by Inkscape are fully supported.
> 
> On systems without Inkscape, there won't be any change in behavior.
> 
>         Thanks, Akira
> --
> Akira Yokosawa (3):
>   docs: sphinx/kfigure.py: Use rsvg-convert(1) for DOT -> PDF conversion
>   docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion
>   docs: sphinx/kfigure.py: Redirect warnings from inkscape to /dev/null
> 
>  Documentation/sphinx/kfigure.py | 109 ++++++++++++++++++++++++++++----
>  1 file changed, 97 insertions(+), 12 deletions(-)
> 
> 
> base-commit: a32fa6b2e8b4e0b8c03f5218afa0649e188239c5



Thanks,
Mauro
