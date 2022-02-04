Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2F4A9D52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376722AbiBDRDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbiBDRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:03:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F433C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:03:47 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a8so5618613pfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aaHkrQj9YKetdETo2sMbTBSD7GlEjQHVlMntBpzVam8=;
        b=iQLxnNd1xRMSZMXPbOFlOIvFDTaRCXsHVDVTgzjQBY1zrcRkK9pSvEIJuwV88OHd9P
         YGCTUnpDnieKPKdMXcX5NNrDFLmbUAKjwvH6rWZVwRRzOVnQo+oOSU6RLaze5vKTlCEK
         dN6kWMte72JrWvWW73foVomfxwZ9MYBuArNxnJyAll+uBoVWAxCAn4QLiEqDPsKNAXbC
         OmOe/212/bvbLDHvMx+pNeIzL+nqJjCzZheCmrc2sBIoyNkHQ6/qGWaf9Oh1RwCo6QOr
         LLiURVLGqWe27Cb2Ck7/QvKIo1KdOI0auo8fh3c073pCB8RPaa93rcKFfSrw9hEjSNtl
         Cj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaHkrQj9YKetdETo2sMbTBSD7GlEjQHVlMntBpzVam8=;
        b=Dnw/tXqDKTEUmoV/UgLj10ZAi7wDjuXpM/DaOrbigNJqp9FUD+NZV6MCnt78U+y7+t
         vEy6qZR+cAcHVpVF2EV3vHesc69i8QCFNuvJZt9XItt1/6CFkKnMRlAaOz8pK6xlxhnV
         wNJG4xmodZBFzdE25X1DkOMTdCiy03zoEjikdgyS9sAo4UghSLocSxPtLjGkS+um3cll
         EROu1FZhHIKQaRtD1Iuh+pZDOts2zBXPAjIyLEkUBWifTpsN3YXzRQleCpAgjuAQIF84
         KZSdkedTvWKDP63bRR4vmg+x94nPCxEclJ9rDo+3ht8Y1u9xxIat9ctf9ys82I2EpeQj
         hRYA==
X-Gm-Message-State: AOAM530qqx18kaxHhMHCNsPcZK+xQetWXGmzoZftG2ZwtN4D28O+8x/x
        43kX7jyWCFB3yfWBQ3EAvjfcmg==
X-Google-Smtp-Source: ABdhPJw5I1ImdZkTHMF9ylW2l8bs17nli3wcs20bg8rA0svdoibVWBqhHroz4g1G3l8I3ERQ032Usw==
X-Received: by 2002:a05:6a00:80d:: with SMTP id m13mr4013210pfk.48.1643994226835;
        Fri, 04 Feb 2022 09:03:46 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t15sm2087622pgc.49.2022.02.04.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:03:45 -0800 (PST)
Date:   Fri, 4 Feb 2022 10:03:43 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Puranjay Mohan <p-mohan@ti.com>
Subject: Re: [PATCH 1/2] remoteproc: Introduce deny_sysfs_ops flag
Message-ID: <20220204170343.GA3220193@p14s>
References: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
 <1643638312-3912-2-git-send-email-p-mohan@ti.com>
 <20220203183700.GB2982815@p14s>
 <CANk7y0h3EDkZqSSy_i3NCwROZOMuHCNkJDvE7s6pWuO7KWipmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0h3EDkZqSSy_i3NCwROZOMuHCNkJDvE7s6pWuO7KWipmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 01:40:23AM +0530, Puranjay Mohan wrote:
> Hi Mathieu,
> 
> On Fri, Feb 4, 2022 at 12:07 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
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
> 
> I will try to figure this out.
> 
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
> > > +                            int n)
> > > +{
> > > +     struct device *dev = kobj_to_dev(kobj);
> > > +     struct rproc *rproc = to_rproc(dev);
> > > +     umode_t mode = attr->mode;
> > > +
> > > +     if (rproc->deny_sysfs_ops && (attr == &dev_attr_recovery.attr ||
> > > +                                   attr == &dev_attr_firmware.attr ||
> > > +                                   attr == &dev_attr_state.attr))
> >
> > I toyed with this solution for a little while.  I think the use case is valid
> > but hiding the above options will also result in a system that is difficult to
> > use (and debug) because they convey important information.
> 
> I feel most use cases will require it to be read-only and not hidden,
> so, we can set mode = 0444 in place of mode = 0 below.

Perfect.

> It will make these files read-only without the extra code.

I haven't looked the specifics but even better if that is the case.

> Actually, the idea to implement is_visble() was given by Bjorn in a
> reply to the patch in the previous series[1].
> 

I missed Bjorn's reply, which can happen given the high traffic on this mailing
list.  And having different views on how to address problems is a good thing.
It gives us an opportunity to discuss different avenues and pick out the best
one. 

> >
> > I suggest introducing a new kernel configuration options to make the attributes
> 
>  We want to do it dynamically and on a per driver basis, hence,
> implementing is_visble() would be apt, which can be controlled by the
> specific driver using the deny_sysfs_ops flag.

I agree that if you need that kind of granularity then a kernel configuration
option is not the right approach.

> 
> > of the rproc_devgroup return -EINVAL when it is set.  So in remoteproc_sysfs.c
> > do something like:
> >
> > #if CONFIG_REMOTEPROC_SYSFS_RO
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
> >                               struct device_attribute *attr,
> >                               const char *buf, size_t count)
> > {
> >         struct rproc *rproc = to_rproc(dev);
> >
> >         if (option_is_read_only())
> >                 return -EINVAL;
> >
> >         if (sysfs_streq(buf, "enabled")) {
> >                 /* change the flag and begin the recovery process if needed */
> >                 rproc->recovery_disabled = false;
> >                 rproc_trigger_recovery(rproc);
> >         } else if (sysfs_streq(buf, "disabled")) {
> >                 rproc->recovery_disabled = true;
> >         } else if (sysfs_streq(buf, "recover")) {
> >                 /* begin the recovery process without changing the flag */
> >                 rproc_trigger_recovery(rproc);
> >         } else {
> >                 return -EINVAL;
> >         }
> >
> >         return count;
> > }
> >
> > Thanks,
> > Mathieu
> >
> > > +             mode = 0;
> 
> ^^ here we can put mode = 0444; for read-only.
> 
> > > +
> > > +     return mode;
> > > +}
> > > +
> > >  static struct attribute *rproc_attrs[] = {
> > >       &dev_attr_coredump.attr,
> > >       &dev_attr_recovery.attr,
> > > @@ -240,7 +255,8 @@ static struct attribute *rproc_attrs[] = {
> > >  };
> > >
> > >  static const struct attribute_group rproc_devgroup = {
> > > -     .attrs = rproc_attrs
> > > +     .attrs = rproc_attrs,
> > > +     .is_visible = rproc_is_visible,
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
> > >       size_t table_sz;
> > >       bool has_iommu;
> > >       bool auto_boot;
> > > +     bool deny_sysfs_ops;
> > >       struct list_head dump_segments;
> > >       int nb_vdev;
> > >       u8 elf_class;
> > > --
> > > 2.24.3
> > >
> 
> [1] https://patchwork.kernel.org/project/linux-remoteproc/patch/20201121030156.22857-3-s-anna@ti.com/
> 
> Thanks,
> Puranjay Mohan
