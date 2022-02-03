Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B2F4A8758
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351673AbiBCPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351684AbiBCPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:12:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53569C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:12:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g18so5298489wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28DWIu3XNuCQNZyIv3j01wBeM+PGOj6BA98YDk2GH6s=;
        b=yMDqx/wTs9+ZyXW76NLufKkbr2j83qEZyQ1Zkx4VE9VjcUjG2dnJmE9B0aFvuRCfQ3
         KqWD6dJ54fT52daABhWM955Tu7b3W7Fk9otZ75K+FZvASj5rnj/X3kaJkzYA1bEtxcLu
         W3qDHMVFKWkKzlvfdmBu77WpufVdTDaMPW3HNYjSnluMtGV3Lzmzs56Xja1kilPY23Fb
         9kX6wGxjRYRPjIR2ekiO0K2NPWoZduqGdcM/q0/0BuXF/ksSf2J50Bp6heL6GAg9yFQn
         jv++1x52rNm6XdOMSd4npR68KkT0SW/6XuxAq5Wt9p5e7edqN3yUfvRUoFwQpMLvaGZK
         Rvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28DWIu3XNuCQNZyIv3j01wBeM+PGOj6BA98YDk2GH6s=;
        b=5qqcS5ombjiiiRKVVv3SWAxoelsiWh47BxZpMpecqRewtR9H577d1AdRG/15nm2H42
         FukZ+NB7qG1sIv3l5WXcaAOBxFIHDgaXiKXvx35F3qPUc4Oxr9VnCR0gZ/GQfpLtoK0m
         sO0wWqF7yJAuN4HFAPrHFoPYPhtvm5L0eGxtt80oZYVvCWO+mWwrbMj1ySmenEvoLgAu
         bic9Lqiunknk5zpdVRszydXPzXlTMhRsniyxHyHiIiecQRiN50qyc78lnryAv2KNkTeH
         KDHKtzQW+gbaj4Nk7epfoEzdPoxrqOsiK4j5RRDB3gv15yv2B1gEb9sYppFEL0yfZGIE
         1K7g==
X-Gm-Message-State: AOAM533i6990MplaZyb+QQcaVAwLt2ZtpuWqcJSiWjItdkBi1THXybJ0
        byEeNTDuFO5nTMSfXJJoBbO24g==
X-Google-Smtp-Source: ABdhPJzE35VCTX6UFJ0sZ2tU/KYpuqWVcaKg653fteKukZdwp6dNgy5/Su6AnVEF80rIhmQsz0eZcg==
X-Received: by 2002:a5d:4578:: with SMTP id a24mr30089156wrc.75.1643901124959;
        Thu, 03 Feb 2022 07:12:04 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:28c2:5854:c832:e580])
        by smtp.gmail.com with ESMTPSA id m14sm25793665wrp.4.2022.02.03.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:12:04 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH 0/2] io_uring: avoid ring quiesce in io_uring_register for eventfd opcodes
Date:   Thu,  3 Feb 2022 15:11:51 +0000
Message-Id: <20220203151153.574032-1-usama.arif@bytedance.com>
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

Usama Arif (2):
  io_uring: avoid ring quiesce while registering/unregistering eventfd
  io_uring: avoid ring quiesce for IORING_REGISTER_EVENTFD_ASYNC

 fs/io_uring.c | 125 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 33 deletions(-)

-- 
2.25.1

