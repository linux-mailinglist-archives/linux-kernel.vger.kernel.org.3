Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6345749EB34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbiA0TmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:42:00 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:36715 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiA0Tl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:41:59 -0500
Received: by mail-yb1-f175.google.com with SMTP id c6so11967385ybk.3;
        Thu, 27 Jan 2022 11:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUWJiAdYBjZ8HLz3oqciBqeoHxb85E3/8hDab3DlNpU=;
        b=uxeiCUN+5eX6VcXe2sk89FLR1P9GDxGh7cuB/Zo7qWl7O3JhfXNlRXxny7QVY4CI2b
         yuEdIc5FrCDQZaThElEU1lctGK0A9HICeMBMCqfTY7o4Nse6r+Su/q5GIh5STKODoMng
         BDm4gahfuLn6+Q6n+z2zlOd2o+Li6WiLHvPbhenG1TfZt9+3a38vyvSJHufornbVInYA
         Cap2mfZeJaPE4TFvwu1431ypdM9RJtY8PE3qG7OnziAUgk6uRtsmj0s/D+HF99cF8jX9
         5f0QEzwWlKshbt9aYN0TVrUoyBd2Qx/e/Hd0nVMK1sVT00iusd4JfkhwVGrPdbv55vuM
         VK4w==
X-Gm-Message-State: AOAM530ns80kld23oBoXqb07m04/cLRpzYvYKO43QU5mX5eJku2NneK5
        do7Wt63RNZTHfJVcRk/vRnFmWZ38Eoeh7UZXRXg=
X-Google-Smtp-Source: ABdhPJzAhU7n3ZgYoHOfkBD/LcfHwCSoimS44ijemNODiKTXOullNscJyRSESbLShxWNqlBc8/CGkCUJ7F7JQJ0coWg=
X-Received: by 2002:a25:2fca:: with SMTP id v193mr7835374ybv.475.1643312518985;
 Thu, 27 Jan 2022 11:41:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com> <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
 <20220127193000.GC2266713@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220127193000.GC2266713@dhcp-10-100-145-180.wdc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jan 2022 20:41:47 +0100
Message-ID: <CAJZ5v0jYGjcSjvASLvTG_vtGZWac7pmK73C0W3YBDN8io25Hkg@mail.gmail.com>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 8:30 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jan 27, 2022 at 08:02:07PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Jan 21, 2022 at 10:09 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > On Fri, Jan 21, 2022 at 08:00:49PM +0100, Rafael J. Wysocki wrote:
> > > > Hi Keith,
> > > >
> > > > It is reported that the following commit
> > > >
> > > > commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
> > > > Author: Keith Busch <kbusch@kernel.org>
> > > > Date:   Tue Jul 27 09:40:44 2021 -0700
> > > >
> > > >    nvme-pci: disable hmb on idle suspend
> > > >
> > > >    An idle suspend may or may not disable host memory access from devices
> > > >    placed in low power mode. Either way, it should always be safe to
> > > >    disable the host memory buffer prior to entering the low power mode, and
> > > >    this should also always be faster than a full device shutdown.
> > > >
> > > >    Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > >    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > >    Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > >
> > > > is the source of a serious power regression occurring since 5.15
> > > > (please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).
> > > >
> > > > After this commit, the SoC on the affected system cannot enter
> > > > C-states deeper than PC2 while suspended to idle which basically
> > > > defeats the purpose of suspending.
> > > >
> > > > What may be happening is that nvme_disable_prepare_reset() that is not
> > > > called any more in the ndev->nr_host_mem_descs case somehow causes the
> > > > LTR of the device to change to "no requirement" which allows deeper
> > > > C-states to be entered.
> > > >
> > > > Can you have a look at this, please?
> > >
> > > I thought platforms that wanted full device shutdown  behaviour would
> > > always set acpi_storage_d3. Is that not happening here?
> >
> > Evidently, it isn't.
> >
> > Also that flag is about putting the device into D3, which need not be
> > necessary as long as the LTR is set to "don't care".
>
> The only NVMe spec guidance for a driver to initiate a controller
> shutdown is to prepare for D3 transition. If this platform wants a full
> device shutdown without D3, then I think we may need a quirk.
>
> We did a shutdown before because we didn't know any better and it's the
> safeset thing to do. That caused complaints for excessive resume
> latency, so now we have a platform indicator to tell us if we should,
> and we rely on that. Are you suggesting we instead consult the PCIe LTR
> in addition to ACPI storage properties?

Possibly.

The point is that there is a regression on this particular system
caused by the above change.  It needs to be dealt with this way or
another.  Doing an additional LTR check may be the way to go, but it
needs to be verified.
