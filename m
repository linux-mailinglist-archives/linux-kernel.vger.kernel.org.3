Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA394C57AE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiBZSnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiBZSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:37 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46F27EC2C;
        Sat, 26 Feb 2022 10:42:01 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d3so9322367qvb.5;
        Sat, 26 Feb 2022 10:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ART3VPTUZNh7t0v6KbRBSIgrQKQirMcxNBZ8VtKI13E=;
        b=BGwaxaoC37S+fVgxW1fQDl1kfafaT1IfFXgMmkQOSrfm+P5E4Aw+KzcmD4DoRix+Lv
         g4rtOlPzErqWh6/sfSjAlu+CGJKXoSjRFtkGguLtvvgH8OtWmJTeIbG8c+mB4lAw8A34
         Cwye2+un5+voVjugHoUsrQx7C2cVZ4tsOw/mal87+xmnVOMvJ2vkgq13lrOmvLLWIbdN
         nlcTEywk3No8rmA5fIsL9IWVwwieIBVgpgSJueinzwrttSTmF1FRTYnzvYwOqmf3Xjn2
         VESivSb9U23X2XKlD7pWJ2U36xGRvOPOhHOyqVplYrJeTtIzcTKOi2SXCUGUKHP0mgi8
         g7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ART3VPTUZNh7t0v6KbRBSIgrQKQirMcxNBZ8VtKI13E=;
        b=GXxlsSN4HoVMeWyddHBmJ7GR+H/G3jtxGe8JaqIeMzUqJePrtISvaHn71g1SRcJA0E
         9nDfIYq/2LOQICpEZuZc8ENIuPosd8VjHP8v/rV+Ve+kQa9QSXbiNrDMoPQXc068LWUG
         xldmCCji/kxNHD8FBPj1OKdFK9dnZahxlIAOfAtMbC1oPLt4IlC64EveLq4z2W74H/1L
         kDds6RzzmwzaAf+Y6wTuDVobnDP6DQHvWlSZvOcpzFk0X5jG2Sdt1GgJg3YHPyP4LnJb
         h9E2i3BXn6WYksn28Pw45NOMwtTAB4jZJW2YWgmEcuYP7C+m+MnQ7PsaGAqvCIImxSgR
         /QXQ==
X-Gm-Message-State: AOAM533iJiuSwW1TTU/nhoPOYDkrzNDY8L88h2br07shHKH1/kmXM1W9
        PIsl9uKZRNiDV6Xb9BWF+jk=
X-Google-Smtp-Source: ABdhPJwZgSr/DyiHHH2vovnnZ7PAQIm+AH/LuKDHWznqObTdKXELfVozhERENSQ3MPhwqjlSTLtI9g==
X-Received: by 2002:ad4:5ba8:0:b0:42c:1046:419e with SMTP id 8-20020ad45ba8000000b0042c1046419emr9768577qvq.119.1645900920340;
        Sat, 26 Feb 2022 10:42:00 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:42:00 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, Peter Geis <pgwipeout@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] usb: dwc3: reorder dwc-of-simple compatibles
Date:   Sat, 26 Feb 2022 13:41:42 -0500
Message-Id: <20220226184147.769964-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226184147.769964-1-pgwipeout@gmail.com>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
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

