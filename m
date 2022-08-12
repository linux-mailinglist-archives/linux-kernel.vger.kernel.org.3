Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF77591030
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiHLLkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHLLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:40:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5B1034;
        Fri, 12 Aug 2022 04:40:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w3so1013413edc.2;
        Fri, 12 Aug 2022 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1UkHTX9tiW35gZea892hMns6ALsK+5bsA3v9NBWFhv0=;
        b=JOkB70tvBMjf320dpziZwTnu91uxqkaRe3wmyXAHPxu9+FyhQQZIsj4ojtOAoZ+zxX
         FGnzgEWx/oNPC5IFDB5VpOQlEFtRpiL9E4z1H4TZggUv6XVjmi6uZqmGtmAnpxjPH43R
         e2+3zk3rdrzMYqNnAe9dhnAMAuW3GPVcYABWK3PSd3aGv1BMsd/kypCTtoNvoP8LC7rQ
         T0Xi0OAeDZjFzT85Gxyz09WW6cX+Ot7CvYv+F/KW+MIfcxx1MFXMiyBBp4mnU4rYtXc7
         SNrZzQzZpTDhoUB3eUzGqwkPiAl93eo5SIEIQGamvULsTqS0oAaaeNlCRJckoR3SZwJu
         CL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1UkHTX9tiW35gZea892hMns6ALsK+5bsA3v9NBWFhv0=;
        b=qc6QMxqE1xQ38LoKcd+ncyclOZTpJ8vobjxR6W14X2wB9d53J1OwWg2VRv/0X6sy9w
         n7zia9Cs5MyoyghiBqaEXhOAiIg4PwCd3LEUJymkhUX66HJNMer6VA0kd/ZqoaC3bzwb
         h06hMUPQQl4dFHqAl1UTbMZpJAJd5HfddnfWBty14r8kZbfKYystbJ6kK1F9ze2QQxks
         2FUSkQHQtuQHBokmQr6htaUdVknP+2KGzMbVgqLL27YsP2d0yKaB5DEcCxWApKGePFcl
         hZ5dL7HXO/APJ+0iW2MwHX5L7Ic5wNYa4arfIJJq0R0pe4emH01aMTkkaErlu9t/mZMv
         fd2A==
X-Gm-Message-State: ACgBeo2ju+bvV/Ce/Yv5L5z9cL2WIh/DcsVEK/pi9D/esnpmAoGI4xxW
        nnj+FrBJsSIeXD+7ewQ7NaF9bgIVPJEjdQ==
X-Google-Smtp-Source: AA6agR6G4HBLrUVRhrAxhmeuwLJ+ZkJK+M9dKyapjdHIrP7Yhk64u75T6A/1ujJADCVDM0TuJ6xmlw==
X-Received: by 2002:a05:6402:3689:b0:43e:43d6:6039 with SMTP id ej9-20020a056402368900b0043e43d66039mr3250463edb.341.1660304412828;
        Fri, 12 Aug 2022 04:40:12 -0700 (PDT)
Received: from fedora.. (188-167-140-93.dynamic.chello.sk. [188.167.140.93])
        by smtp.gmail.com with ESMTPSA id t19-20020a05640203d300b0043bbf79b3ebsm1223741edw.54.2022.08.12.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 04:40:11 -0700 (PDT)
From:   Wim Van Boven <wimvanboven@gmail.com>
To:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wimvanboven@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] drivers/bluetooth: add vendor and device id for liteon WCN685x device
Date:   Fri, 12 Aug 2022 13:38:23 +0200
Message-Id: <20220812113824.13168-1-wimvanboven@gmail.com>
X-Mailer: git-send-email 2.37.1
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

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=04ca ProdID=3a24 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms

Signed-off-by: Wim Van Boven <wimvanboven@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 15caa6469538..abb5721990ac 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -316,6 +316,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d0), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a24), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* QCA WCN785x chipset */
 	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
-- 
2.37.1

