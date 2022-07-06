Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF2569281
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiGFTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiGFTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:19:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA624F29
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:19:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y8so14735696eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pJs6YpPMXJBKMv5cs8ZYrf6cf8wF5M5B8N8jxRJcpPg=;
        b=dPtR0T2CMTa9s7441XqtntYU0TcOhB+ctD8fbFxmFil8ZaBkkURe6NKC8Om4h6NqPq
         YtN/8WONvvOWiIlQ61wamEAeoMTH9GLZlQIQCn6YP+K9Ry7YDe+6bvci1n770G34y3P2
         YRKdY2i0UzHlRx+u7g1kji625wkXo0zCpLY/2sykDBwshgytyCZS/0WU4f1PAljWUuEt
         yx7MPHDJcJHY3PdCdawLNubW0GsziUq9UWXxtbSK+k6lhlCHwmGigDI1zbq9s1kWDwgI
         9u/eFe6j8b7s8JUEwCPdClHidOZ8oD9nWrTBW5q7o+zQcINqUp+Zmg4CiituAVn4pgww
         rUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJs6YpPMXJBKMv5cs8ZYrf6cf8wF5M5B8N8jxRJcpPg=;
        b=b1yISXPLSOrELsn5JtFdyufNwUIaM0EyMgrd4AgRcVnnPiwPcJFgtwnB21L6Z5WCv4
         Mz+Q75/KQHtlOHCO5mYZ6DPrIRXjrKAVbq6u7Z0XdaSB5d2qyhuu3A07Ebh3e0aE41vZ
         Tn51UGzbZImb2Y0OUCCDo/2sZ5V7BZlReqQOJlPATi2jzJ4TXuV5mxAIvWGLVGsuCSGI
         jxywKAOzVu7Ylye/u9qwdRxP/YUE0e6obICrWP6qxctcD/OQupEnVr0MaQ7SJ/rMqz1/
         ZJV78P+LQw06wzSqw8vfOiUA612h3ElnwKqeJB8Cfqw9OPaeRgtBCQ9Fi2w4IjhmlP1X
         hikA==
X-Gm-Message-State: AJIora/rQC1NmpRjZI6IKw8nlNrlTdsQyDvx9/cYZ4Oa/1tuA+MM1/C/
        wZvS7yhoRVCf/70gjJaktOXVHe8r/QU=
X-Google-Smtp-Source: AGRyM1tZi1MWEz9TiMijACO9+VcDGJ5yuTRBsJsWHs1CYRMQNrNePMZRKej5VKvd45iNWVQ6EGkcYA==
X-Received: by 2002:a05:6402:1658:b0:43a:91cd:2ffb with SMTP id s24-20020a056402165800b0043a91cd2ffbmr2824351edx.277.1657135143483;
        Wed, 06 Jul 2022 12:19:03 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b00722e52d043dsm17731397ejf.114.2022.07.06.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:19:03 -0700 (PDT)
Date:   Wed, 6 Jul 2022 21:19:01 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: vt6655: Use loop in vt6655_mac_write_bssid_addr
Message-ID: <b3b93ae7ce41562565e9007eb4580b9c47a2881f.1657134099.git.philipp.g.hortmann@gmail.com>
References: <cover.1657134099.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657134099.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use loop in vt6655_mac_write_bssid_addr to avoid multiple
similar statements.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Code for testing:
for (int i = 0; i < 6; i++){
	iowrite8(mac_addr[i], iobase + MAC_REG_BSSID0 + i);
	printk("i = %i\n", i);
}

Log:
[ 2592.189081] i = 0
[ 2592.189083] i = 1
[ 2592.189083] i = 2
[ 2592.189084] i = 3
[ 2592.189084] i = 4
[ 2592.189085] i = 5
---
 drivers/staging/vt6655/device_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 298963cbca1d..099f0b95417a 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -192,12 +192,8 @@ device_set_options(struct vnt_private *priv)
 static void vt6655_mac_write_bssid_addr(void __iomem *iobase, const u8 *mac_addr)
 {
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
-	iowrite8(mac_addr[0], iobase + MAC_REG_BSSID0);
-	iowrite8(mac_addr[1], iobase + MAC_REG_BSSID0 + 1);
-	iowrite8(mac_addr[2], iobase + MAC_REG_BSSID0 + 2);
-	iowrite8(mac_addr[3], iobase + MAC_REG_BSSID0 + 3);
-	iowrite8(mac_addr[4], iobase + MAC_REG_BSSID0 + 4);
-	iowrite8(mac_addr[5], iobase + MAC_REG_BSSID0 + 5);
+	for (int i = 0; i < 6; i++)
+		iowrite8(mac_addr[i], iobase + MAC_REG_BSSID0 + i);
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
 }
 
-- 
2.37.0

