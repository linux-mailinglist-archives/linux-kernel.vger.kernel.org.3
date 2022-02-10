Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2506F4B1110
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243275AbiBJO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:56:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbiBJO4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:56:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C411CC4C;
        Thu, 10 Feb 2022 06:56:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E71FB8255A;
        Thu, 10 Feb 2022 14:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4478AC004E1;
        Thu, 10 Feb 2022 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644504999;
        bh=I+gIcY+KfvtSU0JaeIJ0CIXiLVlwL3aHah5tuIc7NZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8QRs2XqQFepijiM7/NN1q2GqcdaCOx416RHZWlgBNP9kkNC9vEbHUUgI0LXcyLAT
         ef8do+sIhS8il5uGw0UCTP43qbim0qRfur0OOVWovLXZXJ+JQUm93z1VjtGSrtIIIH
         DGlA86q+MbRwXZPEM1d+BNVXsrdjgHa+fLhGo+fS68a7IyX3fw8MMFgDoV3nZV0hmN
         pPPOtZPizgdOpaisXrnkgGYP3+OvxIeQpP63cSGP1rtDOZl5gYNyxW8PRc2lND7t6X
         JRdMb/sjjfv4U01wYFtU8zxldgzAvvubYxI5PCi79ZHPvj6ttBHTQkCsshcO/Dh8Mh
         9oeiw1mOjGAqg==
Date:   Thu, 10 Feb 2022 06:56:35 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Apparently it works fine when you disable VMD, so sounds like the
acpi_storage_d3 is set, but we fail to find the correct acpi companion
device when it's in a VMD domain.
