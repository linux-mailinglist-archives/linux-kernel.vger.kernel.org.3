Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B381247BCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhLUJX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:23:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44302 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhLUJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:23:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F079EB8124B;
        Tue, 21 Dec 2021 09:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0FBC36AE2;
        Tue, 21 Dec 2021 09:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640078604;
        bh=vs6i4+czViyI3niT0XaIdGWKKRNE64KCSW1Ge0iJUMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFyHD1mTWBetPy/IaSAHNt0jtVC558rU2odGeu0CUBv7mrg/gEEPDUJ3dI5/k+gNs
         S/RmsgwAx/8pU6/vOHLbVQTP0gIHnDwKBjw8jGNtz9QCbGBFoMkd+KjIb7DZzy8+Dg
         7jIC2+VjTX3zVG0LBA9+tnzVxTdT9qhclPLrtRgY=
Date:   Tue, 21 Dec 2021 10:23:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tim@cyberelk.net, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] paride: fix up build warning on mips platforms
Message-ID: <YcGdCp1lgG2x89y/@kroah.com>
References: <20211130084626.3215987-1-gregkh@linuxfoundation.org>
 <YcCo8+jTG3b+5GTA@kroah.com>
 <4915ba81-28b1-6008-62f2-50316177fd46@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4915ba81-28b1-6008-62f2-50316177fd46@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 09:33:12AM -0700, Jens Axboe wrote:
> On 12/20/21 9:01 AM, Greg Kroah-Hartman wrote:
> > On Tue, Nov 30, 2021 at 09:46:26AM +0100, Greg Kroah-Hartman wrote:
> >> MIPS include files define "PC" so when building the paride driver the
> >> following build warning shows up:
> >>
> >> 	rivers/block/paride/bpck.c:32: warning: "PC" redefined
> >>
> >> Fix this by undefining PC before redefining it as is done for other
> >> defines in this driver.
> >>
> >> Cc: Tim Waugh <tim@cyberelk.net>
> >> Cc: Jens Axboe <axboe@kernel.dk>
> >> Cc: linux-block@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> >>  drivers/block/paride/bpck.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/block/paride/bpck.c b/drivers/block/paride/bpck.c
> >> index f5f63ca2889d..d880a9465e9b 100644
> >> --- a/drivers/block/paride/bpck.c
> >> +++ b/drivers/block/paride/bpck.c
> >> @@ -28,6 +28,7 @@
> >>  
> >>  #undef r2
> >>  #undef w2
> >> +#undef PC
> >>  
> >>  #define PC			pi->private
> >>  #define r2()			(PC=(in_p(2) & 0xff))
> >> -- 
> >> 2.34.1
> >>
> > 
> > Given the lack of objections to this, I'll just take it through one of
> > my trees for 5.17-rc1.
> 
> Sorry about that, got lost. I can queue it  up too, or you can add my
> acked-by, either is fine.

Easy enough for me to take it, now done, thanks!

greg k-h
