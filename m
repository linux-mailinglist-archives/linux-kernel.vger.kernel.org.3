Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ABB483820
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 21:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiACU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 15:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACU6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:58:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E02C061761;
        Mon,  3 Jan 2022 12:58:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 530B7B810AD;
        Mon,  3 Jan 2022 20:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2E3C36AE9;
        Mon,  3 Jan 2022 20:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641243514;
        bh=Oi2lazAlGtBEN+SacQrdXjI+cepKxcMn/RM+uCr/A+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R88BGgJV4fIZVu/4U+HzuRMu7VpdLNmck25pqqUONCQyalbdrWib82X6UQLyQtINl
         3xqyglE3tEdrN7URVYUoBlSFLq0qZ1qUSk7RFl/K5M67EulzEjqwvaO4H6zwY0+jvP
         JmvNRy/BAW1pTo53rjcSszjmrrEgumNtNGk/VydAuosiAFMD3XgbZuHjfGhYJZRJjQ
         GqrjeDM3bqq9Z1VxGImUhTnXU/ILMFntSJAlDvSEiPSlWcJgFXB1ubJSPxaNhFBfzq
         +MHwJiwc/wYghXYjEvNX8SZ0N4LvLn4zcc0mHirsRacAThrl1dYJeAdX2aS9S/iMYi
         ivyu+TF9VQqog==
Date:   Mon, 3 Jan 2022 21:58:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: make pdfdocs fails on Debian stable
Message-ID: <20220103215831.2e65bb94@coco.lan>
In-Reply-To: <20220103171108.GB3422@lst.de>
References: <20220103163050.GA3151@lst.de>
        <20220103175814.5b22a6a7@coco.lan>
        <20220103171108.GB3422@lst.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 3 Jan 2022 18:11:08 +0100
Christoph Hellwig <hch@lst.de> escreveu:

> On Mon, Jan 03, 2022 at 05:58:14PM +0100, Mauro Carvalho Chehab wrote:
> > Weird... when you do a make, it should have checked for all
> > dependencies, when it internally runs:
> > 
> > 	./scripts/sphinx-pre-install   
> 
> Detected OS: Debian GNU/Linux 11 (bullseye).
> Sphinx version: 3.4.3
> 
> 
> All optional dependencies are met.
> Needed package dependencies are met.
> 
> > Basically, you need the xelatex package for it to work, as PDF
> > output is via LaTeX. This is not a mandatory requirement, though,
> > as most people are only interested on html output, and LaTeX
> > dependencies require to install lots of stuff. it should provide you
> > a list of packages required for PDF, with a suggestion of using
> > apt-get to install it.
> > 
> > In this specific case, I guess the package name is 'texlive-xetex'.  
> 
> texlive-xetex is installed and seems to work find on various other
> documents produced earlier by make pdfdocs

Ah, the error is specific to RCU.tex then?

You'll need to re-run xelatex with -interaction=interactive, in
order to be able to identify what's the root cause.

You could do this by using LATEXOPTS, e. g.:

	$ make SPHINXDIRS=RCU LATEXOPTS="-interaction=interactive" pdfdocs

With that, LaTeX will stop at the offending line from the .tex file.

On a quick test here, I'm getting these at Fedora 35:

	(/usr/share/texlive/texmf-dist/tex/latex/l3packages/xtemplate/xtemplate.sty)

	! LaTeX Error: File `ctexhook.sty' not found.

	Type X to quit or <RETURN> to proceed,
	or enter new name. (Default extension: sty)

It seems that a recent change (probably to better address issues with 
Chinese and Japanese translation) added an extra dependency to some
stylesheet.

I solved it by installing this package: "texlive-ctex".

The enclosed patch should fix the script for it to report such need.

Thanks,
Mauro

[PATCH] scripts: sphinx-pre-install: add required ctex dependency

After a change meant to fix support for oriental characters
(Chinese, Japanese, Korean), ctex stylesheet is now a requirement
for PDF output.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 288e86a9d1e5..46aaab414098 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -78,6 +78,7 @@ my %texlive = (
 	'ucs.sty'            => 'texlive-ucs',
 	'upquote.sty'        => 'texlive-upquote',
 	'wrapfig.sty'        => 'texlive-wrapfig',
+	'ctexhook.sty'       => 'texlive-ctex',
 );
 
 #

