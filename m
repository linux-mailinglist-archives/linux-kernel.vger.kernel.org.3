Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1328857371A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiGMNRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiGMNRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:17:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CD6CCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:17:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a8-20020a25a188000000b0066839c45fe8so8389181ybi.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oLyFYnPfeBbsdMI1D5MiIAVqtfxKriA/JoWUyBDItRs=;
        b=kkqCkR0t9of0kYRQg0ELnWvmpY0fNOO85FmPcSftGFP8Uwnkd7hIbc7SW9eMhC5Vr7
         lvd7zmUfCBdNduVlDdPse9oPwBPyYPpnpsVM1R7KKskAWNOpO0ZB6mce/Pod2pznbXfO
         rBQgCe3KNFNGYWQaBCYkQfR1KIYGvCjoZxPX3fuAMbufXmmTLvQ6TiGxWAdSCrtcztll
         VlaUCqcBOvQpclZ51bfiLUGOHb7UVUYZTk0LwQJwbLwLUjuT90QwqeUI61KZdSr4/fZ5
         /aT5ZTOvTFFDZ87q9NlopOAXbXz7pU4zCTTVf6UyeR+RK3VO/lAo7UUWxq75UMVKfWj2
         XGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oLyFYnPfeBbsdMI1D5MiIAVqtfxKriA/JoWUyBDItRs=;
        b=iVptbt20TT9KtuTqLTisoBSDqWUia/V0PdYjINpefrhX7qUoiBrX+qnm7t4KP4Gv04
         uaMYUdNPoiGzTvDMMEPH3w91qfpte2RlQ2pxPZuVZnpXx3RstLsT0qx4qOOJdGxrOtkF
         8jNbjIZPzAcIzQFoUn2CmPG8afvdGzPotdeErJCs6vWFCSoRb7t7qNupNDZvHBc4N37A
         hPyfpCDAlLjZ+2KBx6cRHjpw+WNluW1UGPDjhKywHWnsGa0IKSM51zpdIFXoVwePo3I7
         u0Flfgrs3adDsZyRZqnRqJnvX/k90BVfJm5EGpysVSTwJGSoLgtvSB7fSFEJVRfiUSPJ
         PAfg==
X-Gm-Message-State: AJIora8QKsAwi5p7K2dg5KGjTRERJdt3ZYwYRSqAjd3MRHD6gk6Q9igu
        YLHpJTkT6FAvbjj3jSHZzHEsNuoAM56oc4IbrgBY
X-Google-Smtp-Source: AGRyM1tgv/1Rheq4mRhYYatWPvmwK+InGksaBZw6vbnKXvQjSNZAS2qj5vxLQtmRqv9i73lD4UbbloOQSq7bc3g9ROvW
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:101:0:b0:314:5477:aae0 with SMTP
 id 1-20020a810101000000b003145477aae0mr4092131ywb.253.1657718248786; Wed, 13
 Jul 2022 06:17:28 -0700 (PDT)
Date:   Wed, 13 Jul 2022 18:47:22 +0530
Message-Id: <20220713131722.2316829-1-vamshigajjela@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH v3] serial: 8250_dw: Avoid pslverr on reading empty receiver fifo
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

With PSLVERR_RESP_EN parameter set to 1, the device generates an error
response when an attempt to read an empty RBR with FIFO enabled.

This happens when LCR writes are ignored when UART is busy.
dw8250_check_lcr() in retries to update LCR, invokes dw8250_force_idle()
to clear and reset FIFO and eventually reads UART_RX causing the error.

Avoid this by not reading RBR/UART_RX when no data is available.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v3:
- check lsr based on FIFO enablement
v2:
- update as per review comments (re-format comments, xmas tree ordering)
 drivers/tty/serial/8250/8250_dw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..7573904579f6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -82,8 +82,21 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 static void dw8250_force_idle(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
+	unsigned int lsr;
 
 	serial8250_clear_and_reinit_fifos(up);
+
+	/*
+	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
+	 * error response when an attempt to read an empty RBR with FIFO
+	 * enabled.
+	 */
+	if (up->fcr & UART_FCR_ENABLE_FIFO) {
+		lsr = p->serial_in(p, UART_LSR);
+		if (!(lsr & UART_LSR_DR))
+			return;
+	}
+
 	(void)p->serial_in(p, UART_RX);
 }
 
-- 
2.37.0.144.g8ac04bfd2-goog

