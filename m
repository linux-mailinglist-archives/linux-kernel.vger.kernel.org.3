Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2099F4810F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhL2Ia2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbhL2Ia1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:30:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD39C061574;
        Wed, 29 Dec 2021 00:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62C50B817F2;
        Wed, 29 Dec 2021 08:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DDBC36AE9;
        Wed, 29 Dec 2021 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640766624;
        bh=YfRWdmIFWVyKrJ7vFVvxDn23niord7mBjwi8ie1DWCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2su2cXgwvAgNdVy/xvyHT6lpWj4Wv8Nu3cHDTcI1iknuBwxlDytrvPi4CLtoB2sBw
         c/L855RTGIOroiEwXQCj2coZAgWQpKYmsKfX/yfITuaJw3W/sZZSZe8FFU+POJPrF9
         Ud9GeQgmuUKpyezUkEc5kDZApPdKHkd5Spkaw9IY=
Date:   Wed, 29 Dec 2021 09:30:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     mathias.nyman@intel.com, Albert Wang <albertccwang@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: re-initialize the HC during resume if HCE was set
Message-ID: <YcwclrVzEXRxgUFa@kroah.com>
References: <20211228060246.2958070-1-pumahsu@google.com>
 <YcrKNP4TRXB6nsCI@kroah.com>
 <CAGCq0Lb8ZoGpbkLNhXG=OyWgvz_Qn3ABmq_uvMPJdyEKygMH+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGCq0Lb8ZoGpbkLNhXG=OyWgvz_Qn3ABmq_uvMPJdyEKygMH+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Dec 29, 2021 at 01:53:04PM +0800, Puma Hsu wrote:
> This commit is not used to fix a specific commit. We find a condition
> that when XHCI runs the resume process but the HCE flag is set, then
> the Run/Stop bit of USBCMD cannot be set so that HC would not be
> enabled. In fact, HC may already meet a problem at this moment.
> Besides, in xHCI requirements specification revision 1.2, Table 5-21
> BIT(12) claims that Software should re-initialize the xHC when HCE is
> set. Therefore, I think this commit could be the error handling for
> HCE.

So this does not actually fix an issue that you have seen in any device
or testing?  So it is not relevant for older kernels but just "nice to
have"?

How did you test this if you can not duplicate the problem?

thanks,

greg k-h
