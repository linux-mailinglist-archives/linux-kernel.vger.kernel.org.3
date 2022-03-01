Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2164C93AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiCAS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiCAS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:58:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8E13E01
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:57:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x5so23246616edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zud0bHbg7or0vGw73+41/J87CFQxONqEus9t2ll45Rs=;
        b=DsgKcn6Wm/yJlxIPNaf7eO5rB6HLZkcIk+WPwZvNmmUc/GKiS7zpasVMBWMd0yjyki
         2PymiLOSNKkhLrj7c1c7v7IVJJL9ebx3T2/GG+m+54Ao3Nij3T+Kv/U69gcvZMfwy/x9
         YdiE+IPzI+yQ9l05jpGxD2qYJnkMgYlvQchIH2huu8tur7SOHmB53bQgGEd797WQW2/y
         6hAgypa6ocRO3PMCTOPkXaktqRTJFUN1KF9zzERSOlfrT7DWKOnG3dFsCmjQ3VgLp5aS
         3jqI+PAkElL4g99Iwaj2xFNwFuKZR5feZ0CuvnsvBqDkimO5HJbyu8mXB/vrqIRSdrUF
         0ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zud0bHbg7or0vGw73+41/J87CFQxONqEus9t2ll45Rs=;
        b=35hdsjhljkP548H1pSiNTmrqrl1ppjhy6ud4G2u76T0JP52P0ptI3HbFLkFBqAtBr/
         ikC0hQ5XoyuStTTKnSF5pBhN1JE0lqK9qv2grhNA9jwPMi263yTj78ybQCZFe1mb01eP
         k8i2Fp4Vf0k0aINyO86KlzHVTeBPWB+Zk8CqXgAhk//aBCYuiOeaFxuFVzk6dk5diRCz
         FcZcHsKrNMTkM8G9mWwW4es0Dq+yQnJ6fbIp5IXuwgMeCfno6XKszbNpfYldWeZR0Nu7
         YqfYlpTVmALkujPF092V1pEMUuq+I+F3SClS9vj7kUhvnwSegiDgvBZwsLfkAbf2RaV/
         uV+A==
X-Gm-Message-State: AOAM533JuwTKVVSiddXaTi5+Q5OaLHFNm9633ywaTb426itFWZYTm1p7
        hzwEl7jPAWHfrNzKXmLys2WAfPw0QhbiS+xKs849uw==
X-Google-Smtp-Source: ABdhPJyL6+SxghMQh2cJjoZTXo+JonmVRVSfrrJfTCrKlK4gFnKNqpBlNq8QOSm7nMu/fvyHPWkk+GmV57kInGebUOM=
X-Received: by 2002:a50:da47:0:b0:410:a39a:c43b with SMTP id
 a7-20020a50da47000000b00410a39ac43bmr26283276edk.33.1646161074969; Tue, 01
 Mar 2022 10:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20220301022625.469446-1-wonchung@google.com> <Yh3ofnlEx0bT/R6E@kuha.fi.intel.com>
In-Reply-To: <Yh3ofnlEx0bT/R6E@kuha.fi.intel.com>
From:   Won Chung <wonchung@google.com>
Date:   Tue, 1 Mar 2022 10:57:41 -0800
Message-ID: <CAOvb9yi4oi=KegV1d8MvxWPhStf5jL01CbdM_pAdLqKNAocJ1Q@mail.gmail.com>
Subject: Re: [PATCH v2] usb:typec: Add sysfs support for Type C connector's
 physical location
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 1, 2022 at 1:33 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Won,
>
> On Tue, Mar 01, 2022 at 02:26:25AM +0000, Won Chung wrote:
> > When ACPI table includes _PLD field for a Type C connector, share _PLD
> > values in its sysfs. _PLD stands for physical location of device.
> >
> > Currently without connector's location information, when there are
> > multiple Type C ports, it is hard to distinguish which connector
> > corresponds to which physical port at which location. For example, when
> > there are two Type C connectors, it is hard to find out which connector
> > corresponds to the Type C port on the left panel versus the Type C port
> > on the right panel. With location information provided, we can determin=
e
> > which specific device at which location is doing what.
> >
> > _PLD output includes much more fields, but only generic fields are adde=
d
> > and exposed to sysfs, so that non-ACPI devices can also support it in
> > the future. The minimal generic fields needed for locating a port are
> > the following.
> > - panel
> > - vertical_position
> > - horizontal_position
> > - dock
> > - lid
> >
> > Signed-off-by: Won Chung <wonchung@google.com>
> > ---
> >
> > Changes in v2:
> > - Use string for location.
> > - Clarify get_pld() with naming and return type.
> >
> >  Documentation/ABI/testing/sysfs-class-typec |  35 ++++++
> >  drivers/usb/typec/class.c                   | 113 ++++++++++++++++++++
> >  drivers/usb/typec/class.h                   |   3 +
> >  3 files changed, 151 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentatio=
n/ABI/testing/sysfs-class-typec
> > index 75088ecad202..4497a5aeb063 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -141,6 +141,41 @@ Description:
> >               - "reverse": CC2 orientation
> >               - "unknown": Orientation cannot be determined.
> >
> > +What:                /sys/class/typec/<port>/location/panel
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             Describes which panel surface of the system=E2=80=99s hou=
sing the
> > +             port resides on.
> > +
> > +What:                /sys/class/typec/<port>/location/vertical_positio=
n
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             Describes vertical position of the port on the panel surf=
ace.
> > +             Valid values: upper, center, lower
> > +
> > +What:                /sys/class/typec/<port>/location/horizontal_posit=
ion
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             Describes horizontal position of the port on the panel su=
rface.
> > +             Valid values: left, center, right
> > +
> > +What:                /sys/class/typec/<port>/location/dock
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             Set as "yes" if the port resides in a docking station or =
a port
> > +             replicator, otherwise set as "no".
> > +
> > +What:                /sys/class/typec/<port>/location/lid
> > +Date:                March 2022
> > +Contact:     Won Chung <wonchung@google.com>
> > +Description:
> > +             Set as "yes" if the port resides on the lid of laptop sys=
tem,
> > +             otherwise set as "no".
> > +
>
> I've probable lost track of the topic during my winter break, I'm
> sorry about that, but why are you proposing now that this should be
> made Type-C specific?
> This information is not Type-C specific, so it definitely does not
> belong here.
>
> Br,
>
> --
> heikki

Hi Heikki,

Thank you for the comment. Sorry that my description was not clear.
This is follow up from "[PATCH v6] ACPI: device_sysfs: Add sysfs
support for _PLD" in which Rafael suggested to have generic location
in Type C connector than adding PLD specifically to ACPI device. I was
also convinced by Rafael since userspace code would also be quite
ACPI-specific to access PLD in ACPI device sysfs. The discussion can
be found in https://lore.kernel.org/all/CAOvb9yh7uNg9ZU3RsieGChsjLCfKQhHhip=
Bi4RMuQYKEA4fu9A@mail.gmail.com/.
For your reference, in a diverged email thread, Greg also gave a
feedback: https://lore.kernel.org/all/Yg01TjB6DGYeMxjI@kroah.com/.

Do you think it is still better to have this location information in
ACPI device? I would appreciate it if you can share your thoughts in
the original thread where the discussion is. Thank you very much!

Won
