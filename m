Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9607446A6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349404AbhLFUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:18:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:32982 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349378AbhLFUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:18:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 66D10CE180D;
        Mon,  6 Dec 2021 20:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5F4C341C1;
        Mon,  6 Dec 2021 20:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638821667;
        bh=OjM1lgAgJBqJdXggUVF+9xutggZAn/OQ31FijpeWq5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kaJmhlpMIAmevcg7NRZXHLshEpRtXxk7z9G2dtURRYk6JK3sk+oisE0V33cQ5Cnks
         3KiebBIE+vBZGnI++LbsNQrEIwTDSPyp+s1VF2qusX8FLTilfos1rEFgVQkBleD7/Q
         dJxk36kAgVQxYdz1+p0VHPwuS5tR4xRgiufa3vLwREy4U+fOcAdWYv6qTfrpy0FK0x
         Tx3/i0FKKiZEyyL1vxgmGKw4/1UYMkNGANkeagSZUP/Z9LWBEw9QYkMVEE6VcKxdDZ
         o/ATJAn4tB7mu67JG0xxR1ObLYfVcY8rivKbe0Hlfq98ygfW1g5YMG+unzJjXk2SjA
         x33C8xeGmDC/A==
Date:   Mon, 6 Dec 2021 21:14:21 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        " =?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] docs: allow selecting a Sphinx theme
Message-ID: <20211206211421.6eeb990d@coco.lan>
In-Reply-To: <878rwx35v7.fsf@meer.lwn.net>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
        <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
        <878rwx35v7.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 06 Dec 2021 12:12:12 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Instead of having RTD as an almost mandatory theme, allow the
> > user to select other themes via a THEMES environment var.
> >
> > There's a catch, though: as the current theme override logic is
> > dependent of the RTD theme, we need to move the code which
> > adds the CSS overrides to be inside the RTD theme logic.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >
> > See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1638369365.git.mchehab+huawei@kernel.org/
> >
> >  Documentation/Makefile             |  3 ++
> >  Documentation/conf.py              | 52 +++++++++++++++++-------------
> >  Documentation/doc-guide/sphinx.rst |  8 +++++
> >  3 files changed, 41 insertions(+), 22 deletions(-)  
> 
> So I'm playing with this now, and definitely want to apply it.  I do
> have one little worry, though...  THEME seems like an overly general
> name to use here, and seems relatively likely to conflict with other
> uses.  THEME= on the command line is fine, but what do you think about
> something like DOCS_THEME for the environment variable?  Or even
> HTML_THEME as Sphinx uses?

I'm not sure if we will ever consider a "THEME" environment var for anything
but docs and html stuff. That's why I ended taking the shortest name (for
both THEME and CSS make vars).

Yet, I'm OK if to use whatever name you think it would work best.

Btw, while I didn't actually test, maybe those would also apply to epub,
so, just in case, I guess DOCS_THEME would be preferable, IMO.

Thanks,
Mauro
