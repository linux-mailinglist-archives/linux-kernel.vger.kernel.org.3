Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B848B654
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350357AbiAKTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350308AbiAKTAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52036C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6lg/YQOMfTdWC8/+oY9b2dJk5r3hMXV+s1jSNhLuMho=; b=hKLhNAPUBMKTrlRjkXM99Kvqhv
        G/dAO8OBQEXH5ogTsRzdqvBhOkgysPoC+UitwtXa8PUFMwr1fA/ZEK5nljZFoYK4xA5NMtLF9+RHl
        V6aYtrEqN2JMzNROpfT/O1/7MXqNvqZ+T+UG/yQbtPMzi1bvluP4zy6es9FnuZbh4h3O+ONmbkUty
        b6gi/Qftkav7i+r/N/4eLBjlyf4fT0Q4TmkyyDGL8ETxRfCtxOS7K4cROyUhwULoKmhBazrgn87vX
        yrB10DVXF6U+Fqrbo5UYVqkESJhbs/VKxvdROhVNlqfC8hbrSvIbYFj/KawCY7qW91VJEpxJf/cXq
        EQLV9rIw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7MNX-00HMZd-Vk; Tue, 11 Jan 2022 19:00:19 +0000
Date:   Tue, 11 Jan 2022 11:00:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] firmware: remove old CONFIG_FW_LOADER_MODULE test
Message-ID: <Yd3Twxj4FjYvBwuo@bombadil.infradead.org>
References: <20211230093932.2747587-1-gregkh@linuxfoundation.org>
 <YdcAOL6hCck2jqXq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdcAOL6hCck2jqXq@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 03:44:08PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 30, 2021 at 10:39:32AM +0100, Greg Kroah-Hartman wrote:
> > The CONFIG_FW_LOADER_MODULE check in firmware.h is very obsolete given
> > that this symbol went away decades ago, so it should be removed.
> > 
> > Reported-by: Borislav Petkov <bp@alien8.de>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  include/linux/firmware.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> > index 3b057dfc8284..0b1c4d9c5465 100644
> > --- a/include/linux/firmware.h
> > +++ b/include/linux/firmware.h
> > @@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
> >  }
> >  #endif
> >  
> > -#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
> > +#if defined(CONFIG_FW_LOADER)
> >  int request_firmware(const struct firmware **fw, const char *name,
> >  		     struct device *device);
> >  int firmware_request_nowarn(const struct firmware **fw, const char *name,
> > -- 
> > 2.34.1
> > 
> 
> Odd, 0-day reports a bunch of warnings with this change:
> 
> drivers/base/firmware_loader/main.c:1054:1: error: redefinition of 'request_firmware_nowait'
> drivers/base/firmware_loader/main.c:811:1: error: redefinition of 'request_firmware'
> drivers/base/firmware_loader/main.c:838:5: error: redefinition of 'firmware_request_nowarn'
> drivers/base/firmware_loader/main.c:863:5: error: redefinition of 'request_firmware_direct'
> drivers/base/firmware_loader/main.c:887:5: error: redefinition of 'firmware_request_platform'
> drivers/base/firmware_loader/main.c:941:1: error: redefinition of 'request_firmware_into_buf'
> drivers/base/firmware_loader/main.c:970:1: error: redefinition of 'request_partial_firmware_into_buf'
> drivers/base/firmware_loader/main.c:992:6: error: redefinition of 'release_firmware'
> 
> 
> Luis, any ideas?

Yeah I think this comes from the fact that modules get a respective
_MODULE define in the generated file
include/generated/autoconf.h 

For example:

vagrant@kdevops-dev /data/linux-next (git::20211203-umh-fix-exitcodes)$
grep CONFIG_CRC8 .config
CONFIG_CRC8=m
vagrant@kdevops-dev /data/linux-next (git::20211203-umh-fix-exitcodes)$
grep CONFIG_CRC8 include/generated/autoconf.h
#define CONFIG_CRC8_MODULE 1 

So I think the above was put in place to ask if its built-in or a
module.

  Luis
