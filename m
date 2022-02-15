Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDDC4B6E20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiBONyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:54:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiBONyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:54:33 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA96110EFF;
        Tue, 15 Feb 2022 05:54:23 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id v186so56299780ybg.1;
        Tue, 15 Feb 2022 05:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VCB6/TQULsTlvbiZYdqUi+KQ3iN3sPeHQszyAnSUGg=;
        b=vAXGmzzzNK5o5rDCe/hS8V3cDY+BPu99D7PwHG1j0heLQioTH7mBaXRPG7vViHDYWJ
         I1xJce/bhtAr19+8LmmK65vy6FXYmbScNx2lrunX9nm+yBZt/c+kY7mmajVHJxGoNSwl
         BIqtY3PNgMG0j5TqzrlJW/6UdzW9jxt08fmyK1+mGRhHeBItMYHOGzk/r2N6YwkJ2pJg
         o/FtYx8IoX+CJMEKcshnhsfkLQvqQCA4m+JjsuBkba1JRdG3bIbbLddiJsak+4tUNJBE
         y9VhEinUGwtvzNhzXQR3K1W3xmG5M3q3nqsJkrGIY0n4tE1PYvmvcn6y2h6M9qHLnEC3
         wkwA==
X-Gm-Message-State: AOAM532JXRWlkL9lmAtRvRZnyCC5EvsS3dkjPfTie4lmVONMPKdxQLI7
        zgmfZbP2wYInQBX7/bf6nKeoHzfM3mRaIdT7nK0=
X-Google-Smtp-Source: ABdhPJz9HLZaYlFx3aJeuZLCsNZELI2z4J7OpgCJUicvzOuXK1NcKjMXC1E3fPoL8UCttvxc0BXPkt3FiRvzSlRSSq4=
X-Received: by 2002:a81:a4d8:: with SMTP id b207mr3980752ywh.196.1644933262520;
 Tue, 15 Feb 2022 05:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20220211023008.3197397-1-wonchung@google.com> <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
 <CAOvb9yjpruiHxkZyZ8BOT0Hi_iV7xMOnBCr59BZX3eah_Zcy_w@mail.gmail.com>
 <CAOvb9yh7jo27NH32tbAOtkJrnC9LwUFgFbHRbdbArwiU+YSmdw@mail.gmail.com> <Ygt9B6+0b1hIBr5a@kuha.fi.intel.com>
In-Reply-To: <Ygt9B6+0b1hIBr5a@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Feb 2022 14:54:11 +0100
Message-ID: <CAJZ5v0hVZ1a9krnfW=ogdi+bpOpGDPvT12NxdstRRWjhNi+v3g@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Won Chung <wonchung@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:14 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Feb 14, 2022 at 02:58:44PM -0800, Won Chung wrote:
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
> >
> > Hi Rafael again,
> >
> > Sorry for the silly question here. I misunderstood your comment a bit,
> > but I talked to Benson and Prashant for clarification. I understand
> > now what you mean by it is not an ACPI-specific problem and exposing
> > PLD would depend on ACPI.
> >
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
> Like you said, _PLD is not Type-C specific. We can't limit it to any
> specific device class. For example, I'm pretty sure that sooner or
> later we want to get this information in user space also with camera
> sensors, and probable with a few other things as well.
>
> I think the question here is, can we create a some kind of an
> abstraction layer for the user space that exposes the device location
> details in generic Linux specific way - so with ACPI it would utilise
> the _PLD, and with DT something else (today AFAIK DT does not have
> any way to describe locations of the devices). Maybe I'm wrong?

No, you aren't.

> But if that is the question, then IMO the answer is: maybe one day,
> but not today,

Why not?

> and even if we one day can come up with something like
> that, we still should expose the _PLD as ACPI specific information to
> the user space as is.

Why would it need that information in this particular format?

> Even if one day we have common sysfs attributes for all the devices
> that contain the location of the device in some form, those attributes
> will almost certainly have only a sub-set of the _PLD details, a
> sub-set that works also with DT.

That doesn't have to be the case.

However, things linke cpuidle have been invented to provide user space
interfaces for features that previously were only available on systems
with ACPI.  Why is _PLD different?

> IMO the user space should always have access to all the necessary _PLD
> details in their raw form if needed, even if those common device
> location attributes exist - duplicated information or not.

Again, why would it need that information?

> And debugfs
> unfortunately is also not OK for that, because the user space needs to
> be able to also rely on access to the additional details if needed.

What additional details do you mean?

> We can limit the _PLD fields that we expose to the ones that we know
> we need today (and probable should limit them to those), and we can of
> course have a Kconfig option for the _PLD sysfs information if we want
> to, but let's not start this by trying to figure out what kind of
> abstraction we want for this. Right now we simply can not do that.

Why can't we?
