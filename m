Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A6473DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhLNHaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhLNHaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:30:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B3C061574;
        Mon, 13 Dec 2021 23:30:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C60A0B8172C;
        Tue, 14 Dec 2021 07:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1BEC34601;
        Tue, 14 Dec 2021 07:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639467005;
        bh=gYFpfKygjkNh+QfJantXcHERF69BkSPMM6cmh874rnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SD5hx1FaZwNj01InPHHFaDdQnqhMzJi+lQVgODEm+DdNMKzVcZ/Y5yK7oQtvj3omC
         ao5tBlDCQL5A2+kLrBk+vP/toEkQ+EHGL43lCit8pkdduOl/4PxxiroLUtUcCMNVeL
         4KaGTK8nTFQbiRXUgoSxSfoqCa1pmu3OHQs03IrQ=
Date:   Tue, 14 Dec 2021 08:29:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YbhH9z/hVg+RsWhL@kroah.com>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain>
 <YbL2uUqV0GWFOitE@kroah.com>
 <cb29756b-8b21-5b4d-f107-b5573945d7ab@acm.org>
 <YbSCYyAv1SmYy7mz@kroah.com>
 <a4b285ba-4a46-c94b-444e-d3c4f42c42c5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4b285ba-4a46-c94b-444e-d3c4f42c42c5@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:04:29PM -0800, Bart Van Assche wrote:
> On 12/11/21 02:50, Greg Kroah-Hartman wrote:
> > On Fri, Dec 10, 2021 at 09:29:41AM -0800, Bart Van Assche wrote:
> > > (b) No other block layer sysfs attribute follows this encoding scheme.
> > 
> > Then follow what they do.  Do they have multiple values in a single
> > file?  If so, they are broken and we should change that.
> 
> Hi Greg,
> 
> The only other block layer sysfs attribute I know of that reports multiple
> values is the queue/scheduler attribute. Here is an example of the output
> that can be produced by reading that attribute:
> 
> # cat /sys/block/sda/queue/scheduler
> [mq-deadline] kyber bfq none

That's fine, there is no problem there.

That output is the "correct" way to show a list of options and the one
that is currently selected in a sysfs file as I thought I said earlier
in this thread.

> I don't think that changing the behavior of that attribute is an option
> because that would break existing user space software, e.g. the
> https://github.com/osandov/blktests/ test suite.

Very true, do not change this file format.

thanks,

greg k-h
