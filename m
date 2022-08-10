Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D23258F463
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiHJW2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiHJW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:27:58 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CB8FD47;
        Wed, 10 Aug 2022 15:27:52 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id h8so12080710qvs.6;
        Wed, 10 Aug 2022 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=q1NGPCLDIdQwMRiHKVCYyEcH5qE/Uoqtt0LLnokNsTg=;
        b=IKx/c6rZ0dp3PHp8F49mo1PiSJ6BwdUpNvusmD1JASvQ1bCAgjOlXltClfsYF/gm/S
         qRN3oOzcK6idhEMRzaErOutJV14ZgNY/ZB6sw0K5t6PIJXZ8iGsd//TJn/ViyXPPGoFq
         C9iRCZFSdaiRcabpFE85bsPrmw1SMIoqShcMnG2IiL3ANU6BiDuMkES1jpdfoUODaAgW
         EYyjVd/4XbOpQDPebizoKv0/d8tY+ENx9iTIQEvHhZ8uOWwF+Rj2HLACFhSijZtSOirq
         2vjEvbpuCse/T2x/SFkE+3Xegmz51sJu7JWkv6wF9ZML0JYw5aM/sXP7LS3q6UFUDk+k
         I2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=q1NGPCLDIdQwMRiHKVCYyEcH5qE/Uoqtt0LLnokNsTg=;
        b=tE+27PgjTIsL0lCH+o+2KcN3Xc/g6KFFm5t4+DuzYydOBdBvZtn6m/ENuHmviQBKH2
         itrFk4UtfsEJtlKZEzbsXc5arY+ew6POBD1JuBx26q7pXuBfkKtmlcloTK7TuRFGAL9k
         XYqLsXpTKBVVhMa7oFmsQzd4pphEMepN9Q4tX2hesqO4YLrfusIddmVtBmZW5wWe57ye
         vZxNq/KhRjUXx5CEiKDs7Mzx2DuL0zkobZB3Y4ADJ6GEr1zu9E4L4Dtd+0uwJdFEHWEd
         6xOTrczHxfA2CjWmYTF9LZjBcKX/afXSLcbRcmcvq/xLvHWbTtkFCR3tP5EU1A5vt/OH
         A5xQ==
X-Gm-Message-State: ACgBeo02NLdie7d5lpYSMx8zm1moYQOGV3QBpboh3zrne3scKdvtJp9r
        4hF60Y7UiA9Xh2D3kQ9wA2A=
X-Google-Smtp-Source: AA6agR46FE2oTOMV5RXRMU9KCpPAUBmaFfkEuyE+YHwfPe3M7BQFP1NSyHpnrXNrwzjS3RwVwJ4t9Q==
X-Received: by 2002:a05:6214:f01:b0:477:7bdb:a020 with SMTP id gw1-20020a0562140f0100b004777bdba020mr25459196qvb.67.1660170471970;
        Wed, 10 Aug 2022 15:27:51 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006b8e8c657ccsm711341qkj.117.2022.08.10.15.27.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Aug 2022 15:27:51 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 2/2] usb: host: xhci-plat: suspend/resume clks for brcm
Date:   Wed, 10 Aug 2022 15:27:35 -0700
Message-Id: <1660170455-15781-3-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660170455-15781-1-git-send-email-justinpopo6@gmail.com>
References: <1660170455-15781-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

The xhci_plat_brcm xhci block can enter suspend with clock disabled to save
power and re-enable them on resume. Make use of the XHCI_SUSPEND_RESUME_CLKS
quirk to do so.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/usb/host/xhci-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index a68b2b0..62756d9 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -123,7 +123,7 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
 };
 
 static const struct xhci_plat_priv xhci_plat_brcm = {
-	.quirks = XHCI_RESET_ON_RESUME,
+	.quirks = XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS,
 };
 
 static const struct of_device_id usb_xhci_of_match[] = {
-- 
2.7.4

