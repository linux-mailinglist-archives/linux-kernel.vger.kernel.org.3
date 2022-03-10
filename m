Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3E24D518E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245665AbiCJSzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245706AbiCJSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:55:37 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBABD19D631
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:54:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so14117447eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Ri3bVYAnXxiYaGvnRik7h4+hlVS0hY9TiXALlzUhYY=;
        b=p71WLpom8CBwzQ6n96+OVUxb6GViE1ixM0pX7SHAUOMnypb4usr/7l3ZI8BBeMBogO
         khv3FXbQW84AHPqwX5QhyfH/sSAw+uk8AE9uAPkvFsJfllcc6ffWMPkYWA347lWLRJA4
         fFUvRhwT78CjOPys2ESfDJjmLOQ/3oSteEUTJSfI/jBvTo8wD4bRyhFVGidh3pBCSqBW
         sAQ29bkcFvLRnTdCepzYQsUPZYxA7SRYwx1eXrmWXImLk5jCFN+pn22TBvgXJ6uL55EG
         YHMi07ioLa3TTJLNn5VjKU4Jfk2rwJfCw5QGraeEyexhWOjsrxaRQddQPPsTBDL5Zp3M
         rtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Ri3bVYAnXxiYaGvnRik7h4+hlVS0hY9TiXALlzUhYY=;
        b=7ehayZXn+hp5P86BzxHTEqt4Qqy1WNidWgzpj8t/noHktFPB9S/++lybGB/ZEUsZOQ
         mAuKTv98q8aJ/OdNT8TKtSDDYkbaGVEU3TwiBdGgopD1V+42G3zWIW4IeTLOWRD/FcgK
         moXeVS9iORuaDh6uVBSO30ZOu4mpDQi35AZOCbW6V0VuXa5pmaCaY4d1LlzYVmRgRt3U
         1hgV/ai1T42H74TFlK/ARnJadZzTk9VCTkTSFGdsuWQLHJYDTYG1W0LhWQrhrhCBklUW
         HlZnLep8XB3GMqlfESFxL9q5N6PswwF/muszMWsdifX09Js394LtNDloQFghZgu62JVp
         1nQQ==
X-Gm-Message-State: AOAM530O3ka8HxT3te6vZCHLYHh53NLR2wsZtIC6rQwWb4/+ehCXESZr
        NSJy0YGwlgPTzUQ6loXYDZAklYL6+B0=
X-Google-Smtp-Source: ABdhPJxipjjuA2Ab6aX2ZDzxYGE88i39T+CjYXvbZ985rHUeM5A3y5p+xuWoejkSr4Bdjb6Et8wHVQ==
X-Received: by 2002:a17:907:1c8c:b0:6d8:795b:b458 with SMTP id nb12-20020a1709071c8c00b006d8795bb458mr5283423ejc.706.1646938473217;
        Thu, 10 Mar 2022 10:54:33 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id fs6-20020a170907600600b006da8ec6e4a6sm2071346ejc.26.2022.03.10.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:54:32 -0800 (PST)
Date:   Thu, 10 Mar 2022 19:54:29 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: vt6656: Remove unused rf_type in rf.c; top level
Message-ID: <e111923dffc4781cf9d4e7966c9f365beb93c5ee.1646935331.git.philipp.g.hortmann@gmail.com>
References: <cover.1646935331.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646935331.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rf_type that supports 5GHz band.

To keep a better overview this is only the first part of the patch.
Compiler Warings about unused variables will be removed with the following
patch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6656/rf.c | 65 ++-----------------------------------
 1 file changed, 2 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index b9c06b312ae1..6f57f7af1aed 100644
--- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -528,10 +528,6 @@ static const struct vnt_table_info vnt_table_seq[][3] = {
 		{&al2230_init_table[0][0], CB_AL2230_INIT_SEQ * 3},
 		{&al2230_channel_table0[0][0], CB_MAX_CHANNEL_24G * 3},
 		{&al2230_channel_table1[0][0], CB_MAX_CHANNEL_24G * 3}
-	}, {	/* RF_AIROHA7230 init table, channel table 0 and 1 */
-		{&al7230_init_table[0][0], CB_AL7230_INIT_SEQ * 3},
-		{&al7230_channel_table0[0][0], CB_MAX_CHANNEL * 3},
-		{&al7230_channel_table1[0][0], CB_MAX_CHANNEL * 3}
 	}, {	/* RF_VT3226 init table, channel table 0 and 1 */
 		{&vt3226_init_table[0][0], CB_VT3226_INIT_SEQ * 3},
 		{&vt3226_channel_table0[0][0], CB_MAX_CHANNEL_24G * 3},
@@ -540,14 +536,6 @@ static const struct vnt_table_info vnt_table_seq[][3] = {
 		{&vt3226d0_init_table[0][0], CB_VT3226_INIT_SEQ * 3},
 		{&vt3226_channel_table0[0][0], CB_MAX_CHANNEL_24G * 3},
 		{&vt3226_channel_table1[0][0], CB_MAX_CHANNEL_24G * 3}
-	}, {	/* RF_VT3342A0 init table, channel table 0 and 1 */
-		{&vt3342a0_init_table[0][0], CB_VT3342_INIT_SEQ * 3},
-		{&vt3342_channel_table0[0][0], CB_MAX_CHANNEL * 3},
-		{&vt3342_channel_table1[0][0], CB_MAX_CHANNEL * 3}
-	}, {	/* RF_AIROHA7230 init table 2 and channel table 2 */
-		{&al7230_init_table_amode[0][0], CB_AL7230_INIT_SEQ * 3},
-		{&al7230_channel_table2[0][0], CB_MAX_CHANNEL * 3},
-		{NULL, 0}
 	}
 };
 
@@ -641,24 +629,6 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
 
 		break;
 
-	case RF_AIROHA7230:
-		if (ch->flags & IEEE80211_CHAN_NO_OFDM)
-			ret = vnt_rf_write_embedded(priv, 0x111bb900);
-		else
-			ret = vnt_rf_write_embedded(priv, 0x221bb900);
-
-		if (ret)
-			return ret;
-
-		/*
-		 * 0x080F1B00 for 3 wire control TxGain(D10)
-		 * and 0x31 as TX Gain value
-		 */
-		power_setting = 0x080c0b00 | (power << 12);
-
-		ret = vnt_rf_write_embedded(priv, power_setting);
-		break;
-
 	case RF_VT3226:
 		power_setting = ((0x3f - power) << 20) | (0x17 << 8);
 
@@ -714,11 +684,6 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
 
 		break;
 
-	case RF_VT3342A0:
-		power_setting =  ((0x3f - power) << 20) | (0x27 << 8);
-
-		ret = vnt_rf_write_embedded(priv, power_setting);
-		break;
 	default:
 		break;
 	}
@@ -766,10 +731,8 @@ void vnt_rf_rssi_to_dbm(struct vnt_private *priv, u8 rssi, long *dbm)
 	switch (priv->rf_type) {
 	case RF_AL2230:
 	case RF_AL2230S:
-	case RF_AIROHA7230:
 	case RF_VT3226:
 	case RF_VT3226D0:
-	case RF_VT3342A0:
 		a = airoharf[idx];
 		break;
 	default:
@@ -790,17 +753,11 @@ int vnt_rf_table_download(struct vnt_private *priv)
 	case RF_AL2230S:
 		idx = 0;
 		break;
-	case RF_AIROHA7230:
-		idx = 1;
-		break;
 	case RF_VT3226:
-		idx = 2;
+		idx = 1;
 		break;
 	case RF_VT3226D0:
-		idx = 3;
-		break;
-	case RF_VT3342A0:
-		idx = 4;
+		idx = 2;
 		break;
 	}
 
@@ -831,23 +788,5 @@ int vnt_rf_table_download(struct vnt_private *priv)
 				     table_seq[VNT_TABLE_1].length,
 				     table_seq[VNT_TABLE_1].addr);
 
-	if (priv->rf_type == RF_AIROHA7230) {
-		table_seq = &vnt_table_seq[5][0];
-
-		/* Init Table 2 */
-		ret = vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
-				      MESSAGE_REQUEST_RF_INIT2,
-				      table_seq[VNT_TABLE_INIT_2].length,
-				      table_seq[VNT_TABLE_INIT_2].addr);
-		if (ret)
-			return ret;
-
-		/* Channel Table 2 */
-		ret = vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
-					     MESSAGE_REQUEST_RF_CH2,
-					     table_seq[VNT_TABLE_2].length,
-					     table_seq[VNT_TABLE_2].addr);
-	}
-
 	return ret;
 }
-- 
2.25.1

