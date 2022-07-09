Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4956C5FB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiGIC2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiGIC2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:28:16 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D479EE8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:28:14 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 9A2941008B388;
        Sat,  9 Jul 2022 10:28:05 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id C61E2200A5E62;
        Sat,  9 Jul 2022 10:28:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jtiPptT7xq7X; Sat,  9 Jul 2022 10:28:03 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 3A3F72009BEAF;
        Sat,  9 Jul 2022 10:27:54 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH v3 1/4] virtio_test: kick vhost for a batch of descriptors
Date:   Sat,  9 Jul 2022 10:27:42 +0800
Message-Id: <20220709022745.21020-2-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn>
References: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only kick vhost when the batch finishes.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 tools/virtio/virtio_test.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 23f142af5..95f78b311 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -208,11 +208,10 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 				}
 
 				++started;
-
-				if (unlikely(!virtqueue_kick(vq->vq))) {
-					r = -1;
-					break;
-				}
+			}
+			if (unlikely(!virtqueue_kick(vq->vq))) {
+				r = -1;
+				break;
 			}
 
 			if (started >= bufs)
-- 
2.17.1

