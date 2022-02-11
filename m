Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BA4B2E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbiBKUGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:06:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiBKUGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:06:46 -0500
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38155CF6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:06:44 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id IcBknKU2vAWDQIcBknFZLD; Fri, 11 Feb 2022 21:06:42 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 11 Feb 2022 21:06:42 +0100
X-ME-IP: 90.126.236.122
Message-ID: <1bc15512-d811-b26a-d4f3-e14b30730c00@wanadoo.fr>
Date:   Fri, 11 Feb 2022 21:06:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Content-Language: en-GB
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jhansen@vmware.com, vdasa@vmware.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, acking@vmware.com, dtor@vmware.com,
        pv-drivers@vmware.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
 <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
 <20220211140950.GN1951@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220211140950.GN1951@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/02/2022 à 15:09, Dan Carpenter a écrit :
> On Thu, Feb 10, 2022 at 11:27:34PM +0100, Christophe JAILLET wrote:
>> The 'err_remove_vmci_dev_g' error label is not at the right place.
>> This could lead to un-released resource.
>>
>> There is also a missing label. If pci_alloc_irq_vectors() fails, the
>> previous vmci_event_subscribe() call must be undone.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Review with GREAT care.
>>
>> This patch is a recent rebase of an old patch that has never been
>> submitted.
>> This function is huge and modifying its error handling path is error
>> prone (at least for me).
>>
>> The patch is compile-tested only.
> 
> There is still one bug.  Sorry if the line numbers are off.

Thanks for the review Dan.
Much appreciated.

> 
> drivers/misc/vmw_vmci/vmci_guest.c
>     705                if (capabilities & VMCI_CAPS_NOTIFICATIONS) {
>     706                        vmci_dev->notification_bitmap = dma_alloc_coherent(
>                                                                    ^^^^^
> Alloc
> 
>     707                                &pdev->dev, PAGE_SIZE, &vmci_dev->notification_base,
>     708                                GFP_KERNEL);
>     709                        if (!vmci_dev->notification_bitmap) {
>     710                                dev_warn(&pdev->dev,
>     711                                         "Unable to allocate notification bitmap\n");
>     712                        } else {
>     713                                memset(vmci_dev->notification_bitmap, 0, PAGE_SIZE);
>     714                                caps_in_use |= VMCI_CAPS_NOTIFICATIONS;
>     715                        }
>     716                }
>     717
>     718                if (mmio_base != NULL) {
>     719                        if (capabilities & VMCI_CAPS_DMA_DATAGRAM) {
>     720                                caps_in_use |= VMCI_CAPS_DMA_DATAGRAM;
>     721                        } else {
>     722                                dev_err(&pdev->dev,
>     723                                        "Missing capability: VMCI_CAPS_DMA_DATAGRAM\n");
>     724                                error = -ENXIO;
>     725                                goto err_free_data_buffers;
> 
> This should be goto err_free_notification_bitmap;

Agreed.
The error handling path still looked odd to me because 2 things were 
undone without a label between the 2 steps.
That was it. An err_free_notification_bitmap should be added and used.
I missed it.

> 
>     726                        }
>     727                }
> 
> On of the rules for error handling is that the unwind code should mirror
> the allocation code but instead of that this code will have:
> 
> Alloc:
> 	if (capabilities & VMCI_CAPS_NOTIFICATIONS)
> Free:
> 	if (vmci_dev->notification_bitmap)
> 
> It's the same if statement but you wouldn't really know it from just
> looking at it so it's confusing.

This one is fine I think. If the allocation of notification_bitmap 
fails, it is not an error. So it looks fine to test it the way it is done.
Or we should have both 'if'.


> Whatever...  But where this really
> hurts is with:
> 
> Alloc:
> 	if (vmci_dev->exclusive_vectors) {
> 		error = request_irq(pci_irq_vector(pdev, 1), ...
> Free:
> 	free_irq(pci_irq_vector(pdev, 1), vmci_dev);
> 
> No if statement.  It works because it's the last allocation but it's
> confusing and fragile.

Agreed.

> 
> The other question I had was:
> 
>     882        err_remove_bitmap:
>     883                if (vmci_dev->notification_bitmap) {
>     884                        vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This doesn't mirror anything in the allocation code so who knows if its
> done in the correct place/order.

Agreed. It puzzled me as well.

vmci_guest_remove_device() also has this kind of code, but it is not 
done the same way in this function. It is unconditional and not close to 
the dma_free_coherent() call.
Odd.

I won't touch it by myself :)

> 
>     885                        dma_free_coherent(&pdev->dev, PAGE_SIZE,
>     886                                          vmci_dev->notification_bitmap,
>     887                                          vmci_dev->notification_base);
>     888                }
> 
> regards,
> dan carpenter
> 
> 

All your comments are unrelated to my patch and looks like additional fixes.

Until recently, this file was mostly untouched.
So, let see if a maintainer looks interested in these patches and if he 
prefers a patch that fixes everything or several patches, maybe easier 
to review.

Once again, big thanks.

CJ
