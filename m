Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6487050CA4D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiDWNFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiDWNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:05:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2C1F0420
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h1so10495234pfv.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+3gUIKqgjIoqwfyRdl1gl0gu9sfmeEdgyuQbdCNe5BA=;
        b=LN46w5S3b44hmyqlW8bleygWumr9HpM35L/IWvTsW2aVpra7CrkWWp7so/GivC7wS4
         K9iUcT4o8T+bZXihS+zOeHAmcmoTBKE0otsLwcElfTrewYuDDKDbNBRwLoutCrt/de0W
         8We+i7z52FruY7VU3uCd5NXYM5sa2Qx4H+VCEDgkyMOfHOGoL4Ym1IbuNDbt0CuXOB2X
         DtlVR+fgZWKYWiNjmYrIECen7dFpfqG8zAEGwlktMSZP3W3WEVVKwMTOd1zlxK76TUzf
         S/xfImg2o2KaLtfuNhtAw8GjMahPILScWywueuVqyvYpbWABvLcZpNTYrnD1Cxt6NSVB
         L8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3gUIKqgjIoqwfyRdl1gl0gu9sfmeEdgyuQbdCNe5BA=;
        b=Im1IXjf4yO014QUig/eI5L1YQXgLpw2DjQub0b2/HO8CEspK2QBswqQ5D362ON1aCc
         6YNgxTRyQ2vxHI2dfjV2+4yyUHQAkg2bmiAKNHZy8iMcU0cX5v2hp73k99Hvpg6539qa
         qA7cBqQCWka83nPkeg3CBveUOhLFBE6P2nigkGmrC3GK35KOZG0gH6A7snND4Q/07v2+
         que2RXX+D3ytB4z4pXA+bBlBCI3MJ4xldpwB7xPJvv7dsekp/5glvsqjjXWONYDJHxvu
         Z+o8uUktXUqLzV7iB0nka3x6hGbCM3ZfzUAdbZcl0vHhyahf0ssvAWIyDmnurgg49Jub
         SVqg==
X-Gm-Message-State: AOAM533n9WYSRnFgrtkWc/AoDMgiCvtX9tJikO2Cib5n2ZbsXjwWYnn9
        MCjYN+gmdWyG4HMFe8NtW4xshDrG4Ew22Q==
X-Google-Smtp-Source: ABdhPJzLZyrXSGRaOPPlqezEIm/raJzvDqC2gZAi8gNTlVurCBybd2ZOdD+ntz/RHhOcwoeeuMs3Tw==
X-Received: by 2002:a05:6a00:2186:b0:4f7:5544:1cc9 with SMTP id h6-20020a056a00218600b004f755441cc9mr9719631pfi.62.1650718937763;
        Sat, 23 Apr 2022 06:02:17 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm5808994pfb.129.2022.04.23.06.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:02:17 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 3/7] staging: rtl8192e: Remove unnecessary u8 cast in comparison
Date:   Sat, 23 Apr 2022 21:01:46 +0800
Message-Id: <20220423130150.161903-4-wjsota@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423130150.161903-1-wjsota@gmail.com>
References: <20220423130150.161903-1-wjsota@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the macro VERSION_8190_BD is defined to be 0x3, and the structure
members card_8192_version and IC_Cut are both u8, an explicit u8 cast is
unnecessary.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 4fe806eae5b7..b608540c036c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -811,7 +811,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 	rtl92e_config_mac(dev);
 
-	if (priv->card_8192_version > (u8)VERSION_8190_BD) {
+	if (priv->card_8192_version > VERSION_8190_BD) {
 		rtl92e_get_tx_power(dev);
 		rtl92e_set_tx_power(dev, priv->chan);
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 1b70c12be365..b7bdbd895e7b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -919,7 +919,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				continue;
 			switch (CurrentCmd->CmdID) {
 			case CmdID_SetTxPowerLevel:
-				if (priv->IC_Cut > (u8)VERSION_8190_BD)
+				if (priv->IC_Cut > VERSION_8190_BD)
 					_rtl92e_set_tx_power_level(dev,
 								   channel);
 				break;
-- 
2.36.0

