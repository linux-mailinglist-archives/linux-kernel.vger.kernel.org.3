Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36AB483C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiADGrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:47:18 -0500
Received: from verein.lst.de ([213.95.11.211]:48808 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233059AbiADGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:47:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4E6168AFE; Tue,  4 Jan 2022 07:47:08 +0100 (CET)
Date:   Tue, 4 Jan 2022 07:47:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: make pdfdocs fails on Debian stable
Message-ID: <20220104064708.GA15446@lst.de>
References: <20220103163050.GA3151@lst.de> <20220103175814.5b22a6a7@coco.lan> <20220103171108.GB3422@lst.de> <20220103215831.2e65bb94@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220103215831.2e65bb94@coco.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 09:58:31PM +0100, Mauro Carvalho Chehab wrote:
> Ah, the error is specific to RCU.tex then?

Yes.

> 
> You'll need to re-run xelatex with -interaction=interactive, in
> order to be able to identify what's the root cause.
> 
> You could do this by using LATEXOPTS, e. g.:
> 
> 	$ make SPHINXDIRS=RCU LATEXOPTS="-interaction=interactive" pdfdocs
> 
> With that, LaTeX will stop at the offending line from the .tex file.
> 
> On a quick test here, I'm getting these at Fedora 35:
> 
> 	(/usr/share/texlive/texmf-dist/tex/latex/l3packages/xtemplate/xtemplate.sty)
> 
> 	! LaTeX Error: File `ctexhook.sty' not found.
> 
> 	Type X to quit or <RETURN> to proceed,
> 	or enter new name. (Default extension: sty)
> 
> It seems that a recent change (probably to better address issues with 
> Chinese and Japanese translation) added an extra dependency to some
> stylesheet.
> 
> I solved it by installing this package: "texlive-ctex".

There is no texlive-ctex on Debian, but ctexhook.sty is installed as
part of texlive-extra-utils.  Here are the last lines from the
interactive run:

(/usr/share/texlive/texmf-dist/tex/latex/ctex/ctexhook.sty)
(/usr/share/texlive/texmf-dist/tex/xelatex/xecjk/xeCJK.cfg))
(/usr/share/texlive/texmf-dist/tex/latex/etoolbox/etoolbox.sty)
Writing index file RCU.idx
(./RCU.aux)
Runaway argument?
{\contentsline {chapter}{\numberline {16}A Tour Through TREE\_RCU’s\ETC.
! File ended while scanning use of \@writefile.
<inserted text> 
                \par 
l.191 \begin{document}

? 

