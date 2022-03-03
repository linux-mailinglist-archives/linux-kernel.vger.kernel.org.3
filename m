Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38D4CC46D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiCCRz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiCCRzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:55:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E9515470D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:54:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i11so7604706eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RQc1EduZOxTVRuovpIxxC4lLLOT2x5sF2/FtMnYZD/E=;
        b=Cwet6+xm3v/FuUk7aMMFOzwkCxFlqIg+IXN/Es6pmj/8bjEUctLSG6QX85Nk7SNSHX
         OAjh3lSun2PuLc+dQhVoaTX5dtgrMAbxuXJPHvIgU1PjmKeRdu8CsDIaOwECO63sf4v4
         wN30/iPlbXr7RcfAtg8Igk2qVW4s+WQRc+/fgRBitdCmR1XGg1KxrH6USS1O0cc/Qmp6
         4P3g0jz2aODU6+sgof2+vtDbZyXdVFEQQH6nj0Z3NlS68QKcLE0ukAgOr4Is3Xj1JYCR
         lXJ113FpUGjltfa31Q1FKRIory/1DMJA0bcKB6+hOSGLZX7/IVs+cp9A7I75EF7tfH1s
         icGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RQc1EduZOxTVRuovpIxxC4lLLOT2x5sF2/FtMnYZD/E=;
        b=FFj8KFmIz0qnG4gdfz1dqTBw6g/aiCV7zy4Gkwj4q/bo+KUYdBh7P91Iau/xzm5Rvr
         gstepfAjjvo89Lz0s79ybA6OPLzw00wTBCcLC7V2DsnymXBySuJdoK33QYxaD2jKOhEj
         P6IznMFJqf3hNPMhq+L+NH9VDvp9w4WR9l1t0cHhqVoQU/m4I8tTyMJeLnsPVwi+FXre
         3I0gGDFRYNUq45krQEpCeDatEiyl/VKfut131e8vk74Ic3iIGo9s3W9V5B9ju8VQ4SrK
         LjI2QgqIGKaZsS2n1SKGqr6rDNUDuic/ItJdpnYKu4p0ee7apUHlN7/mobPNjBQr8KTv
         QZNg==
X-Gm-Message-State: AOAM53397aH1mRcSMIp/k23wXFv49kLPtrPjlfMCFUp5Bhf4M2iQRgCU
        ZYVM4FdsJfNrtvWhqxA5C9VHu6Sw7mejg25QA0FPkA==
X-Google-Smtp-Source: ABdhPJx96NoKM7kiOq+mdIK5kt8YNcj4xxoTnWjFMDM//0/0jJNiszMwTp5lpcPnEmv1NbCtRQQwsQB91On+I/Qv5qY=
X-Received: by 2002:aa7:c687:0:b0:415:eb43:8ff5 with SMTP id
 n7-20020aa7c687000000b00415eb438ff5mr2509400edq.74.1646330074426; Thu, 03 Mar
 2022 09:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20220301022625.469446-1-wonchung@google.com> <Yh3ofnlEx0bT/R6E@kuha.fi.intel.com>
 <CAOvb9yi4oi=KegV1d8MvxWPhStf5jL01CbdM_pAdLqKNAocJ1Q@mail.gmail.com>
 <CAJZ5v0ipcdUqTEFn075NeioyHRDKy2j_pYZOBKgqnx_c1=q5Pw@mail.gmail.com> <Yh9TIeCIchBrZOdH@kuha.fi.intel.com>
In-Reply-To: <Yh9TIeCIchBrZOdH@kuha.fi.intel.com>
From:   Won Chung <wonchung@google.com>
Date:   Thu, 3 Mar 2022 09:54:11 -0800
Message-ID: <CAOvb9yhaV2Kx5R+BR9M_rcqw5XOo7AiLmNP1r7XX_qf5xOBCfQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb:typec: Add sysfs support for Type C connector's
 physical location
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 3:21 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Mar 01, 2022 at 08:11:06PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 1, 2022 at 7:57 PM Won Chung <wonchung@google.com> wrote:
> > >
> > > On Tue, Mar 1, 2022 at 1:33 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > Hi Won,
> > > >
> > > > On Tue, Mar 01, 2022 at 02:26:25AM +0000, Won Chung wrote:
> > > > > When ACPI table includes _PLD field for a Type C connector, share=
 _PLD
> > > > > values in its sysfs. _PLD stands for physical location of device.
> > > > >
> > > > > Currently without connector's location information, when there ar=
e
> > > > > multiple Type C ports, it is hard to distinguish which connector
> > > > > corresponds to which physical port at which location. For example=
, when
> > > > > there are two Type C connectors, it is hard to find out which con=
nector
> > > > > corresponds to the Type C port on the left panel versus the Type =
C port
> > > > > on the right panel. With location information provided, we can de=
termine
> > > > > which specific device at which location is doing what.
> > > > >
> > > > > _PLD output includes much more fields, but only generic fields ar=
e added
> > > > > and exposed to sysfs, so that non-ACPI devices can also support i=
t in
> > > > > the future. The minimal generic fields needed for locating a port=
 are
> > > > > the following.
> > > > > - panel
> > > > > - vertical_position
> > > > > - horizontal_position
> > > > > - dock
> > > > > - lid
> > > > >
> > > > > Signed-off-by: Won Chung <wonchung@google.com>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Use string for location.
> > > > > - Clarify get_pld() with naming and return type.
> > > > >
> > > > >  Documentation/ABI/testing/sysfs-class-typec |  35 ++++++
> > > > >  drivers/usb/typec/class.c                   | 113 ++++++++++++++=
++++++
> > > > >  drivers/usb/typec/class.h                   |   3 +
> > > > >  3 files changed, 151 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Docume=
ntation/ABI/testing/sysfs-class-typec
> > > > > index 75088ecad202..4497a5aeb063 100644
> > > > > --- a/Documentation/ABI/testing/sysfs-class-typec
> > > > > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > > > > @@ -141,6 +141,41 @@ Description:
> > > > >               - "reverse": CC2 orientation
> > > > >               - "unknown": Orientation cannot be determined.
> > > > >
> > > > > +What:                /sys/class/typec/<port>/location/panel
> > > > > +Date:                March 2022
> > > > > +Contact:     Won Chung <wonchung@google.com>
> > > > > +Description:
> > > > > +             Describes which panel surface of the system=E2=80=
=99s housing the
> > > > > +             port resides on.
> > > > > +
> > > > > +What:                /sys/class/typec/<port>/location/vertical_p=
osition
> > > > > +Date:                March 2022
> > > > > +Contact:     Won Chung <wonchung@google.com>
> > > > > +Description:
> > > > > +             Describes vertical position of the port on the pane=
l surface.
> > > > > +             Valid values: upper, center, lower
> > > > > +
> > > > > +What:                /sys/class/typec/<port>/location/horizontal=
_position
> > > > > +Date:                March 2022
> > > > > +Contact:     Won Chung <wonchung@google.com>
> > > > > +Description:
> > > > > +             Describes horizontal position of the port on the pa=
nel surface.
> > > > > +             Valid values: left, center, right
> > > > > +
> > > > > +What:                /sys/class/typec/<port>/location/dock
> > > > > +Date:                March 2022
> > > > > +Contact:     Won Chung <wonchung@google.com>
> > > > > +Description:
> > > > > +             Set as "yes" if the port resides in a docking stati=
on or a port
> > > > > +             replicator, otherwise set as "no".
> > > > > +
> > > > > +What:                /sys/class/typec/<port>/location/lid
> > > > > +Date:                March 2022
> > > > > +Contact:     Won Chung <wonchung@google.com>
> > > > > +Description:
> > > > > +             Set as "yes" if the port resides on the lid of lapt=
op system,
> > > > > +             otherwise set as "no".
> > > > > +
> > > >
> > > > I've probable lost track of the topic during my winter break, I'm
> > > > sorry about that, but why are you proposing now that this should be
> > > > made Type-C specific?
> > > > This information is not Type-C specific, so it definitely does not
> > > > belong here.
> > > >
> > > > Br,
> > > >
> > > > --
> > > > heikki
> > >
> > > Hi Heikki,
> > >
> > > Thank you for the comment. Sorry that my description was not clear.
> > > This is follow up from "[PATCH v6] ACPI: device_sysfs: Add sysfs
> > > support for _PLD" in which Rafael suggested to have generic location
> > > in Type C connector than adding PLD specifically to ACPI device.
> >
> > Well, this doesn't have to be /sys/class/typec/<port>/location/ though.
> >
> > For example, the device location information can be exposed in a more
> > generic way is /sys/devices/.../location/ for all devices for which it
> > is available, somewhat in analogy to /sys/devices/.../power/.
>
> Right, that's what I meant. These can be made generic.

> thanks,
>
> --
> heikki

Hi Heikki and Rafael,

Thank you for clarification and guidance. I created and sent a new
patch on driver core for /sys/devices/.../location/.

Won
