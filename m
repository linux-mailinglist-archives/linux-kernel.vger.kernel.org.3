Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6160A462886
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhK2Xsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhK2Xsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:48:53 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A263BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:45:35 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v138so47090946ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxXr7NzoOaAEG2HqFzsFUv+olwI5UjMu/0Q0OMgMWIA=;
        b=PMpQ/AlVcXnmaj6em4Tnt7KBFtx5l0luWo9PlCtHeCzk28LsUG5BYnHs1J0r68pHqO
         33ImPWHHhFVeUO0aG6Fo2tQGkSCW53lqBMABgFDSNApQu6zEEdpn2FxFuUWFHg4A26p1
         owAEb5WaKi6z4j5pU6Up3nX73NdRvZiRuyOYY8Ay3Pw9hZSUjzQ7KkIQw3hoWeKCD0SY
         Sq3xfrq4b3ppN85tZFassMkP6Ac3dJ0Wvg3zzXs+1bIky+Pesay+pWpa7wC2vY8Vmfps
         L58mH2GrEa3r0XnNOdNIGrW/Use766GfU2kSz370F5sZ1PkBuY7S2psMz1xZhjK/bcAU
         TfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxXr7NzoOaAEG2HqFzsFUv+olwI5UjMu/0Q0OMgMWIA=;
        b=10+RKX2M+l2SjVfeZ6OJoZmcDE6AinLmxhsDVw8QOo2wg48OtZfglebBBM9bQ19dDp
         PRfZM6L2LndaXVJlTtlp79+m3EjYpsp8tbNtivpC4IPif+altsPOKakOejsl8vnTOR6U
         afw917wCOV4XQBq7uF9eE4CGWNbvIJ7oO7R9U+DuFXtxuXyUseusuEE5nn+qopz1PjvF
         HjE9fzOdj6ull8rOQdzz/NMVzUyeDoJM01c+KrH5+VwxleEl/Olr8UcomyrloOj4sTKa
         sO3T+arZhR5Gc6o4Ai+JutKhKcuZnNhyaIW2D/wC7vNmCl728hUhqmVcAOn1rVlCDnU5
         lONQ==
X-Gm-Message-State: AOAM532NJjfZG/mSnS2nImxDKMk9eV/HmCu4QX7RCuYlat8b0LBaH5I4
        Sq7xJGM385+10Enbc1s6h59GBPHk7pmmfeZDssGzlQ==
X-Google-Smtp-Source: ABdhPJyPK5nbiFI2zf0yQIuvaSfU0KS8zzd9EXj7FavCPWv3Ufk9qPokAeFlb5O92v+ZbU/Xh8CTY7wGSWFQ5kBKoVI=
X-Received: by 2002:a25:2d67:: with SMTP id s39mr39913718ybe.140.1638229534696;
 Mon, 29 Nov 2021 15:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20211126002612.1030246-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20211126002612.1030246-1-dmitry.baryshkov@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Nov 2021 15:44:58 -0800
Message-ID: <CAGETcx-oBFSueaXZ1nypzS2DE06RrC5=QM25L+FvBrizvfZxvA@mail.gmail.com>
Subject: Re: [PATCH] of: property: stop parsing remote-endpoint graph properties
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

On Thu, Nov 25, 2021 at 4:26 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> When parsing remote-endpoint properties, two counter devlinks will be
> created, resulting in the circular dependency, which is later broken. In
> most of the cases, the order in which depency is broken does not matter
> (or is correct). However lately I stumbled upon the following
> configuration.
>
> In this case for some reason devlink code decided to break the loop by
> making panel depend on the bridge driver, enforcing that bridge is
> probed before the panel.

Let's find and fix the "for some reason" part then instead of just
removing support for a property.

> However in such cases the bridge will lookup next bridge or panel using
> drm_of_find_panel_or_bridge() in the probe callback. Thus we have a
> deadlock: panel is waiting for the bridge because of the devlink
> dependency and bridge probe() expects the panel to be available and thus
> returns -EPROBE_DEFER.
>
> To prevent such deadlocks, stop parsing the remote-endpoint property and
> let drivers decide their probe order using standard -EPROBE_DEFER
> returns.

Nak.

Removing support for a property will always be NAKed. Not because I
care about one specific property. It's because fw_devlink needs to get
the full view of the dependencies to be able to break cycles. The
cycle detection and fixing logic has been improving steadily. So
there's no reason to give up on it suddenly.

-Saravana

>
> DTS except follows:
>
> / {
>         panel0 {
>                 compatible = "powertip,ph800480t013-idf02";
>                 power-supply = <&vreg_l11c_3p3>;
>                 backlight = <&lcd0_reg>;
>                 port {
>                         panel0_in: endpoint {
>                                 remote-endpoint = <&bridge0_out>;
>                         };
>                 };
>         };
> };
>
> &dsi0 {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         status = "okay";
>
>         bridge@0 {
>                 reg = <0>;
>                 compatible = "toshiba,tc358762";
>
>                 ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>
>                         port@0 {
>                                 reg = <0>;
>                                 bridge0_in: endpoint {
>                                         remote-endpoint = <&dsi0_out>;
>                                 };
>                         };
>
>                         port@1 {
>                                 reg = <1>;
>                                 bridge0_out: endpoint {
>                                         remote-endpoint = <&panel0_in>;
>                                 };
>                         };
>                 };
>         };
>         ports {
>                 port@1 {
>                         endpoint {
>                                 remote-endpoint = <&bridge0_in>;
>                                 data-lanes = <0 1 2 3>;
>                         };
>                 };
>         };
>
> };
>
> Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/of/property.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index f7229e4030e3..83548076ee63 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1249,7 +1249,6 @@ static struct device_node *parse_##fname(struct device_node *np,       \
>   * @parse_prop.index: For properties holding a list of phandles, this is the
>   *                   index into the list
>   * @optional: Describes whether a supplier is mandatory or not
> - * @node_not_dev: The consumer node containing the property is never a device.
>   *
>   * Returns:
>   * parse_prop() return values are
> @@ -1261,7 +1260,6 @@ struct supplier_bindings {
>         struct device_node *(*parse_prop)(struct device_node *np,
>                                           const char *prop_name, int index);
>         bool optional;
> -       bool node_not_dev;
>  };
>
>  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
> @@ -1285,7 +1283,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
>  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
>  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
>  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> @@ -1388,7 +1385,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_pinctrl6, },
>         { .parse_prop = parse_pinctrl7, },
>         { .parse_prop = parse_pinctrl8, },
> -       { .parse_prop = parse_remote_endpoint, .node_not_dev = true, },
>         { .parse_prop = parse_pwms, },
>         { .parse_prop = parse_resets, },
>         { .parse_prop = parse_leds, },
> @@ -1437,9 +1433,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
>                 while ((phandle = s->parse_prop(con_np, prop_name, i))) {
>                         struct device_node *con_dev_np;
>
> -                       con_dev_np = s->node_not_dev
> -                                       ? of_get_compat_node(con_np)
> -                                       : of_node_get(con_np);
> +                       con_dev_np = of_node_get(con_np);
>                         matched = true;
>                         i++;
>                         of_link_to_phandle(con_dev_np, phandle);
> --
> 2.33.0
>
