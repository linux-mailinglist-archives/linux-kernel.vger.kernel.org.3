Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568FF520F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbiEJH4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiEJH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A939A243106;
        Tue, 10 May 2022 00:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 437A160EE0;
        Tue, 10 May 2022 07:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4F0C385A6;
        Tue, 10 May 2022 07:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652169153;
        bh=vc0jkaHHDEyk7KcfLPoRwXfVaaRAgF8uAKkEtH+i3d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o57B2N5NdHj7ACnoHZLdj/Sa5tQnRlJKGhzqPWmo1TjmXKTWjaFI/zfkc/krS0ub9
         BGZrDFhJqFRQ21zDj0sNbTs+Ok6mbSEx1VRlhShub15jp/y/8M0FOyyZ38aGeDhikp
         PhGcRhsSQIDt0NLaMOR4bJSmBpD/uIJP610tetDk=
Date:   Tue, 10 May 2022 09:52:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Felipe Balbi <balbi@kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 4/4] USB: gadget: Add a new bus for gadgets
Message-ID: <YnoZva+tZa8Ix+aI@kroah.com>
References: <YnFCEn45XwDWM/9Y@rowland.harvard.edu>
 <CAMuHMdVDK0W0T3=+2c1E6wtwy5JTUemTGYyj3PFuVUhK++AzrA@mail.gmail.com>
 <YnFO0Qr8RY7peFCg@rowland.harvard.edu>
 <YnaR8LaaPTdLTiok@rowland.harvard.edu>
 <CAMuHMdUpOiHHMktPk_-NauDW2ufvGThnkFU7Pok376pM6OEyYw@mail.gmail.com>
 <Ynkh5eKtfxU+AyZX@rowland.harvard.edu>
 <CAMuHMdVi6jCi=tRBNjBodVcA48ygiqPACQcmHx+1HRYnArJ9tQ@mail.gmail.com>
 <YnktokC8Uk9j53yO@rowland.harvard.edu>
 <YnlAAxT5Lq0NvxX0@kroah.com>
 <YnlFl0M0FRzhxwpK@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnlFl0M0FRzhxwpK@rowland.harvard.edu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 12:47:19PM -0400, Alan Stern wrote:
> On Mon, May 09, 2022 at 06:23:31PM +0200, Greg KH wrote:
> > On Mon, May 09, 2022 at 11:05:06AM -0400, Alan Stern wrote:
> > > On Mon, May 09, 2022 at 04:42:01PM +0200, Geert Uytterhoeven wrote:
> > > > Hi Alan,
> > > > 
> > > > On Mon, May 9, 2022 at 4:15 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > > On Mon, May 09, 2022 at 09:46:25AM +0200, Geert Uytterhoeven wrote:
> > > > > > > Geert:
> > > > > > >
> > > > > > > Can you test the patch below?  It ought to fix the problem (although it
> > > > > >
> > > > > > Thanks!
> > > > > >
> > > > > > root@h3-salvator-xs:~# ls -l /sys/bus/gadget/devices/
> > > > > > total 0
> > > > > > lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.0 ->
> > > > > > ../../../devices/platform/soc/e659c000.usb/gadget.0
> > > > > > lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.1 ->
> > > > > > ../../../devices/platform/soc/ee020000.usb/gadget.1
> > > > > > lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.2 ->
> > > > > > ../../../devices/platform/soc/e6590000.usb/gadget.2
> > > > > >
> > > > > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > >
> > > > > > LGTM, so
> > > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > >
> > > > > Thanks!
> > > > >
> > > > > > > might end up causing other problems down the line...)
> > > > > >
> > > > > > Can you please elaborate? I'm not too familiar with UBS gadgets.
> > > > >
> > > > > I was concerned about the fact that changing the name of a file,
> > > > > directory, or symbolic link in sysfs means changing a user API, and so
> > > > > it might cause some existing programs to fail.  That would be a
> > > > > regression.
> > > > >
> > > > > Perhaps the best way to work around the problem is to leave the name set
> > > > > to "gadget" if the ID number is 0, while adding the ID number on to the
> > > > > name if the value is > 0.  What do you think?
> > > > 
> > > > Oh, you mean the "gadget.N" subdirs, which are the targets of the
> > > > symlinks above? These were indeed named "gadget" before.
> > > > 
> > > > Would it be possible to append the ".N" suffixes only to the actual
> > > > symlinks, while keeping the target directory names unchanged?
> > > > E.g. /sys/bus/gadget/devices/gadget.0 ->
> > > > ../../../devices/platform/soc/e659c000.usb/gadget
> > > 
> > > No, it's not possible.  Or at least, not without significant changes to 
> > > the driver core.  Besides, people expect these names to be the same.
> > 
> > It should always be ok to change the names of devices as those are not
> > going to be persistent / determinisitic.  It's the attributes of devices
> > that are supposed to be used to determine those types of things.
> > 
> > So I think let's start out with the .N suffix for everything for now.
> > I'll be glad to submit the fixed patch to the Android kernel build
> > system to see what their testing comes back with to see if they happened
> > to make any name assumptions as that's the largest user of this
> > codebase.
> 
> Okay.  Do you need me to send it as a proper patch before you try it 
> out?

Yes please.

thanks,

greg k-h
