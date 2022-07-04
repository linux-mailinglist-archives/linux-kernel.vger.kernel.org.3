Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80F565D77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiGDSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiGDSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:21:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701D1146D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:21:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so6877331eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yRa0b2lHkl6grPBOgdI9i8N3apwm433ugj3fMKkyrCs=;
        b=fSQLvJyzlvpnzhnTI2Ak9Sv7ottO1qVYdA2ySP09FIwax4aP+tqPPa9rbbMIAioQm+
         jE+LY3fs00b53z6cAnEehmUPNJap5IchdfjkVvpMwBCgibdydF01naAS8mwdrf6DKCau
         6gwULgAW1lGUcZPIduH83HlIvcChfF9XQkAzwRRLazqzBGTo6iFpdGtCMLG0tocA4e5a
         eqs6RV/7/4qh9/4c0SkUKGs8bgiSvosZE7Cn7aDtYbqnZVnylYjqfFjQ7cRXApQ40H0A
         ocTxyZMwYIbE2zZegHpHYtdVMGdt+1Ib/3nF16q5l931DYRrmmWXsJSzOmj2uqoJtAPQ
         EUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yRa0b2lHkl6grPBOgdI9i8N3apwm433ugj3fMKkyrCs=;
        b=IH00WvaOYN499rnZducwO/UynB5DSZF/Q+m9cHzyqG0ouwK0eTfC9NqNqqWnqqeQ42
         9O9mslUnqk2THkSKo8i5SRJ7qKBYPw/6/lS+NNSD+eWIQgUIBIdFpjb6e0g/iLNT1ce/
         Jx196H+JcjOtgghZH+SCYnVyB5ZLRg14u32yF7lK5vGP2pX/l3X3S/vYj87lnvY3Efxx
         7G/S9upNGLIY8sCOp3/jf/7GEFTNHwHKJrV/yw1hkpltsxXe+e+86BcfkMOuzvG46OUr
         L7x482tyYZferA2IQDwxuwm2AsgPutA2EeoJzflO+oLuhcAAn1eBXtJSsHlPNN+xoEh7
         0GaQ==
X-Gm-Message-State: AJIora8eq3h26DLUxsBY2ts008lrTD1WzdLdyBEi773ILEqMTOQxJTFU
        YRH6euv0dXc4k3ecivcJqB8HTdyQWiA=
X-Google-Smtp-Source: AGRyM1uksjksaqdaQ6jjO6J9u02+r1D3WXjcJwB49/PeMgsYd32pribpvmokZbvr9Npoj4+EQdxxag==
X-Received: by 2002:aa7:cdc2:0:b0:43a:7255:5274 with SMTP id h2-20020aa7cdc2000000b0043a72555274mr1851055edw.159.1656958873537;
        Mon, 04 Jul 2022 11:21:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id pv1-20020a170907208100b00726abf9cd8esm10137393ejb.125.2022.07.04.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:21:13 -0700 (PDT)
Date:   Mon, 4 Jul 2022 20:21:08 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: vt6655: Convert macro
 vt6655_mac_read_ether_addr to function
Message-ID: <2e2524187d9d3a6140fe4a5a35926db14dddfe98.1656835310.git.philipp.g.hortmann@gmail.com>
References: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro vt6655_mac_read_ether_addr to static function.
checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 025a53b493d3..298963cbca1d 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -123,6 +123,7 @@ static void device_free_info(struct vnt_private *priv);
 static void device_print_info(struct vnt_private *priv);
 
 static void vt6655_mac_write_bssid_addr(void __iomem *iobase, const u8 *mac_addr);
+static void vt6655_mac_read_ether_addr(void __iomem *iobase, u8 *mac_addr);
 
 static int device_init_rd0_ring(struct vnt_private *priv);
 static int device_init_rd1_ring(struct vnt_private *priv);
@@ -200,17 +201,17 @@ static void vt6655_mac_write_bssid_addr(void __iomem *iobase, const u8 *mac_addr
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
 }
 
-#define vt6655_mac_read_ether_addr(iobase, mac_addr)		\
-do {								\
-	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
-	mac_addr[0] = ioread8(iobase + MAC_REG_PAR0);		\
-	mac_addr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);	\
-	mac_addr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);	\
-	mac_addr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);	\
-	mac_addr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);	\
-	mac_addr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);	\
-	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
-} while (0)
+static void vt6655_mac_read_ether_addr(void __iomem *iobase, u8 *mac_addr)
+{
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
+	mac_addr[0] = ioread8(iobase + MAC_REG_PAR0);
+	mac_addr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);
+	mac_addr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);
+	mac_addr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);
+	mac_addr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);
+	mac_addr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
+}
 
 /*
  * Initialisation of MAC & BBP registers
-- 
2.36.1

