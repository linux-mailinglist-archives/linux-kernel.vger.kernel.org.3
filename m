Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F024C5854FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiG2SXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbiG2SXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:23:03 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jul 2022 11:23:02 PDT
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A346391C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4323; q=dns/txt; s=iport;
  t=1659118982; x=1660328582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9brC4OueP9hGIkrSu1+D/+bQmxzFBGuNt0XX9xeckfA=;
  b=aTF6EoJcGMo0PNWamUfwrAXqrViC4FOh05E/NtIQP8HVyGEDI8WI3wMn
   shPKHP4WxKtl9g5UT1ozbVplL3Qzr2rL7Zw0TXEZbiwV7WLqyT6BbloEj
   0G+W38bS1NqKEZYOaXc30r9KfkJvW3NuuthXQCXEIYRFm6E6E+vZ/V+oT
   4=;
X-IronPort-AV: E=Sophos;i="5.93,201,1654560000"; 
   d="scan'208";a="943018207"
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Jul 2022 18:21:59 +0000
Received: from zorba (sjc-vpn6-1252.cisco.com [10.21.124.228])
        by alln-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 26TILuru014577
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Jul 2022 18:21:58 GMT
Date:   Fri, 29 Jul 2022 11:21:56 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        George Cherian <george.cherian@marvell.com>,
        sgoutham@marvell.com, "BOBBY Liu (bobbliu)" <bobbliu@cisco.com>,
        xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: allow selection of number of sparse irqs
Message-ID: <20220729182156.GS821407@zorba>
References: <20220728030420.2279713-1-danielwa@cisco.com>
 <980a561ed87c5530aab2e2b067074862@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980a561ed87c5530aab2e2b067074862@kernel.org>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.21.124.228, sjc-vpn6-1252.cisco.com
X-Outbound-Node: alln-core-1.cisco.com
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 09:52:18AM +0100, Marc Zyngier wrote:
> On 2022-07-28 04:04, Daniel Walker wrote:
> > Currently the maximum number of interrupters is capped at 8260 (64 +
> > 8196) in most of the architectures were CONFIG_SPARSE_IRQ is selected.
> > This upper limit is not sufficient for couple of existing SoC's from
> > Marvell.
> > For eg: Octeon TX2 series of processors support a maximum of 32K
> > interrupters.
> > 
> > Allow configuration of the upper limit of the number of interrupts.
> > 
> > Cc: George Cherian <george.cherian@marvell.com>
> > Cc: sgoutham@marvell.com
> > Cc: "BOBBY Liu (bobbliu)" <bobbliu@cisco.com>
> > Cc: xe-linux-external@cisco.com
> > Signed-off-by: Daniel Walker <danielwa@cisco.com>
> > ---
> >  kernel/irq/Kconfig     | 23 +++++++++++++++++++++++
> >  kernel/irq/internals.h | 10 +++++++++-
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> > index db3d174c53d4..b356217abcfe 100644
> > --- a/kernel/irq/Kconfig
> > +++ b/kernel/irq/Kconfig
> > @@ -125,6 +125,29 @@ config SPARSE_IRQ
> > 
> >  	  If you don't know what to do here, say N.
> > 
> > +choice
> > +	prompt "Select number of sparse irqs"
> > +	depends on SPARSE_IRQ
> > +	default SPARSE_IRQ_EXTEND_8K
> > +	help
> > +          Allows choosing the number of sparse irq's available on the
> > +          system. For each 8k of additional irqs added there is
> > approximatly
> > +          1kb of kernel size increase.
> > +
> > +config SPARSE_IRQ_EXTEND_8K
> > +	bool "8k"
> > +
> > +config SPARSE_IRQ_EXTEND_16K
> > +	bool "16K"
> > +
> > +config SPARSE_IRQ_EXTEND_32K
> > +	bool "32K"
> > +
> > +config SPARSE_IRQ_EXTEND_64K
> > +	bool "64K"
> > +
> > +endchoice
> > +
> >  config GENERIC_IRQ_DEBUGFS
> >  	bool "Expose irq internals in debugfs"
> >  	depends on DEBUG_FS
> > diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> > index f09c60393e55..25fe5abf6c16 100644
> > --- a/kernel/irq/internals.h
> > +++ b/kernel/irq/internals.h
> > @@ -12,7 +12,15 @@
> >  #include <linux/sched/clock.h>
> > 
> >  #ifdef CONFIG_SPARSE_IRQ
> > -# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
> > +# if defined(CONFIG_SPARSE_IRQ_EXTEND_8K)
> > +# define IRQ_BITMAP_BITS	(NR_IRQS + 8192 + 4)
> > +# elif defined(CONFIG_SPARSE_IRQ_EXTEND_16K)
> > +# define IRQ_BITMAP_BITS	(NR_IRQS + 16384 + 4)
> > +# elif defined(CONFIG_SPARSE_IRQ_EXTEND_32K)
> > +# define IRQ_BITMAP_BITS	(NR_IRQS + 32768 + 4)
> > +# elif defined(CONFIG_SPARSE_IRQ_EXTEND_64K)
> > +# define IRQ_BITMAP_BITS	(NR_IRQS + 65536 + 4)
> > +# endif
> >  #else
> >  # define IRQ_BITMAP_BITS	NR_IRQS
> >  #endif
> 
> It really feels like the wrong approach. If your system
> supports a large number of interrupt (I guess it has
> a GICv3 ITS), this shouldn't impact the lesser machines
> (most people are using a distro kernel).
> 
> It also doesn't really scale: the GICv3 architecture gives
> you up to 24 bits of interrupts. Are we going to allocate
> 2MB worth of bitmap? Future interrupt architectures may have
> even larger interrupt spaces.
> 
> As it turns out, we already store the irqdesc in an rb-tree.
> It doesn't take too much imagination to turn this into a
> xarray and use it for both allocation and tracking.
> 
> It would also conveniently replace the irqs_resend bitmap
> if using marks to flag the IRQs to be resent.

Marvell submitted a similar change, but non-selectable, about a month ago.

The limitation prevents Cisco and Marvell hardware from functioning. I don't
think we're well versed enough on the generic irq system to implement what your
suggesting, even if we did Thomas would not likely accept it.

Your suggestion is more of a long term solution vs. our short term solution. I'm
not wedded to any solution, we just need to relieve the limitation so our
hardware starts working. I would imagine other companies have this issue, but I
don't know which ones currently.

I would rather to use an upstream solution verses holding the patches privately.
I would suggest if this limitation would not be overcome for 3-4 releases the
short term solution should be acceptable over that time frame to be replaced by
something else after that.

Daniel
