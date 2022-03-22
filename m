Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24E14E3DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiCVLoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiCVLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 768602717D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647949404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2l0fFq2ky7IzX1acqQDcv0PT6l/OeImeJ+r0/hABWSs=;
        b=NLlGOu89K8PbOU7ULvzj9hQN0FqTgr3YeQBm3CXeWwaBTm4/uC9t0at7QcHF4xYAM7VKzX
        wcVkVMTLtCcqve0QPWgb8BwnjL5q/Ps9DwWgJb+Wk7Py0LA8Z4JkYi6wQvmkiPTIgdQuPC
        oX0CvQj5X7L/cTEReGzcliTYFjnxwzs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-_RzsB6xRMwGeRxgBBdpscg-1; Tue, 22 Mar 2022 07:43:23 -0400
X-MC-Unique: _RzsB6xRMwGeRxgBBdpscg-1
Received: by mail-qk1-f200.google.com with SMTP id v16-20020a376110000000b0067b2749e0fbso11634297qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2l0fFq2ky7IzX1acqQDcv0PT6l/OeImeJ+r0/hABWSs=;
        b=Ou14E9dsVQQ62/uQuBDPu5PfY9WUj7NhL8NauWi5GXHIOJBJ0MUibOsEv+EIw3eDUq
         bYOj62rY5tDXJ1XSLhv39G96nHCkpFo20vidDi96AmEtxjs0Kdw92Xi7rjygr9RK9ne6
         DrV8V2cy7s0Q17VTp5LU1urYqBQImiLrPQeFbji7O2qdmgQHyD59SD7YelxNEprzBoIM
         N/0YTJpVvHnse+xk+3u2vQl5RihxjfUSvqe7fuDPufSFgkuVzTFgMVIiK0Bv+uB+rdFI
         Cnum3yhIVsIGXKO7pqd00pgkp4/Amj+g9xpCdKquiOUItChheN3Pzgr84CtqfAuUji4U
         h1Cw==
X-Gm-Message-State: AOAM533vc+7uLUWXnh177Ashj2vPEFna42GrRWtxw1CYo+iRomxevrNn
        TlCsBd45ZvUEx2bi+NOyMVy8nsP3iaR5HCbCEt1IiV4Q0Z5mFbhbvzr9uDWIJ1v3Kik/nf26p9B
        Ir0dHlE0F1oqDiO92YeU+9Y9O
X-Received: by 2002:ad4:574d:0:b0:435:82ea:d03c with SMTP id q13-20020ad4574d000000b0043582ead03cmr18959369qvx.131.1647949402731;
        Tue, 22 Mar 2022 04:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAAjBCXd7O70+Bvy7zI379GD8IRuBdJuK4sQOv2roJe09wIwfOWpSci+9Wv5tMuxFEEnV38w==
X-Received: by 2002:ad4:574d:0:b0:435:82ea:d03c with SMTP id q13-20020ad4574d000000b0043582ead03cmr18959357qvx.131.1647949402514;
        Tue, 22 Mar 2022 04:43:22 -0700 (PDT)
Received: from step1.redhat.com ([87.12.25.114])
        by smtp.gmail.com with ESMTPSA id y12-20020a05622a164c00b002e1e277885esm13177825qtj.8.2022.03.22.04.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 04:43:21 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] virtio: use virtio_device_ready() in virtio_device_restore()
Date:   Tue, 22 Mar 2022 12:43:13 +0100
Message-Id: <20220322114313.116516-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After waking up a suspended VM, the kernel prints the following trace
for virtio drivers which do not directly call virtio_device_ready() in
the .restore:

    PM: suspend exit
    irq 22: nobody cared (try booting with the "irqpoll" option)
    Call Trace:
     <IRQ>
     dump_stack_lvl+0x38/0x49
     dump_stack+0x10/0x12
     __report_bad_irq+0x3a/0xaf
     note_interrupt.cold+0xb/0x60
     handle_irq_event+0x71/0x80
     handle_fasteoi_irq+0x95/0x1e0
     __common_interrupt+0x6b/0x110
     common_interrupt+0x63/0xe0
     asm_common_interrupt+0x1e/0x40
     ? __do_softirq+0x75/0x2f3
     irq_exit_rcu+0x93/0xe0
     sysvec_apic_timer_interrupt+0xac/0xd0
     </IRQ>
     <TASK>
     asm_sysvec_apic_timer_interrupt+0x12/0x20
     arch_cpu_idle+0x12/0x20
     default_idle_call+0x39/0xf0
     do_idle+0x1b5/0x210
     cpu_startup_entry+0x20/0x30
     start_secondary+0xf3/0x100
     secondary_startup_64_no_verify+0xc3/0xcb
     </TASK>
    handlers:
    [<000000008f9bac49>] vp_interrupt
    [<000000008f9bac49>] vp_interrupt
    Disabling IRQ #22

This happens because we don't invoke .enable_cbs callback in
virtio_device_restore(). That callback is used by some transports
(e.g. virtio-pci) to enable interrupts.

Let's fix it, by calling virtio_device_ready() as we do in
virtio_dev_probe(). This function calls .enable_cts callback and sets
DRIVER_OK status bit.

This fix also avoids setting DRIVER_OK twice for those drivers that
call virtio_device_ready() in the .restore.

Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

I'm not sure about the fixes tag. That one is more generic, but the
following one I think introduced the issue.

Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")

Thanks,
Stefano
---
 drivers/virtio/virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 22f15f444f75..75c8d560bbd3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
 			goto err;
 	}
 
-	/* Finally, tell the device we're all set */
-	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
+	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+		virtio_device_ready(dev);
 
 	virtio_config_enable(dev);
 
-- 
2.35.1

