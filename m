Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F98D49CC42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbiAZOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiAZOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:24:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8051CC06161C;
        Wed, 26 Jan 2022 06:24:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E7D6177F;
        Wed, 26 Jan 2022 14:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E16C340E3;
        Wed, 26 Jan 2022 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643207061;
        bh=ukl36IdEnUA37wQdeyxEyI6HSFV992E6U+2myU8xcr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x53+f4g3yOT+nEU5vLNo9kHzYgdmL+LL93j9GTfssW9uKB02qk6YhiE2glb7JjNbE
         oXx7BzTA2BsxDQBKhLGZR/HUpBN/88l4YXinjEWziK8c2pYgq0Zl+tLeAfL1yj4vXG
         wGjksxAtxILDCOx7WQWcnBl0Nm4UYA3ezxBxF/EA=
Date:   Wed, 26 Jan 2022 15:24:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Message-ID: <YfFZkgE3wfPXLpYA@kroah.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
 <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
 <YfFMSkhbvHaR0YNE@smile.fi.intel.com>
 <f6ffe9bb-8683-4061-c876-1d559267ebae@redhat.com>
 <YfFWmmJFtEB93jUi@smile.fi.intel.com>
 <3430838d-1c63-da49-b774-c5a883e7085f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3430838d-1c63-da49-b774-c5a883e7085f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:18:14PM +0100, Javier Martinez Canillas wrote:
> On 1/26/22 15:11, Andy Shevchenko wrote:
> > On Wed, Jan 26, 2022 at 02:47:33PM +0100, Javier Martinez Canillas wrote:
> >> On 1/26/22 14:27, Andy Shevchenko wrote:
> >>> On Wed, Jan 26, 2022 at 12:18:30PM +0100, Javier Martinez Canillas wrote:
> >>>> On 1/26/22 11:59, Helge Deller wrote:
> >>>>> On 1/26/22 11:02, Andy Shevchenko wrote:
> > 
> > ...
> > 
> >>>>>> P.S. For the record, I will personally NAK any attempts to remove that
> >>>>>> driver from the kernel. And this is another point why it's better not
> >>>>>> to be under the staging.
> >>>>>
> >>>>> I agree. Same as for me to NAK the disabling of fbcon's acceleration
> >>>>> features or even attempting to remove fbdev altogether (unless all
> >>>>> relevant drivers are ported to DRM).
> >>>>
> >>>> But that will never happen if we keep moving the goal post.
> >>>>
> >>>> At some point new fbdev drivers should not be added anymore, otherwise
> >>>> the number of existing drivers that need conversion will keep growing.
> >>>
> >>> This thread is not about adding a new driver.
> >>
> >> It was about adding a new drivers to drivers/video/ (taken from staging).
> > 
> > Does it mean gates are open to take any new fbdev drivers to the staging?
> > If not, I do not see a point here.
> > 
> 
> Good question. I don't know really.
> 
> But staging has always been more flexible in what's accepted there and
> that's why some distros avoid to enable CONFIG_STAGING=y in the kernel.

And that's why if you load a staging driver, it enables TAINT_CRAP in
your runtime flags :)
