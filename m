Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B12449C593
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbiAZIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiAZIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:52:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38104C06161C;
        Wed, 26 Jan 2022 00:52:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E665EB81C10;
        Wed, 26 Jan 2022 08:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C76C340E3;
        Wed, 26 Jan 2022 08:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643187156;
        bh=Dz16Rb8c2taqcOq9oJ+djyTRcUAitIfC8J2mz7ZIZis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mt2vigRpuosNXieU2+Sr1W+0RxDKwhcrQWrPSaAGi/Sjvue7btasifqnhxC8KvIUt
         TZrWMp3bhJoVFdXYlAy1T7mo6pzi35AMsK4DJlVcJsthIIODvFEMcXbQ/M2zVdv3Je
         p+yZKSIBCEFsLAPHTdvVfUDNJMeMBKenBC9hno8g=
Date:   Wed, 26 Jan 2022 09:52:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wander Costa <wcosta@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Message-ID: <YfELyq5AmxiZxjme@kroah.com>
References: <20211029201402.428284-1-wander@redhat.com>
 <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
 <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com>
 <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com>
 <YfArHDfrVHw7ApDx@smile.fi.intel.com>
 <YfArWaKJ13+OC/7w@smile.fi.intel.com>
 <CAAq0SU=U3UY+DUdd1fjj25Yt_QZriShZTSFTsq5B4tPnOYhQvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SU=U3UY+DUdd1fjj25Yt_QZriShZTSFTsq5B4tPnOYhQvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:40:36PM -0300, Wander Costa wrote:
> On Tue, Jan 25, 2022 at 1:56 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Jan 25, 2022 at 06:53:48PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 25, 2022 at 12:40:27PM +0000, Jon Hunter wrote:
> > > > On 25/01/2022 10:29, Wander Costa wrote:
> >
> > ...
> >
> > > > Andy, does this work for X86?
> > >
> > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > No, it does NOT fix an issue (I see it on a handful x86) with the legacy UART
> > > (means the 8250_pnp is in use). And I believe the same will be the case on LPSS
> > > ones (8250_dw / 8250_lpss) and HSU (8250_mid), because the patch influences on
> > > all of them.
> >
> > Shall I send a revert and we can continue with a new approach later on?
> >
> 
> Tomorrow (or maybe after tomorrow) I am going to post the fixes I
> already have, and an additional patch adding a build option
> (disabled to default) so people maybe if they want to use the FIFO on
> console write. But I understand if people decide to go
> ahead and revert the patch.

Let me revert this for now.  And no new config options please, this
should "just work".

thanks,

greg k-h
