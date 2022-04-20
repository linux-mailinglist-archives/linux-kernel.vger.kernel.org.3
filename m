Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6E508D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380614AbiDTQfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380542AbiDTQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:35:12 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A29443AD1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:32:26 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id o18so1350793qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3J4XthPQxhmZkFCcoyfDlVHXj50acCyi35YWGqXRzhQ=;
        b=MnuBJjSO+X5Pn8+P5NO2V5AJCtF1cWQ6TPbAd8C+4hJ5Qvnsyy7d412pABypCnNTlk
         GqdXNfazFth9H0OxyARXt//T6KxxcABwfqHwl0XjhcpQ73Lq//+viSjwoBWzsN9BjwH+
         LDRP+DaHS0tzYKk8DZQz6i/TNoeBRlftRxZNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3J4XthPQxhmZkFCcoyfDlVHXj50acCyi35YWGqXRzhQ=;
        b=qvs/9e4Lz//L5+Xgb17v3VOuBJ8Iz8oXrhQr93+b9BR8iF13RHA7Jkpi5RH4GU5Xbe
         75DOn43lJJEPDaRXSDhHx1EdoKr2DsFtTx2X/HHeNSj9ZGtA5FCTn0KH5hQeewuTVmxq
         0U1XnY2XDxicm8XofRaXv4v47RE4qQgAQbABMz/SVZEoVGmFlGnKDAZqHomhj/vdZ4ot
         ALFQ2AOu3B3IV9pbbRHaNbZu+z6jOu4x2TyrbYnd8MLvXMmG5QkIJgjFFEbj/jlSEF7/
         o7ex29/kXy5au5MiHWokwBeabAecvwKwoUHsmEvYlfY8mvjvro2O0avLSKv9crmTHSBu
         +89A==
X-Gm-Message-State: AOAM532q0KEn76Gk6VSUDeJPWmmndj28ipFdJOLXKugDGM/aPgrU+nhS
        8Ag8Gc7YT2T0PPinsuMhtl1/og==
X-Google-Smtp-Source: ABdhPJx539AYgJ3/MSSBaHkjC7fNsv8ltIIot/KmpPFw8OAWDw6agxwItmPKNSuHHH1eKaSLKSEWOg==
X-Received: by 2002:ac8:5c4c:0:b0:2e2:1006:2b21 with SMTP id j12-20020ac85c4c000000b002e210062b21mr14391034qtj.423.1650472345134;
        Wed, 20 Apr 2022 09:32:25 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id k20-20020a05622a03d400b002ec16d2694fsm1978359qtx.39.2022.04.20.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:32:24 -0700 (PDT)
Date:   Wed, 20 Apr 2022 12:32:23 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        workflows@vger.kernel.org
Subject: Re: A lot of regression reports submitted to bugzilla.kernel.org are
 apparently ignored, even bisected ones
Message-ID: <20220420163223.kz32qomzj3y4hjj5@nitro.local>
References: <6808cd17-b48c-657d-de60-ef9d8bfa151e@leemhuis.info>
 <acccdf28-3c5d-a81b-8e3a-f72e0f46149c@kernel.org>
 <20ad7c63-c837-6f6e-6bbe-7b49d653e033@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20ad7c63-c837-6f6e-6bbe-7b49d653e033@leemhuis.info>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:57:12PM +0200, Thorsten Leemhuis wrote:
> > I find such Bugzilla useless - the Components are not matching reality,
> > Products look ok except missing really a lot. Does it have proper
> > assigners based on maintainers? Nope. At least not everywhere.

Nobody has stepped up to maintain bugzilla for the past 10 years. Managing
components, products, assignees -- that's not the job of the infrastructure
team. Linux development is so compartmentalized that cross-subsystem tasks
like bug reporting have been thoroughly neglected.

However, I would argue that bugzilla needs fewer components, not more of them.
Otherwise people get confused and file bugs against "kernel.org" or whatever
happens to be the first entry in the list. For bugzilla to be useful, it needs
to have a bugmaster -- and nobody has volunteered thus far. It's not something
that members of the LF IT team can do, since none of us are kernel developers.

If someone steps up, I'll be happy to grant them admin rights to manage all
the components, etc.

> > All the bug or issue reports I get via email and I think I am not alone
> > in this. All automated tools (kbuild, kernelCI) are using emails for bug
> > reporting. Why having one more system which seems not up to date?

Email is a poor choice when someone needs to share large files (usually,
dumps). Besides, I really don't want stuff like that in public-inbox archives,
either.

This is one major upside of bugzilla -- it can still be largely email-based,
but it also provides a way to share large files without the need to ship them
around as attachments or use some other 3rd-party file sharing services.

> I'm the wrong one to ask, as I think it's a disservice right now that
> needs to be dealt with -- for example by turning it off or by making it
> work properly. But to my knowledge there is nobody really responsible
> for it (apart from Konstantin and his team, but they are afaics only
> responsible for running bugzilla the software -- not for maintaining
> components, products, and such things). That's afaics why we as the
> kernel developers community need to come up with a decision. But maybe
> mailing lists are a bad tool for this and this needs to wait till kernel
> and/or maintainers summit in September (it's already on the list of
> topics I plan to propose).

All that really needs to happen to improve the situation:

1. have an actual kernel developer be responsible for managing bugzilla; this
   person would manage components and keep an eye on new bugs to make sure
   they get to proper subsystem owners

That's it, there are no other entries here. Bugzilla *can* be a useful tool
and works reasonably well with email back-and-forth, but nobody wants to do
this work -- so everyone ends up blaming the tool.

-K
