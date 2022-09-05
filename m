Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128DF5AD5EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiIEPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiIEPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:13:10 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507D1B7A1;
        Mon,  5 Sep 2022 08:12:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MLsRR6mDYzkq6l;
        Mon,  5 Sep 2022 23:11:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP2 (Coremail) with SMTP id Syh0CgBH53DtERZj1M+nAQ--.47246S4;
        Mon, 05 Sep 2022 23:12:45 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Christian Mauderer <oss@c-mauderer.de>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: spi-byte: fix unbalanced of_node_get()/of_node_put()
Date:   Mon,  5 Sep 2022 15:30:23 +0000
Message-Id: <20220905153023.4152525-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53DtERZj1M+nAQ--.47246S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUGr4DZFW5ZFy3XF4UXFb_yoW8AF1fpF
        WYk343Aw43W3yxua1FyFykXFyDKa18KFWUJFWxuay5Zw1DZ34UX3WxAFyUAa47ZFyfu3WF
        vF1UJa47ZF48ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Enabling CONFIG_OF_DYNAMIC triggers the following error at device remove:

OF: ERROR: memory leak, expected refcount 1 instead of 2, \
 of_node_get()/of_node_put() unbalanced - destroy cset entry: \
 attach overlay node /spi/led-controller@0/led

of_get_next_available_child() is used to get child node with refcount
incremented in spi_byte_probe(), but missing of_node_put() on it when
done. This patch fix it.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/leds/leds-spi-byte.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-spi-byte.c b/drivers/leds/leds-spi-byte.c
index 9d23dc9e7639..eaad227b4542 100644
--- a/drivers/leds/leds-spi-byte.c
+++ b/drivers/leds/leds-spi-byte.c
@@ -91,12 +91,12 @@ static int spi_byte_probe(struct spi_device *spi)
 		dev_err(dev, "Device must have exactly one LED sub-node.");
 		return -EINVAL;
 	}
-	child = of_get_next_available_child(dev_of_node(dev), NULL);
 
 	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 	if (!led)
 		return -ENOMEM;
 
+	child = of_get_next_available_child(dev_of_node(dev), NULL);
 	of_property_read_string(child, "label", &name);
 	strlcpy(led->name, name, sizeof(led->name));
 	led->spi = spi;
@@ -113,10 +113,12 @@ static int spi_byte_probe(struct spi_device *spi)
 			led->ldev.brightness = led->ldev.max_brightness;
 		} else if (strcmp(state, "off")) {
 			/* all other cases except "off" */
+			of_node_put(child);
 			dev_err(dev, "default-state can only be 'on' or 'off'");
 			return -EINVAL;
 		}
 	}
+	of_node_put(child);
 	spi_byte_brightness_set_blocking(&led->ldev,
 					 led->ldev.brightness);
 
-- 
2.34.1

