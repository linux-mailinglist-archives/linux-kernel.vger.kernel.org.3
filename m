Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E215175C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386665AbiEBRd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386658AbiEBRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:33:48 -0400
X-Greylist: delayed 911 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 10:30:16 PDT
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFD0E25DE;
        Mon,  2 May 2022 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=76j0I
        vA+I38dm9XbzmM3FuswAc3dTUCCDmQhUcsk+2Y=; b=Wl+Y3oMk2j9KfVEFnmNLH
        eg6GIloHE8BebBvjaOrJsoqg0fI36q4L9/D5d1age8+6bwL58KX2m/Pxnw+ztwLR
        G6B+/2G04FTD4oDHRVw41oCG+8buoG1VLHJ5V4oZJl3dxIUjFfOyr7EwT6QWPqwR
        14ReLd/MZLV3Tx5vk89Mz8=
Received: from localhost (unknown [49.235.41.28])
        by smtp1 (Coremail) with SMTP id GdxpCgCHteaAEXBicD8XAg--.29129S2;
        Tue, 03 May 2022 01:14:40 +0800 (CST)
Date:   Tue, 3 May 2022 01:14:40 +0800
From:   Hui Su <suhui_kernel@163.com>
To:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/dma-buf: fix the wrong return val
Message-ID: <20220502171440.GA377545@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: GdxpCgCHteaAEXBicD8XAg--.29129S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF45ZFW8trW3GFW3Ar4fXwb_yoWkXrgEgr
        48Xw4xX34vkr45tw1qywn5ZFyxKa4DZrZ5Arn2q3yayry5GrnxWw4ku3Z8A348Xa18WFWv
        9ryfW34FkryUXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8YNt7UUUUU==
X-Originating-IP: [49.235.41.28]
X-CM-SenderInfo: 5vxk3xhbnh20lho6il2tof0z/1tbiMwD0bVXmBJls4AAAsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function should return the correct value.

Fixes: 64a8f92fd783 ("dma-buf: add dma_fence_unwrap v2")
Signed-off-by: Hui Su <suhui@zeku.com>
---
 drivers/dma-buf/st-dma-fence-unwrap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
index 039f016b57be..0f156fca9697 100644
--- a/drivers/dma-buf/st-dma-fence-unwrap.c
+++ b/drivers/dma-buf/st-dma-fence-unwrap.c
@@ -157,7 +157,7 @@ static int unwrap_array(void *arg)
 	dma_fence_signal(f1);
 	dma_fence_signal(f2);
 	dma_fence_put(array);
-	return 0;
+	return err;
 }

 static int unwrap_chain(void *arg)
@@ -199,7 +199,7 @@ static int unwrap_chain(void *arg)
 	dma_fence_signal(f1);
 	dma_fence_signal(f2);
 	dma_fence_put(chain);
-	return 0;
+	return err;
 }

 static int unwrap_chain_array(void *arg)
@@ -245,7 +245,7 @@ static int unwrap_chain_array(void *arg)
 	dma_fence_signal(f1);
 	dma_fence_signal(f2);
 	dma_fence_put(chain);
-	return 0;
+	return err;
 }

 int dma_fence_unwrap(void)
--
2.34.1

