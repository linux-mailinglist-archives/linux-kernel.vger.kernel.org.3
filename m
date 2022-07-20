Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33CA57B403
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiGTJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiGTJj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAEC655BD;
        Wed, 20 Jul 2022 02:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECF7F61B54;
        Wed, 20 Jul 2022 09:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683CAC341C7;
        Wed, 20 Jul 2022 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658309963;
        bh=bpwOyUAXFiTTEmd9afQz5/COfFvZ78HnxMVqhMFUSgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjdLDCZ/wI33QZYNAtJOpM3jl1PpQldRJfxXuUkzp+kwRG6nCjILVGNrleqr4EGxQ
         8Y224y0Z4/nIYpR0aCdyQZVdJBIGarwq/xz8EK5pFz1+ySnXO+jEsAZwCAeg9iDpR1
         CCPYMLu4gjoJzI6xjQ+iX84xCF2Onwe3eBOgvbTITilxsupRqNeTu9wuBm5Pv+y22l
         GhdOEXhOOI5wq5xTlWBzFeTu3u4rnqoZnBa4+FJOANaQBpV8ec5NV4jcNzh+r+f16z
         bL43jLibj1VJqKmjh5YNmbTHOUipicX3H1EJq198cK82fxIqkcFEjkb4lQIX5JCoUv
         g/dgiUqWK4reQ==
Date:   Wed, 20 Jul 2022 15:09:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Qiang Yu <quic_qianyu@quicinc.com>, quic_hemantk@quicinc.com,
        loic.poulain@linaro.org, quic_jhugo@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v4 1/1] bus: mhi: host: Move IRQ allocation to controller
 registration phase
Message-ID: <20220720093909.GA5747@thinkpad>
References: <1655952183-66792-1-git-send-email-quic_qianyu@quicinc.com>
 <20220624072740.GA12171@thinkpad>
 <87k08an038.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k08an038.fsf@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:15:23PM +0300, Kalle Valo wrote:
> + ath11k list
> 
> Manivannan Sadhasivam <mani@kernel.org> writes:
> 
> > On Thu, Jun 23, 2022 at 10:43:03AM +0800, Qiang Yu wrote:
> >> During runtime, the MHI endpoint may be powered up/down several times.
> >> So instead of allocating and destroying the IRQs all the time, let's just
> >> enable/disable IRQs during power up/down.
> >> 
> >> The IRQs will be allocated during mhi_register_controller() and freed
> >> during mhi_unregister_controller(). This works well for things like PCI
> >> hotplug also as once the PCI device gets removed, the controller will
> >> get unregistered. And once it comes back, it will get registered back
> >> and even if the IRQ configuration changes (MSI), that will get accounted.
> >> 
> >> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> >
> > Applied to mhi-next!
> 
> I did a bisect and this patch breaks ath11k during rmmod. I'm on
> vacation right now so I can't investigate in detail but more info below.
> 

I just tested linux-next/master next-20220718 on my NUC with QCA6390, but I'm
not able to reproduce the issue during rmmod! Instead I couldn't connect to AP.

log: https://paste.debian.net/1247788/

Thanks,
Mani

> [   66.939878] rmmod ath11k_pci
> [   67.606269] general protection fault, probably for non-canonical
> address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
> PTI
> [   67.606328] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> [   67.606387] CPU: 3 PID: 1463 Comm: rmmod Not tainted 5.19.0-rc1+ #669
> [   67.606456] Hardware name: Intel(R) Client Systems
> NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [   67.606492] RIP: 0010:mhi_irq_handler+0x61/0x370 [mhi]
> [   67.606565] Code: 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 9b 02 00
> 00 49 8b ad 20 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea
> 03 <80> 3c 02 00 0f 85 bd 02 00 00 48 8d 7b 10 48 8b 6d 00 48 b8 00 00
> [   67.606639] RSP: 0018:ffffc900042ffba8 EFLAGS: 00010046
> [   67.606706] RAX: dffffc0000000000 RBX: ffff88812e1e2800 RCX:
> 0000000000000001
> [   67.606742] RDX: 0000000000000000 RSI: ffff88812e1e2800 RDI:
> ffff888110e8d120
> [   67.606776] RBP: 0000000000000000 R08: 0000000000000001 R09:
> ffffffff86ac17af
> [   67.606810] R10: fffffbfff0d582f5 R11: 0000000000000001 R12:
> ffff88812c3afb80
> [   67.606845] R13: ffff888110e8d000 R14: ffff88811ddba800 R15:
> ffff88812e1e2800
> [   67.606880] FS:  00007fef00794740(0000) GS:ffff888234200000(0000)
> knlGS:0000000000000000
> [   67.606915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   67.606950] CR2: 000055df2323b788 CR3: 0000000109844001 CR4:
> 00000000003706e0
> [   67.606987] Call Trace:
> [   67.607021]  <TASK>
> [   67.607056]  __free_irq+0x590/0x9d0
> [   67.607099]  ? slab_free_freelist_hook+0xf0/0x1a0
> [   67.607136]  free_irq+0x7b/0x110
> [   67.607171]  mhi_deinit_free_irq+0x14e/0x260 [mhi]
> [   67.607210]  mhi_unregister_controller+0x69/0x290 [mhi]
> [   67.607249]  ath11k_mhi_unregister+0x2b/0x70 [ath11k_pci]
> [   67.607284]  ath11k_pci_remove+0x107/0x2a0 [ath11k_pci]
> [   67.607321]  pci_device_remove+0x89/0x1b0
> [   67.607359]  device_release_driver_internal+0x3bc/0x600
> [   67.607400]  driver_detach+0xbc/0x180
> [   67.607439]  bus_remove_driver+0xe2/0x2d0
> [   67.607476]  pci_unregister_driver+0x21/0x250
> [   67.607512]  __do_sys_delete_module+0x307/0x4b0
> [   67.607548]  ? free_module+0x4e0/0x4e0
> [   67.607584]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
> [   67.607618]  ? syscall_enter_from_user_mode+0x1d/0x50
> [   67.607653]  ? lockdep_hardirqs_on+0x79/0x100
> [   67.607688]  do_syscall_64+0x35/0x80
> [   67.607723]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   67.607758] RIP: 0033:0x7fef008e1a6b
> [   67.607794] Code: 73 01 c3 48 8b 0d 25 c4 0c 00 f7 d8 64 89 01 48 83
> c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 c3 0c 00 f7 d8 64 89 01 48
> [   67.607836] RSP: 002b:00007ffdd5803a38 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [   67.607873] RAX: ffffffffffffffda RBX: 000055c0d3f107a0 RCX:
> 00007fef008e1a6b
> [   67.607961] RDX: 000000000000000a RSI: 0000000000000800 RDI:
> 000055c0d3f10808
> [   67.607995] RBP: 00007ffdd5803a98 R08: 0000000000000000 R09:
> 0000000000000000
> [   67.608029] R10: 00007fef0095dac0 R11: 0000000000000206 R12:
> 00007ffdd5803c70
> [   67.608063] R13: 00007ffdd5804eb7 R14: 000055c0d3f0f2a0 R15:
> 000055c0d3f107a0
> [   67.608100]  </TASK>
> [   67.608134] Modules linked in: ath11k_pci(-) ath11k mac80211 libarc4
> cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core
> [   67.608185] ---[ end trace 0000000000000000 ]---
> [   67.608186] RIP: 0010:mhi_irq_handler+0x61/0x370 [mhi]
> [   67.608192] Code: 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 9b 02 00
> 00 49 8b ad 20 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea
> 03 <80> 3c 02 00 0f 85 bd 02 00 00 48 8d 7b 10 48 8b 6d 00 48 b8 00 00
> [   67.608194] RSP: 0018:ffffc900042ffba8 EFLAGS: 00010046
> [   67.608196] RAX: dffffc0000000000 RBX: ffff88812e1e2800 RCX:
> 0000000000000001
> [   67.608197] RDX: 0000000000000000 RSI: ffff88812e1e2800 RDI:
> ffff888110e8d120
> [   67.608198] RBP: 0000000000000000 R08: 0000000000000001 R09:
> ffffffff86ac17af
> [   67.608199] R10: fffffbfff0d582f5 R11: 0000000000000001 R12:
> ffff88812c3afb80
> [   67.608200] R13: ffff888110e8d000 R14: ffff88811ddba800 R15:
> ffff88812e1e2800
> [   67.608201] FS:  00007fef00794740(0000) GS:ffff888234200000(0000)
> knlGS:0000000000000000
> [   67.608203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   67.608204] CR2: 000055df2323b788 CR3: 0000000109844001 CR4:
> 00000000003706e0
> [   67.608206] Kernel panic - not syncing: Fatal exception
> [   67.608665] Kernel Offset: 0xa00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   67.608704] Rebooting in 10 seconds..
> 
> git bisect start
> # bad: [9df125af0822d3e2bde7508e9536d67ab541a166] bus: mhi: ep: Check dev_set_name() return value
> git bisect bad 9df125af0822d3e2bde7508e9536d67ab541a166
> # good: [178329d4d635fb1848cc7ca1803dee5a634cde0d] bus: mhi: host: pci_generic: Add support for Quectel EM120 FCCL modem
> git bisect good 178329d4d635fb1848cc7ca1803dee5a634cde0d
> # bad: [1227d2a20cd7319fb45c62fab4b252600e0308bf] bus: mhi: host: Move IRQ allocation to controller registration phase
> git bisect bad 1227d2a20cd7319fb45c62fab4b252600e0308bf
> # good: [b7ce716254315dffcfce60e149ddd022c8a60345] bus: mhi: host: pci_generic: Add Cinterion MV31-W with new baseline
> git bisect good b7ce716254315dffcfce60e149ddd022c8a60345
> # first bad commit: [1227d2a20cd7319fb45c62fab4b252600e0308bf] bus: mhi: host: Move IRQ allocation to controller registration phase
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 

-- 
மணிவண்ணன் சதாசிவம்
