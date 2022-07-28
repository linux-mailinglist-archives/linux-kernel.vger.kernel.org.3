Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B927858398E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiG1HfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiG1HfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:35:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70722289
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:35:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6B0634D99;
        Thu, 28 Jul 2022 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658993713;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HA2OxoEIzsjynWmHnpVgHh77MhV4G6QUODaqUF4b0kc=;
        b=096bkuScD6x3RE2dBy8EWuWqvEghwRHXdbG4njGuAKdGd3J4eub6vZHbhEEvU9JrbrXdOE
        a7d9Q6oYU7ZGaao2kaGXv6qiMZ1x7LXsLovunBWLyTJU1hBxOn1mlYuUhSKSMUNGvPzWqW
        /fwQ04NEzZEvP15s+Vm4nK10HoK1QPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658993713;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HA2OxoEIzsjynWmHnpVgHh77MhV4G6QUODaqUF4b0kc=;
        b=e5dmcgR/VtgslV2/uMTD66tDSvICLMAX7pKmE6Ut7pgKNero22wHVCRCJinnKzyvYXvMc/
        TSPB9H1H+sP9J/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A7B713A7E;
        Thu, 28 Jul 2022 07:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sjYAGDE84mILFwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 28 Jul 2022 07:35:13 +0000
Date:   Thu, 28 Jul 2022 09:35:11 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YuI8L3xgAIlwBVFU@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220727161135.24531-1-pvorel@suse.cz>
 <YuFqh6OrWEQsZV04@kroah.com>
 <YuG6jfeT9p47Ekn1@pevik>
 <YuIz5bvMLKQeYn1h@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuIz5bvMLKQeYn1h@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jul 28, 2022 at 12:22:05AM +0200, Petr Vorel wrote:
> > Hi Greg,

> > thanks for your review!

> > > On Wed, Jul 27, 2022 at 06:11:35PM +0200, Petr Vorel wrote:
> > > > Print kernel architecture in /sys/devices/system/cpu/arch
> > > > using UTS_MACHINE, i.e. member of struct uts_namespace.machine.

> > > > This helps people who debug kernel with initramfs with minimal
> > > > environment (i.e. without coreutils or even busybox) or allow to open
> > > > sysfs file instead of run uname -m in high level languages.

> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > >  drivers/base/cpu.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)

> > > You can't add a new sysfs file without a Documentation/ABI/ update as
> > > well.  Please fix that up.
> > I'm sorry. Yes, I realized it later on (once I got offline).
> > Sure, I'll fix this in v2. But the main question is whether this feature is
> > acceptable and what is the best place for the file.


> > > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > > index 4c98849577d4..7c8032e3ff10 100644
> > > > --- a/drivers/base/cpu.c
> > > > +++ b/drivers/base/cpu.c
> > > > @@ -3,6 +3,7 @@
> > > >   * CPU subsystem support
> > > >   */

> > > > +#include <generated/compile.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/init.h>
> > > > @@ -232,6 +233,13 @@ static ssize_t print_cpus_kernel_max(struct device *dev,
> > > >  }
> > > >  static DEVICE_ATTR(kernel_max, 0444, print_cpus_kernel_max, NULL);

> > > > +static ssize_t print_cpus_arch(struct device *dev,
> > > > +				     struct device_attribute *attr, char *buf)
> > > > +{
> > > > +	return sysfs_emit(buf, "%s\n", UTS_MACHINE);
> > > > +}
> > > > +static DEVICE_ATTR(arch, 0444, print_cpus_arch, NULL);

> > > why just UTS_MACHINE?  Doesn't 'uname' show this already?  And I thought
> > > this was in /proc/cpuinfo but odd, it isn't...
> > Sure, this info is in uname(). But for certain cases is really easier to read
> > file from /proc or /sys than run create custom C bindings or a binary which
> > calls uname(2) libc wrapper or run uname binary via execve(2).

> > Yes, I also expected /proc/cpuinfo would have it but it does not have it. I
> > don't think it's a good idea to add 'arch  : foo' line to it, but I can do if
> > there is consensus that it's the best place.

> > > Also what about the other things in compile.h?
> > UTS_VERSION is in /proc/version.
> > LINUX_COMPILE_BY (e.g. "user"), LINUX_COMPILE_HOST (e.g. "host") and
> > LINUX_COMPILER (e.g. "aarch64-alpine-linux-musl-gcc (Alpine 11.2.1_git20220219)
> > ...") are IMHO useless, but I can add it if you wish.

> > Well, there is hostname in /proc/sys/kernel/hostname, there are also ostype and
> > osrelease.. Thinking about it twice /proc/sys/kernel/ looks to me a better place
> > for arch file than current /sys/devices/system/cpu/. WDYT?

> Yeah, I think /proc/sys/kernel/ makes sense, good idea.
Thanks for info, I'll send v2 shortly.

Kind regards,
Petr

> greg k-h
