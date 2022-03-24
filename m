Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8154E60F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347508AbiCXJSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiCXJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:18:19 -0400
X-Greylist: delayed 2382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 02:16:47 PDT
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE279D4F1;
        Thu, 24 Mar 2022 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648113405;
        bh=8iITNHrVU17bPyPq/aCt5ijbzEpqeSpR6VGmt9fp4O4=;
        h=From:To:Cc:Subject:Date;
        b=CoQqxSNBvOZq6J2ITUZpKWTIHPsDi/aQFMpbKDVVkPbrbnQEWd1E2dvc4CZzddRon
         E8szrtkGEt1r9HuGdsmvN81IzZXIJ43Jr6zH6aCQ0klKhlPrnqlIW358C6JyYmDbJP
         D9Nm++cwwwqDTAg3OdtW3cFdgtpKKdgNzBWBOhrI=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id 3DC9EA7E; Thu, 24 Mar 2022 17:15:28 +0800
X-QQ-mid: xmsmtpt1648113328tewr9hg0d
Message-ID: <tencent_B3E19486FF39415098B572B7397C2936C309@qq.com>
X-QQ-XMAILINFO: NwU0tZNR0OQK49YLfziyIHPVLwaNbOO/tFvzXnAVzMl7VOg4G7RENCCLyqN7nA
         tLvurzBiClpBgVRiyqmd+F9nkdhcn1k2NOXXctTq/gFvc5ys5Jy+IishhG5yPUzSCPOm3834w6RI
         hkFCQms90g6g22tWFTGotebD4OX+BrC2KgYWN+DHaHQxb3nLt2tgLXohme/2aqZbHkwvFXikq2jg
         LRiOeKNA20abjn+2idG0P8u7m/ZroCajqTfZa6gVQbsGPASLgKB8ECnFiHiFwThiate46xNh5XfP
         5u9jphWBfDcPQh1hoYEgZWaN5JdsbJN+nGsW7uR45wI2oIRVk+Vrbmy0OD4LDm6gfu2LYVQJu7T4
         O/bDt1LXhqR+SeaDcdolUU+D5p4xbYtwX96/EPA0MOkUeZd+sriIaltDp3pi4Fb6vz/JY1yePUGX
         j95zM2UANmdukPhCDAgvBE+MCP5NMiPZsYjiqFbgMTJdBuUcxZ6kYLli1/Pl3eBpONg8sTNmxbVy
         QD2SOmaVCuTldLp1hubrOlGYgcLGx35d0QEjO+UktOSQhErDz7Xd1Zkq/ZaPmHTYxHqSJX7NuSfI
         iLmW7iTCKZ2+nJ459P9HyxBOa4RhX3FgS4Cbt7ofX9btI0e2pPTgKJqOqhm+cDnNMrdfu9EoBtJ0
         txv3QXuE8XGEoOw/uJ5Xbok9+YlMiJJvXxMMIrhso2ftmMjeeLhDycZohbP6Rk+R7Mc+o7/korCv
         cjhPOhP9Mkb/0iBCRkQJT41oT69Q1SOZHvGGkORYQT3T5nQgCpjep/qHNfk4x/0t6D4b+p4rwFzf
         qEi4P0IjYvYzMMrY9JQaw972p6uV+9BQoBfIY5HuWecqz5flErRAkjeyA2ZC74t6xCsvmHI2nPrd
         XDc9X0f23UkOybqifkQRYO2hMEfJdw3rzZgto0PEstQouVY/tat+f6Xi3EtfUbSixP1A9ysCFAyk
         cD2QeUL1g=
From:   xkernel.wang@foxmail.com
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] drm/msm/disp: check the return value of kzalloc()
Date:   Thu, 24 Mar 2022 17:15:08 +0800
X-OQ-MSGID: <20220324091508.2854-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index cabe151..369e57f 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -169,6 +169,8 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
 	va_list va;
 
 	new_blk = kzalloc(sizeof(struct msm_disp_state_block), GFP_KERNEL);
+	if (!new_blk)
+		return;
 
 	va_start(va, fmt);
 
-- 
