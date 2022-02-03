Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97D54A8B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353424AbiBCSYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245555AbiBCSYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:24:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC51C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:24:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j25so6003097wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIZiYOb5KIYRl/qJc3StlrUHLBXvSan9TakJg38R+r0=;
        b=hBlA3xaNLllrMEAMRhqVVebO2N0bJadJaFI+KSJaqMBuIR4QR3BSR6zVxK1U+oHfB1
         yEEUIglJoDYa3z4eZN6P5y80hN7LykGGWvM8isNRSKtemPSw6JcHhqbcEf5ZLHIsgiR8
         wtBA6e3oAtrz1FeG9FgkrAWPAE3RWFKH4fmeQFh0l3qvi5WpWiSLXBqFun/4CJcz579m
         kP2OX3zuQEeQLrmsL8L2l1ZvGo1dYIm6+FPwndq0MrpMKMbIPh59UzOf87FPUd6y8iWJ
         6AhLTR4y2F1GCDac4OfMY8dcNv7YUZcs2k9O8JvIl7xAca6s5PVk6XbUO2hWRG91503u
         Ex6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIZiYOb5KIYRl/qJc3StlrUHLBXvSan9TakJg38R+r0=;
        b=a99HDlP0bDkxb8/cP5tBpBFTGhhECW/mdc39fC099FuCqul7X+JOvzVftjQIhtEPlE
         6tSqfQ6aCXr7VEnccI70/BFWi0cE+D2XjIxjUHJRJaVhbdWGjTlVe9E9HFkeIexNXXyT
         zbfg4SL4sxpPPwAbFcZRgBNvCe7l+WqUHAxiXLSQojxFLGtHRKvwgAV6KFdYKi3TP0J/
         /uyqcbzao4Dzfbr7VMIzhwri/UYgPNs8Nu40QcAfUFK8Fuv/UyxSUEmE76oqdYdt+nS7
         A7oLu05JEmucKwo6EriRXQEf7jrfv7kskoxfQHEiTuN92a9bFedmtIZQ3Zlq5pQsXuep
         nYcg==
X-Gm-Message-State: AOAM531FL9ZLGGBrpO25DUu11hB3xbWRjagc/7fRkMzzDS9TjgoykSJs
        LjiyFAE8JwjSv0UsgTo1AT6TCg==
X-Google-Smtp-Source: ABdhPJwkq1lu/FX3hmHrjWcRzfmDXRRgs1s6TEjLoxV53Cdc30bUV5zS5H2RhYT9CS9sVFZuekLC3Q==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr31290512wrr.42.1643912683900;
        Thu, 03 Feb 2022 10:24:43 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:28c2:5854:c832:e580])
        by smtp.gmail.com with ESMTPSA id h18sm3540056wro.9.2022.02.03.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:24:43 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v4 0/3] io_uring: avoid ring quiesce in io_uring_register for eventfd opcodes
Date:   Thu,  3 Feb 2022 18:24:38 +0000
Message-Id: <20220203182441.692354-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done by creating a new RCU data structure (io_ev_fd) as part of
io_ring_ctx that holds the eventfd_ctx, with reads to the structure protected
by rcu_read_lock and writes (register/unregister calls) protected by a mutex.

With the above approach ring quiesce can be avoided which is much more
expensive then using RCU lock. On the system tested, io_uring_reigster with
IORING_REGISTER_EVENTFD takes less than 1ms with RCU lock, compared to 15ms
before with ring quiesce.

The first patch creates the RCU protected data structure and removes ring
quiesce for IORING_REGISTER_EVENTFD and IORING_UNREGISTER_EVENTFD.

The second patch builds on top of the first patch and removes ring quiesce
for IORING_REGISTER_EVENTFD_ASYNC.

---
v3->v4:
- Switch back to call_rcu and use rcu_barrier incase io_eventfd_register fails
to make sure all rcu callbacks have finished.

v2->v3:
- Switched to using synchronize_rcu from call_rcu in io_eventfd_unregister.

v1->v2:
- Added patch to remove eventfd from tracepoint (Patch 1) (Jens Axboe)
- Made the code of io_should_trigger_evfd as part of io_eventfd_signal (Jens Axboe)

Usama Arif (3):
  io_uring: remove trace for eventfd
  io_uring: avoid ring quiesce while registering/unregistering eventfd
  io_uring: avoid ring quiesce for IORING_REGISTER_EVENTFD_ASYNC

 fs/io_uring.c                   | 127 +++++++++++++++++++++++---------
 include/trace/events/io_uring.h |  13 ++--
 2 files changed, 96 insertions(+), 44 deletions(-)

-- 
2.25.1

