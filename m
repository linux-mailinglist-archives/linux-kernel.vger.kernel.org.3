Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89DF59F339
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiHXFxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiHXFxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:53:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5EF82754;
        Tue, 23 Aug 2022 22:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7606FB822F0;
        Wed, 24 Aug 2022 05:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72A9C433C1;
        Wed, 24 Aug 2022 05:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661320399;
        bh=xYx09e/FwCKJeDXFZzACj1fWTrIBpLHE2EnCNXrSroA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVnqYa7x7LmcPayzCMr21vN5XocvMwvmUpy/Asg1QcQI9HebF4HiJbzjkf069amXK
         airByeV6QG8jWPuLmPbvnCKowes+bWjy75vfwmzBOGDXdzFbcEilMbpDL/ZIywk5rD
         yGKJHb2K3ss6U3hS+VGlrytpRe23S2OIjLBnYz+c=
Date:   Wed, 24 Aug 2022 07:53:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     balbi@kernel.org, michal.simek@xilinx.com, michal.simek@amd.com,
        shubhrajyoti.datta@xilinx.com, lee.jones@linaro.org,
        christophe.jaillet@wanadoo.fr, szymon.heidrich@gmail.com,
        jakobkoschel@gmail.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, siva.durga.prasad.paladugu@amd.com
Subject: Re: [PATCH] usb: gadget: udc-xilinx: replace memcpy with memcpy_toio
Message-ID: <YwW8zE8ieLCsSxPN@kroah.com>
References: <20220824051636.1109962-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824051636.1109962-1-piyush.mehta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:46:36AM +0530, Piyush Mehta wrote:
> For ARM processor, unaligned access to device memory is not allowed.
> Method memcpy does not take care of alignment.
> 
> USB detection failure with the unaligned address of memory access, with
> below kernel crash. To fix the unaligned address the kernel panic issue,
> replace memcpy with memcpy_toio method.
> 
> Kernel crash:
> Unable to handle kernel paging request at virtual address ffff80000c05008a
> Mem abort info:
>   ESR = 0x96000061
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x21: alignment fault
> Data abort info:
>   ISV = 0, ISS = 0x00000061
>   CM = 0, WnR = 1
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000143b000
> [ffff80000c05008a] pgd=100000087ffff003, p4d=100000087ffff003,
> pud=100000087fffe003, pmd=1000000800bcc003, pte=00680000a0010713
> Internal error: Oops: 96000061 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.19-xilinx-v2022.1 #1
> Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __memcpy+0x30/0x260
> lr : __xudc_ep0_queue+0xf0/0x110
> sp : ffff800008003d00
> x29: ffff800008003d00 x28: ffff800009474e80 x27: 00000000000000a0
> x26: 0000000000000100 x25: 0000000000000012 x24: ffff000800bc8080
> x23: 0000000000000001 x22: 0000000000000012 x21: ffff000800bc8080
> x20: 0000000000000012 x19: ffff000800bc8080 x18: 0000000000000000
> x17: ffff800876482000 x16: ffff800008004000 x15: 0000000000004000
> x14: 00001f09785d0400 x13: 0103020101005567 x12: 0781400000000200
> x11: 00000000c5672a10 x10: 00000000000008d0 x9 : ffff800009463cf0
> x8 : ffff8000094757b0 x7 : 0201010055670781 x6 : 4000000002000112
> x5 : ffff80000c05009a x4 : ffff000800a15012 x3 : ffff00080362ad80
> x2 : 0000000000000012 x1 : ffff000800a15000 x0 : ffff80000c050088
> Call trace:
>  __memcpy+0x30/0x260
>  xudc_ep0_queue+0x3c/0x60
>  usb_ep_queue+0x38/0x44
>  composite_ep0_queue.constprop.0+0x2c/0xc0
>  composite_setup+0x8d0/0x185c
>  configfs_composite_setup+0x74/0xb0
>  xudc_irq+0x570/0xa40
>  __handle_irq_event_percpu+0x58/0x170
>  handle_irq_event+0x60/0x120
>  handle_fasteoi_irq+0xc0/0x220
>  handle_domain_irq+0x60/0x90
>  gic_handle_irq+0x74/0xa0
>  call_on_irq_stack+0x2c/0x60
>  do_interrupt_handler+0x54/0x60
>  el1_interrupt+0x30/0x50
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x78/0x7c
>  arch_cpu_idle+0x18/0x2c
>  do_idle+0xdc/0x15c
>  cpu_startup_entry+0x28/0x60
>  rest_init+0xc8/0xe0
>  arch_call_rest_init+0x10/0x1c
>  start_kernel+0x694/0x6d4
>  __primary_switched+0xa4/0xac
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>

What commit id does this fix?  Should it go to a stable branch?

Please add this information in the form of a Fixes: tag and such and
resend.

thanks,

greg k-h
