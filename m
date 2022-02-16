Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906614B8F29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiBPRdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:33:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiBPRdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:33:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6922128B6;
        Wed, 16 Feb 2022 09:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB4C861BC5;
        Wed, 16 Feb 2022 17:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809BCC340E8;
        Wed, 16 Feb 2022 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645032786;
        bh=qYYdvT6AeCXuOfXWgf9Vb2nVM8/mVSQ3AS/PSeriAhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQyWt24JhOIOrw2z1XZlLZ4AShWBTjF+Mw2U+/MzBIfagEq1m1oNJSnB+xFjo9wcr
         Uq9a8jKVsSvykveWdQSApN+8pHaQI3OTX6RPAP22fW7kpYyS5JiPxHFVWTsaVpW7EQ
         hTvzjDTJ+aftNgohE2CTeMTuDtTl8DJNCBUzfvyc=
Date:   Wed, 16 Feb 2022 18:33:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Won Chung <wonchung@google.com>, Len Brown <lenb@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
Message-ID: <Yg01TjB6DGYeMxjI@kroah.com>
References: <20220211023008.3197397-1-wonchung@google.com>
 <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
 <CAOvb9yjpruiHxkZyZ8BOT0Hi_iV7xMOnBCr59BZX3eah_Zcy_w@mail.gmail.com>
 <CAOvb9yh7jo27NH32tbAOtkJrnC9LwUFgFbHRbdbArwiU+YSmdw@mail.gmail.com>
 <CAJZ5v0gwMSWXMA4XmEioUr2ML3y_NPe9WYUCj2XUj++9ivSLTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwMSWXMA4XmEioUr2ML3y_NPe9WYUCj2XUj++9ivSLTA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 03:04:54PM +0100, Rafael J. Wysocki wrote:
> Adding Greg, who should be involved in this discussion IMO.
> 
> On Mon, Feb 14, 2022 at 11:59 PM Won Chung <wonchung@google.com> wrote:
> >
> > On Mon, Feb 14, 2022 at 12:30 PM Won Chung <wonchung@google.com> wrote:
> > >
> > > On Mon, Feb 14, 2022 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Fri, Feb 11, 2022 at 3:30 AM Won Chung <wonchung@google.com> wrote:
> > > > >
> > > > > When ACPI table includes _PLD fields for a device, create a new
> > > > > directory (pld) in sysfs to share _PLD fields.
> > > >
> > > > This version of the patch loos better to me, but I'm not sure if it
> > > > goes into the right direction overall.
> > > >
> > > > > Currently without PLD information, when there are multiple of same
> > > > > devices, it is hard to distinguish which device corresponds to which
> > > > > physical device in which location. For example, when there are two Type
> > > > > C connectors, it is hard to find out which connector corresponds to the
> > > > > Type C port on the left panel versus the Type C port on the right panel.
> > > >
> > > > So I think that this is your primary use case and I'm wondering if
> > > > this is the best way to address it.
> > > >
> > > > Namely, by exposing _PLD information under the ACPI device object,
> > > > you'll make user space wanting to use that information depend on this
> > > > interface, but the problem is not ACPI-specific (inevitably, it will
> > > > appear on systems using DT, sooner or later) and making the user space
> > > > interface related to it depend on ACPI doesn't look like a perfect
> > > > choice.
> > > >
> > > > IOW, why don't you create a proper ABI for this in the Type C
> > > > subsystem and expose the information needed by user space in a generic
> > > > way that can be based on the _PLD information on systems with ACPI?
> > >
> > > Hi Rafael,
> > >
> > > Thank you for the review.
> > >
> > > I was thinking that _PLD info is specific to ACPI since it is part of
> > > the ACPI table. Could you explain a little bit more on why you think
> > > exposing _PLD fields is not an ACPI-specific problem?
> 
> _PLD is an interface defined by ACPI, but its purpose is not ACPI-specific.
> 
> > Hi Rafael again,
> >
> > Sorry for the silly question here. I misunderstood your comment a bit,
> > but I talked to Benson and Prashant for clarification. I understand
> > now what you mean by it is not an ACPI-specific problem and exposing
> > PLD would depend on ACPI.
> 
> Right.
> 
> > >
> > > I gave an example of how _PLD fields can be used for specifying Type C
> > > connectors, but it is not Type C specific. For Chrome OS, we plan to
> > > initially add PLD to not only Type C connectors but also USB port
> > > devices (including Type C and Type A). Also, PLD can be used in the
> > > future for describing other types of ports too like HDMI. (Benson and
> > > Prashant, please correct or add if I am wrong or missing some
> > > information) Maybe my commit message was not detailed enough..
> > >
> > > I am also curious what Heikki thinks about this. Heikki, can you take
> > > a look and share your thoughts?
> >
> > I am still curious what you and Heikki think about this since it may
> > not be a Type C specific issue. We can start from adding generic
> > location info to Type C subsystem first, as you suggested, then
> > consider how to do the same for USB devices and Type A ports
> > afterwards. I would appreciate sharing any thoughts or feedback. Thank
> > you very much!
> 
> I don't really think that this is a Type C problem either.
> 
> It has existed for a long time in the USB world, for example, or
> wherever there are user-accessible ports, but it looks like in the
> Type C case it has become vitally important.
> 
> My point is that writing user space depending on accessing _PLD
> information exposed under an ACPI device interface that only
> corresponds to the device in question and in the ACPI-specific format
> would be a mistake (Greg, please let me know if you disagree).  That's
> because (a) it would depend on ACPI tables being present (so it
> wouldn't work on systems without them) and (b) it would depend on the
> format of data which covers information that isn't likely to be
> relevant.
> 
> If this information is exposed by the kernel verbatim and user space
> depending on this information is created, it will not be possible to
> unexpose it even if it turns out that exposing it has been a mistake.
> 
> OTOH, if only the relevant pieces of information are exposed in a
> generic way, it is always possible to expose more pieces of it in the
> future as needed.

There are pending patches on the linux-usb mailing list from Heikki to
help expand on the typec information in sysfs in a generic way.  Won,
please work with the linux-usb developers on this change and do not do
anything that is ACPI-specific and only.  That way will not be good for
anyone involved.

Please see:
	https://lore.kernel.org/r/20220203144657.16527-1-heikki.krogerus@linux.intel.com

for the current discussion.

thanks,

greg k-h
