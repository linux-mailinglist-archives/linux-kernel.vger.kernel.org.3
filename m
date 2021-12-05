Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2AA468D23
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 21:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhLEUJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 15:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLEUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 15:09:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277AEC061714;
        Sun,  5 Dec 2021 12:05:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5019B80ED8;
        Sun,  5 Dec 2021 20:05:57 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 2F563C00446;
        Sun,  5 Dec 2021 20:05:52 +0000 (UTC)
Date:   Sun, 5 Dec 2021 20:11:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Iain Hunter <drhunter95@gmail.com>, lothar.felten@gmail.com,
        iain@hunterembedded.co.uk, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] workaround regression in ina2xx introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Message-ID: <20211205201103.7e19d647@jic23-huawei>
In-Reply-To: <CAK8P3a3LPLbJRDEsYgSL9x=rrk1=AmBWxFBNd0H591NKrLnMZA@mail.gmail.com>
References: <20210930081025.366039-1-drhunter95@gmail.com>
        <CAK8P3a3LPLbJRDEsYgSL9x=rrk1=AmBWxFBNd0H591NKrLnMZA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 13:04:10 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Sep 30, 2021 at 10:10 AM Iain Hunter <drhunter95@gmail.com> wrote:
> >
> > From: Iain Hunter <iain@hunterembedded.co.uk>
> >
> > That change adds an error check to avoid saturation during multiplication
> > to calculate nano seconds in timespec64_to_ns().
> > In ina2xx_capture_thread() a timespec64 structure is used to calculate
> > the delta time until the next sample time. This delta can be negative if
> > the next sample time was in the past. In the -1 case timespec64_to_ns()
> > now clamps the -1 second value to KTIME_MAX. This essentially puts ina2xx
> > thread to sleep forever.
> > Proposed patch is to:
> > 1 change from timespec64_XXX() to standard raw ktime_XXX() APIs to remove
> > non-standard timespec64 calls.
> > 2 split the functionality in the loop into two parts:
> > - do while loop only does the test to see if the next sample time is in the
> > future or in the past and so will be skipped and the sample time
> > incremented until it is in the future. This test is done with a simple
> > signed comparison as we are only interested in the sign being positive or
> > negative.
> > - after do while loop we know that next is later than now and so delay is
> > positive and ksub_sub() can be used to get the delay which is positive.
> >
> > Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>
> >
> > Fixes: cb47755725da("time: Prevent undef$  
> 
> The changelog text could be improved to more closely follow the
> style described in Documentation/process/submitting-patches.rst,
> but the important information is here and the changes look good
> to me.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Hi Iain,

Are you planning to do a v5 with change log tidied up?
In particularly the fixes tag?

Sorry, I should have followed up on this earlier to find out your plans.

Jonathan
