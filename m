Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73D54C47F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiBYOzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiBYOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:13 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8C7225592;
        Fri, 25 Feb 2022 06:54:41 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id n185so4660080qke.5;
        Fri, 25 Feb 2022 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ART3VPTUZNh7t0v6KbRBSIgrQKQirMcxNBZ8VtKI13E=;
        b=JN4l4vqHFQn2xmpeWdDL8cBi2bcL/CO0OBjadfrloabBkBoq2Lrr5WiXGj1bkOq05b
         Q1rnwO+kcyDVeZB4Mrnfr/EH8tGTniLwBV67ca8rRS3c3IShRYML6alXCScbBjRDCSHc
         uYKLRdqCbmlkgRR9QXb2C+qqRCfVfs2r0AyvFPgMfatm6cUYtkllJOjaVSZsV0LELxv6
         eIioSjVYeSq/kcmfxqO/YzfJh1tbtoThTcQA5pnJwIF83Znup0B/loRA145U0ex5TQSH
         U8V4wHzkgjmPC21g+fCn7ep/zkeyAoqsrqFd4oSXwvPZ95YgRf9ZHfZcHkdan1Jy5YeJ
         layw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ART3VPTUZNh7t0v6KbRBSIgrQKQirMcxNBZ8VtKI13E=;
        b=qGpD1hoP61htaforXeJsya2uezzhsLpG9T1pznyLESbb/BJKTjtsLJPAuP/Akr2T5g
         XMuiAj3a1sxk/1XTbwMJFbjcFC3qUjtfMQrzYxjeHM5qOJNcWoSSVPKL4tTkIVq9Qlfs
         AW7BiFJzvw5GYyyqgayRH/GIxbbuMggpBkiniO4mXzf+nEc5DvtcpAVL7Ztg6CsPBb1c
         SnRxXD8h657ndeErPQGNHYoP33FVpjxadtJgm+IgaVnvNVZJS5MNnqoBr5J2NBeBgDme
         x1EV36ekieG1oEXetPAKC6SB2zGiBVSnDpg2RN/b/PhL3FkemKdl2wLiUxFHgiVocx3X
         IHRA==
X-Gm-Message-State: AOAM533T17PfBew4cNqrdY2aSkmOKHfwOJ8gqx8TfiNDLh3mVvmeBMyE
        BX5QJvmASkcy5VcIEFQExQg=
X-Google-Smtp-Source: ABdhPJwNUKZeDezV9CEn8o8sUWC3HeQsS+FCZoNvXDfs5k9n5B5Xs8ZeYSVCKDv9LFgDmilOTwuEzg==
X-Received: by 2002:a37:a795:0:b0:475:ce3f:ac76 with SMTP id q143-20020a37a795000000b00475ce3fac76mr5014946qke.193.1645800880760;
        Fri, 25 Feb 2022 06:54:40 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm1318292qkc.73.2022.02.25.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:54:40 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/8] usb: dwc3: reorder dwc-of-simple compatibles
Date:   Fri, 25 Feb 2022 09:54:28 -0500
Message-Id: <20220225145432.422130-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225145432.422130-1-pgwipeout@gmail.com>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
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

The dwc3-of-simple driver is getting rather disorganized with the new
inclusions.
Reorder the dwc3-of-simple compatibles to be alphabetical.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 71fd620c5161..9dc6295df6b1 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -171,12 +171,12 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 };
 
 static const struct of_device_id of_dwc3_simple_match[] = {
-	{ .compatible = "rockchip,rk3399-dwc3" },
-	{ .compatible = "cavium,octeon-7130-usb-uctl" },
-	{ .compatible = "sprd,sc9860-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
+	{ .compatible = "cavium,octeon-7130-usb-uctl" },
 	{ .compatible = "hisilicon,hi3670-dwc3" },
 	{ .compatible = "intel,keembay-dwc3" },
+	{ .compatible = "rockchip,rk3399-dwc3" },
+	{ .compatible = "sprd,sc9860-dwc3" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);
-- 
2.25.1

