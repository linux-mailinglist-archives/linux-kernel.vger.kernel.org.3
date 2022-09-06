Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF35AEE7C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiIFPSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiIFPRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:17:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA26554B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:30:24 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AE7DE3F470
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662474555;
        bh=97GqXImGG+MXZDwD0Hi1FKiYbWbcXEGTrI+TzMSJ84w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=D/HOJV6RFEGLJwNCdMr/tTV7/4k2jFrRiuPKhsPEDsLMK2sA9ObcG8CF+uvPNhzsO
         DKxXkJ+Eax+CkfPk5XiJwkL3wLSv+z/B4J930zC03KDipczfYdNof2UQlPifJlzu2E
         uSFmsWZTwwoVYRUd2ebdU1lExRDNZpfpwnep6o13H5TSbdnJoCRx0KrfaoDDroN39v
         FRzHPHgvWcjhdGUUEqNH5sjH1E7aK4siFLEGyn2DvN8t2I5BCWSbw9p4u4G/mWihUp
         cqLGNHxtHa/FPRZYL9OSEIHvtLrCpkXGe8FZ6AbAsWhuhF6p7RKqas97hySD9iSu/z
         ZBQJ6MAqDlKIA==
Received: by mail-wr1-f71.google.com with SMTP id r23-20020adfb1d7000000b002286358a916so1632203wra.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=97GqXImGG+MXZDwD0Hi1FKiYbWbcXEGTrI+TzMSJ84w=;
        b=lC5V+J8bnVD4K8UjtHnvKz7yu0C5il9+7yB1mIeZSJDP5apMczifuGKsVo1VJBC4wU
         qVr/pVGaebDKV3gFx5oOgAojbvaJ6H57LEMFvmQIp8I0yVcjXjdEDeK0tDFwfDbjIRuY
         kf2qd9We7uzRvpEXsjoHzOnM36BweCw2hOKdZiLmEqSufrJR95KGtML7ajSXWI52p1Eb
         JSe53f7IWW7++/68OMfdnNuNw+m2s/HTGTzywQZMDImuhbc2a+XtaTpGv8haJRAIqO66
         h3Yjd62I2vLHIQJZituRjn0dyPBhFMNiWfH8Vk1VGWOAZn8X9XTk1HVEuHIWEPsTcTge
         070g==
X-Gm-Message-State: ACgBeo0UZupE53zsp8TNhyabEbsO5VF+jJtfdVNz1XZn4fWbpEHtTk+b
        1Db7+z3NmAomAeTNo7Y8daLCS0bNw2XGhsnEfduyuItgkWLcQCS6dEAqAww9ZjRrCSP3Y3w/oex
        dj7nAdzgqQC9rK65Lk/RTtGEysWuiubpyg0/NF+3ZXtIxp3rLaMrBWNEOvg==
X-Received: by 2002:a5d:47a6:0:b0:228:473c:b84b with SMTP id 6-20020a5d47a6000000b00228473cb84bmr11147202wrb.556.1662474555167;
        Tue, 06 Sep 2022 07:29:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5HpYYxZQ9UXOe2F+hMzRwb0JPHQBggFgsZyckZdFaZor7r/1SrdJeC9o6xq/HmIFMAPcD0JeHb69TOJj3/CiA=
X-Received: by 2002:a5d:47a6:0:b0:228:473c:b84b with SMTP id
 6-20020a5d47a6000000b00228473cb84bmr11147182wrb.556.1662474554828; Tue, 06
 Sep 2022 07:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com> <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
 <YxWqSYDWe0NitSkL@black.fi.intel.com> <CAAd53p6bSmTPavjA0v6tybc6=HrwiDn0JGzXwVOG_m5EVw1p1w@mail.gmail.com>
 <YxYXH5dqKqPANeVX@black.fi.intel.com> <CAAd53p5tYG=mAR-RSr1g_iznmmcCy1QpthG5vQzr99AP4QLJyg@mail.gmail.com>
 <YxdNKx1OFKsgBUBu@black.fi.intel.com>
In-Reply-To: <YxdNKx1OFKsgBUBu@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 6 Sep 2022 22:29:03 +0800
Message-ID: <CAAd53p6nNh1nUSfJgj5db+2B=eOCfiKta5aRiGsE4N0teL9cPQ@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found on
 AMD USB4 controller
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 9:37 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Sep 06, 2022 at 08:57:20PM +0800, Kai-Heng Feng wrote:
> > On Mon, Sep 5, 2022 at 11:34 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Mon, Sep 05, 2022 at 11:21:36PM +0800, Kai-Heng Feng wrote:
> > > > > Hmm, so you see the actual hotplug but the tunneled PCIe link may not be
> > > > > detected? Does the PCIe "Card Present" (or Data Link Layer Active)
> > > > > status change at all or is it always 0?
> > > >
> > > > It changes only after tb_switch_add() is called.
> > >
> > > I doubt tb_switch_add() does anything but instead it is the established
> > > PCIe tunnel that then shows up as it toggles the Card Present bit or so.
> > > But that should also trigger PME if the root port is in D3 so you should
> > > see this wake if everything works accordingly (unless I'm missing
> > > something).
> >
> > You are right. Sometimes it may still fail to detect hotplugged device
> > right after tb_switch_add().
> > At which point PCIe tunnels are established? Is it after tb_scan_port()?
>
> They are established when userspace writes "1" to ../authorized of the
> device (not automatically).
>
> On Ubuntu that's boltd that handles this so you may need to disable it
> before you do the experiment.

In the dmesg it was disabled and "authorized" was 0 originally.

>
> > I found that it's cleaner to wakeup hotplug ports via iterating device
> > link consumers at the end of tb_scan_port().
> >
> > According to your commit b2be2b05cf3b1c7b499d3b05decdcc524879fea7
> > ("thunderbolt: Create device links from ACPI description"), it states
> > "The _DSD can be added to tunneled USB3 and PCIe ports, and is needed to
> > make sure the USB4 NHI is resumed before any of the tunneled ports so
> > the protocol tunnels get established properly before the actual port
> > itself is resumed. Othwerwise the USB/PCI core find the link may not be
> > established and starts tearing down the device stack."
> >
> > So isn't waking them up a logical thing to do here?
>
> No they should wake up themselves.

OK.

>
> > > So if you do this:
> > >
> > > 1. Boot the system up, nothing connected
> > > 2. Plug in the TBT/USB4 device but do not authorize the PCIe tunnel
> > > 3. Wait for the TBT/USB4 domain to enter sleep (runtime suspend)
> > > 4. Authorize the PCIe tunnel
> > >
> > >   # echo 1 > .../authorized
> > >
> > > The established PCIe tunnel should trigger PME and the root port then
> > > should be able to detect the PCIe link. Can you add full dmesg with
> > > "thunderbolt.dyndbg=+p" in the command line to the bug?
> >
> > dmesg attached. Unfortunately there's no PME.
>
> Hmm, attached to where? Forgot to attach? ;-)

Oops, it's attached to the Bugzilla now.

Kai-Heng
