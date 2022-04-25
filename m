Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D8650D7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiDYD7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbiDYD7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:59:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59662326E0;
        Sun, 24 Apr 2022 20:56:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k14so12386896pga.0;
        Sun, 24 Apr 2022 20:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRYoxd4SVcaYEgYokuQbUOJXKX9A1z1JFiyvn7Q7fAk=;
        b=jdKLJO/DgNU4XwfRtwLmT6K93znOtIz79LvBpvHyt225nnMskN7zRJBDrfqWJer7sz
         QMRi9NB5nwrMvxTV8AjMpnlshoKu0El3zZCjMDi7hw6/cBI03oFILfUJ1IIXdPoJM54o
         RVvRH/sZA0lmE1OcMEVOJrIXwy7k3HLB+e5ll2AVmopvYJJsLgp4BOCNWsXun903qiMV
         XCOQnHxHHZzIsc+3EOgDJEJ1fSpfSkuHJCf6OCy7y7ZVTsVz33bGsMk3qhCuynOn7WMS
         nCjyxjh54j4MR+AzSIvSQGxML5D/1ra8EJCXXhiWBUcL4mzVerTMXlJeijdm3dN5k5FF
         5rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRYoxd4SVcaYEgYokuQbUOJXKX9A1z1JFiyvn7Q7fAk=;
        b=F7bhBiR69XDF8oDcU/ub9kH1L6cJQahVl4A5HOfWYw+tjSo75EggG00nUhDSh7umK/
         oj82Lsvbu/wGRj5eAObRevENFdoOow72Av36WLY4JY23LkdTFA9bfeElYvL4spk2xtgD
         uGOjxRLXVcVyxbMOpdvYASYsNrE0AwwYDgVYCghtPy7BZPg2KXfEBaZ1LHSUdwA1ejE0
         K7aLUK7/WknRslTL27Z+jeuTkkapZAEe5yeZqIYwERTI9W+RjVLP2L9JE3FjUkhrfE5K
         u48+iIbpN/lA5ijNHAf3Pr8997GZxaudjmW05P2RRQo4MyOcK+m5yH0gcUbmH8wbIGzd
         cVsA==
X-Gm-Message-State: AOAM53150z91Or9YNf5viTsdVTeJiI0KXLxQ/PCVot30Ojb1tQpBEziZ
        YWBPlrAhN8N3Yl1FfXyOyX5h7y6spHuUKw==
X-Google-Smtp-Source: ABdhPJyvohF2mxJIDNu78p/OKu6B2/C8x6iyU+yZ8mxW1TvHW9NQI2XkF2PBcDR24NESDzSLO4NMxA==
X-Received: by 2002:a63:fd07:0:b0:3aa:1cd9:194f with SMTP id d7-20020a63fd07000000b003aa1cd9194fmr13536057pgh.509.1650858970763;
        Sun, 24 Apr 2022 20:56:10 -0700 (PDT)
Received: from ethan-Latitude-7280.localdomain (125-228-239-174.hinet-ip.hinet.net. [125.228.239.174])
        by smtp.googlemail.com with ESMTPSA id n59-20020a17090a5ac100b001cd498dc153sm15123367pji.3.2022.04.24.20.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:56:10 -0700 (PDT)
From:   Ethan Yang <ipis.yang@gmail.com>
X-Google-Original-From: Ethan Yang <etyang@sierrawireless.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gchiang@sierrawireless.com, ipis.yang@gmail.com,
        Ethan Yang <etyang@sierrawireless.com>
Subject: [PATCH v2] add support for Sierra Wireless EM7590 0xc080 and 0xc081 compositions.
Date:   Mon, 25 Apr 2022 11:55:20 +0800
Message-Id: <20220425035520.4717-1-etyang@sierrawireless.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220425034204.4345-1-etyang@sierrawireless.com>
References: <20220425034204.4345-1-etyang@sierrawireless.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support for Sierra Wireless EM7590 0xc080 and 0xc081

Signed-off-by: Ethan Yang <etyang@sierrawireless.com>
---
 drivers/usb/serial/qcserial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index c18bf8164bc2..586ef5551e76 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -166,6 +166,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
+	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
+	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */
-- 
2.17.1

