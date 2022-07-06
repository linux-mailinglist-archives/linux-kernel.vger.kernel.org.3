Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8535680A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiGFIAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiGFIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:00:05 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31B6A1900E;
        Wed,  6 Jul 2022 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Msj1Q
        C6+hqxSIXMSAOcQBdkaMXFRb0rZzELsEToclcY=; b=jelA2TkPCVEuiP2+Yihjz
        xFKo0/E7JG030cyO9VHgg97hNhNIgflovw9X2j6b7ZVXGAqVo0MR5FR8KbfKc51S
        vLHGaVRM66raANWQoJepMw8DdFZyRBzvrQmt93aFb4Bx7SdXca59ZudGX/3vRIF9
        CH9V3SpbI0Cezu4/2muWno=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp1 (Coremail) with SMTP id GdxpCgDHlqHaQMVimzpAMw--.41942S4;
        Wed, 06 Jul 2022 15:59:55 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     pawell@cadence.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] usb: cdnsp: Fix potential memory leak in cdnsp_alloc_stream_info()
Date:   Wed,  6 Jul 2022 15:59:21 +0800
Message-Id: <20220706075921.2255059-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDHlqHaQMVimzpAMw--.41942S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWrXr47Kw1fWFW8AFyDtrb_yoWDXFc_ZF
        4a9FZrGF1jkws7Gw1Fqr98urWqyr42vFWkXa12qr4fGF18ur93AryxZr4xXFW7J3y5Jrnr
        Z348t3y5ur1kJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREK9atUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBORs2jF-POXSRtQAAsh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdnsp_alloc_stream_info() allocates stream context array for stream_info
->stream_ctx_array with cdnsp_alloc_stream_ctx(). When some error occurs,
stream_info->stream_ctx_array is not released, which will lead to a
memory leak.

We can fix it by releasing the stream_info->stream_ctx_array with
cdnsp_free_stream_ctx() on the error path to avoid the potential memory
leak.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/usb/cdns3/cdnsp-mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index 97866bfb2da9..319037848151 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -631,6 +631,7 @@ int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
 			stream_info->stream_rings[cur_stream] = NULL;
 		}
 	}
+	cdnsp_free_stream_ctx(pdev, pep);
 
 cleanup_stream_rings:
 	kfree(pep->stream_info.stream_rings);
-- 
2.25.1

