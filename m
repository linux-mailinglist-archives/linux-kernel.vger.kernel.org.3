Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118324ACC1A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbiBGWiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiBGWit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:38:49 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A278C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:38:48 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cn6so10669513edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQTLwdFqZWSPqjLuZ8bkwP4E9IYeu/IAczrgRf3hPDw=;
        b=tYGYk22m9UeQuMH+SOtxtZdnWjU50/aae2zy5xxBcRoknaz7Xzfkkuj2OL1fmyyOXn
         0zeeGZgqnuVZVSmz4D/MoUlBCefNnle65bOBen4zy+RdU9FCwdGjGmqQ28CxgX2CFM1l
         6J8425xrAchHuiKWY2GLaqwBNI1Sd7ZNBiwYGUDPKVEmMBFu2u+tpomcgKUEgrzQ13Yn
         Jp/nnbwfByo981IT0pP98vo3ezYyXcOnVTMTw9xOtzRu+cKfr7+qdR5BwEhIe4OLi0tO
         DmHxzP1WDutEdChT4QLCopeRGOwHI2H2LQK9hIgrFTr3v0EOxTydDsiqY3EOcDOduaWo
         GNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQTLwdFqZWSPqjLuZ8bkwP4E9IYeu/IAczrgRf3hPDw=;
        b=sus37SX08EY1aKiH2SKdG+RKV8ZPa7LGtmHiOz8gVOjzj+Dzyelm3c+exl+pM0A/65
         0np/4353VlZp62ImnXvkkFrC3pRaCZ7ILbZU+64xQvDLF+JSJjmYGJxK208uxXYB5HtQ
         9/I+I4DrdBd2/Ylq6OyeGMbRaSXpye75jBlewY/0HtvYBQgTqdyOAV4rnWuiBCsAKjmd
         WyB0mvtTDCH/BKMb9+PN4lBT770vETQvCKezaqd70m7Qb84GJCDc7V0mbqhafSwwHBSK
         Bo023SCdQcvIgyEPgUNy3xaTuViN/nc9w8HMawBarLjx0lZWkbYFiODkiErbq8yRR7nN
         sd1g==
X-Gm-Message-State: AOAM532bUat+uVQ7ytPm7+837IgoQKS1ZF84EXQ3gIpV6DxFNznMmAxc
        3N1ueub9b4xWJzjU3q+Mas65V1KjrL+D+Wz+rFkrK/MwLQw=
X-Google-Smtp-Source: ABdhPJzkb/peMR69wwqjZgqUcG4uDjwOmmVlLy04NjOMGG3AyXhtxXbm50gQme61S6vzMEmIiXNJ0Lny66ufWYhgmZg=
X-Received: by 2002:a50:ee16:: with SMTP id g22mr1629536eds.434.1644273526659;
 Mon, 07 Feb 2022 14:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20220207043907.2758424-1-badhri@google.com> <YgDk8M3N8VEZK5Sk@kuha.fi.intel.com>
In-Reply-To: <YgDk8M3N8VEZK5Sk@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 7 Feb 2022 14:38:09 -0800
Message-ID: <CAPTae5KG5iJSkB352KnUwtp741kFocnugfqHGKvtGzRTCPeP2w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] usb: typec: Introduce typec attributes for
 limiting source current
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>, Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 1:23 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> +Benson
>
> On Sun, Feb 06, 2022 at 08:39:06PM -0800, Badhri Jagan Sridharan wrote:
> > This change introduces the following two attributes to the
> > typec sysfs class which allows userspace to limit the power
> > advertised while acting as source. This is useful to mitigate
> > battery drain in portable devices when the battery SOC is low.
> >
> > New attibutes introduced:
> > 1. limit_src_current_active
> > 2. limit_src_current_ma
> >
> > The port while in PD contract and acting as source would
> > only advertise vSafe5V fixed PDO with current set through
> > limit_src_current_ma when limit_src_current_active is set
> > to 1. When limit_src_current_active is set to 0, the port
> > would publish the default source capabilities.
> > limit_src_current_ma would limit the current to the
> > Maximum current published by vSafe5V fixed pdo of the default
> > source capabilities of the port.
>
> This competes with Benson's idea of having "sets" of capabilites from
> which to choose the ones that we advertise to the partner. You could
> also use that idea to cover this case as well. You just have two
> source capabilities sets defined - one where you only have the vSafe5V
> and another for everything.

Agree. I was actually wondering whether there were any follow-ups for
the proposal.
Happy to make use of the interface additions that you are exposing through your
patchset.  Thanks for sending them out !

>
> Benson's idea also seems to be something what we can support with UCSI
> and some native USB PD controller host interfaces, but limiting the
> source capabitites to only vSafe5V is something that we can't do. I
> means, on some platforms we may have a source capabilities "set" that
> we can choose that only exposes the vSafe5V, but there is no guarantee
> that we always have it (and it's unlikely that we ever have it). It's
> up to some firmware that we have no control over.

Given that all pd sources should
mandatorily support vSafe5V and the patch only "reduces" the maximum
current exposed by default, there are no new additional capabilities
that the source
should support. So not sure why this would be not supportable though.

>
> So this is the wrong way and Benson's idea is the right way IMO.
>
> I already prepared a proposal for adding support for Benson's idea:
> https://lore.kernel.org/linux-usb/20220203144657.16527-1-heikki.krogerus@linux.intel.com/
>
> This patch adds the attributes that you can use to choose the
> capabilities that are advertised to the partner:
> https://lore.kernel.org/linux-usb/20220203144657.16527-3-heikki.krogerus@linux.intel.com/
>
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-typec | 25 ++++++
> >  drivers/usb/typec/class.c                   | 99 +++++++++++++++++++++
> >  drivers/usb/typec/class.h                   |  5 ++
> >  include/linux/usb/typec.h                   |  4 +
> >  4 files changed, 133 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > index 75088ecad202..dd2240632172 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -141,6 +141,31 @@ Description:
> >               - "reverse": CC2 orientation
> >               - "unknown": Orientation cannot be determined.
> >
> > +What:                /sys/class/typec/<port>/limit_src_current_active
> > +Date:                February 2022
> > +Contact:     Badhri Jagan Sridharan <badhri@google.com>
> > +Description:
> > +             This attribute can be used to make the port only publish
> > +             vSafe5V fixed pdo with Maximum current limited to the
> > +             current limit set by limit_src_current_ma when the port
> > +             is acting as source.
> > +             Valid values:
> > +             - write(2) "1" limits source capabilities to vSafe5V
> > +               with max current specified by limit_src_current_ma
> > +             - write(2) "0" publishes the default source capabilities
> > +               of the port.
> > +
> > +What:                /sys/class/typec/<port>/limit_src_current_ma
> > +Date:                February 2022
> > +Contact:     Badhri Jagan Sridharan <badhri@google.com>
> > +Description:
> > +             This attribute allows write(2) to set the Maximum
> > +             current published when limit_src_current_active is set
> > +             to 1. When limit_src_current_active is already set
> > +             to 1, if the port is already acting as source with
> > +             explicit contract in place, write(2) will make the port
> > +             renegotiate the pd contract.
> > +
> >  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
> >
> >  What:                /sys/class/typec/<port>-partner/accessory_mode
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 45a6f0c807cb..3b3c7b080ad1 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -1403,6 +1403,102 @@ port_type_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RW(port_type);
> >
> > +static ssize_t
> > +limit_src_current_active_store(struct device *dev, struct device_attribute *attr, const char *buf,
> > +                            size_t size)
> > +{
> > +     struct typec_port *port = to_typec_port(dev);
> > +     int ret;
> > +     u8 active;
> > +
> > +     if (port->cap->type == TYPEC_PORT_SNK || !port->ops || !port->ops->limit_src_current_set ||
> > +         !port->cap->pd_revision) {
> > +             dev_dbg(dev, "Limiting source current not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (kstrtou8(buf, 0, &active))
> > +             return -EINVAL;
> > +
> > +     if (active != 1 && active != 0)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&port->limit_src_current_lock);
> > +
> > +     if (port->limit_src_current_active == (bool)active) {
> > +             ret = size;
> > +             goto unlock_and_ret;
> > +     }
> > +
> > +     ret = port->ops->limit_src_current_set(port, port->limit_src_current_ma, active);
> > +     if (ret)
> > +             goto unlock_and_ret;
> > +
> > +     port->limit_src_current_active = active;
> > +     ret = size;
> > +
> > +unlock_and_ret:
> > +     mutex_unlock(&port->limit_src_current_lock);
> > +     return ret;
> > +}
> > +
> > +static ssize_t
> > +limit_src_current_active_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct typec_port *port = to_typec_port(dev);
> > +
> > +     return sysfs_emit(buf, "%d\n", port->limit_src_current_active ? 1 : 0);
> > +}
> > +static DEVICE_ATTR_RW(limit_src_current_active);
> > +
> > +static ssize_t
> > +limit_src_current_ma_store(struct device *dev, struct device_attribute *attr, const char *buf,
> > +                        size_t size)
> > +{
> > +     struct typec_port *port = to_typec_port(dev);
> > +     int ret;
> > +     u32 src_current_ma;
> > +
> > +     if (port->cap->type == TYPEC_PORT_SNK || !port->ops || !port->ops->limit_src_current_set ||
> > +         !port->cap->pd_revision) {
> > +             dev_dbg(dev, "Limiting source current not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (kstrtou32(buf, 0, &src_current_ma))
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&port->limit_src_current_lock);
> > +
> > +     if (port->limit_src_current_ma == src_current_ma) {
> > +             ret = size;
> > +             goto unlock_and_ret;
> > +     }
> > +
> > +     if (port->limit_src_current_active) {
> > +             ret = port->ops->limit_src_current_set(port, src_current_ma,
> > +                                                    port->limit_src_current_active);
> > +             if (ret)
> > +                     goto unlock_and_ret;
> > +     }
> > +
> > +     port->limit_src_current_ma = src_current_ma;
> > +     ret = size;
> > +
> > +unlock_and_ret:
> > +     mutex_unlock(&port->limit_src_current_lock);
> > +     return ret;
> > +}
> > +
> > +static ssize_t
> > +limit_src_current_ma_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct typec_port *port = to_typec_port(dev);
> > +
> > +     return sysfs_emit(buf, "%u\n", port->limit_src_current_ma);
> > +}
> > +static DEVICE_ATTR_RW(limit_src_current_ma);
> > +
> >  static const char * const typec_pwr_opmodes[] = {
> >       [TYPEC_PWR_MODE_USB]    = "default",
> >       [TYPEC_PWR_MODE_1_5A]   = "1.5A",
> > @@ -1536,6 +1632,8 @@ static struct attribute *typec_attrs[] = {
> >       &dev_attr_vconn_source.attr,
> >       &dev_attr_port_type.attr,
> >       &dev_attr_orientation.attr,
> > +     &dev_attr_limit_src_current_active.attr,
> > +     &dev_attr_limit_src_current_ma.attr,
> >       NULL,
> >  };
> >
> > @@ -2039,6 +2137,7 @@ struct typec_port *typec_register_port(struct device *parent,
> >
> >       ida_init(&port->mode_ids);
> >       mutex_init(&port->port_type_lock);
> > +     mutex_init(&port->limit_src_current_lock);
> >
> >       port->id = id;
> >       port->ops = cap->ops;
> > diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> > index 0f1bd6d19d67..3856bc058444 100644
> > --- a/drivers/usb/typec/class.h
> > +++ b/drivers/usb/typec/class.h
> > @@ -54,6 +54,11 @@ struct typec_port {
> >
> >       const struct typec_capability   *cap;
> >       const struct typec_operations   *ops;
> > +
> > +     /* lock to protect limit_src_current_*_store operation */
> > +     struct mutex                    limit_src_current_lock;
> > +     u32                             limit_src_current_ma;
> > +     bool                            limit_src_current_active;
> >  };
> >
> >  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
> > diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> > index 7ba45a97eeae..1b1958ae4c16 100644
> > --- a/include/linux/usb/typec.h
> > +++ b/include/linux/usb/typec.h
> > @@ -213,6 +213,8 @@ struct typec_partner_desc {
> >   * @pr_set: Set Power Role
> >   * @vconn_set: Source VCONN
> >   * @port_type_set: Set port type
> > + * @limit_src_current_set: Used to limit source current advertisement while
> > + *                         acting as source
> >   */
> >  struct typec_operations {
> >       int (*try_role)(struct typec_port *port, int role);
> > @@ -221,6 +223,8 @@ struct typec_operations {
> >       int (*vconn_set)(struct typec_port *port, enum typec_role role);
> >       int (*port_type_set)(struct typec_port *port,
> >                            enum typec_port_type type);
> > +     int (*limit_src_current_set)(struct typec_port *port, u32 limit_src_current_ma,
> > +                                  bool enable);
> >  };
> >
> >  enum usb_pd_svdm_ver {
> > --
> > 2.35.0.263.gb82422642f-goog
>
> --
> heikki
