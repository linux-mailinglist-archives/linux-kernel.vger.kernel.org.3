Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2FD4874B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbiAGJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiAGJbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:31:22 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0349FC061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:31:22 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g2so4992310pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Snzve2VDTQKwZaO4ZqlxUOQ1EnmaNMLBwnYHXxG3WV0=;
        b=bkH2MhCFBrGVQWHKMOz05SKwjfL4sbXGkcilrxRjbArW/bKE779ot7D59DPLSuoRrJ
         LiY8cSwEqpBDfMEslAcGOWbydcWuRz3aS8PoXPooEKeMmF1cB5vhrVKhcoIratjOkgrA
         Tuf8IH0GAJ4icniBEWB0NGfIibup9QkqpuCp623gSPjrNOv9lSFDuRSMm/is30LrdtZG
         gBTv2NjLiQn+NqgWS1LOh8RBAnswekKXepXc5s4qG41HBUMYRACrtcTv2J67t+fW0kfi
         D1agXDyMwZdbUoqc66ccWCsbRaOrh2lU4qKZWHynKl9MIwPHlaEFaqqI9jjCHR3fI6Qe
         Im3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Snzve2VDTQKwZaO4ZqlxUOQ1EnmaNMLBwnYHXxG3WV0=;
        b=D+QJMeDuCV7LYU9Z8/BbEAVbbCYuyJn9rPFLCZjLUK+f1aUtwXri6VBqk3lrQUOGdO
         bxGXMnimCgc2cvBdZdtMcUb5MKZDJEcfKLQ6HZKFdEdbTMj6Fu3P+z6txgMmbZPgqR/l
         1XoR0tl+qsbIhqlg6nXBhG4kRy+Hia3qcc07RfmTaewjZKEnzajSjnBY8NhzF/DLxccs
         /u++xFhJWk59KqqdvH6JlyleV1XogYjQ8Tzp+dI00on92g9gRp5mC7WjDM91VaumnhA3
         b8aFGmeumBibOQOWWFUvR2GeuGjBNuGGTAU5G/uJJ8AvlaI1EpQwiz1l42lN2gFDso3e
         OK+g==
X-Gm-Message-State: AOAM533Iv2WBIRf2+BRuADwAQyMHiz8mLjYVxsxEUpmJ/1Tg+XtyZvg8
        gUHczi3uFefB4O337ayLKy4=
X-Google-Smtp-Source: ABdhPJzlEFq4M8TGSeqiyPP4mzG+YNaZAJcoYb7r9zkEpnJE7BHdkiRoXegwfVr6GwDgs+X1o8hezA==
X-Received: by 2002:aa7:9904:0:b0:4ba:5abb:aaf9 with SMTP id z4-20020aa79904000000b004ba5abbaaf9mr62943416pff.16.1641547881529;
        Fri, 07 Jan 2022 01:31:21 -0800 (PST)
Received: from localhost.localdomain ([43.128.2.63])
        by smtp.gmail.com with ESMTPSA id g12sm5183617pfv.136.2022.01.07.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 01:31:21 -0800 (PST)
From:   tcs.kernel@gmail.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com
Subject: [PATCH] tty tty_buffer: fix uninit-value in n_tty_receive_buf_common
Date:   Fri,  7 Jan 2022 17:30:58 +0800
Message-Id: <20220107093058.1659772-1-tcs.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haimin Zhang <tcs.kernel@gmail.com>

syzbot report an uninit-value issue in n_tty_receive_buf_common.
The root case is in the tty_buffer_reset() which in tty_buffer_alloc()
function, it initialized the tty_buffer struct but did not initialize 
"data[]" points area. So we should initialize the points area to avoid
using dirty data.
The syzbot report is as follows:

BUG: KMSAN: uninit-value in variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
BUG: KMSAN: uninit-value in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
BUG: KMSAN: uninit-value in n_tty_receive_buf_standard drivers/tty/n_tty.c:1557 [inline]
BUG: KMSAN: uninit-value in __receive_buf drivers/tty/n_tty.c:1577 [inline]
BUG: KMSAN: uninit-value in n_tty_receive_buf_common+0x1e6c/0x10360 drivers/tty/n_tty.c:1674
 variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
 n_tty_receive_buf_standard drivers/tty/n_tty.c:1557 [inline]
 __receive_buf drivers/tty/n_tty.c:1577 [inline]
 n_tty_receive_buf_common+0x1e6c/0x10360 drivers/tty/n_tty.c:1674
 n_tty_receive_buf2+0xbe/0xd0 drivers/tty/n_tty.c:1709
 tty_ldisc_receive_buf+0x15e/0x390 drivers/tty/tty_buffer.c:471
 tty_port_default_receive_buf+0x14b/0x1e0 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:491 [inline]
 flush_to_ldisc+0x5bf/0xa10 drivers/tty/tty_buffer.c:543
 process_one_work+0xdc2/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10f1/0x2290 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 __kmalloc+0xc3c/0x12d0 mm/slub.c:4437
 kmalloc include/linux/slab.h:595 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:177 [inline]
 __tty_buffer_request_room+0x4d2/0x900 drivers/tty/tty_buffer.c:275
 __tty_insert_flip_char+0xe5/0x3d0 drivers/tty/tty_buffer.c:392
 tty_insert_flip_char include/linux/tty_flip.h:36 [inline]
 uart_insert_char+0x495/0xb70 drivers/tty/serial/serial_core.c:3139
 serial8250_read_char+0x280/0x820 drivers/tty/serial/8250/8250_port.c:1769
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1784 [inline]
 serial8250_handle_irq+0x540/0x980 drivers/tty/serial/8250/8250_port.c:1927
 serial8250_default_handle_irq+0x18f/0x370 drivers/tty/serial/8250/8250_port.c:1949
 serial8250_interrupt+0x111/0x3f0 drivers/tty/serial/8250/8250_core.c:126
 __handle_irq_event_percpu+0x188/0xc90 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:198 [inline]
 handle_irq_event+0x188/0x420 kernel/irq/handle.c:215
 handle_edge_irq+0x472/0x13e0 kernel/irq/chip.c:822
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0xf8/0x360 arch/x86/kernel/irq.c:250
 common_interrupt+0xb1/0xd0 arch/x86/kernel/irq.c:240
 asm_common_interrupt+0x1e/0x40

Reported-by: syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com
Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com>
---
 drivers/tty/tty_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6c7e65b1d9a1..0e7f3547d971 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -180,6 +180,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 
 found:
 	tty_buffer_reset(p, size);
+	memset((char *)p + sizeof(struct tty_buffer), 0, 2 * size);
 	atomic_add(size, &port->buf.mem_used);
 	return p;
 }
-- 
2.25.1

