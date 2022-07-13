Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB865735F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiGMMC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiGMMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:02:25 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC6F4239
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:02:24 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id u13so6516161iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLHlcD1BbkSesfBNiOV7YrrSdYxCd45IacaClX538P8=;
        b=FuYVlgPktz9Me7uksXbfDI7RUzuvebE4l+KRaDjErf9W40BWskp58/1UBPGB03R7GK
         x3yRxchO7XxZJk6dF/fN/sjLqn2MdgM9B6B6XNEhRFChkZoP0ebFbpSPpxphIDzahoNY
         oBIXxRrjgGlu6nfmogxuHBwayX/9h/Sry94B6FSM4Xr9WkAQPh/IyaFMoyOw6rehgjSz
         aWy9ZabK7rbif7ZaJ1ZTSeYG2Ud6/gKWP68rbDB6qZ8xiKkYL48dVYgTzMWoupl0PedM
         UBb442k3MaLaEFQgrX3DM5UVorPsoDU5p1EdISuUpPuy7mXLTM0T9kycsywGBnwhsTHW
         YcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLHlcD1BbkSesfBNiOV7YrrSdYxCd45IacaClX538P8=;
        b=U3GP8bZD2kTrJ1saDAdZrpdZ2YtJv695HBxwd1A+Hx3hRpylSUironCVP9zFPA+YZq
         vvM1UQA0YSxvVlEig9e8nzBFdTzmViccDOKHnNDxqANos4LQo3qxB3k2X+S+Fue/7U0s
         441FIliJ0uBD9ClOkYeQmyMTMnWDLwjsWu35mPVelUHCHrHhqVXbGAMLlKqK+50CYUIV
         mV9wEnk1XyIU/kKVLjXrohMZXx1m0/L0SE2o6LrPDwsaKJg1uYoSU8MInUDu1gvEtpn/
         Y1AAScBNnJIXU2U4l/ro+fe2mT1FBtoOKtXsHjNNPS51eGO4xbWDHrWI7olRKco0oIFx
         t5GQ==
X-Gm-Message-State: AJIora8t376U+X0BGEvxltLLAKxmd7r8ErPqSIsJv9dtshDGIWJRRd27
        36ayM1rcNyt9prFYT7+gXf8dYLNRB91K2/ewUQbJ+w==
X-Google-Smtp-Source: AGRyM1vzGnXMOueDPW7R9FdHXd7YskMys/eG99n7Q+joGp2dqTInmorSDef9SKArvVCV3S9SNR+0Ugv7B/RlfhV/bRA=
X-Received: by 2002:a05:6e02:18c7:b0:2dc:404a:8416 with SMTP id
 s7-20020a056e0218c700b002dc404a8416mr1594696ilu.39.1657713744347; Wed, 13 Jul
 2022 05:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220705171649.969194-1-hsinyi@chromium.org>
In-Reply-To: <20220705171649.969194-1-hsinyi@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 14:01:47 +0200
Message-ID: <CAPDyKFq1KLYEo9jtN4j-=+sRoYtb0su5LzcErEWAtTxEKEF-mA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: domains: Ensure genpd_debugfs_dir exists before remove
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 at 19:17, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Both genpd_debug_add() and genpd_debug_remove() may be called
> indirectly by other drivers while genpd_debugfs_dir is not yet
> set. For example, drivers can call pm_genpd_init() in probe or
> pm_genpd_init() in probe fail/cleanup path:
>
> pm_genpd_init()
>  --> genpd_debug_add()
>
> pm_genpd_remove()
>  --> genpd_remove()
>    --> genpd_debug_remove()
>
> At this time, genpd_debug_init() may not yet be called.
>
> genpd_debug_add() checks that if genpd_debugfs_dir is NULL, it
> will return directly. Make sure this is also checked
> in pm_genpd_remove(), otherwise components under debugfs root
> which has the same name as other components under pm_genpd may
> be accidentally removed, since NULL represents debugfs root.
>
> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v1->v2: Add more context in commit message
> ---
>  drivers/base/power/domain.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3e86772d5fac5..5a2e0232862e0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
>  {
>         struct dentry *d;
>
> +       if (!genpd_debugfs_dir)
> +               return;
> +
>         d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
>         debugfs_remove(d);
>  }
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
