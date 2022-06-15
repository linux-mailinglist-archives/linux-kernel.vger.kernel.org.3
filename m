Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4697554D10E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347636AbiFOSlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOSlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:41:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E0334653
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41B48B8212F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01FC34115;
        Wed, 15 Jun 2022 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655318468;
        bh=aQrwqFLT5KW3RGQgBn+BHZAI/LCgRU4T3zqdiFw1N7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltvj3ELLROvjZiA+vZ9/XTdu6ZHC0rN40UdjI9aHr8z17KjaRnfMG5CBqD30ftlZ6
         kx92xiAp9otoG3YyPqc+cjJwECdxHG8FoppMCCCedaFXI++mWseAIgWHZPB1AEox7T
         BJqH4dgfwtbwNUjr9wK5aFfuVdJlIbZiXG8XPdk1QXdaSH3xqTUGourVIY4qfd02d9
         nS70C69mwGmpVmYtSuLi9iDdMAa+I45rpIztDoU1YVnK0dJm/cLBrwZJ5I6z+f/q/d
         aX/6gJeaeH/68VtFBdqkF1Rpk84cEDlp8uF9ITU0NBCu9IW9I1FBsaB7FLmNi8vTDB
         1B3tviLs9rFdQ==
Date:   Wed, 15 Jun 2022 12:41:05 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Report model,sn,fw,pci device information during
 init
Message-ID: <YqonwfjE8BL6Xowf@kbusch-mbp>
References: <20220615180213.760756-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615180213.760756-1-e.velu@criteo.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 08:02:13PM +0200, Erwan Velu wrote:
> SCSI-based device get their identify properties being printed when initialized like :
> 
> [    1.245357] scsi 0:0:0:0: Direct-Access     ATA      HGST HTE721010A9 A3M0 PQ: 0 ANSI: 5
> 
> When initializing nvme devices, no identification message is reported
> making difficult to identify them during the boot process. If the system
> crashes during boot process or if the init phase fail, it could be very diffcult
> to identify the faulty disk.
> 
> This patch reports model, serial, firmware version and pci information
> as soon as possible making this early identifying task possible.
> 
> Reporting the serial has the interest of being able to ensure which
> physical drive is concerned if a hardware replacement is required and
> host features the exact same drive multiple times.
> 
> A typical output looks like:
> [    0.383353] nvme nvme0: pci function 0000:00:03.0
> [    0.418184] nvme nvme0: MODEL:QEMU NVMe Ctrl                          SN:deadbeef            FW:1.0     PCI_ID:1b36:1af4
> [    0.422020] nvme nvme0: 1/0/0 default/read/poll queues

The PCI_ID: print is misleading. That format usually indicates VID:DID, but
you're printing VID:SSVID.

This is also very similar to the recently introduced nvme_print_device_info(),
but that one removes the annoying trailing spaces if they exist. I guess if
we're going this direction, just use that print, but change it from dev_err to
dev_info, and remove the call on global id collision detection.
