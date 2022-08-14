Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCEF5925DA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbiHNRug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHNRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:50:34 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74C1C923;
        Sun, 14 Aug 2022 10:50:33 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n133so6630153oib.0;
        Sun, 14 Aug 2022 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=knj+8z4UTU4OZaEAZ8wqsUOuV/Nu60xNyiNJljXS19Q=;
        b=QHsxPE57quzg5BAU+EIYqrOCV22xtAzg9GALEKqEOwhtkF3jZKMel3HyWqwkv5vNfd
         trrHS0dcVJKUs9A+Ng0uQd1JQwp1s4c9Ghy2s4hpkl5+R11bK/qWbihJ08yA0Rca8q0u
         wn+pXwVEK49cNtR4/0x2lqAaBRjOqyoKS2YET+/0tuevpwYpa9euaMmJfENeVUTRA0qv
         vQpAGRBfHFHk8MCk6zuCABSAsFlK0qJdYcFIQkY0SF8y8srcf7N7QL9iXqNAfh9Xj1eO
         fOpGhdsZcOZv+VFTWAmHiyb/KsOmQ6cBefBk5h2YLPzoHFAq0Far4ayxUQAtCFAcLP5F
         7Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=knj+8z4UTU4OZaEAZ8wqsUOuV/Nu60xNyiNJljXS19Q=;
        b=R7nezJ/2tkymsJAdXcCkbOVqNussnNwk3HqdpiOfNZR+o4DZLt416RBT6RTLuuX5UE
         KHPAxs8aCfV6J0LdGb3k8xvjUxvA9ftry8hxMj5NoGXHJiZq5SpDvSOJ3bPC53iGCycK
         6+7P0DyCRZ8K8JMsjcL0tRlr5pEgH0eHRL+U4nq3HPztSW03lCYiAOngB1f/kEl9ZINK
         myj++wmqXgg/uEOkrkNRTarDk/zJVUBbxqK944utX1sGP3ny+grboyMkWODBqP5YUy2h
         Bez027elv+4Rc7uMOtBiPXJ01IY3PjFEvA2IKeXq/2HkX0OO9OrGBliQju3zpBrrGM+C
         Jn0w==
X-Gm-Message-State: ACgBeo3KaDtnWT3frjZWIl0TexqScFJ3S0KB5LFB70ooBUs+PfXii7cu
        29TwXnK6Laz34+dNfd/1LBQWJHrnJmc=
X-Google-Smtp-Source: AA6agR5RnSps4UtO1s0bbx9x06cJYKqMO6GiHSZzgzKSgb9LxS6C2z32RZ2oZvy0oGO49dtDAYI7Eg==
X-Received: by 2002:a54:4496:0:b0:343:2d07:fe01 with SMTP id v22-20020a544496000000b003432d07fe01mr8765781oiv.226.1660499432764;
        Sun, 14 Aug 2022 10:50:32 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id t14-20020a056870638e00b0010e5a5dfcb4sm995874oap.0.2022.08.14.10.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 10:50:32 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/2] staging: r8188eu: Add Rosewill USB-N150 Nano to device tables
Date:   Sun, 14 Aug 2022 12:50:27 -0500
Message-Id: <20220814175027.2689-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is reported as using the RTL8188EUS chip.

It has the improbable USB ID of 0bda:ffef, which normally would belong
to Realtek, but this ID works for the reporter.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index cc2b44f60c46..9147d176da4f 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -28,6 +28,7 @@ static struct usb_device_id rtw_usb_id_tbl[] = {
 	/*=== Realtek demoboard ===*/
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0x8179)}, /* 8188EUS */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0x0179)}, /* 8188ETV */
+	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill USB-N150 Nano */
 	/*=== Customer ID ===*/
 	/****** 8188EUS ********/
 	{USB_DEVICE(0x07B8, 0x8179)}, /* Abocom - Abocom */
-- 
2.37.1

