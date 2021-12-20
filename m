Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0078847A8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhLTLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:45:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59608 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhLTLpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:45:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D4860FEC;
        Mon, 20 Dec 2021 11:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833ECC36AE8;
        Mon, 20 Dec 2021 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640000703;
        bh=3aUOTDpD6DOuqHaqm1yDmhgD4JeRmkbRYQYZINlR0N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w/d+dVjpqt6PvPDDUsWhxVsViYCad/vgT1i4wZbFupyIUdGzAVbYBBFCLLSSFLDgE
         GZ6BdN1HDKMviUklCVRmZT84XrExG5AcXUFt7SYRgyKX7Vmi6LTqFyWglA78B0X6GB
         atexSk1VSMLGDY/9HNHI5St8KNFheZfxZbzSq2M4=
Date:   Mon, 20 Dec 2021 12:45:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Radim Pavlik <radim.pavlik@tbs-biometrics.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sc16is7xx: Prevent dereferencing invalid data when
 gpio_hog used
Message-ID: <YcBsvFGF5DasixIy@kroah.com>
References: <CAHp75VeaWJBstu2j1-wkBkPfgc0dXvjWZR01d8-q0P8t_3gvNA@mail.gmail.com>
 <20211220113603.1311-1-radim.pavlik@tbs-biometrics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220113603.1311-1-radim.pavlik@tbs-biometrics.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:36:03PM +0100, Radim Pavlik wrote:
> gpio_hog is trying to use gpio functions during probe call.
> At that time we dont have initialized port data which are dereferenced
> via assigned gpio.direction_input/output functions.
> This results in unable to handle kernel NULL pointer dereference
> followed by Kernel panic.
> This patch prevents that.
> 
> Due to changed order of initialization 'port' before 'gpio controller'
> was also changed error path which resulted in removed label.
> 
> No fixes tag because patch spans across multiple patches.

Then list the individual patches please.  Or at least give us a chance
to know how far back to backport this to stable kernels.

thanks,

greg k-h
