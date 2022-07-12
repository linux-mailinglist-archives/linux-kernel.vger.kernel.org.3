Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32F3571C25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiGLORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiGLORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:17:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A633B31D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 149AEB816E1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C733C341CD;
        Tue, 12 Jul 2022 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657635451;
        bh=4k4HRuM7gfop9Mz8eN6pF7c8Y7aZaQnTyFpt9VK42+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRPNWMYBMg/S8KALz1C0TbpcTHoDupuy9XwR4wVf5K9TGpU+JiAXJGIjbBBg6wYNE
         +d+AFDvEGqZZsaSoFZShVTE/D1gR7lEad4QzeNoA95xIXjGpuxUKzcq7iXVIc3CVVK
         Pg31zJbXodgWOUP2P1/sojB4ihv4hy5zWrX4gSoZ+bYZB4oyCe+3GGXYj1BG8dZ2T+
         SnihCayMpZDPhwIvsWTLpPfn/VfbMRRWEAuEO2q9imBlhbX6XNlxeZydNC5SfRz4UC
         bRVhmpXM3U2ZR10wRQmx5etcHfXkc4iCNyexPULuWVnFEstqjeQlPXaGM3e4JANZhZ
         Ezy4vS3NJ/REA==
Date:   Tue, 12 Jul 2022 08:17:28 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Stefan Roese <sr@denx.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: fix hang during error recovery when the
 PCI device is isolated
Message-ID: <Ys2CeIqv//5ZGJTM@kbusch-mbp>
References: <20220712124453.2227362-1-schnelle@linux.ibm.com>
 <20220712124453.2227362-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712124453.2227362-2-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 02:44:53PM +0200, Niklas Schnelle wrote:
> On s390 and powerpc PCI devices are isolated when an error is detected
> and driver->err_handler->error_detected is called with an inaccessible
> PCI device and PCI channel state set to pci_channel_io_frozen
> (see Step 1 in Documentation/PCI/pci-error-recovery.rst).
> 
> In the case of NVMe devices nvme_error_detected() then calls
> nvme_dev_disable(dev, false) and requests a reset. After a successful
> reset the device is accessible again and nvme_slot_reset() resets the
> controller and queues nvme_reset_work() which then recovers the
> controller.
> 
> Since commit b98235d3a471 ("nvme-pci: harden drive presence detect in
> nvme_dev_disable()") however nvme_dev_disable() no longer freezes the
> queues if pci_device_is_present() returns false. This is the case for an
> isolated PCI device. In principle this makes sense as there are no
> accessible hardware queues to run. The problem though is that for
> a previously live reset controller with online queues nvme_reset_work()
> calls nvme_wait_freeze() which, without the freeze having been
> initiated, then hangs forever. Fix this by starting the freeze in
> nvme_slot_reset() which is the earliest point where we know the device
> should be accessible again.
> 
> Fixes: b98235d3a471 ("nvme-pci: harden drive presence detect in nvme_dev_disable()")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Oh, we've messed up the expected sequence. The mistaken assumption is a device
not present means we're about to unbind from it, but it could appear that way
just for normal error handling and reset, so we need to preserve the previous
handling.

The offending commit really just wants to avoid the register access (which we
shouldn't have to do, but hey, broken hardware...). So let's keep the sequence
the same as before and just skip the register read. Does this work for you?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fdfee3e590db..c40e82cee735 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
@@ -2690,9 +2772,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {
-		u32 csts = readl(dev->bar + NVME_REG_CSTS);
+	if (pci_is_enabled(pdev)) {
+		u32 csts = ~0;
 
+		if (pci_device_is_present(pdev))
+			csts = readl(dev->bar + NVME_REG_CSTS);
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
 		    dev->ctrl.state == NVME_CTRL_RESETTING) {
 			freeze = true;
--
