Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F5560E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiF3AwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 20:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiF3AwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:52:10 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F763FDAB;
        Wed, 29 Jun 2022 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Msj1Q
        C6+hqxSIXMSAOcQBdkaMXFRb0rZzELsEToclcY=; b=W5+aqmNpOBgWQCZ2244BF
        DQdm/Ucmg63hkZqJHkcRA5UomTaxYRlctL97y4dwznuMMiOkNRtt5SHwduEzCEFC
        uGBD1aGJJwkhqgSj+7CTjbq/New4grv2sPBVrXYInlkqrIwTKjLVuPA8J29eIZ28
        exzyNuQNlDUheK2IIqk/wI=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp3 (Coremail) with SMTP id G9xpCgAHs5un87xiTZlmMg--.54029S4;
        Thu, 30 Jun 2022 08:52:00 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     pawell@cadence.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] usb: cdnsp: Fix potential memory leak in cdnsp_alloc_stream_info()
Date:   Thu, 30 Jun 2022 08:51:48 +0800
Message-Id: <20220630005148.2166473-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgAHs5un87xiTZlmMg--.54029S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWrXr47Kw1fWFW8AFyDtrb_yoWDXFc_ZF
        4a9FZrGF1jkws7Gw1Fqr98urWqyr42vFWkXa12qr4fGF18ur93AryxZr4xXFW7J3y5Jrnr
        Z348t3y5ur1kJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRE7PEPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFRAwjF5mLi7PcwAAs9
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

