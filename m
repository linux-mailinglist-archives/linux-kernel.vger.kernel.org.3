Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96424AC9ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiBGTvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbiBGTr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:47:28 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C0CC03FEE0;
        Mon,  7 Feb 2022 11:47:15 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id p5so43184679ybd.13;
        Mon, 07 Feb 2022 11:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuRNuHNXZ73VDUS0YFtFTT31aQYm+MB2IbD5aGK6CEA=;
        b=D8UOl53t8IcFGd1x/TM8N09U7/cI8gTG/YwBARd7rwxsyItIX21MQ+YYwhuLBtV/wC
         FhsMN8dwMbasBYbKjLgylYM8X0uZjGhB8E5iV3QrKeEi+MK8q2gnNPQAnDz7BMzbkiVE
         fgXGPSanDEjshW7A7S9tmkhFkNoyakFkjocos/tPFf3n3/HpN7/HHJXYlqt8Z1vOrYng
         MbMquK5xfZKKTl3/UwoxCFzfio6JITWwmgh1WbwwIklCATYbsrze5RVIHHzEKQ00aVuG
         MnYDAJJSaoyeSQpUBwPMObI6AOzmrswu3xdML2HoGRd8O1k9q+GeBcpwnCp3ArQeDIUC
         8eDg==
X-Gm-Message-State: AOAM531wI8B/mvwRPLDxLRJWBSL0QwbQxp22T/mWwXteQTUKLYBC9H2n
        KDxEhxVI7j9SujfKeLO8/cphv1kOpC8TriUvh+k=
X-Google-Smtp-Source: ABdhPJyzP29Oh6MTXKAjJHRSuLi+phXO76/VohY769b33mWTlzmTt9W6CUm0Y/8REwbK8ghJsb0vS9WEFL5YIcwNsL4=
X-Received: by 2002:a05:690c:118:: with SMTP id bd24mr1600198ywb.515.1644263233894;
 Mon, 07 Feb 2022 11:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20220207163829.1025904-1-nathan@kernel.org> <0d11f34a98e720cb5cf0d37e67a3e130d8275e31.camel@linux.intel.com>
 <YgFPrElA4O9P6U/l@dev-arch.archlinux-ax161>
In-Reply-To: <YgFPrElA4O9P6U/l@dev-arch.archlinux-ax161>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Feb 2022 20:47:03 +0100
Message-ID: <CAJZ5v0j-FyFRwwfKk8Ohyutvde_aBkdu+_Ni7FBvtzT5oEuVzg@mail.gmail.com>
Subject: Re: [PATCH] thermal: netlink: Fix parameter type of
 thermal_genl_cpu_capability_event() stub
To:     Nathan Chancellor <nathan@kernel.org>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 5:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Feb 07, 2022 at 08:54:41AM -0800, srinivas pandruvada wrote:
> > On Mon, 2022-02-07 at 09:38 -0700, Nathan Chancellor wrote:
> > > When building with CONFIG_THERMAL_NETLINK=n, there is a spew of
> > > warnings
> > > along the lines of:
> > >
> > >   In file included from drivers/thermal/thermal_core.c:27:
> > >   In file included from drivers/thermal/thermal_core.h:15:
> > >   drivers/thermal/thermal_netlink.h:113:71: warning: declaration of
> > > 'struct cpu_capability' will not be visible outside of this function
> > > [-Wvisibility]
> > >   static inline int thermal_genl_cpu_capability_event(int count,
> > > struct cpu_capability *caps)
> > >
> > >    ^
> > >   1 warning generated.
> > >
> > > 'struct cpu_capability' is not forward declared anywhere in the
> > > header.
> > > As it turns out, this should really be 'struct
> > > thermal_genl_cpu_caps',
> > > which silences the warning and makes the parameter types of the stub
> > > match the full function.
> > Thanks for sending the patch. I was about to send this change.
> > Since this patch target only linux-next, don't we need prefix:
> > "[PATCH -next]" instead of "[PATCH]"?
>
> I could probably get better about adding "-next" to the subject prefix
> to make it easier for maintainers but I do include the commit that the
> patch was based on at the bottom of the patch to accomplish the same
> thing.
>
> Thank you for the review!

Patch applied, thanks!
