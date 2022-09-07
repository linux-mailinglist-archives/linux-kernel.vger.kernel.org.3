Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807165B03BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIGMQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiIGMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:16:14 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C3AFAF4;
        Wed,  7 Sep 2022 05:16:13 -0700 (PDT)
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4MN1SP2TzJz9sQ8;
        Wed,  7 Sep 2022 14:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1662552965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yu0YYVQDoYE6h44bljdx59LHutNAwWTa6raWx+wgdJY=;
        b=kTqf0AbE7OoeDFyfj4tPj9eCngCfCk48PBitWUWKhtb5MbsvOQCDuUmSEKdwBhdHr6HB8N
        FFnbWibYDy83/AT7Ot9iStqXx6MfzvAGXqW/II4iUf6AXLx9Fw9lbwnQ58uDRWCnPwRXdo
        1B2cdwISNDzxZx6+Zd+OSJW93xLsQ4aq/NWAaio8E1VJnyJVxKUbDAJObHhrFUF4tagBW1
        oFzc1buzxnF1zsoYN3lB8PbHMF7L7IHBtHM3ur045a6FJmVOWdkX31gc1O+AI5Pf2MDsuC
        sFN6i8yAeWX3mebZifdZQZpo0i0qtgB7FvtSEemC1a1tVf604/UJALULCquNTg==
Date:   Wed, 7 Sep 2022 14:16:04 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "arequipeno@gmail.com" <arequipeno@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Message-ID: <2047607620.67144.1662552964865@office.mailbox.org>
Subject: Re: [PATCH v10 0/2] Introduce block device LED trigger
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: c254649fcc8c57e5546
X-MBO-RS-META: 3meupxmoo81x8pbr15p4aja9n8y1isna
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

with a heavily patched Linux 6.0-rc4 with kfence, kmemleak and slub_debug I get the
following splat at boot:

Sep 07 11:33:11 kernel: =============================================================================
Sep 07 11:33:11 kernel: BUG kmalloc-16 (Not tainted): Object already free
Sep 07 11:33:11 kernel: -----------------------------------------------------------------------------
Sep 07 11:33:11 kernel: Allocated in kernfs_fop_write_iter+0x178/0x200 age=1 cpu=0 pid=453
Sep 07 11:33:11 kernel:  __slab_alloc.constprop.0+0x42/0x80
Sep 07 11:33:11 kernel:  __kmalloc+0x334/0x3a0
Sep 07 11:33:11 kernel:  kernfs_fop_write_iter+0x178/0x200
Sep 07 11:33:11 kernel:  vfs_write+0x268/0x430
Sep 07 11:33:11 kernel:  ksys_write+0x6f/0xf0
Sep 07 11:33:11 kernel:  do_syscall_64+0x5c/0x90
Sep 07 11:33:11 kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Sep 07 11:33:11 kernel: Freed in blkdev_trig_get_bdev+0x47/0x60 [ledtrig_blkdev] age=1 cpu=0 pid=453
Sep 07 11:33:11 kernel:  kfree+0x374/0x3b0
Sep 07 11:33:11 kernel:  blkdev_trig_get_bdev+0x47/0x60 [ledtrig_blkdev]
Sep 07 11:33:11 kernel:  link_dev_by_path_store+0x5c/0x3f0 [ledtrig_blkdev]
Sep 07 11:33:11 kernel:  kernfs_fop_write_iter+0x11f/0x200
Sep 07 11:33:11 kernel:  vfs_write+0x268/0x430
Sep 07 11:33:11 kernel:  ksys_write+0x6f/0xf0
Sep 07 11:33:11 kernel:  do_syscall_64+0x5c/0x90
Sep 07 11:33:11 kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Sep 07 11:33:11 kernel: Slab 0xffffeb91446ad1c0 objects=32 used=31 fp=0xffff912c1ab47b10 flags=0x4000000000000201(locked|slab|zone=2)
Sep 07 11:33:11 kernel: Object 0xffff912c1ab47b10 @offset=2832 fp=0x0000000000000000
Sep 07 11:33:11 kernel: Redzone  ffff912c1ab47b00: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Sep 07 11:33:11 kernel: Object   ffff912c1ab47b10: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
Sep 07 11:33:11 kernel: Redzone  ffff912c1ab47b20: bb bb bb bb bb bb bb bb                          ........
Sep 07 11:33:11 kernel: Padding  ffff912c1ab47b70: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[...]
Sep 07 11:33:11 kernel: Call Trace:
Sep 07 11:33:11 kernel:  <TASK>
Sep 07 11:33:11 kernel:  dump_stack_lvl+0x37/0x4a
Sep 07 11:33:11 kernel:  object_err+0x2f/0x42
Sep 07 11:33:11 kernel:  free_debug_processing.cold+0x9c/0x126
Sep 07 11:33:11 kernel:  ? kernfs_fop_write_iter+0xa0/0x200
Sep 07 11:33:11 kernel:  __slab_free+0x265/0x450
Sep 07 11:33:11 kernel:  ? _raw_spin_lock_irqsave+0x1b/0x50
Sep 07 11:33:11 kernel:  ? _raw_spin_unlock_irqrestore+0x22/0x40
Sep 07 11:33:11 kernel:  ? kernfs_fop_write_iter+0xa0/0x200
Sep 07 11:33:11 kernel:  kfree+0x374/0x3b0
Sep 07 11:33:11 kernel:  kernfs_fop_write_iter+0xa0/0x200
Sep 07 11:33:11 kernel:  vfs_write+0x268/0x430
Sep 07 11:33:11 kernel:  ksys_write+0x6f/0xf0
Sep 07 11:33:11 kernel:  do_syscall_64+0x5c/0x90
Sep 07 11:33:11 kernel:  ? do_syscall_64+0x6b/0x90
Sep 07 11:33:11 kernel:  ? do_syscall_64+0x6b/0x90
Sep 07 11:33:11 kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Sep 07 11:33:11 kernel: RIP: 0033:0x74dc50050e94
Sep 07 11:33:11 kernel: Code: 15 f9 0e 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 8d 96 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3>
Sep 07 11:33:11 kernel: RSP: 002b:00007fff526d4058 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
Sep 07 11:33:11 kernel: RAX: ffffffffffffffda RBX: 000000000000000c RCX: 000074dc50050e94
Sep 07 11:33:11 kernel: RDX: 000000000000000c RSI: 0000620ac0072430 RDI: 0000000000000005
Sep 07 11:33:11 kernel: RBP: 0000620ac0072430 R08: 0000620ac00852a0 R09: 007265776f703a3a
Sep 07 11:33:11 kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000005
Sep 07 11:33:11 kernel: R13: 0000000000000000 R14: 0000000000000005 R15: 0000620ac00852a0
Sep 07 11:33:11 kernel:  </TASK>
Sep 07 11:33:11 kernel: Disabling lock debugging due to kernel taint
Sep 07 11:33:11 kernel: FIX kmalloc-16: Object at 0xffff912c1ab47b10 not freed

I'm not 100% sure if this is an issue with ledtrig_blkdev or something else,
but I thought I'll let you know about it.
I have not been able to test this on a vanilla kernel yet.

Other than that, I hope this patchset gets included in upstream.
I have been using it for a long time now and found it very useful.

Cheers,
Tor
