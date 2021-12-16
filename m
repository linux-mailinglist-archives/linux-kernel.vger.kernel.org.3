Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ED747714C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhLPMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhLPMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:05:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713E8C061574;
        Thu, 16 Dec 2021 04:05:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10F9661D7A;
        Thu, 16 Dec 2021 12:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED18C36AE4;
        Thu, 16 Dec 2021 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639656313;
        bh=xnAVQ4r+VQvlqTGC/jY1NEPm3UtZVMG2RXgN8eve8aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fg++ln0VLp60KAI5xSjOihbQGXru+Pmqy2duMxqezESEV9xgjv+PAQENFvNAu+x74
         7rkyGzyCCYJH6pE7HbZXHi097iGuZp2ioLwPh16KwH4hXYNI2U7y0xvFtHxpLTHjWQ
         prOt3GSCy+2py6nVhM3nNKHrsV6jsvsDHM9hIU1M=
Date:   Thu, 16 Dec 2021 13:05:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-media@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: prefer generic SPDX-License expression to
 deprecated one
Message-ID: <Ybsrdll5sqIakINT@kroah.com>
References: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
 <20211216122311.0c9d154e@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216122311.0c9d154e@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 12:23:11PM +0100, Mauro Carvalho Chehab wrote:
> Em Thu, 16 Dec 2021 11:31:32 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
> 
> > Commit 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier") and
> > commit e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
> > introduce the SPDX-License expression LGPL-2.1-or-later for some files.
> > 
> > The command ./scripts/spdxcheck.py warns:
> > 
> >   drivers/media/dvb-core/dmxdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> >   drivers/media/dvb-core/dvb_demux.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> >   drivers/media/dvb-core/dvbdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> >   drivers/media/common/b2c2/flexcop.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > 
> > The preferred SPDX expression for LGPL-2.1 or any later version is with
> > the more generic "+"-extension for "any later version", so: LGPL-2.1+
> > 
> > This makes spdxcheck happy again.
> 
> It doesn't sound right to apply such patch.
> 
> See, the latest SPDX version uses LGPL-2.1-or-later:
> 
> 	https://spdx.org/licenses/LGPL-2.1-or-later.html
> 
> And it deprecated LGPL-2.1+:
> 
> 	https://spdx.org/licenses/LGPL-2.1+.html
> 
> So, those files are perfectly fine with regards to SPDX, and are
> adherent to its latest specs. We do need the latest specs on media,
> as our documentation is under GFDL-1.1-no-invariants-or-later, which
> only exists on newer SPDX versions.
> 
> So, the right thing to do here seems to fix spdxcheck.py, letting it
> either allow both variants (as we probably don't want to replace it
> everywhere) or to emit a warning if the deprecated ones are used.

No, we are not going to add a "warning" for older SPDX versions like
that, otherwise the majority of the kernel will start spitting out
warnings.

Let's worry about actually fixing all of the files that do NOT have SPDX
tags before even considering to move to a newer version of the spec.  We
started this work before the FSF made the crazy change to their tags,
let's not worry about any deprecated issues at the moment.

thanks,

greg k-h
