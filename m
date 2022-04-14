Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6014E500B59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbiDNKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbiDNKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED446FA2A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s25so5337533edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFWSbvyg+22b/MTXpAJu7hFpGo/4sj3aFOsTXUdx0xU=;
        b=QyV2bqbB67CEvoWLL+KxlN8vK+MHpp1Sd1EBlVNcejR3Jac427hCRQNr4Sg17bXh5J
         5pBDvjAs0EYgGiLDKqkIS9ihJtHNmxqrMU2M0n5DIEdcY8eyLb1Si4mhVD7Wx7OP4RMU
         r8YlaMAaPkX7YDyqH5H4KdcWalyHglva0b58jrZP3lxhKQfjwgrj1KZIYWVxiHG2mMty
         cvFK7XMq7+KvMg8vIxRwTjAWTzXFhBMZoEjO7CfgSEjA19j5h7wdcR+B9FU1zpct42I3
         ZCjM9kAeyrUlgVVBQfZIjcCsGjqLRuNsjKAHhOxUADOPkqW1+wVPXNt1BkMMw/AhWPcO
         zmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFWSbvyg+22b/MTXpAJu7hFpGo/4sj3aFOsTXUdx0xU=;
        b=aVIdr+IkKWwHMPxp7ICYWQxKa4rPXWfuQn3Tmw1QdeyFfMbxp3QJFwET40QC5e98q5
         VKrO4Fx8HnJKQ/i3wJijRm5k7khyVrnPJOUkebUXTKg0x7fLit3fudjkUhcwfQamJL3J
         2FkRdUCR6Vcgf7AM/+MVgFX6CalmbO+jHaQm2WQUZ6VXFfZQ6xFAFgE1zFm0wW/NUtGS
         qkZWc4rhDtce6FgJk6AT1hj0UYfWfiLxEcqMi8IAFoYvDCK40FxAX/4DYAVC3MQMJOv2
         yBaDtreaTV2EjyXyKvXh//02rfBG/TLhbeiabLct/PSkWxBBq9tqUIQ8gVpqhQmquBCZ
         yt8w==
X-Gm-Message-State: AOAM531GeGtcgbyXtCQQM8oCH2kb1032U4QrNEtd6Yevv/tKdAeQMiIn
        YQvA4Rcq1oZ52rz4nSY/Zlo=
X-Google-Smtp-Source: ABdhPJwo5OS8VI7zAySQPUrSJFOPG8ga1uuwWy1rlKpZKAVE0RwTl6dsqS/eI1kUmqChDbVRmgbXRA==
X-Received: by 2002:a05:6402:4407:b0:421:21be:376b with SMTP id y7-20020a056402440700b0042121be376bmr1583976eda.294.1649933027522;
        Thu, 14 Apr 2022 03:43:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/8] staging: r8188eu: fix struct rt_firmware_hdr
Date:   Thu, 14 Apr 2022 12:43:16 +0200
Message-Id: <20220414104323.6152-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414104323.6152-1-straube.linux@gmail.com>
References: <20220414104323.6152-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure rt_firmware_hdr is wrong, there are two issues.

The first issue is that the size of struct rt_firmware_hdr is 33 bytes
but the header in the firmware file is 32 bytes long.

The hexdump of rtl8188eufw.bin shows that the field Rsvd1 of struct
rt_firmware_hdr should be u8 instead of __le16.

OFFSET      rtl8188eufw.bin
-----------------------------------------------------------
0x00000000  E1 88 10 00 0B 00 01 00 01 21 11 27 30 36 00 00
0x00000010  2D 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00000020  02 45 4E 00 00 00 00 00 00 00 00 00 00 00 00 00

0x00000000  E1 88 10 00 0B 00 01  00     01     21    11    27 30 36 00 00
                              ^   ^      ^      ^     ^     ^
                     Subversion   Rsvd1  Month  Date  Hour  Minute

This was figured out by looking at struct rtlwifi_firmware_header in
drivers/net/wireless/rtlwifi/wifi.h and the firmware file that the
rtlwifi/rtl8188ee driver uses.

The second issue is that the u16 and u32 fields sould be __le16 and
__le32.

Change the field Rsvd1 to u8 and the u16, u32 fileds to __le16, __le32.

Both issues had no effect because the header size is actually hardcoded
to 32 where it is used in the code. Also the fields after Subversion
are not used and the bytes of the u16 and u32 fields are all zero.

Fixes: 7884fc0a1473 ("staging: r8188eu: introduce new include dir for RTL8188eu driver")
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 8620f3c92b52..7cd08268f3b9 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -29,7 +29,7 @@ struct rt_firmware_hdr {
 					 *  FW for different conditions */
 	__le16		Version;	/*  FW Version */
 	u8		Subversion;	/*  FW Subversion, default 0x00 */
-	u16		Rsvd1;
+	u8		Rsvd1;
 
 	/*  LONG WORD 1 ---- */
 	u8		Month;	/*  Release time Month field */
@@ -42,11 +42,11 @@ struct rt_firmware_hdr {
 
 	/*  LONG WORD 2 ---- */
 	__le32		SvnIdx;	/*  The SVN entry index */
-	u32		Rsvd3;
+	__le32		Rsvd3;
 
 	/*  LONG WORD 3 ---- */
-	u32		Rsvd4;
-	u32		Rsvd5;
+	__le32		Rsvd4;
+	__le32		Rsvd5;
 };
 
 static void fw_download_enable(struct adapter *padapter, bool enable)
-- 
2.35.1

