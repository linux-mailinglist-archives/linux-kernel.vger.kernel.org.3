Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9949C7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiAZKsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:48:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37682 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiAZKsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:48:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B457B81C10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1862BC340E3;
        Wed, 26 Jan 2022 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643194085;
        bh=NDYIA12Lp80m8mzBikJjKfoIdYohJwIilWBj4Myci9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKj0u4TmCD5cyALouDUEs+XdggPems82wyll1Tljp52x4txPWifZie2Rv4G0vC6uy
         F2M2yIECM8vjyzjAl3+kxOfFWGAojjMK5qpkCWV7lHrVNqihRF5S0xo9zrsu+64PdS
         9oOwnT8g6asrqJSjT1MQeOtNM/JaHBGuEduqrV7o=
Date:   Wed, 26 Jan 2022 11:48:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, dan.carpenter@oracle.com,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] staging: r8188eu: remove DBG_88E calls from
 os_dep/ioctl_linux.c
Message-ID: <YfEm4t+fhO4I2uDW@kroah.com>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-7-phil@philpotter.co.uk>
 <a681a562-eb41-9dc8-703a-5b235c15a3a1@gmail.com>
 <YfCgQbFxfVZXw9Fg@equinox>
 <b5bbe488-ac43-fd89-7c65-36bfa9c903a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5bbe488-ac43-fd89-7c65-36bfa9c903a6@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:26:08PM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> On 1/26/22 04:13, Phillip Potter wrote:
> 
> [snip]
> 
> }
> > > 
> > > And here you also removes the reads. I guess, some kind of magic pattern is
> > > used
> > > 
> > 
> > So these calls are macro arguments, they would never be executed under
> > normal circumstances anyway, unless the rtw_debug kernel module was
> > passed in as 5 or more - it is 1 by default. The DBG_88E macro would
> > expand during preprocessing phase to (for example):
> > 
> > do {
> > 	if (5 <= GlobalDebugLevel)
> > 		pr_info("R8188EU: " "dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
> > } while (0)
> > 
> > As this is never executed under normal circumstances anyway, I would say
> > calls like these are therefore safe to remove. Happy to be convinced
> > though :-) Many thanks.
> > 
> 
> I see your point, thanks for explanation.
> 
> Well, in this case, you may left all reads, that are executed during normal
> lifetime of a driver. We know, that there is at least 1 place, where read()
> call removal can break things. Might be there are couple of other places we
> don't know about.
> 
> IMHO the best thing you can do is to leave these reads and leave a comment
> like "hey, please remove me and test". One day useless reads should be
> anyway removed, since ideally rtw_read family must get __must_check
> annotation + normal error handling.

No, if these were never getting called in normal operation, there's no
need to add them back.

thanks,

greg k-h
