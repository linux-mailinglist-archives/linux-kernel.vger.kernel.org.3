Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7940F48FB47
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 08:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiAPHDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 02:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiAPHDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 02:03:03 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627AAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 23:03:03 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id fo11so14671158qvb.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 23:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DFJxJo3WrNDOnKnM1u6xw8YsXtSt+iZ6G/kMCVsM30Y=;
        b=MxSg4cfCRB1PyF5rIDfg1wS+8LqSgSTjwIJRdmXpCkdG6tlGqKZRxGQ7JxJZzlRXGD
         /5w1EjxiJ8QO3PsTMwUnPpElPln6nUCAMQozzETox8Z81UOfKVKVpMWtWfTyr0xSiFqy
         m00x+pnqZzdgTk68hJ+KDg4m+dIbwxSuwvU0KeOLH7ncP9oT+b0PBxPp2fUduVIqtWXT
         d8hukUGdFLsXHfUX4pM2yTr/32mvufGdhaQtmNrliyUR5YCFwS1aAiwqdddo7emu4erd
         1CjeZeI6UfOnLgR4xUA4k6w5jHVc3Y5H54Vy/lV1vxFBZiZSsd7iblTsJTlYajMkmA2F
         4/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DFJxJo3WrNDOnKnM1u6xw8YsXtSt+iZ6G/kMCVsM30Y=;
        b=md8tQJJ27P3fyXcS5b97/9hIpXQ/cifGc0WjwP85NG4Eru0A6LZf0TLvo9Hrl7OIcU
         QJ4Yr0hDA5ifUV8qfpfbcPmtEwuA37TRZpThOJ/8ydWwZJQxYmhvMC5naY7Xu1n18z1P
         E3vZutBDdeIIcCJTtWGukxH0ECackO9xnv7SayUiAYGa9H2fiB0joSBVO+pbVlwFWR0q
         zPCwgOxVC0Pk7js6tp1cYvf+Y4aN7S7axGsig/bE1m4D9VhofCL58IRLO+WTGze97i5S
         tDA9bLTYFZidpg1ugu9TWBEKSTgc6fy271KDhP+asxXURgKgwfxZ+wrzb9jYAqGbBO+s
         1VYQ==
X-Gm-Message-State: AOAM5327qujX2/kzvHMnPg7PZrPRUHmawLBd95hKwDk/CFysyPwjPtNu
        D+4aAGqYdzO+QGLmkW6OfmyEDgsDYDej72vp
X-Google-Smtp-Source: ABdhPJygxEjC1+1meJyj9mKP2pvI8gdBvMmwHd+nf7+dfOrEE4GD0d6YIvCRTYbe50Q4Fi1wSA+r0g==
X-Received: by 2002:ad4:4ea6:: with SMTP id ed6mr7323176qvb.35.1642316582451;
        Sat, 15 Jan 2022 23:03:02 -0800 (PST)
Received: from WRT-WX9.. ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id ay21sm4703439qtb.12.2022.01.15.23.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 23:03:02 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm: fix missed initialization for folio_batch::percpu_pvec_drained
Date:   Sun, 16 Jan 2022 15:02:27 +0800
Message-Id: <20220116070227.6854-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The folio_batch_init() forgets to initinize folio_batch::percpu_pvec_drained.
This can be detected by UBSAN tool.
[    6.990914][    T1] ========================================================================
[    6.991968][    T1] UBSAN: invalid-load in mm/swap.c:996:11
[    6.993429][    T1] load of value 124 is not a valid value for type '_Bool'
[    6.994774][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.16.0-09673-ga33f5c380c4b #27
[    6.995909][    T1] Hardware name: riscv-virtio,qemu (DT)
[    6.996898][    T1] Call Trace:
[    6.997608][    T1] [<ffffffff80005ee6>] dump_backtrace+0x30/0x38
[    6.998307][    T1] [<ffffffff80912a9a>] dump_stack_lvl+0x58/0x7a
[    6.998822][    T1] [<ffffffff80912ad4>] dump_stack+0x18/0x20
[    6.999334][    T1] [<ffffffff8091276e>] ubsan_epilogue+0x10/0x58
[    6.999938][    T1] [<ffffffff8052f84a>] __ubsan_handle_load_invalid_value+0x84/0x86
[    7.000626][    T1] [<ffffffff801927ea>] __pagevec_release+0x6c/0x72
[    7.001212][    T1] [<ffffffff80193776>] truncate_inode_pages_range+0x152/0x4a6
[    7.001839][    T1] [<ffffffff80193aec>] truncate_inode_pages+0x22/0x2a
[    7.002397][    T1] [<ffffffff8045fb60>] blkdev_flush_mapping+0x78/0x13e
[    7.002960][    T1] [<ffffffff80460046>] blkdev_put+0x1a6/0x1f8
[    7.003482][    T1] [<ffffffff804811c2>] disk_scan_partitions+0x5c/0x78
[    7.004069][    T1] [<ffffffff8048147e>] device_add_disk+0x2a0/0x2c0
[    7.004627][    T1] [<ffffffff8060f2a6>] virtblk_probe+0x68c/0xb20
[    7.005176][    T1] [<ffffffff805989dc>] virtio_dev_probe+0x12e/0x210
[    7.005718][    T1] [<ffffffff805eba02>] really_probe.part.0+0x6c/0x24e
[    7.006266][    T1] [<ffffffff805ebcc0>] __driver_probe_device+0xdc/0x13e
[    7.006847][    T1] [<ffffffff805ebd62>] driver_probe_device+0x40/0x10c
[    7.007451][    T1] [<ffffffff805ec5a2>] __driver_attach+0x8c/0x172
[    7.008036][    T1] [<ffffffff805e946a>] bus_for_each_dev+0x6a/0xa8
[    7.008617][    T1] [<ffffffff805eb140>] driver_attach+0x2e/0x36
[    7.009159][    T1] [<ffffffff805eab80>] bus_add_driver+0x170/0x1ee
[    7.009717][    T1] [<ffffffff805ece74>] driver_register+0x66/0xfe
[    7.010295][    T1] [<ffffffff805987fa>] register_virtio_driver+0x30/0x4e
[    7.010899][    T1] [<ffffffff80a2a116>] init+0x78/0xac
[    7.011381][    T1] [<ffffffff800025e8>] do_one_initcall+0x7e/0x262
[    7.011955][    T1] [<ffffffff80a0197e>] kernel_init_freeable+0x30e/0x372
[    7.012559][    T1] [<ffffffff8091846a>] kernel_init+0x32/0x178
[    7.013105][    T1] [<ffffffff80003cda>] ret_from_exception+0x0/0x14
[    7.015034][    T1] ========================================================================

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/linux/pagevec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index dda8d5868c81..67b1246f136b 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -111,6 +111,7 @@ static_assert(offsetof(struct pagevec, pages) ==
 static inline void folio_batch_init(struct folio_batch *fbatch)
 {
 	fbatch->nr = 0;
+	fbatch->percpu_pvec_drained = false;
 }
 
 static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
-- 
2.32.0

