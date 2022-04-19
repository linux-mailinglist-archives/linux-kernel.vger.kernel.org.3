Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33B8507937
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357398AbiDSSjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357619AbiDSShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA3F3FDA1;
        Tue, 19 Apr 2022 11:30:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k23so34681475ejd.3;
        Tue, 19 Apr 2022 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97fWddKSGmLrVBKXP8D65MNLbFu69dXpLbEp8OeL0JY=;
        b=l4gaGxR7QY976pTLr51DV5OFFvZ4SvJxGNErfabGm/GnDcsHJDY/Gdk/2Z0EkzaQLq
         s7p0x+toR+dVXKzTOT/KpgKoBkUKU27RVLblkE0A9OXiqrtVu8G31A8/n9v6B8Sfk25u
         3EsqcW67ipUUI1wd6PXhpolMX3CkD8cPku7CLVV38euJBrhPIwjvYyAI9OejewDE4cpd
         tWMS6Me9ASCDuQsGmBcUOXqQbHO8qHPX4lQcfZXWX0HPMrGjnsZTbNGb2V3XvSW0OUiU
         F9IKzakhpNdtaDKBg775xKB9RG9zVpPWnPIbruH8DyRNCQi4n2u1CEC9w7V9BciV+QFj
         e3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97fWddKSGmLrVBKXP8D65MNLbFu69dXpLbEp8OeL0JY=;
        b=RKEh80dVSxUvueiQ/YKrqRbLs1iDoVCS4VTGjv+h0wN31ExfEVlYHSkPVVeUz2yqzn
         7ky82ua94FNQY8ybiP8Q+Yfyqr7OsWUlwwJUFWioyINvX3uTYDI7TmBklEmuNjTa5m3I
         ElN44T0biBYj3IiW//53fHjnPkdVhYIb5DcSoqpGyXtum9MbIHuPldT2tx5e3BA+0vQs
         UlJJFtYFryrvjhZARP3raphyS9A3WXa5ISchTjRqnU7wPx2ax9TlpVf6cikDqc82ZmU6
         P25J14wMBH1v7onCLzNMdYyp1yPApZrSJKIdniCiygbVnr30jtM8WHKCkJ5SHR4Hj2Hp
         H3TA==
X-Gm-Message-State: AOAM530QraoSAQaHqXAi7ZzdUuB6chxwRGYTIwGLl8+thEICt0J69d8p
        9QjfKs/bqlkH3lfFbJHU6Uc=
X-Google-Smtp-Source: ABdhPJy40m5Mj+RdiYvb/wXuHzxxId5OkZmRF/y55+fiCI2YZOOZ0XAkb8ztMvmaAqyjR4wELyXmFA==
X-Received: by 2002:a17:907:3da5:b0:6e8:c2c8:1f18 with SMTP id he37-20020a1709073da500b006e8c2c81f18mr14463438ejc.728.1650393055646;
        Tue, 19 Apr 2022 11:30:55 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm8799915edb.23.2022.04.19.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:30:55 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        powen.kao@mediatek.com, peter.wang@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] scsi: ufshpb: Remove 0 assignment for enum value
Date:   Tue, 19 Apr 2022 20:30:41 +0200
Message-Id: <20220419183044.789065-3-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419183044.789065-1-huobean@gmail.com>
References: <20220419183044.789065-1-huobean@gmail.com>
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

From: Bean Huo <beanhuo@micron.com>

If the first enumerator has no initializer, the value of the corresponding
constant is zero.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshpb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
index 2825ec69a6a6..b7e2817d4e76 100644
--- a/drivers/scsi/ufs/ufshpb.h
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -59,8 +59,8 @@ enum UFSHPB_MODE {
 };
 
 enum UFSHPB_STATE {
-	HPB_INIT = 0,
-	HPB_PRESENT = 1,
+	HPB_INIT,
+	HPB_PRESENT,
 	HPB_SUSPEND,
 	HPB_FAILED,
 	HPB_RESET,
-- 
2.34.1

