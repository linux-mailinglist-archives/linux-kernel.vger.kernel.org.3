Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C074C1170
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbiBWLhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiBWLhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:37:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB7DBC91
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:36:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f17so14240976wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=converge.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fuv+HoeuuFNBFLzARsrok2ReIyO8tsmLZ6isq9BRJJ0=;
        b=C68QlCbSiKFXW0MkjaD+O0MTlBy51OTMsw4tPIpfgss395Aj26cyeQyJuu5JGvLssP
         5LhLEakwIbZI1MvdvyyH7QyRTmlRMvio7i5My6YXYB27aGWzvv8CFPbovASMgx1VnN04
         TNOruFq5UUp+vIhUMISkq9WXbDFXx7v5qPjgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fuv+HoeuuFNBFLzARsrok2ReIyO8tsmLZ6isq9BRJJ0=;
        b=WfANjZ+kbw4GhsEToYnLQEFOfetVxsM1padkt2G/PYQ4QQxN9VJV8hn1wVphy7/MqP
         +Kj8KjQVqc6JjCmDXESniZA55nvuTq+lWBUIM9Hw71uaoXqJkmMy3ZVMU0QAvijrVfru
         p0g1d7cJxphLihWumMUNKVvtBBJOmTEGMfhsMOrYEjF4hhE1c4w9M1JFwYp17dZladne
         eZlk1OsTnRWnjLfWE3kTvrV+ygl+xwLT8sPeUAEzEA2LGw8W50Ao/RWpfUadZsdR4izR
         j+3ItEVIy5Ve3pnP6HIXBLp8wTS+ZPyQle7k9I3nX7mK4d2GBuKAQ5IoT8mLnzCbhzZy
         yEKQ==
X-Gm-Message-State: AOAM532WFMiLbOA4DX1FQNvSA9zCDc5AOB+hOHZoletl9tBBspzJxnaA
        JaJxqXKCIHGdYI/ik2mXwpnpCA==
X-Google-Smtp-Source: ABdhPJwy/OcljsfdGSQuD0p5mHZzYEw4S5DMC6+xUsDeM5qLe9yjveTBprXEmfWAOUxZdaSsYcunUQ==
X-Received: by 2002:adf:fd07:0:b0:1e3:1af8:c834 with SMTP id e7-20020adffd07000000b001e31af8c834mr23177633wrr.629.1645616192384;
        Wed, 23 Feb 2022 03:36:32 -0800 (PST)
Received: from trublion.medusa.local ([217.138.23.146])
        by smtp.gmail.com with ESMTPSA id m62-20020a1c2641000000b00380d0cff5f3sm4989531wmm.8.2022.02.23.03.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 03:36:32 -0800 (PST)
From:   Lucas Denefle <lucas.denefle@converge.io>
To:     zbr@ioremap.net, lucas.denefle@converge.io
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Yang Guang <yang.guang5@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] w1: w1_therm: fixes w1_seq for ds28ea00 sensors
Date:   Wed, 23 Feb 2022 11:35:55 +0000
Message-Id: <20220223113558.232750-1-lucas.denefle@converge.io>
X-Mailer: git-send-email 2.35.1
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

w1_seq was failing due to several devices responding to the
CHAIN_DONE at the same time. Now properly selects the current
device in the chain with MATCH_ROM. Also acknowledgment was
read twice.

Signed-off-by: Lucas Denefle <lucas.denefle@converge.io>
---
 drivers/w1/slaves/w1_therm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 565578002d79..c7b8a8e787e2 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -2089,16 +2089,20 @@ static ssize_t w1_seq_show(struct device *device,
 		if (sl->reg_num.id == reg_num->id)
 			seq = i;
 
+		if (w1_reset_bus(sl->master))
+			goto error;
+
+		/* Put the device into chain DONE state */
+		w1_write_8(sl->master, W1_MATCH_ROM);
+		w1_write_block(sl->master, (u8 *)&rn, 8);
 		w1_write_8(sl->master, W1_42_CHAIN);
 		w1_write_8(sl->master, W1_42_CHAIN_DONE);
 		w1_write_8(sl->master, W1_42_CHAIN_DONE_INV);
-		w1_read_block(sl->master, &ack, sizeof(ack));
 
 		/* check for acknowledgment */
 		ack = w1_read_8(sl->master);
 		if (ack != W1_42_SUCCESS_CONFIRM_BYTE)
 			goto error;
-
 	}
 
 	/* Exit from CHAIN state */
-- 
2.35.1

