Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B5512C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbiD1HC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiD1HCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:02:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34C986C7;
        Wed, 27 Apr 2022 23:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 72F29CE0F19;
        Thu, 28 Apr 2022 06:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14782C385A0;
        Thu, 28 Apr 2022 06:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651129147;
        bh=LvBswdVAcOBrI9uhbKqCt5QccRBOmdvICEn+wE2qsv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezQ03FeRQk9UBULzlKyZdOBdtFjUq99yGPibCzgjCt/604N6ne/a/bhycknVU3mKz
         vfqdXoAIwcUuDqtTXwokKKZQK9GR6PaTEPreXjeGr1OueJVW9nJgq64zUSNueip5B0
         Z9FaHWhoPA2pbObcFMoUNkn7+Qjz8bhHFdpgyiyA=
Date:   Thu, 28 Apr 2022 08:59:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv6] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Message-ID: <Ymo7ODt+bToCf5Y2@kroah.com>
References: <20220310032636.7286-1-quic_saipraka@quicinc.com>
 <YlkPvnBYzJo9aeZ2@kroah.com>
 <cad739da-75af-8d2f-4107-72c657b9acab@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad739da-75af-8d2f-4107-72c657b9acab@quicinc.com>
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,THIS_AD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:04:34AM +0530, Sai Prakash Ranjan wrote:
> Hi Greg,
> 
> On 4/15/2022 11:55 AM, Greg Kroah-Hartman wrote:
> > On Thu, Mar 10, 2022 at 08:56:36AM +0530, Sai Prakash Ranjan wrote:
> > > From: Shanker Donthineni <shankerd@codeaurora.org>
> > > 
> > > Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
> > > reads/writes from/to DCC on secondary cores. Each core has its
> > > own DCC device registers, so when a core reads or writes from/to DCC,
> > > it only accesses its own DCC device. Since kernel code can run on
> > > any core, every time the kernel wants to write to the console, it
> > > might write to a different DCC.
> > > 
> > > In SMP mode, Trace32 creates multiple windows, and each window shows
> > > the DCC output only from that core's DCC. The result is that console
> > > output is either lost or scattered across windows.
> > > 
> > > Selecting this option will enable code that serializes all console
> > > input and output to core 0. The DCC driver will create input and
> > > output FIFOs that all cores will use. Reads and writes from/to DCC
> > > are handled by a workqueue that runs only core 0.
> > > 
> > > Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> > > Acked-by: Adam Wallis <awallis@codeaurora.org>
> > > Signed-off-by: Timur Tabi <timur@codeaurora.org>
> > > Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> > > Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> > > ---
> > > 
> > > Changes in v6:
> > >   * Disable CPU hotplug when CONFIG_HVC_DCC_SERIALIZE_SMP=y.
> > > 
> > > Changes in v5:
> > >   * Use get_cpu() and put_cpu() for CPU id check in preemptible context.
> > >   * Revert back to build time Kconfig.
> > >   * Remove unnecessary hotplug locks, they result in sleeping in atomic context bugs.
> > >   * Add a comment for the spinlock.
> > > 
> > > Changes in v4:
> > >   * Use module parameter for runtime choice of enabling this feature.
> > >   * Use hotplug locks to avoid race between cpu online check and work schedule.
> > >   * Remove ifdefs and move to common ops.
> > >   * Remove unnecessary check for this configuration.
> > >   * Use macros for buf size instead of magic numbers.
> > >   * v3 - https://lore.kernel.org/lkml/20211213141013.21464-1-quic_saipraka@quicinc.com/
> > > 
> > > Changes in v3:
> > >   * Handle case where core0 is not online.
> > > 
> > > Changes in v2:
> > >   * Checkpatch warning fixes.
> > >   * Use of IS_ENABLED macros instead of ifdefs.
> > > 
> > > ---
> > >   drivers/tty/hvc/Kconfig   |  20 +++++
> > >   drivers/tty/hvc/hvc_dcc.c | 175 +++++++++++++++++++++++++++++++++++++-
> > >   2 files changed, 192 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> > > index 8d60e0ff67b4..62560cd0c04d 100644
> > > --- a/drivers/tty/hvc/Kconfig
> > > +++ b/drivers/tty/hvc/Kconfig
> > > @@ -87,6 +87,26 @@ config HVC_DCC
> > >   	  driver. This console is used through a JTAG only on ARM. If you don't have
> > >   	  a JTAG then you probably don't want this option.
> > > +config HVC_DCC_SERIALIZE_SMP
> > > +	bool "Use DCC only on CPU core 0"
> > > +	depends on SMP && HVC_DCC
> > > +	help
> > > +	  Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
> > > +	  reads/writes from/to DCC on more than one CPU core. Each core has its
> > > +	  own DCC device registers, so when a CPU core reads or writes from/to
> > > +	  DCC, it only accesses its own DCC device. Since kernel code can run on
> > > +	  any CPU core, every time the kernel wants to write to the console, it
> > > +	  might write to a different DCC.
> > > +
> > > +	  In SMP mode, Trace32 creates multiple windows, and each window shows
> > > +	  the DCC output only from that core's DCC. The result is that console
> > > +	  output is either lost or scattered across windows.
> > Why are we documenting, and supporting, a closed source userspace tool
> > with kernel changes?  Does this advertisement deserve to be in the
> > kernel source tree?
> 
> Ok, I will remove the comment.
> 
> > And why can't they just fix their tool if this is such a big issue?  Why
> > does this only affect this one platform and not all other smp systems?
> 
> Hmm, this has been discussed in all the past versions of this series and still we
> are at the same question :) I will write a small summary below which will cover
> mostly relevant discussions we discussed till now and then I can point to it
> whenever this question is asked again.

No, it needs to go into the changelog text so that we know what we are
reviewing and considering when you submit it.  Never refer back to some
old conversation, how are we supposed to remember that?

So this all seems to be debugging-only code, and this config option
should NEVER be turned on for a real system.  That makes much more
sense, and is something that I don't recall anyone saying before.

So make this very very explicit, both in the changelog, and in the
Kconfig text, AND when the driver loads have it spit out a huge message
in the kernel log saying that this is for debugging only and that no one
should see this on a normal running system.  We have examples of other
Kconfig options that do this at runtime, copy what they do so it's
painfully obvious.  Like what is in clk_debug_init().

thanks,

greg k-h
