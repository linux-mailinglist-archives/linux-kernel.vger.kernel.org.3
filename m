Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB02538767
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbiE3Sgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiE3Sg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:36:28 -0400
X-Greylist: delayed 1268 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 11:36:27 PDT
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13466F4B7;
        Mon, 30 May 2022 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=AY1BJRxIqd71XP8I9fSzc+wL+o3YgANE/+tMjUyrz4w=; b=Lo80M
        V5DpuWnuwO4/fR+/tWQbN6WNHtKPabltZLTg7IfDxaIeEbcQtamLbctTAU3M9rG6YfDv5RtvO7TtY
        C6tIu38WqaXWnekQmFhw6pagNky5iUxeD4So62T55HmlR4XlNqy1Ytmm2doHAYiQgwYcqggHMv92t
        kpPbgc4tXKFqAMx4jnhFB+NqzJGgl8Hd3D+/Pk4F5IORMbb9ssczV1JgsFMsokjfuHtxRIpOL1hNV
        yR6UViVzGO6dwHHUoywKjNC4DIXEPeulglitsCQpgKCvk5p2DyFzGkwv+9ORF+poMKQIXYQnzysQE
        mzRgc1hLyitjQq1MDgu98gxL4C0uw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nvjui-0007a7-QU; Mon, 30 May 2022 19:14:48 +0100
Date:   Mon, 30 May 2022 19:14:43 +0100
From:   John Keeping <john@metanate.com>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        quic_pkondeti@quicinc.com, wcheng@codeaurora.org,
        quic_ugoswami@quicinc.com, andrew_gabbasov@mentor.com,
        plr.vincent@gmail.com, gustavoars@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: Re: [PATCH] usb: f_fs: Fix crash during gadget function switching
Message-ID: <YpUJkxWBNuZiW7Xk@donbot>
References: <20220510080105.126146-1-michael@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510080105.126146-1-michael@allwinnertech.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 04:01:05PM +0800, Michael Wu wrote:
> On arm64 android12 and possibly other platforms, during the usb gadget
> function switching procedure (e.g. from mtp to midi), a synchronization
> issue could occur, which causes an use-after-free panic as shown below:
> 
> [  119.787946][    T1] init: Control message: Processed ctl.start for 'adbd' from pid: 395 (system_server)
> [  119.790006][   T32] android_work: sent uevent USB_STATE=DISCONNECTED
> [  119.805457][ T2309] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-512' (offset 0, size 1802201963)!
> [  119.819368][ T2309] ------------[ cut here ]------------
> [  119.825359][ T2309] kernel BUG at mm/usercopy.c:99!
> [  119.830868][ T2309] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [  119.837843][ T2309] Modules linked in: sunxi_usbc ohci_sunxi ehci_sunxi sunxi_hci mali_kbase(O) sunxi_rfkill
> [  119.848904][ T2309] CPU: 3 PID: 2309 Comm: MtpServer Tainted: G           O      5.4.125+ #9
> [  119.858411][ T2309] Hardware name: sun50iw9 (DT)
> [  119.863615][ T2309] pstate: 60400005 (nZCv daif +PAN -UAO)
> [  119.869790][ T2309] pc : usercopy_abort+0x90/0x94
> [  119.875078][ T2309] lr : usercopy_abort+0x90/0x94
> [  119.880357][ T2309] sp : ffffffc019e13ad0
> [  119.884858][ T2309] x29: ffffffc019e13ae0 x28: 0000000000000000
> [  119.891601][ T2309] x27: ffffff8030e7c030 x26: 0000000000000000
> [  119.898347][ T2309] x25: 0000000000000001 x24: ffffff806e25bd30
> [  119.905092][ T2309] x23: 000000006b6b6b6b x22: ffffff807c804680
> [  119.911838][ T2309] x21: ffffff8041410200 x20: 0000000000000001
> [  119.918581][ T2309] x19: 000000006b6b6b6b x18: ffffffc019e05058
> [  119.925326][ T2309] x17: 0000000000000000 x16: 00000000000002e3
> [  119.932073][ T2309] x15: 0000000000000000 x14: 0000000000000010
> [  119.938820][ T2309] x13: ffffffc0103972c0 x12: 0000000000000001
> [  119.945565][ T2309] x11: 0000000000000000 x10: 0000000000000002
> [  119.952311][ T2309] x9 : 54fea1fa84857d00 x8 : 54fea1fa84857d00
> [  119.959056][ T2309] x7 : 0000000000000001 x6 : 0000000000000000
> [  119.965801][ T2309] x5 : ffffff807f3a9038 x4 : 0000000000000000
> [  119.972546][ T2309] x3 : 0000000000000000 x2 : ffffff807f3a8f40
> [  119.979293][ T2309] x1 : ffffffc0114e94de x0 : 000000000000006d
> [  119.986038][ T2309] Call trace:
> [  119.989569][ T2309]  usercopy_abort+0x90/0x94
> [  119.994466][ T2309]  __check_heap_object+0x16c/0x188
> [  120.000041][ T2309]  __check_object_size+0x120/0x210
> [  120.005620][ T2309]  ffs_epfile_io+0x574/0x6bc
> [  120.010612][ T2309]  ffs_epfile_read_iter+0x10c/0x198
> [  120.016284][ T2309]  __vfs_read+0x178/0x1e0
> [  120.020980][ T2309]  vfs_read+0x1d0/0x284
> [  120.025481][ T2309]  ksys_read+0x74/0xe0
> [  120.029884][ T2309]  __arm64_sys_read+0x1c/0x28
> [  120.034977][ T2309]  el0_svc_common+0xb8/0x1cc
> [  120.039967][ T2309]  el0_svc_compat_handler+0x1c/0x28
> [  120.045649][ T2309]  el0_svc_compat+0x8/0x24
> [  120.050453][ T2309] Code: f90003e4 aa0803e1 aa0903e4 97fa0fa9 (d4210000)
> [  120.058109][ T2309] ---[ end trace a246be823ca7d164 ]---
> [  120.064073][ T2309] Kernel panic - not syncing: Fatal exception
> [  120.070723][ T2309] SMP: stopping secondary CPUs
> [  120.076030][ T2309] Kernel Offset: disabled
> [  120.080757][ T2309] CPU features: 0x00010002,20002004
> [  120.086438][ T2309] Memory Limit: none
> [  120.090657][ T2309] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Two processes P1 and P2 engaged in the switching procedure:
> - P1 (e.g. MtpServer) calls 'ffs_epfile_io' (alias 'C'),
> - P2 (e.g. usb@1.0-service) calls 'ffs_epfile_io_complete' (alias 'A')
>   and the 'ffs_func_unbind' (alias 'B').
> 
> P1                               P2
> |                                |
> |             configfs_write_file|
> |       gadget_dev_desc_UDC_store|
> |               unregister_gadget|
> |    usb_gadget_unregister_driver|
> |        usb_gadget_remove_driver|
> |                                |
> |                                |________________________________________
> |                                |                                        |
> |           usb_gadget_disconnect|                                        |
> |                sunxi_udc_pullup|                                        |
> |            sunxi_udc_set_pullup|                                        |
> |   configfs_composite_disconnect|                                        |
> |            composite_disconnect|                                        |
> |                    reset_config|                                        |
> |                ffs_func_disable|                                        |
> |                ffs_func_set_alt|                                        |
> |            ffs_func_eps_disable|                                        |
> |                  usb_ep_disable|                                        |
> |            sunxi_udc_ep_disable|                                        |
> |                  sunxi_udc_nuke|               configfs_composite_unbind|
> |                  sunxi_udc_done|                                        |
> |                                |                                        |
> |ffs_epfile_read_iter            |                     purge_configs_funcs|
> |                                |                                        |
> |                     complete   |                                        |
> |ffs_epfile_io [C] <------------ |ffs_epfile_io_complete [A]              |

I assume this is the path through ffs_epfile_io() with !io_data->aio.
It looks like there is no check there for epfile->ep == ep which the
other paths do check.

Does the patch below fix the problem without needing to add a new
completion?

-- >8 --
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1084,16 +1084,22 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
                         */
                        usb_ep_dequeue(ep->ep, req);
                        wait_for_completion(&done);
-                       interrupted = ep->status < 0;
+                       interrupted = true;
                }
 
-               if (interrupted)
+               spin_lock_irq(&epfile->ffs->eps_lock);
+               if (epfile->ep != ep)
+                       ret = -ESHUTDOWN;
+               else if (interrupted && ep->status < 0)
                        ret = -EINTR;
-               else if (io_data->read && ep->status > 0)
-                       ret = __ffs_epfile_read_data(epfile, data, ep->status,
-                                                    &io_data->data);
                else
                        ret = ep->status;
+               spin_unlock_irq(&epfile->ffs->eps_lock);
+
+               if (io_data->read && ret > 0)
+                       ret = __ffs_epfile_read_data(epfile, data, ret,
+                                                    &io_data->data);
+
                goto error_mutex;
        } else if (!(req = usb_ep_alloc_request(ep->ep, GFP_ATOMIC))) {
                ret = -ENOMEM;
