Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696C05048AF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiDQR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiDQR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DACD5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so23510438ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZTBfR/A89syNfUStFLmnUWCQR/KrbeiEyXxR04D+i4=;
        b=JbNAEqTXiQowm2n17xTXw3p55q/678/g4P2W8R2+Gq8DZeXcdqZKHqBnon1GuG6Rco
         e+gzkl0dUhLAp/TcbnXCaju0oWLkNLeHKiTQrWVZ2ORSxBWhtPvMQgBFM7qmM7hsgsP0
         WdADsG+v+sECo5fkpt0CapJF6C8QFMK4XmpS+2m1fcqEl9vbDMuIKrhBQk+KQ24OL21U
         PlbPKzuwYFpsSowSiSBIusykAvZUxwvCaxt5ihrYNeimVQO4X+1reeb1I5oHP+F8aFFk
         mCKF8hm0HWf+WVYEZnunVTD9eLk/rVRJRUoeMRiMp/IW64KXsdbvjeAPr/Mnc3yl59SF
         ID8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZTBfR/A89syNfUStFLmnUWCQR/KrbeiEyXxR04D+i4=;
        b=oDEGDpPR7HIl8yNKrF8iwm3Oo7zBFuaEl71Ey7YjXAZw77Oo6tEIJ2XSQlkXOd9MW9
         48OR60T3ml5SkP/ZfZUPHaxvkrm1fyLpUT45PpO7lXuPJaxZlyZ1yLw04W4663UN7eE1
         lP2Dguc/CSr6W1HD7LLRu+Zlc8FEkRwoJ6OOFQiy6he8fyrx0G7w/8NlEzeRh3lPg9VA
         dMpdJ/QmDRk9gzajTZKgttoV87SsAzPhMG9JJFkaKMVzvq8WracmaQKLe5CnnKREBIkW
         K1lk80I/6t5XPUoQ8fYRq313C32nQ8BGqD2q8PIjSdsJeBmFxkPB02/98XUEy3Noa38A
         nitw==
X-Gm-Message-State: AOAM5312Gf4XbvSbgE8dFViia7lLdlvjKKDZmelZouuUsXruaGsuNOXK
        pLZsIPdXr48Qxht5MRPFkUk=
X-Google-Smtp-Source: ABdhPJwXoFfnrFhj0GsJ8c2wFNj++cwxFiLjiiIn68WECW8SJS8vyxTlSYWX4RZpIp6goCLoEzlxXA==
X-Received: by 2002:a17:907:948b:b0:6d8:27f8:ab4a with SMTP id dm11-20020a170907948b00b006d827f8ab4amr6363899ejc.39.1650218088398;
        Sun, 17 Apr 2022 10:54:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 1/8] staging: r8188eu: fix struct rt_firmware_hdr
Date:   Sun, 17 Apr 2022 19:54:34 +0200
Message-Id: <20220417175441.13830-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417175441.13830-1-straube.linux@gmail.com>
References: <20220417175441.13830-1-straube.linux@gmail.com>
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

The size of struct rt_firmware_hdr is 36 bytes.

$ pahole -C rt_firmware_hdr drivers/staging/r8188eu/r8188eu.o
struct rt_firmware_hdr {
        __le16                     Signature;            /*     0     2 */
        u8                         Category;             /*     2     1 */
        u8                         Function;             /*     3     1 */
        __le16                     Version;              /*     4     2 */
        u8                         Subversion;           /*     6     1 */

        /* XXX 1 byte hole, try to pack */

        u16                        Rsvd1;                /*     8     2 */
        u8                         Month;                /*    10     1 */
        u8                         Date;                 /*    11     1 */
        u8                         Hour;                 /*    12     1 */
        u8                         Minute;               /*    13     1 */
        __le16                     RamCodeSize;          /*    14     2 */
        u8                         Foundry;              /*    16     1 */
        u8                         Rsvd2;                /*    17     1 */

        /* XXX 2 bytes hole, try to pack */

        __le32                     SvnIdx;               /*    20     4 */
        u32                        Rsvd3;                /*    24     4 */
        u32                        Rsvd4;                /*    28     4 */
        u32                        Rsvd5;                /*    32     4 */

        /* size: 36, cachelines: 1, members: 17 */
        /* sum members: 33, holes: 2, sum holes: 3 */
        /* last cacheline: 36 bytes */
};

But the header in the firmware file is only 32 bytes long.

The hexdump of rtl8188eufw.bin shows that the field Rsvd1 should be u8
instead of __le16.

OFFSET      rtl8188eufw.bin
-----------------------------------------------------------
0x00000000  E1 88 10 00 0B 00 01 00 01 21 11 27 30 36 00 00
0x00000010  2D 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0x00000000  E1 88 10 00 0B 00 01  00     01     21    11    27 30 36 00 00
                              ^   ^      ^      ^     ^     ^
                     Subversion   Rsvd1  Month  Date  Hour  Minute

With the change of field Rsvd1 from __le16 to u8 the structure has the
correct size 32.

$ pahole -C rt_firmware_hdr drivers/staging/r8188eu/r8188eu.o
struct rt_firmware_hdr {
        __le16                     Signature;            /*     0     2 */
        u8                         Category;             /*     2     1 */
        u8                         Function;             /*     3     1 */
        __le16                     Version;              /*     4     2 */
        u8                         Subversion;           /*     6     1 */
        u8                         Rsvd1;                /*     7     1 */
        u8                         Month;                /*     8     1 */
        u8                         Date;                 /*     9     1 */
        u8                         Hour;                 /*    10     1 */
        u8                         Minute;               /*    11     1 */
        __le16                     RamCodeSize;          /*    12     2 */
        u8                         Foundry;              /*    14     1 */
        u8                         Rsvd2;                /*    15     1 */
        __le32                     SvnIdx;               /*    16     4 */
        u32                        Rsvd3;                /*    20     4 */
        u32                        Rsvd4;                /*    24     4 */
        u32                        Rsvd5;                /*    28     4 */

        /* size: 32, cachelines: 1, members: 17 */
        /* last cacheline: 32 bytes */

The wrong size had no effect because the header size is hardcoded to
32 where it is used in the code and the fields after Subversion are
not used.

Fixes: 7884fc0a1473 ("staging: r8188eu: introduce new include dir for RTL8188eu driver")
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v4:
- no changes

v3:
- updated the commit message
- moved the u32 to __le32 conversions to a separate patch

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 8620f3c92b52..eb4ab11f6b28 100644
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
-- 
2.35.1

