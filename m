Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815184A99CE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348080AbiBDNSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiBDNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:17:59 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B3C061714;
        Fri,  4 Feb 2022 05:17:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id n8so12595996lfq.4;
        Fri, 04 Feb 2022 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWtOAu9WKrYoROm2gjTPv1399/qOrJsSs5qZQZJ0ihE=;
        b=WH6L2xGfA/AwKGK2FfsX10jsB46NH3qFBkx7KHcZtbw7eJpi8rwgDlXsoesyLeCNAZ
         ZYARJX35gbig6eJWmUIV0X5wWSXQ0DrStE2OKWsk58x+rks3VmKdbh6eOpxuKM4od4bF
         sCMDZLjACAhf0eSBeUa6LfW21/W/1lcpk29OgFUqNXfiqFKZdJZJXLBUFZNURgOLokUm
         omw3YdswfW9g9dCAGzLSSudbRSpaHpFH7iEbNAwOaFCSDwEATTDZ6fEAvKpLFHcrLL6O
         zAbg4NCOS4tommu6qywSJh5dfAYr7Vfgo/grwMqSURfTb97GveYTe374PtoK1ACA0OSQ
         T6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWtOAu9WKrYoROm2gjTPv1399/qOrJsSs5qZQZJ0ihE=;
        b=0zPqv3kve6ZRhIPd+WH3J3YAnPnJvrWZoLX4SRs9JN3/fXZ3I424I+H1HxH1feYahG
         0vKzueOjkB1UIC8qwJgcdbLgSDx2NlXWtJHp552vrQQ8vdif1KROhtIQ3HrkaKqHgB+N
         s+rEiN4GxM9OcMyL0+RT7jITPL7nx00Sc2+3PxMd6FQcyE8CCyRRGP/y5M9B2KxCcq6E
         iHdE8wS9nzB7m/z19rhOX79fbKw4HNaL/bk/o3mA1QkrbRREOM6GGxonJGRt16oFTQ8P
         /Rw8Bv2h6SPsO79IRGM4TDu83ghPv9Mmx0SDqb8w/j6XgDiq2+kDi+O+SPsVn880QyLa
         3Q+A==
X-Gm-Message-State: AOAM532MDWyfMiTqumXUFaJdQLoKYoC9OrievsweGGZflY3qOWpvL7aY
        YVG00O5AGptmIAvmkj0pzGdXYxf8QUUvSBr4l2OJz1SSd0w=
X-Google-Smtp-Source: ABdhPJydeZspshtmqM1In8tiqjdNlVNr+aIESbwlkbReNdiEqUW0il42zwUtxPqzDOf0WiHcspzu4o96IQnAEHZDzo0=
X-Received: by 2002:a19:6503:: with SMTP id z3mr1020014lfb.121.1643980677232;
 Fri, 04 Feb 2022 05:17:57 -0800 (PST)
MIME-Version: 1.0
References: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
 <1643638312-3912-2-git-send-email-p-mohan@ti.com> <20220203183700.GB2982815@p14s>
 <Yfw+VdrUJFjl6ZAQ@ripper>
In-Reply-To: <Yfw+VdrUJFjl6ZAQ@ripper>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri, 4 Feb 2022 18:47:45 +0530
Message-ID: <CANk7y0h9QLH2vs9QwrjN4sXVHTvDbFF0UpfBozrnG3wnaTThPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] remoteproc: Introduce deny_sysfs_ops flag
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Puranjay Mohan <p-mohan@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Fri, Feb 4, 2022 at 2:12 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 03 Feb 10:37 PST 2022, Mathieu Poirier wrote:
>
> > Hi Puranjay,
> >
> > On Mon, Jan 31, 2022 at 07:41:51PM +0530, Puranjay Mohan wrote:
> > > The remoteproc framework provides sysfs interfaces for changing
> > > the firmware name and for starting/stopping a remote processor
> > > through the sysfs files 'state' and 'firmware'. The 'recovery'
> > > sysfs file can also be used similarly to control the error recovery
> > > state machine of a remoteproc. These interfaces are currently
> > > allowed irrespective of how the remoteprocs were booted (like
> > > remoteproc self auto-boot, remoteproc client-driven boot etc).
> > > These interfaces can adversely affect a remoteproc and its clients
> > > especially when a remoteproc is being controlled by a remoteproc
> > > client driver(s). Also, not all remoteproc drivers may want to
> > > support the sysfs interfaces by default.
> > >
> > > Add support to deny the sysfs state/firmware/recovery change by
> > > introducing a state flag 'deny_sysfs_ops' that the individual
> > > remoteproc drivers can set based on their usage needs. The default
> > > behavior is to allow the sysfs operations as before.
> > >
> > > Implement attribute_group->is_visible() to hide the sysfs
> > > state/firmware/recovery entries when deny_sysfs_ops flag is set.
> > >
> >
> > The address in the "To:" field of this email doesn't match the one in the SoB,
> > Something that makes checkpatch angry.
> >
> > > Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
> > >  include/linux/remoteproc.h            |  2 ++
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> > > index ea8b89f97d7b..4a41abdd1f7b 100644
> > > --- a/drivers/remoteproc/remoteproc_sysfs.c
> > > +++ b/drivers/remoteproc/remoteproc_sysfs.c
> > > @@ -230,6 +230,21 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> > >  }
> > >  static DEVICE_ATTR_RO(name);
> > >
> > > +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
> > > +                          int n)
> > > +{
> > > +   struct device *dev = kobj_to_dev(kobj);
> > > +   struct rproc *rproc = to_rproc(dev);
> > > +   umode_t mode = attr->mode;
> > > +
> > > +   if (rproc->deny_sysfs_ops && (attr == &dev_attr_recovery.attr ||
> > > +                                 attr == &dev_attr_firmware.attr ||
> > > +                                 attr == &dev_attr_state.attr))
> >
> > I toyed with this solution for a little while.  I think the use case is valid
> > but hiding the above options will also result in a system that is difficult to
> > use (and debug) because they convey important information.
> >
> > I suggest introducing a new kernel configuration options to make the attributes
> > of the rproc_devgroup return -EINVAL when it is set.  So in remoteproc_sysfs.c
> > do something like:
> >
> > #if CONFIG_REMOTEPROC_SYSFS_RO
>
> We should assume that people runs the common multi_v7_defconfig for arm,
> or defconfig for arm64, and still want this support.
>
> Based on Puranjay's proposed patch I think it's also reasonable to
> assume that we might have platforms with a mixture of "read-only" and
> "normal" remoteprocs (e.g. some power-management uC + some DSP).
>

I will send another version with mode = 0444 in the .is_visible(), to
make it read-only when deny_sysfs_ops is true.
Also, this patch should technically be v3 as previous series ended with v2.
So, I will mark my next patch as v4.
Please let me know if any other changes are required to this patch.

> > static bool option_is_read_only()
> > {
> >         return true;
> > }
> > #else
> > static bool option_is_read_only()
> > {
> >         return false;
> > }
> > #endif
> >
> > [...]
> >
> > static ssize_t recovery_store(struct device *dev,
> >                             struct device_attribute *attr,
> >                             const char *buf, size_t count)
> > {
> >       struct rproc *rproc = to_rproc(dev);
> >
> >         if (option_is_read_only())
>
> struct attribute_group has a .is_visible callback which I think is
> better to base this on.
>
> Regards,
> Bjorn
>
> >                 return -EINVAL;
> >
> >       if (sysfs_streq(buf, "enabled")) {
> >               /* change the flag and begin the recovery process if needed */
> >               rproc->recovery_disabled = false;
> >               rproc_trigger_recovery(rproc);
> >       } else if (sysfs_streq(buf, "disabled")) {
> >               rproc->recovery_disabled = true;
> >       } else if (sysfs_streq(buf, "recover")) {
> >               /* begin the recovery process without changing the flag */
> >               rproc_trigger_recovery(rproc);
> >       } else {
> >               return -EINVAL;
> >       }
> >
> >       return count;
> > }
> >
> > Thanks,
> > Mathieu
> >
> > > +           mode = 0;
> > > +
> > > +   return mode;
> > > +}
> > > +
> > >  static struct attribute *rproc_attrs[] = {
> > >     &dev_attr_coredump.attr,
> > >     &dev_attr_recovery.attr,
> > > @@ -240,7 +255,8 @@ static struct attribute *rproc_attrs[] = {
> > >  };
> > >
> > >  static const struct attribute_group rproc_devgroup = {
> > > -   .attrs = rproc_attrs
> > > +   .attrs = rproc_attrs,
> > > +   .is_visible = rproc_is_visible,
> > >  };
> > >
> > >  static const struct attribute_group *rproc_devgroups[] = {
> > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > > index e0600e1e5c17..3849c66ce38f 100644
> > > --- a/include/linux/remoteproc.h
> > > +++ b/include/linux/remoteproc.h
> > > @@ -523,6 +523,7 @@ struct rproc_dump_segment {
> > >   * @table_sz: size of @cached_table
> > >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> > >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > > + * @deny_sysfs_ops: flag to not permit sysfs operations on state, firmware and recovery
> > >   * @dump_segments: list of segments in the firmware
> > >   * @nb_vdev: number of vdev currently handled by rproc
> > >   * @elf_class: firmware ELF class
> > > @@ -562,6 +563,7 @@ struct rproc {
> > >     size_t table_sz;
> > >     bool has_iommu;
> > >     bool auto_boot;
> > > +   bool deny_sysfs_ops;
> > >     struct list_head dump_segments;
> > >     int nb_vdev;
> > >     u8 elf_class;
> > > --
> > > 2.24.3
> > >



Thanks,
Puranjay Mohan
