Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A7A4CA378
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiCBLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiCBLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:21:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB63219E;
        Wed,  2 Mar 2022 03:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646220070; x=1677756070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uLNxc+hzfZRFOP722nQGlf7G0w39Iep5IwVHkKWJPDc=;
  b=R65X/oEYZPosGI8lxqahZQn0lbOG6r8SLPL0sgiIsTZurjvUSlviAvjw
   7IbC4qvIj+AW7s2ZFQBDMJc+ezof29FhOLSfC5MR/Y4iEwZxIG58he9SU
   u0N6z+F/3lpwV1bfFsgXu362UqDN5ZKCZdgwjdzlusJfT8IF7LhC7xK6m
   jFx6MNxNqiATKMGDa7NP33g7b/rERig3InHH//0SyNySLGWDJ6ofBWCmF
   FS6GIPu77XAGrZu0LWxcuJyl2WCmVIYP+5P4NuPVIGr8FgRSkkzuVg5Qr
   rxV2M2fomu6spvS3ju1GJttby+PrbU8Uy8vnfbCsglJLl5qpN3ArETn17
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="339807372"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="339807372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="686106119"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2022 03:21:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 02 Mar 2022 13:21:05 +0200
Date:   Wed, 2 Mar 2022 13:21:05 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Won Chung <wonchung@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb:typec: Add sysfs support for Type C connector's
 physical location
Message-ID: <Yh9TIeCIchBrZOdH@kuha.fi.intel.com>
References: <20220301022625.469446-1-wonchung@google.com>
 <Yh3ofnlEx0bT/R6E@kuha.fi.intel.com>
 <CAOvb9yi4oi=KegV1d8MvxWPhStf5jL01CbdM_pAdLqKNAocJ1Q@mail.gmail.com>
 <CAJZ5v0ipcdUqTEFn075NeioyHRDKy2j_pYZOBKgqnx_c1=q5Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ipcdUqTEFn075NeioyHRDKy2j_pYZOBKgqnx_c1=q5Pw@mail.gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 08:11:06PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 1, 2022 at 7:57 PM Won Chung <wonchung@google.com> wrote:
> >
> > On Tue, Mar 1, 2022 at 1:33 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi Won,
> > >
> > > On Tue, Mar 01, 2022 at 02:26:25AM +0000, Won Chung wrote:
> > > > When ACPI table includes _PLD field for a Type C connector, share _PLD
> > > > values in its sysfs. _PLD stands for physical location of device.
> > > >
> > > > Currently without connector's location information, when there are
> > > > multiple Type C ports, it is hard to distinguish which connector
> > > > corresponds to which physical port at which location. For example, when
> > > > there are two Type C connectors, it is hard to find out which connector
> > > > corresponds to the Type C port on the left panel versus the Type C port
> > > > on the right panel. With location information provided, we can determine
> > > > which specific device at which location is doing what.
> > > >
> > > > _PLD output includes much more fields, but only generic fields are added
> > > > and exposed to sysfs, so that non-ACPI devices can also support it in
> > > > the future. The minimal generic fields needed for locating a port are
> > > > the following.
> > > > - panel
> > > > - vertical_position
> > > > - horizontal_position
> > > > - dock
> > > > - lid
> > > >
> > > > Signed-off-by: Won Chung <wonchung@google.com>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Use string for location.
> > > > - Clarify get_pld() with naming and return type.
> > > >
> > > >  Documentation/ABI/testing/sysfs-class-typec |  35 ++++++
> > > >  drivers/usb/typec/class.c                   | 113 ++++++++++++++++++++
> > > >  drivers/usb/typec/class.h                   |   3 +
> > > >  3 files changed, 151 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > > > index 75088ecad202..4497a5aeb063 100644
> > > > --- a/Documentation/ABI/testing/sysfs-class-typec
> > > > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > > > @@ -141,6 +141,41 @@ Description:
> > > >               - "reverse": CC2 orientation
> > > >               - "unknown": Orientation cannot be determined.
> > > >
> > > > +What:                /sys/class/typec/<port>/location/panel
> > > > +Date:                March 2022
> > > > +Contact:     Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Describes which panel surface of the system’s housing the
> > > > +             port resides on.
> > > > +
> > > > +What:                /sys/class/typec/<port>/location/vertical_position
> > > > +Date:                March 2022
> > > > +Contact:     Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Describes vertical position of the port on the panel surface.
> > > > +             Valid values: upper, center, lower
> > > > +
> > > > +What:                /sys/class/typec/<port>/location/horizontal_position
> > > > +Date:                March 2022
> > > > +Contact:     Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Describes horizontal position of the port on the panel surface.
> > > > +             Valid values: left, center, right
> > > > +
> > > > +What:                /sys/class/typec/<port>/location/dock
> > > > +Date:                March 2022
> > > > +Contact:     Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Set as "yes" if the port resides in a docking station or a port
> > > > +             replicator, otherwise set as "no".
> > > > +
> > > > +What:                /sys/class/typec/<port>/location/lid
> > > > +Date:                March 2022
> > > > +Contact:     Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Set as "yes" if the port resides on the lid of laptop system,
> > > > +             otherwise set as "no".
> > > > +
> > >
> > > I've probable lost track of the topic during my winter break, I'm
> > > sorry about that, but why are you proposing now that this should be
> > > made Type-C specific?
> > > This information is not Type-C specific, so it definitely does not
> > > belong here.
> > >
> > > Br,
> > >
> > > --
> > > heikki
> >
> > Hi Heikki,
> >
> > Thank you for the comment. Sorry that my description was not clear.
> > This is follow up from "[PATCH v6] ACPI: device_sysfs: Add sysfs
> > support for _PLD" in which Rafael suggested to have generic location
> > in Type C connector than adding PLD specifically to ACPI device.
> 
> Well, this doesn't have to be /sys/class/typec/<port>/location/ though.
> 
> For example, the device location information can be exposed in a more
> generic way is /sys/devices/.../location/ for all devices for which it
> is available, somewhat in analogy to /sys/devices/.../power/.

Right, that's what I meant. These can be made generic.

thanks,

-- 
heikki
