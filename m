Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED84BEB00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiBUSbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:31:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiBUSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:30:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA9C2A;
        Mon, 21 Feb 2022 10:29:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70CE0614CE;
        Mon, 21 Feb 2022 18:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43623C340E9;
        Mon, 21 Feb 2022 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645468186;
        bh=ZfjUNmy1VfVROCOWpX9vGvVVCfkJxiBW68BcBOGRwWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaD7mzvKN5pX1/r75f4SHYMAPQpMzXqLS9P6mDzUsc9wDemPRw5za5KM4G1/wKr2N
         zXIKy35J9NMK3kUlHgwBFOWk+QM3g01FnmQuYmKTloqSH3O83nPj/BoEJMdWz8OxMC
         aX6KriMB1D+1NlSCFAe9l6vk9U7fzDP/k+ARIYEc=
Date:   Mon, 21 Feb 2022 19:29:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCHv4] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Message-ID: <YhPaGB2xdf6EhEvs@kroah.com>
References: <20220210135632.24638-1-quic_saipraka@quicinc.com>
 <YgpyMRTo5wVMhUPl@FVFF77S0Q05N>
 <f8ab050f-117b-2c8e-71b8-dbfa38d24c03@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ab050f-117b-2c8e-71b8-dbfa38d24c03@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 09:33:23AM +0530, Sai Prakash Ranjan wrote:
> Hi Mark,
> 
> On 2/14/2022 8:46 PM, Mark Rutland wrote:
> > Hi,
> > 
> > On Thu, Feb 10, 2022 at 07:26:32PM +0530, Sai Prakash Ranjan wrote:
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
> > This has been the Linux behaviour since the dawn of time, so why is this not
> > considered to be a bug in the tools? Why can't Lauterbach add an option to
> > treat the cores as one?
> 
> More like a feature request than a bug? And why would tools add such a
> feature when
> it is the kernel which runs in SMP mode? Shouldn't kernel be the one having
> such a feature
> because there would be number of such tools with the same issue and we can't
> send a feature
> request to all those tool vendors to add this feature right. Instead adding
> this in the kernel would
> avoid all these centrally at one place.

Please fix this in userspace.

> > Importantly, with hotplug we *cannot* guarantee that all messages will go to
> > the same CPU anyway, since that could be offlined (even if it is CPU 0), so in
> > general we cann't provide a guarantee here.
> 
> Right that is true, in case of CPU hotplug this would be pretty much broken
> if CPU0 is offlined.
> We use these during initial bringup stage of SoCs when we don't have debug
> UART console up and running
> and at the time we don't much care for testing out hotplugging the CPUs and
> let alone trying out
> to offline CPU0 which we use and shoot our own foot :)
> 
> Given this is mostly a debug feature, we don't mind if this doesn't
> guarantee to work in hotplug scenario.

We do not get to choose this type of thing.  Either it will work
properly, or not.  Offlineing cpu 0 happens with power management
situations, right?  Especially with big/little systems, if CPU0 was a
big one, you would remove it while only the little ones were running.

I still feel this should all be handled in userspace.

Especially given the problems that this patch is having with being
tested properly :(

thanks,

greg k-h
