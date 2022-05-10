Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7FC520F56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiEJIGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiEJIFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:05:45 -0400
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8C457BA;
        Tue, 10 May 2022 01:01:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07439848|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0389675-0.00112187-0.959911;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.NhGh97t_1652169688;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.NhGh97t_1652169688)
          by smtp.aliyun-inc.com(11.95.168.178);
          Tue, 10 May 2022 16:01:29 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, john@metanate.com,
        axboe@kernel.dk, quic_pkondeti@quicinc.com, wcheng@codeaurora.org,
        quic_ugoswami@quicinc.com, andrew_gabbasov@mentor.com,
        plr.vincent@gmail.com
Cc:     gustavoars@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: [PATCH] usb: f_fs: Fix crash during gadget function switching
Date:   Tue, 10 May 2022 16:01:05 +0800
Message-Id: <20220510080105.126146-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 android12 and possibly other platforms, during the usb gadget
function switching procedure (e.g. from mtp to midi), a synchronization
issue could occur, which causes an use-after-free panic as shown below:

[  119.787946][    T1] init: Control message: Processed ctl.start for 'adbd' from pid: 395 (system_server)
[  119.790006][   T32] android_work: sent uevent USB_STATE=DISCONNECTED
[  119.805457][ T2309] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-512' (offset 0, size 1802201963)!
[  119.819368][ T2309] ------------[ cut here ]------------
[  119.825359][ T2309] kernel BUG at mm/usercopy.c:99!
[  119.830868][ T2309] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  119.837843][ T2309] Modules linked in: sunxi_usbc ohci_sunxi ehci_sunxi sunxi_hci mali_kbase(O) sunxi_rfkill
[  119.848904][ T2309] CPU: 3 PID: 2309 Comm: MtpServer Tainted: G           O      5.4.125+ #9
[  119.858411][ T2309] Hardware name: sun50iw9 (DT)
[  119.863615][ T2309] pstate: 60400005 (nZCv daif +PAN -UAO)
[  119.869790][ T2309] pc : usercopy_abort+0x90/0x94
[  119.875078][ T2309] lr : usercopy_abort+0x90/0x94
[  119.880357][ T2309] sp : ffffffc019e13ad0
[  119.884858][ T2309] x29: ffffffc019e13ae0 x28: 0000000000000000
[  119.891601][ T2309] x27: ffffff8030e7c030 x26: 0000000000000000
[  119.898347][ T2309] x25: 0000000000000001 x24: ffffff806e25bd30
[  119.905092][ T2309] x23: 000000006b6b6b6b x22: ffffff807c804680
[  119.911838][ T2309] x21: ffffff8041410200 x20: 0000000000000001
[  119.918581][ T2309] x19: 000000006b6b6b6b x18: ffffffc019e05058
[  119.925326][ T2309] x17: 0000000000000000 x16: 00000000000002e3
[  119.932073][ T2309] x15: 0000000000000000 x14: 0000000000000010
[  119.938820][ T2309] x13: ffffffc0103972c0 x12: 0000000000000001
[  119.945565][ T2309] x11: 0000000000000000 x10: 0000000000000002
[  119.952311][ T2309] x9 : 54fea1fa84857d00 x8 : 54fea1fa84857d00
[  119.959056][ T2309] x7 : 0000000000000001 x6 : 0000000000000000
[  119.965801][ T2309] x5 : ffffff807f3a9038 x4 : 0000000000000000
[  119.972546][ T2309] x3 : 0000000000000000 x2 : ffffff807f3a8f40
[  119.979293][ T2309] x1 : ffffffc0114e94de x0 : 000000000000006d
[  119.986038][ T2309] Call trace:
[  119.989569][ T2309]  usercopy_abort+0x90/0x94
[  119.994466][ T2309]  __check_heap_object+0x16c/0x188
[  120.000041][ T2309]  __check_object_size+0x120/0x210
[  120.005620][ T2309]  ffs_epfile_io+0x574/0x6bc
[  120.010612][ T2309]  ffs_epfile_read_iter+0x10c/0x198
[  120.016284][ T2309]  __vfs_read+0x178/0x1e0
[  120.020980][ T2309]  vfs_read+0x1d0/0x284
[  120.025481][ T2309]  ksys_read+0x74/0xe0
[  120.029884][ T2309]  __arm64_sys_read+0x1c/0x28
[  120.034977][ T2309]  el0_svc_common+0xb8/0x1cc
[  120.039967][ T2309]  el0_svc_compat_handler+0x1c/0x28
[  120.045649][ T2309]  el0_svc_compat+0x8/0x24
[  120.050453][ T2309] Code: f90003e4 aa0803e1 aa0903e4 97fa0fa9 (d4210000)
[  120.058109][ T2309] ---[ end trace a246be823ca7d164 ]---
[  120.064073][ T2309] Kernel panic - not syncing: Fatal exception
[  120.070723][ T2309] SMP: stopping secondary CPUs
[  120.076030][ T2309] Kernel Offset: disabled
[  120.080757][ T2309] CPU features: 0x00010002,20002004
[  120.086438][ T2309] Memory Limit: none
[  120.090657][ T2309] ---[ end Kernel panic - not syncing: Fatal exception ]---

Two processes P1 and P2 engaged in the switching procedure:
- P1 (e.g. MtpServer) calls 'ffs_epfile_io' (alias 'C'),
- P2 (e.g. usb@1.0-service) calls 'ffs_epfile_io_complete' (alias 'A')
  and the 'ffs_func_unbind' (alias 'B').

P1                               P2
|                                |
|             configfs_write_file|
|       gadget_dev_desc_UDC_store|
|               unregister_gadget|
|    usb_gadget_unregister_driver|
|        usb_gadget_remove_driver|
|                                |
|                                |________________________________________
|                                |                                        |
|           usb_gadget_disconnect|                                        |
|                sunxi_udc_pullup|                                        |
|            sunxi_udc_set_pullup|                                        |
|   configfs_composite_disconnect|                                        |
|            composite_disconnect|                                        |
|                    reset_config|                                        |
|                ffs_func_disable|                                        |
|                ffs_func_set_alt|                                        |
|            ffs_func_eps_disable|                                        |
|                  usb_ep_disable|                                        |
|            sunxi_udc_ep_disable|                                        |
|                  sunxi_udc_nuke|               configfs_composite_unbind|
|                  sunxi_udc_done|                                        |
|                                |                                        |
|ffs_epfile_read_iter            |                     purge_configs_funcs|
|                                |                                        |
|                     complete   |                                        |
|ffs_epfile_io [C] <------------ |ffs_epfile_io_complete [A]              |
|      +                         |                                        |
|      +                                                                  |
|      +                                                                  |
|      +                  [1] complete                                    |
|      +++++++++++++++++++++++++++++++++++++++++++++++> ffs_func_unbind[B]|
|                                                                         |

On gadget switching, 'A' will raise a completion, which wakes up 'P1' to
resume 'C'. Then 'C' references 'ep->status' for branch jumping etc.
On the other path, 'B' keeps running and exec 'kfree(func->eps)', which
actually free 'ep->status' referenced by 'C'.

This leads to the panic: `usercopy: Kernel memory exposure attempt detected
from SLUB object 'kmalloc-512' (offset 0, size 1802201963)!`

To fix this issue, we add a completion[1] to ensure that 'C' completes
before 'B'.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/usb/gadget/function/f_fs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 4585ee3a444a8..c3e918cd00170 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -124,6 +124,7 @@ struct ffs_ep {
 	u8				num;
 
 	int				status;	/* P: epfile->mutex */
+	void				*context;
 };
 
 struct ffs_epfile {
@@ -246,6 +247,7 @@ ffs_sb_create_file(struct super_block *sb, const char *name, void *data,
 
 DEFINE_MUTEX(ffs_lock);
 EXPORT_SYMBOL_GPL(ffs_lock);
+DECLARE_COMPLETION(io_done);
 
 static struct ffs_dev *_ffs_find_dev(const char *name);
 static struct ffs_dev *_ffs_alloc_dev(void);
@@ -711,6 +713,8 @@ static void ffs_epfile_io_complete(struct usb_ep *_ep, struct usb_request *req)
 	if (req->context) {
 		struct ffs_ep *ep = _ep->driver_data;
 		ep->status = req->status ? req->status : req->actual;
+		if (ep->status == -ESHUTDOWN)
+			ep->context = &io_done;
 		complete(req->context);
 	}
 }
@@ -1094,6 +1098,10 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 						     &io_data->data);
 		else
 			ret = ep->status;
+
+		if (ep->status == -ESHUTDOWN && ep->context)
+			complete(ep->context);
+
 		goto error_mutex;
 	} else if (!(req = usb_ep_alloc_request(ep->ep, GFP_ATOMIC))) {
 		ret = -ENOMEM;
@@ -3607,6 +3615,12 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	/* cleanup after autoconfig */
 	spin_lock_irqsave(&func->ffs->eps_lock, flags);
 	while (count--) {
+		if (ep->status == -ESHUTDOWN && ep->context) {
+			spin_unlock_irqrestore(&func->ffs->eps_lock, flags);
+			wait_for_completion(ep->context);
+			spin_lock_irqsave(&func->ffs->eps_lock, flags);
+		}
+
 		if (ep->ep && ep->req)
 			usb_ep_free_request(ep->ep, ep->req);
 		ep->req = NULL;
-- 
2.29.0

