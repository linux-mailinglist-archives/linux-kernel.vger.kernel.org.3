Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCF52C047
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiERQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbiERQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:36:03 -0400
X-Greylist: delayed 30093 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 09:35:55 PDT
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A9901F0F;
        Wed, 18 May 2022 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=3KgQ3zrN3LBLM7gFu4d9St4sYVmP9yxCPwwUUX7EJ3A=; b=L
        l7yuLxSZ5EP3U4aUM86tvoyS8fQv4Yd9snjAO1A5IDnm2qLlMyJTX9UM44Vv4o/u
        OlkNp7qACnO1zBb3DGkn/jWf9W+5CdTnYUuPi6Jgez7PoblzyWG9X9VbN8xISX8j
        rcn95n7/uyCHtkhcPTS1Sd13A2FbTTMDQkPvpQ0gZk=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogDn7nphIIVihK+CBg--.61907S2;
        Thu, 19 May 2022 00:35:46 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     pawell@cadence.com, gregkh@linuxfoundation.org, peter.chen@nxp.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn, Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] usb: cdnsp:  Fix potential dereference of NULL pointer
Date:   Wed, 18 May 2022 09:35:43 -0700
Message-Id: <1652891743-110930-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 54FpogDn7nphIIVihK+CBg--.61907S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF45AFWxZF47GrWrAw13Jwb_yoWfXFX_Gw
        4ruFy7tF1agFy7Aw18Cr9xWrWjkw1qvF4kXa1Igw43CFy7ur1kZryxXr4kJF1xZ3yUKr1D
        KFyYk398uF1kAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEJBlPy7vIULQAOsH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of cdnsp_get_transfer_ring()
needs to be checked to avoid use of NULL pointer
in case of an acquisition failure.

Fixes: 3d8290455 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/usb/cdns3/cdnsp-ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index 1b14384..9f206b9 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -655,6 +655,8 @@ static int cdnsp_cmd_set_deq(struct cdnsp_device *pdev,
 	 * to reflect the new position.
 	 */
 	ep_ring = cdnsp_get_transfer_ring(pdev, pep, deq_state->stream_id);
+	if (!ep_ring)
+		return -EINVAL;
 
 	if (cdnsp_trb_is_link(ep_ring->dequeue)) {
 		ep_ring->deq_seg = ep_ring->deq_seg->next;
-- 
2.7.4

