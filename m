Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FFB4A8CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349550AbiBCUKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353917AbiBCUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:10:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D6C061714;
        Thu,  3 Feb 2022 12:10:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u14so8262624lfo.11;
        Thu, 03 Feb 2022 12:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgjIhjoJuA3DF90qjLz2c6bqzGg+YJ5rojP2yLU/3Gg=;
        b=mujSGYAEuY2n2r/XC3vDwPwIkzL23n7o+bK2j/Ek2t9bl8tagm2cBFf1fzm5sni0SJ
         07q57O/78pLb0XTVeJETFFnae99pYgpzGNXPylNZuLelndVAWYZrkIlgytJfJrNH/STV
         m/8HC150F/lJ8AY/UesYi1AppxJLpiUQpSyNTk2RFqA8bZye2iWFoVwu53t99fNmHI8y
         SgWxXeWw8tXaPi7F7ECaWuo529yaKu/fUPrCxk6pBYtLPbVJ4jKbgLetFxdJkvq32IPD
         /67faTlD9EvuVujad5ZK5At0vdqnsYSrQlYlsK8Ffa06SifKj5flQxmF6BpHvidgwgSv
         q/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgjIhjoJuA3DF90qjLz2c6bqzGg+YJ5rojP2yLU/3Gg=;
        b=HDYOajHbLQsD10HndYcK2jO55j1YdjCi2X311/q7JAEv1UI2Y8LeoVBgjOUFDS5Ex3
         OMkLQei/i6qfMW8cdFldFwW5v97NTO9nvNeXT9wyyUPzl8xlluNWC2tWI7sMIYo9nmKE
         AhK6Jv1rj5rI1fEVjoi4kxUtObbKuVNYpsxj2lZmwV4t3rcQ+AEr2Mv+yEMz+VGsxGTX
         VRlXADRfEdZRBYYy6RKsT9RYtVSS6+ql5MbzwusbZ6Mcqkp+s/e8gHfCY5jcs4vRLX1B
         oRbvKdLUNP47xN2cEccAVQMZFInwMgDIc9dAyzwe+Gi7Vq81isoqzdjQ7/T4MmiRjew8
         H+Gg==
X-Gm-Message-State: AOAM531aJAo2JBi2tVo7uYt9750bBzUQ4tpfKhuvpYGNrANxJ3bgUstr
        zMXUGVUaNOdtfvA0uPvXfrgBAwuy3amxoItvuFM=
X-Google-Smtp-Source: ABdhPJx4xHZ2lgJ/wS3C7uJFGZrVZvEZCnYbsMd9TWqAHNQQj8n+9xbrSGt0QBaYWsmLPuNl0mw7fpBMMGub3WVxjk0=
X-Received: by 2002:a05:6512:2f0:: with SMTP id m16mr29550646lfq.72.1643919035014;
 Thu, 03 Feb 2022 12:10:35 -0800 (PST)
MIME-Version: 1.0
References: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
 <1643638312-3912-2-git-send-email-p-mohan@ti.com> <20220203183700.GB2982815@p14s>
In-Reply-To: <20220203183700.GB2982815@p14s>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri, 4 Feb 2022 01:40:23 +0530
Message-ID: <CANk7y0h3EDkZqSSy_i3NCwROZOMuHCNkJDvE7s6pWuO7KWipmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] remoteproc: Introduce deny_sysfs_ops flag
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Puranjay Mohan <p-mohan@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Fri, Feb 4, 2022 at 12:07 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hi Puranjay,
>
> On Mon, Jan 31, 2022 at 07:41:51PM +0530, Puranjay Mohan wrote:
> > The remoteproc framework provides sysfs interfaces for changing
> > the firmware name and for starting/stopping a remote processor
> > through the sysfs files 'state' and 'firmware'. The 'recovery'
> > sysfs file can also be used similarly to control the error recovery
> > state machine of a remoteproc. These interfaces are currently
> > allowed irrespective of how the remoteprocs were booted (like
> > remoteproc self auto-boot, remoteproc client-driven boot etc).
> > These interfaces can adversely affect a remoteproc and its clients
> > especially when a remoteproc is being controlled by a remoteproc
> > client driver(s). Also, not all remoteproc drivers may want to
> > support the sysfs interfaces by default.
> >
> > Add support to deny the sysfs state/firmware/recovery change by
> > introducing a state flag 'deny_sysfs_ops' that the individual
> > remoteproc drivers can set based on their usage needs. The default
> > behavior is to allow the sysfs operations as before.
> >
> > Implement attribute_group->is_visible() to hide the sysfs
> > state/firmware/recovery entries when deny_sysfs_ops flag is set.
> >
>
> The address in the "To:" field of this email doesn't match the one in the SoB,
> Something that makes checkpatch angry.

I will try to figure this out.

>
> > Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> > ---
> >  drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
> >  include/linux/remoteproc.h            |  2 ++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> > index ea8b89f97d7b..4a41abdd1f7b 100644
> > --- a/drivers/remoteproc/remoteproc_sysfs.c
> > +++ b/drivers/remoteproc/remoteproc_sysfs.c
> > @@ -230,6 +230,21 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(name);
> >
> > +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
> > +                            int n)
> > +{
> > +     struct device *dev = kobj_to_dev(kobj);
> > +     struct rproc *rproc = to_rproc(dev);
> > +     umode_t mode = attr->mode;
> > +
> > +     if (rproc->deny_sysfs_ops && (attr == &dev_attr_recovery.attr ||
> > +                                   attr == &dev_attr_firmware.attr ||
> > +                                   attr == &dev_attr_state.attr))
>
> I toyed with this solution for a little while.  I think the use case is valid
> but hiding the above options will also result in a system that is difficult to
> use (and debug) because they convey important information.

I feel most use cases will require it to be read-only and not hidden,
so, we can set mode = 0444 in place of mode = 0 below.
It will make these files read-only without the extra code.
Actually, the idea to implement is_visble() was given by Bjorn in a
reply to the patch in the previous series[1].

>
> I suggest introducing a new kernel configuration options to make the attributes

 We want to do it dynamically and on a per driver basis, hence,
implementing is_visble() would be apt, which can be controlled by the
specific driver using the deny_sysfs_ops flag.

> of the rproc_devgroup return -EINVAL when it is set.  So in remoteproc_sysfs.c
> do something like:
>
> #if CONFIG_REMOTEPROC_SYSFS_RO
> static bool option_is_read_only()
> {
>         return true;
> }
> #else
> static bool option_is_read_only()
> {
>         return false;
> }
> #endif
>
> [...]
>
> static ssize_t recovery_store(struct device *dev,
>                               struct device_attribute *attr,
>                               const char *buf, size_t count)
> {
>         struct rproc *rproc = to_rproc(dev);
>
>         if (option_is_read_only())
>                 return -EINVAL;
>
>         if (sysfs_streq(buf, "enabled")) {
>                 /* change the flag and begin the recovery process if needed */
>                 rproc->recovery_disabled = false;
>                 rproc_trigger_recovery(rproc);
>         } else if (sysfs_streq(buf, "disabled")) {
>                 rproc->recovery_disabled = true;
>         } else if (sysfs_streq(buf, "recover")) {
>                 /* begin the recovery process without changing the flag */
>                 rproc_trigger_recovery(rproc);
>         } else {
>                 return -EINVAL;
>         }
>
>         return count;
> }
>
> Thanks,
> Mathieu
>
> > +             mode = 0;

^^ here we can put mode = 0444; for read-only.

> > +
> > +     return mode;
> > +}
> > +
> >  static struct attribute *rproc_attrs[] = {
> >       &dev_attr_coredump.attr,
> >       &dev_attr_recovery.attr,
> > @@ -240,7 +255,8 @@ static struct attribute *rproc_attrs[] = {
> >  };
> >
> >  static const struct attribute_group rproc_devgroup = {
> > -     .attrs = rproc_attrs
> > +     .attrs = rproc_attrs,
> > +     .is_visible = rproc_is_visible,
> >  };
> >
> >  static const struct attribute_group *rproc_devgroups[] = {
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index e0600e1e5c17..3849c66ce38f 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -523,6 +523,7 @@ struct rproc_dump_segment {
> >   * @table_sz: size of @cached_table
> >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > + * @deny_sysfs_ops: flag to not permit sysfs operations on state, firmware and recovery
> >   * @dump_segments: list of segments in the firmware
> >   * @nb_vdev: number of vdev currently handled by rproc
> >   * @elf_class: firmware ELF class
> > @@ -562,6 +563,7 @@ struct rproc {
> >       size_t table_sz;
> >       bool has_iommu;
> >       bool auto_boot;
> > +     bool deny_sysfs_ops;
> >       struct list_head dump_segments;
> >       int nb_vdev;
> >       u8 elf_class;
> > --
> > 2.24.3
> >

[1] https://patchwork.kernel.org/project/linux-remoteproc/patch/20201121030156.22857-3-s-anna@ti.com/

Thanks,
Puranjay Mohan
