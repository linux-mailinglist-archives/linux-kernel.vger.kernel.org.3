Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4618649C9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbiAZMpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiAZMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:45:44 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0802C06161C;
        Wed, 26 Jan 2022 04:45:43 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id y192so11000036vkc.8;
        Wed, 26 Jan 2022 04:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeFZ1F1xCDNSkCC3zvx1x8IPpqPLoE1A/p8p4FpCtcI=;
        b=ZVGtaWpaBb7/zTDQUYd02zGW5ej+fB9Ni2GWkLkMYoMFh/Q3Ed+6lu08HRZwnM4Ibn
         EdrwNrAjeKVIMC6SWjWW+ROZkCF1kT1RLs4eGTtaQ/XDaea+NXDx+2wZ6LKEwB7brBeV
         8cxuX1KlqGPTrSfdaw3EhqcWrSEx7JY5OcEucHOnH98SxehuhaBS4zkX8oKJ+xJ3SmHi
         ubkU6cxklht96f12N/9ksjT4qj2t1tyqwEQkIiwXAywmgbWcL0wrSBj7GW85zCiStnTS
         I+gVCzsUBgGvgbouH9SuuEtscfCBh+9kgsnlgOxbDLTQE0hT1EnHdT10hWTUtf3EPi2n
         jeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeFZ1F1xCDNSkCC3zvx1x8IPpqPLoE1A/p8p4FpCtcI=;
        b=dJc7aMjPbmkV8VcjBu0Ynum5S4i2ty4STuPuOl84UM8k5SfUnVRWoMyPeN/Zv09iPu
         EYhXc2cunmxZnOnPE52T/JpRAVLhWeBodO79wzCVvrFZhQ8haKjQdhePwyStRsBHSL9S
         gI8P9EES1L0wgshFtjvwuvLDsxhpgcF6zT4L9a9n8OnOD0g1LOD0cs3oP4wAy1tzfFya
         FFuDNhPosKnkpaGfpxEJgp7wJ0eyhQzIHs5XaePNG67JWWSqWqt3NoNaAq6uKC7OePgq
         IlK03itGML9YU3aEoZDYyzsluKk0jBUpCaqI/diJsAtp9/2s/357FYq3t98yv5gOLixH
         Tspw==
X-Gm-Message-State: AOAM532gTm0eid/xGM0cFo7S32GVy8sKQP1Rvi0V1NP1Mor9sSmG5fJ9
        Rdyg80+leN8v+6idTQ6t3+ryU5607MueQXRgbTI=
X-Google-Smtp-Source: ABdhPJw2/kvCWaVfdeHkWcdx6kf6eHrJ0ds9yVYC+9izkBB4SxRKp0tBY20gUsabLtsv9cMExP6fvP7vqgriXc4RovY=
X-Received: by 2002:a67:fdce:: with SMTP id l14mr3908513vsq.70.1643201142807;
 Wed, 26 Jan 2022 04:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <YfE5MOkQRoHQV7Wf@kroah.com> <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com>
 <YfE7LNFuf79i3oAQ@kroah.com>
In-Reply-To: <YfE7LNFuf79i3oAQ@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 26 Jan 2022 13:45:31 +0100
Message-ID: <CAMhs-H9c8zF=v2tu5Y1OsFRP6esOi5zrUceqS_OUiJ=MSfCvRQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset provider
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 26, 2022 at 01:08:52PM +0100, Sergio Paracuellos wrote:
> > On Wed, Jan 26, 2022 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> > > > Hi all,
> > > >
> > > > This patch series add minimal change to provide mt7621 resets properly
> > > > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > > > controller of the SoC and is already providing clocks to the rest of
> > > > the world.
> > > >
> > > > There is shared architecture code for all ralink platforms in 'reset.c'
> > > > file located in 'arch/mips/ralink' but the correct thing to do to align
> > > > hardware with software seems to define and add related reset code to the
> > > > already mainlined clock driver.
> > > >
> > > > After this changes, we can get rid of the useless reset controller node
> > > > in the device tree and use system controller node instead where the property
> > > > '#reset-cells' has been added. Binding documentation for this nodeq has
> > > > been updated with the new property accordly.
> > > >
> > > > This series also provide a bindings include header where all related
> > > > reset bits for the MT7621 SoC are defined.
> > > >
> > > > Also, please take a look to this review [0] to understand better motivation
> > > > for this series.
> > > >
> > > > Regarding the way of merging this:
> > > >  - I'd like patches 1 and 4 which are related going through staging tree.
> > >
> > > Patches 1 and 4 now in the staging tree, thanks.
> >
> > Stephen wanted all to go through the CLK tree since PATCH 3 and 1 were
> > also a dependency... Can we get all of them through the same tree,
> > then? I am ok with both CLK or staging trees.
>
> That's fine with me if they all go through the CLK tree, but there will
> be a merge issue that I already fixed up in my tree.  If you want me to
> drop them, just let me know.

Stephen, what do you prefer? Is it better all going through staging-tree then?

Best regards,
    Sergio Paracuellos
>
> thanks,
>
> greg k-h
