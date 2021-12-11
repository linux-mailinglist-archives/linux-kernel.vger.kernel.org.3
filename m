Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA68B47136F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 11:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhLKKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 05:50:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53448 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhLKKuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 05:50:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2591CE2F5A;
        Sat, 11 Dec 2021 10:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA3EC341C6;
        Sat, 11 Dec 2021 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639219817;
        bh=oULXXNjKX1XrkECFAxfwuHzkSGlYBJuKuwLL+fq0ybU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCuk5L40IwsyzelUSyACjQrrJkVNXgI7MGWK/RCMTsn5u/O9rRUVhOJ34Lqzsly46
         6NBR8M2iFMo8pKARNaMazD1OxhxP/1QUcP2QbAWTGyX1r42djjr35cR1irS1793dDg
         ihHd4lnlq3G2z6rhWuquWigmawyvNOrI6iYk4bEM=
Date:   Sat, 11 Dec 2021 11:50:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YbSCYyAv1SmYy7mz@kroah.com>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain>
 <YbL2uUqV0GWFOitE@kroah.com>
 <cb29756b-8b21-5b4d-f107-b5573945d7ab@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb29756b-8b21-5b4d-f107-b5573945d7ab@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 09:29:41AM -0800, Bart Van Assche wrote:
> On 12/9/21 10:42 PM, Greg Kroah-Hartman wrote:
> > A single hex value makes sense to me.
> 
> Hi Greg,
> 
> I'm not enthusiast about this approach because:
> (a) A single hex value can be confused with a number. Reporting a bitfield in
>     hex format is not sufficient to prevent confusion with a number.

Each sysfs file has their own "units" or values, or whatever.  So a hex
number or bitfield or something else is fine.

Again, single value, no need to parse, is the key here.

> (b) No other block layer sysfs attribute follows this encoding scheme.

Then follow what they do.  Do they have multiple values in a single
file?  If so, they are broken and we should change that.

> (c) This encoding enforces the restriction that data unit sizes are a power of
>     two. Is there anything fundamental in encryption that restricts data unit
>     sizes to a power of two? I don't know the answer myself.

Again, you all can pick the rules you want for this file, if you want to
have bitfields, wonderful!  If you want to make it an enum, wonderful!

thanks,

greg k-h
