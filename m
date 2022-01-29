Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17F74A2D1E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352527AbiA2Iai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352517AbiA2Iah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:30:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131F2C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:30:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67C12CE284E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AED5C340E5;
        Sat, 29 Jan 2022 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643445032;
        bh=LmS6TDU/ucq+n9hRSsa4AQxVYWYfepde97p1cN1bCsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2BwzNVJeD3uuyqaJ4EXIsk7Dwgrcm4eTfSCBkcnUsZHXoJ/taxE3koywyfkt7XuSa
         6CuQcQPDaVS4pzRk9Hlew2NbGOTDajfAPm+y+RomuL2YpqbVQ36TamuMymC6up9f26
         UocQBfhhoOjMLgZL+cXVDqTUbGFT4Bd8uWVX4qMI=
Date:   Sat, 29 Jan 2022 09:30:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Zhou Qingyang <zhou1615@umn.edu>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Kangjie Lu <kjlu@umn.edu>, LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()
Message-ID: <YfT7JaD7N0AZRS59@kroah.com>
References: <20220124165856.57022-1-zhou1615@umn.edu>
 <YfPC3N+H9Fu/gqpz@kroah.com>
 <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
 <CADnq5_MtMPNHbs92OMHEzvPYSHGt=nPJMdrny6Siuvj3SYTAXQ@mail.gmail.com>
 <CACO55tt4P+beifvS=jcDsfwybFynngc8DHLR0n3BseeDJNrHyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tt4P+beifvS=jcDsfwybFynngc8DHLR0n3BseeDJNrHyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 08:57:56PM +0100, Karol Herbst wrote:
> On Fri, Jan 28, 2022 at 8:54 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
> > >
> > > Sigh-thank you for catching this - I had totally forgot about the umn.edu ban.
> > > I pushed this already but I will go ahead and send a revert for this patch.
> > > Will cc you on it as well.
> >
> > This seems short-sighted.  If the patch is valid I see no reason to
> > not accept it.  I'm not trying to downplay the mess umn got into, but
> > as long as the patch is well scrutinized and fixes a valid issue, it
> > should be applied rather than leaving potential bugs in place.
> >
> > Alex
> >
> 
> Even though knowing that malicious code can be introduced via
> perfectly fine looking patches, and sometimes one will never spot the
> problem, this patch isn't all that bad tbh.
> 
> So should we reject patches out of "policies" or should we just be
> extra careful? But not addressing the concerns as Greg pointed out is
> also kind of a bad move, but also not knowing what the state of
> resolving this mess is anyway.

If you think the change is correct, and are willing to sign off on it,
that's fine for now.

The big issue here is that the umn.edu "researchers" are not folling the
very basic and simple proceedures that we worked to set up with them,
and have resumed sending buggy patches to the kernel community.  If you
think this one is not a problem, then feel free to keep it.

As I just now told their administration, it is very difficult to tell
malice from incompetence.  If this is malice, then we need to defend our
community.  If this is just incompetence, then the university has to
handle that as the contributions are coming in their name, _and_ we also
need to defend from that.  What we have tried in the past for this group
is obviously not working, so we now will need to do something else.

{sigh}

greg k-h
