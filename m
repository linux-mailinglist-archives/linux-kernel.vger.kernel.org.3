Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC846FAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhLJGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:45:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54004 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLJGpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:45:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 95EA3CE29F7;
        Fri, 10 Dec 2021 06:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0863DC00446;
        Fri, 10 Dec 2021 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639118528;
        bh=u5OoKjIcepqXlbr0Up1Xu8bPTZ+muxyw2CHNv9uQrs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WgHp/zmnBmlYMXTXE0bvSEIN3dzAwRRHYwpFRiOCixVLoc/+pCtE3YjffRXnTcDyv
         Uihco6B0D7aPEjbFjXFsubKdh4Rfw3rU5DGtZE9aYK6O9kthu2b6ACein5tA2JaJ2n
         A/vhgmvthKmJtE0KKHERit6PGcvJn2r3/UvaGPkM=
Date:   Fri, 10 Dec 2021 07:42:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YbL2uUqV0GWFOitE@kroah.com>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbKT/lcp6iZ+lD4n@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:40:46PM -0800, Eric Biggers wrote:
> On Thu, Dec 09, 2021 at 02:51:59PM -0800, Bart Van Assche wrote:
> > On 12/7/21 5:35 PM, Eric Biggers wrote:
> > > +What:		/sys/block/<disk>/queue/crypto/modes/<mode>
> > > +Date:		December 2021
> > > +Contact:	linux-block@vger.kernel.org
> > > +Description:
> > > +		[RO] For each crypto mode (i.e., encryption/decryption
> > > +		algorithm) the device supports with inline encryption, a file
> > > +		will exist at this location.  It will contain a hexadecimal
> > > +		number that is a bitmask of the supported data unit sizes, in
> > > +		bytes, for that crypto mode.
> > > +
> > > +		Currently, the crypto modes that may be supported are:
> > > +
> > > +		   * AES-256-XTS
> > > +		   * AES-128-CBC-ESSIV
> > > +		   * Adiantum
> > > +
> > > +		For example, if a device supports AES-256-XTS inline encryption
> > > +		with data unit sizes of 512 and 4096 bytes, the file
> > > +		/sys/block/<disk>/queue/crypto/modes/AES-256-XTS will exist and
> > > +		will contain "0x1200".
> > 
> > So a bitmask is used to combine multiple values into a single number?
> 
> You could think of it that way, yes.
> 
> > Has it been considered to report each value separately, e.g. 512\n4096\n
> > instead of 0x1200\n?  I think the former approach is more friendly for shell
> > scripts.

No multi-line outputs in sysfs please.  If you have to do a "selection
from an array", that is not how to do it.

Look at the output of /sys/power/pm_test/ as one way you can do it if
you have to choose one option from a list:
$ cat /sys/power/pm_test
[none] core processors platform devices freezer

But I don't think that applies here, right?

> I don't think that would be acceptable to the sysfs folks, as they only allow
> one value per file.  I suppose a bitmask could be viewed as unacceptable too,
> but it seemed to make sense here, given that the data unit sizes are always
> powers of 2, and the hardware reports them as bitmasks.
> 
> Greg already reviewed this patch, but maybe he wasn't looking at this part.
> 
> Greg, any opinion on the best way to report a set of power-of-2 values via
> sysfs?

A single hex value makes sense to me.

thanks,

greg k-h
