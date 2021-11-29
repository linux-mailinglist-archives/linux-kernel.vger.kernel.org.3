Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAD4623D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhK2WBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhK2V7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:59:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E3C061A13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 11:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CEFDB815CE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 19:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF6CC53FAD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638214187;
        bh=ejZQQUbAl2en4OrZqhaRxXhMmoxR9zvdS59nSPLP1lM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YY3PaMlXoLBrfESQjX8RQcxceb1iKcgznBZeWMsye+WZkbvi/rsd5ELkuahHrN94Q
         HUDk110IP+mKnEEh+GbaT8VVe/9V2/YGV7iMuMXjR/0Et35wAMl0lKFX9fItDovgZW
         AlJE4Zaayru1SgxbPZgF3aBBsJL1wsNx5e0OXVH3lQ13F4soymFWDRJw+3kIDE8R4z
         +y/qvIbncJz6njH461bxnOn4iIuXBzRMGZixCkuAAfwbwV0+LM9ctFSQ6Dr3s4lfSk
         wGy4G8Hbh+jg/jQrkYxHEwejO9YPIVrCLubB5E+JBujDktni1sEt1uCxKJMWoKJp+/
         Pl9xCOde80Tqw==
Received: by mail-ed1-f41.google.com with SMTP id x6so76171181edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 11:29:47 -0800 (PST)
X-Gm-Message-State: AOAM533svlvZk4LBJNJNsZWmdqjRf5EVU88pCpmJ8pt13HT0Ix3ZW12J
        8SoaWHfhl5UGNyMdh5RJxQwhZ6ul9ossLcPlig==
X-Google-Smtp-Source: ABdhPJzsMmSxeViscHuzy0KbvAv4a0mHXQEc6+wJ70K+GZOauw3j9FEql3MZalMfGbBglVNUPZe8KEqTo3HV6S9Qg4c=
X-Received: by 2002:a17:907:16ac:: with SMTP id hc44mr60376458ejc.363.1638214186096;
 Mon, 29 Nov 2021 11:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20211117145829.204360-1-marcan@marcan.st> <20211117145829.204360-2-marcan@marcan.st>
 <f3582c00-925d-91ec-c829-0aaa8f0157c0@suse.de> <36f3cf18-6654-e1bf-1fa6-a5797751ee86@marcan.st>
In-Reply-To: <36f3cf18-6654-e1bf-1fa6-a5797751ee86@marcan.st>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Nov 2021 13:29:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLd=NrZgkTw+N2+Ka4zqRVpZMRNSisUDV9MhBQA-0TZQg@mail.gmail.com>
Message-ID: <CAL_JsqLd=NrZgkTw+N2+Ka4zqRVpZMRNSisUDV9MhBQA-0TZQg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/simpledrm: Bind to OF framebuffers in /chosen
To:     Hector Martin <marcan@marcan.st>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 9:24 PM Hector Martin <marcan@marcan.st> wrote:
>
> On 18/11/2021 18.19, Thomas Zimmermann wrote:
> > Hi
> >
> > Am 17.11.21 um 15:58 schrieb Hector Martin:
> >> @@ -897,5 +898,21 @@ static struct platform_driver simpledrm_platform_driver = {
> >>
> >>    module_platform_driver(simpledrm_platform_driver);
> >>
> >> +static int __init simpledrm_init(void)
> >> +{
> >> +    struct device_node *np;
> >> +
> >> +    if (IS_ENABLED(CONFIG_OF_ADDRESS) && of_chosen) {
> >> +            for_each_child_of_node(of_chosen, np) {
> >> +                    if (of_device_is_compatible(np, "simple-framebuffer"))
> >> +                            of_platform_device_create(np, NULL, NULL);
> >> +            }
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +fs_initcall(simpledrm_init);
> >> +
> >
> > Simpledrm is just a driver, but this is platform setup code. Why is this
> > code located here and not under arch/ or drivers/firmware/?
> >
> > I know that other drivers do similar things, it doesn't seem to belong here.
>
> This definitely doesn't belong in either of those, since it is not arch-
> or firmware-specific. It is implementing support for the standard
> simple-framebuffer OF binding, which specifies that it must be located
> within the /chosen node (and thus the default OF setup code won't do the
> matching for you); this applies to all OF platforms [1]
>
> Adding Rob; do you think this should move from simplefb/simpledrm to
> common OF code? (where?)

of_platform_default_populate_init() should work.
