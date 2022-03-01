Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4964C93FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiCATMA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Mar 2022 14:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiCATL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:11:59 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27656582F;
        Tue,  1 Mar 2022 11:11:17 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id bt13so29203229ybb.2;
        Tue, 01 Mar 2022 11:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nmWK2BW2x6xyV74EFPtWDeE7bgfe1HOlsD2rX10CEvs=;
        b=DvvsKonyb7fR2c7QzbCJ+8FjvBu/8nZUAADqg3dgj1/R+x5wEhlEn178U0JhkVzG1u
         Rn3YxJoeallf3Q/C91iIzhnqMQN47cp4tCun0pTWGwCkXbleJyxQ/oHbb+1YMh+kFfnD
         7N/rz/D7NGgqH7EBIkHJiy1RE+VeXz5z9zxYs44nXix+s8hLikcGhexfUvuGe0y6i4oM
         s+VVkV5NA9DFrf5dRx9z5B79QWkT1GC+ewvMLS8KipIEfaiAm85prTsu6gvZWUvc9cvi
         LHRNgFAaOVdZlOEHW9gXzyOXckFlNb5Xvq0K+xtzETqI9CEHd4cb2kxClDIjWXEgZ/eF
         Tq8g==
X-Gm-Message-State: AOAM530QZdzPVEGqVc54atBz32ANZX2GAU2h0sKfhQ7dOWVcpg3rhPsf
        QK8q9jf8TTtKrCIbzj/hn5rX7nivHCqf0sR/5Pw=
X-Google-Smtp-Source: ABdhPJzdznA9JoxWBukbJH/P/CqzYOu5SA6WPHkv5lA2ZdqzTyBxETRORZtwqbCo1uWpT/gTyW0yXaWw+GTJrcOTYTs=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr25343371ybk.482.1646161877152; Tue, 01
 Mar 2022 11:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20220301022625.469446-1-wonchung@google.com> <Yh3ofnlEx0bT/R6E@kuha.fi.intel.com>
 <CAOvb9yi4oi=KegV1d8MvxWPhStf5jL01CbdM_pAdLqKNAocJ1Q@mail.gmail.com>
In-Reply-To: <CAOvb9yi4oi=KegV1d8MvxWPhStf5jL01CbdM_pAdLqKNAocJ1Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 20:11:06 +0100
Message-ID: <CAJZ5v0ipcdUqTEFn075NeioyHRDKy2j_pYZOBKgqnx_c1=q5Pw@mail.gmail.com>
Subject: Re: [PATCH v2] usb:typec: Add sysfs support for Type C connector's
 physical location
To:     Won Chung <wonchung@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 7:57 PM Won Chung <wonchung@google.com> wrote:
>
> On Tue, Mar 1, 2022 at 1:33 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Won,
> >
> > On Tue, Mar 01, 2022 at 02:26:25AM +0000, Won Chung wrote:
> > > When ACPI table includes _PLD field for a Type C connector, share _PLD
> > > values in its sysfs. _PLD stands for physical location of device.
> > >
> > > Currently without connector's location information, when there are
> > > multiple Type C ports, it is hard to distinguish which connector
> > > corresponds to which physical port at which location. For example, when
> > > there are two Type C connectors, it is hard to find out which connector
> > > corresponds to the Type C port on the left panel versus the Type C port
> > > on the right panel. With location information provided, we can determine
> > > which specific device at which location is doing what.
> > >
> > > _PLD output includes much more fields, but only generic fields are added
> > > and exposed to sysfs, so that non-ACPI devices can also support it in
> > > the future. The minimal generic fields needed for locating a port are
> > > the following.
> > > - panel
> > > - vertical_position
> > > - horizontal_position
> > > - dock
> > > - lid
> > >
> > > Signed-off-by: Won Chung <wonchung@google.com>
> > > ---
> > >
> > > Changes in v2:
> > > - Use string for location.
> > > - Clarify get_pld() with naming and return type.
> > >
> > >  Documentation/ABI/testing/sysfs-class-typec |  35 ++++++
> > >  drivers/usb/typec/class.c                   | 113 ++++++++++++++++++++
> > >  drivers/usb/typec/class.h                   |   3 +
> > >  3 files changed, 151 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > > index 75088ecad202..4497a5aeb063 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-typec
> > > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > > @@ -141,6 +141,41 @@ Description:
> > >               - "reverse": CC2 orientation
> > >               - "unknown": Orientation cannot be determined.
> > >
> > > +What:                /sys/class/typec/<port>/location/panel
> > > +Date:                March 2022
> > > +Contact:     Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Describes which panel surface of the system’s housing the
> > > +             port resides on.
> > > +
> > > +What:                /sys/class/typec/<port>/location/vertical_position
> > > +Date:                March 2022
> > > +Contact:     Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Describes vertical position of the port on the panel surface.
> > > +             Valid values: upper, center, lower
> > > +
> > > +What:                /sys/class/typec/<port>/location/horizontal_position
> > > +Date:                March 2022
> > > +Contact:     Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Describes horizontal position of the port on the panel surface.
> > > +             Valid values: left, center, right
> > > +
> > > +What:                /sys/class/typec/<port>/location/dock
> > > +Date:                March 2022
> > > +Contact:     Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Set as "yes" if the port resides in a docking station or a port
> > > +             replicator, otherwise set as "no".
> > > +
> > > +What:                /sys/class/typec/<port>/location/lid
> > > +Date:                March 2022
> > > +Contact:     Won Chung <wonchung@google.com>
> > > +Description:
> > > +             Set as "yes" if the port resides on the lid of laptop system,
> > > +             otherwise set as "no".
> > > +
> >
> > I've probable lost track of the topic during my winter break, I'm
> > sorry about that, but why are you proposing now that this should be
> > made Type-C specific?
> > This information is not Type-C specific, so it definitely does not
> > belong here.
> >
> > Br,
> >
> > --
> > heikki
>
> Hi Heikki,
>
> Thank you for the comment. Sorry that my description was not clear.
> This is follow up from "[PATCH v6] ACPI: device_sysfs: Add sysfs
> support for _PLD" in which Rafael suggested to have generic location
> in Type C connector than adding PLD specifically to ACPI device.

Well, this doesn't have to be /sys/class/typec/<port>/location/ though.

For example, the device location information can be exposed in a more
generic way is /sys/devices/.../location/ for all devices for which it
is available, somewhat in analogy to /sys/devices/.../power/.
