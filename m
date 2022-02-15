Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E64B7771
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiBOThl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:37:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiBOThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:37:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8F55F62;
        Tue, 15 Feb 2022 11:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A437B818F3;
        Tue, 15 Feb 2022 19:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69643C340EB;
        Tue, 15 Feb 2022 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953845;
        bh=xxtp7AtRbMPH8L8pxD9NIPa5Oth1b2IIlAEzmBmmEzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6v2Ql03UCcTy1v/BJgL+mzmEcTHWGpXmnkg153+h1Q5SRJQzrtpzdq2Jv1DkFgtK
         afIuNINH8mYOb4bwgeOBgov4SgZhpSceUVlMQ8F3grdpWwqTIUVWYqrOjZY9sv0uLA
         E3COT+NSbV3ADGUOsCpZkDFjXpU4eaFErRPtJpL/l+ukH/ViROS+gVGNEGVu1SrVdi
         +D1E4MCz1ylDrYLJiYygKXVSkWW1s8HsFb4X2wfD/mbciTc210PdPw+ZMHi4yp79mr
         zdKAnEdzSd26r+bk17yQgO+eXVudIq53Tg4IGdZab+sbMkH0+rUA2evFd4HeEMEEOG
         b4lG69uONLtnQ==
Date:   Tue, 15 Feb 2022 11:37:22 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215193722.GD1934598@dhcp-10-100-145-180.wdc.com>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
 <20220215191731.GB25076@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215191731.GB25076@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:17:31PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
> > After the surprise removal of a mounted NVMe disk the pciehp task
> > reliably hangs forever with a trace similar to this one:
> 
> Do you have a specific reproducer? At least with doing a
> 
> echo 1 > /sys/.../remove
> 
> while running fsx on a file system I can't actually reproduce it.

That's a gracefull removal. You need to do something to terminate the
connection without the driver knowing about it. If you don't have a hotplug
capable system, you can do something slightly destructive to the PCI link to
force an ungraceful teardown, though you'll need to wait for IO timeout before
anything interesting will happen.

  # setpci -s "${slot}" CAP_EXP+10.w=10:10

The "$slot" needs to be the B:D.f of the bridge connecting to your nvme
end device. An example getting it for a non-multipath PCIe attached nvme0n1:

  # readlink -f /sys/block/nvme0n1/device | grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | tail -2 | head -1
