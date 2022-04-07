Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2C64F7BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiDGJaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiDGJan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:30:43 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7144A06
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649323718;
        bh=qrEk1KaQqHvx86BvGZbTrk+9iRUH0cmWZPEc61qHsBI=;
        h=From:To:Cc:Subject:Date;
        b=LDd5Jay6Ua4M7Rk3quFdJb8SgDPSuZjtqWrWwqliBIg5ntSUNjqp/XacMdFtX7jJp
         /X/fkzdKAMvVmFPEWFBR5+U+YOHa9IUv2mpP35DLCjkdZ6mH4VgDyKFE3QoEKTYe/d
         ap5kgwwuIo7p3ExFZYpafOI6djHPnxvewqi5BfBA=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 720A506C; Thu, 07 Apr 2022 17:28:32 +0800
X-QQ-mid: xmsmtpt1649323712txu21a4wf
Message-ID: <tencent_FE734C50BC851F2AB5FE1380F833A7E67A0A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj7gXE9EPckixmarPTNotNuv+oSnMoBzpUK/sMEAhv3nREl6ig4F
         WQJ6nhIBxe2K/G1fr9R9+gtZonkh3jygJuZ11VbRvBqkl5ltFnuySv/Ab/xXcSbXLs/I26jTHjYw
         Ue94j8EPgpcxzvysMVwld7y8MEbEIOq/E4BOaBeW8/kMyxhPwSTTiPQ3MOX7MDNLUB+lfky6+oMd
         uSxl0GUqHlZdpZPfN0KYKeI8Knxijp76AVpKZfEmmnom/CEKwg9NwiOzjILt4ZottQlcuA4isZI1
         jxGg2MFn2Mb6PNfTfBKhlDvxASNCfpkOwvK/HyWYTaivYPstV4gqChWxWclJgOXtuqQ1e3rHDwhR
         E5WFqZGKDFfXkByYRoqsN/qnitiIgXsAuSTKAgWxS8NCPyD1b0LuUYzoKuXImaZc9TchccBLE4tA
         AGZkm9AmCXPumw1p1FNP6y0N7vmQlAub0vil0WaN4TbWDQQuYFtKSMoDx7TLX+uXuhWYdIltiR2/
         m8okaFJ+Kqz6N/xt4eEy4Ejv2Qpa0E+yaT/LoU4xn4K9r6wbSd5PqfXbWty57ne8XcmBEQRArlAo
         tvk9rp2HNOnTwphtSaeWOHph0juckClHzUyvvcvC21s/1MCH6bM/EviXSKH0kfqUXbuJREFF0NA0
         K06MIYPG929N93yoTBdhpN9yLFKOqjkF8VuSm0p5ewxQZ9A23FBUtAl+Q9VBfugEZs8Y8dEtzglv
         59qZsx+fsWyxH1kfRDDeEPLQqZgkc7B5nUr8sxvZ9QjjXK6nq2/hh3kOxBzwz0oJLrdLP0lYNzEi
         O6gTz8WCRcBZXshOfUfT90itR1do5p+lKNawaEIIkv155skoaya19lO4/5+nSKYFti2oNGuFtpQ8
         dnp9yrsJiXTwC73mMqm8VB9ggIKxe9oaUuRGmwP+W6fQrZFg+LgM9XTS8FcnYFgHCn+hiihv4tru
         6p8ph7Pu7QCPHt1RcbTWBImgJyEfXKKucZRq8W7nEeBuH89iORSw==
From:   xkernel.wang@foxmail.com
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com
Cc:     martin.blumenstingl@googlemail.com, p.zabel@pengutronix.de,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] clk: meson: meson8b: fix a memory leak in meson8b_clkc_init_common()
Date:   Thu,  7 Apr 2022 17:28:23 +0800
X-OQ-MSGID: <20220407092823.14526-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

`rstc` is allocated by kzalloc() for resetting the controller register,
however, if reset_controller_register() fails, `rstc` is not properly
released before returning, which can lead to memory leak.
Therefore, this patch adds kfree(rstc) on the above error path.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/clk/meson/meson8b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index a844d35..823eacc 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3741,6 +3741,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 	if (ret) {
 		pr_err("%s: Failed to register clkc reset controller: %d\n",
 		       __func__, ret);
+		kfree(rstc);
 		return;
 	}
 
-- 
