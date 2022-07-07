Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632056AC97
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiGGUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiGGUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4F21D32D;
        Thu,  7 Jul 2022 13:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E02662418;
        Thu,  7 Jul 2022 20:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BB2C3411E;
        Thu,  7 Jul 2022 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657224964;
        bh=ZFMH5B/Kr49IH99WLl66v3d7NBi0EDRNt8+9wu8lIB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XAG/5TMp8LDglt139jKEchKVWxEpGe2utgAvIcGsBK/smlcBlpQaBaMlVm21Q38wt
         RZPA+aNRJipERy7WHiK7IK+4gXnQr+rkfXXx9hvVPzWBwx/xHoLoNhqEVVo+uAj2mh
         voVFX0kdKiwjbchQRlOIMlToO1C+eDKFRw+/G6W1dpctheaq4WffcTDyPlWVjpvqae
         kqxMKEPZc/gBLfli3oGHkdkHqvdIzzocMlPgTBDs1FH96krZHs8yElrHOz5FoPkdbq
         cAqQtSpDYYB/wkvW0JHeruxF2QRd4v5SIOORZuw6MVwHvSph3g+/jMgC/aSsaY2fFv
         ca0oGbuioWGbw==
Date:   Thu, 7 Jul 2022 21:15:58 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, ksummit-discuss@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v2 0/5] Address some issues with sphinx detection
Message-ID: <20220707211558.438a27d4@sal.lan>
In-Reply-To: <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
        <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 5 Jul 2022 13:15:57 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro,
> 
> On Sat,  2 Jul 2022 11:11:24 +0100, Mauro Carvalho Chehab  wrote:
> > Checking if Sphinx is available and read to run is tricky, and may involve
> > installing several packages for the document build to happen.
> > 
> > There are two options to install Sphinx:
> > 
> > 	- via distro-provided packages;
> > 	- via pip, using virtualenv/venv.
> > 
> > Some recent discussions showed a couple of misleading instructions.
> > 
> > This series improves the Sphinx detection by:
> > 
> > - Fixing the logich with checks if a past venv is working and recommend
> >   just enabling it instead of installing a new venv;
> > - Detect if sphinx-build stopped working on a venv. This may happen during
> >   distribution updates;
> > - Move the PDF minimal version to be later, in order for it to be printed only
> >   after finishing the Sphinx version check;
> > 
> > Additionally, as now the Sphinx provided on almost all modern distros are
> > above the minimal required version, place instructions about how to install
> > Sphinx from the distro-provided packages after placing the instructions for
> > installing it via venv.
> > 
> > This will hopefully help to have more developers checking documentation
> > builds with
> > 
> > 	make htmldocs  
> So this is a meta-level feedback considering the most likely uses
> of sphinx-pre-install.
> 
> I think first-time users of sphinx-pre-install are more likely
> interested in getting ready for running "make html".  They won't
> bother with "make pdfdocs". 

True, but, as you're pointing below, math expressions require LaTeX.

The idea of using --no-pdf is to setup an environment without LaTeX,
meaning that math tags would only be partially parsed: basically, the
output would be html with LaTeX-like math expressions (at least last
time I tried).

> They won't likely be interested in virtualenv, either.

Yes and no. The big issue with using distro packages is that it will
produce 11 false-positive warnings due to duplicated C symbols. This
will only be (hopefully) fixed on a later Sphinx 5.x (or 6.0). So,
it would take more than 6 months to get rid of those.

Using 2.4.4, after the fixes I sent, plus the 3 fixes from IIO tree
(yet to be merged on -next), there will be just 4 warnings.

So, IMO, for me, is still preferred to use 2.4.4 via venv.

> So I think it would be reasonable to change the default behavior
> of sphinx-pre-install.

With this series, both venv and non-venv settings will be shown by
default, allowing the developer decide what he prefers.

Still, I'm not 100% sure if this is the best thing to do. 

One alternative would be to run the script on an even more silent mode
when called via makefile, in a way that it would, instead it will keep:

- not display anything if sphinx-build works;
- display enable/disable commands if venv is detected;

But, instead of showing install options, it would instead, print a message
like:

	Can't build the documentation. Please run:

	./scripts/sphinx-pre-install <options)

	Where options are:
	  --no-virtualenv	- Recommend installing Sphinx instead of using a virtualenv
	  --no-pdf		- don't check for dependencies required to build PDF docs
	  ...

Another alternative would be to use --no-pdf for make htmldocs/epubdocs
target, and a "--pdf" for make pdfdocs.

> I mean the reasonable behavior without any option would be that of
> when both --no-pdf and --no-virtualenv are given to the current
> version.
> 
> There are a few issues on --no-pdf.
> 
> It says imagemagick and gcc are necessary, but they are redundant
> in "make html", as far as I see.

Well, gcc is not really necessary, but anyone using the Kernel tree
very likely needs it. So, it doesn't hurt checking for it.

With regards to imagemagick, I'm not sure if, after your patches changing
the way to build image, it is still needed. We need to review it.

Changing the dependency chain is a lot of work, as we need to retest
everything on all supported platforms, using minimal install. Here, I'm
using lxc download, as it usually gets something close to the minimal
distro install.

> Furthermore, it doesn't check dvipng and latex, which are used
> for generating math equation images in HTML.

Not checking for LaTeX is per design. It makes the install a lot havier
than what's actually needed. dvipng is a new dependency after the
changes on svg and dot conversions. Yeah, we need to test it on all
distros and properly add it where needed.

> Fedora, RHEL/CentOS, and openSUSE Leap provide helpful packages
> for installing math expression support.
> 
>     Fedora 36               python3-sphinx-latex (python3-sphinx depends on this)
>     RHEL 9/CentOS stream 9  ditto
>     openSUSE Leap 15.4      python3-Sphinx_4_2_0-latex
>                                 (python3-Sphinx_4_2_0 depends on this) or
>                             python3-Sphinx-latex
>                                 (python3-Sphinx depends on this, version: 2.3.1)

yes, but this will install LaTeX. We don't want this for the minimal htmldocs
build type, as math is used only on a handful set of documents, and most
developers can live without that.

> Other distros, whose texlive packages are coarse grained, don't provide
> such helper packages.
> 
> Also, as mentioned previously, RHEL 9/CentOS stream9's texlive-xecjk 
> doesn't work at the moment due to the lack of its dependency (texlive-ctex).

LTS distros like RHEL and SUSE are usually a lot more conservative and may
not have everything. The building system needs to cope with that.

> I opened a bug ticket at RedHat bugzilla:
>    https://bugzilla.redhat.com/show_bug.cgi?id=2086254
> 
> Unfortunately, I've heard no response yet.
> If you know some means to boost its priority, please provide a comment
> or two to the ticket.
>
> Until the issue can be resolved, "make pdfdocs" is limited to non-CJK
> build on CentOS stream 9, RHEL 9 and its clones if you must stick to
> distro packages. 

Even if they add now, RHEL 9.0 won't have it. So, the script would need
to check if the distro supports it.

> For non-CJK build to work, you must not have
> google-noto-sans-cjk-ttc-fonts.

That doesn't sound right. We should probably fix conf.py to do the right
thing. I mean, if this package is installed but texlive-xecjk, it should
disable CJK fonts.

> openSUSE Leap does not support full CJK build of "make pdfdocs", either.
> Its Noto font packaging is peculiar and a similar named package of
> noto-sans-cjk-fonts installs a set of language-specific fonts, each
> of which doesn't qualify as a CJK font.
> 
> Seeing these problems of LTS distros, I'd suggest sphinx-pre-install
> --pdf would check packages for non-CJK builds.

Makes sense.

> Another option of --cjk would show you additional packages for full CJK build.

Also makes sense. I don't think they're mutually exclusive.

> TL;DR, my suggestion of options and defaults to sphinx-pre-install:
> 
>     --no-pdf (default): for htmldocs only
>     --no-virtualenv (default): distro Sphinx package
>          (mention --virtualenv if distro Sphinx package is too young)
>     --virtualenv: Sphinx by venv/virtualenv
>     --pdf: for pdfdocs
>         --no-cjk (default): don't bother with CJK pdfdocs
>         --cjk: for CJK pdfdocs
>                (print warning if user's distro doesn't support CJK)

The options make sense. Still I would discuss more about what would be
the best default:

	- Suggest both venv and no-venv;
	- Ask the user to run the script;
	- have different behaviors when called with make pdfdocs
	  or make htmldocs / epubdocs.

Regards,
Mauro
