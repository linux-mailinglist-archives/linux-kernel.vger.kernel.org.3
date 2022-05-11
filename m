Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA9523328
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiEKMaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiEKMaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:30:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3252C1FD84C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:30:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1945709pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBRCoEP/+2DHYjRmdpNdJIwofRuvC4FzvpLJBIcQx4c=;
        b=V+UqE7jFMfemCYe6fqVeCWSSkaRSL/NNy9qTMkO3tGoV3UM0Ygz6wTW5ynBiuE+vpP
         bPHYA3q1/YZU6fjAJeu+JHRnpejPu2FX1YWdkqU1u1pQ82sWqq5iI3YedK9GzigcmWbM
         zGBsz+GFHnWiijHVTe/FJBh3uMezUeLmQ4WUO9W3nQiGqE/9JPp7x1eD0X5rB86XmypM
         eF8U0bOX9qCjYOGkdwAqXtRyKom0kk/dLnjyGFP8tNtgItNLKCyVSvUwlfvCkm+Siffe
         SF2qsN5JoMlOeO8wwZJUIqwdUaaE8WveNRu5axjM1t6BSAGglHQmcjVrzLVR4LwFMLZL
         CEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBRCoEP/+2DHYjRmdpNdJIwofRuvC4FzvpLJBIcQx4c=;
        b=jYCk7FiygT4QnpuCw3lg2djinGgdmFoUGumzyCWyleQSO9/OQUxp7IXiIWsOdXFSkE
         3/qQyP5eoX73xGEvoqcJScQaWAJBP1hxqcdlFbn4H0NMl6qnaCZcqfFW0I2PoZfXufKc
         6MoY9hZ4tqTa1icQcWLvdFeRb1OsvYZ2KBoiNuvcepCEKsw9kGhJVUy9+IMrWjHqieee
         cYlmBP7d/+WA/oys4sZ/Rsla/YN9BMx81J3QtGBMcIvUehGDCojtJqmLEUKURIh84foR
         nqM6qgJAuExfJOJo8l6v80zBeGGIstO4TW3voWV2FBudTA9SV/9HPy1xtn1wJE5mbUAS
         w0ZQ==
X-Gm-Message-State: AOAM533PtkSTIWyCN8qrVvAavz2i3bT7OyEXZBHN2NSJ3KZsaaRnbprD
        ggQOwoxgnaJaU4mQKNiF5bDCryspo9G0jIdcFTCkOD2oGmZQCQ==
X-Google-Smtp-Source: ABdhPJzO0xNkKldihTa/WVWQmSOdqiFdCkhNT2BDuc4Y/2xN5Uz06s5JFqS6bjltl+Xm+zOe+uWsslDCo61QPV7/Fyg=
X-Received: by 2002:a17:902:d58a:b0:15f:2073:b58b with SMTP id
 k10-20020a170902d58a00b0015f2073b58bmr9599341plh.65.1652272217565; Wed, 11
 May 2022 05:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220411140606.15654-1-jpawar@cadence.com>
In-Reply-To: <20220411140606.15654-1-jpawar@cadence.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 11 May 2022 14:30:06 +0200
Message-ID: <CAG3jFytUcN5844DnJgb-ee5pcetoWqzsByosMPfT7YMUvs4M8w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: cdns-dsi: Add support for pre_enable and
 post_enable control functions.
To:     Jayshri Pawar <jpawar@cadence.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@linux.ie,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, linux-kernel@vger.kernel.org,
        mparab@cadence.com, sjakhade@cadence.com, nm@ti.com,
        yogeshs@ti.com, kishon@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 at 16:07, Jayshri Pawar <jpawar@cadence.com> wrote:
>
> From: jpawar <jpawar@cadence.com>

This should be "Jayshri Pawar <jpawar@cadence.com>"

>
> Add support for pre_enable and post_enable drm bridge control functions.
> Making sure that host to be prepared before panel is powered up,
> for the panels like TC358762.
>
> Signed-off-by: jpawar <jpawar@cadence.com>

Again, your full name should be used.

> ---
>  drivers/gpu/drm/bridge/cdns-dsi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index 829e1a144656..20bece84ff8c 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -462,6 +462,7 @@ struct cdns_dsi {
>         struct reset_control *dsi_p_rst;
>         struct clk *dsi_sys_clk;
>         bool link_initialized;
> +       bool phy_initialized;
>         struct phy *dphy;
>  };
>
> @@ -711,11 +712,21 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
>         pm_runtime_put(dsi->base.dev);
>  }
>
> +static void cdns_dsi_bridge_post_disable(struct drm_bridge *bridge)
> +{
> +       struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> +       struct cdns_dsi *dsi = input_to_dsi(input);
> +
> +       pm_runtime_put(dsi->base.dev);
> +}
> +
>  static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
>  {
>         struct cdns_dsi_output *output = &dsi->output;
>         u32 status;
>
> +       if (dsi->phy_initialized)
> +               return;
>         /*
>          * Power all internal DPHY blocks down and maintain their reset line
>          * asserted before changing the DPHY config.
> @@ -739,6 +750,7 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
>         writel(DPHY_CMN_PSO | DPHY_ALL_D_PDN | DPHY_C_PDN | DPHY_CMN_PDN |
>                DPHY_D_RSTB(output->dev->lanes) | DPHY_C_RSTB,
>                dsi->regs + MCTL_DPHY_CFG0);
> +       dsi->phy_initialized = true;
>  }
>
>  static void cdns_dsi_init_link(struct cdns_dsi *dsi)
> @@ -914,11 +926,25 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
>         writel(tmp, dsi->regs + MCTL_MAIN_EN);
>  }
>
> +static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> +{
> +       struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> +       struct cdns_dsi *dsi = input_to_dsi(input);
> +
> +       if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
> +               return;
> +
> +       cdns_dsi_init_link(dsi);
> +       cdns_dsi_hs_init(dsi);
> +}
> +
>  static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
>         .attach = cdns_dsi_bridge_attach,
>         .mode_valid = cdns_dsi_bridge_mode_valid,
>         .disable = cdns_dsi_bridge_disable,
> +       .pre_enable = cdns_dsi_bridge_pre_enable,
>         .enable = cdns_dsi_bridge_enable,
> +       .post_disable = cdns_dsi_bridge_post_disable,
>  };
>
>  static int cdns_dsi_attach(struct mipi_dsi_host *host,

Cadence seems to have DKIM mail server failure, which is preventing b4
from importing this patch. Log attached below.

I've manually fixed this author string issues.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.


----

Checking attestation on all messages, may take a moment...
Traceback (most recent call last):
  File "/usr/bin/b4", line 33, in <module>
    sys.exit(load_entry_point('b4==0.8.0', 'console_scripts', 'b4')())
  File "/usr/lib/python3/dist-packages/b4/command.py", line 246, in cmd
    cmdargs.func(cmdargs)
  File "/usr/lib/python3/dist-packages/b4/command.py", line 51, in cmd_am
    b4.mbox.main(cmdargs)
  File "/usr/lib/python3/dist-packages/b4/mbox.py", line 593, in main
    make_am(msgs, cmdargs, msgid)
  File "/usr/lib/python3/dist-packages/b4/mbox.py", line 92, in make_am
    am_msgs = lser.get_am_ready(noaddtrailers=cmdargs.noaddtrailers,
  File "/usr/lib/python3/dist-packages/b4/__init__.py", line 523, in
get_am_ready
    checkmark, trailers, attcrit =
lmsg.get_attestation_trailers(attpolicy, maxdays)
  File "/usr/lib/python3/dist-packages/b4/__init__.py", line 1173, in
get_attestation_trailers
    for attestor in self.attestors:
  File "/usr/lib/python3/dist-packages/b4/__init__.py", line 1028, in attestors
    self._load_dkim_attestors()
  File "/usr/lib/python3/dist-packages/b4/__init__.py", line 1071, in
_load_dkim_attestors
    res = dkim.verify(self.msg.as_bytes(), logger=dkimlogger)
  File "/usr/lib/python3/dist-packages/dkim/__init__.py", line 1352, in verify
    return d.verify(dnsfunc=dnsfunc)
  File "/usr/lib/python3/dist-packages/dkim/__init__.py", line 940, in verify
    return self.verify_sig(sig, include_headers, sigheaders[idx], dnsfunc)
  File "/usr/lib/python3/dist-packages/dkim/__init__.py", line 773, in
verify_sig
    self.pk, self.keysize, self.ktag, self.seqtlsrpt = load_pk_from_dns(name,
  File "/usr/lib/python3/dist-packages/dkim/__init__.py", line 481, in
load_pk_from_dns
    s = dnsfunc(name, timeout=timeout)
  File "/usr/lib/python3/dist-packages/dkim/dnsplug.py", line 88, in get_txt
    txt = _get_txt(unicode_name, timeout)
  File "/usr/lib/python3/dist-packages/dkim/dnsplug.py", line 31, in
get_txt_dnspython
    a = dns.resolver.query(name,
dns.rdatatype.TXT,raise_on_no_answer=False, lifetime=timeout)
  File "/usr/lib/python3/dist-packages/dns/resolver.py", line 1321, in query
    return resolve(qname, rdtype, rdclass, tcp, source,
  File "/usr/lib/python3/dist-packages/dns/resolver.py", line 1305, in resolve
    return get_default_resolver().resolve(qname, rdtype, rdclass, tcp, source,
  File "/usr/lib/python3/dist-packages/dns/resolver.py", line 1176, in resolve
    timeout = self._compute_timeout(start, lifetime)
  File "/usr/lib/python3/dist-packages/dns/resolver.py", line 997, in
_compute_timeout
    raise Timeout(timeout=duration)
dns.exception.Timeout: The DNS operation timed out after
5.402302026748657 seconds
