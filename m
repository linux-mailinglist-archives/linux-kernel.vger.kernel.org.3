Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE06C5A1CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiHYWns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243785AbiHYWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:43:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4B5C6B51
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:43:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u6so60985eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balfug.com; s=gm;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qHBRNjLQO+fTuSN5fkgAMVOPdbNt+emprPz8tTnQjyY=;
        b=O4UTbQ8SFax9TaiplcN7GgB5UzuOvNTwOTsK7SBU68+NkCZQcCQBnkLFfwckNexR4t
         k/yjST8y0+midTKeabpDc/oHmyb1HM0DUOmaTc94msibXEL/difjzNhtjAWwz/1yV1yI
         BzOCtG2+KnI3a7IM/WgZpAQw5ujqxZSG6aV9PrnussqXuj8kdU5ZaYI8nsJR3GBnKKrA
         ump+D+e/DrLZfF3nIYZzdWd6SM4dbjHJ++sDCQnY0YWEzHVYWw0wW08phtq3a5X8IoYx
         mon96Cs6e55YtsyIOS5qDIWPOxLukwfyl92Gvq3qwANMpjJNe/u0P1Q5OISPzEtRYtPu
         4xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qHBRNjLQO+fTuSN5fkgAMVOPdbNt+emprPz8tTnQjyY=;
        b=UNsgTJ0hzQm/wx8eN2ADTwcLMFTHMEEXwIKuHtlA8SGWmZSATu9H8l7ic/+rbBIYLA
         iNNNZb23T+PW/FPWJKuGAHVluomWyEeYGWnL6VCIn6UYSth/rzxBA4Ig14quiSptiglA
         zapTO7yGiajvkgLj5H59MDzhZ2RQCSGgLy3qAVevfDknOE7LiX+ra/5DK+o+HWTlTdvU
         8pN9sBToU0p+HfxW2FGuTX5OZ4WgDJRxb2ClYCqDhw7eattvUGlJb1M8IuU/zXpuUIY/
         G5vraPge16Lnurd8Jc3Rsof8ILX94Ri2M9EUOvL3Vx2p7eOAGAL1isRINXCPiIwLgGFF
         98WQ==
X-Gm-Message-State: ACgBeo1J9sPbs70rv+EQaos4RZguQ18st/q7jyVUoIAug2vB5j1/3/2V
        hzpHEts0u38EJ0ELEJC/r2NHYA==
X-Google-Smtp-Source: AA6agR6I828Vg1tmwrNDsZMZ182b3qTLPeA21GD7WMdDXjTIchau04EevrIBfuBnluvqLTScsjR60g==
X-Received: by 2002:a05:6402:2499:b0:440:942a:40c2 with SMTP id q25-20020a056402249900b00440942a40c2mr4952533eda.37.1661467418799;
        Thu, 25 Aug 2022 15:43:38 -0700 (PDT)
Received: from localhost.localdomain (20014C4E198D65010944FE0C94C0B856.dsl.pool.telekom.hu. [2001:4c4e:198d:6501:944:fe0c:94c0:b856])
        by smtp.gmail.com with ESMTPSA id i2-20020aa7c702000000b0043cb1a83c9fsm357529edq.71.2022.08.25.15.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:43:38 -0700 (PDT)
From:   Szabolcs Sipos <labuwx@balfug.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szabolcs Sipos <labuwx@balfug.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Add RTL8761BUV device (Edimax BT-8500)
Date:   Fri, 26 Aug 2022 00:42:08 +0200
Message-Id: <20220825224208.343700-2-labuwx@balfug.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825224208.343700-1-labuwx@balfug.com>
References: <20220825224208.343700-1-labuwx@balfug.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=7392 ProdID=c611 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Edimax Bluetooth Adapter
S:  SerialNumber=XXXXXXXXXXXX
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Szabolcs Sipos <labuwx@balfug.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ecedaee1d965..87d377212214 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -528,6 +528,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x8771), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x7392, 0xc611), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
-- 
2.37.2

