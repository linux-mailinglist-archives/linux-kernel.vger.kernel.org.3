Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E6D46F79C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhLIXo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIXoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:44:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BCC061746;
        Thu,  9 Dec 2021 15:40:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B4ACB8270A;
        Thu,  9 Dec 2021 23:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6277DC004DD;
        Thu,  9 Dec 2021 23:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639093247;
        bh=nnZsPoAmi114JwLrOsBaJlHzvJP82n/hX1V8BTv/Rfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnfawriabHqjlX6ocp4UNXZ3O5+17puWjgRm3kXrPAVyw4hoAPqthUcPU+Yga6leR
         5sJmnSVJx5IHPfoheVQJDJj4+QAGqKg3S59zU744ZGBrK1ZPSPzVHINO6fAi3Sc3wI
         uxwUAsQ9YGI3eu1mImtDIjM46c8bYjjeQXKTuVXFTHvzwGGSqR0l47EsLenlSuWVjI
         xX/MV+/4RAFaks3YbJ+kjJGX0Zk19LUE3xDuq6WsbJOQBsqY+XjOrooHN7JBAf6JQe
         EYHM16GcXQ4DnRAti/VzCZQqEbPL/2XEFjZC8/MBWsYdu2AJ4JTkBasQK3QgpHuCV0
         oyDbU6wpyQ/pw==
Date:   Thu, 9 Dec 2021 15:40:46 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YbKT/lcp6iZ+lD4n@sol.localdomain>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:51:59PM -0800, Bart Van Assche wrote:
> On 12/7/21 5:35 PM, Eric Biggers wrote:
> > +What:		/sys/block/<disk>/queue/crypto/modes/<mode>
> > +Date:		December 2021
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RO] For each crypto mode (i.e., encryption/decryption
> > +		algorithm) the device supports with inline encryption, a file
> > +		will exist at this location.  It will contain a hexadecimal
> > +		number that is a bitmask of the supported data unit sizes, in
> > +		bytes, for that crypto mode.
> > +
> > +		Currently, the crypto modes that may be supported are:
> > +
> > +		   * AES-256-XTS
> > +		   * AES-128-CBC-ESSIV
> > +		   * Adiantum
> > +
> > +		For example, if a device supports AES-256-XTS inline encryption
> > +		with data unit sizes of 512 and 4096 bytes, the file
> > +		/sys/block/<disk>/queue/crypto/modes/AES-256-XTS will exist and
> > +		will contain "0x1200".
> 
> So a bitmask is used to combine multiple values into a single number?

You could think of it that way, yes.

> Has it been considered to report each value separately, e.g. 512\n4096\n
> instead of 0x1200\n?  I think the former approach is more friendly for shell
> scripts.

I don't think that would be acceptable to the sysfs folks, as they only allow
one value per file.  I suppose a bitmask could be viewed as unacceptable too,
but it seemed to make sense here, given that the data unit sizes are always
powers of 2, and the hardware reports them as bitmasks.

Greg already reviewed this patch, but maybe he wasn't looking at this part.

Greg, any opinion on the best way to report a set of power-of-2 values via
sysfs?

> 
> > +struct blk_crypto_attr {
> > +	struct attribute attr;
> > +	ssize_t (*show)(struct blk_crypto_profile *profile,
> > +			struct blk_crypto_attr *attr, char *page);
> > +};
> 
> It is not clear to me why this structure has been introduced instead of using the
> existing kobj_attribute structure?

kobj_attribute isn't strongly-typed to the specific type of kobject.  It also
includes a store function pointer, which is not necessary here.

What I'm doing here is very common; take a look at some other code that
implements sysfs attributes.  Even block/blk-sysfs.c.

> > +static int __init blk_crypto_sysfs_init(void)
> > +{
> > +	int i;
> > +
> > +	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
> > +	for (i = 1; i < BLK_ENCRYPTION_MODE_MAX; i++) {
> > +		struct blk_crypto_attr *attr = &__blk_crypto_mode_attrs[i];
> > +
> > +		attr->attr.name = blk_crypto_modes[i].name;
> > +		attr->attr.mode = 0444;
> > +		attr->show = blk_crypto_mode_show;
> > +		blk_crypto_mode_attrs[i - 1] = &attr->attr;
> > +	}
> > +	return 0;
> > +}
> > +subsys_initcall(blk_crypto_sysfs_init);
> 
> Would it be possible to remove the use of subsys_initcall() if the crypto attributes and
> blk_crypto_modes[] would be defined in the same file?

I want to make it so that all crypto modes show up in sysfs without having to
write extra code every time a new crypto mode is added.  That's not possible if
the attributes are defined statically.  Defining them in the same array would
come close, since then it would be hard for people to forgot to update one place
and not the other.  But that would mix together the sysfs support and the core
blk-crypto support, which seems undesirable.

- Eric
