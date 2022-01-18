Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F26492EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348900AbiARTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiARTrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:47:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E5C061574;
        Tue, 18 Jan 2022 11:47:53 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id a21so310311qkn.0;
        Tue, 18 Jan 2022 11:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=usUQb6w2J4wKH97NV+PGl45llGxPhXDgSjoJ74JvJ7k=;
        b=ZoTHACHjbwqTQt5gA/6zuq40mQExhammSJUIXqx//zC/JFgIk8chYhTQOESqKRNFV2
         cL9jAlTROF+kqbwlrjX7GchtBAHb1tFLX/pptIi1vWegGSaf5JsunWjPQsIZh5YXgzpq
         +1vNbBCTkdMw7AeufiTpLJZm8Tmeit/jJnl1m7PkqLodIUvyYxaOZa4Itdk5Zx7DjCWt
         wU6LYYEMRZSamd7Veg8kHAq+++5pXnzFJzaeW+AzuTLik5wPuOsCt0d23MQWs+lx64zO
         X5yMeFaXcgLUiI0dBBG2GxwYvMvi/YHZUU0eNtbk6HlBSvZB2806NTtGV36EVbkrynv8
         S10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=usUQb6w2J4wKH97NV+PGl45llGxPhXDgSjoJ74JvJ7k=;
        b=7q0m4ABbRMlOVAKhsfGuvqYxxu/PREg6g52+3xdhHyvWani42zmymeFCbVpsmUFhYx
         /iRMKmBN1xK1RhJoUG4lkSoVHwzoYzEF6UCCXk7ukSXqvkpTdR/ZQH1tO4HaYDW7lvqR
         GcAuD9foOiyvRLMw+rYhy1hDmnI2ax0ljwo7WKGFElttcFBFFIsQyfEZMimEGQlYZkFw
         13viiapQrK5jTy75LlGabDU3BlWkOYpf8Vcyw4SLt2tR+7h98nkk8F5FKNLDtzufKVre
         5D7XpkmSa8aoWeuiRxAlQtzzx521j6KYwtd4tYwoT5CBjrhS9HrW0leXB/JQ5wZjlrqR
         bgSQ==
X-Gm-Message-State: AOAM532SnBAHvpwhWzQzFaN3EOiF5zGXhLmIxVaMIME4oLKrABSEPaS4
        3j0ImgI8RA7UbDb7sFjNmwA=
X-Google-Smtp-Source: ABdhPJynpk4Q1bAmy/p/QWrvMHnsNw6jEv1JsjAaFKorbzPqnUk/uUC4CoAYXfSW+5q5JL0i6Uwuaw==
X-Received: by 2002:a37:8d84:: with SMTP id p126mr18801768qkd.684.1642535272443;
        Tue, 18 Jan 2022 11:47:52 -0800 (PST)
Received: from JSServ.amd.com ([165.204.78.2])
        by smtp.googlemail.com with ESMTPSA id d11sm11458287qkn.96.2022.01.18.11.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:47:51 -0800 (PST)
From:   julian schroeder <julianmarcusschroeder@gmail.com>
To:     robh@kernel.org
Cc:     bhanumaiya@google.com,
        julian schroeder <julianmarcusschroeder@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix serdev bind/unbind
Date:   Tue, 18 Jan 2022 13:48:57 -0600
Message-Id: <20220118194857.26546-1-julianmarcusschroeder@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some chromebooks, the serdev is used to communicate with
an embedded controller. When the controller is updated, the
regular ttyS* is needed. Therefore unbind/bind needs to work
to be able to switch between the two modes without having to
reboot. In the case of ACPI enabled platforms, the underlying
serial device is marked as enumerated but this is not cleared
upon remove (unbind). In this state it can not be bound as
serdev.

Signed-off-by: julian schroeder <julianmarcusschroeder@gmail.com>
---
 drivers/tty/serdev/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 92e3433276f8..668fa570bc07 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -138,7 +138,11 @@ EXPORT_SYMBOL_GPL(serdev_device_add);
 void serdev_device_remove(struct serdev_device *serdev)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
+	struct acpi_device *adev;
 
+	adev = ACPI_COMPANION(&serdev->dev);
+	if (adev)
+		acpi_device_clear_enumerated(adev);
 	device_unregister(&serdev->dev);
 	ctrl->serdev = NULL;
 }
-- 
2.20.1

