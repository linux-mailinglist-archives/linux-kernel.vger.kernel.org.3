Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C90485D54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbiAFAmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:42:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40918 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbiAFAmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:42:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08629B81E90;
        Thu,  6 Jan 2022 00:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAAEC36AEB;
        Thu,  6 Jan 2022 00:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429737;
        bh=bdHAdoWudBhWfx8+bzqVio1LC+j7B6DRirdiwGeDdo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ru2EBDG+hqfwvlTMoLhgKYHzMpMz87OOjFh9uqpuDiXTZwFPgwQA6rRyJa/4vItaH
         7nTmLIB5iC4c2diNGWYzvOJTPysmO8HHxVd3ayBXbF6P1yywFDzO6J24VXZ5qKXU9C
         iXkY5CEvpebhghZA8SQaCE6tL8NEvJX8noeOzeaCagTlNBHd365jrYjdp4mFDJMSJn
         qTxT67TbLb2dFKc2MNN19K+uCYZq1GMvAi56IStWtCDqeG74+IngMCDZrw2jdtzSsH
         YZSiuildyrVKLil+40Ftec0xEGgo2V2H0BaiY7x14FBiHUm8lb84XPqpzjHU1aXYS8
         Z0TPj7xYK8Obg==
Date:   Thu, 6 Jan 2022 01:42:13 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     hch@lst.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
Message-ID: <20220106014213.61cd7f94@coco.lan>
In-Reply-To: <84f90b41-7a18-d83c-8739-1d394175f74a@gmail.com>
References: <87mtkcxws9.fsf@meer.lwn.net>
        <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
        <07f8cf68-525b-4fca-a1f9-fd40150fc6e1@gmail.com>
        <20220104090548.76112534@coco.lan>
        <73e62b16-7685-ace2-18d4-e1b79f543caf@gmail.com>
        <20220105084809.157e3f34@coco.lan>
        <241d31e4-5447-a075-69b6-11c14427582d@gmail.com>
        <20220105224230.0700351f@coco.lan>
        <84f90b41-7a18-d83c-8739-1d394175f74a@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 6 Jan 2022 07:57:22 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Wed, 5 Jan 2022 22:42:30 +0100, Mauro Carvalho Chehab wrote:
> > Em Wed, 5 Jan 2022 21:09:59 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> [...]
> >>
> >> I'll test it under various distros/setups.
> >> It may take a while.  
> > 
> > Did a quick test here with this lxc container:
> > 
> > 	$ OS=debian REL=bullseye ;lxc-create -n ${OS} -t /usr/share/lxc/templates/lxc-download -- --dist ${OS} --release ${REL} --arch amd64
> > 
> > If we add check_missing_tex(), it will then complain about lots
> > of packages that don't exist in Debian (se logs at the end).  
> 
> Now I think I understand what kind of tests we need.
> 
> My plan was to intentionally uninstall texlive-ctex (or whichever
> package contains ctexhook.sty) and see if the lack of ctexhook.sty
> is detected or not.
> 
> Apparently, such a test would mean little for sphinx_pre_install.

Yes. The best way is to use lxc (or something similar) to install
a minimal container, install git (and make) and then run the script
directly or via "make pdfdocs".

This way, the script will test all dependencies. 

It should be noticed that, on a minimal install like that, the script
will first report the basic dependencies, which, once installed, may
require other ones.

For instance, in order for the script to detect that python3-venv
is needed, the python package would need to be installed.

On Debian with the above container, I had to run it 2 times.

First run:
	$ make pdfdocs
	...
	You should run:

		sudo apt-get install imagemagick graphviz dvipng fonts-dejavu fonts-noto-cjk gcc latexmk python librsvg2-bin texlive-lang-chinese texlive-xetex

Second run:
	$ make pdfdocs
	...
	You should run:

		sudo apt-get install python3-venv
	note: If you want pdf, you need at least Sphinx 2.4.4.
	To upgrade Sphinx, use:

		/usr/bin/python3 -m venv sphinx_2.4.4
		. sphinx_2.4.4/bin/activate
		pip install -r ./Documentation/sphinx/requirements.txt

> > That's one of the biggest issue with texlive: each distro splits it on
> > different ways. So, basically, the %texlive hash at the script is meant
> > to the way Fedora and openSuse distros usually map packages. I would
> > expect that Mageia would also be similar if not identical, but other
> > distros map packages on different ways.
> > 
> > I'll prepare another patch for fixing the debian issue.  
> 
> Then I'll wait for it.

Patch for Debian sent.

Thanks,
Mauro
