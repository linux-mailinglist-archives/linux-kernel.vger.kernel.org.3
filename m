Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1AF4D7510
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiCML6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 07:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCML6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:58:30 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8479BE3398;
        Sun, 13 Mar 2022 04:57:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l18so7881967ioj.2;
        Sun, 13 Mar 2022 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwtHbOYBAHvTkXWaEDlnEeOYsI2vNh0rAunNRD0QW2w=;
        b=URVBnu/V/NzOS0pCi1fOrZLkvVZYO0O8I1ooqwRtbnYesnTxDcztbz3uF3jeq3u+Bp
         zUbX/U49xJxe/GgLtq0l7uhNMKD6vVB2HIQp7uPGUykwYWTPYTcfKzQXsu/hP6SCslSr
         2x+5bH/iSTIUJprlfje1yAOdShsAbt+iJ27lYRH1cadhhOoJTERnlrtBRhf3vJHNBZU6
         ifqJEvS2xl5nNnlhpGs6PUpUsuN42Wv13r0S2+KOJu/ByY/J0zbR4lpu0bNWlUnerxvF
         y4Q6MPDHujkAWTMOmuOksDgv6ivHwlr9hqLuwJ7Y1Or611x5oK/A7L2RxU7ATt9ZXv+e
         5kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwtHbOYBAHvTkXWaEDlnEeOYsI2vNh0rAunNRD0QW2w=;
        b=1MRXkmR6IF6z0XyEVr2PFs5qgfm4A6/saw7iEx1apqZDO1OY7Y+Raj8Q/9/ybqQcor
         On2T4CMO9aVhfxyXLW8nuZ9Ffb1EE39I8Cb/YYmibTP7xrC3zhInOn2arkCjAMakkxvi
         3LBPFrd7FBGgsgo6nR92uf7oQjW6r8+iD9Xmd5En62bOofe/ewjGfRZCsOBZ/A7KIDgc
         reNmjMIxg5CZFk6z2TLlnzR1KNxVdojvkycQiYhMlAbby9CqohKBNT1H8VioISsUdS+g
         HLeiD+MnXw4E+plWwoq5xDaOL3CMeRsOYc4cAc7gwYMPvw5IKf9U+tkF3q/4wArVbP0I
         Gmhw==
X-Gm-Message-State: AOAM533AeOXyq//0iLYu8paCu6F5E0gGOh+50DEqRC/0lMf8Tf0exzYF
        zvWWlW/JcvkqdqXYw09ChhIAwXcfwDo=
X-Google-Smtp-Source: ABdhPJzzp9rEKtYXk8Nk6/WUlkorAPHLcfAwIzy02wK/SuZGL/dfkKCXYCwqIReq8puHNjyqm+807A==
X-Received: by 2002:a02:b0d5:0:b0:317:c62c:cbcb with SMTP id w21-20020a02b0d5000000b00317c62ccbcbmr16245029jah.78.1647172642076;
        Sun, 13 Mar 2022 04:57:22 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e254:36c5:6684:5681])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e021a4f00b002c665afb993sm7797918ilv.11.2022.03.13.04.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 04:57:21 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, cstevens@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Claude Fillion <Claude.Fillion@mksinst.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL on 5p49v6965
Date:   Sun, 13 Mar 2022 06:57:04 -0500
Message-Id: <20220313115704.301718-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 5p49v6965 has a reference clock frequency doubler.
Enabling it adds versaclock_som.dbl to the clock tree,
but the output frequency remains correct.

Suggested-by: Claude Fillion <Claude.Fillion@mksinst.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index e7be3e54b9be..4d190579e874 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -1211,7 +1211,7 @@ static const struct vc5_chip_info idt_5p49v6965_info = {
 	.model = IDT_VC6_5P49V6965,
 	.clk_fod_cnt = 4,
 	.clk_out_cnt = 5,
-	.flags = VC5_HAS_BYPASS_SYNC_BIT,
+	.flags = VC5_HAS_BYPASS_SYNC_BIT | VC5_HAS_PFD_FREQ_DBL,
 };
 
 static const struct i2c_device_id vc5_id[] = {
-- 
2.34.1

