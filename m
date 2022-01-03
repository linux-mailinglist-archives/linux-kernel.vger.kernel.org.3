Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6253E48353A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiACQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiACQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:58:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC640C061761;
        Mon,  3 Jan 2022 08:58:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4D20B80ED3;
        Mon,  3 Jan 2022 16:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5813FC36AEB;
        Mon,  3 Jan 2022 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641229098;
        bh=elWwxjQsRl02e3ThNY2iZ0/dAPZeSvK75N2M724ivlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dNMXX+m5VAMO4H9Tth4rABQqEQ/FgpcUNDG3FCSKbnQJ9WLv4Hce9dQoVKT3oVRzk
         NBxDpgE8xztv5FsBhvd74xOLhwvOQc0zUBauxuH11+huFMgZLZ1XT+efiELpUYhCdS
         mT0+x5XVPBwBVQj+vGFGBNlLo7irhT7FFkHaN8anuyqUixBfD8KyHeEOFxhk04od25
         7JaVidWHNFW2tPdDrQM/B2NSQiKE+7OlhX3G2Y22ELTs6+v4s3Jdb+jb6kAzEmI2rE
         sPzJrG6vtzDffBAdeylI/jMfRQgd7p1ZhpXH8Rg3RmM+v7Gd5nNn5CJkkf7jCT+Hmu
         0iGldLmGd6hsw==
Date:   Mon, 3 Jan 2022 17:58:14 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: make pdfdocs fails on Debian stable
Message-ID: <20220103175814.5b22a6a7@coco.lan>
In-Reply-To: <20220103163050.GA3151@lst.de>
References: <20220103163050.GA3151@lst.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 3 Jan 2022 17:30:50 +0100
Christoph Hellwig <hch@lst.de> escreveu:

> Hi Jon and Mauro,
> 
> when trying to do a make pdfdocs on my Debian stable system I can't
> get it to complete.  The output below is from linux-next, but mainline
> is the same.
> 
> ------------
> Running 'xelatex --no-pdf -interaction=batchmode -no-pdf -recorder  "RCU.tex"'
> ------------
> This is XeTeX, Version 3.14159265-2.6-0.999992 (TeX Live 2020/Debian) (preloaded format=xelatex)
> restricted \write18 enabled.
>  entering extended mode
> Latexmk: Examining 'RCU.log'
> === TeX engine is 'XeTeX'
> Latexmk: Index file 'RCU.idx' was written
> Latexmk: References changed.
> Latexmk: Log file says output to 'RCU.xdv'
> Latexmk: Errors, so I did not complete making targets
> Collected error summary (may duplicate other messages):
>   xelatex: Command for 'xelatex' gave return code 1
>     Refer to 'RCU.log' for details
> Latexmk: Use the -f option to force complete processing,
>   unless error was exceeding maximum runs, or warnings treated as errors.
> make[2]: *** [Makefile:29: RCU.pdf] Error 12
> make[1]: *** [Documentation/Makefile:115: pdfdocs] Error 2
> make: *** [Makefile:1772: pdfdocs] Error 2
> 

Weird... when you do a make, it should have checked for all
dependencies, when it internally runs:

	./scripts/sphinx-pre-install 

Basically, you need the xelatex package for it to work, as PDF
output is via LaTeX. This is not a mandatory requirement, though,
as most people are only interested on html output, and LaTeX
dependencies require to install lots of stuff. it should provide you
a list of packages required for PDF, with a suggestion of using
apt-get to install it.

In this specific case, I guess the package name is 'texlive-xetex'.

Thanks,
Mauro
