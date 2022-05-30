Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CE15384B9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiE3PWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbiE3PUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:20:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110F11AFEB
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:22:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g67so2683243pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GQ31AOMg6CYL2o02SAXplBrbILZAQU3ouRxiSJOrgU=;
        b=cgfAWNSA80459wk4ly9bSAoXoF/r0/0/legUd21+ZHniCAG1wV1B7JWCmIV9cguxnR
         NV+x0Xe7rxk2pW6mtOL0GEwag0Bw5mdIxGiHpGKwJ5FcR94bn8Tj5J80iBM1BOCblTGM
         PptUeWclGDH0aOgyVPyWxqj6BN9KxTrSnvYHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GQ31AOMg6CYL2o02SAXplBrbILZAQU3ouRxiSJOrgU=;
        b=1UHM+6l7o1oz3hdxD1vrp5ccQsiwnfITFZq6+WawQCNkZDAXT4x6fbKeaVPgDIDVYQ
         F3E5E3mtaDhzJ9ycFK3Pr7CZu5qyZW/QmhsoW6nFbTP4eYQehdsyGS5RQXC1HwF76vw+
         4lOEVLd8CpbjBGNTqdl05PL4bm7PbPpPEazSd9+gqLT3T6ki2KOkGeRIyCdTRq3MbIEK
         asvO/g+L3L1L/q48TRv66Bt6b1q6/dn/+agWiNuwsNLk6DJDSo1LMsGeRCP3qTqXw6g9
         TsymO0XEbPRS8HpEJWffOz4HUA5VfIoIh6YgOQX/q1e0b+rIhypODtFo7x9JSQBY8CpS
         pgdw==
X-Gm-Message-State: AOAM5316QFbrfAMt/fCxrGysyilU1miolOl2kilYS0srdOS/zRMm/F3l
        jeWRDIoBfGIfhFj6XNRqUlPhgg==
X-Google-Smtp-Source: ABdhPJygqQPEqP+uApdlFFyunbfljkbAcq0qYTWB6hl/oH8z4ZP/AA/eKh0jCieqFOXEU2LAYOIIAQ==
X-Received: by 2002:a05:6a00:a8b:b0:4cd:6030:4df3 with SMTP id b11-20020a056a000a8b00b004cd60304df3mr57535126pfl.40.1653920570326;
        Mon, 30 May 2022 07:22:50 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5f0f:14e6:3bd7:41e3])
        by smtp.gmail.com with ESMTPSA id i29-20020a056a00005d00b00517de3dc3c6sm8835947pfk.84.2022.05.30.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:22:49 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian Konig <christian.koenig@amd.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] dma-fence: allow dma fence to have their own lock
Date:   Mon, 30 May 2022 23:22:32 +0900
Message-Id: <20220530142232.2871634-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	RFC

	I don't have a good name for this yet and I did not spend
	any time on documentataion (for that reason)

We create fences (out fences) as part of operations execution, which
are short-lived objects, we want to release all memory after operation
execution is completed or when operation gets cancelled/deleted via
ioctl().

This creates a bit of a problem. DMA fences are refcounted objects and
exporter never knows when importer imports a fence or puts its refcount,
so exporter never knows when fence will be destoyed, which should not
be a problem for refcounted objects, but here comes the twist...

	operation A - creates and exports out fence X
	... user-space imports fence X
	operation A - finishes execution, signals fence X
	kfree operation A, put dma_fence

DMA fences are designed to borrow spinlock that DMA fences use to
protect struct dma_fence members:

	struct dma_fence {
	        spinlock_t *lock;

	        const struct dma_fence_ops *ops;
		.....
	};

	void dma_fence_init(struct dma_fence *fence,
			const struct dma_fence_ops *ops,
			spinlock_t *lock,
			u64 context,
			u64 seqno);

So the `lock` should have at least same lifespan as the DMA fence
that borrows it, which is impossible to guarantee in our case. When
we kfree operation A struct we also kfree ->lock that operation
lends to DMA fence, which outlives operation A (depending on what
fence importers do and when they drop imported fence refcount).

This patch adds a new memnber to struct dma_fence: __lock_inplace.
Which is a lock that DMA fence will use to protect its own data when
it cannot reliably borrow a lock from the outside object.

I also had a patch that puts inplace and borrowed locks to an unnamed
uninon and adds one more dma_fence_flag_bits to distinguish between
fences with borrowed and inplace locks

	struct dma_fence {
		uninon {
			spinlock_t *lock;
			spinlock_t __lock_inplace;
		};
		...
	};

And then instead of locking/unlocking ->lock directly we would use
dma_fence_lock_irqsave()/dma_fence_unlock_irqrestore() macros which
would check fence flags and either use borrowed lock or inplace lock.
But after seeing how owten drivers directly access fence ->lock I
decided to scratch that approach and just add extra spinlock member.

Not-Yet-Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/dma-buf/dma-fence.c | 10 ++++++++++
 include/linux/dma-fence.h   |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 066400ed8841..7ae40b8adb73 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -958,3 +958,13 @@ dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 	trace_dma_fence_init(fence);
 }
 EXPORT_SYMBOL(dma_fence_init);
+
+void dma_fence_inplace_lock_init(struct dma_fence *fence,
+				 const struct dma_fence_ops *ops,
+				 u64 context, u64 seqno)
+{
+	spin_lock_init(&fence->__lock_inplace);
+
+	dma_fence_init(fence, ops, &fence->__lock_inplace, context, seqno);
+}
+EXPORT_SYMBOL(dma_fence_inplace_lock_init);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 1ea691753bd3..6b15a0d2eccf 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -64,6 +64,8 @@ struct dma_fence_cb;
  */
 struct dma_fence {
 	spinlock_t *lock;
+	spinlock_t __lock_inplace;
+
 	const struct dma_fence_ops *ops;
 	/*
 	 * We clear the callback list on kref_put so that by the time we
@@ -262,6 +264,10 @@ struct dma_fence_ops {
 void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 		    spinlock_t *lock, u64 context, u64 seqno);
 
+void dma_fence_inplace_lock_init(struct dma_fence *fence,
+				 const struct dma_fence_ops *ops,
+				 u64 context, u64 seqno);
+
 void dma_fence_release(struct kref *kref);
 void dma_fence_free(struct dma_fence *fence);
 void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq);
-- 
2.36.1.124.g0e6072fb45-goog

