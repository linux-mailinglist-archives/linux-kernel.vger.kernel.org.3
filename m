Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFB24A4ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379779AbiAaPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350284AbiAaPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:40:35 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22CC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:40:35 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E61894DC; Mon, 31 Jan 2022 16:40:33 +0100 (CET)
Date:   Mon, 31 Jan 2022 16:40:32 +0100
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: nvme: IO_PAGE_FAULT logged with Intel SSDPEKKF512G8
Message-ID: <YfgC8H/EJRLRpgES@8bytes.org>
References: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
 <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
 <fd1c1767-0029-58d2-3878-5bc1a85b8e2c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1c1767-0029-58d2-3878-5bc1a85b8e2c@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 06:01:06PM +0100, Paul Menzel wrote:
> > >      $ dmesg --level=err
> > >      [    4.194306] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc080 flags=0x0050]
> > >      [    4.206970] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc000 flags=0x0050]

This was caused by a DMA read to a write-only page. Looks like a bug in
the driver or the devices firmware.

Regards,

	Joerg
