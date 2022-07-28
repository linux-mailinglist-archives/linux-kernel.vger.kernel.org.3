Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F07583916
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiG1G7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiG1G7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D07558CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6737B617BB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693F0C433C1;
        Thu, 28 Jul 2022 06:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658991591;
        bh=H6JnRUnyiByJJ0baf07rcz3QNGmBvJEdeFetwFaIrt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMccGIc1VNSGBXBfJ4t4ZMe2sWl5Xli8a6ddC4m2Dc0QeqDnwk3QkUXasHTPj2c/T
         Cn0kVDBvFQCWWgw2NjRAtzNJCQkFJFrCC1rqHySwCEXAnn2PWY6sGozCCG7DfcAaYY
         e4973Viozw117ESscA56ECU0US4l9WW9BSpJSeW8=
Date:   Thu, 28 Jul 2022 08:59:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YuIz5bvMLKQeYn1h@kroah.com>
References: <20220727161135.24531-1-pvorel@suse.cz>
 <YuFqh6OrWEQsZV04@kroah.com>
 <YuG6jfeT9p47Ekn1@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuG6jfeT9p47Ekn1@pevik>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 12:22:05AM +0200, Petr Vorel wrote:
> Hi Greg,
> 
> thanks for your review!
> 
> > On Wed, Jul 27, 2022 at 06:11:35PM +0200, Petr Vorel wrote:
> > > Print kernel architecture in /sys/devices/system/cpu/arch
> > > using UTS_MACHINE, i.e. member of struct uts_namespace.machine.
> 
> > > This helps people who debug kernel with initramfs with minimal
> > > environment (i.e. without coreutils or even busybox) or allow to open
> > > sysfs file instead of run uname -m in high level languages.
> 
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  drivers/base/cpu.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> 
> > You can't add a new sysfs file without a Documentation/ABI/ update as
> > well.  Please fix that up.
> I'm sorry. Yes, I realized it later on (once I got offline).
> Sure, I'll fix this in v2. But the main question is whether this feature is
> acceptable and what is the best place for the file.
> 
> 
> > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > index 4c98849577d4..7c8032e3ff10 100644
> > > --- a/drivers/base/cpu.c
> > > +++ b/drivers/base/cpu.c
> > > @@ -3,6 +3,7 @@
> > >   * CPU subsystem support
> > >   */
> 
> > > +#include <generated/compile.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > > @@ -232,6 +233,13 @@ static ssize_t print_cpus_kernel_max(struct device *dev,
> > >  }
> > >  static DEVICE_ATTR(kernel_max, 0444, print_cpus_kernel_max, NULL);
> 
> > > +static ssize_t print_cpus_arch(struct device *dev,
> > > +				     struct device_attribute *attr, char *buf)
> > > +{
> > > +	return sysfs_emit(buf, "%s\n", UTS_MACHINE);
> > > +}
> > > +static DEVICE_ATTR(arch, 0444, print_cpus_arch, NULL);
> 
> > why just UTS_MACHINE?  Doesn't 'uname' show this already?  And I thought
> > this was in /proc/cpuinfo but odd, it isn't...
> Sure, this info is in uname(). But for certain cases is really easier to read
> file from /proc or /sys than run create custom C bindings or a binary which
> calls uname(2) libc wrapper or run uname binary via execve(2).
> 
> Yes, I also expected /proc/cpuinfo would have it but it does not have it. I
> don't think it's a good idea to add 'arch  : foo' line to it, but I can do if
> there is consensus that it's the best place.
> 
> > Also what about the other things in compile.h?
> UTS_VERSION is in /proc/version.
> LINUX_COMPILE_BY (e.g. "user"), LINUX_COMPILE_HOST (e.g. "host") and
> LINUX_COMPILER (e.g. "aarch64-alpine-linux-musl-gcc (Alpine 11.2.1_git20220219)
> ...") are IMHO useless, but I can add it if you wish.
> 
> Well, there is hostname in /proc/sys/kernel/hostname, there are also ostype and
> osrelease.. Thinking about it twice /proc/sys/kernel/ looks to me a better place
> for arch file than current /sys/devices/system/cpu/. WDYT?

Yeah, I think /proc/sys/kernel/ makes sense, good idea.

greg k-h
