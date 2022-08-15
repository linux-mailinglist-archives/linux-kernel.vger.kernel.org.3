Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DEC595244
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiHPF6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiHPF6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:58:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85F9D666
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:16:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c20so7009594qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2NHSu+WR71bWEHouMtYEYWTZ2k/kphqS/Xaa0m4gsqo=;
        b=RdxioX6rfZpldJqhwhtPJeZPySZfy2kj3BdriChWQwfUY6NXW7Q1VLICRE9Zqweb+r
         gwrzBdCRX9ofe59/sA+Er7wcZ8SfrC0yQr0qZB22kyXtTztAb7qfOQwR0BTKByvh2Xrk
         joGRbfm86wLLmTtUU7TYwtAh69+AuDDC0o0eBUeR6TMH8wLqlg1V+dx3+aoGzIgRzlM3
         4vd6VJyB8xZYordFoEIVcdJqW/Kx15ZctZTc3e9XPPcF4WE29vwD5iiFCcDa4M2e8ZRw
         6+zq8dzDFJ3sjxrvzA3MdARDyvfTOgJk+l9X0HGfcVt/BOEO685/Yfth3PuOYL0AbJbb
         Ebiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2NHSu+WR71bWEHouMtYEYWTZ2k/kphqS/Xaa0m4gsqo=;
        b=bHiVWJ/I/yGuv1nuZmWnbPTpnRJ11bMv+KRsQa3r4UI0Rc6U1vhte85AqFMMiKGub4
         PWbrw8pfh6Ec4YEjuyQgixV3owPHahj7HUKoiq6hEYw6rzRDIfZ5mDEZIYx27yV8ly8A
         iyM8me25Fb1VMEfZbanixxnGDTs6p9KfFxKhDugnk73lp5XUWhA+xTqsTDn0sU5QiW7s
         sfHpN9eDqItTb+9yMXasbs3+uBmeuvwjYYrDJGV8hBVqmZ9AK4CkpMqRdC30TPP+nkjR
         NDDtlwKweBIHBI/+6RUpfgtM09Nq9OVLvkLAxow9eXse+AIGQ6Z7TZBca0gTGAlhxJEb
         4CPQ==
X-Gm-Message-State: ACgBeo3enMQWuUvgSKVjWcG9u4HYm09AE7EJpjHPZSIz5mewiRUUsdMt
        U+fy5qwKmybUPVe/ds/u7bxLSVR6iqXqwD3z
X-Google-Smtp-Source: AA6agR5IQPzo2LnMl+iKR8S7dBMSEVPE5W7Xd5TxJPOPIUXUs6m6Q/yoaSd/tKdtwwHfQLCUx6+Wtw==
X-Received: by 2002:ac8:7fc5:0:b0:343:681d:c3fb with SMTP id b5-20020ac87fc5000000b00343681dc3fbmr16179373qtk.157.1660605392431;
        Mon, 15 Aug 2022 16:16:32 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u11-20020a05620a430b00b006b99b78751csm10441188qko.112.2022.08.15.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:16:31 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux@rempel-privat.de, kernel@pengutronix.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] counter: interrupt-cnt: Implement watch_validate callback
Date:   Mon, 15 Aug 2022 18:50:58 -0400
Message-Id: <20220815225058.144203-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt-cnt counter driver only pushes one type of event on only
one channel: COUNTER_EVENT_CHANGE_OF_STATE on channel 0. The
interrupt_cnt_watch_validate() watch_valid callback is implemented to
ensure watch configurations are valid for this driver.

Cc: Oleksij Rempel <linux@rempel-privat.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/interrupt-cnt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 3b13f56bbb11..05a5d3e2d2b0 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -139,12 +139,23 @@ static int interrupt_cnt_signal_read(struct counter_device *counter,
 	return 0;
 }
 
+static int interrupt_cnt_watch_validate(struct counter_device *counter,
+					const struct counter_watch *watch)
+{
+	if (watch->channel != 0 ||
+	    watch->event != COUNTER_EVENT_CHANGE_OF_STATE)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct counter_ops interrupt_cnt_ops = {
 	.action_read = interrupt_cnt_action_read,
 	.count_read = interrupt_cnt_read,
 	.count_write = interrupt_cnt_write,
 	.function_read = interrupt_cnt_function_read,
 	.signal_read  = interrupt_cnt_signal_read,
+	.watch_validate  = interrupt_cnt_watch_validate,
 };
 
 static int interrupt_cnt_probe(struct platform_device *pdev)

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2

