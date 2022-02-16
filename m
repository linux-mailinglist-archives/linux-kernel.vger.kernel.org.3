Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927C54B86C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiBPLes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:34:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiBPLeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:34:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE1B14092;
        Wed, 16 Feb 2022 03:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645011274; x=1676547274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3+YJWUdlfqDSPdALE7jDD56AxG0AV/LohKNhQGii1fY=;
  b=C9M3u7U4RRG/sVTce0I+b9IXzBTqtuLRg0wHqDpMfxKzkRSEenBz6B7u
   B+GpOl4pRHu/1WFSrXVCzigY4T+xgmyLPI7lJAhN3Tn2fFAY4TNQ04xip
   dTIBUOl1wnkfHQKa3BaAAd4w3zF8T/rqGEH0iVR9PFSNK3TWWIUDqAEu4
   EU5P6li2P/18j/p8DpkSziPuWS6IItqZTgj++T756jPXoLXox1j8OGb7e
   mF30Pbyf6RGgb4Apfebh27F3GtYlOfJQUOnChIW+JiNLlax1mYXxOmDW9
   1Y1CZN5wtrTx9+BFRUtt3u2mt5elJKs+JgHhYB5RP1exn+sVL5VtlfmgH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250527865"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="250527865"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 03:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="681466865"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Feb 2022 03:34:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Feb 2022 13:34:30 +0200
Date:   Wed, 16 Feb 2022 13:34:30 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Won Chung <wonchung@google.com>, Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
Message-ID: <YgzhRgPD/eBw6UU3@kuha.fi.intel.com>
References: <20220211023008.3197397-1-wonchung@google.com>
 <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
 <CAOvb9yjpruiHxkZyZ8BOT0Hi_iV7xMOnBCr59BZX3eah_Zcy_w@mail.gmail.com>
 <CAOvb9yh7jo27NH32tbAOtkJrnC9LwUFgFbHRbdbArwiU+YSmdw@mail.gmail.com>
 <Ygt9B6+0b1hIBr5a@kuha.fi.intel.com>
 <CAJZ5v0hVZ1a9krnfW=ogdi+bpOpGDPvT12NxdstRRWjhNi+v3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hVZ1a9krnfW=ogdi+bpOpGDPvT12NxdstRRWjhNi+v3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 02:54:11PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 15, 2022 at 11:14 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Mon, Feb 14, 2022 at 02:58:44PM -0800, Won Chung wrote:
> > > On Mon, Feb 14, 2022 at 12:30 PM Won Chung <wonchung@google.com> wrote:
> > > >
> > > > On Mon, Feb 14, 2022 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Fri, Feb 11, 2022 at 3:30 AM Won Chung <wonchung@google.com> wrote:
> > > > > >
> > > > > > When ACPI table includes _PLD fields for a device, create a new
> > > > > > directory (pld) in sysfs to share _PLD fields.
> > > > >
> > > > > This version of the patch loos better to me, but I'm not sure if it
> > > > > goes into the right direction overall.
> > > > >
> > > > > > Currently without PLD information, when there are multiple of same
> > > > > > devices, it is hard to distinguish which device corresponds to which
> > > > > > physical device in which location. For example, when there are two Type
> > > > > > C connectors, it is hard to find out which connector corresponds to the
> > > > > > Type C port on the left panel versus the Type C port on the right panel.
> > > > >
> > > > > So I think that this is your primary use case and I'm wondering if
> > > > > this is the best way to address it.
> > > > >
> > > > > Namely, by exposing _PLD information under the ACPI device object,
> > > > > you'll make user space wanting to use that information depend on this
> > > > > interface, but the problem is not ACPI-specific (inevitably, it will
> > > > > appear on systems using DT, sooner or later) and making the user space
> > > > > interface related to it depend on ACPI doesn't look like a perfect
> > > > > choice.
> > > > >
> > > > > IOW, why don't you create a proper ABI for this in the Type C
> > > > > subsystem and expose the information needed by user space in a generic
> > > > > way that can be based on the _PLD information on systems with ACPI?
> > > >
> > > > Hi Rafael,
> > > >
> > > > Thank you for the review.
> > > >
> > > > I was thinking that _PLD info is specific to ACPI since it is part of
> > > > the ACPI table. Could you explain a little bit more on why you think
> > > > exposing _PLD fields is not an ACPI-specific problem?
> > >
> > > Hi Rafael again,
> > >
> > > Sorry for the silly question here. I misunderstood your comment a bit,
> > > but I talked to Benson and Prashant for clarification. I understand
> > > now what you mean by it is not an ACPI-specific problem and exposing
> > > PLD would depend on ACPI.
> > >
> > > >
> > > > I gave an example of how _PLD fields can be used for specifying Type C
> > > > connectors, but it is not Type C specific. For Chrome OS, we plan to
> > > > initially add PLD to not only Type C connectors but also USB port
> > > > devices (including Type C and Type A). Also, PLD can be used in the
> > > > future for describing other types of ports too like HDMI. (Benson and
> > > > Prashant, please correct or add if I am wrong or missing some
> > > > information) Maybe my commit message was not detailed enough..
> > > >
> > > > I am also curious what Heikki thinks about this. Heikki, can you take
> > > > a look and share your thoughts?
> > >
> > > I am still curious what you and Heikki think about this since it may
> > > not be a Type C specific issue. We can start from adding generic
> > > location info to Type C subsystem first, as you suggested, then
> > > consider how to do the same for USB devices and Type A ports
> > > afterwards. I would appreciate sharing any thoughts or feedback. Thank
> > > you very much!
> >
> > Like you said, _PLD is not Type-C specific. We can't limit it to any
> > specific device class. For example, I'm pretty sure that sooner or
> > later we want to get this information in user space also with camera
> > sensors, and probable with a few other things as well.
> >
> > I think the question here is, can we create a some kind of an
> > abstraction layer for the user space that exposes the device location
> > details in generic Linux specific way - so with ACPI it would utilise
> > the _PLD, and with DT something else (today AFAIK DT does not have
> > any way to describe locations of the devices). Maybe I'm wrong?
> 
> No, you aren't.
> 
> > But if that is the question, then IMO the answer is: maybe one day,
> > but not today,
> 
> Why not?
> 
> > and even if we one day can come up with something like
> > that, we still should expose the _PLD as ACPI specific information to
> > the user space as is.
> 
> Why would it need that information in this particular format?
> 
> > Even if one day we have common sysfs attributes for all the devices
> > that contain the location of the device in some form, those attributes
> > will almost certainly have only a sub-set of the _PLD details, a
> > sub-set that works also with DT.
> 
> That doesn't have to be the case.
> 
> However, things linke cpuidle have been invented to provide user space
> interfaces for features that previously were only available on systems
> with ACPI.  Why is _PLD different?
> 
> > IMO the user space should always have access to all the necessary _PLD
> > details in their raw form if needed, even if those common device
> > location attributes exist - duplicated information or not.
> 
> Again, why would it need that information?

We don't know if we'll need that in the future, and that's the point.

> > And debugfs
> > unfortunately is also not OK for that, because the user space needs to
> > be able to also rely on access to the additional details if needed.
> 
> What additional details do you mean?
> 
> > We can limit the _PLD fields that we expose to the ones that we know
> > we need today (and probable should limit them to those), and we can of
> > course have a Kconfig option for the _PLD sysfs information if we want
> > to, but let's not start this by trying to figure out what kind of
> > abstraction we want for this. Right now we simply can not do that.
> 
> Why can't we?

Right now we can't say for sure if DT can even supply the details that
we need from _PLD. I don't think we can at the moment even say are the
DT guys willing to support this at all.

To play it safe, I would just supply the needed _PLD fields as part of
the ACPI device nodes (under /sys/bus/acpi). There we can guarantee
that we'll always be able to supply all the information in the _PDL if
needed. Since we would add these to the ACPI nodes, it would be
crystal clear to the userspace that this information is only available
on ACPI platforms.

Then if, and only if, we know that DT can supply the same information
(at least to some of it) I would start thinking about the alternative
interface to this information that we make part of the actual devices.
Since at this point we have already the primary ACPI specific
interface to this same information that guarantees that it can supply
all the details if necessary, we don't have to worry about having to
be able to do the same with this new interface. This interface can
just expose the common details that we know for sure that both ACPI
and DT can always supply.

thanks,

-- 
heikki
