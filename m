Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE10462939
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhK3ApQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:45:16 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42821 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhK3ApP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:45:15 -0500
Received: by mail-qt1-f175.google.com with SMTP id z9so18504418qtj.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXWcjgAmwn5xbsX3NCCgIGZffLmwwj4LxTmpgL7Kf/0=;
        b=xNS/gCuUMuZ1EA3kjzCzu5PLgQmSmihtwGoGmPZFb3aaRO7zvZ+pazC1Pfe3kFSxDo
         BEG2sZN06PBiX8q72DmDZ2MWeb2ZB24ohBBhJz556I0Ta2yYSdmpPqDnE72DrrrxzXOD
         2q24tW8VRuhh7leIDnhBIGH6OtXD8AVO5CNGLDX20jlxc3LkeG5clUmLom9+m136RplS
         gTUD62yf61LtqSp7Bl7w6OFq7Bj9mOLbY9Xd9W4a4pu6kEpv/2EBHnlK5zDgwe9ycG3U
         d2e4Eo2HIbSWtznSgCdJPYGzXgVIKx+GenIvdTkv2zceQLA33BwYjAUUFXpoLDF/+vgL
         aJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXWcjgAmwn5xbsX3NCCgIGZffLmwwj4LxTmpgL7Kf/0=;
        b=Dwe4glMLnKZQC/W9bTgP4EDtZzDmLW+r6qCcP+41ACM/Qo8MXHmwEgtgh71TVgdzI4
         xgINMRCBiKReHhPiRzucdSWrJTeImh8oHo2J7oy7A0iLy3LsaqILwjrvIRhKePCr6MWX
         UDopWUsXo4JTSpN7gypCkrSlehkdIwGloPBG0BCB4+UAyvwZlPiEA3AfwB/8XSl6y9TP
         4S6gHjHht4puoaNXY7xz8KL4Fd8whLQnLCcrsgTjumAe6vgKap+410rke85wX1z5Nxes
         QNy81/MIaYkPRZzP+VeWVO2KS8wD8VwG+2vT7sIsY98lVFI25gTDQzpnEkXunA/SnByY
         5Bgg==
X-Gm-Message-State: AOAM532p/Hdj28m7V701XhDoxAOcF8oVV8CRNpZJh/bnbXMaffd+irwt
        oVfdoeGPVQRXmz2gtoKRcyt5MCUiP99xhzwm1DRh5w==
X-Google-Smtp-Source: ABdhPJyAUQwjEkdsYtR8Jm+l0bDap4StYQuthd9DAH0ex8xf5HSvU0CC7+wDnsD9Mvd4CspgBFV88vRr4I21LngpP+I=
X-Received: by 2002:ac8:4e56:: with SMTP id e22mr48470079qtw.72.1638232856568;
 Mon, 29 Nov 2021 16:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20211126002612.1030246-1-dmitry.baryshkov@linaro.org> <CAGETcx-oBFSueaXZ1nypzS2DE06RrC5=QM25L+FvBrizvfZxvA@mail.gmail.com>
In-Reply-To: <CAGETcx-oBFSueaXZ1nypzS2DE06RrC5=QM25L+FvBrizvfZxvA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 30 Nov 2021 03:40:45 +0300
Message-ID: <CAA8EJprP79u9FO-vydsvoA+aqcZvN38TT8FwY8ow6cYxPnuK-g@mail.gmail.com>
Subject: Re: [PATCH] of: property: stop parsing remote-endpoint graph properties
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 02:45, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Nov 25, 2021 at 4:26 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > When parsing remote-endpoint properties, two counter devlinks will be
> > created, resulting in the circular dependency, which is later broken. In
> > most of the cases, the order in which depency is broken does not matter
> > (or is correct). However lately I stumbled upon the following
> > configuration.
> >
> > In this case for some reason devlink code decided to break the loop by
> > making panel depend on the bridge driver, enforcing that bridge is
> > probed before the panel.
>
> Let's find and fix the "for some reason" part then instead of just
> removing support for a property.

How can I help you to debug this? I can post the resulting device tree
or add debugging patches of your choice.

How is the cycle dependency broken? Is it done by removing a single
arc or by dropping all the arcs that form a cycle?
If the former is true, then we know the case: it sees a circular
dependency and just decides incorrectly, which arc should be dropped.

>
> > However in such cases the bridge will lookup next bridge or panel using
> > drm_of_find_panel_or_bridge() in the probe callback. Thus we have a
> > deadlock: panel is waiting for the bridge because of the devlink
> > dependency and bridge probe() expects the panel to be available and thus
> > returns -EPROBE_DEFER.
> >
> > To prevent such deadlocks, stop parsing the remote-endpoint property and
> > let drivers decide their probe order using standard -EPROBE_DEFER
> > returns.
>
> Nak.
>
> Removing support for a property will always be NAKed. Not because I
> care about one specific property. It's because fw_devlink needs to get
> the full view of the dependencies to be able to break cycles. The
> cycle detection and fixing logic has been improving steadily. So
> there's no reason to give up on it suddenly.

Regarding the remote-endpoint.

While I highly value the whole devlink idea and the way it
eases/streamlines device probing in typical dependency cases, I still
think that graph/remote-endpoint handling is not a proper way.

Current code handles remote-endpoint links in the same way as it
handles directional links does not look right. Generic code can not
predict, which side of bidirectional link is the primary side for the
link, checking for the existence of the counterpart, and which one is
a secondary side which just gets probed (and waits for the primary
part to find it). Always getting a circular dependency (for each graph
link) and always breaking should have the same result, as not getting
the circular dependency at all, Is this statement correct?

In fact I can predict that creating such extra dependencies can hide
actual dependencies between devices. Consider for example two devices
A and B, with a graph connection between A and B and another
dependency (for example, clocks or regulator supply) from A to B. How
will devlink handle such a case? Will it correctly determine that A
depends on B or will it break the cycle by removing both dependencies?

The MSM DRM driver employs several graphs, and things were very
fragile here. Dropping remote-endpoint parsing typically fixed those
extra dependency/devlink issues. So selecting between running with
fw_devlink turned off (to let the driver to bind at all) and just
disabling remote-endpoint parsing I'd choose the second option.

>
> -Saravana
>
> >
> > DTS except follows:
> >
> > / {
> >         panel0 {
> >                 compatible = "powertip,ph800480t013-idf02";
> >                 power-supply = <&vreg_l11c_3p3>;
> >                 backlight = <&lcd0_reg>;
> >                 port {
> >                         panel0_in: endpoint {
> >                                 remote-endpoint = <&bridge0_out>;
> >                         };
> >                 };
> >         };
> > };
> >
> > &dsi0 {
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >         status = "okay";
> >
> >         bridge@0 {
> >                 reg = <0>;
> >                 compatible = "toshiba,tc358762";
> >
> >                 ports {
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >
> >                         port@0 {
> >                                 reg = <0>;
> >                                 bridge0_in: endpoint {
> >                                         remote-endpoint = <&dsi0_out>;
> >                                 };
> >                         };
> >
> >                         port@1 {
> >                                 reg = <1>;
> >                                 bridge0_out: endpoint {
> >                                         remote-endpoint = <&panel0_in>;
> >                                 };
> >                         };
> >                 };
> >         };
> >         ports {
> >                 port@1 {
> >                         endpoint {
> >                                 remote-endpoint = <&bridge0_in>;
> >                                 data-lanes = <0 1 2 3>;
> >                         };
> >                 };
> >         };
> >
> > };
> >
> > Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/of/property.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index f7229e4030e3..83548076ee63 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1249,7 +1249,6 @@ static struct device_node *parse_##fname(struct device_node *np,       \
> >   * @parse_prop.index: For properties holding a list of phandles, this is the
> >   *                   index into the list
> >   * @optional: Describes whether a supplier is mandatory or not
> > - * @node_not_dev: The consumer node containing the property is never a device.
> >   *
> >   * Returns:
> >   * parse_prop() return values are
> > @@ -1261,7 +1260,6 @@ struct supplier_bindings {
> >         struct device_node *(*parse_prop)(struct device_node *np,
> >                                           const char *prop_name, int index);
> >         bool optional;
> > -       bool node_not_dev;
> >  };
> >
> >  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
> > @@ -1285,7 +1283,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
> >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > @@ -1388,7 +1385,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
> >         { .parse_prop = parse_pinctrl6, },
> >         { .parse_prop = parse_pinctrl7, },
> >         { .parse_prop = parse_pinctrl8, },
> > -       { .parse_prop = parse_remote_endpoint, .node_not_dev = true, },
> >         { .parse_prop = parse_pwms, },
> >         { .parse_prop = parse_resets, },
> >         { .parse_prop = parse_leds, },
> > @@ -1437,9 +1433,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
> >                 while ((phandle = s->parse_prop(con_np, prop_name, i))) {
> >                         struct device_node *con_dev_np;
> >
> > -                       con_dev_np = s->node_not_dev
> > -                                       ? of_get_compat_node(con_np)
> > -                                       : of_node_get(con_np);
> > +                       con_dev_np = of_node_get(con_np);
> >                         matched = true;
> >                         i++;
> >                         of_link_to_phandle(con_dev_np, phandle);
> > --
> > 2.33.0
> >

-- 
With best wishes
Dmitry
