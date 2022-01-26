Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F83949C04F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiAZAqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiAZAqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:46:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEBAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:46:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h21so5327190wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qu6RcOEnnJ7n1O+3zkO2VX/ZPqBKZq4dTc8Y7asn2hs=;
        b=DUPTpJjYxMkSVGLerpRQE4ciZdIEeO7DCTe20SUYDzzU5zRiPnaAZcBdarIrOXCwXb
         VFv0TV6wlrXZ3hOFzS8GBkRtGztDGn8jWDl1kB+E9Rw91/ghpapnt7QFFj8Evki2gEc+
         WgtA/0tIlSZFMCz/tjeKLF+Kn7/rkC5831FSnwjL1f9qb5ZubTVMVNUCeYu0r32D7bXs
         3tUedzQJmnvHF2mtABtYHGLU29PTEhqPjlRG6GWo2xr/fYOWb7daqSknepMULVbKTdRX
         jcMd2o/YVWjBAT4gP9P16cC15ZEpRjL6Rj8FA3Zw66C1KSwXe7f5xOIRe3U0VAoWrZc0
         gysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qu6RcOEnnJ7n1O+3zkO2VX/ZPqBKZq4dTc8Y7asn2hs=;
        b=rZl7OV5fEWPuxVnopw8bUo8M7M2ZX3uxYN7GedbvteBPi1ovAK5pqRxZsnaRouFUQn
         s4l6s4S5GyOwcrngN5FwXEYES2y+X9CMW2afRVhckMzf+XWBjP3fFsrD5NyCRfu+i9K8
         eIu8NKMTuD0qQ+zS0vpqpQ0NPo52Z06NY7XiKin6fxA2MsPPa/CX5oVAGFxXg1da4OQZ
         Hi+wOeb1MvvA09IXFniPaQoPdrvBNK5Qt1OVtLrBKi+6x6WxvSqfgpi1xSzNWJmEKD/x
         4AagPYGQXv5kzMCqglpcM8a9fzsEdplRCzZgezd8yN3Jph0TmF2V0vwZos84vUNj2ZjV
         KuAA==
X-Gm-Message-State: AOAM531vW7k1pQVVO8CpYZ9yo0GvdMt7IbenF7MzUJioqih00OVGiBZi
        p5XUO09909CCeL8wbT12pf6x1Q==
X-Google-Smtp-Source: ABdhPJz6AXD0tkjXtIWSiI3DHUpUliN8lfcnXu80abGd/+D5nNzMgi0yDhedkdHkX2Qn9hdx95Hx9w==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr19942033wrv.174.1643157959373;
        Tue, 25 Jan 2022 16:45:59 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id w8sm18385528wre.83.2022.01.25.16.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:45:58 -0800 (PST)
Date:   Wed, 26 Jan 2022 00:45:57 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: Re: [PATCH 00/10] Cleanup and removal of DBG_88E macro
Message-ID: <YfCZxZ1RyB00RoTi@equinox>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <YfAYOVY7jFDubwc5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfAYOVY7jFDubwc5@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:33:13PM +0100, Greg KH wrote:
> On Mon, Jan 24, 2022 at 10:44:05PM +0000, Phillip Potter wrote:
> > This series does a few things in order to effect the removal of the
> > DBG_88E macro:
> > 
> > (1) It removes previously converted calls for consistency.
> > (2) It removes all current DBG_88E calls.
> > (3) It removes all aliased DBG_88E calls.
> > (4) It removes the GlobalDebugLevel flag and the file that defines it.
> > 
> > By its very nature, it is a large patchset, so I've tried to group as
> > appropriate. I went by file as I did the work, which led to over 40
> > patches originally, so I've listed the largest C files as their own
> > patches and then grouped everything else by subdir which gives closer
> > sizes for the other patches.
> 
> Can you rebase this on my staging-testing branch?  It no longer applies
> :(
> 
> thanks,
> 
> greg k-h

Hi Greg,

Yes, of course - this was to supersede the previous 'conversion' patches
I sent so that is probably why it doesn't apply. Sorry, I did e-mail but
I should probably have made this clearer. I will fix it up over the next
few days, as it needs other changes anyway. Many thanks.

Regards,
Phil
