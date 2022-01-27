Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9864C49EB04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245524AbiA0TaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiA0TaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:30:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0EFC061714;
        Thu, 27 Jan 2022 11:30:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A797B801BC;
        Thu, 27 Jan 2022 19:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D32C340E6;
        Thu, 27 Jan 2022 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643311802;
        bh=h7RLlmrK1ZqpidaqT0+vY1g9r/JOfPqZK246ZufEcyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvT4pQwbN2WqLd9pqWxbb7WRi2DRoBIfDFKG30HcBk6cth+Da4jNciI/FwEuYEz9m
         zvIJWGVP6M0lu54rCSUgWmi9Yc6BWXq2pwIyaS/at5QlCSaH3pIjoOXuYRZZkmwD3x
         1MnjRKK6Qx0Wh9e+PE1KJPvBuqbroYgy+Q/va2kHnEaIHxBJcNaBIewZ/erzHjjAd8
         ogOZLGYxg6jjn4Sy4znokzGZdYhKJYg2iXNCzoMK7nMYAt428HzkpYmYZ/JS7C2J0S
         rqtjVUzw2FobSW2tFojkXNkCoSw82b7Xu0h/K48VT969JEqNjsfdLmBATYVCkX2azj
         euGByabZaZ+8Q==
Date:   Thu, 27 Jan 2022 11:30:00 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220127193000.GC2266713@dhcp-10-100-145-180.wdc.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:02:07PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 21, 2022 at 10:09 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Jan 21, 2022 at 08:00:49PM +0100, Rafael J. Wysocki wrote:
> > > Hi Keith,
> > >
> > > It is reported that the following commit
> > >
> > > commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
> > > Author: Keith Busch <kbusch@kernel.org>
> > > Date:   Tue Jul 27 09:40:44 2021 -0700
> > >
> > >    nvme-pci: disable hmb on idle suspend
> > >
> > >    An idle suspend may or may not disable host memory access from devices
> > >    placed in low power mode. Either way, it should always be safe to
> > >    disable the host memory buffer prior to entering the low power mode, and
> > >    this should also always be faster than a full device shutdown.
> > >
> > >    Signed-off-by: Keith Busch <kbusch@kernel.org>
> > >    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > >    Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >
> > > is the source of a serious power regression occurring since 5.15
> > > (please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).
> > >
> > > After this commit, the SoC on the affected system cannot enter
> > > C-states deeper than PC2 while suspended to idle which basically
> > > defeats the purpose of suspending.
> > >
> > > What may be happening is that nvme_disable_prepare_reset() that is not
> > > called any more in the ndev->nr_host_mem_descs case somehow causes the
> > > LTR of the device to change to "no requirement" which allows deeper
> > > C-states to be entered.
> > >
> > > Can you have a look at this, please?
> >
> > I thought platforms that wanted full device shutdown  behaviour would
> > always set acpi_storage_d3. Is that not happening here?
> 
> Evidently, it isn't.
> 
> Also that flag is about putting the device into D3, which need not be
> necessary as long as the LTR is set to "don't care".

The only NVMe spec guidance for a driver to initiate a controller
shutdown is to prepare for D3 transition. If this platform wants a full
device shutdown without D3, then I think we may need a quirk.

We did a shutdown before because we didn't know any better and it's the
safeset thing to do. That caused complaints for excessive resume
latency, so now we have a platform indicator to tell us if we should,
and we rely on that. Are you suggesting we instead consult the PCIe LTR
in addition to ACPI storage properties?
