Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB45AD63B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiIEPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiIEPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:22:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A54B88
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:21:51 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8C86A3F45B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662391308;
        bh=py9zoTM93VH6XuypvypDt/VdaH92jIXolDjO+rqkHxo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=q24jGK+Q28vE4etERPkpKHIYfpwn8q0grNZTyn7wOUG8+eo58T+DPqjVFOfNCb5rK
         UOUlCTL7i4oNYwE5Bg2nOxjWeCnDwUGW3OedIyMDApMjCEdAi3uZvHS6pD9U89aKfJ
         5sFq6JPvHkXqVsze4UJWpfVioXD1/aaeuQeOdDbEoxdPd/FWLZlZvvGzHNwf6DiiGp
         NFpzh0InUs01aiC6jVKF0PCpRw44x2gKegjFkGJQOv+5E9bCC6gkYDlW0qzKPIsxzW
         NPzq9baYXZENyOs8I7LnEu8hzBvA/YSR7U8iKpyvd3Zit/RmOV9p2+9XLdRVYrcSbd
         KXHI1gp8JGuSw==
Received: by mail-wr1-f69.google.com with SMTP id d11-20020adfc08b000000b002207555c1f6so1350142wrf.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=py9zoTM93VH6XuypvypDt/VdaH92jIXolDjO+rqkHxo=;
        b=aphXM0y0XxjJjH4Z4hWbA3FJfBDPQTqp74LozxzVGyKKBdPbXgKjf0vVEVR1FoNsZv
         nLcADBh3+fTntVn9kU7Tyjt4RV1rQ0KY5mSwKM+hrQ0pQRB0EY7vsUlEZePik54V7Drg
         eO1sGG87aIa8p9mH3h4Q/rwm02bHqUXnIGLnnj2apgcvJ7nRH5y2VvS9R4wXH987+roX
         1ce3E/Yooaolp5EVZIM86z210NW3zxhgdCP9VmnpAMZ2crwsWnV4EC3d6wxXHC2mjQnu
         J8M8VPf54mfQ3QPZll/jCreMzxuBaeHsfWUqGCX+9gi2ElmY4/qKeHsjxLpHB/GuMuKP
         05rw==
X-Gm-Message-State: ACgBeo3sUvUWM/0ntQYLVBCy0yRKRGicT6kpOVYW+OGbnQoMrE0/iFqr
        MUYR1XwdHY/5YUFhNj99BwUODrowWZWqHEn9FEwmT0KtcZNN9J1x2N6U6isXwGhzGTFgwGWJWzG
        1TtnQZHaE8eiS+yhJnn7uGraIvkDP8Bz4egpIqIprUPnsil0Ts5Gk8Zporw==
X-Received: by 2002:a5d:67ca:0:b0:228:7ad5:768f with SMTP id n10-20020a5d67ca000000b002287ad5768fmr3506451wrw.163.1662391308213;
        Mon, 05 Sep 2022 08:21:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46EVLGTiNJGE31pwY63ZPoQaKCXn5QdjZvdfhzznnDbFwRcN2k+adUQ4irDovCzHAa+EWgErXOKmsTnQ4RtfE=
X-Received: by 2002:a5d:67ca:0:b0:228:7ad5:768f with SMTP id
 n10-20020a5d67ca000000b002287ad5768fmr3506440wrw.163.1662391307950; Mon, 05
 Sep 2022 08:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com> <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
 <YxWqSYDWe0NitSkL@black.fi.intel.com>
In-Reply-To: <YxWqSYDWe0NitSkL@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 5 Sep 2022 23:21:36 +0800
Message-ID: <CAAd53p6bSmTPavjA0v6tybc6=HrwiDn0JGzXwVOG_m5EVw1p1w@mail.gmail.com>
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

On Mon, Sep 5, 2022 at 3:50 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Sep 05, 2022 at 03:26:28PM +0800, Kai-Heng Feng wrote:
> > Hi Mika,
> >
> > On Mon, Sep 5, 2022 at 3:06 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Sep 05, 2022 at 02:56:22PM +0800, Kai-Heng Feng wrote:
> > > > AMD USB4 can not detect external PCIe devices like external NVMe when
> > > > it's hotplugged, because card/link are not up:
> > > >
> > > > pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status = 1101
> > >
> > > I think the correct solution is then to block them from runtime
> > > suspending entirely.
> >
> > Do you mean disable runtime suspend completely? Or just block runtime
> > suspend for a period?
>
> Completely. The port should enter D3 if it cannot wake up and Linux does
> not even enable runtime PM for such ports unless they declare
> "HotPlugSupportInD3" in their ACPI description:
>
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
>
> So that property should not be there if they cannot wake up.

The port can wake up but card/link isn't up yet.

>
> > > > Use `lspci` to resume pciehp bridges can find external devices.
> > > >
> > > > A long delay before checking card/link presence doesn't help, either.
> > > > The only way to make the hotplug work is to enable pciehp interrupt and
> > > > check card presence after the TB switch is added.
> > > >
> > > > Since the topology of USB4 and its PCIe bridges are siblings, hardcode
> > > > the bridge ID so TBT driver can wake them up to check presence.
> > >
> > > Let's not add PCI things into TBT driver unless absolutely necessary.
> >
> > OK. It's getting harder as different components are intertwined
> > together on new hardwares...
> >
> > >
> > > At least on Intel hardware the PCIe hotplug is signaled by SCI when the
> > > root port is in D3, I wonder if AMD has something similar.
> >
> > Yes those root ports are resumed to D0 when something is plugged. They
> > however fail to detect any externel PCIe devices.
>
> Hmm, so you see the actual hotplug but the tunneled PCIe link may not be
> detected? Does the PCIe "Card Present" (or Data Link Layer Active)
> status change at all or is it always 0?

It changes only after tb_switch_add() is called.

Kai-Heng
