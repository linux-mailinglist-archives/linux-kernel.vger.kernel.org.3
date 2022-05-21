Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06252F810
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350199AbiEUDbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiEUDbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:31:52 -0400
X-Greylist: delayed 125755 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 20:31:47 PDT
Received: from azure-sdnproxy-2.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8804956759;
        Fri, 20 May 2022 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References; bh=2+Vwb1brMiNx4lK7ZGRYMXQnW/
        BV3o/Pw9gsvxTqgWw=; b=XFFi+A4zijJ9TWoxHBTKU9FwiZlN6swOxdnr60j7/v
        zDXHm/YYvr1NNr9+blZmHLZu88wVRQFaolPNgGhh/X7S4+Cs9y2ocajsqyo5k4uK
        zlYwtMJVIsiCWAEv2fgKG03m51t83Hnzaa7cPXQEhCXS4bycHVp4HqOM85t3olxZ
        g=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogCHheX9XIhiUlHABg--.30761S2;
        Sat, 21 May 2022 11:31:09 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     agross@kernel.org, bjorn.andersson@linaro.org, jic23@kernel.org,
        lars@metafoo.de, svarbanov@mm-sol.com, iivanov@mm-sol.com,
        jonathan.cameron@huawei.com
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] hv_netvsc: Fix potential dereference of NULL pointer
Date:   Fri, 20 May 2022 20:31:02 -0700
Message-Id: <1653103862-36104-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220520181323.00002892@huawei.com>
References: <20220520181323.00002892@huawei.com>
X-CM-TRANSID: 54FpogCHheX9XIhiUlHABg--.30761S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4UGr4UCw1rtw47CF1Utrb_yoWfXrg_Cr
        48uF1rZr17AFy8KrsrCF4rZFy0yw1vqr1fZrW2y3y3tFy7ZrWDX395Zr97JF4fWa1Uur9x
        Cwn2qFW5AryIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEMBlPy7vKeCwAFsl
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of netvsc_devinfo_get()
needs to be checked to avoid use of NULL
pointer in case of an allocation failure.

Fixes: 0efeea5fb ("hv_netvsc: Add the support of hibernation")

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/net/hyperv/netvsc_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index fde1c49..b1dece6 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2671,7 +2671,10 @@ static int netvsc_suspend(struct hv_device *dev)
 
 	/* Save the current config info */
 	ndev_ctx->saved_netvsc_dev_info = netvsc_devinfo_get(nvdev);
-
+	if (!ndev_ctx->saved_netvsc_dev_info) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	ret = netvsc_detach(net, nvdev);
 out:
 	rtnl_unlock();
-- 
2.7.4

