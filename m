Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0152B29C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiERGnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiERGng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:43:36 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3AF151DA68
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=QqUT63+lVdVPLayOPSpvAYh9oQVOVeBSUyqI0pU89dU=; b=s
        CjLQmnAVjtEEiXx8ljxJpqLF7jay2G0sp/WBT8qiaJNj4DlB6jlbNZIgSxFlzOt7
        wSfTMs8TYV2IoP4CYa9aQo67usrzsQZmBQpar7ekU5EoWvUsF+VV1LFyFbSUGjwW
        9QYnByNB76G2VzIXVhhUaR6ua5BbJ753cu54DjVVhU=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogDHzaV5lYRiupBaBw--.38611S2;
        Wed, 18 May 2022 14:43:05 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     agross@kernel.org, bjorn.andersson@linaro.org, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] iio: vadc: Fix potential dereference of NULL pointer
Date:   Tue, 17 May 2022 23:43:00 -0700
Message-Id: <1652856180-100582-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 5oFpogDHzaV5lYRiupBaBw--.38611S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr43ZF1xurWrZrW3AF47Arb_yoWfWrbEk3
        Wvqw1xXasakrWUCr4jkr4xWr98KFyUWrn5Xw1jvas3KasxJFs3AasFyr4Iyr47Aa1kZ3WD
        Grs8G3sYkFWakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK
        82IY6x8ErcxFaVAv8VWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEJBlPy7vIULQAHsO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of vadc_get_channel() needs to be checked
to avoid use of NULL pointer, which is followed by
the caller 'vadc_do_conversion' of function 'vadc_configure'.
Fix this by adding the null pointer check on prop
in function 'vadc_configure'.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 34202ba..d99bd72 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -210,6 +210,9 @@ static int vadc_configure(struct vadc_priv *vadc,
 	u8 decimation, mode_ctrl;
 	int ret;
 
+	if (!prop)
+		return -ENODEV;
+
 	/* Mode selection */
 	mode_ctrl = (VADC_OP_MODE_NORMAL << VADC_OP_MODE_SHIFT) |
 		     VADC_ADC_TRIM_EN | VADC_AMUX_TRIM_EN;
-- 
2.7.4

