Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215B44A9B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359347AbiBDOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:34:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40012 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiBDOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:34:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7299160F6A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DE2C004E1;
        Fri,  4 Feb 2022 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643985258;
        bh=fypUg1c5tRtvNi/27HyWD+WFQzv7bomeprjjJYewvbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLt7gh0oG+EO9z8N6dAQfrfZ6CLuQkcHRFevSUSAEpaR5Ubcg5QN9KOv/1CKvmSPr
         Ck9DykkwEGyYw6Hf3J7yHYfgT2UgXRxb9GIo+iQpETuSqjoPCIzZA7z7vO4GjvAFJa
         pwxWBFwcRTU0Uomdcflgd0UkzZmm2bnaVVI0BrE8=
Date:   Fri, 4 Feb 2022 15:34:15 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     "giometti@enneenne.com" <giometti@enneenne.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rasm@fe.up.pt" <rasm@fe.up.pt>,
        "jamesnuss@nanometrics.ca" <jamesnuss@nanometrics.ca>
Subject: Re: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
Message-ID: <Yf05Z89OCJYqCNQ3@kroah.com>
References: <20220112205214.2060954-1-robert.hancock@calian.com>
 <Yd9DDJ2HmptwIITA@smile.fi.intel.com>
 <d21aeae0-f75d-f8b9-032a-f4751696d467@enneenne.com>
 <f74e32552955b2293d814cfd14729ab190d8ddbe.camel@calian.com>
 <5178d655-a9f0-0a0e-866c-b85b7eda69f3@enneenne.com>
 <72a4b544d8ed7dc6ff809f21752dd56889185f65.camel@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a4b544d8ed7dc6ff809f21752dd56889185f65.camel@calian.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 05:04:13PM +0000, Robert Hancock wrote:
> On Sun, 2022-01-30 at 10:35 +0100, Rodolfo Giometti wrote:
> > On 29/01/22 23:02, Robert Hancock wrote:
> > > On Thu, 2022-01-13 at 09:17 +0100, Rodolfo Giometti wrote:
> > > > On 12/01/22 22:07, Andy Shevchenko wrote:
> > > > > On Wed, Jan 12, 2022 at 02:52:14PM -0600, Robert Hancock wrote:
> > > > > > If the pps-gpio driver was probed prior to the GPIO device it uses,
> > > > > > the
> > > > > > devm_gpiod_get call returned an -EPROBE_DEFER error, but
> > > > > > pps_gpio_probe
> > > > > > replaced that error code with -EINVAL, causing the pps-gpio probe to
> > > > > > fail and not be retried later. Propagate the error return value so
> > > > > > that
> > > > > > deferred probe works properly.
> > > > > 
> > > > > FWIW,
> > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> > > 
> > > It's not entirely clear to me what tree PPS patches are supposed to go
> > > through.
> > > Seems like some recent ones have gone through char-misc? Not sure if
> > > someone
> > > has this in their queue?
> > 
> > LinuxPPS has no its own tree. All related patches usually are sent to me to
> > be
> > acked and to Greg Kroah-Hartman for inclusion.
> > 
> > Ciao,
> > 
> > Rodolfo
> > 
> 
> It looks like some MAINTAINERS links should maybe be updated for PPS - the
> referenced page at http://wiki.enneenne.com/index.php/LinuxPPS_support seems to
> be dead. There is http://linuxpps.org/doku.php which points to a new mailing
> list location as well, but that seems to have very little activity.
> 
> Greg, can you pick this patch ( https://lkml.org/lkml/2022/1/12/879 ) up?

Please use lore.kernel.org, lkml.org does not work with our tools, nor
do we have any control over it.

thanks,

greg k-h
