Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC91647211B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhLMGdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhLMGdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:33:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820A4C06173F;
        Sun, 12 Dec 2021 22:33:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CDA87CE0BAC;
        Mon, 13 Dec 2021 06:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA82BC00446;
        Mon, 13 Dec 2021 06:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639377212;
        bh=TzIKARFOBboM5lRCfMll7DQr4HiRrpKP+ecsgRxYMFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IajWd52bP8Q0ZuFL0o1FI3SA2WgwssoHg0cXzcLkIo583J7dBbaXkPdDQQqJCfKcT
         fjXs6nRs3z5bxt4OUGUFIbL8Bze/g7edsgVcYTPsmu8NE032rj62Qgp+d+qfsSdaTI
         +clweOCtQexKpEdR8+o6OpgJvXAd6WKhLlwo+rj9awMxydJu8KLdzCbdmk23MDb+Rs
         frHeVBUTPuI5KJjcfeygb77XYTTnr2MKkSvNCCQN5pBrL+YGEHVmrkzIyq0sorkhca
         dhGgoTOdtyQirrhCuVB5OD8bw9Uoj+axjTnjEV1IM85NtlkW1nWKx9ktc1QayyIwvL
         ie9C8iCf86k8A==
Date:   Mon, 13 Dec 2021 07:33:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
Message-ID: <20211213073327.11191087@coco.lan>
In-Reply-To: <8840a859-ca57-c49a-f542-0a37401ccdfc@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
        <20211212113813.058e99fc@coco.lan>
        <8840a859-ca57-c49a-f542-0a37401ccdfc@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 12 Dec 2021 20:57:23 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Sun, 12 Dec 2021 11:38:13 +0100, Mauro Carvalho Chehab wrote:
> 
> Hi Mauro,
> 
> I didn't expect such a quick response.
> Thank you so much!
> 
> > Em Sun, 12 Dec 2021 16:59:53 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> >> This patch set improves conversions of DOT -> PDF and SVG -> PDF
> >> for PDF docs.
> >>
> >> * DOT -> PDF conversion  
> > 
> > First of all, package requirement for docs generation should be auto
> > discovered by:
> > 
> > 	scripts/sphinx-pre-install  
> 
> Please note that this update does not change any requirement.

Ok.

> I think you are worried by the possible degradation of DOT rendering
> without rsvg-convert.  Please see comments below.
> 
> > 
> > and should not break the ones detected by check_distros() and that
> > supports PDF generation.
> >   
> >>
> >> Current scheme uses "dot -Tpdf" (of graphviz).
> >>
> >> Cons:
> >>   - openSUSE's dot(1) does not support -Tpdf.  
> > 
> > I'm sure I tested pdf generation in the past with openSUSE by the
> > time I wrote sphinx-pre-install script. Perhaps some change at either
> > openSUSE or at the docs makefile broke support for it.  
> 
> dot -T? on openSUSE Tumbleweed says (long line folded):
> 
> Format: "?" not recognized. Use one of: canon cmap cmapx cmapx_np dot dot
> _json eps fig gd gd2 gif gv imap imap_np ismap jpe jpeg jpg json json0 mp
>  pic plain plain-ext png pov ps ps2 svg svgz tk vml vmlz vrml wbmp xdot
>  xdot1.2 xdot1.4 xdot_json
> 
> There is no "pdf" here.

Tumbleweed is a rolling distribution. Something could have changed since
when I added support for it. Anyway, the script could check the output of
it to enable/disable pdf via dot (not saying it is worth or not).

> >   
> >>   - Other distro's dot(1) generates PDFs with unnecessarily wide
> >>     margins for inclusion into LaTeX docs.
> >>
> >> Patch 1/3 changes the route to two steps:
> >>
> >>   1. DOT -> SVG by "dot -Tsvg"
> >>   2. SVG -> PDF by "rsvg-convert -f pdf" with fallback to convert(1).  
> > 
> > rsvg-convert is not present on Fedora (nor on RHEL and CentOS), as far
> > as I'm aware.  
> 
> It is provided in the "librsvg2-tools" package, which is suggested by
> sphinx_pre_install.
> So once you have it installed on Fedora/RHEL/CentOS, this change won't
> cause any regression.
> 
> Don't you agree?

Yeah, I missed that. Thanks for reminding me about that ;-)

> >   
> >> Pros:
> >>   - Improved portability across distros
> >>   - Less space for graphs in final PDF documents
> >>
> >> Con:
> >>   - On systems without rsvg-convert, generated PDF will be of raster
> >>     image.  
> > 
> > Raster images are a very bad idea. Why don't keep use "dot -Tpdf" when
> > supported by the system? instead of falling back to raster images?  
> 
> I suppose I am able to do so.  I just thought installing rsvg-convert
> wouldn't be that difficult.
> I can add a patch in v2 if you insist that is necessary.
> 
> >   
> >> * SVG -> PDF conversion
> >>
> >> Current scheme uses convert(1) (of ImageMagick)
> >>
> >> Cons:
> >>   - Generated PDFs are of raster image.  Some of them look blurry.
> >>   - Raster image tends to be large in size.
> >>   - convert(1) delegates SVG decoding to rsvg-convert(1).
> >>     It doesn't cover full range of Inkscape specific SVG features
> >>     and fails to convert some of SVG figures properly.
> >>
> >> Failed conversions are observed with:
> >>   - Documentation/userspace-api/media/v4l/selection.svg
> >>   - Documentation/userspace-api/media/v4l/vbi_525.svg
> >>   - Documentation/userspace-api/media/v4l/vbi_625.svg  
> > 
> > What do you mean by failed? With the current way, the VBI ones
> > seem OK to me:
> > 
> > 	https://linuxtv.org/downloads/v4l-dvb-apis-new/pdf/media.pdf  
> 
> By "fail", I meant "fail to render properly.
> 
> selection.svg is rendered on page 810 in your PDF.
> I think the mask strap is lost in the figure.
> Well, selection.svg has Inkscape specific elements for the strap.
> So it is not rendered in a browser, either.

Ok, so we should fix selection.svg to address such issues. The same applies
to other images and graphs. That may include properly setting the margins.

> If you open it in Inkscape, I think you will see the difference.
> Actually speaking, I have edited selection.svg so that it can
> be rendered in a browser.  My plan is to send it as an independent
> patch once this patch set is accepted.

No matter if this is merged or not, if you find an issue at the images
at the media docs, please send them to linux-media@vger.org.

> 
> Figures 10, 11, and 12 on pages 1031 and 1032 don't look good
> either.  Do you see what I mean?
> 
> > 
> > (This is daily updated. On today's build the raw VBI ones are in
> > page 1031/1032)
> > 
> > Do you mean that your changes caused a regression there?  
> 
> Of course not!
> 
> >   
> >> If you have Inkscape installed as well, convert(1) delegates SVG
> >> decoding to inkscape(1) and the above SVGs are rendered correctly.
> >>
> >> So if Inkscape is required for converting those SVGs, why not use it
> >> directly in the first place?  
> > 
> > I remember that the main focus were to be able to generate PDF at the
> > major distros. It should be OK to use whatever tool, provided that it
> > won't cause regressions with such distros. Not that is should matter
> > much for the others, but my particular interest is that it shouldn't
> > cause regressions neither on Debian nor on Fedora, as those are the 
> > ones I use for PDF generation. Debian is used at linuxtv.org, where we
> > do automate builds for PDF, ePUB and HTML. Fedora is what I used locally,
> > in order to test and fix issues on media PDF document output.  
> 
> I have tested this change on Debian and Fedora systems as well as
> openSUSE, Arch, and other distros.
> I'd say it works flawlessly.
> 
> I'd appreciate if you could give a try on your systems.

I'll try to run some tests today.

> Thanks for your feedback.
> I am willing to improve the quality of the PDF docs further.
> 
>         Thanks, Akira
> 
> >   
> >> Patch 2/3 adds a route of SVG -> PDF conversion by inkscape(1).
> >> Patch 3/3 hides warning messages from inkscape(1) which are harmless
> >> in command-line uses.
> >>
> >> Pros:
> >>   - Generated PDFs are of vector graphics.
> >>   - Vector graphics tends to be smaller in size and keeps looking nice
> >>     while zoomed in.
> >>   - SVGs drawn by Inkscape are fully supported.
> >>
> >> On systems without Inkscape, there won't be any change in behavior.
> >>
> >>         Thanks, Akira
> >> --
> >> Akira Yokosawa (3):
> >>   docs: sphinx/kfigure.py: Use rsvg-convert(1) for DOT -> PDF conversion
> >>   docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion


> >>   docs: sphinx/kfigure.py: Redirect warnings from inkscape to /dev/null

It sounds too risky to redirect stderr to /dev/null. Yeah, here, the output
of inkscape is too crowd of warnings. Hacking it with a 
SPHINX_SHOW_INKSCAPE_WARN variable also seems a bad idea.

Not sure how this could be solved.

Thanks,
Mauro
