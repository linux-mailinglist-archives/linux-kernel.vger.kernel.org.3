Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9724A68E0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbiBBAAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiBBAAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:00:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F250C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:00:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so59373012eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqllxHt7yNoWu7VaWkakCDa1qzT4RpRcgjBmYDF5Djg=;
        b=d670fUvw0MYPj7AP65Zg5wsXk1t723UvfwdMSeF7nwsVXZuEUwKQyXRDkloAalyg5m
         PRDINzdmr+XKFP9yLKnHNhUpnZc9h/muYNaX9vqgUtS2ZIQZp3Lv3Hxzj/+Ajpa6NDlo
         vDTzfvl8TUIFgMTOil6NCqy2zrmyFmDr9V2gwGQ7qE9v21Z3XWlClovac0H21dI+5diu
         EcoCth1fIHjU0o+piYxzvyHP6xqXqhIVSR4Aot2aRIaUkpHkNzu0b8kyfVrUsUbaRaJw
         Eh6GfxAGRYJ9ZU7e5xW04WjXNH7GHYkKCNnrT8KTy4BXcjvHPYLeB3TP+bwWVULhswqQ
         eCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqllxHt7yNoWu7VaWkakCDa1qzT4RpRcgjBmYDF5Djg=;
        b=XySzfthS36NhzbFIK7iHxjh7SZYtILhnw+C3KEt6sXskhiImBadd/zokOS7a2f9+4+
         tbusn43BXupfRb2rwUTgMu1WQlD1Shu8UgaYauhLGS7ExoZkLRcoc1Al+kuYBi4/99EB
         0hNRt4Xvi8bcOUVqYJ4cOv5bbNYGqvEaqBePMeX/awiN53RhKAUk1kUEfztcvLlp/Q9l
         EjCfKxhL6YejsCGaIzMjtKvaKwaQsUBocp9/37gR8MYxNqSe+pfUQkr/NxyqHfJhIi3Z
         TaYPo3JwMDlQMx6I5enHFy7/Yb9wLeOfv0Wm4qtVuLuVcw8cXFomrBP0hNm1/+a6f/re
         NfnA==
X-Gm-Message-State: AOAM531lH2Lwaas4VMDPJIbZYkqPEtWTmf7EmGeBD19m4+/+3FPG3xkB
        LkZHZLXLvwrFNaBjJmPDorsZBgF0afsb84+XGS0=
X-Google-Smtp-Source: ABdhPJzkU+AoivYaiO+CIbSwtDKaKtKrGb1L6g/G7HKxp0CwA2yyfw4ai/4HM+r9lTmE2r5dHKmXjqmmtuLlzBb87Lg=
X-Received: by 2002:a17:907:d10:: with SMTP id gn16mr18527609ejc.652.1643760008830;
 Tue, 01 Feb 2022 16:00:08 -0800 (PST)
MIME-Version: 1.0
References: <6fc4a81f-1a13-bff9-7b2e-d5bec382cb42@synopsys.com> <9bab4777-3034-b789-fdf6-ca8d7e6a8c35@infradead.org>
In-Reply-To: <9bab4777-3034-b789-fdf6-ca8d7e6a8c35@infradead.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 1 Feb 2022 20:59:59 -0300
Message-ID: <CAOMZO5Aa4WxuadfoFGwwyYyD4UGPm-E258xTWU3-ozp_hwG-7g@mail.gmail.com>
Subject: Re: Kconfig CONFIG_FB dependency regression
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        John Youn <John.Youn@synopsys.com>,
        Bing Yuan <Bing.Yuan@synopsys.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On Tue, Feb 1, 2022 at 8:06 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/1/22 15:01, Thinh Nguyen wrote:
> > Hi,
> >
> > One of our test setups is unable to boot (stuck at initramfs). Git
> > bisection points to the commit below:
> >
> > f611b1e7624c ("drm: Avoid circular dependencies for CONFIG_FB")
> >
> > Reverting this patch resolves the issue. This issue persists in mainline
> > also. Unfortunately there isn't any meaningful log. Hopefully someone
> > can give some insight as to what could be the issue and revert/fix this
> > issue.
>
> Hi,
> Did you enable DRM_FBDEV_EMULATION?
> Please provide the failing .config file.

Does selecting CONFIG_FB=y help?

We had to manually select this option in imx_v6_v7_defconfig after f611b1e7624c.

Please see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.17-rc2&id=c54467482ffd407a4404c990697f432bfcb6cdc4
