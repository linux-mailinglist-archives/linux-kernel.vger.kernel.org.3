Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8178577EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiGRJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGRJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:31:17 -0400
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:101:465::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A03E1A81C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:31:15 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4LmcCM6mlzz9sWT;
        Mon, 18 Jul 2022 11:30:55 +0200 (CEST)
Message-ID: <f9a57983-0fda-9f94-6d21-e62870ca45ae@denx.de>
Date:   Mon, 18 Jul 2022 11:30:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] nvme-pci: fix hang during error recovery when the PCI
 device is isolated
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220712124453.2227362-1-schnelle@linux.ibm.com>
 <20220712124453.2227362-2-schnelle@linux.ibm.com>
 <Ys2CeIqv//5ZGJTM@kbusch-mbp>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <Ys2CeIqv//5ZGJTM@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.22 16:17, Keith Busch wrote:
> On Tue, Jul 12, 2022 at 02:44:53PM +0200, Niklas Schnelle wrote:
>> On s390 and powerpc PCI devices are isolated when an error is detected
>> and driver->err_handler->error_detected is called with an inaccessible
>> PCI device and PCI channel state set to pci_channel_io_frozen
>> (see Step 1 in Documentation/PCI/pci-error-recovery.rst).
>>
>> In the case of NVMe devices nvme_error_detected() then calls
>> nvme_dev_disable(dev, false) and requests a reset. After a successful
>> reset the device is accessible again and nvme_slot_reset() resets the
>> controller and queues nvme_reset_work() which then recovers the
>> controller.
>>
>> Since commit b98235d3a471 ("nvme-pci: harden drive presence detect in
>> nvme_dev_disable()") however nvme_dev_disable() no longer freezes the
>> queues if pci_device_is_present() returns false. This is the case for an
>> isolated PCI device. In principle this makes sense as there are no
>> accessible hardware queues to run. The problem though is that for
>> a previously live reset controller with online queues nvme_reset_work()
>> calls nvme_wait_freeze() which, without the freeze having been
>> initiated, then hangs forever. Fix this by starting the freeze in
>> nvme_slot_reset() which is the earliest point where we know the device
>> should be accessible again.
>>
>> Fixes: b98235d3a471 ("nvme-pci: harden drive presence detect in nvme_dev_disable()")
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Oh, we've messed up the expected sequence. The mistaken assumption is a device
> not present means we're about to unbind from it, but it could appear that way
> just for normal error handling and reset, so we need to preserve the previous
> handling.
> 
> The offending commit really just wants to avoid the register access (which we
> shouldn't have to do, but hey, broken hardware...).

Correct.

> So let's keep the sequence
> the same as before and just skip the register read. Does this work for you?
>
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fdfee3e590db..c40e82cee735 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
>   static void nvme_dev_remove_admin(struct nvme_dev *dev)
> @@ -2690,9 +2772,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   
>   	mutex_lock(&dev->shutdown_lock);
> -	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {
> -		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +	if (pci_is_enabled(pdev)) {
> +		u32 csts = ~0;
>   
> +		if (pci_device_is_present(pdev))
> +			csts = readl(dev->bar + NVME_REG_CSTS);
>   		if (dev->ctrl.state == NVME_CTRL_LIVE ||
>   		    dev->ctrl.state == NVME_CTRL_RESETTING) {
>   			freeze = true;
> --


Thanks. Looks good to me. So if anyone whats to send a proper patch with
this change, feel free to add my:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
