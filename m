Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75383474543
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhLNOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhLNOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:37:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:37:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u17so32757410wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EjMvrwPSu7ED0UdbjvCYsAuuHexCnu6Rd7+A7M539WY=;
        b=dHivwfu99zBaoXggDAdU8tINy/YbNw7tEGDydSVrQNIcGtbQQEyVTa8D5xWXr4E1+2
         m+jTGwh1IrsR6Zk4JE7Kj475L94o0gDZw8sZ2g2E5D1IiOBOg09sxTTfkuu9wGumOixy
         PaVxEXHkdo+Q02XgfmTfGSw8TQvi5xWWAI/MND109iYbWDRpu+lOXNE3DD23ilsXoXUs
         qcoXLfMqCqdqKL9B81ytoj6TXQ7eYn9jSfHUPlY0pGiSXpMpO1x07HUGJy//iMD+Lmey
         diX1MYrKq6w2R0sUaOy5M6t875FRaEjG3/E6nTAsAHlqRei/N/2R29ym2354GO9RI0/o
         WQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EjMvrwPSu7ED0UdbjvCYsAuuHexCnu6Rd7+A7M539WY=;
        b=OkSpXGuktAoGeT8zcp+yvOPTDWrPB1m43muCDSdVCyMMR3XrXGQpF8igncNjI36jcX
         BK6nVly9Iu/8u2aHm6YCg4POHJnaHAEoNo6Qw0ELdR1oEak2Pt6WWwfdRaiZ3nLZgP2M
         InseCaAZLiYoSBJ7lp7Pn55s3+VtilQV+/cOAlKSAq4xKH7/BmLKTcoUzlmScI8k5S61
         qz+qnRpvWfTXk1NIsvVrNp7ww5ycr7d9w+83KIvv4vkF/DRRQHJ8kz5fWmVOWlMM5gkj
         nm01qvUEPGexXkpHVfHtEzy8RTRAKLOy+Z5wB98aT2I9QILXa++HUJG3MvN2lfd+vBIb
         Gu7g==
X-Gm-Message-State: AOAM531p2BBHPZMc9t96xXCOkWhukXP1xOJ6fBGcY3KhXAd8nBX9DKqt
        UvhdIidL2M+7qtA/sgPsORfV4oeK37R4Zg==
X-Google-Smtp-Source: ABdhPJyG+zjY5MrIPxKf5Nee627TYG9pySxms6E8tVqeZ/vgk9UWaetnUCOk9H7D1qx8VZmOJ9L3VQ==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr6267651wri.343.1639492638881;
        Tue, 14 Dec 2021 06:37:18 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:243:2f6a:9a1:5446])
        by smtp.gmail.com with ESMTPSA id k187sm2669579wme.0.2021.12.14.06.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 06:37:18 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:37:12 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] misc: open-dice: Add driver to expose DICE data
 to userspace
Message-ID: <YbisGPqjLV8Chl8h@google.com>
References: <20211213195833.772892-1-dbrazdil@google.com>
 <20211213195833.772892-3-dbrazdil@google.com>
 <YbhFTj561N4Ir2RG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbhFTj561N4Ir2RG@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 08:18:38AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 13, 2021 at 07:58:33PM +0000, David Brazdil wrote:
> > Open Profile for DICE is an open protocol for measured boot compatible
> > with the Trusted Computing Group's Device Identifier Composition
> > Engine (DICE) specification. The generated Compound Device Identifier
> > (CDI) certificates represent the hardware/software combination measured
> > by DICE, and can be used for remote attestation and sealing.
> > 
> > Add a driver that exposes reserved memory regions populated by firmware
> > with DICE CDIs and exposes them to userspace via a character device.
> > 
> > Userspace obtains the memory region's size from read() and calls mmap()
> > to create a mapping of the memory region in its address space. The
> > mapping is not allowed to be write+shared, giving userspace a guarantee
> > that the data were not overwritten by another process.
> > 
> > Userspace can also call write(), which triggers a wipe of the DICE data
> > by the driver. Because both the kernel and userspace mappings use
> > write-combine semantics, all clients observe the memory as zeroed after
> > the syscall has returned.
> > 
> > Cc: Andrew Scull <ascull@google.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> >  drivers/misc/Kconfig     |  12 +++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/open-dice.c | 197 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 210 insertions(+)
> >  create mode 100644 drivers/misc/open-dice.c
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 0f5a49fc7c9e..4d996485f5a7 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -470,6 +470,18 @@ config HISI_HIKEY_USB
> >  	  switching between the dual-role USB-C port and the USB-A host ports
> >  	  using only one USB controller.
> >  
> > +config OPEN_DICE
> > +	tristate "Open Profile for DICE driver"
> > +	depends on OF_RESERVED_MEM
> > +	help
> > +	  This driver exposes a DICE reserved memory region to userspace via
> > +	  a character device. The memory region contains Compound Device
> > +	  Identifiers (CDIs) generated by firmware as an output of DICE
> > +	  measured boot flow. Userspace can uses CDIs for remote attestation
> > +	  and sealing.
> > +
> > +	  If unsure, say N.
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index a086197af544..70e800e9127f 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
> >  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> >  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
> > +obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> > diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> > new file mode 100644
> > index 000000000000..ea7b1a8d49ac
> > --- /dev/null
> > +++ b/drivers/misc/open-dice.c
> > @@ -0,0 +1,197 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 - Google LLC
> > + * Author: David Brazdil <dbrazdil@google.com>
> > + *
> > + * Driver for Open Profile for DICE.
> > + *
> > + * This driver takes ownership of a reserved memory region containing secrets
> > + * derived following the Open Profile for DICE. The contents of the memory
> > + * region are not interpreted by the kernel but can be mapped into a userspace
> > + * process via a misc device. The memory region can also be wiped, removing
> > + * the secrets from memory.
> > + *
> > + * Userspace can access the data by (w/o error handling):
> > + *
> > + *     fd = open("/dev/open-dice0", O_RDWR);
> > + *     size = read(fd, NULL, 0);
> 
> I was thinking you would return the value as a string in the buffer
> provided to the read call, not as the return value itself.  That is odd
> and probably breaks something.  What would happen if you ran 'cat' on
> the device node?

Ah, I misunderstood. Yeah, running `cat` will endlessly print garbage.
I'll do a quick respin and also change write() to appear to consume the
buffer because 'echo 1 > /dev/open-dice0' currently blocks.

David
