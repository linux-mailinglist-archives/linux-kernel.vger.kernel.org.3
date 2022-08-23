Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563AB59EC72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiHWTfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiHWTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:34:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE8D4E;
        Tue, 23 Aug 2022 11:28:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g8so9657781plq.11;
        Tue, 23 Aug 2022 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OpAAIbRmUtdooRSc8Rz9ZxA5vB7ijPi1Sxv/YxOpbd0=;
        b=TQZ7Njj2HSqfRtNonDUamFWpQzengfi3aP/z9bMDz2hgz6sm33sjqV0Moga+WWDBk+
         XFPKoC//wiiYR2o6XMkiF2qLflgsyBnIiMf1R/t89RCCZ1ovAAF+njoXR+ypU6pK7pO2
         zXaMP0O3d1HKaKjQkT9xOdTQb7VG+blhBlGW8Ghy59ncG0gVgKmd3UvI97E/5itdCCOw
         V0SYtynPduFvzwRapuKXwdNX6OpCM4qOZDSA/y7cBYe10BliKEojfntsryU6uCvKox5V
         dOgjJ/KLnTCM/EL7QBMn+fScGvIlg+AIBWaQXaYXiWXgwhYJK1iAivVZVpOJjd+QLwT2
         eSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OpAAIbRmUtdooRSc8Rz9ZxA5vB7ijPi1Sxv/YxOpbd0=;
        b=3FYFNcITePVlD9ZDvlWhqZ8+rk1nSsy0yfqLoPggV4WXrBoqkiFg5+Gh4jSTunD14i
         6UgOStvGKc0jj5p41tPccN4RRahl7s/bYPvSJY0W7Tqk4MD0fUZBdlGBK2WNSOp30VXb
         c6USMDJ05zzP1MqhJhPAzlECK7m8LNPwtzD1VymxqblfljTKjJZkp8Ovn5+W35OEnaPZ
         3hwOFi942etdkZDmbn0WfpjJjw9Y3nAAJf8SQjlDdMhk98BJXM6BPfLq2f0ZVp2CA6sI
         zJdg+aDboNNDOZNCqEmga+e3pCwsqMLY/cKyzG3Dqt2T1pOOrVZzx/bvSfQWTKtfqPVi
         JkVw==
X-Gm-Message-State: ACgBeo1KEXMRB/57sUcU89hftkGJw8rf1cXlii13fmUcGwv8yyQhGBWV
        LB+PC7o56Pxb8Di0HBicsoc=
X-Google-Smtp-Source: AA6agR6QUGf4KzNGBA4P7wW4ovQFBCcvNBnlzOkfXTukL8GORqxCa2a2d0ra2N5k2Cn7+H1eRZDzPQ==
X-Received: by 2002:a17:902:e5d1:b0:16f:15a1:6dbc with SMTP id u17-20020a170902e5d100b0016f15a16dbcmr25391045plf.73.1661279296326;
        Tue, 23 Aug 2022 11:28:16 -0700 (PDT)
Received: from fedora.. ([103.159.189.136])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090a6e0d00b001f2fa09786asm10328798pjk.19.2022.08.23.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:28:15 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH 2/2] usb: ehci: Prevent possible modulo by zero
Date:   Wed, 24 Aug 2022 00:27:58 +0600
Message-Id: <20220823182758.13401-3-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823182758.13401-1-khalid.masum.92@gmail.com>
References: <20220823182758.13401-1-khalid.masum.92@gmail.com>
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

usb_maxpacket() returns 0 if it fails to fetch the endpoint. This
value is later used for calculating modulo. Which can cause modulo
by zero in qtd_fill.

Prevent this breakage by returning if maxpacket is found to be 0.

Fixes coverity warning: 1487371 ("Division or modulo by zero")
Fixes: 9841f37a1cca ("usb: ehci: Add support for SINGLE_STEP_SET_FEATURE test of EHSET")
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 drivers/usb/host/ehci-q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index eb31d13e9ecd..cf2585e9a09f 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -1221,6 +1221,8 @@ static int ehci_submit_single_step_set_feature(
 	token |= (1 /* "in" */ << 8);  /*This is IN stage*/
 
 	maxpacket = usb_maxpacket(urb->dev, urb->pipe);
+	if (unlikely(!maxpacket))
+		return -1;
 
 	qtd_fill(ehci, qtd, buf, len, token, maxpacket);
 
-- 
2.37.1

